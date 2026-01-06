Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CEDC47BC0
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Jan 2026 07:39:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vd1es-0000he-0P; Tue, 06 Jan 2026 02:39:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vd1eg-0000fn-EM
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 02:39:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vd1ec-0003bc-AH
 for qemu-devel@nongnu.org; Tue, 06 Jan 2026 02:39:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767685136;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D+Ix7KkUpTnVrsRDIxffcAq17nkp3J28DHC9Y5uFvS0=;
 b=DlTHLtQWDon/Qz3Fpe1w99DvRIVjwRx+qGTgiMkaVWVjxXRvJ1matIZShHqPuiVhX0ZCKk
 QydRgd3thTsAuqO0mCoIZmyhyBZ/qPD7zUeDrID1Nu7545GYDiuXy74RxsKS6Udiuso+gP
 G+yTAuEppQvFRezufT1nRj/1X9i7/fg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-g1yHQsXGPeO6hrr907nhjw-1; Tue, 06 Jan 2026 02:38:54 -0500
X-MC-Unique: g1yHQsXGPeO6hrr907nhjw-1
X-Mimecast-MFC-AGG-ID: g1yHQsXGPeO6hrr907nhjw_1767685133
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4775e00b16fso4122985e9.2
 for <qemu-devel@nongnu.org>; Mon, 05 Jan 2026 23:38:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767685133; x=1768289933;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D+Ix7KkUpTnVrsRDIxffcAq17nkp3J28DHC9Y5uFvS0=;
 b=umMhKUuez6esz5+vme25+6/p5NnCDrY4i6DQ4r2Lsr/YUjgmsizg+BcYTzEgxfO+MI
 4+W/Fe21wfQutatCNU/ttD0Nm4GlzJI4H+rrz4Qsz4tWFde4v102GU3Kkw9iFrDVR7F1
 ZwIDIg3FPYUMiTg78KQ1LSE8YTtc86vl5oO5yarcHUTSCwtng0zRNVC6010icW9KwAxA
 au4CrVwrqw6/UMPiqk+EkBqZRRtNvlnKxLmk71ez4MJBAYN8S1CEebBm6QqEiEz/Aopm
 jOK8HwMHdzduxgH++98ujvJwjYJZ2WC/evTKpg1QzvNvzErtEv97tSDIn5kj95Jt9lNM
 EJGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2/qHhWN7L04UKwJnD41twiV0RHBv1DMwbCYVdUY/HXB5NwydrvHgf0ivsw8fCVRzPiu3/LVSC9sE4@nongnu.org
X-Gm-Message-State: AOJu0YzuG29JXEsVQQ+PhKpEBfaGELu6u2QTvGhOxn90FiH/M91gXHmq
 2vwoYkC70dRjA++reMG2DYChkSP5+5rAtJBKq6Ru8YhdGffaXsGQEOBpDdHGAjmGhYCKoEaDh8E
 eO1OyWCOWB9TnWBASpnF7ZY0FaKEtKoKR3zICkq6CzhARU+X7cbKIZegE
X-Gm-Gg: AY/fxX4FyjEZp47wgt+4vIXgdmpGgUDjUBieFDEX5mscbMCMVTNWhVLEQUpIJRz9Am0
 HosSzy23+mQqlxC2rkEgJPppp6HzjbFWkG83+lgTnrFxDI5nLc5r5Wpz4cfoLfHiGS5hp/WOcEF
 SXyxEz6MWnhvfe7OIeB9SBcSSVtmBfBshRwvAg5wpQ/uWrAuWq2R37AYv3RztK0rnSe8G/LkkTZ
 U0319Nn5Wr9Z32pERBgm5+OM2WWMlX8WYtyPF/dxcvF2jC2j8QP0QWUIEM1n6tUMXdxciA3xuIy
 JrRo0LPfs7teFbfJOKdvO537Tlf1Rih/34/C0r5ZEXy/BS2XE1d6R6+RIxjn0SI5F5lDdNqM338
 A+yPRhJ3NBS7rCGbS2bQ5w4g2QJJgEfVwusg/DwIbScX3/4gsd8BXxuUbGQ==
