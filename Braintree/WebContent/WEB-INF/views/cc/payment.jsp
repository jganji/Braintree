<%@ include file="/header.jsp"%>
<%@ include file="/index.jsp"%>
<%@ page import="com.lss.tbg.service.BraintreePaymentService" %>
<%
BraintreePaymentService service = new BraintreePaymentService();
String clientToken=service.getClientToken().toString();
%>
<script src="https://js.braintreegateway.com/v2/braintree.js"></script>
<script type="text/javascript">
braintree.setup("<%=clientToken%>","paypal", {id: "checkout",container: "paypal-container",
	  onPaymentMethodReceived: function (obj) {
		  console.log(obj.nonce);
		    doSomethingWithTheNonce(obj.nonce);}
});
</script>
<form id="checkout" action="<%=request.getContextPath()%>/save" method="post">
<div id="paypal-container" ></div>
  <input data-braintree-name="number" value=" "/>
  <input data-braintree-name="cvv" value=" "/>
  <!-- you can also split expiration date into two fields -->
  <input data-braintree-name="expiration_month" value=" "/>
  <input data-braintree-name="expiration_year" value=" "/>
  <input data-braintree-name="postal_code" value=" "/>
  <input data-braintree-name="cardholder_name" value=" "/>
  <input type="submit" id="submit" value="Pay">
</form>
<%@ include file="/footer.jsp"%>