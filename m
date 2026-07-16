Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD79C44512
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 06:37:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkFix-0007ib-Fh; Thu, 16 Jul 2026 02:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wkFiw-0007gr-47; Thu, 16 Jul 2026 02:37:34 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wkFiu-0002tI-1g; Thu, 16 Jul 2026 02:37:33 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [152.228.215.222])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4h13Hq5L0Pz5wt9;
 Thu, 16 Jul 2026 06:37:27 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Thu, 16 Jul 2026 06:37:27 +0000 (UTC)
Received: from mta2.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.96.5])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4h13Hq46w4z5vVj;
 Thu, 16 Jul 2026 06:37:27 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta2.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 1C3BA9419CE; 
 Thu, 16 Jul 2026 06:37:26 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-95G001a01f650c-c919-447d-ac52-7becec1eab61,
 816DE1EE18DD2826DFD8B9EE289546F56902E1FE) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <4499caca-eddd-4f04-9e12-2171bf9eabc7@kaod.org>
Date: Thu, 16 Jul 2026 08:37:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] hw/arm/aspeed_ast27x0: Move SCU link into AST27x0
 coprocessors
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260707060919.350637-1-jamin_lin@aspeedtech.com>
 <20260707060919.350637-4-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260707060919.350637-4-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 8946119187476032572
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFwco07SobpDwtd5FHsEgCIphmUj6zqIl6vyo48QM6uuw8G2CrehKcRUYfeWBEPrkVcyNVWs0DgtrPk6rRHU2g2deGVCbjXA5GCVq7Ok8W2fRarBFL1bFvXkqepBHJ1ARuylM1gX3B1lCKKracUyktngphbe7CM87zJck/OG8wy+keJEPQllC/ghMFSUShCB0Iv/usU0Li6ABt1h4yxqwEEP1F7ON3OQYDfN6Ow55JLQlZP6U9YxXJ8cyE0tZfq2Z4ZlI7CUvsVftRkm/lo6PNE8i5J5B5Hq5CWrCc0Uclm9mV4yJpH2OZwQyrMWD1olyYKubhZSYjk1zJCKhv3j83hN43/95dHt/ljxGKWZS6pNSvjOHJ16OJ6ph3T3irsyO5/79YEbrZJ2ZFvJ9SagYg8r0w2gkW/SLFAvcvd/KGdtMnUM3UChjwcp+oSht3dLDZxoHln+Pt6VhNfqiAFwzKDpbMOI7h0V0SwOgvx4r50KV+RpsD22qt3GunI3E5WMJnZBR9flp6KD5fOIyxt+NVvGtCGfPLMtp2Sj10/apEZKKcN2QVIDYuv2Kpt+1hpQJLGhbxEbbw5YjeDGL51bsYv22xNW9p6FJxlyUyjSWDKouofVb1crrgk+uYZaYXvbQRweAIElEgMubo5XwkFI+Q900SsWzzPa478o3dUpczaSg
DKIM-Signature: a=rsa-sha256; bh=MNevT0hkku1JXAn023Fmz3f46ojtyeUi4D10jfIG9RM=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1784183848; v=1;
 b=HcyFfnWcb2CPKTicZGCHLn649gKEGr1Usf/FeOJHGtHWyc9N8Zl5+TtMz2uw/BKeaVNO+bP1
 79GUnbYYro+weHGY9XkzKE3+MahihX/o/FycQKRJXeXHuWKj5C9cEipdiovDhwLrFBdxqY7HKue
 pajZHFz4HBkaRCVLY4xh2ZsjrMJvsc646p8UCE4jZmSUUfQ+dbx0S1KeFm8LY6RUwzk/VvDxZrS
 26bdJEDMgV70zRRdHQBjhpAyVSvXw3aUTYqiIeq069t1HBUPNUovJ/Ubi0EAkQ3lM9M3dLndVFE
 7vHyXI2eR8QVmuVZC/lATvLEEgbbLbDKebkGAJLG4QfJQ==