X-Received: by 2002:a05:600c:3b27:b0:477:8a29:582c with SMTP id
 5b1f17b1804b1-47d7f0a1804mr22159735e9.34.1767685133090; 
 Mon, 05 Jan 2026 23:38:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGOu+oAuLiLMBNk+N2nRnXRN3+wn6F4GH1y09ys3hsO/RXlFBdvb9Ugz6CaR3ikRl7dXRQShA==
X-Received: by 2002:a05:600c:3b27:b0:477:8a29:582c with SMTP id
 5b1f17b1804b1-47d7f0a1804mr22159465e9.34.1767685132686; 
 Mon, 05 Jan 2026 23:38:52 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f70bc4fsm27299205e9.15.2026.01.05.23.38.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jan 2026 23:38:52 -0800 (PST)
Message-ID: <a5743768-31d0-4b6c-8ab6-ed132b89cf69@redhat.com>
Date: Tue, 6 Jan 2026 08:38:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 12/19] intel_iommu: Add some macros and inline
 functions
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, mst@redhat.com, jasowang@redhat.com,
 peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com
References: <20260106061304.314546-1-zhenzhong.duan@intel.com>
 <20260106061304.314546-13-zhenzhong.duan@intel.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260106061304.314546-13-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 1/6/26 7:12 AM, Zhenzhong Duan wrote:
