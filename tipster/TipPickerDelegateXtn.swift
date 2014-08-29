//
//  TipPickerDelegateXtn.swift
//  tipster
//
//  Created by CK on 8/27/14.
//  Copyright (c) 2014 Chaitanya Kannali. All rights reserved.
//

extension TipPickerDelegateXtn: UIPickerViewDataSource {
    // two required methods

    func numberOfComponentsInPickerView(pickerView: UIPickerView!) -> Int {
        return 1
    }

    func pickerView(pickerView: UIPickerView!, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
}
