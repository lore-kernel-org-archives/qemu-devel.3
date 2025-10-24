Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F08CCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 17:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCLAX-0001Hh-0C; Fri, 24 Oct 2025 13:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vCLAU-0001HI-Mo
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 13:01:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vCLAQ-000685-QZ
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 13:01:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761325288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DshxyYX4shI5ZySFLf3diEEMmNU2wG9DB1pkYigNfUM=;
 b=Dg4kuUz2/tTVXUNLFCDsCkhdbLN4rFClGrqfYZDBa9vuUF956nLoHNhC/Rrvi4qQWv6Y7a
 +wL3PB7tRP2LedK8tgIes64W0/aQQ0MiXbMR/edEQSdeCXS7Ppk4hDenOXA7NxJweimQyW
 NdcxdXhmpj8EoWtIRNb0q0dj8k7EdIY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-hqr5ow5XNwOfJcsmLUGLkg-1; Fri, 24 Oct 2025 13:01:27 -0400
X-MC-Unique: hqr5ow5XNwOfJcsmLUGLkg-1
X-Mimecast-MFC-AGG-ID: hqr5ow5XNwOfJcsmLUGLkg_1761325286
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-471005f28d2so11971585e9.0
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 10:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761325286; x=1761930086;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DshxyYX4shI5ZySFLf3diEEMmNU2wG9DB1pkYigNfUM=;
 b=bZh9+3EkO3Ke8Cg1zevomHQ6d3dsJQp54ldjXTy47NlpE9PnotSUvpFtv93FiTlLL7
 c5BDP+PP1CaNOTfaiOpITFhjSaTk5MgfeMbofq8+6ohLQwMFFwF66zns+E3WkemEkdVj
 U3HW3D3MQNPkrnSBqSPM/RxCU7uJ3C2liM0M9W3IbYLvJimp1CTR8UlAlYaB0xfKD1AC
 iSMHEMgAF0rfY+mY6qe/e8fI5X0JKRKGEZvv9yxx8Bt4IQ3eOYgd4GabzpxsYfU5h25+
 lF0XjwFOD5ObPCSBZJSbbSOtoud8JmMgqLwX6ERFUG0m+GzYQ33xSkFmKtnHvN5t07/O
 RqVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0AsG9UueLBzwvmloZDVvvd4/fVJlrm1IWJeMmWHxEvgjXpWPaMrL2jN6T91tq7gKPuYJF7GOdszzh@nongnu.org
X-Gm-Message-State: AOJu0YwoxPOs+Zgz87GvUEd+aDo4RCyMVGpYidiGWhphsKN8dfAJOEe8
 V5wEbOfpzXJ3QwyR82DGs/nDsar5n3LsaXZPYN+OGYtbQUmOoxkYLI3PA8ZxgnBKUU9Z92Zmy69
 19bo8egDbIDL4LDG4ORbN791MLOBFkKuc5D7yFgs7b/PCPTce6eLtE9ri
X-Gm-Gg: ASbGncsJHtu545RlG8PoyLO0N6Fl5hwv75u0NGKxP1prBoZelBQgp2Rfu1AwVWhPrf4
 lgjClkHi5zdbmCGC3HrhvQA5bSmM4ArimYWVRARVwzFPxPyvR91dq3n9q8VOHOgKrEIboaARbPd
 yzk2t1qFpjEEGAhl9ryZoz7DiVxrxr77A091T8GxuMoPahnuOTukaFKnGSf0oTCb7AxYvT63+q+
 74VU4xb+7cDwE1OvNBg1ISgDPApzilZGxDznePzKzlsYnQP+Ke9ug7beeWVe5SGgo8TxGiUTBBG
 nPC84aaSJa4GjZ+aBXOtfB66qDzS9qPRL3grBQxcHBDdfEdK1HQKGCbmF32klW7TBS9h4mXt
X-Received: by 2002:a05:600c:c091:b0:46f:b42e:edcf with SMTP id
 5b1f17b1804b1-47117925d66mr158249185e9.40.1761325285788; 
 Fri, 24 Oct 2025 10:01:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHA3sr6EYrzyuDVFd3+DRzEWO0IkWZjsjwmPrpdS4zK4X3Ar565t8EWHA5PHXPkwkwmvMuFw==
X-Received: by 2002:a05:600c:c091:b0:46f:b42e:edcf with SMTP id
 5b1f17b1804b1-47117925d66mr158248875e9.40.1761325285306; 
 Fri, 24 Oct 2025 10:01:25 -0700 (PDT)
Received: from [10.54.0.145] ([147.135.244.229])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c43900e1sm189920625e9.17.2025.10.24.10.01.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 10:01:24 -0700 (PDT)
Message-ID: <90e0d491-e59e-4093-812e-57627baea452@redhat.com>
Date: Fri, 24 Oct 2025 19:01:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/23] intel_iommu: Bind/unbind guest page table to host
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
 <20251024084349.102322-14-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251024084349.102322-14-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/24/25 10:43, Zhenzhong Duan wrote:
