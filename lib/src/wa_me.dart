//
//  package
//  wa.me
//
//  Created by Ngonidzashe Mangudya on 26/7/2023.
//  Copyright (c) 2023 ModestNerds, Co
//

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/package.dart';

class WhatsappShare {
  static const MethodChannel _channel = MethodChannel('whatsapp_share');

  /// Checks whether whatsapp is installed in device or not
  ///
  /// [Package] is optional enum parameter which is default to
  /// [Package.whatsapp] for business whatsapp set it to
  /// [Package.businessWhatsapp], it cannot be null. Other supported ones are
  /// [Package.gbWhatsapp], [Package.fmWhatsapp], [Package.yoWhatsapp]
  /// return true if installed otherwise false.
  static Future<bool?> isInstalled({
    Package package = Package.whatsapp,
  }) async {
    final bool? success = await _channel
        .invokeMethod('isInstalled', {'package': package.packageName});
    return success;
  }

  /// Shares a message or/and link url with whatsapp.
  /// - Text: Is the [text] of the message.
  /// - LinkUrl: Is the [linkUrl] to include with the message.
  /// - Phone: is the [phone] contact number to share with.

  static Future<bool?> share({
    required String phone,
    String? text,
    String? linkUrl,
    Package package = Package.whatsapp,
  }) async {
    if (phone.isEmpty) {
      throw FlutterError('Phone cannot be null and with country code');
    }

    final bool? success = await _channel.invokeMethod('share', {
      'title': ' ',
      'text': text,
      'linkUrl': linkUrl,
      'chooserTitle': ' ',
      'phone': phone,
      'package': package.packageName,
    });

    return success;
  }

  /// Shares a local file with whatsapp.
  /// - Text: Is the [text] of the message.
  /// - FilePath: Is the List of paths which can be prefilled.
  /// - Phone: is the [phone] contact number to share with.
  static Future<bool?> shareFile({
    required List<String> filePath,
    required String phone,
    String? text,
    Package package = Package.whatsapp,
  }) async {
    if (filePath.isEmpty) {
      throw FlutterError('FilePath cannot be null');
    }

    if (phone.isEmpty) {
      throw FlutterError('Phone cannot be null and with country code');
    }

    final bool? success =
        await _channel.invokeMethod('shareFile', <String, dynamic>{
      'title': ' ',
      'text': text,
      'filePath': filePath,
      'chooserTitle': ' ',
      'phone': phone,
      'package': package.packageName,
    });

    return success;
  }
}