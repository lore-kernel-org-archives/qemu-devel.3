Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3111CC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 21:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts6ik-0006Mt-2G; Tue, 11 Mar 2025 17:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ts6id-0006JO-JQ
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 17:00:55 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ts6ia-0001pz-8E
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 17:00:54 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 50EFA4E602A;
 Tue, 11 Mar 2025 22:00:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Dx3ce4hpufI6; Tue, 11 Mar 2025 22:00:43 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 51A924E6035; Tue, 11 Mar 2025 22:00:43 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4FAAF74577C;
 Tue, 11 Mar 2025 22:00:43 +0100 (CET)
Date: Tue, 11 Mar 2025 22:00:43 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Subject: Re: [PULL 14/14] hw/sd/sdhci: Remove need for SDHCI_VENDOR_FSL
 definition
In-Reply-To: <20250311195123.94212-15-philmd@linaro.org>
Message-ID: <2ab1ad9c-457f-5e4c-0428-95a568b8ffa9@eik.bme.hu>
References: <20250311195123.94212-1-philmd@linaro.org>
 <20250311195123.94212-15-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1796300472-1741726843=:46820"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1796300472-1741726843=:46820
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 11 Mar 2025, Philippe Mathieu-Daudé wrote:
> All instances of TYPE_IMX_USDHC set vendor=SDHCI_VENDOR_IMX.
> No need to special-case it.

Typo in subject. It's actually SDHCI_VENDOR_IMX which is removed by this 
patch.

Regards,
BALATON Zoltan

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Bernhard Beschow <shentey@gmail.com>
> Message-Id: <20250308213640.13138-3-philmd@linaro.org>
> ---
> include/hw/sd/sdhci.h |  1 -
> hw/arm/fsl-imx25.c    |  2 --
> hw/arm/fsl-imx6.c     |  2 --
> hw/arm/fsl-imx6ul.c   |  2 --
> hw/arm/fsl-imx7.c     |  2 --
> hw/arm/fsl-imx8mp.c   |  2 --
> hw/sd/sdhci.c         | 14 ++++----------
> 7 files changed, 4 insertions(+), 21 deletions(-)
>
> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> index f722d8eb1cc..51fb30ea528 100644
> --- a/include/hw/sd/sdhci.h
> +++ b/include/hw/sd/sdhci.h
> @@ -109,7 +109,6 @@ struct SDHCIState {
> typedef struct SDHCIState SDHCIState;
>
> #define SDHCI_VENDOR_NONE       0
> -#define SDHCI_VENDOR_IMX        1
> #define SDHCI_VENDOR_FSL        2
>
> /*
> diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
> index 5359a6d8d3b..02214ca1a1c 100644
> --- a/hw/arm/fsl-imx25.c
> +++ b/hw/arm/fsl-imx25.c
> @@ -243,8 +243,6 @@ static void fsl_imx25_realize(DeviceState *dev, Error **errp)
>                                  &error_abort);
>         object_property_set_uint(OBJECT(&s->esdhc[i]), "capareg",
>                                  IMX25_ESDHC_CAPABILITIES, &error_abort);
> -        object_property_set_uint(OBJECT(&s->esdhc[i]), "vendor",
> -                                 SDHCI_VENDOR_IMX, &error_abort);
>         if (!sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), errp)) {
>             return;
>         }
> diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
> index dc86338b3a5..a114dc0d63d 100644
> --- a/hw/arm/fsl-imx6.c
> +++ b/hw/arm/fsl-imx6.c
> @@ -327,8 +327,6 @@ static void fsl_imx6_realize(DeviceState *dev, Error **errp)
>                                  &error_abort);
>         object_property_set_uint(OBJECT(&s->esdhc[i]), "capareg",
>                                  IMX6_ESDHC_CAPABILITIES, &error_abort);
> -        object_property_set_uint(OBJECT(&s->esdhc[i]), "vendor",
> -                                 SDHCI_VENDOR_IMX, &error_abort);
>         if (!sysbus_realize(SYS_BUS_DEVICE(&s->esdhc[i]), errp)) {
>             return;
>         }
> diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
> index 34c4aa15cd0..ce8d3ef535f 100644
> --- a/hw/arm/fsl-imx6ul.c
> +++ b/hw/arm/fsl-imx6ul.c
> @@ -531,8 +531,6 @@ static void fsl_imx6ul_realize(DeviceState *dev, Error **errp)
>             FSL_IMX6UL_USDHC2_IRQ,
>         };
>
> -        object_property_set_uint(OBJECT(&s->usdhc[i]), "vendor",
> -                                 SDHCI_VENDOR_IMX, &error_abort);
>         sysbus_realize(SYS_BUS_DEVICE(&s->usdhc[i]), &error_abort);
>
>         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
> diff --git a/hw/arm/fsl-imx7.c b/hw/arm/fsl-imx7.c
> index 3374018cde0..ed1f10bca26 100644
> --- a/hw/arm/fsl-imx7.c
> +++ b/hw/arm/fsl-imx7.c
> @@ -471,8 +471,6 @@ static void fsl_imx7_realize(DeviceState *dev, Error **errp)
>             FSL_IMX7_USDHC3_IRQ,
>         };
>
> -        object_property_set_uint(OBJECT(&s->usdhc[i]), "vendor",
> -                                 SDHCI_VENDOR_IMX, &error_abort);
>         sysbus_realize(SYS_BUS_DEVICE(&s->usdhc[i]), &error_abort);
>
>         sysbus_mmio_map(SYS_BUS_DEVICE(&s->usdhc[i]), 0,
> diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
> index 1ea98e14635..c3f6da63220 100644
> --- a/hw/arm/fsl-imx8mp.c
> +++ b/hw/arm/fsl-imx8mp.c
> @@ -524,8 +524,6 @@ static void fsl_imx8mp_realize(DeviceState *dev, Error **errp)
>             { fsl_imx8mp_memmap[FSL_IMX8MP_USDHC3].addr, FSL_IMX8MP_USDHC3_IRQ },
>         };
>
> -        object_property_set_uint(OBJECT(&s->usdhc[i]), "vendor",
> -                                 SDHCI_VENDOR_IMX, &error_abort);
>         if (!sysbus_realize(SYS_BUS_DEVICE(&s->usdhc[i]), errp)) {
>             return;
>         }
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index fe87e18d5d2..69baf73ae9b 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1735,16 +1735,10 @@ usdhc_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
>
>     case USDHC_VENDOR_SPEC:
>         s->vendor_spec = value;
> -        switch (s->vendor) {
> -        case SDHCI_VENDOR_IMX:
> -            if (value & USDHC_IMX_FRC_SDCLK_ON) {
> -                s->prnsts &= ~SDHC_IMX_CLOCK_GATE_OFF;
> -            } else {
> -                s->prnsts |= SDHC_IMX_CLOCK_GATE_OFF;
> -            }
> -            break;
> -        default:
> -            break;
> +        if (value & USDHC_IMX_FRC_SDCLK_ON) {
> +            s->prnsts &= ~SDHC_IMX_CLOCK_GATE_OFF;
> +        } else {
> +            s->prnsts |= SDHC_IMX_CLOCK_GATE_OFF;
>         }
>         break;
>
>
--3866299591-1796300472-1741726843=:46820--

