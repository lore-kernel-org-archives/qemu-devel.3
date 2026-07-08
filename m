Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B884DC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 04:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whJwc-0008Q1-GH; Wed, 08 Jul 2026 00:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1whJwZ-0008Pe-Ce
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 00:31:32 -0400
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1whJwX-0003iB-3q
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 00:31:31 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 8842A1400074;
 Wed,  8 Jul 2026 00:31:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Wed, 08 Jul 2026 00:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1783485086;
 x=1783571486; bh=ljeNfHzPeowRZDrmrBiEZU+6bIsb9AiCNTzL0cEFdjA=; b=
 DDCo1mFRT1UHkCPRim+MX3udcXOzP1HI/YU6LuIFXWXwvGsAmtzEGGvMsmVnoUZ+
 WYxsGXHrBaQXRlfZg08UD3mY9wvKlS162x1mYGFdwd2XnCwknrVwMYzNf7OozAA8
 iKu5eKfbzZAki/kQ1AowT3PIN2rYZEO8qLcWXYY6/p2qzyqTEt5Oe7FFHzOM3r8t
 rf2b4qRrMDYkoZwM9/jpv4bwkrhumQU7C63fts4ZAMJIiuKslWknMq5mCPRhAUPk
 2P72CV1dJjBmgNig/7Ceo5VDzYRGL5Pz/azX2ZlKGEVrvvbzFF55sawimvCorulG
 af2AZjFt7k6coOL+M9ubRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783485086; x=
 1783571486; bh=ljeNfHzPeowRZDrmrBiEZU+6bIsb9AiCNTzL0cEFdjA=; b=Z
 RWhzvHY6AAhcmLCASYjFzIWbgL/w2Hy7DjIK0PeZeODOpqpbjjsR8Ebh7rHGJyQF
 S6zqJhXq3L+hidn7JTIR2cKLBIKDNeM1Mir8scQtjdtKqFgJEQ1c03PQt5dIBFfl
 QEee6s7r38lQ/ogLnGiZzOpOPzczVaA3VmT/4hIswIIhNy90Zi7Nn8lfMgdfQaRY
 URvXHVnYsUiXNr4VHzXemfdJNzQtWXGsdPN+ndL0tJ8NkdoKpz2V0Aq+WHAXzTfK
 8EtUjFvnDChW8IpnsN0jO68ChvdWv4etK3hx3J9c3tcy1Fop/X9Nylj0b+rUDZWP
 5tiycNPsaqSbeVf2c3Uow==
X-ME-Sender: <xms:ntJNajRQySAlJK18NVMxIWlNwn5r52Ks7LhzhXJmJ6_DCOinVQXNTA>
 <xme:ntJNats3st9dz6yuOdHt7GIH8VMICqBNuzTHwGRbjDtl9iwIxWGhfxGWiaCTJx668
 EOu-NSOQmG2HfG6Ry6ARn-tz3_HusEjKmC_dNfICxFHcA-PbeAWXw>
X-ME-Received: <xmr:ntJNakbSLRtLj8Wv-ra5FGJ9nQqTOqSKA8ocKQtlgIKT3kzNF81QWfyRIIY>
X-ME-Proxy-Cause: dmFkZTGpstCx1OK1WllYRv9vlGQwaFmQwKOq6hrpeq9aXRI6gxQa6XVFT6SvJC+pnyVlu+
 WmkdP1LGbJVJXQ8JFTI55oakIY2toQe1UpsLKc57YXlnBJYgjH550q+ohnMDOvhWUi+gJC
 osdrDj1cXzvLqZPpze9hGaPoZwh1zuiEb2+mgh3elobEbICDDmqJ+1hsElPXXJVvwMIE7X
 o5P2dThk9s5odCZ8TBUjKqwlAf3X0ZdO7AyrRw1TCNcWOcSuN8OYco/+KPagE37qPiLzcA
 71yagUPaUPxhX7IbQ7JsxjKcMeZ+OyCTdlJ6jfrfPUxRFV7uEJDSDfSkjuxJkA+NSTOeeH
 ccXJro/p+xQNwH+1lCVZWiyzy4C6c92Tc5uozVW60+y0vgIu1zKLz0L9I1KASCQKixn9Pm
 XfvDZCelO7VNtooI6/wg5HAS2pQv6O6DUr5ntVrPCXjg/w1kYjuZ5o3utpYoZ8C6bAvVLi
 +KzjtZxM1ajnNVBaIvVFHcRhmuAqpWaH/BOdIwSAh35tGfhh3S92nEapheve4QQfUVuzZN
 W7qRZ2PCYJwNp0/Gq5mGvt2xmK0PJGHZxNOBFnyKDDNOzXxrV7KnOQ3aTu+SzQAsq/1Chf
 pcyE6pN/n3TtX2UuUqGtne/Rwqsx/eowcWHFmzCWUurkIhMRbDyxQ5JOTWgw
X-ME-Proxy: <xmx:ntJNajGtZkFnZ30pqsWq_XhgVXSXN5ziAdL5d7-Vcxhe2VWM4-kWMA>
 <xmx:ntJNaoweQYiURItHMZquA3Q8jKVxUcgCBRdden6N7ktowkYTEibaVQ>
 <xmx:ntJNalk5KfrFwoFLzoIC2SvmYrSwS80Ur7_xG8TXC3HucdfKKwSSIQ>
 <xmx:ntJNahkwlf-h2vMCzWiXyP4FfDT38VgOcQ8-XO6OmmZGywoAvqLBGw>
 <xmx:ntJNakiZ8tQJxF9VFtQfHRXHfbU3pTx8Yx6j--2JjUpQq3WefEsR8koQ>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 00:31:25 -0400 (EDT)
