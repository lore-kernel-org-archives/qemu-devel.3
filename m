Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7AFC30653
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 21:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLr3w-0000Db-Ul; Mon, 24 Jun 2024 17:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLr3v-0000DF-M8
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:17:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLr3t-0005Ps-Nf
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719263837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7i86XXon0m8KCh7qZ7U0z744yZvCZjERZ3E1tfuh9hU=;
 b=WOfJ7QC+bt6wNXfmdO5dtbUp4b+GJdcfZBg+zP+ROVMBVmeA6/Utr5FJZd8u7XWl5Q1yRA
 Ori6khCXJftHWM388DcaH8HtJWYoRLOIDNMVOkPPdD5vaUotnZiXbnT0WbkQiHzBkrIH7v
 PRA/N4jAqbWHaAIwmDFeA5eb9WfJ+7w=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-qZEDXe2KNbao6swdGKNuoA-1; Mon, 24 Jun 2024 17:17:15 -0400
X-MC-Unique: qZEDXe2KNbao6swdGKNuoA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6af35481ea6so77936576d6.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 14:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719263835; x=1719868635;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7i86XXon0m8KCh7qZ7U0z744yZvCZjERZ3E1tfuh9hU=;
 b=T2YyX0zd0uCAR2J1Hyl/ODwS221cpvSrj3qxtDlk1NW3WIG8ED42P+AcWW6Z2DbfJ+
 y2TtyJN/SrG4O/28o3pYF+Xk5pHX0SKa3KN8J7hNPiUEN986mJM7Mq7kV/8gD/FET1mp
 U17HQ5aaS0D46nTu2jQjBj2IVzuors61/usplJEt0ZQrrO6VC1jev+MB34naUQSNb2Qb
 3jtS8NPGio53OwAcxZ6OBPxNMHlzVZXPCb4ZXjHk4n3s4lRz7w02FBJ7bCUa3lxdozUE
 CxVj8EQ6FGZvcWNkJMUQy+41IbNBLnxuKXNKsW1BqVgfk4XaQ4IgoMWc+tInPCyvS5yj
 d2gg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeCgWqg0gobNurbNStmTYC/z9qRpN33xgj2sk2RVnWg/4f2yXNLkMApYWK89mYngwtL3W/eOV/faIaGO6eI961wK2cFgM=
X-Gm-Message-State: AOJu0YycrjOCa6VCwQ8M5prz6oT0shCA+IDnqWLe0k5MXbz01hsbNwd1
 6cbzFJBt3/Rai4JY59STA92fC5B0HWNju2uab7yweHrEidh3OGSLlRX+QQPQl7Cd9jLyLAVqahC
 HXQ4rayUMi9Ja8XohriF3/hwHVRKml5util91gH+7sW6eW0ktcQzg
X-Received: by 2002:ad4:5fcf:0:b0:6b5:46ad:b92c with SMTP id
 6a1803df08f44-6b546adbb20mr69284136d6.1.1719263834969; 
 Mon, 24 Jun 2024 14:17:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1ginBSjo7d5Ld9eXQvvqApYXvRL4Vm6y1mQcFCETRK3+h6cRmatnGD2ioRHKVEo7mF99SGA==
X-Received: by 2002:ad4:5fcf:0:b0:6b5:46ad:b92c with SMTP id
 6a1803df08f44-6b546adbb20mr69283916d6.1.1719263834639; 
 Mon, 24 Jun 2024 14:17:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b51ef6e795sm37225086d6.141.2024.06.24.14.17.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 14:17:14 -0700 (PDT)
Message-ID: <8a655c20-3354-4b3b-b053-e0bfd10ab26e@redhat.com>
Date: Mon, 24 Jun 2024 23:17:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] VIRTIO-IOMMU/VFIO: Fix host iommu geometry
 handling for hotplugged devices
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 jean-philippe@linaro.org, peter.maydell@linaro.org, yanghliu@redhat.com,
 zhenzhong.duan@intel.com
Cc: alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com,
 berrange@redhat.com
References: <20240614095402.904691-1-eric.auger@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240614095402.904691-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 6/14/24 11:52 AM, Eric Auger wrote:
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
> 
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
>      https://lore.kernel.org/all/20231019134651.842175-1-eric.auger@redhat.com/
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
>    (see replies on v2)
> 
> 
> Eric Auger (8):
>    HostIOMMUDevice: Store the VFIO/VDPA agent
>    virtio-iommu: Implement set|unset]_iommu_device() callbacks
>    HostIOMMUDevice: Introduce get_iova_ranges callback
>    HostIOMMUDevice: Store the aliased bus and devfn
>    virtio-iommu: Compute host reserved regions
>    virtio-iommu: Remove the implementation of iommu_set_iova_range
>    hw/vfio: Remove memory_region_iommu_set_iova_ranges() call
>    memory: Remove IOMMU MR iommu_set_iova_range API
> 
>   include/exec/memory.h              |  32 ----
>   include/hw/virtio/virtio-iommu.h   |   2 +
>   include/sysemu/host_iommu_device.h |  11 ++
>   hw/pci/pci.c                       |   8 +-
>   hw/vfio/common.c                   |  10 -
>   hw/vfio/container.c                |  17 ++
>   hw/vfio/iommufd.c                  |  18 ++
>   hw/virtio/virtio-iommu.c           | 296 +++++++++++++++++++----------
>   system/memory.c                    |  13 --
>   9 files changed, 249 insertions(+), 158 deletions(-)
> 

Applied to vfio-next.

Thanks,

C.




