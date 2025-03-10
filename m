Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC7FC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 13:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trdIt-0001iA-NP; Mon, 10 Mar 2025 09:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1trdIp-0001go-NZ; Mon, 10 Mar 2025 09:36:19 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1trdIn-0007w0-1G; Mon, 10 Mar 2025 09:36:19 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7EBCD4E6032;
 Mon, 10 Mar 2025 14:36:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 3jK-PwBdSr9O; Mon, 10 Mar 2025 14:36:11 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8991B4E6029; Mon, 10 Mar 2025 14:36:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8707174577C;
 Mon, 10 Mar 2025 14:36:11 +0100 (CET)
Date: Mon, 10 Mar 2025 14:36:11 +0100 (CET)
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
Subject: Re: [PATCH v5 04/14] hw/sd/sdhci: Include 'wp-inverted' property in
 quirk bitmask
In-Reply-To: <20250310000620.70120-5-philmd@linaro.org>
Message-ID: <74401f6a-c081-b521-fa3a-f4abb0e67df7@eik.bme.hu>
References: <20250310000620.70120-1-philmd@linaro.org>
 <20250310000620.70120-5-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1502737573-1741613771=:72286"
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

--3866299591-1502737573-1741613771=:72286
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Mon, 10 Mar 2025, Philippe Mathieu-Daudé wrote:
> Import Linux's SDHCI_QUIRK_INVERTED_WRITE_PROTECT quirk definition.
>
> Replace 'wp_inverted' boolean by a bit in quirk bitmask.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> include/hw/sd/sdhci.h | 16 ++++++++++------
> hw/arm/aspeed.c       |  2 +-
> hw/sd/sdhci.c         |  6 +++---
> 3 files changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> index 096d607f4b7..d2e4f0f0050 100644
> --- a/include/hw/sd/sdhci.h
> +++ b/include/hw/sd/sdhci.h
> @@ -30,7 +30,14 @@
> #include "hw/sd/sd.h"
> #include "qom/object.h"
>
> -/* SD/MMC host controller state */
> +/*
> + * SD/MMC host controller state
> + *
> + * QEMU interface:
> + *  + QOM property "wp-inverted-quirk" inverts the Write Protect pin
> + *    polarity (by default the polarity is active low for detecting SD
> + *    card to be protected).
> + */
> struct SDHCIState {
>     /*< private >*/
>     union {
> @@ -99,11 +106,6 @@ struct SDHCIState {
>     uint8_t endianness;
>     uint8_t sd_spec_version;
>     uint8_t uhs_mode;
> -    /*
> -     * Write Protect pin default active low for detecting SD card
> -     * to be protected. Set wp_inverted to invert the signal.
> -     */
> -    bool wp_inverted;
> };
> typedef struct SDHCIState SDHCIState;
>
> @@ -114,6 +116,8 @@ typedef struct SDHCIState SDHCIState;

Now that we have two adjust comment above here to say "These defines"

> enum {
>     /* Controller does not provide transfer-complete interrupt when not busy. */
>     SDHCI_QUIRK_NO_BUSY_IRQ                     = 14,
> +    /* Controller reports inverted write-protect state */
> +    SDHCI_QUIRK_INVERTED_WRITE_PROTECT          = 16,
> };

and I'd say keep this defines that also matches what Linux has.

> #define TYPE_PCI_SDHCI "sdhci-pci"
> diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
> index 98bf071139b..daee2376d50 100644
> --- a/hw/arm/aspeed.c
> +++ b/hw/arm/aspeed.c
> @@ -412,7 +412,7 @@ static void aspeed_machine_init(MachineState *machine)
>     if (amc->sdhci_wp_inverted) {
>         for (i = 0; i < bmc->soc->sdhci.num_slots; i++) {
>             object_property_set_bool(OBJECT(&bmc->soc->sdhci.slots[i]),
> -                                     "wp-inverted", true, &error_abort);
> +                                     "wp-inverted-quirk", true, &error_abort);

Why rename it? That would break command lines that use this.

Regards,
BALATON Zoltan

>         }
>     }
>     if (machine->kernel_filename) {
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 1dc942a0e06..19c600d5bfc 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -274,7 +274,7 @@ static void sdhci_set_readonly(DeviceState *dev, bool level)
> {
>     SDHCIState *s = (SDHCIState *)dev;
>
> -    if (s->wp_inverted) {
> +    if (s->quirks & BIT(SDHCI_QUIRK_INVERTED_WRITE_PROTECT)) {
>         level = !level;
>     }
>
> @@ -1555,12 +1555,12 @@ void sdhci_common_class_init(ObjectClass *klass, const void *data)
>
> static const Property sdhci_sysbus_properties[] = {
>     DEFINE_SDHCI_COMMON_PROPERTIES(SDHCIState),
> +    DEFINE_PROP_BIT("wp-inverted-quirk", SDHCIState, quirks,
> +                    SDHCI_QUIRK_INVERTED_WRITE_PROTECT, false),
>     DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_quirk,
>                      false),
>     DEFINE_PROP_LINK("dma", SDHCIState,
>                      dma_mr, TYPE_MEMORY_REGION, MemoryRegion *),
> -    DEFINE_PROP_BOOL("wp-inverted", SDHCIState,
> -                     wp_inverted, false),
> };
>
> static void sdhci_sysbus_init(Object *obj)
>
--3866299591-1502737573-1741613771=:72286--

