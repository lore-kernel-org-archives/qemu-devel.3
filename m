Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C78CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 21:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc8jU-0003E2-Bb; Tue, 23 Jun 2026 17:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wc8jM-0003DL-LR
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 17:32:30 -0400
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wc8jK-0005aV-BO
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 17:32:28 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 9A47BEC00BD;
 Tue, 23 Jun 2026 17:32:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 23 Jun 2026 17:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1782250333;
 x=1782336733; bh=8+SsNxJkFFaz3pCVLqVcoObHgm353gOoe+kxw7v8wno=; b=
 QU5HOLDlnGZJtvzO1bkdNJzj24eAYwT45pgtMdiJiTmEiHiX4PCK9NsguGe532LX
 yNCOV3AXRKAH27UaSlgtlmyAYdshZg/HjT3/2rL92tYqQmH3JatDyBT4/EtqxU4b
 WKTR/iaoYJIpSILRZdgY9B9kr66VZr6D1oFSNtLX+KWZGfWnd7S8JJEZNuR5fcL7
 HWIer7XVkTBUx0h6M09WynX8aObzERRVI5hGcq55qIWV0TgYR9AXyZAvj6/lDaFZ
 MmfyeBDxX5VwIwMS0z2/vtgNQct8oD1npFqyeYrpkTahxIeePE49qMrGsrYjVNaK
 S+bPWeBrndegQzlIQKYmzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782250333; x=
 1782336733; bh=8+SsNxJkFFaz3pCVLqVcoObHgm353gOoe+kxw7v8wno=; b=a
 uJr2rlyi78b42w3nyHjFoXbJnpM4pkqowsqA+jJrvLhL9H65OwGGYzLtd+6GLyvP
 /mRLgA12XjINxDBal5DZ+VbUVXxwyeR8A/PDqlW36wNG7rMpcR4w6Dl+dEffENg8
 0K24c6aROh+P/Tb3oYEiApxLanvX2rF6kCIidZh9xhSp+D4jokwacvYbL4knftvM
 MXHsiQZ2OeHZFIoeUKSOD6qp4WXOwzJ9oltwcAtTSCIw/lAjXSfTdkNQIbRs/GTk
 oqTwhQDbsD8i1OmEUExw1Zx7J4hSt5dfUimoPTckkb27/82MgBrWA+GbGTLhjWys
 Nm7f72KSJX/oSwEO07+wg==
X-ME-Sender: <xms:Xfs6aoEDJYyCUJSbKQF5RR3N3Fb42FX0TkKhJhKS3u2CGxQnAmrviQ>
 <xme:Xfs6aqS90Alg9fTjBL-TDybtgLgnoqXRutw6oAaAqAgU02aNXiW01Pf4zyNcKmv7J
 34iaXcuM_jTIwDNuGuswBjjPti7-d-Y7Bq1kqyipW9MCkjDITqtag>
X-ME-Received: <xmr:Xfs6atteqxnNFM6u1rVRs7SRZFwQz3ufxAKo_n-sM1nOep1X269BOOcnmU0>
X-ME-Proxy-Cause: dmFkZTFXH0e1s55O3KCtpmQ1ABgEQDdbr9BlntBYQD33mBXEBUz0EfcgM/pwMDppcwlgQO
 Ma8HoAzSROfnvty3GGOWEbQT+kKibSXb5cSIgtBXf76VSubHrMTehWqSU0vJns5JhklKAE
 dDzyvOMxh3dL5rMPPnePIbLSIG3jFgwOcM1M5kv9Hvj4KUcZupNLSUGh+/SZvKUutMvoEh
 c06+468DoiM/ZyQdwz+j7tMbHQq4LIbhKTWpEOirSsU/X3bpC9FvcI1xfIc9TY+XsRKM/K
 E7dTDL9IwH4R3znPa5sCAgIj7ggnEaeQQDZPcqv/kgobftvYZkDdZt7JAr0nAsaANm8udH
 gwwUNUNjbQKwsUYSHv1pWoRf108Eq+GHKY6qrAVaKNjhEecl6tavAR66qyITr0PN1KZ9ZB
 vb/jTvs8MOUi4k3hx5w2Tr6kjYVwlkmpoYIwfq7W1qpJW13GgL/P3XZCgFFJGdpt4jdcTV
 1rCnZILIxhE2loqy9FzRGlViHIq/1QPMIXAM6xmxjfpFqtRqUNhYEK98J4FH3ZXIfr76gk
 9YNw0hut510ohE7HWbcmfXwlRhWCPeC794dzSDb7meckrqHdMH88X0zmIr49pj0Q/unYMz
 GAvf9G90IFPGFT/c3euHpk9Ijts1c7IHyduu+frmQvxgD7jYSpcDQJxfTcPg
