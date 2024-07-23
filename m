Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46FAEC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 14:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWGS8-0005qv-M3; Tue, 23 Jul 2024 10:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sWGS0-0005cg-OU
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sWGRx-0000ba-0S
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 10:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721744707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GV9p37d8sDc387aZLjzVEtGoOjnCRCVZxSyyWzrQsBs=;
 b=M6ceq/F6IfVmyScYmHJAhVAvupTyPxLFM7QeJvKTu0CR+2fZxQJhJsrLWb/qNaPSTF5Goh
 NRWs++lhJPm4VywPSovsikKcSiJ3aMn59fOsS3sXYE5zmuUF1Zz1DqObss3Ye9h8piC8E7
 7afgUREd4dP33bAR4FPSp+jHw7JYqmw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-FKsqTsSAMA--qa2HTa43ug-1; Tue, 23 Jul 2024 10:25:03 -0400
X-MC-Unique: FKsqTsSAMA--qa2HTa43ug-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-42726545762so39363255e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 07:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721744701; x=1722349501;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GV9p37d8sDc387aZLjzVEtGoOjnCRCVZxSyyWzrQsBs=;
 b=HdRe/+KG4lrMjM1pZ/dQpJcYYlYJ2bGlaDEYtJuyey9s+PGU3LkL/YnxrFuVuUqXnD
 v/5wN1WWqBk5y4Bexs75JDw4uETjh+yk0NBNpLVMNytN1CsqCr+WRqOzPLuIU5udV1C+
 Sc5CmkOX9pRjhP1vryipkvj8NURPmXNnqYHwu34N3+TAkc82pM2Q1D1c4kRtQRuSp5da
 yOz8hReDwhCUklQ1NyRSlneW/XPCkUuoGq37DzVvHDx6fGm6dkqO7hVTq1eKzhikuUiC
 h8o1E+9t1eqrmiDk399ao1zNdHRZuvxeAlmCeDrMf3EE1e0hMpizmvK3Fm0WcDx5HcWY
 aj+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWFbXcNjWlj0lhq/+u/0jl1Ny/Fh9QIqnp5brf5Pl1dcAb+HRkEc7aCEQiEGnyI4lWpTVjs4HJcn/VutKuZy9TQ7zxTCZE=
X-Gm-Message-State: AOJu0YzXeyIGYVxKw3pXXEgeE6Pry8L6omDpSDRq+rXlRU3lCnpVYz7d
 HyNUkWp/+sAvBCeJ79MHj+jOWg5UVFsgDRABdqLCDKtM7sMs97yoNEXsbSESq5w/QOs4Qma3zHf
 tgqaaRIW/p8/gVvcjViV4uWyASNYCA1vPdU9eTEOVGg4HI5lc13C5
X-Received: by 2002:a05:600c:3d8a:b0:426:5f75:1c2c with SMTP id
 5b1f17b1804b1-427dc5482e6mr57746365e9.11.1721744700616; 
 Tue, 23 Jul 2024 07:25:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8B82ZKG+iHUl4shx+XdQqPxUDgn3lsqXBac4RBa9uXjglRCyVHL4Eh6FIjRWLZd6HPVe6MQ==
