//
//  CartViewController.swift
//  ProductsShopTest
//
//  Created by Константин Евсюков on 02.07.2024.
//

import UIKit

class CartViewController: UIViewController {
    
    private let cartProductTableView = UITableView()
    private let totalTextPriceLabel = LabelType(type: .totalTextPrice)
    private let totalPriceLabel = LabelType(type: .totalPrice)
    private let container = UIView()
    
    var cartProducts: [Product] = []
    weak var productViewModel: ProductViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        bindProductViewModel()
        updateTabbarBadge()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bindProductViewModel()
        updateTabbarBadge()
    }
}

//MARK: Setup UI
private extension CartViewController {
    
    func setupUI() {
        setupNavbarItem()
        setupTableView()
        setupView()
        setupLabel()
        addSubViews()
        makeConstrants()
    }
    
    func setupNavbarItem() {
        self.navigationItem.title = "Корзина"
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        appearance.backgroundColor = .white
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.compactAppearance = appearance
    }
    
    func setupTableView() {
        cartProductTableView.separatorStyle = .none
        cartProductTableView.register(CartTableViewCell.self, forCellReuseIdentifier: CartTableViewCell.identifier)
        cartProductTableView.delegate = self
        cartProductTableView.dataSource = self
    }
    
    func setupView() {
        container.backgroundColor = .white
        container.clipsToBounds = false
    }
    
    func setupLabel() {
        totalTextPriceLabel.text = "Итого: "
    }
    
    func addSubViews() {
        [cartProductTableView, container].forEach {
            view.addSubview($0)
        }
        
        [totalTextPriceLabel, totalPriceLabel].forEach {
            container.addSubview($0)
        }
    }
    
    func makeConstrants() {
        cartProductTableView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(container.snp.top).inset(20)
        }
        
        container.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(100)
        }
        
        totalTextPriceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.left.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(15)
        }
        
        totalPriceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(15)
        }
    }
    
    func bindProductViewModel() {
        productViewModel?.cartProducts.bind { [weak self] products in
           self?.cartProducts = products ?? []
           self?.cartProductTableView.reloadData()
           self?.updateTotalPrice()
        }
    }
    
    func configureTotalPriceAction(for cell: CartTableViewCell, with product: Product) {
        cell.totalPriceAction = { [weak self] newQuantity in
            guard let strongSelf = self else { return }
            if let index = strongSelf.cartProducts.firstIndex(where: { $0.id == product.id }) {
                strongSelf.cartProducts[index].quantity = newQuantity
                strongSelf.updateTotalPrice()
            }
        }
    }
    
    func deleteProductToCart(for cell: CartTableViewCell, with product: Product) {
        cell.deleteProductAction = { [weak self] product in
            self?.removeProductFromCart(product)
        }
    }
    
    func removeProductFromCart(_ product: Product) {
        if let index = cartProducts.firstIndex(where: { $0.id == product.id }) {
            cartProducts.remove(at: index)
            cartProductTableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
            updateTotalPrice()
            updateTabbarBadge()
            productViewModel?.removeProductFromCart(product)
        }
    }
    
    func updateTotalPrice() {
        let total = cartProducts.reduce(0) { $0 + ($1.price * Double($1.quantity)) }
        totalPriceLabel.text = "\(total)P"
        updateTabbarBadge()
    }
    
    func updateTabbarBadge() {
        if let tabItems = self.tabBarController?.tabBar.items {
            let cartTabIndex = 1
            let cartItem = tabItems[cartTabIndex]
            let totalItems = cartProducts.reduce(0) { $0 + $1.quantity }
            cartItem.badgeValue = totalItems > 0 ? "\(totalItems)" : nil
        }
    }
    
    func openDetails(productId: Int) {
        guard let product = productViewModel?.retriveProduct(withId: productId) else {
            return
        }
        
        DispatchQueue.main.async {
            let detailsViewModel = DetailProductViewModel(product: product)
            let controller = DetailViewController(viewModel: detailsViewModel)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
}

//MARK: Service
extension CartViewController: Service {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.cartProductTableView.reloadData()
        }
    }
}

//MARK: UITableViewDelegate, UITableViewDataSource
extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartProducts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as? CartTableViewCell else { return UITableViewCell() }
        
        if let cartContent = cartProducts.safeObject(at: indexPath.row) {
            cell.product = cartContent
            cell.selectionStyle = .none
            
            configureTotalPriceAction(for: cell, with: cartContent)
            deleteProductToCart(for: cell, with: cartContent)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let product = cartProducts.safeObject(at: indexPath.row) else { return }
        openDetails(productId: product.id)
    }
}
