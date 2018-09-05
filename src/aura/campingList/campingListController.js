({
	   /* clickCreateItem: function(component, event, helper) {

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
    
            // ... hint: more error checking here ...
    		// Quantity must not be blank
            var nameField = component.find("quantity");
            var quantity = nameField.get("v.value");
            if ($A.util.isEmpty(quantity)){
                validItem = false;
                nameField.set("v.errors", [{message:"Quantity can't be blank."}]);
            }
            else {
                nameField.set("v.errors", null);
            }
            
            // Price must not be blank
            var nameField = component.find("price");
            var price = nameField.get("v.value");
            if ($A.util.isEmpty(price)){
                validItem = false;
                nameField.set("v.errors", [{message:"Price can't be blank."}]);
            }
            else {
                nameField.set("v.errors", null);
            }
            
            // If we pass error checking, do some real work
            if(validItem){
                // Create the new expense
                var newItem = component.get("v.newItem");
                console.log("Create item: " + JSON.stringify(newItem));
                
                var theItems = component.get("v.items");
 
                // Copy the expense to a new object
                // THIS IS A DISGUSTING, TEMPORARY HACK
                //var newItem = JSON.parse(JSON.stringify(newitem));
         
                theItems.push(newItem);
                component.set("v.items", theItems);
				component.set("v.newItem",{ 'sobjectType': 'Camping_Item__c','Name': '','Quantity__c': 0,'Price__c': 0,'Packed__c': false });
               
            }
    }, */
    handleAddItem: function(component, event, helper) {
        var newItem = event.getParam("item");
        helper.createItem(component, newItem);
        
        var action = component.get("c.saveItem");
    		action.setParams({"item": newItem});
    		action.setCallback(this, function(response){
        		var state = response.getState();
        		if (component.isValid() && state === "SUCCESS") {
          			var expenses = component.get("v.items");
                	expenses.push(response.getReturnValue());
                	component.set("v.items", expenses);
        		}
    		});
    		$A.enqueueAction(action);
    },
    
    handleUpdateItem: function(component, event, helper) {
        var updatedItem = event.getParam("item");
        helper.updateItem(component, updatedItem);
    },
    /*handleCreateExpense: function(component, event, helper) {
        var newExpense = event.getParam("expense");
        helper.createExpense(component, newExpense);
    },*/
    
    // Load expenses from Salesforce
	doInit: function(component, event, helper) {

        // Create the action
        var action = component.get("c.getItems");
    
        // Add callback behavior for when response is received
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (component.isValid() && state === "SUCCESS") {
                component.set("v.items", response.getReturnValue());
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
    
        // Send action off to be executed
        $A.enqueueAction(action);
	}
    
})