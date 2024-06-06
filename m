Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B0AC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 15:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFFHM-0006YW-2a; Thu, 06 Jun 2024 11:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sFFHJ-0006YI-GE
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 11:43:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sFFHH-0006nE-73
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 11:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717688625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GOck/vCW/Md5F/5uV3/g97WAXHAqUlG7W/eStirmpvc=;
 b=GoaZL8qeSnEPaNehIIVQQJEy1AATpmjm54IilX8Rgz81VjaaqUrAbmEZg3WfUCMh2bOqcz
 JAWnTuY78UgFA0a3JVgJhmRiJ0vx6gKGTTIm4+sDSHhJwnBdOZ2Q+3XV4QB7hyTJy7QyNd
 szujbahyJJccVD6XAPjrMIyfaWs5Bs0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-q0IkRLt5O26JYwIDdPxmMw-1; Thu, 06 Jun 2024 11:43:41 -0400
X-MC-Unique: q0IkRLt5O26JYwIDdPxmMw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-794fd7ff611so121158085a.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 08:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717688621; x=1718293421;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GOck/vCW/Md5F/5uV3/g97WAXHAqUlG7W/eStirmpvc=;
 b=Scpx17Jd4wIEq3hm9Ihy4oIiyK+8ZH4zZgTAD8aN4x2tU6xVCPG7Zmmh2JaUqP4OnV
 Jq506CB8bZlrer8vqKzfwR72w8w7DfqqlxRKymJeIaDI8XO6qGHMBuKB+Jc1CNIGkmHa
 RXjj2ciXjBtKOK8gmKAo+Mb3RD/D9PZUMj8CEnCHEHz5WSocZFYD5H4o+UkPKXbtDYE6
 ZcmI59nCVlHyBQcPvCCVZw45/3OmXpweSedtR9+s5atns5TFnRewFIH8bigKAhzCvIgH
 zUwfX/Liu+NCvCYw/LUrXbzDzA3UTPtROfwlR80ecujbxwWrScUqmyinDQpOS3erVIX8
 J0Lg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/xFf9UutwsodLEXR0hG2anot2k+WHl0W0olgVf2n7Gxe8JKS5wYO3PBEAqFlV86s0FTrAsC05r2kv7JkGYKfIEMbcTQE=
X-Gm-Message-State: AOJu0YyNWAgjzu7GDxqFyZuzcz34sczPgnN1KDN2tKhV2x05cFlX5v5B
 Cqh09esdLB4lhB632D1Ezcv9FLOtttL+KDsx/n6p7VNKrBAvNj6J0DtUKXvcIh2SK7Ij7AL+Al0
 vmcGcaT3wlAZ0JEZhEy2bejz1eW9XTzeB0alMBddNzvfYHZK+/bz1
X-Received: by 2002:a05:620a:a01:b0:795:1eda:7f08 with SMTP id
 af79cd13be357-79523b3f9eemr687731785a.0.1717688620804; 
 Thu, 06 Jun 2024 08:43:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaevJyPeRWsg7brr5S6kHr0O2CV8M4AqvyFUjqMqbaIM+aIAqYCTJ22oacVzhFp1c7hMyu6A==
X-Received: by 2002:a05:620a:a01:b0:795:1eda:7f08 with SMTP id
 af79cd13be357-79523b3f9eemr687727785a.0.1717688620315; 
 Thu, 06 Jun 2024 08:43:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44038ac8860sm5492921cf.58.2024.06.06.08.43.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 08:43:39 -0700 (PDT)
Message-ID: <088a0db6-ae69-4d85-a817-1685d4053d17@redhat.com>
Date: Thu, 6 Jun 2024 17:43:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/15] vfio: VFIO migration support with vIOMMU
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Avihai Horon <avihaih@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
References: <20230622214845.3980-1-joao.m.martins@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230622214845.3980-1-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hello Joao,

