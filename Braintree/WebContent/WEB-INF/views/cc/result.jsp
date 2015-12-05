<%@ include file="/header.jsp"%>
<%@ include file="/index.jsp"%>
<%@ page import="com.lss.tbg.service.BraintreePaymentService" %>
<%
BraintreePaymentService service = new BraintreePaymentService();
String clientToken=service.getClientToken().toString();

%>
<script src="https://js.braintreegateway.com/v2/braintree.js"></script>
<script type="text/javascript">
braintree.setup("<%=clientToken%>","custom", {id: "checkout"});
</script>
<form id="checkout" action="/save" method="post">
 
</form>
<%@ include file="/footer.jsp"%>