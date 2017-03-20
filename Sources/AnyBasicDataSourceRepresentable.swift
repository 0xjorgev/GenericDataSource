//
//  AnyBasicDataSourceRepresentable.swift
//  GenericDataSource
//
//  Created by Mohamed Ebrahim Mohamed Afifi on 3/20/17.
//  Copyright © 2017 mohamede1945. All rights reserved.
//

import Foundation

private class _AnyBasicDataSourceRepresentableBoxBase<Item>: BasicDataSourceRepresentable {

    var items: [Item] {
        get { fatalError() }
        set { fatalError() }
    }

    var dataSource: AbstractDataSource { fatalError() }
}

private class _AnyBasicDataSourceRepresentableBox<DS: BasicDataSourceRepresentable>: _AnyBasicDataSourceRepresentableBoxBase<DS.Item> {

    private let ds: DS
    init(ds: DS) {
        self.ds = ds
    }

    override var items: [DS.Item] {
        get { return ds.items }
        set { ds.items = newValue }
    }

    override var dataSource: AbstractDataSource { return ds.dataSource }
}

public class AnyBasicDataSourceRepresentable<Item>: BasicDataSourceRepresentable {

    private let box: _AnyBasicDataSourceRepresentableBoxBase<Item>
    public init<DS: BasicDataSourceRepresentable>(_ ds: DS) where DS.Item == Item {
        box = _AnyBasicDataSourceRepresentableBox(ds: ds)
    }

    open var items: [Item] {
        get { return box.items }
        set { box.items = newValue }
    }

    open var dataSource: AbstractDataSource { return box.dataSource }
}

extension BasicDataSourceRepresentable {
    public func asBasicDataSourceRepresentable() -> AnyBasicDataSourceRepresentable<Item> {
        return AnyBasicDataSourceRepresentable(self)
    }
}
