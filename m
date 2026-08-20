Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E33C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 13:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx2QY-00078a-6D; Thu, 20 Aug 2026 09:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wx2QU-00076Y-7z
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:03:22 -0400
Received: from smtpout2.mo540.mail-out.ovh.net ([51.210.91.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wx2QP-0006W7-UB
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 09:03:21 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4hQkBq0cK7z41xL;
 Thu, 20 Aug 2026 13:03:15 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Thu, 20 Aug 2026 13:03:14 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.178.118])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4hQkBp6clMz1xq6;
 Thu, 20 Aug 2026 13:03:14 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 035D41923F21; Thu, 20 Aug 2026 13:03:12 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R003e5666219-02a3-4a78-8cc0-99e313863aa5,
 290C66463DCC85845983D07CBD6D5DF49C8F16C8) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 2.10.174.70
Message-ID: <18945ddb-a9f0-48b0-bdd9-a44cdad9e899@kaod.org>
Date: Thu, 20 Aug 2026 15:03:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] hw/arm/aspeed_ast2600: Wire up the ACRY model
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260820081206.3353463-1-jamin_lin@aspeedtech.com>
 <20260820081206.3353463-4-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260820081206.3353463-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 18091522654030507053
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF1PGCcAwnx0WmeiPlR8WsqYQtOKStaZXuP90gj0pflBTQ2XZ4goRh8ly1Ax24rQvxIDktsHDNjvSZVV13qU1uLDOR33PQa+9/y6Uh3p5/RO+vx4VJr/Ea80PQs3BKnjfk7f8lmm1Hi/B+6B4+27JqcHlCu0Bvt5LffHGqDMdk3C2O5tqGVL/0UiX5w9yweRpQUfT5zQ5xAwztbNmfZo68UcFlAXdTt/HqJjtgrVIIOBlz27SlulpPKiQoCSRBDxyefupcOg4gvIOlvHhYJITZ3kvqlF+8SoPklybDaHvyQLI4G6znPop45ThOszK9oTi51scufV6jYlrCtdvSDR9v+XLafcc5Zy6pUZoc+LWGPfLLjr7ctqlgh/eZ+oASOFp9Ge6rhzbaXEytxwdEadRRw84Tdad8VMBoerW0MxxktNd/wIPyXPVx6HezLbV7kkr865Fm1XIW7XPhRw/DEfZYVU25jq/J83z+hbed/DM7vLNrW6ekSC2LD1EHSlBQ9DlY/RompY95xTYNy7BzVd5TVwY+QjD6fPfNd2maK8Rz6NnpqGFvYqLv0Zw8bM/Bh1QaYX9RNwzaw6uceSsMCEHUMDN/5zfHDx6OaXTYoweIGaJCr+rzU2b78wO9iACjVQoAnEKTTXNb0yBZm6DTjE0UuBP/IFVSyfg/9mGKjNkZtCw
DKIM-Signature: a=rsa-sha256; bh=woGrygIhqvQO0TnXFL9rBmMuNdSt2FXIXslIK0gHLGk=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1787230995; v=1;
 b=iY6vcE2HMfn4CXQlf14JaWkeRm/RBR33NuJiOs8djjB7DCVD/iDqdkPZhYDOFr8eQE6z4qHY
 KpP/P1RCpREdhSLo1KNG/HvUgepyn+7mOHsRLHEd+erB4rQh5Aw1xdGmRcxIy8sxfPm9qCEhuXV
 xrK0TBx+9b9YZwwL63EvwWqw1HbkCMELr6cHWEntwM9+0bmq97arJ8+bs87kd8k2ae5QIZMwd7M
 jHn5DaH7LndNkU4ROhPLr3bhjhc47Jlq9SorkXjyQzKazWXW8WgRUFPMEU2VCsg7BNxdzqcPXp5
 s3AAbOMzr2PYtIlfItWg8iK2SET9pwhDQd6WJYb/cxNYQ==
Received-SPF: pass client-ip=51.210.91.51; envelope-from=clg@kaod.org;
 helo=smtpout2.mo540.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 8/20/26 10:12, Jamin Lin wrote:
