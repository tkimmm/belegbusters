// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class CatalogModel {
  static const _itemNames = [
    'Beef Burger',
    'Spaghetti',
    'Steak Sirloin',
    'Shrimp Paella',
  ];

   static const _paths = [
    'images/Burger.jpg',
    'images/Pasta.jpg',
    'images/Steak.jpg',
    'images/Paella.jpg',
  ];

  /// Get item by [id].
  ///
  /// In this sample, the catalog is infinite, looping over [_itemNames].
  Item getById(int id) => Item(id, _itemNames[id % _itemNames.length], _paths[id % _itemNames.length]);

  /// Get item by its position in the catalog.
  Item getByPosition(int position) {
    // In this simplified case, an item's position in the catalog
    // is also its id.
    return getById(position);
  }
}

@immutable
class Item {
  final int id;
  final String name;
  final Color color;
  final int price = 10;
  final String path;

  Item(this.id, this.name, this.path)
      : color = Colors.primaries[id % Colors.primaries.length];

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}