On 6/22/23 23:48, Joao Martins wrote:
> Hey,
> 
> This series introduces support for vIOMMU with VFIO device migration,
> particurlarly related to how we do the dirty page tracking.
> 
> Today vIOMMUs serve two purposes: 1) enable interrupt remaping 2)
> provide dma translation services for guests to provide some form of
> guest kernel managed DMA e.g. for nested virt based usage; (1) is specially
> required for big VMs with VFs with more than 255 vcpus. We tackle both
> and remove the migration blocker when vIOMMU is present provided the
> conditions are met. I have both use-cases here in one series, but I am happy
> to tackle them in separate series.
> 
> As I found out we don't necessarily need to expose the whole vIOMMU
> functionality in order to just support interrupt remapping. x86 IOMMUs
> on Windows Server 2018[2] and Linux >=5.10, with qemu 7.1+ (or really
> Linux guests with commit c40aaaac10 and since qemu commit 8646d9c773d8)
> can instantiate a IOMMU just for interrupt remapping without needing to
> be advertised/support DMA translation. AMD IOMMU in theory can provide
> the same, but Linux doesn't quite support the IR-only part there yet,
> only intel-iommu.
> 
> The series is organized as following:
> 
> Patches 1-5: Today we can't gather vIOMMU details before the guest
> establishes their first DMA mapping via the vIOMMU. So these first four
> patches add a way for vIOMMUs to be asked of their properties at start
> of day. I choose the least churn possible way for now (as opposed to a
> treewide conversion) and allow easy conversion a posteriori. As
> suggested by Peter Xu[7], I have ressurected Yi's patches[5][6] which
> allows us to fetch PCI backing vIOMMU attributes, without necessarily
> tieing the caller (VFIO or anyone else) to an IOMMU MR like I
> was doing in v3.
> 
> Patches 6-8: Handle configs with vIOMMU interrupt remapping but without
> DMA translation allowed. Today the 'dma-translation' attribute is
> x86-iommu only, but the way this series is structured nothing stops from
> other vIOMMUs supporting it too as long as they use
> pci_setup_iommu_ops() and the necessary IOMMU MR get_attr attributes
> are handled. The blocker is thus relaxed when vIOMMUs are able to toggle
> the toggle/report DMA_TRANSLATION attribute. With the patches up to this set,
> we've then tackled item (1) of the second paragraph.
> 
> Patches 9-15: Simplified a lot from v2 (patch 9) to only track the complete
> IOVA address space, leveraging the logic we use to compose the dirty ranges.
> The blocker is once again relaxed for vIOMMUs that advertise their IOVA
> addressing limits. This tackles item (2). So far I mainly use it with
> intel-iommu, although I have a small set of patches for virtio-iommu per
> Alex's suggestion in v2.
> 
> Comments, suggestions welcome. Thanks for the review!


I spent sometime refreshing your series on upstream QEMU (See [1]) and
gave migration a try with CX-7 VF. LGTM. It doesn't seem we are far
from acceptance in QEMU 9.1. Are we ?

First, I will resend these with the changes I made :

   vfio/common: Extract vIOMMU code from vfio_sync_dirty_bitmap()
   vfio/common: Move dirty tracking ranges update to helper()

I guess the PCIIOMMUOps::get_iommu_attr needs a close review. Is
IOMMU_ATTR_DMA_TRANSLATION a must have ?

The rest is mostly VFIO internals for dirty tracking.

Thanks,

C.

[1] https://github.com/legoater/qemu/commits/vfio-9.1


