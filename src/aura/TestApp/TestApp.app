<aura:application extends="force:slds">
  <!-- Create attribute to store lookup value as a sObject--> 
  <aura:attribute name="selectedLookUpRecord" type="sObject" default="{}"/>
 
  <c:SelectRecord objectAPIName="lead" IconName="standard:lead" selectedRecord="{!v.selectedLookUpRecord}" label="Lead Name"/>
 <!-- here c: is org. namespace prefix-->
</aura:application>