Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8A6BD2CE17
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 10:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTHsg-0001jO-IE; Wed, 10 Dec 2025 05:57:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vTHsf-0001j9-5J
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 05:57:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vTHsd-0002jm-CH
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 05:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765364230;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c9Vm7fuR6Kv4tNbZncmgIRBm+204ulp4nL0kSmXLi60=;
 b=inymNf794sz1tR0gjAoeVHGJrFlWbWvmK6tE0CnmTAxRyg3UpHJHZFdS+RlZUyYogX91PS
 bBowlJq0aGF5R+ppZ0pL7RhvmnFj+5BDmtNNIWQXa1ebm3urxkVXTys9lWQxgFCfXRIfxx
 Nq6BcEfdQaDG0EuupAQGELYFofHf45A=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-vPMpJx-1PZesrAMZw1PL7A-1; Wed, 10 Dec 2025 05:57:08 -0500
X-MC-Unique: vPMpJx-1PZesrAMZw1PL7A-1
X-Mimecast-MFC-AGG-ID: vPMpJx-1PZesrAMZw1PL7A_1765364228
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-880441e0f93so20691506d6.1
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 02:57:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765364228; x=1765969028;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9Vm7fuR6Kv4tNbZncmgIRBm+204ulp4nL0kSmXLi60=;
 b=mdVgAhADOqVSIuwV+eZWNK2ILCsFQwjc6yESzwKjj9amETnHwsoJjYT0QI9JiUcYuW
 QgFjQRVL/EwIJshKDmihayrpe8uQ/ftqUo4AviKZEzQwOmEEJK2524Ha+BjCZatWpzMx
 YIBggzdCKd9P+ZzPR1UCxPIlSFJauzQi6LXkr6j5piri0eE13NrIlRFs4OtBttrRIMb/
 xQYjY1vpMFid1iZWa1MXEg1VBPcq7TyL/PIB0hI5qFUmmXiuUn73Wha+OfAEGUBAxf+E
 nBCb9eEAUPCdepOBP9GNXR0YW1e3ox8Yd2u+LkuuyZ5MvgdRkhTSCM7m8F/DP027n4ca
 SoXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgqVvkhTV9tAYwKxY7s1BPh8YQ8BK/KiI9YglWGxKZ6/fxAMwVXuBoGq0X5U1SY3AcoPiS+Eb4He0q@nongnu.org
X-Gm-Message-State: AOJu0Yy3cNXpjQi3431Up5Ni1Lzzt+PqXgEVxX5B6EKo32jHCIidzcUz
 2of06/9yGxL072DYaHZrnrXuU8U2n4G9yjSHFoyfsVIUtKBbenXcSh6m1Uh32P0gNS5ilYbIlFG
 RxBQHOm/BmaaiZ5Ju6JqDqIVZjIOtwmVOAC6T3pdm+MWQOmuc101ESsmP
X-Gm-Gg: AY/fxX6Ci883Ipcd5HUKTfRDLonAPCXYDbgc3e/GRrd0ej1qVNOyeRnDLUhw3Q6S9fh
 2LtVLVAnfBiPRR4c4DKl8KSKUFhiIelUDP2Ao1nVYW7zuOlF+dDPHMY5SQnu0Z/FLKMDOaJbHxF
 h/+XRO9gf41S+sMEm1tTzuu+vyKfcFYfnpJt20YcMvLqsW8oWhCDF7WyHZ4XlAAyIl7KZ7EXcBS
 hyQlCPGiKNwiGU8BG4pQQ5pFwYgnQqhqRyed+3FPM29Tevii+EYG4FGR9kjmhdbG5qnB1yuKr9M
 5nW/oqLvItdRiWXDFW2etW7xfkmWp8VSMkrm9K9+eJte/D7K1Ql9vlF+CXQQh087zPoWzoe6HZJ
 Qv/b7FjDN58qnLtJHlp2G/JF5rYUcRFqjjEHHwujvFFiQOh17EQ7kjsYJcA==
X-Received: by 2002:ad4:5b8f:0:b0:882:6d1a:eaea with SMTP id
 6a1803df08f44-8885c249a92mr74098106d6.30.1765364228381; 
 Wed, 10 Dec 2025 02:57:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFiAU0+yUxO2c1mzKZhzzO/vcMPg+rC3fLkB4dxp3LMgYHXDl3G+gb87C8a4cgrrcs4Y4lwTg==
X-Received: by 2002:ad4:5b8f:0:b0:882:6d1a:eaea with SMTP id
 6a1803df08f44-8885c249a92mr74097656d6.30.1765364227954; 
 Wed, 10 Dec 2025 02:57:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88827f49097sm152958036d6.14.2025.12.10.02.57.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Dec 2025 02:57:07 -0800 (PST)
