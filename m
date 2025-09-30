Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21900CCA468
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 13:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3ak2-0000qj-Op; Tue, 30 Sep 2025 09:50:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3aju-0000pn-Hn
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 09:50:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1v3ajj-0008MK-1z
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 09:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759240180;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sWc8P7DYpSikMfLq60zr971/uUvChGkBGqHzLDZZv2w=;
 b=ZYxnMjyjE/cRNrIaivtwi76pihePFsIKEAUVtzseirPT/c7EmsV/S7fI+PiIEOpp0wa+fW
 22oDlrNTcHULPm3ix5URNWc7iza8S3uFL2gJ6ycjfhOmLqYj8yVYM/UVPx/MlLPDH8uj0u
 fUK8WfdW8jAi9NF8zc1AvcmkKGez+CQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-eLM295YLMCSv9Rv0H5oxaw-1; Tue, 30 Sep 2025 09:49:38 -0400
X-MC-Unique: eLM295YLMCSv9Rv0H5oxaw-1
X-Mimecast-MFC-AGG-ID: eLM295YLMCSv9Rv0H5oxaw_1759240177
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ecdb10a612so5440774f8f.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 06:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759240177; x=1759844977;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sWc8P7DYpSikMfLq60zr971/uUvChGkBGqHzLDZZv2w=;
 b=TjewCSrAqFnnrEVwW1sDWYFgVg30HuW6bjLTBZ7WGH9dKCfgXDX2BiTGFPg49YcxL8
 yWi03rmyzYN8spOWALMmO0mtOQLo32EyBrAb+7kjfcV7NwBx3OqjPVYz9t+s5YreAdqi
 1VjeSxfK/dVhSaqkpMyT6a/RbUgJ0RORotuhk81LBcF0qH13O3wkWEdBm3vKz54EHIBL
 mIlkdOSMoLkxA5ZkcoQ7s1BWGZqJd6OFIUgnCZw9Hu407sPqgHzLIVnoXTNoGkF1MyVD
 OMQ69LyC+Fn6p8DQPwCi/aGumZuHpW937O/MS+8lRracUT1mFhWU4C7dzxDUAL1Q6CCN
 K0fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPnr/pwVMAbvebquwjBxuMqqHEjp76jiV3mIO6h6i/4NEdD+Ihrg75rUdVKExUs13f7duEeqKZVmQP@nongnu.org
X-Gm-Message-State: AOJu0YzU9tAA1k5/szuUgpM0C6gae0JM5HGo3zHIR56MKI2m6K8o142E
 K1Tsp8DRoyi+D437BzxQojDuwm3NfhSToxyYLJtIWPeYmMEci7t+P6ZQDvK7wzTbrSKtNnivXLk
 Q6ewDYEpnGwlPaZDB3EszyZojdUAkjdFyUl1B40Xs2RxCB79/eueaBA07
X-Gm-Gg: ASbGnctmk9kF5aXzXQUs3dLhHt7UF8HwB5314DOfGLQ0W1lm+7ZGs+APS0n8vw7pbrS
 RJc18OBNaQiNtAbd7JyxS1T4XDnbQD9SDJnheMt3F7C4DEJMu0fENKvQr4iLo3mn0eiwNuaIhXy
 xfqljbWn8E78tspE9pgl7eV+Xyl0LhdpyrVZLoMEW7kFmBBRfrA7lpAxXmRg8YC08iGSlV3+nEi
 2FM1Mulr3kTbeSIFX1K5dgl1izM0V82AfXYhHd1eWjS3qX4JH32glPL/M1wr0rlMoVrGcAlppKl
 qjhpohTptgLEFVJC2AcL8a8xkXvcumviFKOc/VFLZX6LdvI7v1dvWZ5GIAxoEVT+p6Rv69/+F6I
 0dhhD81JPyUaVXZmb
X-Received: by 2002:a05:6000:2486:b0:3ed:e1d8:bd73 with SMTP id
 ffacd0b85a97d-40e4d9c9330mr18987572f8f.57.1759240177189; 
 Tue, 30 Sep 2025 06:49:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZi03UOfq7P95x5xyFez15azoVZcySi1JL4yELsU9yrS9dPELBKtIAeWol6UKpbgCkl5m7Zg==
