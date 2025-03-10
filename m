Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4DA6C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 13:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trdMG-0005iK-KJ; Mon, 10 Mar 2025 09:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1trdLu-0004za-6q; Mon, 10 Mar 2025 09:39:30 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1trdLs-0008CZ-7v; Mon, 10 Mar 2025 09:39:29 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0517E4E6030;
 Mon, 10 Mar 2025 14:39:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 97p4AlsmDV-y; Mon, 10 Mar 2025 14:39:22 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0D5944E6029; Mon, 10 Mar 2025 14:39:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0A87F74577C;
 Mon, 10 Mar 2025 14:39:22 +0100 (CET)
Date: Mon, 10 Mar 2025 14:39:22 +0100 (CET)
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
Subject: Re: [PATCH v5 05/14] hw/sd/sdhci: Include 'pending-insert-quirk'
 property in quirk bitmask
In-Reply-To: <20250310000620.70120-6-philmd@linaro.org>
Message-ID: <6eefe61e-d663-16cb-3cbb-8450f7ddfdd9@eik.bme.hu>
References: <20250310000620.70120-1-philmd@linaro.org>
 <20250310000620.70120-6-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1284192835-1741613962=:72286"
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

--3866299591-1284192835-1741613962=:72286
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 10 Mar 2025, Philippe Mathieu-Daudé wrote:
> Import Linux's SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET quirk definition.
>
> Replace 'pending_insert_quirk' boolean (originally introduce in commit
> 0a7ac9f9e72 "sdhci: quirk property for card insert interrupt status
> on Raspberry Pi") by a bit in quirk bitmask.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> include/hw/sd/sdhci.h | 5 ++++-
> hw/sd/sdhci.c         | 8 ++++----
> 2 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> index d2e4f0f0050..2e6e719df7b 100644
> --- a/include/hw/sd/sdhci.h
> +++ b/include/hw/sd/sdhci.h
> @@ -34,6 +34,8 @@
>  * SD/MMC host controller state
>  *
>  * QEMU interface:
> + *  + QOM property "pending-insert-quirk" re-enables pending "card inserted"
> + *    IRQ after reset (used by the Raspberry Pi controllers).
>  *  + QOM property "wp-inverted-quirk" inverts the Write Protect pin
>  *    polarity (by default the polarity is active low for detecting SD
>  *    card to be protected).
> @@ -101,7 +103,6 @@ struct SDHCIState {
>     /* RO Host Controller Version Register always reads as 0x2401 */
>
>     /* Configurable properties */
> -    bool pending_insert_quirk; /* Quirk for Raspberry Pi card insert int */
>     uint32_t quirks;
>     uint8_t endianness;
>     uint8_t sd_spec_version;
> @@ -118,6 +119,8 @@ enum {
>     SDHCI_QUIRK_NO_BUSY_IRQ                     = 14,
>     /* Controller reports inverted write-protect state */
>     SDHCI_QUIRK_INVERTED_WRITE_PROTECT          = 16,
> +    /* Controller losing signal/interrupt enable states after reset */
> +    SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET        = 19,
> };
>
> #define TYPE_PCI_SDHCI "sdhci-pci"
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 19c600d5bfc..d1b1b187874 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -320,7 +320,7 @@ static void sdhci_poweron_reset(DeviceState *dev)
>
>     sdhci_reset(s);
>
> -    if (s->pending_insert_quirk) {
> +    if (s->quirks & BIT(SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET)) {
>         s->pending_insert_state = true;
>     }
> }
> @@ -1307,7 +1307,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
>          * appears when first enabled after power on
>          */
>         if ((s->norintstsen & SDHC_NISEN_INSERT) && s->pending_insert_state) {
> -            assert(s->pending_insert_quirk);
> +            assert(s->quirks & BIT(SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET));
>             s->norintsts |= SDHC_NIS_INSERT;
>             s->pending_insert_state = false;
>         }
> @@ -1557,8 +1557,8 @@ static const Property sdhci_sysbus_properties[] = {
>     DEFINE_SDHCI_COMMON_PROPERTIES(SDHCIState),
>     DEFINE_PROP_BIT("wp-inverted-quirk", SDHCIState, quirks,
>                     SDHCI_QUIRK_INVERTED_WRITE_PROTECT, false),
> -    DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_quirk,
> -                     false),
> +    DEFINE_PROP_BIT("pending-insert-quirk", SDHCIState, quirks,
> +                    SDHCI_QUIRK_RESTORE_IRQS_AFTER_RESET, false),

Now I see why you need bit defines instead of mask value. Other comments 
about renaming and adjusting comment still apply. I'm not sure if adding 
and enum for bit numbers and keeping the defines for the QUIRK to avoid 
mistake of forgetting BIT at usage might be better. Otherwise this looks 
good.

Regards,
BALATON Zoltan

>     DEFINE_PROP_LINK("dma", SDHCIState,
>                      dma_mr, TYPE_MEMORY_REGION, MemoryRegion *),
> };
>
--3866299591-1284192835-1741613962=:72286--