> This captures the guest PASID table entry modifications and propagates
> the changes to host to attach a hwpt with type determined per guest IOMMU
> PGTT configuration.
> 
> When PGTT=PT, attach PASID_0 to a second stage HWPT(GPA->HPA).
> When PGTT=FST, attach PASID_0 to nested HWPT with nesting parent HWPT
> coming from VFIO.
> 
> Co-Authored-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   include/hw/i386/intel_iommu.h |   1 +
>   hw/i386/intel_iommu.c         | 150 +++++++++++++++++++++++++++++++++-
>   hw/i386/trace-events          |   3 +
>   3 files changed, 151 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 3758ac239c..b5f8a9fc29 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -104,6 +104,7 @@ struct VTDAddressSpace {
>       PCIBus *bus;
>       uint8_t devfn;
>       uint32_t pasid;
> +    uint32_t fs_hwpt;
>       AddressSpace as;
>       IOMMUMemoryRegion iommu;
>       MemoryRegion root;          /* The root container of the device */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 871e6aad19..3789a36147 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -20,6 +20,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>   #include "qemu/error-report.h"
>   #include "qemu/main-loop.h"
>   #include "qapi/error.h"
> @@ -42,6 +43,9 @@
>   #include "migration/vmstate.h"
>   #include "trace.h"
>   #include "system/iommufd.h"
> +#ifdef CONFIG_IOMMUFD
> +#include <linux/iommufd.h>
> +#endif


Exposing IOMMUFD in the Intel vIOMMU is unexpected. Initially, we
introduced HostIOMMUDeviceClass to avoid exposing the IOMMU backends.
Are we OK to bypass this abstract layer now ?


Thanks,

C.



  >   /* context entry operations */
>   #define PASID_0    0
> @@ -87,6 +91,7 @@ struct vtd_iotlb_key {
>   
>   static void vtd_address_space_refresh_all(IntelIOMMUState *s);
>   static void vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n);
> +static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, Error **errp);
>   
>   static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
>   {
> @@ -98,7 +103,11 @@ static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s)
>       g_hash_table_iter_init(&as_it, s->vtd_address_spaces);
>       while (g_hash_table_iter_next(&as_it, NULL, (void **)&vtd_as)) {
>           VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
> -        pc_entry->valid = false;
> +        if (pc_entry->valid) {
> +            pc_entry->valid = false;
> +            /* It's fatal to get failure during reset */
> +            vtd_bind_guest_pasid(vtd_as, &error_fatal);
> +        }
>       }
>   }
>   
> @@ -2380,6 +2389,128 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
>       vtd_iommu_replay_all(s);
>   }
>   
> +#ifdef CONFIG_IOMMUFD
> +static int vtd_create_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +                              VTDPASIDEntry *pe, uint32_t *fs_hwpt,
> +                              Error **errp)
> +{
> +    struct iommu_hwpt_vtd_s1 vtd = {};
> +
> +    vtd.flags = (VTD_SM_PASID_ENTRY_SRE_BIT(pe) ? IOMMU_VTD_S1_SRE : 0) |
> +                (VTD_SM_PASID_ENTRY_WPE_BIT(pe) ? IOMMU_VTD_S1_WPE : 0) |
> +                (VTD_SM_PASID_ENTRY_EAFE_BIT(pe) ? IOMMU_VTD_S1_EAFE : 0);
> +    vtd.addr_width = vtd_pe_get_fs_aw(pe);
> +    vtd.pgtbl_addr = (uint64_t)vtd_pe_get_fspt_base(pe);
> +
> +    return !iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
> +                                       idev->hwpt_id, 0, IOMMU_HWPT_DATA_VTD_S1,
> +                                       sizeof(vtd), &vtd, fs_hwpt, errp);
> +}
> +
> +static void vtd_destroy_old_fs_hwpt(HostIOMMUDeviceIOMMUFD *idev,
> +                                    VTDAddressSpace *vtd_as)
> +{
> +    if (!vtd_as->fs_hwpt) {
> +        return;
> +    }
> +    iommufd_backend_free_id(idev->iommufd, vtd_as->fs_hwpt);
> +    vtd_as->fs_hwpt = 0;
> +}
> +
> +static int vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
> +                                     VTDAddressSpace *vtd_as, Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +    VTDPASIDEntry *pe = &vtd_as->pasid_cache_entry.pasid_entry;
> +    uint32_t hwpt_id;
> +    bool ret;
> +
> +    /*
> +     * We can get here only if flts=on, the supported PGTT is FST and PT.
> +     * Catch invalid PGTT when processing invalidation request to avoid
> +     * attaching to wrong hwpt.
> +     */
> +    if (!vtd_pe_pgtt_is_fst(pe) && !vtd_pe_pgtt_is_pt(pe)) {
> +        error_setg(errp, "Invalid PGTT type");
> +        return -EINVAL;
> +    }
> +
> +    if (vtd_pe_pgtt_is_pt(pe)) {
> +        hwpt_id = idev->hwpt_id;
> +    } else if (vtd_create_fs_hwpt(idev, pe, &hwpt_id, errp)) {
> +        return -EINVAL;
> +    }
> +
> +    ret = host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp);
> +    trace_vtd_device_attach_hwpt(idev->devid, vtd_as->pasid, hwpt_id, !ret);
> +    if (ret) {
> +        /* Destroy old fs_hwpt if it's a replacement */
> +        vtd_destroy_old_fs_hwpt(idev, vtd_as);
> +        if (vtd_pe_pgtt_is_fst(pe)) {
> +            vtd_as->fs_hwpt = hwpt_id;
> +        }
> +    } else if (vtd_pe_pgtt_is_fst(pe)) {
> +        iommufd_backend_free_id(idev->iommufd, hwpt_id);
> +    }
> +
> +    return !ret;
> +}
> +
> +static int vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
> +                                     VTDAddressSpace *vtd_as, Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +    IntelIOMMUState *s = vtd_as->iommu_state;
> +    uint32_t pasid = vtd_as->pasid;
> +    bool ret;
> +
> +    if (s->dmar_enabled && s->root_scalable) {
> +        ret = host_iommu_device_iommufd_detach_hwpt(idev, errp);
> +        trace_vtd_device_detach_hwpt(idev->devid, pasid, !ret);
> +    } else {
> +        /*
> +         * If DMAR remapping is disabled or guest switches to legacy mode,
> +         * we fallback to the default HWPT which contains shadow page table.
> +         * So guest DMA could still work.
> +         */
> +        ret = host_iommu_device_iommufd_attach_hwpt(idev, idev->hwpt_id, errp);
> +        trace_vtd_device_reattach_def_hwpt(idev->devid, pasid, idev->hwpt_id,
> +                                           !ret);
> +    }
> +
> +    if (ret) {
> +        vtd_destroy_old_fs_hwpt(idev, vtd_as);
> +    }
> +
> +    return !ret;
> +}
> +
> +static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, Error **errp)
> +{
> +    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
> +    VTDHostIOMMUDevice *vtd_hiod = vtd_find_hiod_iommufd(vtd_as);
> +    int ret;
> +
> +    /* Ignore emulated device or legacy VFIO backed device */
> +    if (!vtd_hiod) {
> +        return 0;
> +    }
> +
> +    if (pc_entry->valid) {
> +        ret = vtd_device_attach_iommufd(vtd_hiod, vtd_as, errp);
> +    } else {
> +        ret = vtd_device_detach_iommufd(vtd_hiod, vtd_as, errp);
> +    }
> +
> +    return ret;
> +}
> +#else
> +static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, Error **errp)
> +{
> +    return 0;
> +}
> +#endif
> +
>   /* Do a context-cache device-selective invalidation.
>    * @func_mask: FM field after shifting
>    */
> @@ -3134,6 +3265,8 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>       VTDPASIDEntry pe;
>       IOMMUNotifier *n;
>       uint16_t did;
> +    const char *err_prefix;
> +    Error *local_err = NULL;
>   
>       if (vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {
>           if (!pc_entry->valid) {
> @@ -3154,7 +3287,9 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>               vtd_address_space_unmap(vtd_as, n);
>           }
>           vtd_switch_address_space(vtd_as);
> -        return;
> +
> +        err_prefix = "Detaching from HWPT failed: ";
> +        goto do_bind_unbind;
>       }
>   
>       /*
> @@ -3182,12 +3317,21 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>       if (!pc_entry->valid) {
>           pc_entry->pasid_entry = pe;
>           pc_entry->valid = true;
> -    } else if (!vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
> +        err_prefix = "Attaching to HWPT failed: ";
> +    } else if (vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
> +        err_prefix = "Replacing HWPT attachment failed: ";
> +    } else {
>           return;
>       }
>   
>       vtd_switch_address_space(vtd_as);
>       vtd_address_space_sync(vtd_as);
> +
> +do_bind_unbind:
> +    /* TODO: Fault event injection into guest, report error to QEMU for now */
> +    if (vtd_bind_guest_pasid(vtd_as, &local_err)) {
> +        error_reportf_err(local_err, "%s", err_prefix);
> +    }
>   }
>   
>   static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index b704f4f90c..5a3ee1cf64 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -73,6 +73,9 @@ vtd_warn_invalid_qi_tail(uint16_t tail) "tail 0x%"PRIx16
>   vtd_warn_ir_vector(uint16_t sid, int index, int vec, int target) "sid 0x%"PRIx16" index %d vec %d (should be: %d)"
>   vtd_warn_ir_trigger(uint16_t sid, int index, int trig, int target) "sid 0x%"PRIx16" index %d trigger %d (should be: %d)"
>   vtd_reset_exit(void) ""
> +vtd_device_attach_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
> +vtd_device_detach_hwpt(uint32_t dev_id, uint32_t pasid, int ret) "dev_id %d pasid %d ret: %d"
> +vtd_device_reattach_def_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
>   
>   # amd_iommu.c
>   amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32


