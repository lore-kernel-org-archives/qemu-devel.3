Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2C9CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 17:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU65h-0000AI-IR; Mon, 01 Jun 2026 13:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wU65M-0008W2-ME; Mon, 01 Jun 2026 13:05:58 -0400
Received: from smtpout1.mo2.mail-out.ovh.net ([79.137.123.219])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wU65H-0007hg-7D; Mon, 01 Jun 2026 13:05:56 -0400
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo2.mail-out.ovh.net (Postfix) with ESMTPS id 4gTgMX2rHjz4Bck;
 Mon,  1 Jun 2026 17:05:44 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Mon,  1 Jun 2026 17:05:44 +0000 (UTC)
Received: from mta11.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.43.184])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gTgMX1RBpz1yDS; Mon,  1 Jun 2026 17:05:44 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.1])
 (Authenticated sender: clg@kaod.org)
 by mta11.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 9ADF42403055; Mon,  1 Jun 2026 17:05:42 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004cdc2545c-d031-418d-b155-a0440368af2a,
 E35A50153BDE4127F94F88E3CE699B0651996EDF) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <b81a79f7-be69-4530-8105-d747d0f70c97@kaod.org>
Date: Mon, 1 Jun 2026 19:05:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/21] hw/misc/aspeed_scu: Introduce Aspeed2700SCU
 subclass and separate from generic SCU
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
 <20260417032837.2664122-2-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260417032837.2664122-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 13540072283189062795
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTERayHgcog1R7aW8t/pLZIlL7bw0MFm8VT2dDUKpIL1MZ8vo7RlLnuct1MVDMffr4qe9i2XzIOlz61Q00IShQ05F8BeUzVcWrEAT+fxcHI8rZJKM9lCgnD0Vwf88UupNlrKWnSl+pj5XmaTACDET+vkqia4j0vJ0b2mp8yiF9g/srivE7/AA1Z0hPebGZmY+4YH7/0rN6sl5ZmIkRntBYv8nXERL0UB2NV7NfU5AyQ2b+kWeW/gMGUEdLP8RY+emR7pihEwpuLnHjomYMcbKVqSKc27ESzyDD1gu3188UnM6LctoQEKeAiEAKfL9+HXvghV4LkVkWPoCkzzNODqy5zGUCn1D53ty9Ek1sLEIruExDrjxc+9L1jrMDmwJSiA/U1bPXUoEpn5cn1tnN3Dff06E9CDzuuAw8iolDoKCMeyzxPNTRTuu2TF8jyIPusV2XMJUMoEhglyzOyDxfLC758iARepGEsspvZJbXlqAzJf6HaMQoMZsmSBGs5kLOnDU/+TkTrn8BesNZ6gupN7UiXkw0bKG4iDwh3bEBlc09M8LFrOSzeMp0XpPT6CUG/6qGva9xiawes28p4NoHcbAPAaAE9CFZZh1Z0a7xozq4/UjcLuRMDjfagZCZQSpxcqTYyZ5IENUWXbTUS76FAbQsp31t5XrnD1Vxt9tTZFDVaBew
DKIM-Signature: a=rsa-sha256; bh=KZMmtAZhwGkFKvynRY05NXrY/AM0UiG0iDeQAgWIw50=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1780333546; v=1;
 b=Yau7nsi6ATOz85P0Eru798DUQ2H82Umno51ul26kP5HspazbjAPweluyvBXxtAekqOVfSxXm
 7HGXuYaAkRtC+RXSVNZK/LjM/LOSJCwrA+84YNdbtGdlIC49TZUwIX/7PiL0Ecpu4LbaG3ae3dD
 7WDvxPiNbz2W9qu3CmUyskbAeaA+GLnrG4/lS54yR+/Ufz9adXDRYLe0jKi7XjC6qGGcFn2ss8N
 mADR73aeIWrzGC7Z4W+H6u+Mu7ol1K83woby2McLNEn7DCDhq9+9LXrRCzik6zXmJoUWKXxYQpi
 RLEaDkwtOVxEKp4y027Kf4a+fO2KLmxqxRxxR0z37Ri4Q==
Received-SPF: pass client-ip=79.137.123.219; envelope-from=clg@kaod.org;
 helo=smtpout1.mo2.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 4/17/26 05:28, Jamin Lin wrote:
