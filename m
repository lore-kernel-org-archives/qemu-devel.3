Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF4BD3B981
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT0Mv-000120-Kc; Tue, 09 Dec 2025 11:15:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vT0Mu-00011e-F8
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:15:16 -0500
Received: from 8.mo552.mail-out.ovh.net ([46.105.37.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1vT0Mr-0007VA-KF
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:15:16 -0500
Received: from mxplan5.mail.ovh.net (unknown [10.109.254.250])
 by mo552.mail-out.ovh.net (Postfix) with ESMTPS id 4dQkTQ6c7sz5yc1;
 Tue,  9 Dec 2025 16:15:06 +0000 (UTC)
Received: from kaod.org (37.59.142.109) by DAG8EX2.mxp5.local (172.16.2.72)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.61; Tue, 9 Dec
 2025 17:15:05 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S00310aea4e4-a608-4656-bbb4-c462ec044590,
 913B1D19E2E265D49699B36B6A33E6F0AA87D788) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <9a5fe690-92f7-4745-995d-01c93cefeef9@kaod.org>
Date: Tue, 9 Dec 2025 17:15:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] hw/arm/aspeed_soc: Update Aspeed SoC to support
 two SGPIO controllers
To: Yubin Zou <yubinz@google.com>, <qemu-devel@nongnu.org>
CC: Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kane-Chen-AS <kane_chen@aspeedtech.com>, Nabih Estefan
 <nabihestefan@google.com>, <qemu-arm@nongnu.org>
References: <20251209-aspeed-sgpio-v2-0-976e5f5790c2@google.com>
 <20251209-aspeed-sgpio-v2-4-976e5f5790c2@google.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20251209-aspeed-sgpio-v2-4-976e5f5790c2@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [37.59.142.109]
X-ClientProxiedBy: DAG4EX1.mxp5.local (172.16.2.31) To DAG8EX2.mxp5.local
 (172.16.2.72)
X-Ovh-Tracer-GUID: 69a87645-1901-4012-bdba-d7476b68769b
X-Ovh-Tracer-Id: 5407134303060462398
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGAftZX6bcPL4SdPjHFTEep9w2tikCRPTmCURqZN5v7wxypUU4Ja94v7xggxJmBe3q8KHRhxhNbRJTBDPGXPNVEH9ygbLAqPq4VIpf/OXheVB8KOoqr3Uct96q83dmPuUDL70uIKf9Ui7GwMcdzRKNP6YuK12VVCN9VQbiJtdGvicdrNc77mFRS0rTpop9bgAFWLfbBlAvbiKlK0y7XgxzGT6MMcq0UywNlgX6RKLDOUc17ynUvCpEjkE2/wg4tr3oQJppTPcygJ/kyN1t6fgyk3IDRrUKn3wPnezFO4yn5vuYBHOcWYH3q6PLPV9GuV8/cO+sD1NcyMtGktiOATqhNWOQK1gxep9igDixSkpGHNH2lPoQmVCP26VitxVhy0/k7ELnoGrMVNiwL1p95NEz9UxCl5oy8L34FSRY1wfm+XVndV4k74ISEro4YHLnTa61Aij1J3SKCxYhcxSamsQLkcSYP3VZ9ujJlnjUS+iESiHgS7zHp6z26x6ai6fnEzpZDpa+JFuGauPkuvBoVUcy06URSFyA2IYOr4sESnqN2OjH4o0RtoafxEE+B/SFsj7+7uirrQXGiDA1V3j9Fmt2QcnCF/51Mb6nc9aRXWmDYcqjgjVQpyn2Dk7R20y/+K88pM2ng3hBYd9OIZnW70/MAotzZ/KVJxoFGGQzksLuKAw
DKIM-Signature: a=rsa-sha256; bh=z6pJTSRplVAVGj0HdZusgU1Ys5KcKKt8y0RyGGzrjIw=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1765296909; v=1;
 b=LV5Votpo1edui2nu5DkgTd9v5quB+NbLaI83yfoAIINhykKeQByps55IwDtBszsq9y3s8gh4
 4nQLfP9Ayp2CTbUWLkHYtr3XnGh/OgtkWvqCZt+/wlPAK63hpqi+9YQSuiAuScituU01NUyw0ZQ
 uYm2yTeJ1iWiI4W2N06yIE/FZ/Ezq/HZoZj3Uxa0zEd8dkNc9WzTW1CGJnXmgESMVi0LcyDcWij
 ROJGG92xhWshGD0RpTgjhngAF46wym4yAnj7jMPsYNYJo4y5tl0YS7npevLFAxgYdgdwYuReGU1
 n/BvdjuZwGFbELwSM/nCRquwpXYCegD4T6GzyuSU2ERtg==
Received-SPF: pass client-ip=46.105.37.156; envelope-from=clg@kaod.org;
 helo=8.mo552.mail-out.ovh.net
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

