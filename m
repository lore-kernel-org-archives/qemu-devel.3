Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68695C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 12:20:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJWnj-0002Iz-Oi; Mon, 26 May 2025 08:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJWnh-0002El-4i
 for qemu-devel@nongnu.org; Mon, 26 May 2025 08:19:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uJWnc-0000BL-Ih
 for qemu-devel@nongnu.org; Mon, 26 May 2025 08:19:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748261959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=yjGz78lNZqce45P0w5v4tUTDkBBStHgYwQkSpHQPiWo=;
 b=FQHeQty+VRniM6PCUD2rr7ACW0A+WWM0Ne43SA9WIn0K5DKVfvPjifIY8Cf0voBuclCmY8
 yBkn1Vdstb7maKisMSx4Of0ACf/4dmb3XqHHfG4NbnA+Cs1UkxQEPXQfpNdgM7h/y8Xd+j
 BgDc7DY/SiUoQEN+D/J1d0UMn8Aiqjc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-nl9d3ybKNTukPscxDplTbw-1; Mon, 26 May 2025 08:19:17 -0400
X-MC-Unique: nl9d3ybKNTukPscxDplTbw-1
X-Mimecast-MFC-AGG-ID: nl9d3ybKNTukPscxDplTbw_1748261957
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a3684a5655so836200f8f.0
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 05:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748261956; x=1748866756;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yjGz78lNZqce45P0w5v4tUTDkBBStHgYwQkSpHQPiWo=;
 b=NC6ANOQooktSFPmw425eCY4yBzZy5xt0j+pJ2G5ksRK8fRmNeZXVTGoE4kURc/woDG
 xJbBfj+KBqVyXPQ3sb/8LILo4uRcyQ54QCfvf1F8gOe2LANYQmHYkKNzH9iCamHcjpUW
 ofyuWX43jb+ktwLiLy/kmppl9N5ZV/aSDQY0Bjq0p526trKk2OjdAKgnDgK5TwNJ1SBJ
 VOyBwg75BIPJN6dyoTEnxRijrFTnaVss1F8dXl9+lvn5g7Ses58kwXsqntFM1NEDHZW5
 glXoXJRw6LmuKaTrf4jL2YM7ynM7kHqXjFBnw3hRAxPBgB/dMNaG25BsDBKB/qTPj0NH
 jGEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiUMlbmOTsCRwwZgNGll3qzWUXxTdQDUzqXGvgCNiFzA+EVTxOM9ne7nFYAcAVfIqySAXN+Tl6juHD@nongnu.org
X-Gm-Message-State: AOJu0YzAr6fWUDWiQwLAFIV+Za/urZigy3dyKW1P8VmesqGoGGkm9rhQ
 DwNCwyfMRj3+6qSTZyQr9PPND24VwsNOVrvN/ICmpGQiwt5a0kcvW+JBALKkEEkzDl2ljfE90PR
 2Q9s+EXGkYbFIeIPe3HGG/DyHNc4MSSAisD/AKT6vf3iQ9FN5zHNGgeC9
X-Gm-Gg: ASbGncvTCtbAU0FINowWJNprRqP6J8ASAUWG3vkx+8bnTZ1wyopGghI6/sKscbVbV1V
 GPZBMCJy1nACng+o+HvAp/cuo+p4brVrEsRtR/R0E0nAG1Nfd94nWpDeQ0FedJ3BoVBOROqGoks
 JYbEZ0AHWAAI8IxwdBrQ3DEfQ0Y+OkYvC+7sesYTLsixIf4PkW/ZIFNUU0EhAn0KO9V4y3MUUC+
 0x7FqzaW4WckKEyoBh+4wvrhOlAYxZSHSoRRybWc8fET/RcfHr7D/UGrw1RN7xLkBv+IKXzr50g
 Qxfe2ZL6JAA7d60S6hNn35jdm5Fru+WImmx6LBllK/kDDK0bTA==
