Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478EDD3E764
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 17:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTOK7-0003Il-Ur; Wed, 10 Dec 2025 12:49:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vTOK6-0003I1-Sc
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 12:49:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vTOK4-0005rA-Il
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 12:49:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765388996;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q3otZUvISvsTeXmhAEVYcNjdkPUwgAD3BWs2ihERvU0=;
 b=gSD2/O6oi6V+5jHfW1Zd4xw26r8T/w9nz95bgZbzChygndYAV4QkO4JW7dHA4nh8yTBTck
 pIDOV6FPvGS6N9ona5SF0SPp2Q40MoEQJB5W9vZgalQcpFosL7+LS4swr8a2pRAl4TNfMQ
 xPzeMF+cY8vEqxeTFN5qBdLBVjrUe/M=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-9_K8DW7gNCyKtjR4E-w08w-1; Wed, 10 Dec 2025 12:49:54 -0500
X-MC-Unique: 9_K8DW7gNCyKtjR4E-w08w-1
X-Mimecast-MFC-AGG-ID: 9_K8DW7gNCyKtjR4E-w08w_1765388994
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-342701608e2so110214a91.1
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 09:49:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765388993; x=1765993793;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q3otZUvISvsTeXmhAEVYcNjdkPUwgAD3BWs2ihERvU0=;
 b=bC6984+vfxBWm/3aZ5h0fRBkLu3Di/IpHPnWiGrQhzyX2FiOJklKWp7WQUCdpF3Mlu
 urgW0pNZUC3zIw5+mOG7v8kdgt/j6zUqDLU4AeDzawFhWy5qwD9/jvV3z7J6cKh7CpxU
 x0kA17oQpgM+wqOyDIY10EXetQ81cH+FM4RWjk0K1MEMcwlWMpe7fK6ZO6l8TLfNs4Xj
 1TZYXaBu95veQ3R12JA5/20e6w+w9fTOL8vywzG0wHOO+c5GnkUOB+V6cnEtSavJrRfY
 s7mqKRpohrzGX6fGM0rC3SDlLnsB4jQ3N7VfsYNfIApYA9XkyIUnuLdE4hLdHJveb4Rl
 KlPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuEM/dSFnd4lXEtr57Jw1088DgUXrzDu8IOuG2OTIp9xIgvtwrr6YOE6QrywLlMY+nF8SW4ZytEFUc@nongnu.org
X-Gm-Message-State: AOJu0YygjNVXql+cXHH7/QYtXV+svt6XlQQHC2P+sLcli28OSHi5IP3i
 P0rxuXdPMm4K25i0qTfis9iWv9IVq+6lKpLEfnvbj5IIqqOU1BZ9tLjgevxdnVwIpBuWabhC/WU
 H4qVmJr4a/VfKjNefAd8IqE3QX/MqhcAI6BqZG7jNpoVTUrgnQWoiVwAi
X-Gm-Gg: AY/fxX5IvfgzQuM49G5v2cyIyXXAHaw3w0l6s2HwBfDfmSeVeBwB5YLPLnUQRAPBwGa
 MgoFdjfhwyOnFJdHLz1R+cwu9HNKVcGC+XcaT/crtGHhFqYGzitiF22/YJbuHB9PMiUxUkzjgRL
 IlEPSNRbQq50VW7HUlxu+WGsiMN8sukcLJgSRXvxHsAyJmwiXUxnSecd7zNlZrJq2pFxYSBcKIp
 m0ehT5684yyb+lVvW/bslobhrgRB1/3qMeMvrFtarRFY0Z/0/khzd83UrVEsHWuHO0/YG6tiDyh
 94UzqOCwGyzGA9LnkQKbO3KcT2r39jSwSAhjZUKB0AlDpiAmoULWkmexxL0wecmz1x3EeJwqs6W
 oJqxzH86geHglM26248VyPGXIKk8FsOhv/lu0UfF3olc5xjoogCXFPk4q+w==
X-Received: by 2002:a17:90b:3904:b0:340:c179:365a with SMTP id
 98e67ed59e1d1-34a72711d9bmr3057604a91.0.1765388993540; 
 Wed, 10 Dec 2025 09:49:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpbZunN/6q9yjYr83qfuePzsoUmK8B1rCACCHhS39d1ziHGzIIM1CQ9tsP9n868GvteGMmVQ==
