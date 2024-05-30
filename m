Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB099C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 11:41:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCe9U-0005C0-DG; Thu, 30 May 2024 07:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sCe9S-0005B7-4r
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:40:59 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1sCe9P-0006Cs-H4
 for qemu-devel@nongnu.org; Thu, 30 May 2024 07:40:57 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 79D4D4E602E;
 Thu, 30 May 2024 13:40:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 66ZQa9ElNk87; Thu, 30 May 2024 13:40:47 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 827564E601B; Thu, 30 May 2024 13:40:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 80711746E3B;
 Thu, 30 May 2024 13:40:47 +0200 (CEST)
Date: Thu, 30 May 2024 13:40:47 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Gerd Hoffmann <kraxel@redhat.com>
cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH v2 4/4] vga/cirrus: deprecate, don't build by default
In-Reply-To: <20240530112718.1752905-5-kraxel@redhat.com>
Message-ID: <3efcf132-dec1-3765-e77e-3fd207224eeb@eik.bme.hu>
References: <20240530112718.1752905-1-kraxel@redhat.com>
 <20240530112718.1752905-5-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 30 May 2024, Gerd Hoffmann wrote:
> stdvga is the much better option.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
> hw/display/cirrus_vga.c     | 1 +
> hw/display/cirrus_vga_isa.c | 1 +
> hw/display/Kconfig          | 1 -
> 3 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
> index 150883a97166..81421be1f89d 100644
> --- a/hw/display/cirrus_vga.c
> +++ b/hw/display/cirrus_vga.c
> @@ -3007,6 +3007,7 @@ static void cirrus_vga_class_init(ObjectClass *klass, void *data)
>     dc->vmsd = &vmstate_pci_cirrus_vga;
>     device_class_set_props(dc, pci_vga_cirrus_properties);
>     dc->hotpluggable = false;
> +    klass->deprecation_note = "use stdvga instead";
> }
>
> static const TypeInfo cirrus_vga_info = {
> diff --git a/hw/display/cirrus_vga_isa.c b/hw/display/cirrus_vga_isa.c
> index 84be51670ed8..3abbf4dddd90 100644
> --- a/hw/display/cirrus_vga_isa.c
> +++ b/hw/display/cirrus_vga_isa.c
> @@ -85,6 +85,7 @@ static void isa_cirrus_vga_class_init(ObjectClass *klass, void *data)
>     dc->realize = isa_cirrus_vga_realizefn;
>     device_class_set_props(dc, isa_cirrus_vga_properties);
>     set_bit(DEVICE_CATEGORY_DISPLAY, dc->categories);
> +    klass->deprecation_note = "use stdvga instead";

Excepr some old OSes work better with this than stdvga so could this be 
left and not removed? Does it cause a lot of work to keep this device? I 
thought it's stable already and were not many changes for it lately. If 
something works why drop it?

Regards,
BALATON Zoltan

> }
>
> static const TypeInfo isa_cirrus_vga_info = {
> diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> index a4552c8ed78d..cd0779396890 100644
> --- a/hw/display/Kconfig
> +++ b/hw/display/Kconfig
> @@ -11,7 +11,6 @@ config FW_CFG_DMA
>
> config VGA_CIRRUS
>     bool
> -    default y if PCI_DEVICES
>     depends on PCI
>     select VGA
>
>

