Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DEECA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 14:26:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urH60-00074U-FA; Wed, 27 Aug 2025 10:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urH5v-000709-Rj
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 10:25:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1urH5s-0007B2-6Q
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 10:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756304740;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0OuQwOGdi1+h8gPcCTujGYtjAMDCpWJ/PKRlR/hRi/c=;
 b=gBmGioIsnoaStsIOhysLtenK1yMyTaTG6hEcJSCSPL7k0cXVT7Kbu8r8DmOqHJLXjQKbQ+
 /E43WFRZTuiL19f3sPO+rn51PMaHyWRUbHJJsF96ReMPXjUvbuxpgOjPPbqXw+skvwtD1b
 LIzwVyIXQc5yP6/bjIQaluReeVa2NYk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-MRY-U6FtM76r2oxKbXhgMg-1; Wed, 27 Aug 2025 10:25:33 -0400
X-MC-Unique: MRY-U6FtM76r2oxKbXhgMg-1
X-Mimecast-MFC-AGG-ID: MRY-U6FtM76r2oxKbXhgMg_1756304732
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45a15f10f31so6797925e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 07:25:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756304732; x=1756909532;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0OuQwOGdi1+h8gPcCTujGYtjAMDCpWJ/PKRlR/hRi/c=;
 b=CTr0ZKF+CDwszfoTC1gEcGK6Up4Wty1Grvs+7okgK7UgNoVT5yFWXgvE8Cb8iJYVFk
 7Q1z8QOY8M658ULvDnuvzunhq8ssgyKmnueSeDno9Wac5ZXpCFtQsFtghcfjOO2MEGlz
 w1iilp2xbhufkep+5y8RUCRggQXsYjI2RRDA5rWYwEVHNffVw/Lt0dFV1oR7qlbrLEeh
 61/nXH7nSjwQU/MihjCKbTEKFYDBdEAvSpzd0mifp+4pa00PoegC/AkLjccwA+aYcy7c
 0rlApeBhdC3QzirLwcdimpAQ0uCcJTAWVm1hQTA9M6U0AFYemVOHPzEc/YP3cY/L60Ln
 vCnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYbvbSUUOnitwhrgQ+wXxcDL3P28NNsX+DjDT/tX3bAs5PZLPJoGS7DzLXyyDCtvnSGGvqiEUzV/8h@nongnu.org
X-Gm-Message-State: AOJu0YxMopX84pg/LmVLdzwaq6FCwRxyVtgd5gjQzyjm+NKVkUhbB3MJ
 ZQb2M6aWS4i2HhEtegEDnknp8F7uwO61vAwkv0kbLs/i4HXQMPfuzfrs8sOB7maaztJJFu5Z01A
 NeLWdZFmJArIPBkCIL/1QTOWAgRWTMhfLibJ2ctzs4KSRxpacDs4TZ9vD
X-Gm-Gg: ASbGncuMZDt/vGyEmxN+/EjkqzsZi30W2iYC4J1hl9YanNc4SDvuTmmVlHjOUs1Uqay
 nf7bGN5vvcRQkopmMpxMrpnft8M1C20DAMulGtz/dfwZNN0keq4TxPbU8zPMOxg2pJ15Ya5qwSy
 3n9rR4c6YsHO4YUA3zg/DyJs3OfdDq4MwqaDT9waiRrI97p9CPy6h2Rdty0i4RTAKdUKdl6Ci5m
 h7KhYkHvksTqb0mAiM1EvaHTKE6vQg8n7ooD6Ys+GX2ixSknfPVZ/xHAooEKdjxKnHC6MXP15nO
 nMyI3FVJEHT89Ptlc8WRkyHIfQiTxLKAd7ajpF1lCiMurRCAmgD5YaiV0gCAizN9zm/xJCx/Eg8
 1DTbYXNVFvXE=