X-Received: by 2002:a17:90b:3904:b0:340:c179:365a with SMTP id
 98e67ed59e1d1-34a72711d9bmr3057571a91.0.1765388993109; 
 Wed, 10 Dec 2025 09:49:53 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c0c2632b725sm129294a12.8.2025.12.10.09.49.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 09:49:52 -0800 (PST)
Message-ID: <c7c3aa41-405e-45ae-94dc-b65f83f4222e@redhat.com>
Date: Wed, 10 Dec 2025 18:49:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 14/23] intel_iommu_accel: Propagate PASID-based iotlb
 invalidation to host
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, mst@redhat.com, jasowang@redhat.com,
 peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
 <20251117093729.1121324-15-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251117093729.1121324-15-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 11/17/25 10:37 AM, Zhenzhong Duan wrote:
> From: Yi Liu <yi.l.liu@intel.com>
>
> This traps the guest PASID-based iotlb invalidation request and propagate it
> to host.
>
> Intel VT-d 3.0 supports nested translation in PASID granularity. Guest SVA
> support could be implemented by configuring nested translation on specific
> pasid. This is also known as dual stage DMA translation.
>
> Under such configuration, guest owns the GVA->GPA translation which is
> configured as first stage page table on host side for a specific pasid, and
> host owns GPA->HPA translation. As guest owns first stage translation table,
> piotlb invalidation should be propagated to host since host IOMMU will cache
> first level page table related mappings during DMA address translation.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_accel.h    | 10 +++++
>  hw/i386/intel_iommu_internal.h |  6 +++
>  hw/i386/intel_iommu.c          | 11 ++++--
>  hw/i386/intel_iommu_accel.c    | 69 ++++++++++++++++++++++++++++++++++
>  4 files changed, 93 insertions(+), 3 deletions(-)
>
> diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
> index 1a396c50a0..76862310c2 100644
> --- a/hw/i386/intel_iommu_accel.h
> +++ b/hw/i386/intel_iommu_accel.h
> @@ -17,6 +17,9 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMMUDevice *vtd_hiod,
>                            Error **errp);
>  VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as);
>  bool vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, Error **errp);
> +void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
> +                                      uint32_t pasid, hwaddr addr,
> +                                      uint64_t npages, bool ih);
>  #else
>  static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
>                                          VTDHostIOMMUDevice *vtd_hiod,
> @@ -36,5 +39,12 @@ static inline bool vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, Error **errp)
>  {
>      return true;
>  }
> +
> +static inline void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s,
> +                                                    uint16_t domain_id,
> +                                                    uint32_t pasid, hwaddr addr,
> +                                                    uint64_t npages, bool ih)
> +{
> +}
>  #endif
>  #endif
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index e987322e93..a2ca79f925 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -622,6 +622,12 @@ typedef struct VTDPASIDCacheInfo {
>      uint32_t pasid;
>  } VTDPASIDCacheInfo;
>  
> +typedef struct VTDPIOTLBInvInfo {
> +    uint16_t domain_id;
> +    uint32_t pasid;
> +    struct iommu_hwpt_vtd_s1_invalidate *inv_data;
> +} VTDPIOTLBInvInfo;
> +
>  /* PASID Table Related Definitions */
>  #define VTD_PASID_DIR_BASE_ADDR_MASK  (~0xfffULL)
>  #define VTD_PASID_TABLE_BASE_ADDR_MASK (~0xfffULL)
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 36449bf161..ccff240660 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2968,6 +2968,8 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>      vtd_iommu_lock(s);
>      g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_pasid,
>                                  &info);
> +    vtd_flush_host_piotlb_all_locked(s, domain_id, pasid, 0, (uint64_t)-1,
> +                                     false);
>      vtd_iommu_unlock(s);
>  
>      QLIST_FOREACH(vtd_as, &s->vtd_as_with_notifiers, next) {
> @@ -2987,7 +2989,8 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>  }
>  
>  static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
> -                                       uint32_t pasid, hwaddr addr, uint8_t am)
> +                                       uint32_t pasid, hwaddr addr, uint8_t am,
> +                                       bool ih)
>  {
>      VTDIOTLBPageInvInfo info;
>  
> @@ -2999,6 +3002,7 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
>      vtd_iommu_lock(s);
>      g_hash_table_foreach_remove(s->iotlb,
>                                  vtd_hash_remove_by_page_piotlb, &info);
> +    vtd_flush_host_piotlb_all_locked(s, domain_id, pasid, addr, 1 << am, ih);
>      vtd_iommu_unlock(s);
>  
>      vtd_iotlb_page_invalidate_notify(s, domain_id, addr, am, pasid);
> @@ -3030,7 +3034,8 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
>      case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
>          am = VTD_INV_DESC_PIOTLB_AM(inv_desc->val[1]);
>          addr = (hwaddr) VTD_INV_DESC_PIOTLB_ADDR(inv_desc->val[1]);
> -        vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am);
> +        vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am,
> +                                   VTD_INV_DESC_PIOTLB_IH(inv_desc));
>          break;
>  
>      default:
> @@ -5218,7 +5223,7 @@ static int vtd_pri_perform_implicit_invalidation(VTDAddressSpace *vtd_as,
>      ret = 0;
>      switch (pgtt) {
>      case VTD_SM_PASID_ENTRY_FST:
> -        vtd_piotlb_page_invalidate(s, domain_id, vtd_as->pasid, addr, 0);
> +        vtd_piotlb_page_invalidate(s, domain_id, vtd_as->pasid, addr, 0, false);
>          break;
>      /* Room for other pgtt values */
>      default:
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index 66570ea919..41d0e4107b 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -182,3 +182,72 @@ bool vtd_bind_guest_pasid(VTDAddressSpace *vtd_as, Error **errp)
>  
>      return vtd_device_detach_iommufd(vtd_hiod, vtd_as, errp);
>  }
> +
> +/*
> + * This function is a loop function for the s->vtd_address_spaces
> + * list with VTDPIOTLBInvInfo as execution filter. It propagates
> + * the piotlb invalidation to host.
> + */
> +static void vtd_flush_host_piotlb_locked(gpointer key, gpointer value,
> +                                         gpointer user_data)
> +{
> +    VTDPIOTLBInvInfo *piotlb_info = user_data;
> +    VTDAddressSpace *vtd_as = value;
> +    VTDHostIOMMUDevice *vtd_hiod = vtd_find_hiod_iommufd(vtd_as);
> +    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
> +    uint16_t did;
> +
> +    if (!vtd_hiod) {
> +        return;
> +    }
> +
> +    assert(vtd_as->pasid == PCI_NO_PASID);
> +
> +    /* Nothing to do if there is no first stage HWPT attached */
> +    if (!pc_entry->valid ||
> +        !vtd_pe_pgtt_is_fst(&pc_entry->pasid_entry)) {
> +        return;
> +    }
> +
> +    did = VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
> +
> +    if (piotlb_info->domain_id == did && piotlb_info->pasid == PASID_0) {
> +        HostIOMMUDeviceIOMMUFD *idev =
> +            HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +        uint32_t entry_num = 1; /* Only implement one request for simplicity */
> +        Error *local_err = NULL;
> +        struct iommu_hwpt_vtd_s1_invalidate *cache = piotlb_info->inv_data;
> +
> +        if (!iommufd_backend_invalidate_cache(idev->iommufd, vtd_as->fs_hwpt,
> +                                              IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
> +                                              sizeof(*cache), &entry_num, cache,
> +                                              &local_err)) {
> +            /* Something wrong in kernel, but trying to continue */
> +            error_report_err(local_err);
> +        }
> +    }
> +}
> +
> +void vtd_flush_host_piotlb_all_locked(IntelIOMMUState *s, uint16_t domain_id,
> +                                      uint32_t pasid, hwaddr addr,
> +                                      uint64_t npages, bool ih)
> +{
> +    struct iommu_hwpt_vtd_s1_invalidate cache_info = { 0 };
> +    VTDPIOTLBInvInfo piotlb_info;
> +
> +    cache_info.addr = addr;
> +    cache_info.npages = npages;
> +    cache_info.flags = ih ? IOMMU_VTD_INV_FLAGS_LEAF : 0;
> +
> +    piotlb_info.domain_id = domain_id;
> +    piotlb_info.pasid = pasid;
> +    piotlb_info.inv_data = &cache_info;
> +
> +    /*
> +     * Go through each vtd_as instance in s->vtd_address_spaces, find out
> +     * affected host devices which need host piotlb invalidation. Piotlb
> +     * invalidation should check pasid cache per architecture point of view.
> +     */
> +    g_hash_table_foreach(s->vtd_address_spaces,
> +                         vtd_flush_host_piotlb_locked, &piotlb_info);
> +}
Looks good to me

Reviewed-by: Eric Auger <eric.auger@redhat.com>


Eric



