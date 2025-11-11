Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C140ACCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 18:22:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIszv-0003sd-0j; Tue, 11 Nov 2025 13:21:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vIsy3-0001uE-H0; Tue, 11 Nov 2025 13:19:49 -0500
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1vIsy1-00060U-O8; Tue, 11 Nov 2025 13:19:47 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.54.27])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 4d5ZZ60WRNz5vqn;
 Tue, 11 Nov 2025 18:19:41 +0000 (UTC)
Received: from kaod.org (37.59.142.107) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 11 Nov
 2025 19:19:40 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-107S001ba434721-7c73-4691-bd3b-21e20d23aeb9,
 FED24A3CA347B2ADB49E2A92EE4521FA9BC47B0E) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <b66d5044-cd8a-4f5d-aad4-c685dcd34e3f@kaod.org>
Date: Tue, 11 Nov 2025 19:19:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/12] hw/arm/aspeed_ast10x0: Pass SoC name to common
 init for AST10x0 family reuse
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <kane_chen@aspeedtech.com>
References: <20251106084925.1253704-1-jamin_lin@aspeedtech.com>
 <20251106084925.1253704-8-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251106084925.1253704-8-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.107]
X-ClientProxiedBy: DAG6EX1.mxp5.local (172.16.2.51) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 3dee8299-b153-4117-8874-87926cc8e511
X-Ovh-Tracer-Id: 9096426823833914174
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEu8TXs5pAMOFO/x5lb3fcBUX66ZVaVIhTB8S/g6hk0V1lJwC2jjC00jBVYgxVoniO4Lwm+MCF5fzZjuQXvjYiESdYrGkmy291xLfgyfmlbDTO9Z7vhKQ5DujN865eZ2WAa7a2vQHGn2tSIfnJessBp25PHu6Hg+lPG3k4lHMT2nTrfDvDwag/uBaq7JXtqSAdwEWzkho6Hb6LvzAs1Gupn6K8juLgn07EN42UWJCJ3tX2eVxBosquDHMWIgkCc3QHg8z2WYF+Rprc3wZshOuTdo9XftxuLBEYitUtijxWRVyR+0BXmcZXuqhtyQnu57SMyk/0s4/RuS6tKY2cGjOA2BrT80R8K7dfj5h5CuF6aFZARkTNSKV6LkZ+pW4ijPEbh0ax89tZfX4AQErSorULb8F1Cxl/VX1jGyI+kcC9jAp0UQh5JZgUkOASed2+vNRhj8czUOfCKKrSyWAIFSsjLo86PBC/8cCyLaN22aCqjedHIvHs9jWPtEp7/bCjjqRLdmYqWMMLVXmnoliKXWZgVNaudpEd0We+nGm/DDc5m0ZtY2WVUMaYA2QilxnKRrFMN2eXQiVHAMEkox+sJsaUDw76qbJScjNp5R19oh1gqWEzUHAEX0uldM37OB2/HOQQhF19xy8skw09V2qgst9Fl9ZlibHw4a0XvfAMpf8025Q
DKIM-Signature: a=rsa-sha256; bh=XQqI37UI4p/gAn5F4R6nqOFxt91wSvefpGxa7d+UrNk=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1762885183; v=1;
 b=MTwIKXe30ahEcJmKbqxZwQanF5bL068NKtu7K5ToIEN/hEJQ3mEOleYjx3dWdVShLHT8YfMT
 npmJbzXN2XIDnfiqxpuggCbJWR1+bIWfz8afy9XbPuWi/qntkW7T6c059PrcMAF3CsQrteRj/CJ
 NgwhAkUbvIr4NKNKp8IizOHoBszPuKVzgC1W+E9CUDS5EqLx7XW9cuye0X4ux6aYDfIeX9MpA6v
 C3Z8zcABklzPj5r5BvBdjKQEOsEV5JC9sb4qJCHK17+huoiO0P+9dwEdbFMG797NjvRRe59VJZa
 aK6lDTwevxS7CZBuAtwslBOXyN1M3sLuZ+ehbHgXmKxIQ==
Received-SPF: pass client-ip=178.32.125.2; envelope-from=clg@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 11/6/25 09:49, Jamin Lin wrote:
> Refactor the AST10x0 common initialization to accept a socname
> parameter.
> 
> The AST1030 model can be reused by AST1060 since they share most of the
> same controllers. This approach allows AST1060 to leverage the existing
> AST1030 initialization flow while keeping separate SoC-specific init
> functions for components that differ.
> 
> This prepares the framework for AST1060 support, allowing it to reuse
> AST1030 device models and initialization flow without code duplication.
> 
> No functional changes.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast10x0.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
> index 5bbe16af24..c85c21b149 100644
> --- a/hw/arm/aspeed_ast10x0.c
> +++ b/hw/arm/aspeed_ast10x0.c
> @@ -107,19 +107,14 @@ static qemu_irq aspeed_soc_ast1030_get_irq(AspeedSoCState *s, int dev)
>       return qdev_get_gpio_in(DEVICE(&a->armv7m), sc->irqmap[dev]);
>   }
>   
> -static void aspeed_soc_ast10x0_init(Object *obj)
> +static void aspeed_soc_ast10x0_init(Object *obj, const char *socname)
>   {
>       Aspeed10x0SoCState *a = ASPEED10X0_SOC(obj);
>       AspeedSoCState *s = ASPEED_SOC(obj);
>       AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
> -    char socname[8];
>       char typename[64];
>       int i;
>   
> -    if (sscanf(object_get_typename(obj), "%7s", socname) != 1) {
> -        g_assert_not_reached();
> -    }
> -
>       object_initialize_child(obj, "armv7m", &a->armv7m, TYPE_ARMV7M);
>   
>       s->sysclk = qdev_init_clock_in(DEVICE(s), "sysclk", NULL, NULL, 0);
> @@ -184,8 +179,13 @@ static void aspeed_soc_ast10x0_init(Object *obj)
>   static void aspeed_soc_ast1030_init(Object *obj)
>   {
>       AspeedSoCState *s = ASPEED_SOC(obj);
> +    char socname[8];
> +
> +    if (sscanf(object_get_typename(obj), "%7s", socname) != 1) {
> +        g_assert_not_reached();
> +    }
>   
> -    aspeed_soc_ast10x0_init(obj);
> +    aspeed_soc_ast10x0_init(obj, socname);


As Philippe suggested, why not use directly :

        aspeed_soc_ast10x0_init(obj, "ast1030");


Thanks,

C.



>       object_initialize_child(obj, "lpc", &s->lpc, TYPE_ASPEED_LPC);
>       object_initialize_child(obj, "peci", &s->peci, TYPE_ASPEED_PECI);
>   }