> Add some macros and inline functions that will be used by following patch.
>
> This patch also make a cleanup to change below macros to use extract64()
> just like what smmu does, because they are either used in following patches
> or used indirectly by new introduced inline functions.
>
>   VTD_INV_DESC_PIOTLB_IH
>   VTD_SM_PASID_ENTRY_PGTT
>   VTD_SM_PASID_ENTRY_DID
>   VTD_SM_PASID_ENTRY_FSPM
>   VTD_SM_PASID_ENTRY_FSPTPTR
>
> But we doesn't aim to change the huge amount of bit mask style macro
> definitions in this patch, that should be in a separate patch.
>
> Suggested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/i386/intel_iommu_internal.h | 50 ++++++++++++++++++++++++++++------
>  hw/i386/intel_iommu.c          | 27 +++++++++---------
>  2 files changed, 55 insertions(+), 22 deletions(-)
>
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index d8dad18304..e987322e93 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -516,7 +516,7 @@ typedef union VTDPRDesc VTDPRDesc;
>  #define VTD_INV_DESC_PIOTLB_DID(val)      (((val) >> 16) & VTD_DOMAIN_ID_MASK)
>  #define VTD_INV_DESC_PIOTLB_PASID(val)    (((val) >> 32) & 0xfffffULL)
>  #define VTD_INV_DESC_PIOTLB_AM(val)       ((val) & 0x3fULL)
> -#define VTD_INV_DESC_PIOTLB_IH(val)       (((val) >> 6) & 0x1)
> +#define VTD_INV_DESC_PIOTLB_IH(x)         extract64((x)->val[1], 6, 1)
>  #define VTD_INV_DESC_PIOTLB_ADDR(val)     ((val) & ~0xfffULL)
>  #define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000f1c0ULL
>  #define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
> @@ -636,17 +636,20 @@ typedef struct VTDPASIDCacheInfo {
>  
>  /* PASID Granular Translation Type Mask */
>  #define VTD_PASID_ENTRY_P              1ULL
> -#define VTD_SM_PASID_ENTRY_PGTT        (7ULL << 6)
> -#define VTD_SM_PASID_ENTRY_FST         (1ULL << 6)
> -#define VTD_SM_PASID_ENTRY_SST         (2ULL << 6)
> -#define VTD_SM_PASID_ENTRY_NESTED      (3ULL << 6)
> -#define VTD_SM_PASID_ENTRY_PT          (4ULL << 6)
> +#define VTD_SM_PASID_ENTRY_PGTT(x)     extract64((x)->val[0], 6, 3)
> +#define VTD_SM_PASID_ENTRY_FST         1
> +#define VTD_SM_PASID_ENTRY_SST         2
> +#define VTD_SM_PASID_ENTRY_NESTED      3
> +#define VTD_SM_PASID_ENTRY_PT          4
>  
>  #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
> -#define VTD_SM_PASID_ENTRY_DID(val)    ((val) & VTD_DOMAIN_ID_MASK)
> +#define VTD_SM_PASID_ENTRY_DID(x)      extract64((x)->val[1], 0, 16)
>  
> -#define VTD_SM_PASID_ENTRY_FSPM          3ULL
> -#define VTD_SM_PASID_ENTRY_FSPTPTR       (~0xfffULL)
> +#define VTD_SM_PASID_ENTRY_SRE(x)      extract64((x)->val[2], 0, 1)
> +#define VTD_SM_PASID_ENTRY_FSPM(x)     extract64((x)->val[2], 2, 2)
> +#define VTD_SM_PASID_ENTRY_WPE(x)      extract64((x)->val[2], 4, 1)
> +#define VTD_SM_PASID_ENTRY_EAFE(x)     extract64((x)->val[2], 7, 1)
> +#define VTD_SM_PASID_ENTRY_FSPTPFN(x)  extract64((x)->val[2], 12, 52)
>  
>  /* First Stage Paging Structure */
>  /* Masks for First Stage Paging Entry */
> @@ -696,4 +699,33 @@ struct vtd_as_key {
>      uint8_t devfn;
>      uint32_t pasid;
>  };
> +
> +static inline dma_addr_t vtd_pe_get_fspt_base(VTDPASIDEntry *pe)
> +{
> +    return VTD_SM_PASID_ENTRY_FSPTPFN(pe) << VTD_PAGE_SHIFT;
> +}
> +
> +/*
> + * First stage IOVA address width: 48 bits for 4-level paging(FSPM=00)
> + *                                 57 bits for 5-level paging(FSPM=01)
> + */
> +static inline uint32_t vtd_pe_get_fs_aw(VTDPASIDEntry *pe)
> +{
> +    /*
> +     * Paging mode for first-stage translation (VTD spec Figure 9-6)
> +     * 00: 4-level paging, 01: 5-level paging
> +     */
> +    return VTD_HOST_AW_48BIT + VTD_SM_PASID_ENTRY_FSPM(pe) * 9;
> +}
> +
> +static inline bool vtd_pe_pgtt_is_pt(VTDPASIDEntry *pe)
> +{
> +    return (VTD_SM_PASID_ENTRY_PGTT(pe) == VTD_SM_PASID_ENTRY_PT);
> +}
> +
> +/* check if PGTT is first stage translation */
> +static inline bool vtd_pe_pgtt_is_fst(VTDPASIDEntry *pe)
> +{
> +    return (VTD_SM_PASID_ENTRY_PGTT(pe) == VTD_SM_PASID_ENTRY_FST);
> +}
>  #endif
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index d5a4e02fa1..9edd625b1a 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -48,10 +48,11 @@
>  #define VTD_CE_GET_PRE(ce) \
>      ((ce)->val[0] & VTD_SM_CONTEXT_ENTRY_PRE)
>  
> -/* pe operations */
> -#define VTD_PE_GET_TYPE(pe) ((pe)->val[0] & VTD_SM_PASID_ENTRY_PGTT)
> -#define VTD_PE_GET_FS_LEVEL(pe) \
> -    (4 + (((pe)->val[2] >> 2) & VTD_SM_PASID_ENTRY_FSPM))
> +/*
> + * Paging mode for first-stage translation (VTD spec Figure 9-6)
> + * 00: 4-level paging, 01: 5-level paging
> + */
> +#define VTD_PE_GET_FS_LEVEL(pe) (VTD_SM_PASID_ENTRY_FSPM(pe) + 4)
>  #define VTD_PE_GET_SS_LEVEL(pe) \
>      (2 + (((pe)->val[0] >> 2) & VTD_SM_PASID_ENTRY_AW))
>  
> @@ -807,7 +808,7 @@ static inline bool vtd_is_fs_level_supported(IntelIOMMUState *s, uint32_t level)
>  /* Return true if check passed, otherwise false */
>  static inline bool vtd_pe_type_check(IntelIOMMUState *s, VTDPASIDEntry *pe)
>  {
> -    switch (VTD_PE_GET_TYPE(pe)) {
> +    switch (VTD_SM_PASID_ENTRY_PGTT(pe)) {
>      case VTD_SM_PASID_ENTRY_FST:
>          return !!(s->ecap & VTD_ECAP_FSTS);
>      case VTD_SM_PASID_ENTRY_SST:
> @@ -882,7 +883,7 @@ static int vtd_get_pe_in_pasid_leaf_table(IntelIOMMUState *s,
>          return -VTD_FR_PASID_TABLE_ENTRY_INV;
>      }
>  
> -    pgtt = VTD_PE_GET_TYPE(pe);
> +    pgtt = VTD_SM_PASID_ENTRY_PGTT(pe);
>      if (pgtt == VTD_SM_PASID_ENTRY_SST &&
>          !vtd_is_ss_level_supported(s, VTD_PE_GET_SS_LEVEL(pe))) {
>              return -VTD_FR_PASID_TABLE_ENTRY_INV;
> @@ -1116,7 +1117,7 @@ static dma_addr_t vtd_get_iova_pgtbl_base(IntelIOMMUState *s,
>      if (s->root_scalable) {
>          vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
>          if (s->fsts) {
> -            return pe.val[2] & VTD_SM_PASID_ENTRY_FSPTPTR;
> +            return vtd_pe_get_fspt_base(&pe);
>          } else {
>              return pe.val[0] & VTD_SM_PASID_ENTRY_SSPTPTR;
>          }
> @@ -1605,7 +1606,7 @@ static uint16_t vtd_get_domain_id(IntelIOMMUState *s,
>  
>      if (s->root_scalable) {
>          vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
> -        return VTD_SM_PASID_ENTRY_DID(pe.val[1]);
> +        return VTD_SM_PASID_ENTRY_DID(&pe);
>      }
>  
>      return VTD_CONTEXT_ENTRY_DID(ce->hi);
> @@ -1687,7 +1688,7 @@ static bool vtd_dev_pt_enabled(IntelIOMMUState *s, VTDContextEntry *ce,
>               */
>              return false;
>          }
> -        return (VTD_PE_GET_TYPE(&pe) == VTD_SM_PASID_ENTRY_PT);
> +        return vtd_pe_pgtt_is_pt(&pe);
>      }
>  
>      return (vtd_ce_get_type(ce) == VTD_CONTEXT_TT_PASS_THROUGH);
> @@ -3108,9 +3109,9 @@ static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
>          /* Fall through */
>      case VTD_INV_DESC_PASIDC_G_DSI:
>          if (pc_entry->valid) {
> -            did = VTD_SM_PASID_ENTRY_DID(pc_entry->pasid_entry.val[1]);
> +            did = VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
>          } else {
> -            did = VTD_SM_PASID_ENTRY_DID(pe.val[1]);
> +            did = VTD_SM_PASID_ENTRY_DID(&pe);
>          }
>          if (pc_info->did != did) {
>              return;
> @@ -5154,8 +5155,8 @@ static int vtd_pri_perform_implicit_invalidation(VTDAddressSpace *vtd_as,
>      if (ret) {
>          return -EINVAL;
>      }
> -    pgtt = VTD_PE_GET_TYPE(&pe);
> -    domain_id = VTD_SM_PASID_ENTRY_DID(pe.val[1]);
> +    pgtt = VTD_SM_PASID_ENTRY_PGTT(&pe);
> +    domain_id = VTD_SM_PASID_ENTRY_DID(&pe);
>      ret = 0;
>      switch (pgtt) {
>      case VTD_SM_PASID_ENTRY_FST:


