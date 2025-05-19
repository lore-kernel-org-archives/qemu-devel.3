Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA122C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:39:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH2aW-0001nm-7U; Mon, 19 May 2025 11:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uH2aL-0001d5-2x
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:39:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ddutile@redhat.com>)
 id 1uH2aH-0007Xf-QT
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:39:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747669159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qgdz5/biVwy88AmaaFo/X9Og1EQ/ZXG7G4/5NsPPTzQ=;
 b=HRN35gb2U56Zr7gvQrNqWAKT/fC1iamnkfOMJLVLW4ZXZSNQE12VNAA+x8Z8QBoSePqy2s
 DFyzo4lHZOJEEnVGRSpfH8dYRD/3oDOOq+aNJ4icfDfcJLEgd6uEAF9ywd5oFKrxZ+ePV4
 aLA5XNgYyGhcNiyLSeelU+1xlVudCVw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-1ZKHaHimNBekin94Awl76A-1; Mon, 19 May 2025 11:39:18 -0400
X-MC-Unique: 1ZKHaHimNBekin94Awl76A-1
X-Mimecast-MFC-AGG-ID: 1ZKHaHimNBekin94Awl76A_1747669157
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7c579d37eeeso739378485a.0
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 08:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747669157; x=1748273957;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qgdz5/biVwy88AmaaFo/X9Og1EQ/ZXG7G4/5NsPPTzQ=;
 b=g654De4h7PFY6lvyGaGU7FGqnls6gZR6h+//Z2vmE3JU8rWAzl8+4nXvfjQFnWihRY
 3OLsnkslnMUdEW47RUGwx3lPRIMi24u+R/9SJBH0mYXJfXzFregYN5kQdpVKEJgoXem0
 L1eZ3N/E1IkmrRkzlx5gfwSc2Kt74jwBEd/EprJJPgrjxZv5YUFi1yRnIohxUnB3GiI6
 ajAZgK/rO4/HUvsI/hpi7euCHmUUuHWZMlFSDA0YN9UnW0D4VN08xb56spplodvMEQLz
 s2nDQue/6SO6HZIHibXkml76s109ix2GLaNDVJJyGJ6bd6JlLRBtifv40JNIryYB/hUK
 gcUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiiaZSzvaIsDfZAsyklyV87Ip19AijNSXvDF6lYdiVE1bZq8ey2HRs9Ugh6u3KloTdilQnr0qaQgZT@nongnu.org
X-Gm-Message-State: AOJu0Yx1aI2Jx8149LrFnMuvUQBmcdHw13jwUF51rlINUdkXYLrP7NI1
 XbMma+1XqA6hveZR5Pyo4zBN3BM8eMWyxMADeSz3BEtinc98aT+zv2izuuUTxxNWi7tlDmi0uld
 RtWJrtdjWvBuYDj1iVm5m8SUMA66dl5E7hIMu0lUAfpBFbeL8vAKE+RRx
X-Gm-Gg: ASbGncvc6PiYXsH2P1mIcTd3k5AqhF5juAPb6VeB69Wr+Vp2/tbaRYP3EaLd2VpnabJ
 ALZJRyoLdngKDh+eOOUhVpnOCbvGvUSLKIsOBVGwxWzeEy4wqaIoa8YH8dYQf6SOAZS0pPCkDdR
 P4RsV0ZshUt8KLdx5xVqm1plK30xUxIL3NZBeu+KY3feM8VCklrA0NLKAJOPrk88nN5KM+4TrCI
 vcVl+KfYkqlSpNI5tdzfsdoKM+dm9apIx3PA6GV4gptuDDMDGJfYfmR/qAgrkvNu0koi4urQWm/
 1/xpUq7MtJaw
X-Received: by 2002:a05:622a:59c3:b0:476:9474:9b73 with SMTP id
 d75a77b69052e-494b0939a78mr206321101cf.42.1747669157269; 
 Mon, 19 May 2025 08:39:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESM6u6LLPagnqfHk1UshqqQkxiJRdO+93HLzAU+XaQv+J/q+DXseYGWtfl1sL3Y4t6B+ejRA==