X-ME-Proxy: <xmx:Xfs6aqJmhTju1Ce07oCe36PvzEPElSjWZiVS1UR-IqwKSMf-uVycyQ>
 <xmx:Xfs6aqmZHU3tyOY-Li8WxCK08vkxS9G7EuVUMO-BAz2wW8eR-GJnbQ>
 <xmx:Xfs6arKyYYf7F2VGyttt2seneKeZKIgnR6tigeblMvB980cI0N8pCQ>
 <xmx:Xfs6av7QsumwpeUNFrP30NGpvJUfBUcgOfH8tLrth0lxUp6bRH4iBQ>
 <xmx:Xfs6aikbL1r_OrPXIl4pWHurjQ2Q8l01gAeQW65tPal9GFAviVRoZzGb>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jun 2026 17:32:12 -0400 (EDT)
Date: Tue, 23 Jun 2026 15:32:11 -0600
From: Alex Williamson <alex@shazbot.org>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: alex@shazbot.org, qemu-devel@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le
 Goater <clg@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, K S Maan
 <kirandeepmaan45@gmail.com>
Subject: Re: [PATCH v3 0/7] vfio/igd: Fix garbled screen on IGD passthrough
 with legacy VBIOS
Message-ID: <20260623153211.37c6857a@shazbot.org>
In-Reply-To: <20260617100646.28326-1-tomitamoeko@gmail.com>
References: <20260617100646.28326-1-tomitamoeko@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=103.168.172.149; envelope-from=alex@shazbot.org;
 helo=fout-a6-smtp.messagingengine.com
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

On Wed, 17 Jun 2026 18:06:37 +0800
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
> 
> During debugging, it is also found that IGD VBIOS ROM doesn't always
> match the actual IGD device ID, due to the fact that IGD of the same
> CPU family has multiple device IDs but shares the same ROM image.
> However, SeaBIOS checks the device ID strictly and refuses to run if
> IDs does not match. Currently only the default path, reading ROM from
> kernel patches the device ID, but the romfile path doesn't. So the ROM
> ID patching logic is also refactored in this patch series to also handle
> the romfile path.
> 
> These changes are tested on Haswell platform with legacy BIOS boot, by
> K S Maan. Thanks to K S Maan for continuous help on locating and testing
> the issue!
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3093
> Reported-by: K S Maan <kirandeepmaan45@gmail.com>
> 
> Changelog:
> v3:
> * Refactor ROM checksum calculation and patching logic as Alex's comment
> * Fix boundary checks as comments in v2.
> Link: https://lore.kernel.org/all/20260608134559.23971-1-tomitamoeko@gmail.com/t
> 
> v2:
> * New patch 2/7 to fix regression with EFI option ROMs
> * Refine logic in ROM ID and checksum patching
> * Reorder patch 4 and 5 for cleaner bisection
> * Address comments from v1
> Link: https://lore.kernel.org/all/20260603173355.36121-1-tomitamoeko@gmail.com/t
> 
> Tomita Moeko (7):
>   hw/pci: Recalculate option ROM checksum before patching ID
>   hw/pci: Skip EFI option ROM in pci_patch_ids()
>   hw/pci: Introduce rom_need_patch_id flag in PCIDevice
>   hw/pci: Promote pci_patch_ids() to public pci_rom_patch_ids()
>   vfio/igd: Toggle rom_need_patch_id flag on IGD devices
>   vfio/pci: Use pci_rom_patch_ids() for IGD ROM ID patching
>   vfio/igd: Clear saved BDSM in legacy VBIOS ROM at load time
> 
>  hw/pci/pci.c                |  57 ++++++++++------
>  hw/vfio/igd-stubs.c         |   5 ++
>  hw/vfio/igd.c               | 132 ++++++++++++++++++++++++++++++++++--
>  hw/vfio/pci-quirks.c        |   5 ++
>  hw/vfio/pci.c               |  33 ++-------
>  hw/vfio/pci.h               |   3 +
>  hw/vfio/trace-events        |   1 +
>  include/hw/pci/pci.h        |   3 +
>  include/hw/pci/pci_device.h |   1 +
>  9 files changed, 186 insertions(+), 54 deletions(-)

Reviewed-by: Alex Williamson <alex@shazbot.org>