X-Received: by 2002:a05:600c:4512:b0:45b:75d9:516e with SMTP id
 5b1f17b1804b1-45b75d954e6mr2929685e9.15.1756304731987; 
 Wed, 27 Aug 2025 07:25:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuCe3cwhKHAtMRtS7wyUcvwZfudPNdvB7sFfwduQKRbo+VUImkd5jKDGjGJPr1AQk/sXaq9Q==
X-Received: by 2002:a05:600c:4512:b0:45b:75d9:516e with SMTP id
 5b1f17b1804b1-45b75d954e6mr2929305e9.15.1756304731460; 
 Wed, 27 Aug 2025 07:25:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6b1bb9fbsm20638035e9.1.2025.08.27.07.25.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Aug 2025 07:25:30 -0700 (PDT)
Message-ID: <2c150f38-6404-4b1b-912b-8f39658081f1@redhat.com>
Date: Wed, 27 Aug 2025 16:25:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/21] intel_iommu: Handle PASID entry removal and
 update
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Yi Sun <yi.y.sun@linux.intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-12-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250822064101.123526-12-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Zhenzhong,

On 8/22/25 8:40 AM, Zhenzhong Duan wrote:
> This adds an new entry VTDPASIDCacheEntry in VTDAddressSpace to cache the
> pasid entry and track PASID usage and future PASID tagged DMA address
> translation support in vIOMMU.
>
> VTDAddressSpace of PCI_NO_PASID is allocated when device is plugged and
> never freed. For other pasid, VTDAddressSpace instance is created/destroyed
> per the guest pasid entry set up/destroy.
>
> When guest removes or updates a PASID entry, QEMU will capture the guest pasid
> selective pasid cache invalidation, removes VTDAddressSpace or update cached
> PASID entry.
>
> vIOMMU emulator could figure out the reason by fetching latest guest pasid entry
> and compare it with cached PASID entry.
>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h |  27 ++++-
>  include/hw/i386/intel_iommu.h  |   6 +
>  hw/i386/intel_iommu.c          | 196 +++++++++++++++++++++++++++++++--
>  hw/i386/trace-events           |   3 +
>  4 files changed, 220 insertions(+), 12 deletions(-)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index f7510861d1..b9b76dd996 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -316,6 +316,7 @@ typedef enum VTDFaultReason {
>                                    * request while disabled */
>      VTD_FR_IR_SID_ERR = 0x26,   /* Invalid Source-ID */
>  
> +    VTD_FR_RTADDR_INV_TTM = 0x31,  /* Invalid TTM in RTADDR */
>      /* PASID directory entry access failure */
>      VTD_FR_PASID_DIR_ACCESS_ERR = 0x50,
>      /* The Present(P) field of pasid directory entry is 0 */
> @@ -493,6 +494,15 @@ typedef union VTDInvDesc VTDInvDesc;
>  #define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000f1c0ULL
>  #define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
>  
> +/* PASID-cache Invalidate Descriptor (pc_inv_dsc) fields */
> +#define VTD_INV_DESC_PASIDC_G(x)        extract64((x)->val[0], 4, 2)
> +#define VTD_INV_DESC_PASIDC_G_DSI       0
> +#define VTD_INV_DESC_PASIDC_G_PASID_SI  1
> +#define VTD_INV_DESC_PASIDC_G_GLOBAL    3
> +#define VTD_INV_DESC_PASIDC_DID(x)      extract64((x)->val[0], 16, 16)
> +#define VTD_INV_DESC_PASIDC_PASID(x)    extract64((x)->val[0], 32, 20)
> +#define VTD_INV_DESC_PASIDC_RSVD_VAL0   0xfff000000000f1c0ULL
> +
>  /* Information about page-selective IOTLB invalidate */
>  struct VTDIOTLBPageInvInfo {
>      uint16_t domain_id;
> @@ -553,6 +563,21 @@ typedef struct VTDRootEntry VTDRootEntry;
>  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
>  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
>  
> +typedef enum VTDPCInvType {
> +    /* VTD spec defined PASID cache invalidation type */
> +    VTD_PASID_CACHE_DOMSI = VTD_INV_DESC_PASIDC_G_DSI,
> +    VTD_PASID_CACHE_PASIDSI = VTD_INV_DESC_PASIDC_G_PASID_SI,
> +    VTD_PASID_CACHE_GLOBAL_INV = VTD_INV_DESC_PASIDC_G_GLOBAL,
> +} VTDPCInvType;
> +
> +typedef struct VTDPASIDCacheInfo {
> +    VTDPCInvType type;
> +    uint16_t did;
> +    uint32_t pasid;
> +    PCIBus *bus;
> +    uint16_t devfn;
> +} VTDPASIDCacheInfo;
> +
>  /* PASID Table Related Definitions */
>  #define VTD_PASID_DIR_BASE_ADDR_MASK  (~0xfffULL)
>  #define VTD_PASID_TABLE_BASE_ADDR_MASK (~0xfffULL)
> @@ -574,7 +599,7 @@ typedef struct VTDRootEntry VTDRootEntry;
>  #define VTD_SM_PASID_ENTRY_PT          (4ULL << 6)
>  
>  #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
> -#define VTD_SM_PASID_ENTRY_DID(val)    ((val) & VTD_DOMAIN_ID_MASK)
> +#define VTD_SM_PASID_ENTRY_DID(x)      extract64((x)->val[1], 0, 16)
>  
>  #define VTD_SM_PASID_ENTRY_FLPM          3ULL
>  #define VTD_SM_PASID_ENTRY_FLPTPTR       (~0xfffULL)
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 50f9b27a45..0e3826f6f0 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -95,6 +95,11 @@ struct VTDPASIDEntry {
>      uint64_t val[8];
>  };
>  
> +typedef struct VTDPASIDCacheEntry {
> +    struct VTDPASIDEntry pasid_entry;
> +    bool valid;
> +} VTDPASIDCacheEntry;
> +
>  struct VTDAddressSpace {
>      PCIBus *bus;
>      uint8_t devfn;
> @@ -107,6 +112,7 @@ struct VTDAddressSpace {
>      MemoryRegion iommu_ir_fault; /* Interrupt region for catching fault */
>      IntelIOMMUState *iommu_state;
>      VTDContextCacheEntry context_cache_entry;
> +    VTDPASIDCacheEntry pasid_cache_entry;
>      QLIST_ENTRY(VTDAddressSpace) next;
>      /* Superset of notifier flags that this address space has */
>      IOMMUNotifierFlag notifier_flags;
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 1801f1cdf6..a2ee6d684e 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1675,7 +1675,7 @@ static uint16_t vtd_get_domain_id(IntelIOMMUState *s,
>  
>      if (s->root_scalable) {
>          vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
> -        return VTD_SM_PASID_ENTRY_DID(pe.val[1]);
> +        return VTD_SM_PASID_ENTRY_DID(&pe);
>      }
>  
>      return VTD_CONTEXT_ENTRY_DID(ce->hi);
> @@ -3112,6 +3112,183 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
>      return true;
>  }
>  
> +static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
> +                                            uint32_t pasid, VTDPASIDEntry *pe)
> +{
> +    IntelIOMMUState *s = vtd_as->iommu_state;
> +    VTDContextEntry ce;
> +    int ret;
> +
> +    if (!s->root_scalable) {
> +        return -VTD_FR_RTADDR_INV_TTM;
> +    }
> +
> +    ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus), vtd_as->devfn,
> +                                   &ce);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    return vtd_ce_get_pasid_entry(s, &ce, pe, pasid);
> +}
> +
> +static bool vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
> +{
> +    return !memcmp(p1, p2, sizeof(*p1));
> +}
> +
> +/*
> + * This function is a loop function which return value determines if
whose returned value determines whether current vtd_as iterator matches
the pasid cache entry info passed in user_data and needs to be removed
from the pasid cache. 
> + * vtd_as including cached pasid entry is removed.
> + *
> + * For PCI_NO_PASID, when corresponding cached pasid entry is cleared,
> + * it returns false so that vtd_as is reserved as it's owned by PCI
> + * sub-system. For other pasid, it returns true so vtd_as is removed.
> + */
> +static gboolean vtd_flush_pasid_locked(gpointer key, gpointer value,
> +                                       gpointer user_data)
> +{
> +    VTDPASIDCacheInfo *pc_info = user_data;
> +    VTDAddressSpace *vtd_as = value;
> +    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
> +    VTDPASIDEntry pe;
> +    uint16_t did;
> +    uint32_t pasid;
> +    int ret;
> +
> +    if (!pc_entry->valid) {
> +        return false;
> +    }
> +    did = VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
> +
> +    if (vtd_as_to_iommu_pasid_locked(vtd_as, &pasid)) {
> +        goto remove;
> +    }
> +
> +    switch (pc_info->type) {
> +    case VTD_PASID_CACHE_PASIDSI:
> +        if (pc_info->pasid != pasid) {
> +            return false;
> +        }
> +        /* fall through */
> +    case VTD_PASID_CACHE_DOMSI:
> +        if (pc_info->did != did) {
> +            return false;
> +        }
> +        /* fall through */
> +    case VTD_PASID_CACHE_GLOBAL_INV:
> +        break;
> +    default:
> +        error_setg(&error_fatal, "invalid pc_info->type for flush");
> +    }
> +
> +    /*
> +     * pasid cache invalidation may indicate a present pasid entry to present
> +     * pasid entry modification. To cover such case, vIOMMU emulator needs to
> +     * fetch latest guest pasid entry and compares with cached pasid entry,
> +     * then update pasid cache.
> +     */
> +    ret = vtd_dev_get_pe_from_pasid(vtd_as, pasid, &pe);
> +    if (ret) {
> +        /*
> +         * No valid pasid entry in guest memory. e.g. pasid entry was modified
> +         * to be either all-zero or non-present. Either case means existing
> +         * pasid cache should be removed.
> +         */
> +        goto remove;
> +    }
> +
> +    /*
> +     * Update cached pasid entry if it's stale compared to what's in guest
> +     * memory.
> +     */
> +    if (!vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
> +        pc_entry->pasid_entry = pe;
> +    }
> +    return false;
> +
> +remove:
> +    pc_entry->valid = false;
> +
> +    /*
> +     * Don't remove address space of PCI_NO_PASID which is created for PCI
> +     * sub-system.
> +     */
> +    if (vtd_as->pasid == PCI_NO_PASID) {
> +        return false;
> +    }
> +    return true;
> +}
> +
> +/*
> + * For a PASID cache invalidation, this function handles below scenarios:
> + * a) a present cached pasid entry needs to be removed
> + * b) a present cached pasid entry needs to be updated
> + */
> +static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
> +{
> +    if (!s->flts || !s->root_scalable || !s->dmar_enabled) {
> +        return;
> +    }
> +
> +    vtd_iommu_lock(s);
> +    /*
> +     * a,b): loop all the existing vtd_as instances for pasid cache removal
> +       or update.
> +     */
> +    g_hash_table_foreach_remove(s->vtd_address_spaces, vtd_flush_pasid_locked,
> +                                pc_info);
> +    vtd_iommu_unlock(s);
> +}
> +
> +static bool vtd_process_pasid_desc(IntelIOMMUState *s,
> +                                   VTDInvDesc *inv_desc)
> +{
> +    uint16_t did;
> +    uint32_t pasid;
> +    VTDPASIDCacheInfo pc_info;
> +    uint64_t mask[4] = {VTD_INV_DESC_PASIDC_RSVD_VAL0, VTD_INV_DESC_ALL_ONE,
> +                        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
> +
> +    if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, true,
> +                                     __func__, "pasid cache inv")) {
> +        return false;
> +    }
> +
> +    did = VTD_INV_DESC_PASIDC_DID(inv_desc);
> +    pasid = VTD_INV_DESC_PASIDC_PASID(inv_desc);
> +
> +    switch (VTD_INV_DESC_PASIDC_G(inv_desc)) {
> +    case VTD_INV_DESC_PASIDC_G_DSI:
> +        trace_vtd_pasid_cache_dsi(did);
> +        pc_info.type = VTD_PASID_CACHE_DOMSI;
> +        pc_info.did = did;
> +        break;
> +
> +    case VTD_INV_DESC_PASIDC_G_PASID_SI:
> +        /* PASID selective implies a DID selective */
> +        trace_vtd_pasid_cache_psi(did, pasid);
> +        pc_info.type = VTD_PASID_CACHE_PASIDSI;
> +        pc_info.did = did;
> +        pc_info.pasid = pasid;
> +        break;
> +
> +    case VTD_INV_DESC_PASIDC_G_GLOBAL:
> +        trace_vtd_pasid_cache_gsi();
> +        pc_info.type = VTD_PASID_CACHE_GLOBAL_INV;
> +        break;
> +
> +    default:
> +        error_report_once("invalid granularity field in PASID-cache invalidate "
> +                          "descriptor, hi: 0x%"PRIx64" lo: 0x%" PRIx64,
> +                           inv_desc->val[1], inv_desc->val[0]);
what's the point of printing the 2nd 64b? Looking at Figure 6-2 in the
spec (6.5.2.2. PASID-cache invalidate descriptor) it does not seem to
contain anything?

Besides I read in the spec:
Domain-ID (DID): The DID field indicates the target domain-id. Hardware
ignores bits 31:(16+N), where N is the domain-id width reported in the
Capability Register.

How do you make sure N is same on both pIOMMU and vIOMMU?


> +        return false;
> +    }
> +
> +    vtd_pasid_cache_sync(s, &pc_info);
> +    return true;
> +}
> +
>  static bool vtd_process_inv_iec_desc(IntelIOMMUState *s,
>                                       VTDInvDesc *inv_desc)
>  {
> @@ -3274,6 +3451,13 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
>          }
>          break;
>  
> +    case VTD_INV_DESC_PC:
> +        trace_vtd_inv_desc("pasid-cache", inv_desc.val[1], inv_desc.val[0]);
same here
> +        if (!vtd_process_pasid_desc(s, &inv_desc)) {
> +            return false;
> +        }
> +        break;
> +
>      case VTD_INV_DESC_PIOTLB:
>          trace_vtd_inv_desc("p-iotlb", inv_desc.val[1], inv_desc.val[0]);
>          if (!vtd_process_piotlb_desc(s, &inv_desc)) {
> @@ -3309,16 +3493,6 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
>          }
>          break;
>  
> -    /*
> -     * TODO: the entity of below two cases will be implemented in future series.
> -     * To make guest (which integrates scalable mode support patch set in
> -     * iommu driver) work, just return true is enough so far.
> -     */
> -    case VTD_INV_DESC_PC:
> -        if (s->scalable_mode) {
> -            break;
> -        }
> -    /* fallthrough */
>      default:
>          error_report_once("%s: invalid inv desc: hi=%"PRIx64", lo=%"PRIx64
>                            " (unknown type)", __func__, inv_desc.hi,
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index ac9e1a10aa..ae5bbfcdc0 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -24,6 +24,9 @@ vtd_inv_qi_head(uint16_t head) "read head %d"
>  vtd_inv_qi_tail(uint16_t head) "write tail %d"
>  vtd_inv_qi_fetch(void) ""
>  vtd_context_cache_reset(void) ""
> +vtd_pasid_cache_gsi(void) ""
> +vtd_pasid_cache_dsi(uint16_t domain) "Domain selective PC invalidation domain 0x%"PRIx16
> +vtd_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID selective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32
>  vtd_re_not_present(uint8_t bus) "Root entry bus %"PRIu8" not present"
>  vtd_ce_not_present(uint8_t bus, uint8_t devfn) "Context entry bus %"PRIu8" devfn %"PRIu8" not present"
>  vtd_iotlb_page_hit(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page hit sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16
Besides the code looks good to me

Eric