X-Received: by 2002:a05:622a:59c3:b0:476:9474:9b73 with SMTP id
 d75a77b69052e-494b0939a78mr206320491cf.42.1747669156672; 
 Mon, 19 May 2025 08:39:16 -0700 (PDT)
Received: from [192.168.40.164] ([70.105.235.240])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-494ae4fd718sm56344811cf.53.2025.05.19.08.39.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 May 2025 08:39:16 -0700 (PDT)
Message-ID: <6b9c1f0a-be56-451e-bb8d-833b402b78d8@redhat.com>
Date: Mon, 19 May 2025 11:39:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv2 00/20] intel_iommu: Enable stage-1 translation for
 passthrough device
Content-Language: en-US
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <eacfc52a-2dee-49a8-8994-67b738ece68d@redhat.com>
 <SJ0PR11MB6744472953C10F7858FF406F929CA@SJ0PR11MB6744.namprd11.prod.outlook.com>
From: Donald Dutile <ddutile@redhat.com>
In-Reply-To: <SJ0PR11MB6744472953C10F7858FF406F929CA@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ddutile@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URI_DOTEDU=0.001 autolearn=ham autolearn_force=no
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

Hey Zhenzhong,
Thanks for feedback. replies below.
- Don

On 5/19/25 4:37 AM, Duan, Zhenzhong wrote:
> Hi Donald,
> 
>> -----Original Message-----
>> From: Donald Dutile <ddutile@redhat.com>
>> Subject: Re: [PATCH rfcv2 00/20] intel_iommu: Enable stage-1 translation for
>> passthrough device
>>
>> Zhenzhong,
>>
>> Hi!
>> Eric asked me to review this series.
>> Since it's rather late since you posted will summarize review feedback
>> below/bottom.
>>
>> - Don
>>
>> On 2/19/25 3:22 AM, Zhenzhong Duan wrote:
>>> Hi,
>>>
>>> Per Jason Wang's suggestion, iommufd nesting series[1] is split into
>>> "Enable stage-1 translation for emulated device" series and
>>> "Enable stage-1 translation for passthrough device" series.
>>>
>>> This series is 2nd part focusing on passthrough device. We don't do
>>> shadowing of guest page table for passthrough device but pass stage-1
>>> page table to host side to construct a nested domain. There was some
>>> effort to enable this feature in old days, see [2] for details.
>>>
>>> The key design is to utilize the dual-stage IOMMU translation
>>> (also known as IOMMU nested translation) capability in host IOMMU.
>>> As the below diagram shows, guest I/O page table pointer in GPA
>>> (guest physical address) is passed to host and be used to perform
>>> the stage-1 address translation. Along with it, modifications to
>>> present mappings in the guest I/O page table should be followed
>>> with an IOTLB invalidation.
>>>
>>>           .-------------.  .---------------------------.
>>>           |   vIOMMU    |  | Guest I/O page table      |
>>>           |             |  '---------------------------'
>>>           .----------------/
>>>           | PASID Entry |--- PASID cache flush --+
>>>           '-------------'                        |
>>>           |             |                        V
>>>           |             |           I/O page table pointer in GPA
>>>           '-------------'
>>>       Guest
>>>       ------| Shadow |---------------------------|--------
>>>             v        v                           v
>>>       Host
>>>           .-------------.  .------------------------.
>>>           |   pIOMMU    |  |  FS for GIOVA->GPA     |
>>>           |             |  '------------------------'
>>>           .----------------/  |
>>>           | PASID Entry |     V (Nested xlate)
>>>           '----------------\.----------------------------------.
>>>           |             |   | SS for GPA->HPA, unmanaged domain|
>>>           |             |   '----------------------------------'
>>>           '-------------'
>>> Where:
>>>    - FS = First stage page tables
>>>    - SS = Second stage page tables
>>> <Intel VT-d Nested translation>
>>>
>> I'd prefer the use of 's1' for stage1/First stage, and 's2' for stage2/second stage.
>> We don't need different terms for the same technology in the iommu/iommufd
>> space(s).
> 
> OK, then I'd like to use stage1 and stage2 everywhere which is more verbose.
> 
your choice; in other kernel & qemu code I've seen, 's1' and 's2' are used quite frequently,
that's why I recommended it -- call it plagerizing! ;-)

