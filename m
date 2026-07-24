Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18F5C531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnBLY-0001gI-FK; Fri, 24 Jul 2026 04:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wnBLT-0001f9-N9; Fri, 24 Jul 2026 04:33:29 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wnBLP-0002dR-Ky; Fri, 24 Jul 2026 04:33:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784881977; bh=jy1XtVP7DvgYSDbEHyyI3lTHo0kusW7uGWgXRVFAWU4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=GSCU0wcVJsY5hGr5m4PwYYOSXfOA28R/bC+H+8nmgd80QA+NaZm2WrfzbOXVBUkXC
 AhS2vE7IZ4DLkfepME6OfYMnR3Gvs+IaKRBNwkaSSBd8ZiwWOrcm3s8ml8Jq3fgyCK
 mBnNgSwfFlOySRyVFJzfr6ZUZDWvB5dCuNcXvRpaq/2Ym7ORm2PI4b1hanwio/poOM
 TNymnVfeH27tiZvOvRlN4l18JTyFyfqy8EG+PUVeILK/Ca+OJKU1qFYBUMy4b6ZmHj
 DaxKR7nSnUIXa8irk2xKXvRmngKh++cm5x3iOVNKQfOAwSkLWn9AZzp4JgqCDWxkWE
 WYJnc3Q7mYC/g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 60D0F1C450B;
 Fri, 24 Jul 2026 11:32:57 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1B24A3F464F;
 Fri, 24 Jul 2026 11:33:18 +0300 (MSK)
Message-ID: <9e9a526d-e54e-402c-8f78-958e4ee514d5@tls.msk.ru>
Date: Fri, 24 Jul 2026 11:33:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 01/13] vfio/igd: Clear saved BDSM in legacy VBIOS ROM at
 load time
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Tomita Moeko <tomitamoeko@gmail.com>, K S Maan
 <kirandeepmaan45@gmail.com>, qemu-stable@nongnu.org,
 Alex Williamson <alex@shazbot.org>, Mario Casquero <mcasquer@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260721170518.4160785-1-clg@redhat.com>
 <20260721170518.4160785-2-clg@redhat.com>
Content-Language: en-US, ru-RU
From: Michael Tokarev <mjt@tls.msk.ru>
Autocrypt: addr=mjt@tls.msk.ru; keydata=
 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
In-Reply-To: <20260721170518.4160785-2-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 7/21/26 20:05, Cédric Le Goater wrote:
> From: Tomita Moeko <tomitamoeko@gmail.com>
> 
> IGD does not come with a ROM BAR [1], the ROM BAR read by default from
> kernel is actually the host VBIOS shadow RAM region that contains host
> modifications on boot. With AI-assisted reverse engineering on VBIOS
> binaries, it is observed that VBIOS saves BDSM register value on first
> access and uses saved value if present.
> 
> When the image is executed in guest, since there is already a saved HPA
> in VBIOS, it keeps using that value instead of the GPA programmed by
> SeaBIOS in BDSM register in PCI config space, causing VBIOS to program
> GTT entries with wrong address, resulting in garbled output in BIOS
> POST and the error below detected by i915 driver.
> 
> i915 0000:00:02.0: [drm] *ERROR* Initial plane programming using invalid range, dma_addr=0x00000000db200000 ((null) [0x00000000baf00000-0x00000000beefffff])
> 
> The previous solution, c4c45e943e51 ("vfio/pci: Intel graphics legacy
> mode assignment"), adjusts GTT entry addresses to (addr - host BDSM +
> guest BDSM) to workaround that. But it is removed in 5aed8b0f0be2
> ("vfio/igd: Remove GTT write quirk in IO BAR 4") due to inconsistent
> values in MMIO BAR0 and IO BAR4.
> 
> Since it was a value latched into the VBIOS that breaks virtualization
> (QEMU does not map the GTT at the same address in the VM), a ROM quirk
> clearing the saved value in VBIOS image is introduced. It searches the
> BDSM accessor routine by matching a 19-byte signature anchored on the
> unique `mov $0x105e,%ax` instruction, then locates the offset of saved
> BDSM and clears it. This makes the routine fall through to the PCI
> config read on the first call inside the guest.
> 
> [1] 3.5.15, 4th Generation Intel Core Processor Family Datasheet Vol. 2
>      https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/4th-gen-core-family-desktop-vol-2-datasheet.pdf
> 
> Fixes: 5aed8b0f0be2 ("vfio/igd: Remove GTT write quirk in IO BAR 4")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3093
> Reported-by: K S Maan <kirandeepmaan45@gmail.com>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> Reviewed-by: Alex Williamson <alex@shazbot.org>
> Link: https://lore.kernel.org/qemu-devel/20260708103100.23127-1-tomitamoeko@gmail.com
> Signed-off-by: Cédric Le Goater <clg@redhat.com>


> ---
>   hw/vfio/pci.h        |   3 ++
>   hw/vfio/igd-stubs.c  |   5 ++
>   hw/vfio/igd.c        | 115 +++++++++++++++++++++++++++++++++++++++++++
>   hw/vfio/pci-quirks.c |   5 ++
>   hw/vfio/pci.c        |   2 +
>   hw/vfio/trace-events |   1 +
>   6 files changed, 131 insertions(+)

I'm picking this up for currently active stable qemu series.  Since this
change touches several files, including new file since last release
(hw/vfio/igd-stubs.c), I'm also picking a few other changes to the
stable series, namely, for 11.0.x:

v11.0.0-2776-gc822ecd8066 vfio/pci: Initialize rom_read_failed in vfio_pci_load_rom()
   this is a little bugfix by its own, so it's okay to pick up

v11.0.0-3-g55e25958aa1 hw/vfio/pci-quirks.c: remove CONFIG_VFIO_IGD,
   Add stubs for needed functions.  This changes quite a few things,
   but not much.  I can adjust this change (Clear saved BDSM) for the
   context before CONFIG_VFIO_IGD removal, but it feels like it would
   be better to pick up CONFIG_VFIO_IGD removal too, to make the branches
   more similar.

For 10.0.x, things are a bit more complex here.  In particular, 10.0.x
lacks

  v10.0.0-290-ge218ccf0c94 vfio: Rename VFIODevice related services
  v10.0.0-756-g2e27becf17b vfio: consistently handle return value for helpers
  v10.2.0-2365-g988499515da "hw/display: Build stubs once"

and these are more troublesome to pick up, including "CONFIG_VFIO_IGD
removal", so I'm picking up "Initialize rom_read_failed", and adjusting
"Clear saved BDSM" for the lack of "CONFIG_VFIO_IGD removal" (it's
stright-forward, with #ifdef CONFIG_VFIO_IGD instead of empty stub).

I'm not very comfortable with the different approach to 10.0.x and 11.0.x,
maybe I should omit "CONFIG_VFIO_IGD removal" from 11.0.x too.

What do you think?

Maybe this whole thing doesn't need so much attention to begin with :)

Thanks,

/mjt

