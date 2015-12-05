<%@ include file="/header.jsp"%>
<%@ include file="/index.jsp"%>
<%@ page import="com.lss.tbg.service.BraintreePaymentService" %>
<script src="https://js.braintreegateway.com/v2/braintree.js"></script>
<%
BraintreePaymentService service = new BraintreePaymentService();
String clientToken=service.getClientToken().toString();

%>
<style>
<!--
#card-number-container {
  background-repeat: no-repeat;
  background-position: right;
  background-position: right 10px center;
}
-->
</style>

<form action="/save" method="post" id="checkout">
<label for="card-number">Card Number</label>


    <div id="card-number"></div>


    <label for="cvv">CVV</label>
    <div id="cvv"></div>

    <!-- <label for="expirationMonth">expirationMonth</label>
    <div id="expiration-Month"></div>
    <label for="expirationYear">Expiration month</label>
    <div id="expiration-Year"></div> -->

    <label for="expiration-date">expiration Month and year</label>
    <div id="expiration-date"></div>


<%-- <div class="container">
	<fieldset>
	<table>
	<tr>
	<td><form:label path="ccType"> Credit Card Type &nbsp</form:label></td>
	<td colspan="2"><form:select path="ccType">
	<form:option value="0" label="Select One"/>
	<form:options items="${cardTypes}"/>
	</form:select>
	</td>
	</tr>
	<tr>
	<td><form:label path="ccName"> Name on Card &nbsp</form:label></td>
	<td colspan="2"><form:input path="ccName"/>
	</td>
	</tr>
	<tr>
	<td><form:label path="ccNumber"> Card Number &nbsp</form:label></td>
	<td colspan="2"><form:input path="number"/>
	</td>
	</tr>
	<tr>
	<td><form:label path="ccMonth"> Expiration Date &nbsp</form:label></td>
	<td><form:select path="ccMonth">
	<form:option value="0" label="  "/>
	<form:options items="${ccMonths}"/>
	</form:select>
	</td>
	<td>/&nbsp<form:select path="ccYear">
	<form:option value="0" label="  "/>
	<form:options items="${ccYears}"/>
	</form:select>
	</td>
	</tr>
	<tr>
	<td><form:label path="ccVcode"> Verification Code &nbsp</form:label></td>
	<td colspan="2"><form:input path="ccVcode"/>
	</td>
	</tr>
	<tr>
					<td colspan="3" align="center"><form:button>Save</form:button></td>
				</tr>
	</table>
	</fieldset>
</div> --%>
<table>
<tr>
					<td colspan="3" align="center"><button type="submit" value="Submit" id="hostedCheckout">Pay</button></td>
				</tr>
				</table>
</form>
<script type="text/javascript">

braintree.setup("<%=clientToken%>", "custom", {
	  displayName : "Test Hosted Fields - Sandbox Enviro",
	  id: 'checkout',
	  hostedFields: {
		  styles: {
			"input": {
			  "font-size": "12pt",
			  "color": "#3A3A3A",
			  "width":"50%",
			  "padding":"3px",
			  "margin":"3px"
			},
			".number": {
			  "font-family": "inherit"
			},
			":focus": {
			  "color": "blue"
			},
			".valid": {
			  "color": "green"
			},
			".invalid": {
			  "color": "red"
			},
			"@media screen and (max-width: 700px)": {
			  "input": {
				"font-size": "14pt"
			  }
			}
		  },
		  onFieldEvent: function (event) {
			console.log(event);
			if (event.card) {
				console.log(event.card.type);
				switch(event.card.type) {
					case  'master-card':
							//$scope.CCType = "Images/mastercard.png";
							break;
					case  'american-express':
							$scope.CCType = "Images/american_express.png";
							break;
					case  'discover':
							//$scope.CCType = "Images/discover.png";
							break;
					case  'jcb':
							//$scope.CCType = "Images/jcb.png";
							break;
					case  'visa':
							//$scope.CCType = "Images/visa.png";
							break;
					case  'diners-club':
					case  'unionpay':
					case  'maestro':
					default:
							//$scope.CCType = "Images/pixel.gif";
				}

			}
	  },
	  number: {
		selector: "#card-number"
	  },
	  cvv: {
		selector: "#cvv"
	  },
	  expirationDate: {
		selector: "#expiration-date",
		placeholder: "mm/yyyy"
	  }
	},

	  onReady : function(response) {
			console.log("in OnReady");
			//$scope.PaymentProcessing = true;
	  },
	  onPaymentMethodReceived : function(response) {
			console.log("in onPaymentMethodReceived");
			alert(response.nonce);
			console.log(response.nonce);

	  },
	  onError : function(response) {
		  console.log("in onError");
		  console.log(response);

	  }

	});

</script>

<%-- <script type="text/javascript">
alert("in asas");
braintree.setup("<%=clientToken%>", "custom", {id: "checkout",
	hostedFields : {
		onFieldEvent: function(event){
            console.log('field event triggerede', event);
          },
		styles: {
			"input": {
			  "color": "#3A3A3A"
	       	      },
	       	      ".number": {
	       	       "font-family": "monospace"
	       	    }
		},
		number : {
			selector : "#card-number",
				placeholder: '4111 1111 1111 1111'
		},
		cvv : {
			selector : "#cvv"
		},
		expirationMonth : {
			selector : "#expiration-Month"
		},
		expirationYear : {
			selector : "#expiration-Year"
		}
	},

	onPaymentMethodReceived : function(obj) {
			alert(obj.nonce);
			// doSomethingWithTheNonce(obj.nonce);
		}
	});

	alert("in asas");
</script> --%>
<%@ include file="/footer.jsp"%>