X-Received: by 2002:a05:600c:3d8a:b0:426:5f75:1c2c with SMTP id
 5b1f17b1804b1-427dc5482e6mr57746175e9.11.1721744700034; 
 Tue, 23 Jul 2024 07:25:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e?
 ([2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d922c696sm161080155e9.40.2024.07.23.07.24.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 07:24:59 -0700 (PDT)
Message-ID: <11c8d699-f30b-474d-bf8e-c13ade55c388@redhat.com>
Date: Tue, 23 Jul 2024 16:24:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/9] hw/iommufd: IOMMUFD Dirty Tracking
To: Yi Liu <yi.l.liu@intel.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240722211326.70162-1-joao.m.martins@oracle.com>
 <de5a8b4d-7a3f-4957-b76d-9bb11d8d3de1@intel.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <de5a8b4d-7a3f-4957-b76d-9bb11d8d3de1@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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

Hello

On 7/23/24 16:23, Yi Liu wrote:
> On 2024/7/23 05:13, Joao Martins wrote:
>> This small series adds support for IOMMU dirty tracking support via the
>> IOMMUFD backend. The hardware capability is available on most recent x86
>> hardware (and these SMMUv3 in upcoming v6.11). The series is divided
>> organized as follows:
>>
>> * Patches 1 - 7: IOMMUFD backend support for dirty tracking;
>>
>> Introduce auto domains -- Patch 3 goes into more detail, but the gist is that
>> we will find and attach a device to a compatible IOMMU domain, or allocate a new
>> hardware pagetable *or* rely on kernel IOAS attach (for mdevs). Afterwards the
>> workflow is relatively simple:
>>
>> 1) Probe device and allow dirty tracking in the HWPT
>> 2) Toggling dirty tracking on/off
>> 3) Read-and-clear of Dirty IOVAs
>>
>> The heuristics selected for (1) were to always request the HWPT for
>> dirty tracking if supported, or rely on device dirty page tracking. This
>> is a little simplistic and we aren't necessarily utilizing IOMMU dirty
>> tracking even if we ask during hwpt allocation.
>>
>> The unmap case is deferred until further vIOMMU support with migration
>> is added[3] which will then introduce the usage of
>> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR in GET_DIRTY_BITMAP ioctl in the
>> dma unmap bitmap flow.
>>
>> * Patches 8 - 9: Don't block live migration where there's no VF dirty
>> tracker, considering that we have IOMMU dirty tracking.
>>
>> Comments and feedback appreciated (on patches 1, 5, 8, 9)
> 
> Hi Joao,
> 
> Do you have a github branch for this version? :)

There has been some updates since. Please use :

   https://github.com/legoater/qemu/commits/vfio-next

or you could wait for the PR to be merged :

   https://lore.kernel.org/qemu-devel/20240723140019.387786-1-clg@redhat.com/

Thanks,

C.


