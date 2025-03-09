Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46566C282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 11:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trF4Z-0002RT-JD; Sun, 09 Mar 2025 07:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1trF4N-0002Pa-EC; Sun, 09 Mar 2025 07:43:49 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1trF4L-0007vw-Bk; Sun, 09 Mar 2025 07:43:47 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 008444E602D;
 Sun, 09 Mar 2025 12:43:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Pzo-O9mLZXiy; Sun,  9 Mar 2025 12:43:39 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id EB9834E6019; Sun, 09 Mar 2025 12:43:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E604A74577C;
 Sun, 09 Mar 2025 12:43:38 +0100 (CET)
Date: Sun, 9 Mar 2025 12:43:38 +0100 (CET)
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
Subject: Re: [PATCH v4 04/14] hw/sd/sdhci: Make quirks a class property
In-Reply-To: <20250308213640.13138-5-philmd@linaro.org>
Message-ID: <11b37245-5dee-122b-cdfb-dfc820a38661@eik.bme.hu>
References: <20250308213640.13138-1-philmd@linaro.org>
 <20250308213640.13138-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3866299591-103569848-1741520618=:9805"
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

--3866299591-103569848-1741520618=:9805
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Sat, 8 Mar 2025, Philippe Mathieu-Daudé wrote:
> All TYPE_IMX_USDHC instances use the quirk:
> move it to the class layer.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> include/hw/sd/sdhci.h |  3 ++-
> hw/sd/sdhci.c         | 15 +++++++++++++--
> 2 files changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> index c4b20db3877..0616ce3aa59 100644
> --- a/include/hw/sd/sdhci.h
> +++ b/include/hw/sd/sdhci.h
> @@ -95,7 +95,6 @@ struct SDHCIState {
>
>     /* Configurable properties */
>     bool pending_insert_quirk; /* Quirk for Raspberry Pi card insert int */
> -    uint32_t quirks;
>     uint8_t endianness;
>     uint8_t sd_spec_version;
>     uint8_t uhs_mode;
> @@ -112,6 +111,8 @@ typedef struct SDHCIClass {
>         PCIDeviceClass pci_parent_class;
>         SysBusDeviceClass sbd_parent_class;
>     };
> +
> +    uint32_t quirks;
> } SDHCIClass;
>
> /*
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 4917a9b3632..2b7eb11a14a 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -345,6 +345,8 @@ static void sdhci_send_command(SDHCIState *s)
>     rlen = sdbus_do_command(&s->sdbus, &request, response);
>
>     if (s->cmdreg & SDHC_CMD_RESPONSE) {
> +        SDHCIClass *sc = SYSBUS_SDHCI_GET_CLASS(s);

I don't like this because it introduces a class look up which may be 
costly in a function that could be called frequently. Maybe you could just 
drop this patch and leave the quirk handling as it is. Changing it does 
not seem to improve the model much.

Regards,
BALATON Zoltan

> +
>         if (rlen == 4) {
>             s->rspreg[0] = ldl_be_p(response);
>             s->rspreg[1] = s->rspreg[2] = s->rspreg[3] = 0;
> @@ -366,7 +368,7 @@ static void sdhci_send_command(SDHCIState *s)
>             }
>         }
>
> -        if (!(s->quirks & SDHCI_QUIRK_NO_BUSY_IRQ) &&
> +        if (!(sc->quirks & SDHCI_QUIRK_NO_BUSY_IRQ) &&
>             (s->norintstsen & SDHC_NISEN_TRSCMP) &&
>             (s->cmdreg & SDHC_CMD_RESPONSE) == SDHC_CMD_RSP_WITH_BUSY) {
>             s->norintsts |= SDHC_NIS_TRSCMP;
> @@ -1886,7 +1888,15 @@ static void imx_usdhc_init(Object *obj)
>     SDHCIState *s = SYSBUS_SDHCI(obj);
>
>     s->io_ops = &usdhc_mmio_ops;
> -    s->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
> +}
> +
> +static void imx_usdhc_class_init(ObjectClass *oc, void *data)
> +{
> +    SDHCIClass *sc = SYSBUS_SDHCI_CLASS(oc);
> +
> +    sc->quirks = SDHCI_QUIRK_NO_BUSY_IRQ;
> +
> +    sdhci_common_class_init(oc, data);
> }
>
> /* --- qdev Samsung s3c --- */
> @@ -1967,6 +1977,7 @@ static const TypeInfo sdhci_types[] = {
>         .name = TYPE_IMX_USDHC,
>         .parent = TYPE_SYSBUS_SDHCI,
>         .instance_init = imx_usdhc_init,
> +        .class_init = imx_usdhc_class_init,
>     },
>     {
>         .name = TYPE_S3C_SDHCI,
>
--3866299591-103569848-1741520618=:9805--

