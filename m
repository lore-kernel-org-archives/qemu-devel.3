Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7D4C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 10:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLgxt-00034R-D3; Mon, 24 Jun 2024 06:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sLgxl-000333-3u
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:30:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sLgxA-0001Td-Qf
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719224980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XyFRP9v7JO9+3oxRQoszThNy5xVX9NonED7mAJn672k=;
 b=fUmJTf13J3m1L4gE7ABTDDoBmcE63thQRw6Jj8ZSzVpb8nZ3M8ffNyAm/3HVQDBuZ0lgB7
 is2zhHTAtJ2bWDOXj1Ddesbr70rn9Uv4/DrfTD3gQUqw3e9GUA8N0EhAVXGJHGbE0r+2Bf
 /WQFqImIb/GGgNkD8OkUGvOCaPtZLC8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-G-Dx-wqGNxOzkprc9Hdvog-1; Mon, 24 Jun 2024 06:29:37 -0400
X-MC-Unique: G-Dx-wqGNxOzkprc9Hdvog-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42488bec55cso8137715e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 03:29:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719224975; x=1719829775;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XyFRP9v7JO9+3oxRQoszThNy5xVX9NonED7mAJn672k=;
 b=jjAqmpfzN9X/ksZBmwUbDMmFWfvcMQZ9hgUtbOdjv8yRI+sKBMsyr+Eabku0F9J1PM
 9Wbd6ZXRMASWzzLc2lx2L/qaOx9Bcxbk5Xn4aY8UvdB4cfCipDlNNkg1XGWnIeByJSzK
 13m97VFjqhYGB27E7MP6YDk+PuwqELgInbk9/pz/s5KbS6SkMVbJWn/OwUCAWK3EoWCl
 /CartUt547A7u+nF1Gg5kCT/HSlYHPBgtPTtDMxuNiZrlitJLCftRenmcuvi7bECbXZc
 fmoblAu2nTI6J9A/9Ny92QLL2tnE7RpKoxqcquubJ2phesx46wz5p3LWn3Ay8lW0GQZC
 xGNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWo9QPbhg87g0Iu0Dg13WuQkDYwFvEeDiO1QZo+BLvmA3OHzlRiLco8jTNp4mq7xk2kMniNSltSyWSlf5T0UARZ8SRVngQ=
X-Gm-Message-State: AOJu0YwexmY84q+E8A4JJTQF5cvui/9LH9QKnLT/gqbNkZZvV2fN2YM9
 edp86dYhH4/V0ty1VjV4GFG8vFC5a2xqxjaPyXi57pzKe7rFuIfJxo7A+6kTBkbr3vfRfWhgYkC
 Cz808zWjRd7Vs4JKBvSqJ5m0800BP6YXAeZGD6ppjmxy723D+s+Rk
X-Received: by 2002:adf:ec03:0:b0:364:4321:271a with SMTP id
 ffacd0b85a97d-366e32f70abmr4300723f8f.25.1719224975079; 
 Mon, 24 Jun 2024 03:29:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZAEtBvEC0hAZRCKFkuc+OE9zjMUgkSTu9BzsSOn/DCBAujgNtfOI5XBs9pyPPsbta8wPb9A==
X-Received: by 2002:adf:ec03:0:b0:364:4321:271a with SMTP id
 ffacd0b85a97d-366e32f70abmr4300690f8f.25.1719224974373; 
 Mon, 24 Jun 2024 03:29:34 -0700 (PDT)