Received-SPF: pass client-ip=46.105.34.251; envelope-from=clg@kaod.org;
 helo=smtpout1.mo528.mail-out.ovh.net
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/7/26 08:09, Jamin Lin wrote:
> The SCU link is only needed by the AST27x0 SSP/TSP coprocessors for their
> AST2700-specific SCU alias window.
> 
> Move the link property from the common AspeedCoprocessorState into
> Aspeed27x0CoprocessorState, so the generic coprocessor model no longer
> contains an AST2700-specific dependency.
> 
> Also validate that the SCU link has been provided during device realize
> before accessing it.
> 
> No functional change.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   include/hw/arm/aspeed_coprocessor.h |  5 +++--
>   hw/arm/aspeed_ast27x0-ssp.c         | 20 ++++++++++++++++----
>   hw/arm/aspeed_ast27x0-tsp.c         | 20 ++++++++++++++++----
>   hw/arm/aspeed_coprocessor_common.c  |  2 --
>   4 files changed, 35 insertions(+), 12 deletions(-)
> 
> diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_coprocessor.h
> index ac58a5f424..adfc3c4512 100644
> --- a/include/hw/arm/aspeed_coprocessor.h
> +++ b/include/hw/arm/aspeed_coprocessor.h
> @@ -20,10 +20,8 @@ struct AspeedCoprocessorState {
>       MemoryRegion *sram;
>       MemoryRegion sram_alias;
>       MemoryRegion uart_alias;
> -    MemoryRegion scu_alias;
>       Clock *sysclk;
>   
> -    AspeedSCUState *scu;
>       AspeedSCUState scuio;
>       AspeedTimerCtrlState timerctrl;
>       SerialMM *uart;
> @@ -52,6 +50,9 @@ struct Aspeed27x0CoprocessorState {
>       UnimplementedDeviceState otp;
>   
>       ARMv7MState armv7m;
>

If you resend, or in a following series, please add a comment
saying that the fields below are shared with the main SoC.

> +    MemoryRegion scu_alias;
> +    Aspeed2700SCUState *scu;
>   };
>   
>   #define TYPE_ASPEED27X0SSP_COPROCESSOR "aspeed27x0ssp-coprocessor"
> diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
> index 68a8ab26f7..28bb59c8c5 100644
> --- a/hw/arm/aspeed_ast27x0-ssp.c
> +++ b/hw/arm/aspeed_ast27x0-ssp.c
> @@ -167,6 +167,12 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
>           return;
>       }
>   
> +    if (!a->scu) {
> +        error_setg(errp, TYPE_ASPEED27X0SSP_COPROCESSOR
> +                   ": 'scu' link is not set");
> +        return;
> +    }
> +
>       /* AST27X0 SSP Core */
>       armv7m = DEVICE(&a->armv7m);
>       qdev_prop_set_uint32(armv7m, "num-irq", 256);
> @@ -195,11 +201,11 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
>                                   &s->sram_alias);
>   
>       /* SCU */
> -    memory_region_init_alias(&s->scu_alias, OBJECT(s), "scu.alias",
> -                             &s->scu->iomem, 0,
> -                             memory_region_size(&s->scu->iomem));
> +    memory_region_init_alias(&a->scu_alias, OBJECT(a), "scu.alias",
> +                             &a->scu->parent_obj.iomem, 0,
> +                             memory_region_size(&a->scu->parent_obj.iomem));
>       memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],
> -                                &s->scu_alias);
> +                                &a->scu_alias);
>   
>       /* INTC */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
> @@ -275,6 +281,11 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
>                                     sc->memmap[ASPEED_DEV_OTP], 0x800);
>   }
>   
> +static const Property aspeed_27x0_coprocessor_properties[] = {
> +    DEFINE_PROP_LINK("scu", Aspeed27x0CoprocessorState, scu,
> +                     TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),
> +};
> +
>   static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,
>                                                const void *data)
>   {
> @@ -288,6 +299,7 @@ static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,
>       /* Reason: The Aspeed Coprocessor can only be instantiated from a board */
>       dc->user_creatable = false;
>       dc->realize = aspeed_soc_ast27x0ssp_realize;
> +    device_class_set_props(dc, aspeed_27x0_coprocessor_properties);
>   
>       sc->valid_cpu_types = valid_cpu_types;
>       sc->irqmap = aspeed_soc_ast27x0ssp_irqmap;
> diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
> index b8a4f7c91d..f5c4a02161 100644
> --- a/hw/arm/aspeed_ast27x0-tsp.c
> +++ b/hw/arm/aspeed_ast27x0-tsp.c
> @@ -167,6 +167,12 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
>           return;
>       }
>   
> +    if (!a->scu) {
> +        error_setg(errp, TYPE_ASPEED27X0TSP_COPROCESSOR
> +                   ": 'scu' link is not set");
> +        return;
> +    }
> +
>       /* AST27X0 TSP Core */
>       armv7m = DEVICE(&a->armv7m);
>       qdev_prop_set_uint32(armv7m, "num-irq", 256);
> @@ -195,11 +201,11 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
>                                   &s->sram_alias);
>   
>       /* SCU */
> -    memory_region_init_alias(&s->scu_alias, OBJECT(s), "scu.alias",
> -                             &s->scu->iomem, 0,
> -                             memory_region_size(&s->scu->iomem));
> +    memory_region_init_alias(&a->scu_alias, OBJECT(a), "scu.alias",
> +                             &a->scu->parent_obj.iomem, 0,
> +                             memory_region_size(&a->scu->parent_obj.iomem));
>       memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],
> -                                &s->scu_alias);
> +                                &a->scu_alias);
>   
>       /* INTC */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
> @@ -275,6 +281,11 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
>                                     sc->memmap[ASPEED_DEV_OTP], 0x800);
>   }
>   
> +static const Property aspeed_27x0_coprocessor_properties[] = {
> +    DEFINE_PROP_LINK("scu", Aspeed27x0CoprocessorState, scu,
> +                     TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),
> +};
> +
>   static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,
>                                                const void *data)
>   {
> @@ -288,6 +299,7 @@ static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,
>       /* Reason: The Aspeed Coprocessor can only be instantiated from a board */
>       dc->user_creatable = false;
>       dc->realize = aspeed_soc_ast27x0tsp_realize;
> +    device_class_set_props(dc, aspeed_27x0_coprocessor_properties);
>   
>       sc->valid_cpu_types = valid_cpu_types;
>       sc->irqmap = aspeed_soc_ast27x0tsp_irqmap;
> diff --git a/hw/arm/aspeed_coprocessor_common.c b/hw/arm/aspeed_coprocessor_common.c
> index a0a4c73d08..43026d2a55 100644
> --- a/hw/arm/aspeed_coprocessor_common.c
> +++ b/hw/arm/aspeed_coprocessor_common.c
> @@ -27,8 +27,6 @@ static const Property aspeed_coprocessor_properties[] = {
>                        TYPE_MEMORY_REGION, MemoryRegion *),
>       DEFINE_PROP_LINK("sram", AspeedCoprocessorState, sram, TYPE_MEMORY_REGION,
>                        MemoryRegion *),
> -    DEFINE_PROP_LINK("scu", AspeedCoprocessorState, scu, TYPE_ASPEED_SCU,
> -                     AspeedSCUState *),
>       DEFINE_PROP_LINK("uart", AspeedCoprocessorState, uart, TYPE_SERIAL_MM,
>                        SerialMM *),
>       DEFINE_PROP_INT32("uart-dev", AspeedCoprocessorState, uart_dev, 0),


