Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79510C3271E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 07:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRoQq-00057z-MG; Thu, 11 Jul 2024 03:41:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sRoQp-00057J-5w
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 03:41:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sRoQl-0008JQ-MA
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 03:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720683687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zsSBkxjhgplpeHwFoZbBsrfcgLpUHVwJoXtRHAryFUs=;
 b=KunUkABzdCP9oJU1mc+6KQsjZeLHB98tXkhubAik+K3Y1QLooE/GouAkSqFx0XkCGY1EVY
 8Dw+CLaWFoUHT05AfAkvP7fGVoXGJorA65PV4W3crvRyEIEsFiApv1f+lGEwYQkccSsIn8
 msupP0sWa1+S6rx1e6SUi5slo6aBMug=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-ww4Lcd1NP5KGud-COJUh6Q-1; Thu, 11 Jul 2024 03:41:25 -0400
X-MC-Unique: ww4Lcd1NP5KGud-COJUh6Q-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-e057ae54529so978096276.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 00:41:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720683685; x=1721288485;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zsSBkxjhgplpeHwFoZbBsrfcgLpUHVwJoXtRHAryFUs=;
 b=Qkpa98mgxNsJdtQ4NNG9nGU92TWIIBvlOSEDxJkXsX8rovaso00tQ1+KqwxL4ce+fB
 VXHfpKNui+vMAcpiu/Mc45H634tfsq4599CbioBLyIMPY7mRG5DPmdDX8IGQO48uIN9B
 Sd+Z53D2Xr6Rjhs3P/eJVQPBnnSNKD9IjPVMmdHcQeGFFnnLcERY0uT99cjOYbZHYIrV
 gQceERTyP3pWwbhTDtBLr3itPtqEeQ5qBBic5Cyo7rc6OJyHzxDqHaeaCROt5fDBbJvZ
 TKKqhR4mdcJqMfk4VJqUre62wwKXXxknM5F8Gwps+VYeKUMapfcEoD6oYEsxmhCk7u1v
 FpRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcxKGXM1o1bOUPsj+6p/pxi+k68J2RnP0rMR1J4n8kn4MlSnor1jmH92xXUcaWv4mMqc6T8y/MyEc6DiUUpHetySXQcEg=
X-Gm-Message-State: AOJu0Yx9+kQm+oZ0eZ2jL/w6Axxmn9Hxs0mwmXd7aygqd6Ud694SqCAy
 rKyuD10aOVA7kVsH0L5X3EJpn6FTzV0Phk1B0T5mSc5sRdP1vUxVo62fca5scNT6sRCDhCQuZGm
 tNZcphkAV+ywI6SgU1gJGAwzHe7YTYMD5P+IqfUKPE9sqqHixQsoi
X-Received: by 2002:a25:538a:0:b0:dff:47c7:ffb8 with SMTP id
 3f1490d57ef6-e041b0363e7mr8728494276.12.1720683684630; 
 Thu, 11 Jul 2024 00:41:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhvqJ8S0Ricf/bYpAi/mOZ5sSjUHpwDfjKl7e+xwBrGJrp9WFEWGMsaNCRNgZHM+fCDwZOKA==
X-Received: by 2002:a25:538a:0:b0:dff:47c7:ffb8 with SMTP id
 3f1490d57ef6-e041b0363e7mr8728478276.12.1720683684220; 
 Thu, 11 Jul 2024 00:41:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79f190b6a5csm265317485a.126.2024.07.11.00.41.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 00:41:23 -0700 (PDT)
Message-ID: <bf7bbf89-2930-42d0-9a3e-edff8e6c496d@redhat.com>
Date: Thu, 11 Jul 2024 09:41:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] hw/vfio: IOMMUFD Dirty Tracking
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon <avihaih@nvidia.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20240708143420.16953-1-joao.m.martins@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

Hello Joao,

On 7/8/24 4:34 PM, Joao Martins wrote:
> This small series adds support for IOMMU dirty tracking support via the
> IOMMUFD backend. The hardware capability is available on most recent x86
> hardware. The series is divided organized as follows:
> 
> * Patch 1: Fixes a regression into mdev support with IOMMUFD. This
>             one is independent of the series but happened to cross it
>             while testing mdev with this series
> 
> * Patch 2: Adds a support to iommufd_get_device_info() for capabilities
> 
> * Patches 3 - 7: IOMMUFD backend support for dirty tracking;
> 
> Introduce auto domains -- Patch 3 goes into more detail, but the gist is that
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
> * Patches 8-10: Don't block live migration where there's no VF dirty
> tracker, considering that we have IOMMU dirty tracking.
> 
> Comments and feedback appreciated.
> 
> Cheers,
>      Joao
> 
> P.S. Suggest linux-next (or future v6.11) as hypervisor kernel as there's
> some bugs fixed there with regards to IOMMU hugepage dirty tracking.
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
> 
> Joao Martins (10):
>    vfio/iommufd: don't fail to realize on IOMMU_GET_HW_INFO failure
>    backends/iommufd: Extend iommufd_backend_get_device_info() to fetch HW capabilities
>    vfio/iommufd: Return errno in iommufd_cdev_attach_ioas_hwpt()
>    vfio/iommufd: Introduce auto domain creation
>    vfio/iommufd: Probe and request hwpt dirty tracking capability
>    vfio/iommufd: Implement VFIOIOMMUClass::set_dirty_tracking support
>    vfio/iommufd: Implement VFIOIOMMUClass::query_dirty_bitmap support
>    vfio/iommufd: Parse hw_caps and store dirty tracking support
>    vfio/migration: Don't block migration device dirty tracking is unsupported
>    vfio/common: Allow disabling device dirty page tracking
> 
>   include/hw/vfio/vfio-common.h      |  11 ++
>   include/sysemu/host_iommu_device.h |   2 +
>   include/sysemu/iommufd.h           |  12 +-
>   backends/iommufd.c                 |  81 ++++++++++-
>   hw/vfio/common.c                   |   3 +
>   hw/vfio/iommufd.c                  | 217 +++++++++++++++++++++++++++--
>   hw/vfio/migration.c                |   7 +-
>   hw/vfio/pci.c                      |   3 +
>   backends/trace-events              |   3 +
>   9 files changed, 325 insertions(+), 14 deletions(-)


I am a bit confused with all the inline proposals. Would you mind
resending a v4 please ?

Regarding my comments on error handling,

The error should be set in case of failure, which means a routine
can not return 'false' or '-errno' and not setting 'Error **'
parameter at the same time.

If the returned value needs to be interpreted in some ways, for a
retry or any reason, then it makes sense to use an int, else please
use a bool. This is to avoid random negative values being interpreted
as an errno when they are not.

With VFIO migration support, low level errors (from the adapter FW
through the VFIO PCI variant driver) now reach to the core migration
subsystem. It is preferable to propagate this error, possibly literal,
to the VMM, monitor or libvirt. It's not fully symmetric today because
the log_global_stop handler for dirty tracking enablement is not
addressed. Anyhow, an effort on error reporting needs to be made and
any use of error_report() in a low level function is a sign for
improvement.

I think it would have value to probe early the host IOMMU device for
its HW features. If the results were cached in the HostIOMMUDevice
struct, it would then remove unnecessary and redundant calls to the
host kernel and avoid error handling in complex code paths. I hope
this is feasible. I haven't looked closely tbh.

We are reaching soft freeze, in ~10 days. There is a chance this
proposal could make it for 9.1.

Thanks,

C.


