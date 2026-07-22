Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5318C44533
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 05:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmP47-0000M9-Lb; Wed, 22 Jul 2026 01:00:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wmP45-0000L5-Ai
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 01:00:17 -0400
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wmP42-0005ki-RC
 for qemu-devel@nongnu.org; Wed, 22 Jul 2026 01:00:17 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id DE38B1D00117;
 Wed, 22 Jul 2026 01:00:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Wed, 22 Jul 2026 01:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1784696410;
 x=1784782810; bh=7uvMFWrVkzgqT2NhVxo6kyGPXalVleF3s0UkXyMbgo8=; b=
 J31tNy0q7LgRGiBk4HZ1G7QYuT+D7Yt6dpSJU8ceHLGZrO2sEU6PcV6OJtt4chRy
 0YMPqOwCPxZD9GVrD5PJzfCXT5MYWI1wVLQ2jIpK4D4XO6PkyTVzkdXNbTRSfYs1
 rci8qyfLaEyPX4Jd/qgYVvgrNUYHChY1D9OAKQDZFNKXebeCgh1bQL62uzBUJhTR
 mFmzQDqNQtLpJ8NZivasZq4BJWcutQM3tEc9n92XKafwdMR2oaAm6MiCIWZ3wgNB
 ikoSmwF/oe/BHZd72caLjEDTEJnCVW95xoixLFG5bAmTR36ULuTOhJURPW5MO9my
 mjDoYujHPz61vGLDjQ2/OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784696410; x=
 1784782810; bh=7uvMFWrVkzgqT2NhVxo6kyGPXalVleF3s0UkXyMbgo8=; b=N
 YbuKsR8ks1CrzN4oJ3IYbpFDu3KWRTizJons/lYy3j8xY/4v0QWxizjQKNgzrfPa
 NTpYGmL+NnL72Xmy7iu8ejrPRfVXOZJ2iQQaGc7cOlitw4jDieQLhks6AX8sIJpO
 5AL5Pb5lCG8i1BQHjr9+VZPMgUvFQnBM5SnDjKisrCSeMfn7yJGyjR77fZsvW0nZ
 H4rxxEVrrRjyN6gTDc05/X3ZDATAK/d2TW4IHUmhnoC6hKRxUBe+dF0FoaHKB60B
 kMtZEKymTJJoTLjQRv3CEqWWs6rYhsb+vRAnqoz0/qCVvCi5hPu6elfM7QVO8sLa
 vR/w0tRYho8/dF9mJ5rTw==
X-ME-Sender: <xms:WU5gatohFAaopI9eMF9l7rFXhrPJfg236JK6GtOAUVsuVJD0ajTssA>
 <xme:WU5garpDrM5abijZz96Ivis4UVD9FY1hG5GIi66hMaEnAu9hgG8tw4JSMstwFaBFX
 NQVa1P6We0u_xm-evor2aGkovqrgZgDqD1IOmI_nyxx3Ze3IIkN3A>
X-ME-Received: <xmr:WU5gasZCbQKy0tJPzPldDiFj7xp3I7yUrlgmtFfKRIAIbD6K0SW1qK1CIHXo0A>
X-ME-Proxy-Cause: dmFkZTF8FIQCRbI4PhDjbWokBUoXCbm/IQAW9lMNroPYPILdWSLgSNMy1tSg7LZ1eA0lDd
 YkNXlcMgaDk6scP+gGBYkXOWzkREbE3gt7KwY1kqnr60T5WFDqmhMWkVQhS0nw7YOVoV3g
 +24Ips97PM3AHXCoSXrhlFlclLIKyR3BlPMSRVcTu4DJdAst43kuXreW+R0T3X/HPd3JSO
 yv/iD87enUhx0xHmSfFPqoZSMa7Q+p5i3n+SotllOp85XGEbhn17vcj9AWodmvVTTXJaqY
 wAv7SNbNvL3AnxD/Ybs1y6SxOah8ppRtGhmtvbXPp6jqmZaX8Czw7fXZ8AzhNQS1fQm6q/
 8iqo0GAxb9gQu6tolzSsA+8ba8wdX/ewzPqQrZoddfic15yRSYBXlP/bA0kWxNAE5+Fesd
 KDb+epuCdO5iYQAY7Z5pz0BEVelX9S6M8Hb9R1iY58LHIvCSl9HuVDaRqcSKl2y0YvH/a6
 0D9y3Ms+bJENm6HbIT1xrz39xJ6W1hYTz8xeiblvj8CLm270leqWcv7Polfc2hpFEmm47i
 ZDhf0ooBjC4si3LgHaK+YrvNHcpX6zPTEW+D5b69JB154QuexkHB6EUiVzwBt3y+9ItL/z
 fIVPYI39JjAmaoBt/wMOLCb113aZyG+HIHrG6YD+T0bGmyRYMN099XLw1ziw
X-ME-Proxy: <xmx:WU5gap8yv6cYhIXCfjJQtnQflzvSHBNjUTKe5raGY6XfAILiXhqS2A>
 <xmx:WU5gaqk8lUepd_7I3l_ZBqsyQ4W8J7YG2QW5xDTFEufJqTuM2L21KQ>
 <xmx:WU5gamxfYxZxiY_rwdfjrYVuBKZS-iJkb9mJsL6CwgHP-LaIos-yyA>
 <xmx:WU5gas7YGvE1ljAKCJiIQhkTfBcUhnrPCqM8XzjaDrSBmxW7H-kcog>
 <xmx:Wk5gahBOK-NDadYIjUyOISZVWiY2a2zh_4gpCLaHFlopvnSjL9vR-QbV>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 01:00:08 -0400 (EDT)