> Introduce a dedicated Aspeed2700SCUState subclass to isolate AST2700-specific
> behavior from the generic AspeedSCUState implementation.
> 
> Previously, AST17x0/27x0 platforms reused AspeedSCUState directly, including
> in coprocessor paths. With AST2700 introducing additional requirements (e.g.
> future coprocessor features such as DRAM remapping), continuing to extend the
> generic SCU risks impacting other SoCs.
> 
> To address this, add Aspeed2700SCUState as a subclass of AspeedSCUState and
> migrate all AST2700-related users to it, including:
> - AST1700 SoC
> - AST27x0 SoC
> - AST27x0 FC
> - AST27x0 coprocessors
> 
> As part of this refactoring:
> - Remove SCU linkage from the common AspeedCoprocessorState
> - Add a dedicated 'scu' link property to Aspeed27x0CoprocessorState
> - Update SCU memory aliasing to reference the subclass (parent_obj.iomem)
> 
> This separation keeps the common code generic while enabling AST2700-specific
> extensions in both SCU and coprocessor paths.
> 
> No functional change.

I think this patch needs to be broken down further.

> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   include/hw/arm/aspeed_ast1700.h     |  2 +-
>   include/hw/arm/aspeed_coprocessor.h |  5 +++--
>   include/hw/arm/aspeed_soc.h         |  1 +
>   include/hw/misc/aspeed_scu.h        |  5 +++++
>   hw/arm/aspeed_ast27x0-fc.c          |  4 ++--
>   hw/arm/aspeed_ast27x0-ssp.c         | 14 ++++++++++----
>   hw/arm/aspeed_ast27x0-tsp.c         | 14 ++++++++++----
>   hw/arm/aspeed_ast27x0.c             | 16 ++++++++--------
>   hw/arm/aspeed_coprocessor_common.c  |  2 --
>   hw/misc/aspeed_scu.c                |  8 +++++++-
>   10 files changed, 47 insertions(+), 24 deletions(-)
> 
> diff --git a/include/hw/arm/aspeed_ast1700.h b/include/hw/arm/aspeed_ast1700.h
> index f7bd4e8650..39c5977cf1 100644
> --- a/include/hw/arm/aspeed_ast1700.h
> +++ b/include/hw/arm/aspeed_ast1700.h
> @@ -41,7 +41,7 @@ struct AspeedAST1700SoCState {
>       MemoryRegion sram;
>       AspeedSMCState spi;
>       AspeedADCState adc;
> -    AspeedSCUState scu;
> +    Aspeed2700SCUState scu;
>       AspeedGPIOState gpio;
>       AspeedSGPIOState sgpiom[AST1700_SGPIO_NUM];
>       AspeedI2CState i2c;
> diff --git a/include/hw/arm/aspeed_coprocessor.h b/include/hw/arm/aspeed_coprocessor.h
> index 4a50f688ec..4db995d251 100644
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
> @@ -50,6 +48,9 @@ struct Aspeed27x0CoprocessorState {
>       UnimplementedDeviceState scuio;
>   
>       ARMv7MState armv7m;
> +
> +    MemoryRegion scu_alias;
> +    Aspeed2700SCUState *scu;
>   };
>   
>   #define TYPE_ASPEED27X0SSP_COPROCESSOR "aspeed27x0ssp-coprocessor"
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index d7b3647ca1..adf2f2898a 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -151,6 +151,7 @@ struct Aspeed27x0SoCState {
>       AspeedINTCState intcioexp[ASPEED_IOEXP_NUM];
>       GICv3State gic;
>       MemoryRegion dram_empty;
> +    Aspeed2700SCUState scu;
>   };
>   
>   #define TYPE_ASPEED27X0_SOC "aspeed27x0-soc"
> diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
> index d003955428..fd30313e69 100644
> --- a/include/hw/misc/aspeed_scu.h
> +++ b/include/hw/misc/aspeed_scu.h
> @@ -20,6 +20,7 @@ OBJECT_DECLARE_TYPE(AspeedSCUState, AspeedSCUClass, ASPEED_SCU)
>   #define TYPE_ASPEED_2500_SCU TYPE_ASPEED_SCU "-ast2500"
>   #define TYPE_ASPEED_2600_SCU TYPE_ASPEED_SCU "-ast2600"
>   #define TYPE_ASPEED_2700_SCU TYPE_ASPEED_SCU "-ast2700"
> +OBJECT_DECLARE_SIMPLE_TYPE(Aspeed2700SCUState, ASPEED_2700_SCU)
>   #define TYPE_ASPEED_2700_SCUIO TYPE_ASPEED_SCU "io" "-ast2700"
>   #define TYPE_ASPEED_1030_SCU TYPE_ASPEED_SCU "-ast1030"
>   
> @@ -41,6 +42,10 @@ struct AspeedSCUState {
>       uint32_t hw_prot_key;
>   };
>   
> +struct Aspeed2700SCUState {
> +    AspeedSCUState parent_obj;
> +};
> +
>   #define AST2400_A1_SILICON_REV   0x02010303U
>   #define AST2500_A1_SILICON_REV   0x04010303U
>   #define AST2600_A3_SILICON_REV   0x05030303U
> diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
> index 5eb6680da9..46f0c97329 100644
> --- a/hw/arm/aspeed_ast27x0-fc.c
> +++ b/hw/arm/aspeed_ast27x0-fc.c
> @@ -156,7 +156,7 @@ static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)
>       object_property_set_link(OBJECT(&s->ssp), "sram",
>                                OBJECT(&psp->sram), &error_abort);
>       object_property_set_link(OBJECT(&s->ssp), "scu",
> -                             OBJECT(&psp->scu), &error_abort);
> +                             OBJECT(&s->ca35.scu), &error_abort);
>       if (!qdev_realize(DEVICE(&s->ssp), NULL, errp)) {
>           return false;
>       }
> @@ -188,7 +188,7 @@ static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)
>       object_property_set_link(OBJECT(&s->tsp), "sram",
>                                OBJECT(&psp->sram), &error_abort);
>       object_property_set_link(OBJECT(&s->tsp), "scu",
> -                             OBJECT(&psp->scu), &error_abort);
> +                             OBJECT(&s->ca35.scu), &error_abort);
>       if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {
>           return false;
>       }
> diff --git a/hw/arm/aspeed_ast27x0-ssp.c b/hw/arm/aspeed_ast27x0-ssp.c
> index 8b84300e0f..9a2079668b 100644
> --- a/hw/arm/aspeed_ast27x0-ssp.c
> +++ b/hw/arm/aspeed_ast27x0-ssp.c
> @@ -186,11 +186,11 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
>                                   &s->sram_alias);
>   
>       /* SCU */
> -    memory_region_init_alias(&s->scu_alias, OBJECT(s), "scu.alias",
> -                             &s->scu->iomem, 0,
> -                             memory_region_size(&s->scu->iomem));
> +    memory_region_init_alias(&a->scu_alias, OBJECT(a), "scu.alias",
> +                             &a->scu->parent_obj.iomem, 0,

a->scu->parent_obj.iomem seems wrong

> +                             memory_region_size(&a->scu->parent_obj.iomem));
>       memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SCU],
> -                                &s->scu_alias);
> +                                &a->scu_alias);
>   
>       /* INTC */
>       if (!sysbus_realize(SYS_BUS_DEVICE(&a->intc[0]), errp)) {
> @@ -257,6 +257,11 @@ static void aspeed_soc_ast27x0ssp_realize(DeviceState *dev_soc, Error **errp)
>                                     sc->memmap[ASPEED_DEV_SCUIO], 0x1000);
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
> @@ -270,6 +275,7 @@ static void aspeed_soc_ast27x0ssp_class_init(ObjectClass *klass,
>       /* Reason: The Aspeed Coprocessor can only be instantiated from a board */
>       dc->user_creatable = false;
>       dc->realize = aspeed_soc_ast27x0ssp_realize;
> +    device_class_set_props(dc, aspeed_27x0_coprocessor_properties);
>   
>       sc->valid_cpu_types = valid_cpu_types;
>       sc->irqmap = aspeed_soc_ast27x0ssp_irqmap;
> diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
> index e7c7b74491..674307103e 100644
> --- a/hw/arm/aspeed_ast27x0-tsp.c
> +++ b/hw/arm/aspeed_ast27x0-tsp.c
> @@ -186,11 +186,11 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
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
> @@ -257,6 +257,11 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
>                                     sc->memmap[ASPEED_DEV_SCUIO], 0x1000);
>   }
>   
> +static const Property aspeed_27x0_coprocessor_properties[] = {
> +    DEFINE_PROP_LINK("scu", Aspeed27x0CoprocessorState, scu,
> +                     TYPE_ASPEED_2700_SCU, Aspeed2700SCUState *),

a TYPE_ASPEED_2700_SCU is still a TYPE_ASPEED_SCU. Could you keep
the property removed below ?

> +};
> +
>   static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,
>                                                const void *data)
>   {
> @@ -270,6 +275,7 @@ static void aspeed_soc_ast27x0tsp_class_init(ObjectClass *klass,
>       /* Reason: The Aspeed Coprocessor can only be instantiated from a board */
>       dc->user_creatable = false;
>       dc->realize = aspeed_soc_ast27x0tsp_realize;
> +    device_class_set_props(dc, aspeed_27x0_coprocessor_properties);
>   
>       sc->valid_cpu_types = valid_cpu_types;
>       sc->irqmap = aspeed_soc_ast27x0tsp_irqmap;
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index 87dcb82e1b..e84975a9c4 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -425,12 +425,12 @@ static void aspeed_soc_ast2700_init(Object *obj)
>   
>       object_initialize_child(obj, "gic", &a->gic, gicv3_class_name());
>   
> -    object_initialize_child(obj, "scu", &s->scu, TYPE_ASPEED_2700_SCU);
> -    qdev_prop_set_uint32(DEVICE(&s->scu), "silicon-rev",
> +    object_initialize_child(obj, "scu", &a->scu, TYPE_ASPEED_2700_SCU);
> +    qdev_prop_set_uint32(DEVICE(&a->scu), "silicon-rev",
>                            sc->silicon_rev);
> -    object_property_add_alias(obj, "hw-strap1", OBJECT(&s->scu),
> +    object_property_add_alias(obj, "hw-strap1", OBJECT(&a->scu),
>                                 "hw-strap1");
> -    object_property_add_alias(obj, "hw-prot-key", OBJECT(&s->scu),
> +    object_property_add_alias(obj, "hw-prot-key", OBJECT(&a->scu),
>                                 "hw-prot-key");
>   
>       object_initialize_child(obj, "scuio", &s->scuio, TYPE_ASPEED_2700_SCUIO);
> @@ -794,10 +794,10 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>                                   sc->memmap[ASPEED_DEV_VBOOTROM], &s->vbootrom);
>   
>       /* SCU */
> -    if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
> +    if (!sysbus_realize(SYS_BUS_DEVICE(&a->scu), errp)) {
>           return;
>       }
> -    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&s->scu), 0,
> +    aspeed_mmio_map(s->memory, SYS_BUS_DEVICE(&a->scu), 0,
>                       sc->memmap[ASPEED_DEV_SCU]);
>   
>       /* SCU1 */
> @@ -915,7 +915,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>           AspeedWDTClass *awc = ASPEED_WDT_GET_CLASS(&s->wdt[i]);
>           hwaddr wdt_offset = sc->memmap[ASPEED_DEV_WDT] + i * awc->iosize;
>   
> -        object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&s->scu),
> +        object_property_set_link(OBJECT(&s->wdt[i]), "scu", OBJECT(&a->scu),
>                                    &error_abort);
>           if (!sysbus_realize(SYS_BUS_DEVICE(&s->wdt[i]), errp)) {
>               return;
> @@ -1018,7 +1018,7 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
>                          aspeed_soc_ast2700_get_irq(s, ASPEED_DEV_EMMC));
>   
>       /* Timer */
> -    object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&s->scu),
> +    object_property_set_link(OBJECT(&s->timerctrl), "scu", OBJECT(&a->scu),
>                                &error_abort);
>       if (!sysbus_realize(SYS_BUS_DEVICE(&s->timerctrl), errp)) {
>           return;
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
> diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
> index e4160356e4..0a2dad4537 100644
> --- a/hw/misc/aspeed_scu.c
> +++ b/hw/misc/aspeed_scu.c
> @@ -959,6 +959,11 @@ static void aspeed_ast2700_scu_reset(DeviceState *dev)
>       s->regs[AST2700_HW_STRAP1] = s->hw_strap1;
>   }
>   
> +static void aspeed_2700_scu_realize(DeviceState *dev, Error **errp)
> +{
> +    aspeed_scu_realize(dev, errp);
> +}
> +
>   static void aspeed_2700_scu_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -966,6 +971,7 @@ static void aspeed_2700_scu_class_init(ObjectClass *klass, const void *data)
>   
>       dc->desc = "ASPEED 2700 System Control Unit";
>       device_class_set_legacy_reset(dc, aspeed_ast2700_scu_reset);
> +    dc->realize = aspeed_2700_scu_realize;
>       asc->resets = ast2700_a0_resets;
>       asc->calc_hpll = aspeed_2600_scu_calc_hpll;
>       asc->get_apb = aspeed_2700_scu_get_apb_freq;
> @@ -1097,7 +1103,7 @@ static void aspeed_2700_scuio_class_init(ObjectClass *klass, const void *data)
>   static const TypeInfo aspeed_2700_scu_info = {
>       .name = TYPE_ASPEED_2700_SCU,
>       .parent = TYPE_ASPEED_SCU,
> -    .instance_size = sizeof(AspeedSCUState),
> +    .instance_size = sizeof(Aspeed2700SCUState),
>       .class_init = aspeed_2700_scu_class_init,
>   };
>   