X-Received: by 2002:a05:6000:2486:b0:3ed:e1d8:bd73 with SMTP id
 ffacd0b85a97d-40e4d9c9330mr18987542f8f.57.1759240176698; 
 Tue, 30 Sep 2025 06:49:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e56f53b8asm55995445e9.10.2025.09.30.06.49.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 06:49:36 -0700 (PDT)
Message-ID: <2a12ee15-6314-4c03-ae2b-fb0e0809c924@redhat.com>
Date: Tue, 30 Sep 2025 15:49:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/22] intel_iommu: Delete RPS capability related
 supporting code
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20250918085803.796942-1-zhenzhong.duan@intel.com>
 <20250918085803.796942-3-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250918085803.796942-3-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/18/25 10:57 AM, Zhenzhong Duan wrote:
> RID-PASID Support(RPS) is not set in vIOMMU ECAP register, the supporting
> code is there but never take effect.
takes
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
> This simplify the code and doesn't bring any penalty.
simplifies
>
> Opportunistically, s/rid2pasid/rid_pasid and s/RID2PASID/RID_PASID as
> VTD spec uses RID_PASID terminology.
>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>  hw/i386/intel_iommu_internal.h |  1 -
>  hw/i386/intel_iommu.c          | 49 +++++++++++++---------------------
>  2 files changed, 19 insertions(+), 31 deletions(-)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 360e937989..6abe76556a 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -547,7 +547,6 @@ typedef struct VTDRootEntry VTDRootEntry;
>  #define VTD_CTX_ENTRY_LEGACY_SIZE     16
>  #define VTD_CTX_ENTRY_SCALABLE_SIZE   32
>  
> -#define VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK 0xfffff
>  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
>  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
>  
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 71b70b795d..b976b251bc 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -41,8 +41,7 @@
>  #include "trace.h"
>  
>  /* context entry operations */
> -#define VTD_CE_GET_RID2PASID(ce) \
> -    ((ce)->val[1] & VTD_SM_CONTEXT_ENTRY_RID2PASID_MASK)
> +#define RID_PASID    0
I would call that RID_PASID_0 to make it more explicit in the code
or even it is a PASID to PASID_0 would do the job too.
>  #define VTD_CE_GET_PASID_DIR_TABLE(ce) \
>      ((ce)->val[0] & VTD_PASID_DIR_BASE_ADDR_MASK)
>  
> @@ -951,7 +950,7 @@ static int vtd_ce_get_pasid_entry(IntelIOMMUState *s, VTDContextEntry *ce,
>      int ret = 0;
>  
>      if (pasid == PCI_NO_PASID) {
> -        pasid = VTD_CE_GET_RID2PASID(ce);
> +        pasid = RID_PASID;
>      }
>      pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
>      ret = vtd_get_pe_from_pasid_table(s, pasid_dir_base, pasid, pe);
> @@ -970,7 +969,7 @@ static int vtd_ce_get_pasid_fpd(IntelIOMMUState *s,
>      VTDPASIDEntry pe;
>  
>      if (pasid == PCI_NO_PASID) {
> -        pasid = VTD_CE_GET_RID2PASID(ce);
> +        pasid = RID_PASID;
>      }
>      pasid_dir_base = VTD_CE_GET_PASID_DIR_TABLE(ce);
>  
> @@ -1510,15 +1509,14 @@ static inline int vtd_context_entry_rsvd_bits_check(IntelIOMMUState *s,
>      return 0;
>  }
>  
> -static int vtd_ce_rid2pasid_check(IntelIOMMUState *s,
> +static int vtd_ce_rid_pasid_check(IntelIOMMUState *s,
>                                    VTDContextEntry *ce)
>  {
>      VTDPASIDEntry pe;
>  
>      /*
>       * Make sure in Scalable Mode, a present context entry
> -     * has valid rid2pasid setting, which includes valid
> -     * rid2pasid field and corresponding pasid entry setting
> +     * has valid pasid entry setting at RID_PASID(0).
s/at RID_PASID(0) /for PASID_0?
>       */
>      return vtd_ce_get_pasid_entry(s, ce, &pe, PCI_NO_PASID);
>  }
> @@ -1581,12 +1579,11 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
>          }
>      } else {
>          /*
> -         * Check if the programming of context-entry.rid2pasid
> -         * and corresponding pasid setting is valid, and thus
> -         * avoids to check pasid entry fetching result in future
> -         * helper function calling.
> +         * Check if the programming of pasid setting at RID_PASID(0)
of pasid 0?
> +         * is valid, and thus avoids to check pasid entry fetching
> +         * result in future helper function calling.
>           */
> -        ret_fr = vtd_ce_rid2pasid_check(s, ce);
> +        ret_fr = vtd_ce_rid_pasid_check(s, ce);
>          if (ret_fr) {
>              return ret_fr;
>          }
> @@ -2097,7 +2094,7 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>      bool reads = true;
>      bool writes = true;
>      uint8_t access_flags, pgtt;
> -    bool rid2pasid = (pasid == PCI_NO_PASID) && s->root_scalable;
> +    bool rid_pasid = (pasid == PCI_NO_PASID) && s->root_scalable;
I am not keen of the rid_pasid name. It does not tell what is the
semantic of the variable. rid_pasid is an actual field in the CE.
does that check whether we face a request without pasid in scalable
mode. If so I would call that request_wo_pasid_sm or somethink alike
>      VTDIOTLBEntry *iotlb_entry;
>      uint64_t xlat, size;
>  
> @@ -2111,8 +2108,8 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>  
>      cc_entry = &vtd_as->context_cache_entry;
>  
> -    /* Try to fetch pte from IOTLB, we don't need RID2PASID logic */
> -    if (!rid2pasid) {
> +    /* Try to fetch pte from IOTLB, we don't need RID_PASID(0) logic */
It is unclear what the "RID_PASID(0) logic" is. All the more so we now
just have to set the pasid to PASID_0.
> +    if (!rid_pasid) {
>          iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
>          if (iotlb_entry) {
>              trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->pte,
> @@ -2160,8 +2157,8 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>          cc_entry->context_cache_gen = s->context_cache_gen;
>      }
>  
> -    if (rid2pasid) {
> -        pasid = VTD_CE_GET_RID2PASID(&ce);
> +    if (rid_pasid) {
> +        pasid = RID_PASID;
>      }
>  
>      /*
> @@ -2189,8 +2186,8 @@ static bool vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>          return true;
>      }
>  
> -    /* Try to fetch pte from IOTLB for RID2PASID slow path */
> -    if (rid2pasid) {
> +    /* Try to fetch pte from IOTLB for RID_PASID(0) slow path */
PASID_0?
> +    if (rid_pasid) {
>          iotlb_entry = vtd_lookup_iotlb(s, source_id, pasid, addr);
>          if (iotlb_entry) {
>              trace_vtd_iotlb_page_hit(source_id, addr, iotlb_entry->pte,
> @@ -2464,20 +2461,14 @@ static void vtd_iotlb_page_invalidate_notify(IntelIOMMUState *s,
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
> +             * RID_PASID(0) of this device.
>               */
>              if (!(vtd_as->pasid == pasid ||
> -                  (vtd_as->pasid == PCI_NO_PASID && pasid == rid2pasid))) {
> +                  (vtd_as->pasid == PCI_NO_PASID && pasid == RID_PASID))) {
would strongly suggest using PASID_0 instead
>                  continue;
>              }
>  
> @@ -2976,9 +2967,7 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>          if (!vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus),
>                                        vtd_as->devfn, &ce) &&
>              domain_id == vtd_get_domain_id(s, &ce, vtd_as->pasid)) {
> -            uint32_t rid2pasid = VTD_CE_GET_RID2PASID(&ce);
> -
> -            if ((vtd_as->pasid != PCI_NO_PASID || pasid != rid2pasid) &&
> +            if ((vtd_as->pasid != PCI_NO_PASID || pasid != RID_PASID) &&
>                  vtd_as->pasid != pasid) {
>                  continue;
>              }
Thanks

Eric