Message-ID: <29cc809c-bc6d-44a9-a4eb-85f618ebe01d@redhat.com>
Date: Wed, 10 Dec 2025 11:57:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/23] intel_iommu: Delete RPS capability related
 supporting code
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, mst@redhat.com, jasowang@redhat.com,
 peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
 <20251117093729.1121324-3-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251117093729.1121324-3-zhenzhong.duan@intel.com>
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Zhenzhong,

On 11/17/25 10:37 AM, Zhenzhong Duan wrote:
> RID-PASID Support(RPS) is not set in vIOMMU ECAP register, the supporting
> code is there but never takes effect.
>
> Meanwhile, according to VTD spec section 3.4.3:
> "Implementations not supporting RID_PASID capability (ECAP_REG.RPS is 0b),
> use a PASID value of 0 to perform address translation for requests without
> PASID."
>
> We should delete the supporting code which fetches RID_PASID field from
> scalable context entry and use 0 as RID_PASID directly, because RID_PASID
> field is ignored if no RPS support according to spec.
>
> This simplifies the code and doesn't bring any penalty.
>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h |  2 +-
>  hw/i386/intel_iommu.c          | 89 +++++++++++-----------------------
>  2 files changed, 28 insertions(+), 63 deletions(-)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 75bafdf0cd..36d04427dd 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -609,7 +609,7 @@ typedef struct VTDRootEntry VTDRootEntry;
>  #define VTD_CTX_ENTRY_LEGACY_SIZE     16
>  #define VTD_CTX_ENTRY_SCALABLE_SIZE   32
>  
> -#define VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK 0xfffff
> +#define PASID_0                             0
>  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
>  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
>  #define VTD_SM_CONTEXT_ENTRY_PRE            0x10ULL
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 7b6eeb4d7d..46d2c88493 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -42,8 +42,6 @@
>  #include "trace.h"
>  
>  /* context entry operations */
> -#define VTD_CE_GET_RID2PASID(ce) \
> -    ((ce)->val[1] & VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK)
>  #define VTD_CE_GET_PASID_DIR_TABLE(ce) \
>      ((ce)->val[0] & VTD_PASID_DIR_BASE_ADDR_MASK)
>  #define VTD_CE_GET_PRE(ce) \
> @@ -959,15 +957,12 @@ static int vtd_ce_get_pasid_entry(IntelIOMMUState *s, VTDContextEntry *ce,
>                                    VTDPASIDEntry *pe, uint32_t pasid)
>  {
>      dma_addr_t pasid_dir_base;
> -    int ret = 0;
>  
>      if (pasid == PCI_NO_PASID) {
> -        pasid = VTD_CE_GET_RID2PASID(ce);
> +        pasid = PASID_0;
>      }
>      pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
> -    ret = vtd_get_pe_from_pasid_table(s, pasid_dir_base, pasid, pe);
> -
> -    return ret;
> +    return vtd_get_pe_from_pasid_table(s, pasid_dir_base, pasid, pe);
>  }
>  
>  static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
> @@ -981,7 +976,7 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
>      VTDPASIDEntry pe;
>  
>      if (pasid == PCI_NO_PASID) {
> -        pasid = VTD_CE_GET_RID2PASID(ce);
> +        pasid = PASID_0;
>      }
>      pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
>  
> @@ -1521,17 +1516,15 @@ static inline int vtd_context_entry_rsvd_bits_check(IntelIOMMUState *s,
>      return 0;
>  }
>  
> -static int vtd_ce_rid2pasid_check(IntelIOMMUState *s,
> -                                  VTDContextEntry *ce)
> +static int vtd_ce_pasid_0_check(IntelIOMMUState *s, VTDContextEntry *ce)
>  {
>      VTDPASIDEntry pe;
>  
>      /*
>       * Make sure in Scalable Mode, a present context entry
> -     * has valid rid2pasid setting, which includes valid
> -     * rid2pasid field and corresponding pasid entry setting
> +     * has valid pasid entry setting at PASID_0.
>       */
> -    return vtd_ce_get_pasid_entry(s, ce, &pe, PCI_NO_PASID);
> +    return vtd_ce_get_pasid_entry(s, ce, &pe, PASID_0);
>  }
>  
>  /* Map a device to its corresponding domain (context-entry) */
> @@ -1592,15 +1585,11 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
>          }
>      } else {
>          /*
> -         * Check if the programming of context-entry.rid2pasid
> -         * and corresponding pasid setting is valid, and thus
> -         * avoids to check pasid entry fetching result in future
> -         * helper function calling.
> +         * Check if the programming of pasid setting of PASID_0
> +         * is valid, and thus avoids to check pasid entry fetching
> +         * result in future helper function calling.
>           */
> -        ret_fr = vtd_ce_rid2pasid_check(s, ce);
> -        if (ret_fr) {
> -            return ret_fr;
> -        }
> +        return vtd_ce_pasid_0_check(s, ce);
>      }
>  
>      return 0;
> @@ -2109,7 +2098,6 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>      bool reads = true;
>      bool writes = true;
>      uint8_t access_flags, pgtt;
> -    bool rid2pasid = (pasid == PCI_NO_PASID) && s->root_scalable;
>      VTDIOTLBEntry *iotlb_entry;
>      uint64_t xlat, size;
>  
> @@ -2121,21 +2109,23 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>  
>      vtd_iommu_lock(s);
>  
> -    cc_entry = &vtd_as->context_cache_entry;
> +    if (pasid == PCI_NO_PASID && s->root_scalable) {
> +        pasid = PASID_0;
> +    }
>  
> -    /* Try to fetch pte from IOTLB, we don't need RID2PASID logic */
> -    if (!rid2pasid) {
> -        iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
> -        if (iotlb_entry) {
> -            trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->pte,
> -                                     iotlb_entry->domain_id);
> -            pte = iotlb_entry->pte;
> -            access_flags = iotlb_entry->access_flags;
> -            page_mask = iotlb_entry->mask;
> -            goto out;
> -        }
> +    /* Try to fetch pte from IOTLB */
> +    iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
> +    if (iotlb_entry) {
> +        trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->pte,
> +                                 iotlb_entry->domain_id);
> +        pte = iotlb_entry->pte;
> +        access_flags = iotlb_entry->access_flags;
> +        page_mask = iotlb_entry->mask;
> +        goto out;
>      }
>  
> +    cc_entry = &vtd_as->context_cache_entry;
> +
>      /* Try to fetch context-entry from cache first */
>      if (cc_entry->context_cache_gen == s->context_cache_gen) {
>          trace_vtd_iotlb_cc_hit(bus_num, devfn, cc_entry->context_entry.hi,
> @@ -2172,10 +2162,6 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>          cc_entry->context_cache_gen = s->context_cache_gen;
>      }
>  
> -    if (rid2pasid) {
> -        pasid = VTD_CE_GET_RID2PASID(&ce);
> -    }
> -
>      /*
>       * We don't need to translate for pass-through context entries.
>       * Also, let's ignore IOTLB caching as well for PT devices.
> @@ -2201,19 +2187,6 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>          return true;
>      }
>  
> -    /* Try to fetch pte from IOTLB for RID2PASID slow path */
> -    if (rid2pasid) {
> -        iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
> -        if (iotlb_entry) {
> -            trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->pte,
> -                                     iotlb_entry->domain_id);
> -            pte = iotlb_entry->pte;
> -            access_flags = iotlb_entry->access_flags;
> -            page_mask = iotlb_entry->mask;
> -            goto out;
> -        }
> -    }
> -
>      if (s->flts && s->root_scalable) {
>          ret_fr = vtd_iova_to_flpte(s, &ce, addr, is_write, &pte, &level,
>                                     &reads, &writes, s->aw_bits, pasid);
> @@ -2476,20 +2449,14 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
>          ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
>                                         vtd_as->devfn, &ce);
>          if (!ret && domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
> -            uint32_t rid2pasid = PCI_NO_PASID;
> -
> -            if (s->root_scalable) {
> -                rid2pasid = VTD_CE_GET_RID2PASID(&ce);
> -            }
> -
>              /*
>               * In legacy mode, vtd_as->pasid == pasid is always true.
>               * In scalable mode, for vtd address space backing a PCI
>               * device without pasid, needs to compare pasid with
> -             * rid2pasid of this device.
> +             * PASID_0 of this device.
>               */
>              if (!(vtd_as->pasid == pasid ||
> -                  (vtd_as->pasid == PCI_NO_PASID && pasid == rid2pasid))) {
> +                  (vtd_as->pasid == PCI_NO_PASID && pasid == PASID_0))) {
>                  continue;
>              }
>  
> @@ -2994,9 +2961,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>          if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
>                                        vtd_as->devfn, &ce) &&
>              domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
> -            uint32_t rid2pasid = VTD_CE_GET_RID2PASID(&ce);
> -
> -            if ((vtd_as->pasid != PCI_NO_PASID || pasid != rid2pasid) &&
> +            if ((vtd_as->pasid != PCI_NO_PASID || pasid != PASID_0) &&
>                  vtd_as->pasid != pasid) {
>                  continue;
>              }
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


