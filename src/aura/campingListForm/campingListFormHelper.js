({
    createItem: function(component, newItem) {
        var createItem = component.getEvent("addItem");
        createItem.setParams({ "item": newItem });
        createItem.fire();
        component.set("v.newItem",{ 'sobjectType': 'Camping_Item__c',
                                   'Name': '',
                                   'Quantity__c': 0,
                                   'Price__c': 0,
                                   'Packed__c': false });
    },
	validateItemForm: function(component) {

        // Simplistic error checking
        var validItem = true;
    
        // Name must not be blank
        var nameField = component.find("itmname");
        var itmname = nameField.get("v.value");
        if ($A.util.isEmpty(itmname)){
            validItem = false;
            nameField.set("v.errors", [{message:"Item name can't be blank."}]);
        }
        else {
            nameField.set("v.errors", null);
        }
    
        // Quantity must be set, must be a positive number
        var quantityField = component.find("quantity");
        var quantity = quantityField.get("v.value");
        if ($A.util.isEmpty(quantity) || isNaN(quantity) || (quantity <= 0.0)){
            validItem = false;
            quantityField.set("v.errors", [{message:"Enter a quantity."}]);
        }
        else {
            // If the amount looks good, unset any errors...
            quantityField.set("v.errors", null);
        }
        
        // Price must be set, must be a positive number
        var priceField = component.find("price");
        var price = priceField.get("v.value");
        if ($A.util.isEmpty(price) || isNaN(price) || (price <= 0.0)){
            validItem = false;
            priceField.set("v.errors", [{message:"Enter a price."}]);
        }
        else {
            // If the amount looks good, unset any errors...
            priceField.set("v.errors", null);
        }
        
        return(validItem);
    }
})