>>
>>> There are some interactions between VFIO and vIOMMU
>>> * vIOMMU registers PCIIOMMUOps [set|unset]_iommu_device to PCI
>>>     subsystem. VFIO calls them to register/unregister HostIOMMUDevice
>>>     instance to vIOMMU at vfio device realize stage.
>>> * vIOMMU calls HostIOMMUDeviceIOMMUFD interface [at|de]tach_hwpt
>>>     to bind/unbind device to IOMMUFD backed domains, either nested
>>>     domain or not.
>>>
>>> See below diagram:
>>>
>>>           VFIO Device                                 Intel IOMMU
>>>       .-----------------.                         .-------------------.
>>>       |                 |                         |                   |
>>>       |       .---------|PCIIOMMUOps              |.-------------.    |
>>>       |       | IOMMUFD |(set_iommu_device)       || Host IOMMU  |    |
>>>       |       | Device  |------------------------>|| Device list |    |
>>>       |       .---------|(unset_iommu_device)     |.-------------.    |
>>>       |                 |                         |       |           |
>>>       |                 |                         |       V           |
>>>       |       .---------|  HostIOMMUDeviceIOMMUFD |  .-------------.  |
>>>       |       | IOMMUFD |            (attach_hwpt)|  | Host IOMMU  |  |
>>>       |       | link    |<------------------------|  |   Device    |  |
>>>       |       .---------|            (detach_hwpt)|  .-------------.  |
>>>       |                 |                         |       |           |
>>>       |                 |                         |       ...         |
>>>       .-----------------.                         .-------------------.
>>>
>>> Based on Yi's suggestion, this design is optimal in sharing ioas/hwpt
>>> whenever possible and create new one on demand, also supports multiple
>>> iommufd objects and ERRATA_772415.
>>>
>>> E.g., Stage-2 page table could be shared by different devices if there
>>> is no conflict and devices link to same iommufd object, i.e. devices
>>> under same host IOMMU can share same stage-2 page table. If there is
>> and 'devices under the same guest'.
>> Different guests cant be sharing the same stage-2 page tables.
> 
> Yes, will update.
> 
Thanks.

