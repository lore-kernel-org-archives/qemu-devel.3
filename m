Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E17CCFA1A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 18:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIt09-0004Qc-A8; Tue, 11 Nov 2025 13:21:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vIszA-0002wb-PI
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 13:21:04 -0500
Received: from 10.mo548.mail-out.ovh.net ([46.105.77.235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vIsz8-0006L4-4C
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 13:20:55 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.110.43.201])
 by mo548.mail-out.ovh.net (Postfix) with ESMTPS id 4d5ZbQ4L1Jz5vS4;
 Tue, 11 Nov 2025 18:20:50 +0000 (UTC)
Received: from kaod.org (37.59.142.101) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 11 Nov
 2025 19:20:49 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G00405aa82e9-5f8e-4d2a-bd39-68d148d32899,
 FED24A3CA347B2ADB49E2A92EE4521FA9BC47B0E) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <a589c937-33bb-4647-9282-d9d1e2c15131@kaod.org>
Date: Tue, 11 Nov 2025 19:20:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/12] hw/arm/aspeed_ast10x0_evb: Add AST1060 EVB
 machine support
To: Jamin Lin <jamin_lin@aspeedtech.com>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, Joel
 Stanley <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, Kevin
 Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED
 BMCs" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
CC: <troy_lee@aspeedtech.com>, <kane_chen@aspeedtech.com>
References: <20251106084925.1253704-1-jamin_lin@aspeedtech.com>
 <20251106084925.1253704-10-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251106084925.1253704-10-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG2EX1.mxp5.local (172.16.2.11) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 823d16c1-2124-4cd1-b6c3-c45fd3009038
X-Ovh-Tracer-Id: 9115567122886724414
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFI54cztQU0zZOckAHpmcRRbgXHUyEHLdTdlt3xaKkH81BqRuWsu19xpne3PNrpwtgxJxSwWwSNRkEh59YB2pqmH7itmoHdd6dn+GuE2bA1QlWpCibvc5lJqmM/4mIPFjPJfkjHW3cERFREU9EvZhHz4Vl+QEJAe3v/ev7kleGZiuKwZWZlBKQ7La6W4I0yBghXZTxw2TXsOJ1u7wL6qQlTUil4uxFcFxfsKWvfCo/D1fK50NId48NDeTr2GL0CXiA1P/Mzcai8n+EPnwZ9sIvgnWSs9BXXfki5/b5EEzHe2t3kQp3GsA75wY7Umbb017E26jbfsaNl/lAhdxapm74TptoIVSTaLr+4cPzGFpP6IVeJMxzrWiETtbw79qNBUh/wEkAnFMuJr1SIUQO9F2Rw+OtQARat+pmnfV1kLdjRDol/PkQc9tg96Sf7beNQXWeDzIL486qALzEM7H52FEA5L9koYPXT0aHQ/C5TqLB6dMQc6d5lREeFQo7wnnN89tZLnOxip3jXUA80e3BYgoTaHzbkv0aBmBHpjfdbC7lWyXhjwSh23VzG8Xw2dZN4gCUwaYUAL49kwUL5bEFjXY680Uu225YMaecGsTr1NGSWurUS8Ni7Tmuq3LArjKhSlGItZ9huii8hhZmG1Gf+MnoXNWttXvnGd9Cwq316vg0hKg
DKIM-Signature: a=rsa-sha256; bh=zZS8IkEkG1O88cUD80F8SlbZOiqH7ay+Mme1/7SIE/E=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1762885251; v=1;
 b=JQKrpfYUjf1DJm5mXf9p5zddZ0CYg8pKT1jaYkjiexfq3z8R5YxIMmCHAVLNZvcPmuvU/z61
 p3jnTSHgH/B56uQbdXpAswVzC6E/q6Mb97N9MQrTBbWyUcPokS3HSqcmpMc3FYnYotgvu0gBps/
 Jsa2yrGeqWPorpdW6ReBiJ9v/yL2H92JcXQCOM4RPS92V1xvv/7reKivMPHBFTb8HMQzbI9Jpis
 BmkfH6oqot7MyuKCIdppJ0G8xvMd4OfhihXIwsucuDq/VBDJsJm04APfk8g71hjo6B8NbnuloUH
 QH46smpI1/RjB8D7rNRKtBGl4VZtl3IkPP65ymeMy7yTg==
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
> Add a new machine definition ast1060-evb to support the Aspeed AST1060
> evaluation board. The new EVB reuses the same MiniBMC framework used by
> AST1030, as both SoCs share the same core peripherals and controller
> designs.
> 
> The AST1060 EVB machine initializes the ast1060-a2 SoC and sets the
> FMC and SPI flash models (w25q80bl and w25q02jvm) for simulation.
> This enables QEMU to boot and emulate firmware images for AST1060-based
> platforms.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/arm/aspeed_ast10x0_evb.c | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
> 
> diff --git a/hw/arm/aspeed_ast10x0_evb.c b/hw/arm/aspeed_ast10x0_evb.c
> index 7af2a77865..a01385b543 100644
> --- a/hw/arm/aspeed_ast10x0_evb.c
> +++ b/hw/arm/aspeed_ast10x0_evb.c
> @@ -96,12 +96,35 @@ static void aspeed_minibmc_machine_ast1030_evb_class_init(ObjectClass *oc,
>       aspeed_machine_class_init_cpus_defaults(mc);
>   }
>   
> +static void aspeed_minibmc_machine_ast1060_evb_class_init(ObjectClass *oc,
> +                                                          const void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    AspeedMachineClass *amc = ASPEED_MACHINE_CLASS(oc);
> +
> +    mc->desc = "Aspeed AST1060 PFR (Cortex-M4)";

What does "PFR" mean ?

> +    amc->soc_name = "ast1060-a2";
> +    amc->hw_strap1 = 0;
> +    amc->hw_strap2 = 0;
> +    mc->init = aspeed_minibmc_machine_init;
> +    amc->fmc_model = "w25q80bl";
> +    amc->spi_model = "w25q02jvm";
> +    amc->num_cs = 2;
> +    amc->macs_mask = 0;
> +    aspeed_machine_class_init_cpus_defaults(mc);
> +}
> +
>   static const TypeInfo aspeed_ast10x0_evb_types[] = {
>       {
>           .name           = MACHINE_TYPE_NAME("ast1030-evb"),
>           .parent         = TYPE_ASPEED_MACHINE,
>           .class_init     = aspeed_minibmc_machine_ast1030_evb_class_init,
>           .interfaces     = arm_machine_interfaces,
> +    }, {
> +        .name           = MACHINE_TYPE_NAME("ast1060-evb"),
> +        .parent         = TYPE_ASPEED_MACHINE,
> +        .class_init     = aspeed_minibmc_machine_ast1060_evb_class_init,
> +        .interfaces     = arm_machine_interfaces,
>       }
>   };
>   

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



