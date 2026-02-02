Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E6AEE7DF08
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 16:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmxAj-0000IE-33; Mon, 02 Feb 2026 11:53:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vmxAg-0000HY-9a
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 11:53:06 -0500
Received: from 3.mo552.mail-out.ovh.net ([178.33.254.192])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vmxAe-0003NS-Kh
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 11:53:06 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.58.195])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4f4Xjm6QGfz5vyX;
 Mon,  2 Feb 2026 16:53:00 +0000 (UTC)
Received: from kaod.org (37.59.142.95) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 2 Feb
 2026 17:53:00 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G0019fa674b8-6ea9-446c-91f5-7d7cbea2aebc,
 7652E71065C1D671F0F2B67E69D7E7AF66B0F117) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <3a192654-b0bf-48c1-a662-0ba52a218a0c@kaod.org>
Date: Mon, 2 Feb 2026 17:52:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/8] hw/arm/aspeed_ast27x0: Sort SSP and TSP IRQ maps
To: Jamin Lin <jamin_lin@aspeedtech.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
References: <SE3PR06MB819906A48EA635CEB8DAAE7BFC9AA@SE3PR06MB8199.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SE3PR06MB819906A48EA635CEB8DAAE7BFC9AA@SE3PR06MB8199.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.95]
X-ClientProxiedBy: DAG5EX1.mxp5.local (172.16.2.41) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: 4625b06f-2056-455b-a857-de77daf29702
X-Ovh-Tracer-Id: 15450724422160452597
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTES8iLIQoMSAa1oS5sLlY6noRBT4nPmQYVbWa79LoLrpgUoZKXsOLh/i5BFcuUuN0FK198fmFw3Nt8yGW3NFiPxsmCqi1jcA84DZrU/u0IVJcyzeBvK3W2YF3FyGLKyuVJnfpIIZw3rS/lp/ndhBhLWfOA7bhGuILBweeR1HmAox5ikR1Hmtw5g0tW91Jf5eieNTcHW3bpLI234sOQFgQbtw+LHjsF/wC2OW25T3gSGxx/TZqZOpZ9mCvbKRispSXOQXBErU8cox+cbvVgGEyBOqnd6wOVo7e7tagBSSpp9H+YnWwxh0k8i+XgBwboFrbtNN80dhEtvuzmjRGq9WiH4obsvJRsG2nfrqH5QfQcqVUgFQbAzz8GiEAupSandwz4DvaliJbo1dFpjPLfnw0RPiZjyVlBOVKfFRY5hTU7H8vgLs1DwACXL+5EFqVH69+VCz1nMvlNfIRUkC3Y97YVBCNbDkuHcRwT4cBNhoeSL+ax2gcoDfxMOyptoGRPHIqsWTdi+aZ7HLvhjAjIpKtj/KlwK+m4ftukRNP6rZDN3AMqnglbVfasjYZudX5AKsxJ9hFGOrbee5lAJpXchj20lCVZGtw1xpv3+smRkBdboaSyz0TzN0bI8ddJbZMQ+ewemvBPa/9rsDLnhlnaBPuwNkmrNDiLO7F3bRgvbx7+q7g
DKIM-Signature: a=rsa-sha256; bh=uPS6+0EvxWPy1Ovx+kHX2fWlP7dlz4xpCyBOixLMLgo=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770051181; v=1;
 b=cWuMM4PRhi4xzt1Bs5B4Th7B06SUwCcXapWYdt0J+33JnCG32I1dMdRHcCA45BwbTOz/Ksx9
 MwKtsibbVn0nylS08SfQXdiC/Di03wqi/O82H5vztHabak03bjopRfZ5WHZfpK44iet4vvoIvWa
 YB7z/o/nbZHsGNS1nvdh4x9i4imRQGI8Yx69Uh8kXIiBbbo1y2waJwGy9cmdvOmqIlmbM0s3AAf
 IZ258Sm8ZL7eZrDJgJkCmbEbkLl6/jmXjwRC+UoGYCTP9N16Kat+aQNIRTfZVhoJwPDdH2cDHZF
 O7toJp9mySCxoB4UlW1n+WEp81r+/3BfI3uAXxlYoIbXg==
Received-SPF: pass client-ip=178.33.254.192; envelope-from=clg@kaod.org;
 helo=3.mo552.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/2/26 07:19, Jamin Lin wrote:
> From: Jamin Lin <jamin_lin@aspeedtech.com>
> 
> Sort the SSP and TSP IRQ map tables to improve readability and make the
> definitions easier to maintain.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast27x0-ssp.c | 4 ++--
>   hw/arm/aspeed_ast27x0-tsp.c | 4 ++--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
> index e4bcf0fa2a..9b12ba6743 100644
> --- a/hw/arm/aspeed_ast27x0-ssp.c
> +++ b/hw/arm/aspeed_ast27x0-ssp.c
> @@ -44,12 +44,13 @@ static const hwaddr aspeed_soc_ast27x0ssp_memmap[] = {
>   };
>   
>   static const int aspeed_soc_ast27x0ssp_irqmap[] = {
> +    [ASPEED_DEV_UART4]     = 8,
>       [ASPEED_DEV_SCU]       = 12,
> +    [ASPEED_DEV_TIMER1]    = 16,
>       [ASPEED_DEV_UART0]     = 164,
>       [ASPEED_DEV_UART1]     = 164,
>       [ASPEED_DEV_UART2]     = 164,
>       [ASPEED_DEV_UART3]     = 164,
> -    [ASPEED_DEV_UART4]     = 8,
>       [ASPEED_DEV_UART5]     = 164,
>       [ASPEED_DEV_UART6]     = 164,
>       [ASPEED_DEV_UART7]     = 164,
> @@ -58,7 +59,6 @@ static const int aspeed_soc_ast27x0ssp_irqmap[] = {
>       [ASPEED_DEV_UART10]    = 164,
>       [ASPEED_DEV_UART11]    = 164,
>       [ASPEED_DEV_UART12]    = 164,
> -    [ASPEED_DEV_TIMER1]    = 16,
>   };
>   
>   /* SSPINT 164 */
> diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
> index 68683a15d8..e39d1dc171 100644
> --- a/hw/arm/aspeed_ast27x0-tsp.c
> +++ b/hw/arm/aspeed_ast27x0-tsp.c
> @@ -44,12 +44,13 @@ static const hwaddr aspeed_soc_ast27x0tsp_memmap[] = {
>   };
>   
>   static const int aspeed_soc_ast27x0tsp_irqmap[] = {
> +    [ASPEED_DEV_UART4]     = 8,
>       [ASPEED_DEV_SCU]       = 12,
> +    [ASPEED_DEV_TIMER1]    = 16,
>       [ASPEED_DEV_UART0]     = 164,
>       [ASPEED_DEV_UART1]     = 164,
>       [ASPEED_DEV_UART2]     = 164,
>       [ASPEED_DEV_UART3]     = 164,
> -    [ASPEED_DEV_UART4]     = 8,
>       [ASPEED_DEV_UART5]     = 164,
>       [ASPEED_DEV_UART6]     = 164,
>       [ASPEED_DEV_UART7]     = 164,
> @@ -58,7 +59,6 @@ static const int aspeed_soc_ast27x0tsp_irqmap[] = {
>       [ASPEED_DEV_UART10]    = 164,
>       [ASPEED_DEV_UART11]    = 164,
>       [ASPEED_DEV_UART12]    = 164,
> -    [ASPEED_DEV_TIMER1]    = 16,
>   };
>   
>   /* TSPINT 164 */

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

