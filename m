Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E395EC77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 13:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uThQk-0004n6-5y; Mon, 23 Jun 2025 09:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uThQi-0004lV-3s
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:41:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uThQd-0004pi-Bg
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:41:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750686100;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jyk7ctFWXw8PChcCSNZX+oMObQ82KiagzQI8sSYd1bU=;
 b=LcL/dhM3hnEpdFFj4SM4hVI1dlhjA96G2h+J9KGpOshZXCx9nJwfG0lu9G0izkibNr+TwO
 8TZP4C/Ce/3rZ5O0yVmqt4jO0xaEbSq0yP0WiFAtLvrZ0LG93skD1417TLOxkymCWDzXBQ
 eJOCa3lJ66he6ktS4tMNZk+Lsfw7AMA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-FPfH8jzvNTyfmP9Ave17zQ-1; Mon, 23 Jun 2025 09:41:35 -0400
X-MC-Unique: FPfH8jzvNTyfmP9Ave17zQ-1
X-Mimecast-MFC-AGG-ID: FPfH8jzvNTyfmP9Ave17zQ_1750686095
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451d2037f1eso26045845e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 06:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750686095; x=1751290895;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jyk7ctFWXw8PChcCSNZX+oMObQ82KiagzQI8sSYd1bU=;
 b=twl/O1aulVFSvljBbNUzzOstKjK4VKg5znhP0WE5gnhsMMtvJOAju9xOXXig1NL3DH
 ykMzZCY3NQoP5IAv+PyuXEwWL66G/13/QWqYGBAJYXb+CLtbnq1N0TN3lwAEtSiLC8Ac
 XRHx5YslLlGCqbah1JkJdRx5/3u0vWWtvggJVkUFN3D2rNep45ak0Xof+sxSAf2kKhL4
 RHb4HtboN5Ki9mOZMIwA0z1DW/TXRyrYPOA0IlzI6Eq6rxLWL9jjT0W4TsD8eWcmdi2A
 b7ysd6qQLVQsMalkPRNI6VYg3cKwNFaUzWdYETHlOJkLwxzhK2oGk7otFwbfu5k0cxXP
 LbxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF7b6ACRwz336nLWOCmTGtkK+WIeMByLwMVrgwVs+d0bxmaybF6OohNR07rurmQEFt0gT3U0QsJZGO@nongnu.org
X-Gm-Message-State: AOJu0YzCYAZrHL6XSrg0LYBkZCMQkaCUycYnKFoHvpcsYws7zjUiQJOE
 XpoMVFbG8v5OpRjqnsjSfwgYJ1od6X1YeOy4+FgV+av0RV4XRVV2WB2mLLjZaP30gcn77vrRd9k
 VDo2OnIQEpYE7qv9f1lNV5bsE+d00WAMdDiEOt844saFeDBPGAyOFoO/t
X-Gm-Gg: ASbGncsrnAa2iKVCYlXmfZMw9ekV7B9uAebGF4Jm5yS1lKYm3LcAsweYzJzCdMRiruD
 t/xUixrheUAwjAgGkLfvi4tDfPt0arElbHkYUok4mZBq1nD1jN1tRvyk9MVwPVn2WRdgAfVDqMf
 Qh4mXQ5BHWB3RTmQfa1BDaXLaZvZDHso0FzSBYXzx4DUb0bcpyJq9pWUrWX5MOEb9NKencH7Mh7
 zOfcDrgaurFVUY6uCz5Zq4O7FODGmuhHW8S27N9H3cqt/CdIAjd+I5LcMgox5N1A7EdD2Pkgk5j
 1Z4ZdvMpSQfK198b+676rJI//ITUmGmPtERv9/p3Akhv9jt2RPy1PT3dvsNYumK6THB6Yg==
X-Received: by 2002:a05:600c:c3c1:b0:440:68db:9fef with SMTP id
 5b1f17b1804b1-453655c612bmr71385415e9.20.1750686094572; 
 Mon, 23 Jun 2025 06:41:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEY+4RojiFC/+KAYyLmbz/TRdJfu58waLF7BW29FjOABd3wHReGAlShHJjLchHizasfxhFWfA==
