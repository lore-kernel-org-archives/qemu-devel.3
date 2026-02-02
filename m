Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939C4E7DF0C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 16:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmxA1-0008TN-AN; Mon, 02 Feb 2026 11:52:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vmx9z-0008SR-2k
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 11:52:23 -0500
Received: from 10.mo548.mail-out.ovh.net ([46.105.77.235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vmx9w-0003HY-Mz
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 11:52:22 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.58.201])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4f4Xhv4SG8z5vS5;
 Mon,  2 Feb 2026 16:52:15 +0000 (UTC)
Received: from kaod.org (37.59.142.106) by DAG14EX2.mxp5.local (172.16.2.142)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Mon, 2 Feb
 2026 17:52:14 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006abfa813d-7937-4a7d-8986-7315e9d2eec4,
 7652E71065C1D671F0F2B67E69D7E7AF66B0F117) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <a7cd6e8d-9d29-4cfc-97c5-76a79b90d473@kaod.org>
Date: Mon, 2 Feb 2026 17:52:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/8] hw/arm/aspeed_ast27x0: Fix EHCI3/4 IRQ routing to
 GIC
To: Jamin Lin <jamin_lin@aspeedtech.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>,
 "leetroy@gmail.com" <leetroy@gmail.com>, "andrew@codeconstruct.com.au"
 <andrew@codeconstruct.com.au>, "joel@jms.id.au" <joel@jms.id.au>,
 "pierrick.bouvier@linaro.org" <pierrick.bouvier@linaro.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Troy Lee <troy_lee@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>
References: <SE3PR06MB81996DD83FD1E3D3D72ED313FC9AA@SE3PR06MB8199.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SE3PR06MB81996DD83FD1E3D3D72ED313FC9AA@SE3PR06MB8199.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.106]
X-ClientProxiedBy: DAG7EX2.mxp5.local (172.16.2.62) To DAG14EX2.mxp5.local
 (172.16.2.142)
X-Ovh-Tracer-GUID: ea9a0a84-0edb-41ed-85aa-af850313e21a
X-Ovh-Tracer-Id: 15437776575863294965
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF8O6KCbLlmuKHCIkpykW1a7JnaCzJpN5hIVCpcm5MFoeDxjYMFFkuMhs+qHFQMIkQcR6KktYS9w3TyxCxTH5nFa1uGyJG/j2CDOvJgs+RCE70rGxR1p1rSbSQzEBZTB1cccyQCaxaQqMoW9KPkHcbhUAuZksJMbFlihtRdYX1WvnHd72v+1K57hT8t9OeNHyPPoGKv+tVa7AD8fPwui5w35swbKykljBfDycsmLLK8vPUlqmmrv8geCxA+sU1BRDtf/2vQJ1yTxv9dcfDSp2Pqu1LennP2/wpGvP3b7tun5OGatic+75SS6kA3T/v/m+pI2SKf1zjXnASsolPl+agxB6j1MvMU693uyw8cbtnFjWkihReXrfE0PXYAP6nOjfv7Rva06tWjRYbEy+fLhgAxQHOq1r+lTpi5pW/iimYQXdH9tvcGKR3KCxbVXJQ8OVFez2L6gRNxLIjLJzh8N6GX9TKV72xfutSRwEqarc7GPYCqrVJKZL+mTskhavOKmentSjqGc77eBf49eA4NYA69a7WkkIFM76gWU/ihqJg2DsyZp+PgyKZKoizDgBAugmApYk9cHpzltQH1gFcSxvCj0rM296MSRa8132CDX2XcDLMdhuXaKf45+TMNdQTsl7S599kQAVuQbzjRl72ddh1d/8PkNu6ucMmRYcrfQAFLeg
DKIM-Signature: a=rsa-sha256; bh=gaaWkRW0/9uxrSDE31jBSLGvf2kinUPC8Uxme7mq/Rs=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1770051136; v=1;
 b=TQE5T2Dqr+JstSNVN4eqkts3PGkyG/k2WPMFD08VT1A5L9c7xybdUwwUBmiCFsMwJnBJGI/J
 vpbq7T8suYCctJWVK+phqMsy2qnHnkNaJVatzsFU7zbkwzEWurL6gS/9X3eaIJm2Sa7BHVP0tSg
 BtOOlQXHdt48RqPB2L+2Ds3QEDpXqo+HpsvODZXb6d1DRwOMpc5qUylomZtGh4cCbHxzhTq6zd7
 lqmpnzMRVhNbrjbMqy6KIiQIjDL3j5TPXFFqnooFyiHVQOgsNxwlZT6jI3gJKqCLh/Hnyzv3qva
 CRjO7DiuaK5Mv6iGgzIsvC56t8sCNASWDAIeSUSf2k7kw==
Received-SPF: pass client-ip=46.105.77.235; envelope-from=clg@kaod.org;
 helo=10.mo548.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> EHCI3 and EHCI4 were missing entries in aspeed_soc_ast2700a1_irqmap,
> so their source IRQs were never routed through the INTC OR-gates.
> 
> As a result, EHCI3/4 interrupts were not propagated to the GIC,
> causing incorrect interrupt behavior for these controllers.
> 
> Add EHCI3 and EHCI4 to the IRQ map and route them to the same INTC
> group as other shared peripherals, ensuring their interrupts are
> properly connected to the GIC.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Fixes: ba27ba302a264117c8b8427f944ced1bed17c438 ("hw/arm: ast27x0: Wire up EHCI controllers")
> ---
>   hw/arm/aspeed_ast27x0.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index d17f446661..e16183c3b3 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -149,6 +149,8 @@ static const int aspeed_soc_ast2700a1_irqmap[] = {
>       [ASPEED_DEV_ETH1]      = 196,
>       [ASPEED_DEV_ETH2]      = 196,
>       [ASPEED_DEV_ETH3]      = 196,
> +    [ASPEED_DEV_EHCI3]     = 196,
> +    [ASPEED_DEV_EHCI4]     = 196,
>       [ASPEED_DEV_PECI]      = 197,
>       [ASPEED_DEV_SDHCI]     = 197,
>   };

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