>>
>>> conflict, i.e. there is one device under non cache coherency mode
>>> which is different from others, it requires a separate stage-2 page
>>> table in non-CC mode.
>>>
>>> SPR platform has ERRATA_772415 which requires no readonly mappings
>>> in stage-2 page table. This series supports creating VTDIOASContainer
>>> with no readonly mappings. If there is a rare case that some IOMMUs
>>> on a multiple IOMMU host have ERRATA_772415 and others not, this
>>> design can still survive.
>>>
>>> See below example diagram for a full view:
>>>
>>>         IntelIOMMUState
>>>                |
>>>                V
>>>       .------------------.    .------------------.    .-------------------.
>>>       | VTDIOASContainer |--->| VTDIOASContainer |--->| VTDIOASContainer  |--
>>> ...
>>>       | (iommufd0,RW&RO) |    | (iommufd1,RW&RO) |    | (iommufd0,RW only)|
>>>       .------------------.    .------------------.    .-------------------.
>>>                |                       |                              |
>>>                |                       .-->...                        |
>>>                V                                                      V
>>>         .-------------------.    .-------------------.          .---------------.
>>>         |   VTDS2Hwpt(CC)   |--->| VTDS2Hwpt(non-CC) |-->...    | VTDS2Hwpt(CC) |-
>> ->...
>>>         .-------------------.    .-------------------.          .---------------.
>>>             |            |               |                            |
>>>             |            |               |                            |
>>>       .-----------.  .-----------.  .------------.              .------------.
>>>       | IOMMUFD   |  | IOMMUFD   |  | IOMMUFD    |              | IOMMUFD    |
>>>       | Device(CC)|  | Device(CC)|  | Device     |              | Device(CC) |
>>>       | (iommufd0)|  | (iommufd0)|  | (non-CC)   |              | (errata)   |
>>>       |           |  |           |  | (iommufd0) |              | (iommufd0) |
>>>       .-----------.  .-----------.  .------------.              .------------.
>>>
>>> This series is also a prerequisite work for vSVA, i.e. Sharing
>>> guest application address space with passthrough devices.
>>>
>>> To enable stage-1 translation, only need to add "x-scalable-mode=on,x-flts=on".
>>> i.e. -device intel-iommu,x-scalable-mode=on,x-flts=on...
>>>
>>> Passthrough device should use iommufd backend to work with stage-1
>> translation.
>>> i.e. -object iommufd,id=iommufd0 -device vfio-pci,iommufd=iommufd0,...
>>>
>>> If host doesn't support nested translation, qemu will fail with an unsupported
>>> report.
>>>
>>> Test done:
>>> - VFIO devices hotplug/unplug
>>> - different VFIO devices linked to different iommufds
>>> - vhost net device ping test
>>>
>>> PATCH1-8:  Add HWPT-based nesting infrastructure support
>>> PATCH9-10: Some cleanup work
>>> PATCH11:   cap/ecap related compatibility check between vIOMMU and Host
>> IOMMU
>>> PATCH12-19:Implement stage-1 page table for passthrough device
>>> PATCH20:   Enable stage-1 translation for passthrough device
>>>
>>> Qemu code can be found at [3]
>>>
>>> TODO:
>>> - RAM discard
>>> - dirty tracking on stage-2 page table
>>>
>>> [1] https://lists.gnu.org/archive/html/qemu-devel/2024-01/msg02740.html
>>> [2] https://patchwork.kernel.org/project/kvm/cover/20210302203827.437645-
>> 1-yi.l.liu@intel.com/
>>> [3]
>> https://github.com/yiliu1765/qemu/tree/zhenzhong/iommufd_nesting_rfcv2
>>>
>>> Thanks
>>> Zhenzhong
>>>
>>> Changelog:
>>> rfcv2:
>>> - Drop VTDPASIDAddressSpace and use VTDAddressSpace (Eric, Liuyi)
>>> - Move HWPT uAPI patches ahead(patch1-8) so arm nesting could easily rebase
>>> - add two cleanup patches(patch9-10)
>>> - VFIO passes iommufd/devid/hwpt_id to vIOMMU instead of
>> iommufd/devid/ioas_id
>>> - add vtd_as_[from|to]_iommu_pasid() helper to translate between vtd_as and
>>>     iommu pasid, this is important for dropping VTDPASIDAddressSpace
>>>
>>> Yi Liu (3):
>>>     intel_iommu: Replay pasid binds after context cache invalidation
>>>     intel_iommu: Propagate PASID-based iotlb invalidation to host
>>>     intel_iommu: Refresh pasid bind when either SRTP or TE bit is changed
>>>
>>> Zhenzhong Duan (17):
>>>     backends/iommufd: Add helpers for invalidating user-managed HWPT
>>>     vfio/iommufd: Add properties and handlers to
>>>       TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>>>     HostIOMMUDevice: Introduce realize_late callback
>>>     vfio/iommufd: Implement HostIOMMUDeviceClass::realize_late() handler
>>>     vfio/iommufd: Implement [at|de]tach_hwpt handlers
>>>     host_iommu_device: Define two new capabilities
>>>       HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP]
>>>     iommufd: Implement query of HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP]
>>>     iommufd: Implement query of HOST_IOMMU_DEVICE_CAP_ERRATA
>>>     intel_iommu: Rename vtd_ce_get_rid2pasid_entry to
>>>       vtd_ce_get_pasid_entry
>>>     intel_iommu: Optimize context entry cache utilization
>>>     intel_iommu: Check for compatibility with IOMMUFD backed device when
>>>       x-flts=on
>>>     intel_iommu: Introduce a new structure VTDHostIOMMUDevice
>>>     intel_iommu: Add PASID cache management infrastructure
>>>     intel_iommu: Bind/unbind guest page table to host
>>>     intel_iommu: ERRATA_772415 workaround
>>>     intel_iommu: Bypass replay in stage-1 page table mode
>>>     intel_iommu: Enable host device when x-flts=on in scalable mode
>>>
>>>    hw/i386/intel_iommu_internal.h     |   56 +
>>>    include/hw/i386/intel_iommu.h      |   33 +-
>>>    include/system/host_iommu_device.h |   40 +
>>>    include/system/iommufd.h           |   53 +
>>>    backends/iommufd.c                 |   58 +
>>>    hw/i386/intel_iommu.c              | 1660 ++++++++++++++++++++++++----
>>>    hw/vfio/common.c                   |   17 +-
>>>    hw/vfio/iommufd.c                  |   48 +
>>>    backends/trace-events              |    1 +
>>>    hw/i386/trace-events               |   13 +
>>>    10 files changed, 1776 insertions(+), 203 deletions(-)
>>>
>> Relative to the patches:
>> Patch 1: As Eric eluded to, a proper description for the patch should be written,
>> and the title should change 'helpers' to 'helper'
> 
> This is addressed in [1]
> 
> [1] https://github.com/yiliu1765/qemu/commits/zhenzhong/iommufd_nesting_rfcv3.wip/
> 
ok.
>>
>> Patch 2:
>> (1) Introduce 'realize_late()' interface, but leave the reader wondering 'ah, why?
>> what?' ... after reading farther down the series, I learn more about realize_late(),
>> but more on that later...
> 
> realize_late() has been removed in [1]
> 
Yes, I saw. :)

