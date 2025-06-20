import Foundation

extension String {
    func removeVietnameseDiacritics() -> String {
        let vietnamese = [
            "aáàạảãăắằặẳẵâấầậẩẫ",
            "AÁÀẠẢÃĂẮẰẶẲẴÂẤẦẬẨẪ",
            "eéèẹẻẽêếềệểễ",
            "EÉÈẸẺẼÊẾỀỆỂỄ",
            "iíìịỉĩ",
            "IÍÌỊỈĨ",
            "oóòọỏõôốồộổỗơớờợởỡ",
            "OÓÒỌỎÕÔỐỒỘỔỖƠỚỜỢỞỠ",
            "uúùụủũưứừựửữ",
            "UÚÙỤỦŨƯỨỪỰỬỮ",
            "yýỳỵỷỹ",
            "YÝỲỴỶỸ",
            "đĐ",
        ]
        let latin = [
            "a", "A",
            "e", "E",
            "i", "I",
            "o", "O",
            "u", "U",
            "y", "Y",
            "dD",
        ]

        var result = self
        for i in 0..<vietnamese.count {
            let letters = vietnamese[i]
            let replacement = latin[i]
            letters.forEach { letter in
                result = result.replacingOccurrences(of: String(letter), with: replacement)
            }
        }
        return result
    }
}
