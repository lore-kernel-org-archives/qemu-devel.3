Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7447C7EE2A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 13:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTh3f-0006bc-L2; Mon, 23 Jun 2025 09:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uTh3d-0006bL-Qc
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:17:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uTh3b-0000aE-A5
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:17:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750684674;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cTZHf5GlcWvRgJC7pWKdMEC4bDrLpgy1vFq2e4ypDCU=;
 b=Wo4OTSvFBRLwcaarm0uJ6KVJNfGzKUnldUGdN4ik6cX8Ez7u/2jDi41/hO7QQhx+4xaPtO
 Qd+wPy+aAwle5eNvbcRBROhsAQW7hl70R2+ZeLYtiPZzWkxg/XjDEkWx8qDlbjRHe0c5gr
 Un3PWkBgHn2njmgQc0J87D1bhhvx4N4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-c95wRaJqO3uzueR7NP0GYQ-1; Mon, 23 Jun 2025 09:17:49 -0400
X-MC-Unique: c95wRaJqO3uzueR7NP0GYQ-1
X-Mimecast-MFC-AGG-ID: c95wRaJqO3uzueR7NP0GYQ_1750684669
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4ff581df3so2027559f8f.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 06:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750684668; x=1751289468;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cTZHf5GlcWvRgJC7pWKdMEC4bDrLpgy1vFq2e4ypDCU=;
 b=ZsdDe8zB6fX+Fsk85I9oLe4vatlVrQMoE6cNdxK2Lcclp5e6FMwRhEDyE6Y5DTf/kF
 504seY+CgQ+A/YtUB332XBCvef1XjpUnB6uEEso4Wzuv+7WaEL5CgWGz20QJFQQpCSYS
 8jUZvJtt5pt2y8X/oS3NwgZkGiG5DyYasf03DFxd5ZOZDOJAZLefLWBXcIHoD6zYBg3a
 JKv0YjE+8Sx1i9iRUQHZDe8RMVtzJw+cjcqf7IGMxMdJJ4eppA7PuaOg1+I5msNIlQC1
 GZtgwnR8xB+4lOCBRIfa+TH63CqzdlZj3KJvKX0dP8F/4ocX9idjVkG7o/NjmmOQmYTm
 5VZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrlmoeEn6VkB5H3cFAYy7wva6Y4nVJpWqGLM8zdjw8qbKA7TlaDXOpZNrxTrV8lXoKapCJr3Pb/dvk@nongnu.org
X-Gm-Message-State: AOJu0YwQqFVJyQdR1xENS5g0lOEXJJImn6OAOGfdd1rZOnKtPF40otRW
 zWqZmTeMQiEElD65lJjK0w7Bx5YfPI8jQeAKK1g8OXO+fClpsg8mYGXifcdVGOpoPCb0MqmNi4M
 49u2AME/6tyMzDFnITLHl6+urCtNOKcaEfGF5xbWwrzrMAKBJdj/Ep4H1
X-Gm-Gg: ASbGncvkpR5GWwBn0VL7Yy6akfUPQcwa1HuhnmzzgIqu/dvkMgJB2ON83Qk8ATuTi8+
 WsTBEg+/rrzD7cUTKHwY+kO5U+81oQwacI1GxMrURnNpkQ9lcDPN0PPn2dLWY1nD+k0lLg0ce8w
 YnEcyUgP/6OVcFjoLolHe0kgel7xhbx6EUhETxgy3/DkWVlpQX7pIvKlqEG4vEaUYj4AYyqMVkc
 9pOgbn++/PhOy7SrYQLDSNnzb0QtiZA/ciNOAx+LVu/57YM6rdd9QZx+ZQjrcBsjBXcPXcOCtoc
 mZUlvir9XKDDFu0mfpyU37/k+Vw4cX9/HXXx5/7WW9DPIWs8K6ZKQfMhEnh/bhCgBXB7YQ==