>> (2) For my education, can you provide ptrs to VFIO & VPDA code paths that
>> demonstrate the need for different [at|de]tach_<>_hwpt()
> 
> Google help me find this link https://lkml.iu.edu/2309.2/08079.html
> specially https://gitlab.com/lulu6/gitlabqemutmp/-/commit/354870ff6bd9bac80c9fc5c7f944331cb24b0331
> 
thanks for vdpa ptrs; I have my diff work cut out for me, but heh, I asked for it! :)

>>
>> Patch 3: Why can't the realize() be moved to after attach?  isn't realize() suppose
>> to indicate 'all is setup and object can now be used' -- apologies for what could
>> be a dumb question, as that's my understanding of realize().  If the argument is
>> such that there needs to be two steps, how does the first realize() that put the
>> object into a used state <somehow> wait until realize_late()?
>>
>> Patch 4: Shouldn't the current/existing realize callback just be overwritten with
>> the later one, when this is needed?
> 
> realize_late() has been removed in [1]
> 
+1

>>
>> Patch 5: no issues.
>>
>> Patch 6: ewww -- fs1gp ... we use underlines all over the place for multi-word
>> elements; so how about 's1_1g_pg'
>>            -- how many places is that really used that multiple underlines is an issue?
> 
> This is vtd specific, so to follow VTD spec's naming so that we can easily find its definition by searching fs1gp.
> 
>>
ok.  You had mentioned earlier that you used VTD nomenclature, so I should have concluded the same here. /my bad.

