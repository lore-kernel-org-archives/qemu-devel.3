Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0CBC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 13:51:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trdWw-0007sb-7L; Mon, 10 Mar 2025 09:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1trdWp-0007r4-2e; Mon, 10 Mar 2025 09:50:47 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1trdWm-0002BI-N1; Mon, 10 Mar 2025 09:50:46 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 28C314E6030;
 Mon, 10 Mar 2025 14:50:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Amo_kyIDHFmI; Mon, 10 Mar 2025 14:50:38 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 29CAE4E602E; Mon, 10 Mar 2025 14:50:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 271C074577C;
 Mon, 10 Mar 2025 14:50:38 +0100 (CET)
Date: Mon, 10 Mar 2025 14:50:38 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: qemu-devel@nongnu.org, Steven Lee <steven_lee@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, Bernhard Beschow <shentey@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Bin Meng <bmeng.cn@gmail.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Troy Lee <leetroy@gmail.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-block@nongnu.org, 
 Jamin Lin <jamin_lin@aspeedtech.com>
Subject: Re: [PATCH v5 09/14] hw/sd/sdhci: Allow SDHCI classes to register
 their own MemoryRegionOps
In-Reply-To: <20250310000620.70120-10-philmd@linaro.org>
Message-ID: <962d917a-d583-38a4-6338-3c0c1cb096a3@eik.bme.hu>
References: <20250310000620.70120-1-philmd@linaro.org>
 <20250310000620.70120-10-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1660091918-1741614638=:72286"
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1660091918-1741614638=:72286
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 10 Mar 2025, Philippe Mathieu-Daudé wrote:
> Add MemoryRegionOps as a class property. For now it is only
> used by TYPE_IMX_USDHC.
> Otherwise the default remains in little endian.

I still don't see why you need to do this via the class and not just set 
it init or realize as it's done already but it should work so

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> include/hw/sd/sdhci.h |  1 +
> hw/sd/sdhci.c         | 22 ++++++++--------------
> 2 files changed, 9 insertions(+), 14 deletions(-)
>
> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> index dfa0c214036..108bc1993c6 100644
> --- a/include/hw/sd/sdhci.h
> +++ b/include/hw/sd/sdhci.h
> @@ -117,6 +117,7 @@ struct SDHCIClass {
>         SysBusDeviceClass sbd_parent_class;
>     };
>
> +    const MemoryRegionOps *io_ops;
>     uint32_t quirks;
>     uint64_t iomem_size;
> };
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 3467385490d..6868bf68285 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1428,8 +1428,6 @@ void sdhci_initfn(SDHCIState *s)
>     s->transfer_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
>                                      sdhci_data_transfer, s);
>     s->quirks = s->sc->quirks;
> -
> -    s->io_ops = &sdhci_mmio_le_ops;
> }
>
> void sdhci_uninitfn(SDHCIState *s)
> @@ -1447,6 +1445,7 @@ void sdhci_common_realize(SDHCIState *s, Error **errp)
>     SDHCIClass *sc = s->sc;
>     const char *class_name = object_get_typename(OBJECT(s));
>
> +    s->io_ops = sc->io_ops ?: &sdhci_mmio_le_ops;
>     switch (s->endianness) {
>     case DEVICE_LITTLE_ENDIAN:
>         /* s->io_ops is little endian by default */
> @@ -1890,17 +1889,11 @@ static const MemoryRegionOps usdhc_mmio_ops = {
>     .endianness = DEVICE_LITTLE_ENDIAN,
> };
>
> -static void imx_usdhc_init(Object *obj)
> -{
> -    SDHCIState *s = SYSBUS_SDHCI(obj);
> -
> -    s->io_ops = &usdhc_mmio_ops;
> -}
> -
> static void imx_usdhc_class_init(ObjectClass *oc, void *data)
> {
>     SDHCIClass *sc = SYSBUS_SDHCI_CLASS(oc);
>
> +    sc->io_ops = &usdhc_mmio_ops;
>     sc->quirks = BIT(SDHCI_QUIRK_NO_BUSY_IRQ);
>
>     sdhci_common_class_init(oc, data);
> @@ -1957,11 +1950,13 @@ static const MemoryRegionOps sdhci_s3c_mmio_ops = {
>     .endianness = DEVICE_LITTLE_ENDIAN,
> };
>
> -static void sdhci_s3c_init(Object *obj)
> +static void sdhci_s3c_class_init(ObjectClass *oc, void *data)
> {
> -    SDHCIState *s = SYSBUS_SDHCI(obj);
> +    SDHCIClass *sc = SYSBUS_SDHCI_CLASS(oc);
>
> -    s->io_ops = &sdhci_s3c_mmio_ops;
> +    sc->io_ops = &sdhci_s3c_mmio_ops;
> +
> +    sdhci_common_class_init(oc, data);
> }
>
> static const TypeInfo sdhci_types[] = {
> @@ -1983,13 +1978,12 @@ static const TypeInfo sdhci_types[] = {
>     {
>         .name = TYPE_IMX_USDHC,
>         .parent = TYPE_SYSBUS_SDHCI,
> -        .instance_init = imx_usdhc_init,
>         .class_init = imx_usdhc_class_init,
>     },
>     {
>         .name = TYPE_S3C_SDHCI,
>         .parent = TYPE_SYSBUS_SDHCI,
> -        .instance_init = sdhci_s3c_init,
> +        .class_init = sdhci_s3c_class_init,
>     },
> };
>
>
--3866299591-1660091918-1741614638=:72286--