X-Received: by 2002:a05:6000:41f6:b0:3a4:c71a:8119 with SMTP id
 ffacd0b85a97d-3a6d27eed6emr11306497f8f.25.1750684668484; 
 Mon, 23 Jun 2025 06:17:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWL4+gvuVy6xRbxogX3tvhUCkWC3Z3SoAxealJnytxEBJZeZy8gNHB5DApa0GljsywEUgTAg==
X-Received: by 2002:a05:6000:41f6:b0:3a4:c71a:8119 with SMTP id
 ffacd0b85a97d-3a6d27eed6emr11306449f8f.25.1750684667942; 
 Mon, 23 Jun 2025 06:17:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d1192680sm9682442f8f.95.2025.06.23.06.17.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 06:17:47 -0700 (PDT)
Message-ID: <ef70ca86-d796-4a47-a66f-923f270a2468@redhat.com>
Date: Mon, 23 Jun 2025 15:17:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/19] intel_iommu: Bind/unbind guest page table to host
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-15-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620071813.55571-15-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/20/25 9:18 AM, Zhenzhong Duan wrote:
> This captures the guest PASID table entry modifications and
> propagates the changes to host to attach a hwpt with type determined
> per guest IOMMU mdoe and PGTT configuration.
>
> When PGTT is Pass-through(100b), the hwpt on host side is a stage-2
> page table(GPA->HPA). When PGTT is First-stage Translation only(001b),
> vIOMMU reuse hwpt(GPA->HPA) provided by VFIO as nested parent to
> construct nested page table.
>
> When guest decides to use legacy mode then vIOMMU switches the MRs of
> the device's AS, hence the IOAS created by VFIO container would be
> switched to using the IOMMU_NOTIFIER_IOTLB_EVENTS since the MR is
> switched to IOMMU MR. So it is able to support shadowing the guest IO
> page table.
>
> Co-Authored-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h |  11 ++
>  hw/i386/intel_iommu.c          | 244 +++++++++++++++++++++++++++++++--
>  hw/i386/trace-events           |   3 +
>  3 files changed, 243 insertions(+), 15 deletions(-)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 5ed76864be..92a533db54 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -563,6 +563,13 @@ typedef struct VTDRootEntry VTDRootEntry;
>  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
>  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
>  
> +typedef enum VTDPASIDOp {
> +    VTD_PASID_BIND,
> +    VTD_PASID_UPDATE,
> +    VTD_PASID_UNBIND,
> +    VTD_OP_NUM
> +} VTDPASIDOp;
> +
>  typedef enum VTDPCInvType {
>      /* Force reset all */
>      VTD_PASID_CACHE_FORCE_RESET = 0,
> @@ -607,6 +614,9 @@ typedef struct VTDPASIDCacheInfo {
>  
>  #define VTD_SM_PASID_ENTRY_FLPM          3ULL
>  #define VTD_SM_PASID_ENTRY_FLPTPTR       (~0xfffULL)
> +#define VTD_SM_PASID_ENTRY_SRE_BIT(val)  (!!((val) & 1ULL))
> +#define VTD_SM_PASID_ENTRY_WPE_BIT(val)  (!!(((val) >> 4) & 1ULL))
> +#define VTD_SM_PASID_ENTRY_EAFE_BIT(val) (!!(((val) >> 7) & 1ULL))
>  
>  /* First Level Paging Structure */
>  /* Masks for First Level Paging Entry */
> @@ -644,5 +654,6 @@ typedef struct VTDHostIOMMUDevice {
>      PCIBus *bus;
>      uint8_t devfn;
>      HostIOMMUDevice *hiod;
> +    uint32_t s1_hwpt;
>  } VTDHostIOMMUDevice;
>  #endif
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index be01f8885f..1c94a0033c 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -20,6 +20,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
>  #include "qapi/error.h"
> @@ -41,6 +42,9 @@
>  #include "migration/vmstate.h"
>  #include "trace.h"
>  #include "system/iommufd.h"
> +#ifdef CONFIG_IOMMUFD
> +#include <linux/iommufd.h>
> +#endif
>  
>  /* context entry operations */
>  #define VTD_CE_GET_RID2PASID(ce) \
> @@ -839,6 +843,27 @@ static inline uint16_t vtd_pe_get_did(VTDPASIDEntry *pe)
>      return VTD_SM_PASID_ENTRY_DID((pe)->val[1]);
>  }
>  
> +static inline dma_addr_t vtd_pe_get_flpt_base(VTDPASIDEntry *pe)
> +{
> +    return pe->val[2] & VTD_SM_PASID_ENTRY_FLPTPTR;
Isn'it called FSPTPTR in the spec. In the positive I would use the same
terminology.
> +}
> +
> +static inline uint32_t vtd_pe_get_fl_aw(VTDPASIDEntry *pe)
> +{
> +    return 48 + ((pe->val[2] >> 2) & VTD_SM_PASID_ENTRY_FLPM) * 9;
here again I am bit lost as you seem to look at 3d 64b FSPM while there
is an AW field in the first 64b, please add a comment.
Also it isnot clear where this computation come from. Can you quote the
spec?
> +}
> +
> +static inline bool vtd_pe_pgtt_is_pt(VTDPASIDEntry *pe)
> +{
> +    return (VTD_PE_GET_TYPE(pe) == VTD_SM_PASID_ENTRY_PT);
> +}
> +
> +/* check if pgtt is first stage translation */
> +static inline bool vtd_pe_pgtt_is_flt(VTDPASIDEntry *pe)
> +{
> +    return (VTD_PE_GET_TYPE(pe) == VTD_SM_PASID_ENTRY_FLT);
> +}
> +
>  static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
>  {
>      return pdire->val & 1;
> @@ -2431,6 +2456,188 @@ static void vtd_context_global_invalidate(IntelIOMMUState *s)
>      vtd_iommu_replay_all(s);
>  }
>  
> +#ifdef CONFIG_IOMMUFD
> +static void vtd_init_s1_hwpt_data(struct iommu_hwpt_vtd_s1 *vtd,
> +                                  VTDPASIDEntry *pe)
> +{
> +    memset(vtd, 0, sizeof(*vtd));
> +
> +    vtd->flags =  (VTD_SM_PASID_ENTRY_SRE_BIT(pe->val[2]) ?
> +                                        IOMMU_VTD_S1_SRE : 0) |
> +                  (VTD_SM_PASID_ENTRY_WPE_BIT(pe->val[2]) ?
> +                                        IOMMU_VTD_S1_WPE : 0) |
> +                  (VTD_SM_PASID_ENTRY_EAFE_BIT(pe->val[2]) ?
> +                                        IOMMU_VTD_S1_EAFE : 0);
> +    vtd->addr_width = vtd_pe_get_fl_aw(pe);
> +    vtd->pgtbl_addr = (uint64_t)vtd_pe_get_flpt_base(pe);
> +}
> +
> +static int vtd_create_s1_hwpt(VTDHostIOMMUDevice *vtd_hiod,
> +                              VTDPASIDEntry *pe, Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +    struct iommu_hwpt_vtd_s1 vtd;
> +    uint32_t s1_hwpt;
> +
> +    vtd_init_s1_hwpt_data(&vtd, pe);
> +
> +    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
> +                                    idev->hwpt_id, 0, IOMMU_HWPT_DATA_VTD_S1,
> +                                    sizeof(vtd), &vtd, &s1_hwpt, errp)) {
> +        return -EINVAL;
> +    }
> +
> +    vtd_hiod->s1_hwpt = s1_hwpt;
> +
> +    return 0;
> +}
> +
> +static void vtd_destroy_s1_hwpt(VTDHostIOMMUDevice *vtd_hiod)
> +{
> +    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +
> +    iommufd_backend_free_id(idev->iommufd, vtd_hiod->s1_hwpt);
> +    vtd_hiod->s1_hwpt = 0;
> +}
> +
> +static int vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
> +                                     uint32_t pasid, VTDPASIDEntry *pe,
> +                                     Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +    uint32_t hwpt_id;
> +    int ret;
> +
> +    if (vtd_pe_pgtt_is_flt(pe)) {
> +        ret = vtd_create_s1_hwpt(vtd_hiod, pe, errp);
> +        if (ret) {
> +            return ret;
> +        }
> +        hwpt_id = vtd_hiod->s1_hwpt;
> +    } else {
> +        hwpt_id = idev->hwpt_id;
> +    }
> +
> +    ret = !host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id, errp);
> +    trace_vtd_device_attach_hwpt(idev->devid, pasid, hwpt_id, ret);
> +    if (ret && vtd_pe_pgtt_is_flt(pe)) {
> +        vtd_destroy_s1_hwpt(vtd_hiod);
> +    }
> +
> +    return ret;
> +}
> +
> +static int vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
> +                                     uint32_t pasid, VTDPASIDEntry *pe,
> +                                     Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFD *idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +    int ret;
> +
> +    if (vtd_hiod->iommu_state->dmar_enabled) {
> +        ret = !host_iommu_device_iommufd_detach_hwpt(idev, errp);
> +        trace_vtd_device_detach_hwpt(idev->devid, pasid, ret);
> +    } else {
> +        ret = !host_iommu_device_iommufd_attach_hwpt(idev, idev->hwpt_id, errp);
> +        trace_vtd_device_reattach_def_hwpt(idev->devid, pasid, idev->hwpt_id,
> +                                           ret);
> +    }
> +
> +    if (vtd_pe_pgtt_is_flt(pe)) {
> +        vtd_destroy_s1_hwpt(vtd_hiod);
> +    }
> +
> +    return ret;
> +}
> +
> +static int vtd_device_attach_pgtbl(VTDHostIOMMUDevice *vtd_hiod,
> +                                   VTDAddressSpace *vtd_as, VTDPASIDEntry *pe)
> +{
> +    /*
> +     * If pe->gptt == FLT, should be go ahead to do bind as host only
PGTT. The rest of the sentence is difficult to parse.
> +     * accepts guest FLT under nesting. If pe->pgtt==PT, should setup
> +     * the pasid with GPA page table. Otherwise should return failure.
> +     */
> +    if (!vtd_pe_pgtt_is_flt(pe) && !vtd_pe_pgtt_is_pt(pe)) {
> +        return -EINVAL;
> +    }
> +
> +    /* Should fail if the FLPT base is 0 */
> +    if (vtd_pe_pgtt_is_flt(pe) && !vtd_pe_get_flpt_base(pe)) {
> +        return -EINVAL;
> +    }
> +
> +    return vtd_device_attach_iommufd(vtd_hiod, vtd_as->pasid, pe, &error_abort);
> +}
> +
> +static int vtd_device_detach_pgtbl(VTDHostIOMMUDevice *vtd_hiod,
> +                                   VTDAddressSpace *vtd_as)
> +{
> +    VTDPASIDEntry *cached_pe = vtd_as->pasid_cache_entry.cache_filled ?
> +                       &vtd_as->pasid_cache_entry.pasid_entry : NULL;
> +
> +    if (!cached_pe ||
> +        (!vtd_pe_pgtt_is_flt(cached_pe) && !vtd_pe_pgtt_is_pt(cached_pe))) {
> +        return 0;
> +    }
> +
> +    return vtd_device_detach_iommufd(vtd_hiod, vtd_as->pasid, cached_pe,
> +                                     &error_abort);
> +}
> +
> +/**
> + * Caller should hold iommu_lock.
> + */
> +static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as,
> +                                VTDPASIDEntry *pe, VTDPASIDOp op)
> +{
> +    IntelIOMMUState *s = vtd_as->iommu_state;
> +    VTDHostIOMMUDevice *vtd_hiod;
> +    int devfn = vtd_as->devfn;
> +    int ret = -EINVAL;
> +    struct vtd_as_key key = {
> +        .bus = vtd_as->bus,
> +        .devfn = devfn,
> +    };
> +
> +    vtd_hiod = g_hash_table_lookup(s->vtd_host_iommu_dev, &key);
> +    if (!vtd_hiod || !vtd_hiod->hiod) {
> +        /* means no need to go further, e.g. for emulated devices */
don't you want to check

            object_dynamic_cast(OBJECT(vtd_hiod->hiod),
                                TYPE_HOST_IOMMU_DEVICE_IOMMUFD)
as well.
In the positive you may introduce a helper that returns the vtd_hiod or NULL. It could also be used in previous patch and maybe at other locations as well.

> +        return 0;
> +    }
> +
> +    if (vtd_as->pasid != PCI_NO_PASID) {
> +        error_report("Non-rid_pasid %d not supported yet", vtd_as->pasid);
> +        return ret;
> +    }
> +
> +    switch (op) {
> +    case VTD_PASID_UPDATE:
> +    case VTD_PASID_BIND:
> +    {
> +        ret = vtd_device_attach_pgtbl(vtd_hiod, vtd_as, pe);
> +        break;
> +    }
> +    case VTD_PASID_UNBIND:
> +    {
> +        ret = vtd_device_detach_pgtbl(vtd_hiod, vtd_as);
> +        break;
> +    }
> +    default:
> +        error_report_once("Unknown VTDPASIDOp!!!\n");
> +        break;
> +    }
> +
> +    return ret;
> +}
> +#else
> +static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as,
> +                                VTDPASIDEntry *pe, VTDPASIDOp op)
> +{
> +    return 0;
> +}
> +#endif
> +
>  /* Do a context-cache device-selective invalidation.
>   * @func_mask: FM field after shifting
>   */
> @@ -3181,20 +3388,23 @@ static int vtd_fill_pe_in_cache(IntelIOMMUState *s, VTDAddressSpace *vtd_as,
>                                  VTDPASIDEntry *pe)
>  {
>      VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
> +    int ret;
>  
> -    if (vtd_pasid_entry_compare(pe, &pc_entry->pasid_entry)) {
> -        /* No need to go further as cached pasid entry is latest */
> -        return 0;
> +    if (pc_entry->cache_filled) {
> +        if (vtd_pasid_entry_compare(pe, &pc_entry->pasid_entry)) {
> +            /* No need to go further as cached pasid entry is latest */
> +            return 0;
> +        }
> +        ret = vtd_bind_guest_pasid(vtd_as, pe, VTD_PASID_UPDATE);
> +    } else {
> +        ret = vtd_bind_guest_pasid(vtd_as, pe, VTD_PASID_BIND);
>      }
>  
> -    pc_entry->pasid_entry = *pe;
> -    pc_entry->cache_filled = true;
> -
> -    /*
> -     * TODO: send pasid bind to host for passthru devices
> -     */
> -
> -    return 0;
> +    if (!ret) {
> +        pc_entry->pasid_entry = *pe;
> +        pc_entry->cache_filled = true;
> +    }
> +    return ret;
>  }
>  
>  /*
> @@ -3265,10 +3475,14 @@ static gboolean vtd_flush_pasid(gpointer key, gpointer value,
>      return false;
>  
>  remove:
> -    /*
> -     * TODO: send pasid unbind to host for passthru devices
> -     */
> -    pc_entry->cache_filled = false;
> +    if (pc_entry->cache_filled) {
> +        if (vtd_bind_guest_pasid(vtd_as, NULL, VTD_PASID_UNBIND)) {
> +            pasid_cache_info_set_error(pc_info);
> +            return false;
> +        } else {
> +            pc_entry->cache_filled = false;
> +        }
> +    }
>  
>      /*
>       * Don't remove address space of PCI_NO_PASID which is created by PCI
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index c8a936eb46..1c31b9a873 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -73,6 +73,9 @@ vtd_warn_invalid_qi_tail(uint16_t tail) "tail 0x%"PRIx16
>  vtd_warn_ir_vector(uint16_t sid, int index, int vec, int target) "sid 0x%"PRIx16" index %d vec %d (should be: %d)"
>  vtd_warn_ir_trigger(uint16_t sid, int index, int trig, int target) "sid 0x%"PRIx16" index %d trigger %d (should be: %d)"
>  vtd_reset_exit(void) ""
> +vtd_device_attach_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
> +vtd_device_detach_hwpt(uint32_t dev_id, uint32_t pasid, int ret) "dev_id %d pasid %d ret: %d"
> +vtd_device_reattach_def_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
>  
>  # amd_iommu.c
>  amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32
Eric