X-Received: by 2002:a05:6000:1ac9:b0:3a3:7077:ab99 with SMTP id
 ffacd0b85a97d-3a4cb48445amr7383062f8f.45.1748261956464; 
 Mon, 26 May 2025 05:19:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC4wDiBIjyoPVRMb26X1K8fC1AhdSRImIuIW5JQBsco0aXvuO5FAfN1MvGZk6oTFE34KDC7g==
X-Received: by 2002:a05:6000:1ac9:b0:3a3:7077:ab99 with SMTP id
 ffacd0b85a97d-3a4cb48445amr7383034f8f.45.1748261956024; 
 Mon, 26 May 2025 05:19:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442eb85a3b1sm279180155e9.0.2025.05.26.05.19.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 05:19:15 -0700 (PDT)
Message-ID: <946512ca-7fb6-4d56-a1f7-c14e507c00e4@redhat.com>
Date: Mon, 26 May 2025 14:19:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv3 00/21] intel_iommu: Enable stage-1 translation for
 passthrough device
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/21/25 13:14, Zhenzhong Duan wrote:
> Hi,
> 
> Per Jason Wang's suggestion, iommufd nesting series[1] is split into
> "Enable stage-1 translation for emulated device" series and
> "Enable stage-1 translation for passthrough device" series.
> 
> This series is 2nd part focusing on passthrough device. We don't do
> shadowing of guest page table for passthrough device but pass stage-1
> page table to host side to construct a nested domain. There was some
> effort to enable this feature in old days, see [2] for details.
> 
> The key design is to utilize the dual-stage IOMMU translation
> (also known as IOMMU nested translation) capability in host IOMMU.
> As the below diagram shows, guest I/O page table pointer in GPA
> (guest physical address) is passed to host and be used to perform
> the stage-1 address translation. Along with it, modifications to
> present mappings in the guest I/O page table should be followed
> with an IOTLB invalidation.
> 
>          .-------------.  .---------------------------.
>          |   vIOMMU    |  | Guest I/O page table      |
>          |             |  '---------------------------'
>          .----------------/
>          | PASID Entry |--- PASID cache flush --+
>          '-------------'                        |
>          |             |                        V
>          |             |           I/O page table pointer in GPA
>          '-------------'
>      Guest
>      ------| Shadow |---------------------------|--------
>            v        v                           v
>      Host
>          .-------------.  .------------------------.
>          |   pIOMMU    |  | Stage1 for GIOVA->GPA  |
>          |             |  '------------------------'
>          .----------------/  |
>          | PASID Entry |     V (Nested xlate)
>          '----------------\.--------------------------------------.
>          |             |   | Stage2 for GPA->HPA, unmanaged domain|
>          |             |   '--------------------------------------'
>          '-------------'
> For history reason, there are different namings in different VTD spec rev,
> Where:
>   - Stage1 = First stage = First level = flts
>   - Stage2 = Second stage = Second level = slts
> <Intel VT-d Nested translation>
> 
> There are some interactions between VFIO and vIOMMU
> * vIOMMU registers PCIIOMMUOps [set|unset]_iommu_device to PCI
>    subsystem. VFIO calls them to register/unregister HostIOMMUDevice
>    instance to vIOMMU at vfio device realize stage.
> * vIOMMU calls HostIOMMUDeviceIOMMUFD interface [at|de]tach_hwpt
>    to bind/unbind device to IOMMUFD backed domains, either nested
>    domain or not.
> 
> See below diagram:
> 
>          VFIO Device                                 Intel IOMMU
>      .-----------------.                         .-------------------.
>      |                 |                         |                   |
>      |       .---------|PCIIOMMUOps              |.-------------.    |
>      |       | IOMMUFD |(set_iommu_device)       || Host IOMMU  |    |
>      |       | Device  |------------------------>|| Device list |    |
>      |       .---------|(unset_iommu_device)     |.-------------.    |
>      |                 |                         |       |           |
>      |                 |                         |       V           |
>      |       .---------|  HostIOMMUDeviceIOMMUFD |  .-------------.  |
>      |       | IOMMUFD |            (attach_hwpt)|  | Host IOMMU  |  |
>      |       | link    |<------------------------|  |   Device    |  |
>      |       .---------|            (detach_hwpt)|  .-------------.  |
>      |                 |                         |       |           |
>      |                 |                         |       ...         |
>      .-----------------.                         .-------------------.
> 
> Based on Yi's suggestion, this design is optimal in sharing ioas/hwpt
> whenever possible and create new one on demand, also supports multiple
> iommufd objects and ERRATA_772415.
> 
> E.g., Under one guest's scope, Stage-2 page table could be shared by different
> devices if there is no conflict and devices link to same iommufd object,
> i.e. devices under same host IOMMU can share same stage-2 page table. If there
> is conflict, i.e. there is one device under non cache coherency mode which is
> different from others, it requires a separate stage-2 page table in non-CC mode.
> 
> SPR platform has ERRATA_772415 which requires no readonly mappings
> in stage-2 page table. This series supports creating VTDIOASContainer
> with no readonly mappings. If there is a rare case that some IOMMUs
> on a multiple IOMMU host have ERRATA_772415 and others not, this
> design can still survive.
> 
> See below example diagram for a full view:
> 
>        IntelIOMMUState
>               |
>               V
>      .------------------.    .------------------.    .-------------------.
>      | VTDIOASContainer |--->| VTDIOASContainer |--->| VTDIOASContainer  |-->...
>      | (iommufd0,RW&RO) |    | (iommufd1,RW&RO) |    | (iommufd0,only RW)|
>      .------------------.    .------------------.    .-------------------.
>               |                       |                              |
>               |                       .-->...                        |
>               V                                                      V
>        .-------------------.    .-------------------.          .---------------.
>        |   VTDS2Hwpt(CC)   |--->| VTDS2Hwpt(non-CC) |-->...    | VTDS2Hwpt(CC) |-->...
>        .-------------------.    .-------------------.          .---------------.
>            |            |               |                            |
>            |            |               |                            |
>      .-----------.  .-----------.  .------------.              .------------.
>      | IOMMUFD   |  | IOMMUFD   |  | IOMMUFD    |              | IOMMUFD    |
>      | Device(CC)|  | Device(CC)|  | Device     |              | Device(CC) |
>      | (iommufd0)|  | (iommufd0)|  | (non-CC)   |              | (errata)   |
>      |           |  |           |  | (iommufd0) |              | (iommufd0) |
>      .-----------.  .-----------.  .------------.              .------------.
> 
> This series is also a prerequisite work for vSVA, i.e. Sharing
> guest application address space with passthrough devices.
> 
> To enable stage-1 translation, only need to add "x-scalable-mode=on,x-flts=on".
> i.e. -device intel-iommu,x-scalable-mode=on,x-flts=on...
> 
> Passthrough device should use iommufd backend to work with stage-1 translation.
> i.e. -object iommufd,id=iommufd0 -device vfio-pci,iommufd=iommufd0,...
> 
> If host doesn't support nested translation, qemu will fail with an unsupported
> report.
> 
> Test done:
> - VFIO devices hotplug/unplug
> - different VFIO devices linked to different iommufds
> - vhost net device ping test
> 
> Fault report isn't supported in this series, we presume guest kernel always
> construct correct S1 page table for passthrough device. For emulated devices,
> the emulation code already provided S1 fault injection.
> 
> PATCH1-6:  Add HWPT-based nesting infrastructure support