Date: Tue, 21 Jul 2026 23:00:04 -0600
From: Alex Williamson <alex@shazbot.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yang Wencheng <east.moutain.yang@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@mailo.com>, Yangwencheng
 <yangwencheng@gmail.com>, alex@shazbot.org
Subject: Re: [PATCH] hw/vfio: Coalesce repeated PCI_COMMAND memory-decode
 DMA (re)map for passthrough BARs
Message-ID: <20260721230004.2c03fede@shazbot.org>
In-Reply-To: <20260721110247-mutt-send-email-mst@kernel.org>
References: <20260721130611.539089-1-east.moutain.yang@gmail.com>
 <38865e6b-6e80-4581-9aaf-257a53dfb972@app.fastmail.com>
 <20260721110247-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=202.12.124.150; envelope-from=alex@shazbot.org;
 helo=fout-b7-smtp.messagingengine.com
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

On Tue, 21 Jul 2026 11:03:39 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Jul 21, 2026 at 08:41:04AM -0600, Alex Williamson wrote:
> > 
> > 
> > On Tue, Jul 21, 2026, at 7:06 AM, Yang Wencheng wrote:  
> > > From: YangWencheng <east.moutain.yang@gmail.com>
> > >
> > > A passthrough device's own MMIO/BAR range is registered with the IOMMU
> > > (VFIO_IOMMU_MAP_DMA) when its memory region becomes part of the guest
> > > address space, to support peer-to-peer DMA into that BAR from other
> > > devices. Toggling the guest's PCI_COMMAND memory-decode-enable bit off
> > > and back on -- something PCI enumeration/attribute code does routinely,
> > > sometimes several times for the same device (e.g. disable before
> > > reprogramming a BAR then re-enable, or generic driver probing during
> > > guest OS boot) -- currently tears down and rebuilds this mapping every
> > > single time via vfio_listener_region_del()/region_add(), unconditionally.
> > >
> > > For devices with very large BARs this is expensive: mapping a 64GB BAR
> > > into IOMMU page tables measured at ~8.5s per call on this hardware, and
> > > was observed being repeated 3-5 times for the same BAR during a single
> > > guest boot, because nothing changed about the underlying mapping between
> > > the disable and the following re-enable.
> > >
> > > Defer the actual VFIO_IOMMU_UNMAP_DMA for "ram device" regions (i.e.
> > > passthrough device BARs used for P2P DMA -- explicitly not regular guest
> > > RAM or RamDiscardManager-backed regions, so migration/ballooning/
> > > virtio-mem are unaffected) instead of issuing it immediately in
> > > region_del(). If a matching region_add() for the exact same region
> > > (same MemoryRegion pointer, iova, size, vaddr, readonly) follows, cancel
> > > the deferred unmap and skip the VFIO_IOMMU_MAP_DMA entirely -- the
> > > host-side mapping was never actually removed, so there is nothing to
> > > redo. A region_add() for anything that doesn't match maps normally, as
> > > before.
> > >
> > > Nothing is leaked: any mapping still on the pending list is flushed with
> > > a real unmap in two places -- vfio_container_instance_finalize(), before
> > > the container's fd is closed (VM shutdown / last device in a group removed),
> > > and vfio_bars_finalize(), matched by MemoryRegion pointer to just that
> > > device's own BARs, so a device hot-unplugged while the container stays
> > > alive for other devices can't leave a dangling deferred entry either.
> > >
> > > This does not weaken the PCI_COMMAND memory-decode security boundary:
> > > every guest write to PCI_COMMAND is still forwarded synchronously and
> > > unconditionally to the real device's config space in
> > > vfio_pci_write_config() (an entirely separate code path, untouched by
> > > this change), which is what actually gates whether the physical device
> > > claims/responds to transactions targeting its BAR, independent of
> > > whatever the IOMMU's routing table still contains. This change only
> > > avoids redundant bookkeeping of that routing table when nothing about
> > > the mapping has changed.  
> > 
> > Seems like you should focus on huge pfnmap support on your platform
> > rather than hack the VMM to not behave like bare metal.  Thanks,
> > 
> 
> But bare metal does not tweak an iommu during pci enumeration?

Bare metal is not using the IOMMU to map the device into a guest
physical address space, so no, an equivalent operation does not occur
there.  The proposal here is intentionally leaving stale gpa mappings
to avoid the unmap/remap overhead, where we've essentially eliminated
that overhead on other platforms with huge pfnmap support.  The
specific platform that's being optimized here is also omitted, which
makes it impossible to determine the ongoing need for this code.

The scheme here effectively assumes that a region_del() will either be
followed by a region_add() that cancels the deferred unmap, or the
deferral will be executed on finalize.  It does not actually account
for cases where the guest might remap the BAR to a different address,
ex. pci=realloc, leaving a stale mapping in place.  The finalize also
appears to be using a different MR from the one deferred, such that the
IOMMU is actually only unmapped due to close().

More importantly though, this entire scheme is relying on a gap in the
vfio type1 IOMMU backend, where clearing the memory enable bit of the
command register zaps the CPU mappings and errors faults while cleared,
but does not generate unmaps in the IOMMU.  IOMMUFD resolves that gap,
generating a move-notify/invalidate on the dma-buf, which results in an
IOMMU unmap.  IOW, the premise of this workaround is broken in the
direction that VFIO is headed.

Therefore, I'd once again suggest that effort is better redirected to
implement huge pfnmap support for whatever platform this might be in
order to follow a proven solution to this problem for type1.  Huge
pfnmap is used both in the CPU fault path as well as the DMA mapping
path, by virtue of generating user faults in the pfnmap.  Alternatively,
iommufd may provide better p2p DMA mapping performance than type1
without huge pfnmap, but CPU faults would lag without such support
anyway.  Thanks,

Alex

