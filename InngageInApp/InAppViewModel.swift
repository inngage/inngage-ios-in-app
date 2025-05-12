//
//  InAppViewModel.swift
//  InngageInApp
//
//  Created by Saulo Moura on 18/07/24.
//

import Foundation
import UIKit

final class InAppViewModel: ObservableObject{
    @Published var resultMessage: String = ""
    
    let device = UIDevice.current
    let locale = NSLocale.current
    
    private let api = ApiManager()
    
    func inngageSubscribe(
        appToken: String?,
        identifier: String?,
        registration: String?,
        email: String?,
        phoneNumber: Int?) {
            if #available(iOS 16, *) {
                let subscribe = Subscribe(
                    app_token: appToken ?? "",
                    identifier: identifier ?? "",
                    registration: registration ?? "",
                    platform: device.systemName,
                    sdk: "1.0.0",
                    device_model: device.name, 
                    device_manufacturer: device.model,
                    os_locale: locale.language.languageCode?.identifier ?? "",
                    os_language: locale.language.languageCode?.identifier ?? "",
                    os_version: device.systemVersion,
                    app_version: "1.0.0",
                    app_installed_in: "2024-07-31T09:52:30.433905",
                    app_updated_in: "2024-07-31T09:52:30.433905",
                    uuid: device.identifierForVendor?.uuidString ?? "",
                    custom_field: CustomField(empresa: "Inngage", nome: "Saulo"),
                    phone_number: phoneNumber ?? 0,
                    email: email ?? "")
                
                api.sendSubscriptionRequest(subscribe: subscribe)
            } else {
                let subscribe = Subscribe(
                    app_token: appToken ?? "",
                    identifier: identifier ?? "",
                    registration: registration ?? "",
                    platform: device.systemName,
                    sdk: "1.0.0",
                    device_model: device.name,
                    device_manufacturer: device.model,
                    os_locale: Locale.preferredLanguages.first ?? "",
                    os_language: Locale.preferredLanguages.first ?? "",
                    os_version: device.systemVersion,
                    app_version: "1.0.0",
                    app_installed_in: "2024-07-31T09:52:30.433905",
                    app_updated_in: "2024-07-31T09:52:30.433905",
                    uuid: device.identifierForVendor?.uuidString ?? "",
                    custom_field: CustomField(empresa: "Inngage", nome: "Saulo"),
                    phone_number: phoneNumber ?? 0,
                    email: email ?? "")
                
                api.sendSubscriptionRequest(subscribe: subscribe)
            }
    }
}