> 
>> Cheers,
>>      Joao
>>
>> P.S. Suggest v6.11-rc as hypervisor kernel as there's
>> some bugs fixed there with regards to IOMMU hugepage dirty tracking.
>>
>> Changes since v5[6]:
>> * Remove patches 1-4 as these were commited to vfio-next
>> * Add the Rb by Cedric and Zhenzhong (previously patches 7, 8, 10, 11)
>> * Introduce VFIODevice::iommu_dirty_tracking and use it on patch 5, 8
>> to store whether we can use IOMMU dirty tracking.
>>
>> Changes since v4[5]:
>> * Add various Reviewed-by in patches 2,3,4,6,8,11
>> * Change error messages to mention IOMMU (Zhenzhong)
>> * Better improve the checking of dirty page tracking in
>>    vfio_migration_realize() to detect per-device IOMMU instead of using
>>    container dirty_page_supported().
>> * Improve various commit messages (Eric)
>> * Extract the caps::hw_caps into its own patch as it was miosleading to
>> be hidden in another patch (new patch 7)
>> * Restructure patch 1 helper to be vfio_device_is_mdev() and use
>> vfio::mdev directly in rest of patches (Cedric)
>> * Improve error messages of set,query dirty tracking (Cedric)
>> * Add missing casts to uintptr and uint64_t* (Cedric)
>> * Add missing commens to struct doc from aw_bits removal (and hw_caps
>> addition) (Eric)
>> * Fix the detach flow in auto domains (Eric)
>> * Set hwpt to NULL on detach (Eric)
>> * Spurious line (Eric)
>>
>> Changes since v3[5]:
>> * Skip HostIOMMUDevice::realize for mdev, and introduce a helper to check if the VFIO
>>    device is mdev. (Zhenzhong)
>> * Skip setting IOMMU device for mdev (Zhenzhong)
>> * Add Zhenzhong review tag in patch 3
>> * Utilize vbasedev::bcontainer::dirty_pages_supported instead of introducing
>>    a new HostIOMMUDevice capability and thus remove the cap patch from the series (Zhenzhong)
>> * Move the HostIOMMUDevice::realize() to be part of VFIODevice initialization in attach_device()
>> while skipping it all together for mdev. (Cedric)
>> * Due to the previous item, had to remove aw_bits because it depends on device attach being
>> finished, instead defer it to when get_cap() gets called.
>> * Skip auto domains for mdev instead of purposedly erroring out (Zhenzhong)
>> * Pass errp in all cases, and instead just free the error in case of -EINVAL
>>    in most of all patches, and also pass Error* in iommufd_backend_alloc_hwpt() amd
>>    set/query dirty. This is made better thanks in part to skipping auto domains for mdev (Cedric)
>>
>> Changes since RFCv2[4]:
>> * Always allocate hwpt with IOMMU_HWPT_ALLOC_DIRTY_TRACKING even if
>> we end up not actually toggling dirty tracking. (Avihai)
>> * Fix error handling widely in auto domains logic and all patches (Avihai)
>> * Reuse iommufd_backend_get_device_info() for capabilities (Zhenzhong)
>> * New patches 1 and 2 taking into consideration previous comments.
>> * Store hwpt::flags to know if we have dirty tracking (Avihai)
>> * New patch 8, that allows to query dirty tracking support after
>> provisioning. This is a cleaner way to check IOMMU dirty tracking support
>> when vfio::migration is iniitalized, as opposed to RFCv2 via device caps.
>> device caps way is still used because at vfio attach we aren't yet with
>> a fully initialized migration state.
>> * Adopt error propagation in query,set dirty tracking
>> * Misc improvements overall broadly and Avihai
>> * Drop hugepages as it's a bit unrelated; I can pursue that patch
>> * separately. The main motivation is to provide a way to test
>> without hugepages similar to what vfio_type1_iommu.disable_hugepages=1
>> does.
>>
>> Changes since RFCv1[2]:
>> * Remove intel/amd dirty tracking emulation enabling
>> * Remove the dirtyrate improvement for VF/IOMMU dirty tracking
>> [Will pursue these two in separate series]
>> * Introduce auto domains support
>> * Enforce dirty tracking following the IOMMUFD UAPI for this
>> * Add support for toggling hugepages in IOMMUFD
>> * Auto enable support when VF supports migration to use IOMMU
>> when it doesn't have VF dirty tracking
>> * Add a parameter to toggle VF dirty tracking
>>
>> [0] https://lore.kernel.org/qemu-devel/20240201072818.327930-1-zhenzhong.duan@intel.com/
>> [1] https://lore.kernel.org/qemu-devel/20240201072818.327930-10-zhenzhong.duan@intel.com/
>> [2] https://lore.kernel.org/qemu-devel/20220428211351.3897-1-joao.m.martins@oracle.com/
>> [3] https://lore.kernel.org/qemu-devel/20230622214845.3980-1-joao.m.martins@oracle.com/
>> [4] https://lore.kernel.org/qemu-devel/20240212135643.5858-1-joao.m.martins@oracle.com/
>> [5] https://lore.kernel.org/qemu-devel/20240708143420.16953-1-joao.m.martins@oracle.com/
>> [6] https://lore.kernel.org/qemu-devel/20240719120501.81279-1-joao.m.martins@oracle.com/
>>
>> Joao Martins (9):
>>    vfio/iommufd: Introduce auto domain creation
>>    vfio/{iommufd,container}: Remove caps::aw_bits
>>    vfio/iommufd: Add hw_caps field to HostIOMMUDeviceCaps
>>    vfio/{iommufd,container}: Invoke HostIOMMUDevice::realize() during
>>      attach_device()
>>    vfio/iommufd: Probe and request hwpt dirty tracking capability
>>    vfio/iommufd: Implement VFIOIOMMUClass::set_dirty_tracking support
>>    vfio/iommufd: Implement VFIOIOMMUClass::query_dirty_bitmap support
>>    vfio/migration: Don't block migration device dirty tracking is
>>      unsupported
>>    vfio/common: Allow disabling device dirty page tracking
>>
>>   include/hw/vfio/vfio-common.h      |  13 +++
>>   include/sysemu/host_iommu_device.h |   5 +-
>>   include/sysemu/iommufd.h           |  11 ++
>>   backends/iommufd.c                 |  85 ++++++++++++++-
>>   hw/vfio/common.c                   |  19 ++--
>>   hw/vfio/container.c                |   9 +-
>>   hw/vfio/helpers.c                  |  11 ++
>>   hw/vfio/iommufd.c                  | 170 ++++++++++++++++++++++++++++-
>>   hw/vfio/migration.c                |  12 +-
>>   hw/vfio/pci.c                      |   3 +
>>   backends/trace-events              |   3 +
>>   11 files changed, 318 insertions(+), 23 deletions(-)
>>
> 