X-Received: by 2002:a05:600c:c3c1:b0:440:68db:9fef with SMTP id
 5b1f17b1804b1-453655c612bmr71385205e9.20.1750686094080; 
 Mon, 23 Jun 2025 06:41:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535ebcecb5sm145990925e9.37.2025.06.23.06.41.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 06:41:33 -0700 (PDT)
Message-ID: <f38345e6-701f-4a10-9505-7f5bfb0a9b91@redhat.com>
Date: Mon, 23 Jun 2025 15:41:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/19] intel_iommu: Propagate PASID-based iotlb
 invalidation to host
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, shameerali.kolothum.thodi@huawei.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Yi Sun <yi.y.sun@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-17-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250620071813.55571-17-zhenzhong.duan@intel.com>
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

Hi Zhenzhong,

On 6/20/25 9:18 AM, Zhenzhong Duan wrote:
> From: Yi Liu <yi.l.liu@intel.com>
>
> This traps the guest PASID-based iotlb invalidation request and propagate it
> to host.
>
> Intel VT-d 3.0 supports nested translation in PASID granular. Guest SVA support
s/granular/granularity
> could be implemented by configuring nested translation on specific PASID. This
> is also known as dual stage DMA translation.
>
> Under such configuration, guest owns the GVA->GPA translation which is
> configured as stage-1 page table in host side for a specific pasid, and host
> owns GPA->HPA translation. As guest owns stage-1 translation table, piotlb
> invalidation should be propagated to host since host IOMMU will cache first
> level page table related mappings during DMA address translation.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h |   6 ++
>  hw/i386/intel_iommu.c          | 113 ++++++++++++++++++++++++++++++++-
>  2 files changed, 117 insertions(+), 2 deletions(-)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index b3e4aa23f1..07bfb97499 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -589,6 +589,12 @@ typedef struct VTDPASIDCacheInfo {
>      bool error_happened;
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
> index 621b07aa02..d1fa395274 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -2639,12 +2639,105 @@ static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as,
>  
>      return ret;
>  }
> +
> +/*
> + * Caller of this function should hold iommu_lock.
> + */
> +static void vtd_invalidate_piotlb(VTDAddressSpace *vtd_as,
> +                                  struct iommu_hwpt_vtd_s1_invalidate *cache)
> +{
> +    VTDHostIOMMUDevice *vtd_hiod;
> +    HostIOMMUDeviceIOMMUFD *idev;
> +    int devfn = vtd_as->devfn;
> +    struct vtd_as_key key = {
> +        .bus = vtd_as->bus,
> +        .devfn = devfn,
> +    };
> +    IntelIOMMUState *s = vtd_as->iommu_state;
> +    uint32_t entry_num = 1; /* Only implement one request for simplicity */
> +    Error *err;
> +
> +    vtd_hiod = g_hash_table_lookup(s->vtd_host_iommu_dev, &key);
> +    if (!vtd_hiod || !vtd_hiod->hiod) {
> +        return;
> +    }
> +    idev = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +
> +    if (!iommufd_backend_invalidate_cache(idev->iommufd, vtd_hiod->s1_hwpt,
> +                                          IOMMU_HWPT_INVALIDATE_DATA_VTD_S1,
> +                                          sizeof(*cache), &entry_num, cache,
> +                                          &err)) {
> +        error_report_err(err);
> +    }
> +}
> +
> +/*
> + * This function is a loop function for the s->vtd_address_spaces
> + * list with VTDPIOTLBInvInfo as execution filter. It propagates
> + * the piotlb invalidation to host. Caller of this function
> + * should hold iommu_lock.
instead of having this mention everywhere may be more efficient to
postfix each function with _locked and I don't know if it exists have a
checker.
> + */
> +static void vtd_flush_pasid_iotlb(gpointer key, gpointer value,
> +                                  gpointer user_data)
> +{
> +    VTDPIOTLBInvInfo *piotlb_info = user_data;
> +    VTDAddressSpace *vtd_as = value;
> +    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
> +    uint32_t pasid;
> +    uint16_t did;
> +
> +    /* Replay only fill pasid entry cache for passthrough device */
fills
> +    if (!pc_entry->cache_filled ||
> +        !vtd_pe_pgtt_is_flt(&pc_entry->pasid_entry)) {
> +        return;
> +    }
> +
> +    if (vtd_as_to_iommu_pasid_locked(vtd_as, &pasid)) {
> +        return;
> +    }
> +
> +    did = vtd_pe_get_did(&pc_entry->pasid_entry);
> +
> +    if (piotlb_info->domain_id == did && piotlb_info->pasid == pasid) {
> +        vtd_invalidate_piotlb(vtd_as, piotlb_info->inv_data);
> +    }
> +}
> +
> +static void vtd_flush_pasid_iotlb_all(IntelIOMMUState *s,
> +                                      uint16_t domain_id, uint32_t pasid,
> +                                      hwaddr addr, uint64_t npages, bool ih)
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
> +     * Here loops all the vtd_as instances in s->vtd_address_spaces
I am not a native english speaker but I am not sure loop something is
OK. Go though each?
Besides that comment is not that useful as it paraphrases the code.
> +     * to find out the affected devices since piotlb invalidation
> +     * should check pasid cache per architecture point of view.
> +     */
> +    g_hash_table_foreach(s->vtd_address_spaces,
> +                         vtd_flush_pasid_iotlb, &piotlb_info);
> +}
>  #else
>  static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as,
>                                  VTDPASIDEntry *pe, VTDPASIDOp op)
>  {
>      return 0;
>  }
> +
> +static void vtd_flush_pasid_iotlb_all(IntelIOMMUState *s,
> +                                      uint16_t domain_id, uint32_t pasid,
> +                                      hwaddr addr, uint64_t npages, bool ih)
> +{
> +}
>  #endif
>  
>  /* Do a context-cache device-selective invalidation.
> @@ -3300,6 +3393,13 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>      info.pasid = pasid;
>  
>      vtd_iommu_lock(s);
> +    /*
> +     * Here loops all the vtd_as instances in s->vtd_as
would frop above.
> +     * to find out the affected devices since piotlb invalidation
Find out ...
> +     * should check pasid cache per architecture point of view.
> +     */
> +    vtd_flush_pasid_iotlb_all(s, domain_id, pasid, 0, (uint64_t)-1, 0);
> +
>      g_hash_table_foreach_remove(s->iotlb, vtd_hash_remove_by_pasid,
>                                  &info);
>      vtd_iommu_unlock(s);
> @@ -3323,7 +3423,8 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>  }
>  
>  static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
> -                                       uint32_t pasid, hwaddr addr, uint8_t am)
> +                                       uint32_t pasid, hwaddr addr, uint8_t am,
> +                                       bool ih)
>  {
>      VTDIOTLBPageInvInfo info;
>  
> @@ -3333,6 +3434,13 @@ static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
>      info.mask = ~((1 << am) - 1);
>  
>      vtd_iommu_lock(s);
> +    /*
> +     * Here loops all the vtd_as instances in s->vtd_as
> +     * to find out the affected devices since piotlb invalidation
> +     * should check pasid cache per architecture point of view.
> +     */
> +    vtd_flush_pasid_iotlb_all(s, domain_id, pasid, addr, 1 << am, ih);
> +
>      g_hash_table_foreach_remove(s->iotlb,
>                                  vtd_hash_remove_by_page_piotlb, &info);
>      vtd_iommu_unlock(s);
> @@ -3366,7 +3474,8 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
>      case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
>          am = VTD_INV_DESC_PIOTLB_AM(inv_desc->val[1]);
>          addr = (hwaddr) VTD_INV_DESC_PIOTLB_ADDR(inv_desc->val[1]);
> -        vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am);
> +        vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am,
> +                                   VTD_INV_DESC_PIOTLB_IH(inv_desc->val[1]));
>          break;
>  
>      default:
Eric


