Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2E0C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 13:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVtSc-0004hK-KF; Mon, 22 Jul 2024 09:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sVtSP-0004F4-11
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 09:52:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sVtSM-0006LF-Os
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 09:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721656321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+BVpcDsc9aC56P5jFcJFfnJ8kLarbQImNMndQ4+ZXgE=;
 b=g67cSGRH7tSMdv4dNOOJVpp6Q/UidznJMu4Gn29Lg03+zR6oFGlV3gYeNz8Hm2iVRjVh79
 QvAGfFPX4NuzcIU+1rTUqsPTMUAjGmLKPfrQzj/ZemvqOhNQgFzgrf2abxx7iTRXjJ26UD
 TG53GFB3obrLVFQehZcqm5rFMQYPf8E=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-dHeZ-e6mMiy6FogMLj6Wnw-1; Mon, 22 Jul 2024 09:52:00 -0400
X-MC-Unique: dHeZ-e6mMiy6FogMLj6Wnw-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-447dc559df8so53018231cf.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 06:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721656319; x=1722261119;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+BVpcDsc9aC56P5jFcJFfnJ8kLarbQImNMndQ4+ZXgE=;
 b=qUEw1XI1JfbJ8x64CQFl9HMZvRSJVZ6+NmlLfJZN79rDSTOH8AKTXx+6BuGDqC0jZP
 LdwJgYtijgO5k1dB2qrIW4tMJ1h1R2dzNh0Uy3W/ZQRule0SMbkOHG+FooYmtPn4/z2w
 GkSGQo5Ngwm+SnAOVg62ybrJpF2y2hrH5lP4HycFcnneM7eeRWfU6IwgHZ/frrGvDWhx
 kWVr9FQt1nQiYzJHZkOW3OgGQa2iT0U7la9kRPDlyTh1YJZ5fDAiLwEfDfxZos0xAm40
 UXrrV8TXqTGRN8Dp30Ui7Jr1IxD3liNlaeTR8r8J7w2qnru5eOsm5lWWWL2GSQ32WdRh
 rFeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzUasRuxnhSrYz8Ww5LcppbCRHDdCgwQipTjNwkA5RzzwXk1lCRepVnbS+xS0da7JmLJNvthSRBkvNG0qEyouyEV4GQcI=
X-Gm-Message-State: AOJu0YxG3A4fJszTIEI5sC0Cghrh14g8Bm9+8jWXH2e4+nMevGPoRj7p
 IN+EAr9VW4ZYb8vNpOL3vrPz5SOPW5/0ZxAJQ5ahU8lDoicFdjOpDeKg1taCEHmRWF2jRysgwhV
 4ETe39GvN2+7NoFDMQ+2Rqk6u75pkfAOCf3dzaO6lbkljY03umgutv3vNPxn4
X-Received: by 2002:a05:622a:1111:b0:447:f922:64fd with SMTP id
 d75a77b69052e-44fa52b0afemr114850861cf.35.1721656319330; 
 Mon, 22 Jul 2024 06:51:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3grdmegoKvz8fd4EprNRwGJKbSGdWnIam5lv5oy9l/JnD7HNX/sqHjeoOiuWrXfs+/xDPAg==
X-Received: by 2002:a05:622a:1111:b0:447:f922:64fd with SMTP id
 d75a77b69052e-44fa52b0afemr114850541cf.35.1721656318880; 
 Mon, 22 Jul 2024 06:51:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e?
 ([2a01:e0a:9e2:9000:bed7:42c6:fb19:d12e])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44f9cd43183sm33575511cf.55.2024.07.22.06.51.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 06:51:58 -0700 (PDT)