The first 6 patches are all VFIO or IOMMUFD related. They are
mostly  additions and I didn't see anything wrong. They could
be merged in advance through the VFIO tree.

Thanks,

C.




> PATCH7-8:  Some cleanup work
> PATCH9:    cap/ecap related compatibility check between vIOMMU and Host IOMMU
> PATCH10-20:Implement stage-1 page table for passthrough device
> PATCH21:   Enable stage-1 translation for passthrough device
> 
> Qemu code can be found at [3]
> 
> TODO:
> - RAM discard
> - dirty tracking on stage-2 page table
> - Fault report to guest when HW Stage-1 faults
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02740.html
> [2] https://patchwork.kernel.org/project/kvm/cover/20210302203827.437645-1-yi.l.liu@intel.com/
> [3] https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_rfcv3
> 
> Thanks
> Zhenzhong
> 
> Changelog:
> rfcv3:
> - s/hwpt_id/id in iommufd_backend_invalidate_cache()'s parameter (Shameer)
> - hide vtd vendor specific caps in a wrapper union (Eric, Nicolin)
> - simplify return value check of get_cap() (Eric)
> - drop realize_late (Cedric, Eric)
> - split patch13:intel_iommu: Add PASID cache management infrastructure (Eric)
> - s/vtd_pasid_cache_reset/vtd_pasid_cache_reset_locked (Eric)
> - s/vtd_pe_get_domain_id/vtd_pe_get_did (Eric)
> - refine comments (Eric, Donald)
> 
> rfcv2:
> - Drop VTDPASIDAddressSpace and use VTDAddressSpace (Eric, Liuyi)
> - Move HWPT uAPI patches ahead(patch1-8) so arm nesting could easily rebase
> - add two cleanup patches(patch9-10)
> - VFIO passes iommufd/devid/hwpt_id to vIOMMU instead of iommufd/devid/ioas_id
> - add vtd_as_[from|to]_iommu_pasid() helper to translate between vtd_as and
>    iommu pasid, this is important for dropping VTDPASIDAddressSpace
> 
> 
> Yi Liu (3):
>    intel_iommu: Replay pasid binds after context cache invalidation
>    intel_iommu: Propagate PASID-based iotlb invalidation to host
>    intel_iommu: Refresh pasid bind when either SRTP or TE bit is changed
> 
> Zhenzhong Duan (18):
>    backends/iommufd: Add a helper to invalidate user-managed HWPT
>    vfio/iommufd: Add properties and handlers to
>      TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>    vfio/iommufd: Initialize iommufd specific members in
>      HostIOMMUDeviceIOMMUFD
>    vfio/iommufd: Implement [at|de]tach_hwpt handlers
>    vfio/iommufd: Save vendor specific device info
>    iommufd: Implement query of host VTD IOMMU's capability
>    intel_iommu: Rename vtd_ce_get_rid2pasid_entry to
>      vtd_ce_get_pasid_entry
>    intel_iommu: Optimize context entry cache utilization
>    intel_iommu: Check for compatibility with IOMMUFD backed device when
>      x-flts=on
>    intel_iommu: Introduce a new structure VTDHostIOMMUDevice
>    intel_iommu: Introduce two helpers vtd_as_from/to_iommu_pasid_locked
>    intel_iommu: Handle PASID entry removing and updating
>    intel_iommu: Handle PASID entry adding
>    intel_iommu: Introduce a new pasid cache invalidation type FORCE_RESET
>    intel_iommu: Bind/unbind guest page table to host
>    intel_iommu: ERRATA_772415 workaround
>    intel_iommu: Bypass replay in stage-1 page table mode
>    intel_iommu: Enable host device when x-flts=on in scalable mode
> 
>   hw/i386/intel_iommu_internal.h     |   56 +
>   include/hw/i386/intel_iommu.h      |   33 +-
>   include/system/host_iommu_device.h |   32 +
>   include/system/iommufd.h           |   54 +
>   backends/iommufd.c                 |   94 +-
>   hw/i386/intel_iommu.c              | 1670 ++++++++++++++++++++++++----
>   hw/vfio/iommufd.c                  |   40 +
>   backends/trace-events              |    1 +
>   hw/i386/trace-events               |   13 +
>   9 files changed, 1791 insertions(+), 202 deletions(-)
> 