> Introduce the ASPEED_DEV_ACRY enum slot and add the ACRY model state
> to AspeedSoCState.
> 
> Instantiate the new ACRY model on the AST2600 SoC using its
> real-silicon register address and IRQ:
> 
> - ACRY register region 0x1e6fa000-0x1e6fafff
> - IRQ 160
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_soc.h |  3 +++
>   hw/arm/aspeed_ast2600.c     | 17 +++++++++++++++++
>   2 files changed, 20 insertions(+)
> 
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 46e7854727..8d80f16705 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -25,6 +25,7 @@
>   #include "hw/i2c/aspeed_i2c.h"
>   #include "hw/i3c/aspeed_i3c.h"
>   #include "hw/ssi/aspeed_smc.h"
> +#include "hw/misc/aspeed_acry.h"
>   #include "hw/misc/aspeed_hace.h"
>   #include "hw/misc/aspeed_sbc.h"
>   #include "hw/misc/aspeed_sli.h"
> @@ -82,6 +83,7 @@ struct AspeedSoCState {
>       AspeedSCUState scu;
>       AspeedSCUState scuio;
>       AspeedHACEState hace;
> +    AspeedACRYState acry;
>       AspeedXDMAState xdma;
>       AspeedADCState adc;
>       AspeedSMCState fmc;
> @@ -271,6 +273,7 @@ enum {
>       ASPEED_DEV_EMMC,
>       ASPEED_DEV_KCS,
>       ASPEED_DEV_HACE,
> +    ASPEED_DEV_ACRY,
>       ASPEED_DEV_DPMCU,
>       ASPEED_DEV_DP,
>       ASPEED_DEV_I3C,
> diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
> index f23a51c8a4..f7c7ec7fb1 100644
> --- a/hw/arm/aspeed_ast2600.c
> +++ b/hw/arm/aspeed_ast2600.c
> @@ -52,6 +52,7 @@ static const hwaddr aspeed_soc_ast2600_memmap[] = {
>       [ASPEED_DEV_DP]        = 0x1E6EB000,
>       [ASPEED_DEV_PCIE_PHY1] = 0x1E6ED200,
>       [ASPEED_DEV_SBC]       = 0x1E6F2000,
> +    [ASPEED_DEV_ACRY]      = 0x1E6FA000,
>       [ASPEED_DEV_EMMC_BC]   = 0x1E6f5000,
>       [ASPEED_DEV_VIDEO]     = 0x1E700000,
>       [ASPEED_DEV_SDHCI]     = 0x1E740000,
> @@ -144,6 +145,7 @@ static const int aspeed_soc_ast2600_irqmap[] = {
>       [ASPEED_DEV_FSI1]      = 100,
>       [ASPEED_DEV_FSI2]      = 101,
>       [ASPEED_DEV_I3C]       = 102,   /* 102 -> 107 */
> +    [ASPEED_DEV_ACRY]      = 160,
>   };
>   
>   static qemu_irq aspeed_soc_ast2600_get_irq(AspeedSoCState *s, int dev)
> @@ -269,6 +271,8 @@ static void aspeed_soc_ast2600_init(Object *obj)
>       snprintf(typename, sizeof(typename), "aspeed.hace-%s", socname);
>       object_initialize_child(obj, "hace", &s->hace, typename);
>   
> +    object_initialize_child(obj, "acry", &s->acry, TYPE_ASPEED_ACRY);
> +
>       object_initialize_child(obj, "i3c", &s->i3c, TYPE_ASPEED_I3C);
>   
>       object_initialize_child(obj, "sbc", &s->sbc, TYPE_ASPEED_AST2600_SBC);
> @@ -726,6 +730,19 @@ static void aspeed_soc_ast2600_realize(DeviceState *dev, Error **errp)
>       sysbus_connect_irq(SYS_BUS_DEVICE(&s->hace), 0,
>                          aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_HACE));
>   
> +    /* ACRY */
> +    object_property_set_link(OBJECT(&s->acry), "dram", OBJECT(s->dram_mr),
> +                             &error_abort);
> +    object_property_set_link(OBJECT(&s->acry), "sram", OBJECT(&s->sram[1]),
> +                             &error_abort);
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&s->acry), errp)) {
> +        return;
> +    }
> +    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->acry), 0,
> +                    sc->memmap[ASPEED_DEV_ACRY]);
> +    sysbus_connect_irq(SYS_BUS_DEVICE(&s->acry), 0,
> +                       aspeed_soc_ast2600_get_irq(s, ASPEED_DEV_ACRY));
> +
>       /* I3C */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->i3c), errp)) {
>           return;

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