Received: from redhat.com ([2.52.146.100]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247cf5272esm171907925e9.0.2024.06.24.03.29.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 03:29:33 -0700 (PDT)
Date: Mon, 24 Jun 2024 06:29:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 jean-philippe@linaro.org, peter.maydell@linaro.org, clg@redhat.com,
 yanghliu@redhat.com, zhenzhong.duan@intel.com,
 alex.williamson@redhat.com, jasowang@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com
Subject: Re: [PATCH v4 0/8] VIRTIO-IOMMU/VFIO: Fix host iommu geometry
 handling for hotplugged devices
Message-ID: <20240624062759-mutt-send-email-mst@kernel.org>
References: <20240614095402.904691-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614095402.904691-1-eric.auger@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Jun 14, 2024 at 11:52:50AM +0200, Eric Auger wrote:
> This series is based on Zhenzhong HostIOMMUDevice: 
> 
> [PATCH v7 00/17] Add a host IOMMU device abstraction to check with vIOMMU
> https://lore.kernel.org/all/20240605083043.317831-1-zhenzhong.duan@intel.com/
> 
> It allows to convey host IOVA reserved regions to the virtio-iommu and
> uses the HostIOMMUDevice infrastructure. This replaces the usage of
> IOMMU MR ops which fail to satisfy this need for hotplugged devices.
> 
> See below for additional background.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

Should likely be merged together with the dependency.
I can either merge both this one and the dependency, or
Alex can do that because of the vfio changes.




> In [1] we attempted to fix a case where a VFIO-PCI device protected
> with a virtio-iommu was assigned to an x86 guest. On x86 the physical
> IOMMU may have an address width (gaw) of 39 or 48 bits whereas the
> virtio-iommu used to expose a 64b address space by default.
> Hence the guest was trying to use the full 64b space and we hit
> DMA MAP failures. To work around this issue we managed to pass
> usable IOVA regions (excluding the out of range space) from VFIO
> to the virtio-iommu device. This was made feasible by introducing
> a new IOMMU Memory Region callback dubbed iommu_set_iova_regions().
> This latter gets called when the IOMMU MR is enabled which
> causes the vfio_listener_region_add() to be called.
> 
> For coldplugged devices the technique works because we make sure all
> the IOMMU MR are enabled once on the machine init done: 94df5b2180
> ("virtio-iommu: Fix 64kB host page size VFIO device assignment")
> for granule freeze. But I would be keen to get rid of this trick.
> 
> However with VFIO-PCI hotplug, this technique fails due to the
> race between the call to the callback in the add memory listener
> and the virtio-iommu probe request. Indeed the probe request gets
> called before the attach to the domain. So in that case the usable
> regions are communicated after the probe request and fail to be
> conveyed to the guest.
> 
> Using an IOMMU MR Ops is unpractical because this relies on the IOMMU
> MR to have been enabled and the corresponding vfio_listener_region_add()
> to be executed. Instead this series proposes to replace the usage of this
> API by the recently introduced PCIIOMMUOps: ba7d12eb8c  ("hw/pci: modify
> pci_setup_iommu() to set PCIIOMMUOps"). That way, the callback can be
> called earlier, once the usable IOVA regions have been collected by
> VFIO, without the need for the IOMMU MR to be enabled.
> 
> This series also removes the spurious message:
> qemu-system-aarch64: warning: virtio-iommu-memory-region-7-0: Notified about new host reserved regions after probe
> 
> In the short term this may also be used for passing the page size
> mask, which would allow to get rid of the hacky transient IOMMU
> MR enablement mentionned above.
> 
> [1] [PATCH v4 00/12] VIRTIO-IOMMU/VFIO: Don't assume 64b IOVA space
>     https://lore.kernel.org/all/20231019134651.842175-1-eric.auger@redhat.com/
> 
> Extra Notes:
> With that series, the reserved memory regions are communicated on time
> so that the virtio-iommu probe request grabs them. However this is not
> sufficient. In some cases (my case), I still see some DMA MAP failures
> and the guest keeps on using IOVA ranges outside the geometry of the
> physical IOMMU. This is due to the fact the VFIO-PCI device is in the
> same iommu group as the pcie root port. Normally the kernel
> iova_reserve_iommu_regions (dma-iommu.c) is supposed to call reserve_iova()
> for each reserved IOVA, which carves them out of the allocator. When
> iommu_dma_init_domain() gets called for the hotplugged vfio-pci device
> the iova domain is already allocated and set and we don't call
> iova_reserve_iommu_regions() again for the vfio-pci device. So its
> corresponding reserved regions are not properly taken into account.
> 
> This is not trivial to fix because theoretically the 1st attached
> devices could already have allocated IOVAs within the reserved regions
> of the second device. Also we are somehow hijacking the reserved
> memory regions to model the geometry of the physical IOMMU so not sure
> any attempt to fix that upstream will be accepted. At the moment one
> solution is to make sure assigned devices end up in singleton group.
> Another solution is to work on a different approach where the gaw
> can be passed as an option to the virtio-iommu device, similarly at
> what is done with intel iommu.
> 
> This series can be found at:
> https://github.com/eauger/qemu/tree/iommufd_nesting_preq_v7_resv_regions_v4
> 
> History:
> v3 -> v4:
> - add one patch to add aliased pci bus and devfn in the HostIOMMUDevice
> - Use those for resv regions computation
> - Remove VirtioHostIOMMUDevice and simply use the base object
> 
> v2 -> v3:
> - moved the series from RFC to patch
> - collected Zhenzhong's R-bs and took into account most of his comments
>   (see replies on v2)
> 
> 
> Eric Auger (8):
>   HostIOMMUDevice: Store the VFIO/VDPA agent
>   virtio-iommu: Implement set|unset]_iommu_device() callbacks
>   HostIOMMUDevice: Introduce get_iova_ranges callback
>   HostIOMMUDevice: Store the aliased bus and devfn
>   virtio-iommu: Compute host reserved regions
>   virtio-iommu: Remove the implementation of iommu_set_iova_range
>   hw/vfio: Remove memory_region_iommu_set_iova_ranges() call
>   memory: Remove IOMMU MR iommu_set_iova_range API
> 
>  include/exec/memory.h              |  32 ----
>  include/hw/virtio/virtio-iommu.h   |   2 +
>  include/sysemu/host_iommu_device.h |  11 ++
>  hw/pci/pci.c                       |   8 +-
>  hw/vfio/common.c                   |  10 -
>  hw/vfio/container.c                |  17 ++
>  hw/vfio/iommufd.c                  |  18 ++
>  hw/virtio/virtio-iommu.c           | 296 +++++++++++++++++++----------
>  system/memory.c                    |  13 --
>  9 files changed, 249 insertions(+), 158 deletions(-)
> 
> -- 
> 2.41.0