> 
> Regards,
> 	Joao
> 
> Changes since v3[8]:
> * Pick up Yi's patches[5][6], and rework the first four patches.
>    These are a bit better splitted, and make the new iommu_ops *optional*
>    as opposed to a treewide conversion. Rather than returning an IOMMU MR
>    and let VFIO operate on it to fetch attributes, we instead let the
>    underlying IOMMU driver fetch the desired IOMMU MR and ask for the
>    desired IOMMU attribute. Callers only care about PCI Device backing
>    vIOMMU attributes regardless of its topology/association. (Peter Xu)
>    These patches are a bit better splitted compared to original ones,
>    and I've kept all the same authorship and note the changes from
>    original where applicable.
> * Because of the rework of the first four patches, switch to
>    individual attributes in the VFIOSpace that track dma_translation
>    and the max_iova. All are expected to be unused when zero to retain
>    the defaults of today in common code.
> * Improve the migration blocker message of the last patch to be
>    more obvious that vIOMMU migration blocker is added when no vIOMMU
>    address space limits are advertised. (Patch 15)
> * Cast to uintptr_t in IOMMUAttr data in intel-iommu (Philippe).
> * Switch to MAKE_64BIT_MASK() instead of plain left shift (Philippe).
> * Change diffstat of patches with scripts/git.orderfile (Philippe).
> 
> Changes since v2[3]:
> * New patches 1-9 to be able to handle vIOMMUs without DMA translation, and
> introduce ways to know various IOMMU model attributes via the IOMMU MR. This
> is partly meant to address a comment in previous versions where we can't
> access the IOMMU MR prior to the DMA mapping happening. Before this series
> vfio giommu_list is only tracking 'mapped GIOVA' and that controlled by the
> guest. As well as better tackling of the IOMMU usage for interrupt-remapping
> only purposes.
> * Dropped Peter Xu ack on patch 9 given that the code changed a bit.
> * Adjust patch 14 to adjust for the VFIO bitmaps no longer being pointers.
> * The patches that existed in v2 of vIOMMU dirty tracking, are mostly
> * untouched, except patch 12 which was greatly simplified.
> 
> Changes since v1[4]:
> - Rebased on latest master branch. As part of it, made some changes in
>    pre-copy to adjust it to Juan's new patches:
>    1. Added a new patch that passes threshold_size parameter to
>       .state_pending_{estimate,exact}() handlers.
>    2. Added a new patch that refactors vfio_save_block().
>    3. Changed the pre-copy patch to cache and report pending pre-copy
>       size in the .state_pending_estimate() handler.
> - Removed unnecessary P2P code. This should be added later on when P2P
>    support is added. (Alex)
> - Moved the dirty sync to be after the DMA unmap in vfio_dma_unmap()
>    (patch #11). (Alex)
> - Stored vfio_devices_all_device_dirty_tracking()'s value in a local
>    variable in vfio_get_dirty_bitmap() so it can be re-used (patch #11).
> - Refactored the viommu device dirty tracking ranges creation code to
>    make it clearer (patch #15).
> - Changed overflow check in vfio_iommu_range_is_device_tracked() to
>    emphasize that we specifically check for 2^64 wrap around (patch #15).
> - Added R-bs / Acks.
> 
> [0] https://lore.kernel.org/qemu-devel/20230222174915.5647-1-avihaih@nvidia.com/
> [1] https://lore.kernel.org/qemu-devel/c66d2d8e-f042-964a-a797-a3d07c260a3b@oracle.com/
> [2] https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/oem-kernel-dma-protection
> [3] https://lore.kernel.org/qemu-devel/20230222174915.5647-1-avihaih@nvidia.com/
> [4] https://lore.kernel.org/qemu-devel/20230126184948.10478-1-avihaih@nvidia.com/
> [5] https://lore.kernel.org/all/20210302203827.437645-5-yi.l.liu@intel.com/
> [6] https://lore.kernel.org/all/20210302203827.437645-6-yi.l.liu@intel.com/
> [7] https://lore.kernel.org/qemu-devel/ZH9Kr6mrKNqUgcYs@x1n/
> [8] https://lore.kernel.org/qemu-devel/20230530175937.24202-1-joao.m.martins@oracle.com/
> 
> Avihai Horon (4):
>    memory/iommu: Add IOMMU_ATTR_MAX_IOVA attribute
>    intel-iommu: Implement IOMMU_ATTR_MAX_IOVA get_attr() attribute
>    vfio/common: Extract vIOMMU code from vfio_sync_dirty_bitmap()
>    vfio/common: Optimize device dirty page tracking with vIOMMU
> 
> Joao Martins (7):
>    memory/iommu: Add IOMMU_ATTR_DMA_TRANSLATION attribute
>    intel-iommu: Implement get_attr() method
>    vfio/common: Track whether DMA Translation is enabled on the vIOMMU
>    vfio/common: Relax vIOMMU detection when DMA translation is off
>    vfio/common: Move dirty tracking ranges update to helper
>    vfio/common: Support device dirty page tracking with vIOMMU
>    vfio/common: Block migration with vIOMMUs without address width limits
> 
> Yi Liu (4):
>    hw/pci: Add a pci_setup_iommu_ops() helper
>    hw/pci: Refactor pci_device_iommu_address_space()
>    hw/pci: Introduce pci_device_iommu_get_attr()
>    intel-iommu: Switch to pci_setup_iommu_ops()
> 
>   include/exec/memory.h         |   4 +-
>   include/hw/pci/pci.h          |  11 ++
>   include/hw/pci/pci_bus.h      |   1 +
>   include/hw/vfio/vfio-common.h |   2 +
>   hw/i386/intel_iommu.c         |  53 +++++++-
>   hw/pci/pci.c                  |  58 +++++++-
>   hw/vfio/common.c              | 241 ++++++++++++++++++++++++++--------
>   hw/vfio/pci.c                 |  22 +++-
>   8 files changed, 329 insertions(+), 63 deletions(-)
> 