Date: Tue, 7 Jul 2026 22:31:23 -0600
From: Alex Williamson <alex@shazbot.org>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater
 <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, K S Maan
 <kirandeepmaan45@gmail.com>, alex@shazbot.org
Subject: Re: [PATCH v5 0/3] vfio/igd: Fix garbled screen on IGD passthrough
 with legacy VBIOS
Message-ID: <20260707223123.3979deb8@shazbot.org>
In-Reply-To: <20260707083550.25765-1-tomitamoeko@gmail.com>
References: <20260707083550.25765-1-tomitamoeko@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=103.168.172.158; envelope-from=alex@shazbot.org;
 helo=fhigh-a7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue,  7 Jul 2026 16:35:47 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> This series fixes the regression that on IGD passthrough with legacy
> BIOS boot and VBIOS, the screen is garbled during BIOS POST and GRUB
> (which uses standard VGA output routines), starting from QEMU 10.0.
> Though the kernel i915 driver still works, it reports an error about
> the initial GTT programmed by VBIOS is using invalid address.
> 
> i915 0000:00:02.0: [drm] *ERROR* Initial plane programming using invalid range, dma_addr=0x00000000db200000 ((null) [0x00000000baf00000-0x00000000beefffff])
> 
> With the help of AI disassembling the VBIOS image dumped from host, it
> is found that the VBIOS itself implements a routine like:
> 
>     uint32_t get_BDSM() {
>         static uint32_t saved = 0;
>         if (saved != 0) {
>             return saved;
>         }
>         return read_pci_config(BDSM_REG);
>     }
> 
> And the saved value is not cleared after initialization. Given that IGD
> devices don't have a real ROM BAR, the VBIOS image read by default from
> host is actually the VBIOS shadow RAM region, containing host-side
> modifications like the saved BDSM value above during POST. When the
> image is executed in guest, it still uses the saved host BDSM (HPA)
> instead of the value programmed by SeaBIOS in config space (GPA). This
> address mismatch leads to the garbled screen and i915 error.
> 
> The previous solution, c4c45e943e51 ("vfio/pci: Intel graphics legacy
> mode assignment"), adjusts GTT entry addresses to (addr - host BDSM +
> guest BDSM) to workaround that. But it is removed in 5aed8b0f0be2
> ("vfio/igd: Remove GTT write quirk in IO BAR 4") due to inconsistent
> values in MMIO BAR0 and IO BAR4. Considering it's unsafe to expose HPA
> to guest, a ROM quirk clearing the saved value in VBIOS image is
> introduced to fix the issue.

How is it unsafe to expose an HPA?  The initial values in the PCI BARs
expose their HPAs, it's not unsafe.  The issue here is that the host
value is latched into the BIOS, which breaks the virtualization since
we're not mapping the GTT at the same address in the VM.
 
> During debugging, it is also found that IGD VBIOS ROM doesn't always
> match the actual IGD device ID, due to the fact that IGD of the same
> CPU family has multiple device IDs but shares the same ROM image.
> However, SeaBIOS checks the device ID strictly and refuses to run if
> IDs does not match. Currently only the default path, reading ROM from
> kernel patches the device ID, but the romfile path doesn't. So the ROM
> ID patching logic is also refactored in this patch series to also handle
> the romfile path.

This is a separate feature from the regression fix.  Up until now we've
only modified the ROM as provided through the vfio interface as the
user is out of the loop.  Once the user is in the loop and providing
the ROM via a file, we've always assumed it's the user's responsibility
to fixup the ROM and QEMU should pass it through unmodified.  I have a
tool[1] in my github that has served this purpose, allowing a device ID
to be written into the ROM image and the checksum recalculated.  We've
always required a ROM provided as a romfile to be pre-modified to match
the device ID.  Even the existing fixup in the PCI code is only for
default ROMs, not the PCIDevice.romfile image.

As I understand this series, we're using the rationale that removing
the GTT hack introduced a regression in QEMU and the fix we've
discovered for that regression requires clearing a field in the ROM
image, therefore we want to do that regardless of whether the ROM image
is provided through vfio or by the user... and while we're already
mangling the user provided image, we might as well fixup the device ID.

Also, as I'm reading the gitlab issue resolved by patch 3, it's
reported against the ROM read through vfio path, not the romfile path.
So for the issue presented, this could be a single patch that adds an
igd callout/stub to vfio_pci_load_rom() to zero the BDSM field, and
we'd require the romfile path to provide a pristine ROM image, with
matching device ID (already a requirement) and now the BDSM workaround.

Given that QEMU 11.1 is already in soft-freeze, that sounds more like
the self-contained, no additional feature fix that we need.
Effectively patch 3 with the BDSM zeroing directly wired through
vfio_pci_load_rom() and a Fixes: tag referencing the 10.0 commit
removing the previous GTT hack.  Thanks,

Alex

[1]https://github.com/awilliam/rom-parser

