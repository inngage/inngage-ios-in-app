import SwiftUI

public struct InAppView: View {
    @Binding var isShowing: Bool
    
    var data: [String: Any]?
    var actionButtonRight: () -> Void = {}
    var hasActionButtonRight: Bool = false
    var actionButtonLeft: () -> Void = {}
    var hasActionButtonLeft: Bool = false
    
    @State private var carousel: Int = 0
    @State private var backgroundImage: String = ""
        
    public init(
        data: [String: Any],
        isShowing: Binding<Bool>,
        actionButtonRight: @escaping () -> Void = {},
        hasActionButtonRight: Bool = false,
        actionButtonLeft: @escaping () -> Void = {},
        hasActionButtonLeft: Bool = false) {
            self.data = data
            self.actionButtonRight = actionButtonRight
            self.actionButtonLeft = actionButtonLeft
            self.hasActionButtonLeft = hasActionButtonLeft
            self.hasActionButtonRight = hasActionButtonRight
            
            if let aps = data["aps"] as? [String: Any],
               let inapp = aps["inapp"] as? [String: Any],
               let richContent = inapp["rich_content"] as? [String: Any] {
                self._backgroundImage = State(initialValue: inapp["background_image"] as? String ?? "")
                self._carousel = State(initialValue: richContent["carousel"] as? Int ?? 0)
            }
            
            self._isShowing = isShowing
    }
    
    public var body: some View {
        if isShowing {
            if carousel == 1 {
                InAppRichContent(
                    data: data ?? ["": ""],
                    isActive: $isShowing,
                    actionButtonLeft: actionButtonLeft,
                    hasActionButtonLeft: hasActionButtonLeft,
                    actionButtonRight: actionButtonRight,
                    hasActionButtonRight: hasActionButtonRight)
            } else if(!backgroundImage.isEmpty && carousel == 0){
                InAppBackgroundImage(
                    data: data ?? ["": ""],
                    isActive: $isShowing,
                    actionButtonLeft: actionButtonLeft,
                    actionButtonRight: actionButtonRight)
            } else {
                InAppNormal(
                    data: data ?? ["": ""],
                    isActive: $isShowing)
            }
        }
    }
    
    private func handleDeepLink(){
        print("Está utilizando deep link")
    }
}

//#Preview {
//    InAppView()
//}
