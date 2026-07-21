Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AA2C44533
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 14:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmBf4-0006gz-WE; Tue, 21 Jul 2026 10:41:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wmBf0-0006ga-GF
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 10:41:31 -0400
Received: from fout-a4-smtp.messagingengine.com ([103.168.172.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1wmBex-0000fm-BN
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 10:41:30 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 092AAEC00D7;
 Tue, 21 Jul 2026 10:41:26 -0400 (EDT)
Received: from phl-imap-18 ([10.202.2.89])
 by phl-compute-02.internal (MEProxy); Tue, 21 Jul 2026 10:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1784644886;
 x=1784731286; bh=b+8hSTOBJtwF9VuaXhUEa1TnsZ9jJRm2p5t4sXUCGpQ=; b=
 eb7Wwc0McI1NAp4v7G33+hSj97lsKFYLphkWG1rU3TunWQSvT+HWxYERIw39k0ms
 zozRyomYk4aa65cEUzNgEbIR87bZSk7YbBWnXmHmQz2J3hhVLDH1/X+EEOzGJ3C7
 zOpeHQs2JeBW6FTvTab9C0DPofwK4W6dKN2AMo41PujU99ylotu/FvmgOb+1IgHl
 vB72m5+Qd3v4WG/ppMiDIwsLrpTPSUy7c7anduMN3JQ4uTwGYxwJrWRci2TiJXwF
 jef2LmOKT/zlTzyY/0eCt9FtfSMpBWvlZdi3mSn6HxxMUr7ddkqlVbuM5KDzA+mn
 uJBrMETMgrSknB+onWqwXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784644886; x=
 1784731286; bh=b+8hSTOBJtwF9VuaXhUEa1TnsZ9jJRm2p5t4sXUCGpQ=; b=A
 ORpPhGLU3q/cDgqzvWOdCX+G8OHHjWegiUI5pZkjLwtqMH6krQccK0SFDIgp8SxK
 fJVUBulYsFnF76wzZHGpIFMZ87Lt2WxzKeuwZHNDT49GuIdcysvyFlL62mTnhmop
 R/puAgy5aDwNrhNMmyoDWOMyEgnUbhJT+KY4RPCxrF/qXpRGnkfp2gf0yE98kAF3
 OJ9kfQt3WIFwxAxnpOTpl/O+rfgaCRRJyEcFLQHviJBMrFhrE+PowhscWFqMGh0A
 2HAUYY+qDEUiiit4gfZdjMnoN9UxpVdK1GukexTnH8zQ1K3Kv4HE4G2cvoOrVoT0
 Q5uGJIaJm36WGSPAqe13Q==
X-ME-Sender: <xms:FYVfag1meWrSCfZ7-5m9PjDRH8XDoPqTHzl1ilYAoMVVQMeVakXwKQ>
 <xme:FYVfal716pxgjMppeaK5T3hpSaNQNsDNZ9X33JKXIcTqbPx5MmwR0Kv7QzVsjB_dS
 EE2QMFz9P_l6J7l48p_xpYdQk_GbSOJ6WsrFAEFTforLhN9aT1r>
X-ME-Proxy-Cause: dmFkZTGVQyRzJJGM+dWRciSGqyMaw7O68w3e4oMJyegh8eCLATCXQs0AaiQmMGSAEBf6Gv
 VfjbHXG+cOHM2lxHbjo6hjPYqkUtmENQGn9sazdM9eYPOY3od87yi1zPStgbWT7yby5rk1
 tTpZdcJ1zsHNrjGr3pwu1XZluUJrLqVsh1bRj/N/HWxEvbNItmKFN2vQIyLcHikB+lwahg
 JWNIgEj3BqedbRmpa99g7yYnzxECRKay9+nax0rV+wyuGBycEfV5TqkYEbqcz5G5FSnACD
 arLXuFLH2JM5kCD1cUGB/8VoPnq7amFYK/6aVy52IULKkiC8OC6eGJ5/0XkMZ32dOLcmKR
 LwxdYUQgrq9yGKwF53cbRGop6biXY6/iMAavTHEPJeJ6zJqTinTKOA5G5Aw1HuTeOLEIif
 Hhx9ZCY3lU1jwDuzYnbQbtseU/4lPpBTuPDUZnTTUX2Gq6YeipQBS+a9WF2wgYEmEYVePE
 md/uh2ClaXSteiPD3fbcluAO0vPkx3L5+IvralanQf07hl05pA1ySh+/hOjABf1E2Ilbh2
 Db4lD+goX4cDSxbJW8a11XhsAq+iQ9AzuUUz1JP8UzybXcbgWZIYhSckeu/pndf0S9iIod
 X2WppX9fWzRG30MKnGASGrECXx3nx93NSajHKgTUZP7ZC32pMFCJuYm9U3/w
X-ME-Proxy: <xmx:FYVfajZAIQA9NJzIcfHRy0rMIMRE0_CDHSN0HEBfRlNZ63Y0DikYXg>
 <xmx:FYVfahfWCYL42QKRQs1UUE_94MJFdmsu0reW3Y35mF8LtjdCjh4iUw>
 <xmx:FYVfasKPSRcUJP1vXMEBdRWivmIb1ayhkOXWLOYrPmFBGDgxjBM5tw>
 <xmx:FYVfamKfOzkT9nrl2b9-uKYQwBX4XnI2tzzgtNW6_xMI-etyI6uLUw>
 <xmx:FoVfakl_ug_BSnHF87RciQ79el_EdXtZxcPLQFDiI5PjCFgNg--GHL69>
Feedback-ID: i03f14258:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 8DD6D15C008C; Tue, 21 Jul 2026 10:41:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: Aln86KiM0iWN
Date: Tue, 21 Jul 2026 08:41:04 -0600
From: "Alex Williamson" <alex@shazbot.org>
To: "Yang Wencheng" <east.moutain.yang@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, "Peter Xu" <peterx@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yangwencheng <yangwencheng@gmail.com>
Message-Id: <38865e6b-6e80-4581-9aaf-257a53dfb972@app.fastmail.com>
In-Reply-To: <20260721130611.539089-1-east.moutain.yang@gmail.com>
References: <20260721130611.539089-1-east.moutain.yang@gmail.com>
Subject: Re: [PATCH] hw/vfio: Coalesce repeated PCI_COMMAND memory-decode DMA
 (re)map for passthrough BARs
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=103.168.172.147; envelope-from=alex@shazbot.org;
 helo=fout-a4-smtp.messagingengine.com
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



On Tue, Jul 21, 2026, at 7:06 AM, Yang Wencheng wrote:
> From: YangWencheng <east.moutain.yang@gmail.com>
>
> A passthrough device's own MMIO/BAR range is registered with the IOMMU
> (VFIO_IOMMU_MAP_DMA) when its memory region becomes part of the guest
> address space, to support peer-to-peer DMA into that BAR from other
> devices. Toggling the guest's PCI_COMMAND memory-decode-enable bit off
> and back on -- something PCI enumeration/attribute code does routinely,
> sometimes several times for the same device (e.g. disable before
> reprogramming a BAR then re-enable, or generic driver probing during
> guest OS boot) -- currently tears down and rebuilds this mapping every
> single time via vfio_listener_region_del()/region_add(), unconditionally.
>
> For devices with very large BARs this is expensive: mapping a 64GB BAR
> into IOMMU page tables measured at ~8.5s per call on this hardware, and
> was observed being repeated 3-5 times for the same BAR during a single
> guest boot, because nothing changed about the underlying mapping between
> the disable and the following re-enable.
>
> Defer the actual VFIO_IOMMU_UNMAP_DMA for "ram device" regions (i.e.
> passthrough device BARs used for P2P DMA -- explicitly not regular guest
> RAM or RamDiscardManager-backed regions, so migration/ballooning/
> virtio-mem are unaffected) instead of issuing it immediately in
> region_del(). If a matching region_add() for the exact same region
> (same MemoryRegion pointer, iova, size, vaddr, readonly) follows, cancel
> the deferred unmap and skip the VFIO_IOMMU_MAP_DMA entirely -- the
> host-side mapping was never actually removed, so there is nothing to
> redo. A region_add() for anything that doesn't match maps normally, as
> before.
>
> Nothing is leaked: any mapping still on the pending list is flushed with
> a real unmap in two places -- vfio_container_instance_finalize(), before
> the container's fd is closed (VM shutdown / last device in a group removed),
> and vfio_bars_finalize(), matched by MemoryRegion pointer to just that
> device's own BARs, so a device hot-unplugged while the container stays
> alive for other devices can't leave a dangling deferred entry either.
>
> This does not weaken the PCI_COMMAND memory-decode security boundary:
> every guest write to PCI_COMMAND is still forwarded synchronously and
> unconditionally to the real device's config space in
> vfio_pci_write_config() (an entirely separate code path, untouched by
> this change), which is what actually gates whether the physical device
> claims/responds to transactions targeting its BAR, independent of
> whatever the IOMMU's routing table still contains. This change only
> avoids redundant bookkeeping of that routing table when nothing about
> the mapping has changed.

Seems like you should focus on huge pfnmap support on your platform rather than hack the VMM to not behave like bare metal.  Thanks,

Alex


> Signed-off-by: Yangwencheng <yangwencheng@gmail.com>
> ---
>  hw/vfio/container.c              | 53 ++++++++++++++++++++++
>  hw/vfio/listener.c               | 76 ++++++++++++++++++++++++++++++++
>  hw/vfio/pci.c                    | 11 +++++
>  include/hw/vfio/vfio-container.h | 28 ++++++++++++
>  4 files changed, 168 insertions(+)
>
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index d09a663732..00676cadc9 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -298,6 +298,56 @@ GList *vfio_container_get_iova_ranges(const 
> VFIOContainer *bcontainer)
>      return g_list_copy_deep(bcontainer->iova_ranges, copy_iova_range, 
> NULL);
>  }
> 
> +/*
> + * Actually unmap (and free the bookkeeping for) any deferred "ram
> + * device" unmaps still pending on this container. Must be called
> + * before the container's fd is closed/reused, and is safe to call at
> + * any time (e.g. also from a specific device's exit path, to avoid
> + * leaking a mapping if that device is hot-unplugged while the
> + * container otherwise stays alive for other devices).
> + */
> +void vfio_flush_pending_ram_device_unmaps(VFIOContainer *bcontainer)
> +{
> +    VFIOPendingRamDeviceUnmap *pending, *tmp;
> +
> +    QLIST_FOREACH_SAFE(pending, &bcontainer->pending_ram_device_unmap_list,
> +                       next, tmp) {
> +        int ret = vfio_container_dma_unmap(bcontainer, pending->iova,
> +                                            pending->size, NULL, false);
> +        if (ret) {
> +            error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> +                         "0x%"HWADDR_PRIx") = %d (%s)",
> +                         bcontainer, pending->iova, pending->size, ret,
> +                         strerror(-ret));
> +        }
> +        QLIST_REMOVE(pending, next);
> +        g_free(pending);
> +    }
> +}
> +
> +void vfio_flush_pending_ram_device_unmaps_for_mr(VFIOContainer *bcontainer,
> +                                                   MemoryRegion *mr)
> +{
> +    VFIOPendingRamDeviceUnmap *pending, *tmp;
> +
> +    QLIST_FOREACH_SAFE(pending, &bcontainer->pending_ram_device_unmap_list,
> +                       next, tmp) {
> +        if (pending->mr != mr) {
> +            continue;
> +        }
> +        int ret = vfio_container_dma_unmap(bcontainer, pending->iova,
> +                                            pending->size, NULL, false);
> +        if (ret) {
> +            error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
> +                         "0x%"HWADDR_PRIx") = %d (%s)",
> +                         bcontainer, pending->iova, pending->size, ret,
> +                         strerror(-ret));
> +        }
> +        QLIST_REMOVE(pending, next);
> +        g_free(pending);
> +    }
> +}
> +
>  static void vfio_container_instance_finalize(Object *obj)
>  {
>      VFIOContainer *bcontainer = VFIO_IOMMU(obj);
> @@ -312,6 +362,8 @@ static void vfio_container_instance_finalize(Object *obj)
>          g_free(giommu);
>      }
> 
> +    vfio_flush_pending_ram_device_unmaps(bcontainer);
> +
>      g_list_free_full(bcontainer->iova_ranges, g_free);
>  }
> 
> @@ -325,6 +377,7 @@ static void vfio_container_instance_init(Object *obj)
>      bcontainer->iova_ranges = NULL;
>      QLIST_INIT(&bcontainer->giommu_list);
>      QLIST_INIT(&bcontainer->vrdl_list);
> +    QLIST_INIT(&bcontainer->pending_ram_device_unmap_list);
>  }
> 
>  static const TypeInfo types[] = {
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index c19600e980..e6bcfd028e 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -49,6 +49,55 @@
>   * Device state interfaces
>   */
> 
> +/*
> + * Defer the VFIO_IOMMU_UNMAP_DMA for a "ram device" (passthrough device
> + * MMIO/BAR) region instead of doing it immediately. See the comment on
> + * VFIOPendingRamDeviceUnmap in vfio-container.h for why.
> + */
> +static void vfio_defer_ram_device_unmap(VFIOContainer *bcontainer,
> +                                        MemoryRegion *mr, hwaddr iova,
> +                                        hwaddr size, void *vaddr,
> +                                        bool readonly)
> +{
> +    VFIOPendingRamDeviceUnmap *pending = g_malloc0(sizeof(*pending));
> +
> +    pending->mr = mr;
> +    pending->iova = iova;
> +    pending->size = size;
> +    pending->vaddr = vaddr;
> +    pending->readonly = readonly;
> +    QLIST_INSERT_HEAD(&bcontainer->pending_ram_device_unmap_list, pending,
> +                      next);
> +}
> +
> +/*
> + * If a deferred unmap exactly matching this (mr, iova, size, vaddr,
> + * readonly) is pending, cancel it (drop it without ever issuing the
> + * VFIO_IOMMU_UNMAP_DMA) and report success -- the caller should skip
> + * mapping, since the host-side mapping was never actually removed.
> + * Returns false if there was no matching pending unmap, in which case
> + * the caller must map normally.
> + */
> +static bool vfio_cancel_pending_ram_device_unmap(VFIOContainer *bcontainer,
> +                                                 MemoryRegion *mr,
> +                                                 hwaddr iova, hwaddr size,
> +                                                 void *vaddr, bool readonly)
> +{
> +    VFIOPendingRamDeviceUnmap *pending;
> +
> +    QLIST_FOREACH(pending, &bcontainer->pending_ram_device_unmap_list, next) {
> +        if (pending->mr == mr && pending->iova == iova &&
> +            pending->size == size && pending->vaddr == vaddr &&
> +            pending->readonly == readonly) {
> +            QLIST_REMOVE(pending, next);
> +            g_free(pending);
> +            return true;
> +        }
> +    }
> +
> +    return false;
> +}
> +
> 
>  static bool vfio_log_sync_needed(const VFIOContainer *bcontainer)
>  {
> @@ -608,6 +657,22 @@ void vfio_container_region_add(VFIOContainer *bcontainer,
>                  pgmask + 1);
>              return;
>          }
> +
> +        /*
> +         * If region_del deferred an identical unmap for this exact region
> +         * (same MemoryRegion, iova, size, vaddr, readonly), the underlying
> +         * VFIO_IOMMU_MAP_DMA mapping is still live host-side -- cancel the
> +         * deferred unmap and skip re-mapping. This is what makes toggling
> +         * a passthrough device's PCI_COMMAND memory-decode bit off and
> +         * back on (which normal PCI enumeration/attribute code does,
> +         * sometimes several times per device) cheap instead of repeating
> +         * a possibly multi-second VFIO_IOMMU_MAP_DMA for huge BARs.
> +         */
> +        if (vfio_cancel_pending_ram_device_unmap(bcontainer, section->mr,
> +                                                 iova, int128_get64(llsize),
> +                                                 vaddr, section->readonly)) {
> +            return;
> +        }
>      }
> 
>      if (memory_region_skip_iommu_map(section->mr)) {
> @@ -714,6 +779,17 @@ static void 
> vfio_listener_region_del(MemoryListener *listener,
> 
>          pgmask = (1ULL << ctz64(bcontainer->pgsizes)) - 1;
>          try_unmap = !((iova & pgmask) || (int128_get64(llsize) & pgmask));
> +
> +        if (try_unmap) {
> +            void *vaddr = memory_region_get_ram_ptr(section->mr) +
> +                         section->offset_within_region +
> +                         (iova - section->offset_within_address_space);
> +
> +            vfio_defer_ram_device_unmap(bcontainer, section->mr, iova,
> +                                        int128_get64(llsize), vaddr,
> +                                        section->readonly);
> +            try_unmap = false;
> +        }
>      } else if (memory_region_has_ram_discard_manager(section->mr)) {
>          vfio_ram_discard_unregister_listener(bcontainer, section);
>          /* Unregistering will trigger an unmap. */
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index c204706e63..86d61891fe 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -30,6 +30,7 @@
>  #include "hw/core/qdev-properties.h"
>  #include "hw/core/qdev-properties-system.h"
>  #include "hw/vfio/vfio-cpr.h"
> +#include "hw/vfio/vfio-container.h"
>  #include "migration/vmstate.h"
>  #include "migration/cpr.h"
>  #include "qobject/qdict.h"
> @@ -2042,6 +2043,16 @@ static void vfio_bars_finalize(VFIOPCIDevice *vdev)
>          vfio_region_finalize(&bar->region);
>          if (bar->mr) {
>              assert(bar->size);
> +            /*
> +             * If a PCI_COMMAND memory-decode toggle deferred this BAR's
> +             * unmap (see vfio_defer_ram_device_unmap()), this device is
> +             * now really going away -- flush it for real so the mapping
> +             * isn't leaked for the remaining lifetime of the container.
> +             */
> +            if (vdev->vbasedev.bcontainer) {
> +                vfio_flush_pending_ram_device_unmaps_for_mr(
> +                    vdev->vbasedev.bcontainer, bar->region.mem);
> +            }
>              g_free(bar->mr);
>              bar->mr = NULL;
>          }
> diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
> index a15ee2df2b..24525683fb 100644
> --- a/include/hw/vfio/vfio-container.h
> +++ b/include/hw/vfio/vfio-container.h
> @@ -48,6 +48,7 @@ struct VFIOContainer {
>      bool dirty_pages_started; /* Protected by BQL */
>      QLIST_HEAD(, VFIOGuestIOMMU) giommu_list;
>      QLIST_HEAD(, VFIORamDiscardListener) vrdl_list;
> +    QLIST_HEAD(, VFIOPendingRamDeviceUnmap) pending_ram_device_unmap_list;
>      QLIST_ENTRY(VFIOContainer) next;
>      QLIST_HEAD(, VFIODevice) device_list;
>      GList *iova_ranges;
> @@ -76,6 +77,29 @@ typedef struct VFIORamDiscardListener {
>      QLIST_ENTRY(VFIORamDiscardListener) next;
>  } VFIORamDiscardListener;
> 
> +/*
> + * A "ram device" region (a passthrough device's own MMIO/BAR range,
> + * mapped into the IOMMU for peer-to-peer DMA) that region_del wants to
> + * unmap. The actual VFIO_IOMMU_UNMAP_DMA is deferred: if a matching
> + * region_add for the identical region shows up again (e.g. the guest
> + * toggled PCI_COMMAND memory-decode off then back on, which is common
> + * and can happen several times per device during firmware/OS PCI
> + * enumeration), the map is still valid host-side and both the unmap and
> + * the re-map can be skipped entirely. This avoids repeating the
> + * (potentially multi-second, for huge BARs) VFIO_IOMMU_MAP_DMA ioctl for
> + * no functional reason. Any mapping still pending here when the
> + * container is finally torn down gets a real unmap first, so nothing
> + * is ever leaked.
> + */
> +typedef struct VFIOPendingRamDeviceUnmap {
> +    MemoryRegion *mr;
> +    hwaddr iova;
> +    hwaddr size;
> +    void *vaddr;
> +    bool readonly;
> +    QLIST_ENTRY(VFIOPendingRamDeviceUnmap) next;
> +} VFIOPendingRamDeviceUnmap;
> +
>  VFIOAddressSpace *vfio_address_space_get(AddressSpace *as);
>  void vfio_address_space_put(VFIOAddressSpace *space);
>  void vfio_address_space_insert(VFIOAddressSpace *space,
> @@ -267,4 +291,8 @@ VFIORamDiscardListener *vfio_find_ram_discard_listener(
>  void vfio_container_region_add(VFIOContainer *bcontainer,
>                                 MemoryRegionSection *section, bool cpr_remap);
> 
> +void vfio_flush_pending_ram_device_unmaps(VFIOContainer *bcontainer);
> +void vfio_flush_pending_ram_device_unmaps_for_mr(VFIOContainer *bcontainer,
> +                                                   MemoryRegion *mr);
> +
>  #endif /* HW_VFIO_VFIO_CONTAINER_H */
> -- 
> 2.43.0