>> Patch 7: intel-iommu-specific callbacks in the common vfio & iommufd-backend
>> code; nack. This won't compile w/intel-iommu included with iommufd... I think
>> backend, intel-iommu hw-caps should provide the generic 'caps' boolean-type
>> values/states; ... and maybe they should be extracted via vfio? .... like
>>       case HOST_IOMMU_DEVICE_CAP_AW_BITS:
>>           return vfio_device_get_aw_bits(hiod->agent);
>>
>> Patch 8: Again, VTD-specific code in IOMMUFD is a nack; again, maybe via vfio,
>> or a direct call into an iommu-device-cap api.
> 
> Patch 7&8 addressed in [1]
> 
+1
>>
>> Patch 9: no issues.
>>
>> Patch 10: "except it's stale"  likely "except when it's entry is stale" ?
> 
> addressed in [1]
> 
+1
>>            Did you ever put some tracing in to capture avg hits in cache? ... if so, add
>> as a comment.
>>            Otherwise, looks good.
>>
>> Patch 11: Apologies, I don't know what 'flts' stands for, and why it is relative to 2-
>> stage mapping, or SIOV.  Could you add verbage to explain the use of it, as the
>> rest of this patch doesn't make any sense to me without the background.
>> The patch introduces hw-info-type (none or intel), and then goes on to add a
>> large set of checks; seems like the caps & this checking should go together (split
>> for each cap; put all caps together & the check...).
> 
> OK, will do. There are some explanations in cover-letter.
> For history reason, old vtd spec define stage-1 as first level then switch to first stage.
> 
So 'flts' is 'first level then switch' .

>>
>> Patch 12: Why isn't HostIOMMUDevice extended to have another iommu-specif
>> element, opaque in HostIOMMUDevice, but set to specific IOMMU in use?   e.g.
>> void *hostiommustate;
> 
> Yes, that's possible, but we want to make a generic interface between VFIO/VDPA and vIOMMU.
> 
ok. I don't understand how VFIO & VPDA complicate that add.

>>
>> Patch 13: Isn't PASID just an extension/addition of BDF id? and doesn't each
>> PASID have its own address space?
> 
> Yes, it is.
> 
>> So, why isn't it handle via a uniqe AS cache like 'any other device'?  Maybe I'm
>> thinking too SMMU-StreamID, which can be varying length, depending on
>> subsystem support.  I see what appears to be sid+pasid calls to do the AS lookups;
>> hmm, so maybe this is the generalized BDF+pasid AS lookup?  if so, maybe a
>> better description stating this transition to a wider stream-id would set the code
>> context better.
> 
> Not quite get..
> 
I'm looking for a better description that states the AS cache lookup is broadened from bdf
to bdf+pasid.

>> As for the rest of the (400 intel-iommu) code, I'm not that in-depth in intel-iommu
>> to determine if its all correct or not.
>>
>> Patch 14: Define PGTT; the second paragraph seem self-contradicting -- it says it
>> uses a 2-stage page table in each case, but it implies it should be different.  At 580
>> lines of code changes, you win! ;-)
> 
> The host side's using nested or only stage-2 page table depends on PGTT's setting in guest.
> 
Thanks for clarification.

>>
>> Patch 15: Read-only and Read/write areas have different IOMMUFDs?  is that an
>> intel-iommu requriement?
>>            At least this intel-iommu-errata code is only in hw/i386/<> modules.
> 
> No, if ERRATA_772415, read-only areas should not be mapped, so we allocate a new VTDIOASContainer to hold only read/write areas mapping.
> We can use same IOMMUFDs for different VTDIOASContainer.
> 
ah yes; I got hung-up on different mappings, and didn't back up to AS-container split & same IOMMUFD.

>>
>> Patch 16: Looks reasonable.  What does the 'SI' mean after "CACHE_DEV",
>> "CACHE_DOM" & "CACHE_PASID" ? -- stream-invalidation?
> 
> VTD_PASID_CACHE_DEVSI stands for 'pasid cache device selective invalidation',
> VTD_PASID_CACHE_DOMSI means 'pasid cache domain selective invalidation'.
> 
That explanation helps. :)  maybe put a short blurb in the commit log, or code,
so one doesn't have to be a ninja-VTD spec consumer to comprehend those (important) diffs.

> Thanks
> Zhenzhong
> 
Again, thanks for the reply.
Looking fwd to the rfcv3 (on list) or move to v1-POST.
- Don


