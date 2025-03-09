Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD25C282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 11:05:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trESB-0005ve-Vn; Sun, 09 Mar 2025 07:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1trES2-0005t9-GL; Sun, 09 Mar 2025 07:04:10 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1trERz-0003zs-Tf; Sun, 09 Mar 2025 07:04:09 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C8AAD4E602D;
 Sun, 09 Mar 2025 12:04:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id SPjp-qpcII-D; Sun,  9 Mar 2025 12:04:01 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id CB1C74E6019; Sun, 09 Mar 2025 12:04:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C8A9E74577C;
 Sun, 09 Mar 2025 12:04:01 +0100 (CET)
Date: Sun, 9 Mar 2025 12:04:01 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, 
 Bernhard Beschow <shentey@gmail.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Guenter Roeck <linux@roeck-us.net>, qemu-block@nongnu.org, 
 Bin Meng <bmeng.cn@gmail.com>, qemu-arm@nongnu.org
Subject: Re: [PATCH v4 13/14] hw/sd/sdhci: Implement Freescale eSDHC as
 TYPE_FSL_ESDHC
In-Reply-To: <20250308213640.13138-14-philmd@linaro.org>
Message-ID: <9eb8f1a0-75c0-526a-869c-53d01551c97b@eik.bme.hu>
References: <20250308213640.13138-1-philmd@linaro.org>
 <20250308213640.13138-14-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-716216210-1741518241=:9805"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--3866299591-716216210-1741518241=:9805
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 8 Mar 2025, Philippe Mathieu-Daudé wrote:
> Per the MPC8569E reference manual, its SDHC I/O range is 4KiB
> wide, mapped in big endian order, and it only accepts 32-bit
> aligned access. Set the default register reset values.
>
> Reported-by: BALATON Zoltan <balaton@eik.bme.hu>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> include/hw/sd/sdhci.h |  2 ++
> hw/sd/sdhci.c         | 37 ++++++++++++++++++++++++++++++++++++-
> 2 files changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> index eb8380187b5..966a1751f50 100644
> --- a/include/hw/sd/sdhci.h
> +++ b/include/hw/sd/sdhci.h
> @@ -162,6 +162,8 @@ DECLARE_INSTANCE_CHECKER(SDHCIState, SYSBUS_SDHCI,
> DECLARE_CLASS_CHECKERS(SDHCIClass, SYSBUS_SDHCI,
>                        TYPE_SYSBUS_SDHCI)
>
> +#define TYPE_FSL_ESDHC "fsl-esdhc"
> +
> #define TYPE_IMX_USDHC "imx-usdhc"
>
> #define TYPE_S3C_SDHCI "s3c-sdhci"
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 234a6e4a1fe..d5cc0bf1458 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1653,7 +1653,37 @@ static void sdhci_bus_class_init(ObjectClass *klass, void *data)
>     sbc->set_readonly = sdhci_set_readonly;
> }
>
> -/* --- qdev i.MX eSDHC --- */
> +/* --- Freescale eSDHC (MPC8569ERM Rev.2 from 06/2011) --- */
> +
> +static const MemoryRegionOps fsl_esdhc_mmio_ops = {
> +    .read = sdhci_read,
> +    .write = sdhci_write,
> +    .valid = {
> +        .min_access_size = 4,

Does this need max access too? Maybe it could work with 8 and likely 
nothing would try to access more than 4 so probably does not matter.

Regards,
BALATON Zoltan

> +        .unaligned = false
> +    },
> +    .endianness = DEVICE_BIG_ENDIAN,
> +};
> +
> +static void fsl_esdhc_class_init(ObjectClass *oc, void *data)
> +{
> +    SDHCIClass *sc = SYSBUS_SDHCI_CLASS(oc);
> +
> +    sc->iomem_size = 0x1000;
> +    sc->io_ops = &fsl_esdhc_mmio_ops;
> +    sc->ro.capareg = 0x01e30000;
> +    sc->reset.sdmasysad = 8;
> +    sc->reset.blkcnt = 8;
> +    sc->reset.prnsts = 0xff800000;
> +    sc->reset.hostctl1 = 0x20; /* Endian mode (address-invariant) */
> +    sc->reset.clkcon = 0x8000;
> +    sc->reset.norintstsen = 0x013f;
> +    sc->reset.errintstsen = 0x117f;
> +
> +    sdhci_common_class_init(oc, data);
> +}
> +
> +/* --- qdev i.MX uSDHC --- */
>
> #define USDHC_MIX_CTRL                  0x48
>
> @@ -1983,6 +2013,11 @@ static const TypeInfo sdhci_types[] = {
>         .class_size = sizeof(SDHCIClass),
>         .class_init = sdhci_sysbus_class_init,
>     },
> +    {
> +        .name = TYPE_FSL_ESDHC,
> +        .parent = TYPE_SYSBUS_SDHCI,
> +        .class_init = fsl_esdhc_class_init,
> +    },
>     {
>         .name = TYPE_IMX_USDHC,
>         .parent = TYPE_SYSBUS_SDHCI,
>
--3866299591-716216210-1741518241=:9805--