On 12/9/25 01:01, Yubin Zou wrote:
> This commit updates the Aspeed SoC model to support two SGPIO
> controllers, reflecting the hardware capabilities of the AST2700
> 
> The memory map and interrupt map are updated to include entries for
> two SGPIO controllers (SGPIOM0 and SGPIOM1). This change is a
> prerequisite for the full implementation of the SGPIO device model.
> 
> Signed-off-by: Yubin Zou <yubinz@google.com>

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/arm/aspeed_ast10x0.c     |  6 +++---
>   hw/arm/aspeed_ast27x0.c     | 10 ++++++++++
>   include/hw/arm/aspeed_soc.h |  8 ++++++--
>   3 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/arm/aspeed_ast10x0.c b/hw/arm/aspeed_ast10x0.c
> index 7f49c13391be0b923e317409a0fccfa741f5e658..c141cc080422579ca6b6965369d84dfbe416247b 100644
> --- a/hw/arm/aspeed_ast10x0.c
> +++ b/hw/arm/aspeed_ast10x0.c
> @@ -36,7 +36,7 @@ static const hwaddr aspeed_soc_ast1030_memmap[] = {
>       [ASPEED_DEV_ESPI]      = 0x7E6EE000,
>       [ASPEED_DEV_SBC]       = 0x7E6F2000,
>       [ASPEED_DEV_GPIO]      = 0x7E780000,
> -    [ASPEED_DEV_SGPIOM]    = 0x7E780500,
> +    [ASPEED_DEV_SGPIOM0]   = 0x7E780500,
>       [ASPEED_DEV_TIMER1]    = 0x7E782000,
>       [ASPEED_DEV_UART1]     = 0x7E783000,
>       [ASPEED_DEV_UART2]     = 0x7E78D000,
> @@ -94,7 +94,7 @@ static const int aspeed_soc_ast1030_irqmap[] = {
>       [ASPEED_DEV_I2C]       = 110, /* 110 ~ 123 */
>       [ASPEED_DEV_KCS]       = 138, /* 138 -> 142 */
>       [ASPEED_DEV_UDC]       = 9,
> -    [ASPEED_DEV_SGPIOM]    = 51,
> +    [ASPEED_DEV_SGPIOM0]   = 51,
>       [ASPEED_DEV_JTAG0]     = 27,
>       [ASPEED_DEV_JTAG1]     = 53,
>   };
> @@ -427,7 +427,7 @@ static void aspeed_soc_ast1030_realize(DeviceState *dev_soc, Error **errp)
>                                     sc->memmap[ASPEED_DEV_UDC], 0x1000);
>       aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->sgpiom),
>                                     "aspeed.sgpiom",
> -                                  sc->memmap[ASPEED_DEV_SGPIOM], 0x100);
> +                                  sc->memmap[ASPEED_DEV_SGPIOM0], 0x100);
>   
>       aspeed_mmio_map_unimplemented(s->memory, SYS_BUS_DEVICE(&s->jtag[0]),
>                                     "aspeed.jtag",
> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
> index c484bcd4e22fb49faf9c16992ae2cdfd6cd82da4..e5f04bd16e80696e41005d9062a6df6d060b8088 100644
> --- a/hw/arm/aspeed_ast27x0.c
> +++ b/hw/arm/aspeed_ast27x0.c
> @@ -69,6 +69,8 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
>       [ASPEED_DEV_ADC]       =  0x14C00000,
>       [ASPEED_DEV_SCUIO]     =  0x14C02000,
>       [ASPEED_DEV_GPIO]      =  0x14C0B000,
> +    [ASPEED_DEV_SGPIOM0]   =  0x14C0C000,
> +    [ASPEED_DEV_SGPIOM1]   =  0x14C0D000,
>       [ASPEED_DEV_I2C]       =  0x14C0F000,
>       [ASPEED_DEV_INTCIO]    =  0x14C18000,
>       [ASPEED_DEV_PCIE_PHY2] =  0x14C1C000,
> @@ -122,6 +124,8 @@ static const int aspeed_soc_ast2700a0_irqmap[] = {
>       [ASPEED_DEV_KCS]       = 128,
>       [ASPEED_DEV_ADC]       = 130,
>       [ASPEED_DEV_GPIO]      = 130,
> +    [ASPEED_DEV_SGPIOM0]   = 130,
> +    [ASPEED_DEV_SGPIOM1]   = 130,
>       [ASPEED_DEV_I2C]       = 130,
>       [ASPEED_DEV_FMC]       = 131,
>       [ASPEED_DEV_WDT]       = 131,
> @@ -173,6 +177,8 @@ static const int aspeed_soc_ast2700a1_irqmap[] = {
>       [ASPEED_DEV_I2C]       = 194,
>       [ASPEED_DEV_ADC]       = 194,
>       [ASPEED_DEV_GPIO]      = 194,
> +    [ASPEED_DEV_SGPIOM0]   = 194,
> +    [ASPEED_DEV_SGPIOM1]   = 194,
>       [ASPEED_DEV_FMC]       = 195,
>       [ASPEED_DEV_WDT]       = 195,
>       [ASPEED_DEV_PWM]       = 195,
> @@ -214,6 +220,8 @@ static const int ast2700_gic130_gic194_intcmap[] = {
>       [ASPEED_DEV_I2C]        = 0,
>       [ASPEED_DEV_ADC]        = 16,
>       [ASPEED_DEV_GPIO]       = 18,
> +    [ASPEED_DEV_SGPIOM0]    = 21,
> +    [ASPEED_DEV_SGPIOM1]    = 24,
>   };
>   
>   /* GICINT 131 */
> @@ -1061,6 +1069,7 @@ static void aspeed_soc_ast2700a0_class_init(ObjectClass *oc, const void *data)
>       sc->sram_size    = 0x20000;
>       sc->pcie_num     = 0;
>       sc->spis_num     = 3;
> +    sc->sgpio_num    = 2;
>       sc->ehcis_num    = 2;
>       sc->wdts_num     = 8;
>       sc->macs_num     = 1;
> @@ -1089,6 +1098,7 @@ static void aspeed_soc_ast2700a1_class_init(ObjectClass *oc, const void *data)
>       sc->sram_size    = 0x20000;
>       sc->pcie_num     = 3;
>       sc->spis_num     = 3;
> +    sc->sgpio_num    = 2;
>       sc->ehcis_num    = 4;
>       sc->wdts_num     = 8;
>       sc->macs_num     = 3;
> diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
> index 4b8e599f1a53bfb2e4d3196d5495cd316f799354..18ff961a38508c5df83b46e187f732d736443f20 100644
> --- a/include/hw/arm/aspeed_soc.h
> +++ b/include/hw/arm/aspeed_soc.h
> @@ -32,6 +32,7 @@
>   #include "hw/net/ftgmac100.h"
>   #include "target/arm/cpu.h"
>   #include "hw/gpio/aspeed_gpio.h"
> +#include "hw/gpio/aspeed_sgpio.h"
>   #include "hw/sd/aspeed_sdhci.h"
>   #include "hw/usb/hcd-ehci.h"
>   #include "qom/object.h"
> @@ -46,6 +47,7 @@
>   #define VBOOTROM_FILE_NAME  "ast27x0_bootrom.bin"
>   
>   #define ASPEED_SPIS_NUM  3
> +#define ASPEED_SGPIO_NUM 2
>   #define ASPEED_EHCIS_NUM 4
>   #define ASPEED_WDTS_NUM  8
>   #define ASPEED_CPUS_NUM  4
> @@ -89,6 +91,7 @@ struct AspeedSoCState {
>       AspeedMiiState mii[ASPEED_MACS_NUM];
>       AspeedGPIOState gpio;
>       AspeedGPIOState gpio_1_8v;
> +    AspeedSGPIOState sgpiom[ASPEED_SGPIO_NUM];
>       AspeedSDHCIState sdhci;
>       AspeedSDHCIState emmc;
>       AspeedLPCState lpc;
> @@ -106,7 +109,6 @@ struct AspeedSoCState {
>       UnimplementedDeviceState pwm;
>       UnimplementedDeviceState espi;
>       UnimplementedDeviceState udc;
> -    UnimplementedDeviceState sgpiom;
>       UnimplementedDeviceState ltpi;
>       UnimplementedDeviceState jtag[ASPEED_JTAG_NUM];
>       AspeedAPB2OPBState fsi[2];
> @@ -166,6 +168,7 @@ struct AspeedSoCClass {
>       uint64_t secsram_size;
>       int pcie_num;
>       int spis_num;
> +    int sgpio_num;
>       int ehcis_num;
>       int wdts_num;
>       int macs_num;
> @@ -221,6 +224,8 @@ enum {
>       ASPEED_DEV_SDHCI,
>       ASPEED_DEV_GPIO,
>       ASPEED_DEV_GPIO_1_8V,
> +    ASPEED_DEV_SGPIOM0,
> +    ASPEED_DEV_SGPIOM1,
>       ASPEED_DEV_RTC,
>       ASPEED_DEV_TIMER1,
>       ASPEED_DEV_TIMER2,
> @@ -263,7 +268,6 @@ enum {
>       ASPEED_DEV_I3C,
>       ASPEED_DEV_ESPI,
>       ASPEED_DEV_UDC,
> -    ASPEED_DEV_SGPIOM,
>       ASPEED_DEV_JTAG0,
>       ASPEED_DEV_JTAG1,
>       ASPEED_DEV_FSI1,
> 


