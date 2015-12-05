<%@ include file="/header.jsp"%>
<%@ include file="/index.jsp"%>
<%@ page import="com.lss.tbg.service.BraintreePaymentService"%>
<script src="https://js.braintreegateway.com/v2/braintree.js"></script>
<%
	BraintreePaymentService service = new BraintreePaymentService();
	String clientToken = service.getClientToken().toString();
%>
<form action="/xxx" method="post" id="checkoutIdxx" enctype="multipart/form-data" onsubmit="return false">
<input type="text" value="venkatram"/>


</form>


<form action="/" method="post" id="checkoutId">
	<fieldset>
		<table style="width: 350px;height: 100px;">
			<tr  style="height: 20px;">
				<td style="height: 20px;"><label for="card-number">Card Number:</label></td>
				<td style="height: 20px;"><div id="card-number"></div></td>

			</tr>
			<tr  style="height: 20px;">
				<td  style="height: 20px;"><label for="cvv">CVV:</label></td>
				<td style="height: 20px;"><div id="cvv"></div></td>

			</tr >
			<tr style="height: 20px;">
				<td  style="height: 20px;"><label for="expiration-date">expiration Month and year(mm/yy):</label></td>
				<td style="height: 20px;"><div id="expiration-date"></div></td>

			</tr>
			<tr>
				<td colspan="3" align="center">
					<button type="submit" value="Submit" id="hostedCheckout">Pay</button>
				</td>
			</tr>
		</table>
	</fieldset>

</form>
<script type="text/javascript">

braintree.setup("<%=clientToken%>", "custom", {
		displayName : "Test Hosted Fields - Sandbox Enviro",
		id : 'checkoutId',
		hostedFields : {
			styles : {
				'input' : {
					/* "font-size" : "12pt",
					"color" : "#3A3A3A",
					"width" : "10%", */
					'font-size' : '12pt',
					'color': '#1A41A4',
					'padding' : '4px 6px !important',
					'margin' : '3px !important',
					'border': '1px solid #5f5f5f !important',
					'border-radius': '6px !important'

				},
				'.number' : {
					"font-family" : "inherit"
				},
				':focus' : {
					'color' : 'blue'
				},
				'.valid' : {
					'color' : 'green'
				},
				'.invalid' : {
					'color' : 'red'
				},
				"@media screen and (max-width: 100px)" : {
					"input" : {
						"font-size" : "14pt"
					}
				}
			},
			onFieldEvent : function(event) {
				console.log(event);
				if (event.card) {
					console.log(event.card.type);
					switch (event.card.type) {
					case 'master-card':
						break;
					case 'american-express':
						break;
					case 'discover':
						break;
					case 'jcb':
						break;
					case 'visa':
						break;
					case 'diners-club':
					case 'unionpay':
					case 'maestro':
					default:
					}

				}
			},
			number : {
				selector : "#card-number"
			},
			cvv : {
				selector : "#cvv"
			},
			expirationDate : {
				selector : "#expiration-date"
			}
		},

		onReady : function(response) {
			console.log("in OnReady" + response);
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

<%@ include file="/footer.jsp"%>