Message-ID: <0c4fb2db-0b55-41a3-988d-8847173d558d@redhat.com>
Date: Mon, 22 Jul 2024 15:51:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/13] hw/iommufd: IOMMUFD Dirty Tracking
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240719120501.81279-1-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/19/24 14:04, Joao Martins wrote:
> This small series adds support for IOMMU dirty tracking support via the
> IOMMUFD backend. The hardware capability is available on most recent x86
> hardware. The series is divided organized as follows:
> 
> * Patch 1-2: Fixes a regression into mdev support with IOMMUFD. This
>               one is independent of the series but happened to cross it
>               while testing mdev with this series
> 
> * Patch 3: Adds a support to iommufd_get_device_info() for capabilities
> 
> * Patches 4 - 11: IOMMUFD backend support for dirty tracking;
> 
> Introduce auto domains -- Patch 5 goes into more detail, but the gist is that
> we will find and attach a device to a compatible IOMMU domain, or allocate a new
> hardware pagetable *or* rely on kernel IOAS attach (for mdevs). Afterwards the
> workflow is relatively simple:
> 
> 1) Probe device and allow dirty tracking in the HWPT
> 2) Toggling dirty tracking on/off
> 3) Read-and-clear of Dirty IOVAs
> 
> The heuristics selected for (1) were to always request the HWPT for
> dirty tracking if supported, or rely on device dirty page tracking. This
> is a little simplistic and we aren't necessarily utilizing IOMMU dirty
> tracking even if we ask during hwpt allocation.
> 
> The unmap case is deferred until further vIOMMU support with migration
> is added[3] which will then introduce the usage of
> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR in GET_DIRTY_BITMAP ioctl in the
> dma unmap bitmap flow.
> 
> * Patches 12-13: Don't block live migration where there's no VF dirty
> tracker, considering that we have IOMMU dirty tracking.
> 
> Comments and feedback appreciated. Thanks for the review so far and
> apologies in advance if I missed any comment.
> 
> Cheers,
>      Joao
> 
> P.S. Suggest linux-next (or future v6.11) as hypervisor kernel as there's
> some bugs fixed there with regards to IOMMU hugepage dirty tracking.
> 
> Changes since v4[6]:
> * Add various Reviewed-by in patches 2,3,4,6,8,11
> * Change error messages to mention IOMMU (Zhenzhong)
> * Better improve the checking of dirty page tracking in
>    vfio_migration_realize() to detect per-device IOMMU instead of using
>    container dirty_page_supported().
> * Improve/Cleanup various commit messages to be clear (Eric)
> * Extract the caps::hw_caps into its own patch as it was miosleading to
> be hidden in another patch (new patch 7)
> * Restructure patch 1 helper to be vfio_device_is_mdev() and use
> vfio::mdev directly in rest of patches (Cedric)
> * Improve error messages of set,query dirty tracking (Cedric)
> * Add missing casts to uintptr and uint64_t* (Cedric)
> * Improve terciary check in set_dirty_Tracking (Cedric)
> * Add missing commens to struct doc from aw_bits removal (and hw_caps
> addition) (Eric)
> * Fix the detach flow in auto domains (Eric)
> * Add new helper vfio_device_hiod_realize() and use it in backends
> * (Cedric)
> * Move introduction of iommufd_hwpt_dirty_tracking() in the predecessor
> * patch (Cedric)
> * Set hwpt to NULL on detach (Eric)
> * Spurious line (Eric)
> 
> Changes since v3[5]:
> * Skip HostIOMMUDevice::realize for mdev, and introduce a helper to check if the VFIO
>    device is mdev. (Zhenzhong)
> * Skip setting IOMMU device for mdev (Zhenzhong)
> * Add Zhenzhong review tag in patch 3
> * Utilize vbasedev::bcontainer::dirty_pages_supported instead of introducing
>    a new HostIOMMUDevice capability and thus remove the cap patch from the series (Zhenzhong)
> * Move the HostIOMMUDevice::realize() to be part of VFIODevice initialization in attach_device()
> while skipping it all together for mdev. (Cedric)
> * Due to the previous item, had to remove aw_bits because it depends on device attach being
> finished, instead defer it to when get_cap() gets called.
> * Skip auto domains for mdev instead of purposedly erroring out (Zhenzhong)
> * Pass errp in all cases, and instead just free the error in case of -EINVAL
>    in most of all patches, and also pass Error* in iommufd_backend_alloc_hwpt() amd
>    set/query dirty. This is made better thanks in part to skipping auto domains for mdev (Cedric)
> 
> Changes since RFCv2[4]:
> * Always allocate hwpt with IOMMU_HWPT_ALLOC_DIRTY_TRACKING even if
> we end up not actually toggling dirty tracking. (Avihai)
> * Fix error handling widely in auto domains logic and all patches (Avihai)
> * Reuse iommufd_backend_get_device_info() for capabilities (Zhenzhong)
> * New patches 1 and 2 taking into consideration previous comments.
> * Store hwpt::flags to know if we have dirty tracking (Avihai)
> * New patch 8, that allows to query dirty tracking support after
> provisioning. This is a cleaner way to check IOMMU dirty tracking support
> when vfio::migration is iniitalized, as opposed to RFCv2 via device caps.
> device caps way is still used because at vfio attach we aren't yet with
> a fully initialized migration state.
> * Adopt error propagation in query,set dirty tracking
> * Misc improvements overall broadly and Avihai
> * Drop hugepages as it's a bit unrelated; I can pursue that patch
> * separately. The main motivation is to provide a way to test
> without hugepages similar to what vfio_type1_iommu.disable_hugepages=1
> does.
> 
> Changes since RFCv1[2]:
> * Remove intel/amd dirty tracking emulation enabling
> * Remove the dirtyrate improvement for VF/IOMMU dirty tracking
> [Will pursue these two in separate series]
> * Introduce auto domains support
> * Enforce dirty tracking following the IOMMUFD UAPI for this
> * Add support for toggling hugepages in IOMMUFD
> * Auto enable support when VF supports migration to use IOMMU
> when it doesn't have VF dirty tracking
> * Add a parameter to toggle VF dirty tracking
> 
> [0] https://lore.kernel.org/qemu-devel/20240201072818.327930-1-zhenzhong.duan@intel.com/
> [1] https://lore.kernel.org/qemu-devel/20240201072818.327930-10-zhenzhong.duan@intel.com/
> [2] https://lore.kernel.org/qemu-devel/20220428211351.3897-1-joao.m.martins@oracle.com/
> [3] https://lore.kernel.org/qemu-devel/20230622214845.3980-1-joao.m.martins@oracle.com/
> [4] https://lore.kernel.org/qemu-devel/20240212135643.5858-1-joao.m.martins@oracle.com/
> [5] https://lore.kernel.org/qemu-devel/20240708143420.16953-1-joao.m.martins@oracle.com/
> [6] https://lore.kernel.org/qemu-devel/20240712114704.8708-1-joao.m.martins@oracle.com/#t
> 
> Joao Martins (13):
>    vfio/pci: Extract mdev check into an helper
>    vfio/iommufd: Don't initialize nor set a HOST_IOMMU_DEVICE with mdev
>    backends/iommufd: Extend iommufd_backend_get_device_info() to fetch HW
>      capabilities
>    vfio/iommufd: Return errno in iommufd_cdev_attach_ioas_hwpt()
>    vfio/iommufd: Introduce auto domain creation
>    vfio/{iommufd,container}: Remove caps::aw_bits
>    vfio/iommufd: Add hw_caps field to HostIOMMUDeviceCaps
>    vfio/{iommufd,container}: Invoke HostIOMMUDevice::realize() during
>      attach_device()
>    vfio/iommufd: Probe and request hwpt dirty tracking capability
>    vfio/iommufd: Implement VFIOIOMMUClass::set_dirty_tracking support
>    vfio/iommufd: Implement VFIOIOMMUClass::query_dirty_bitmap support
>    vfio/migration: Don't block migration device dirty tracking is
>      unsupported
>    vfio/common: Allow disabling device dirty page tracking
> 
>   include/hw/vfio/vfio-common.h      |  15 +++
>   include/sysemu/host_iommu_device.h |   5 +-
>   include/sysemu/iommufd.h           |  13 ++-
>   backends/iommufd.c                 |  89 +++++++++++++-
>   hw/vfio/common.c                   |  17 +--
>   hw/vfio/container.c                |   9 +-
>   hw/vfio/helpers.c                  |  25 ++++
>   hw/vfio/iommufd.c                  | 181 ++++++++++++++++++++++++++++-
>   hw/vfio/migration.c                |  12 +-
>   hw/vfio/pci.c                      |  26 +++--
>   backends/trace-events              |   3 +
>   11 files changed, 356 insertions(+), 39 deletions(-)
  
Applied 1-4 to vfio-next.

Still looking at the rest. We have ~24h for the last reviews.

Thanks,

C.



