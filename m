Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61C6C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 13:55:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxSDO-00036I-My; Thu, 18 Apr 2024 09:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rxSDM-00035B-QF
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 09:54:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rxSDJ-0004sJ-Ob
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 09:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713448448;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C9zBuTZQxZhMMudp9emt2lfUMSrX8ki93/b2r4LPZik=;
 b=SHbgIUGca2z3nSPxcmAA8CECGicb7Nv6lTZm4A0p8Ng6+v4/GPu32QB1U4mITBAsi61bPC
 Wc8HByKPbS18Xs/0OO40IwbDHhxUHOOQowfVgEwl250fJ/5CD2gP876t4aD+9dMnbbROs7
 1tOZ242dQLakPDGmDoDnBHxWzazzxX4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-3pD8xVp2NvaRlmvKgCA0LQ-1; Thu, 18 Apr 2024 09:54:07 -0400
X-MC-Unique: 3pD8xVp2NvaRlmvKgCA0LQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6993c176044so38852286d6.0
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 06:54:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713448446; x=1714053246;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C9zBuTZQxZhMMudp9emt2lfUMSrX8ki93/b2r4LPZik=;
 b=f3YVHzSHEQpWRw6dPxLo5egP6wtNlwN+gTIefM7XIwzjZ/fDEUzddXmDKRgJYD+fFu
 mDKE7ylExIgh3O9R5mxvEKaDt8RlhPqyAve69+73vDSfUJ48bcCALrhX2CsVEojQZ9MM
 AZr29WcrEb8M/fFnTRVN1ghbOQ0Ll6ZqA/dupZ9Xx21vfGJuK3z/kTwS0YUlWfwl4Ode
 nxBdG+9v4uVAUFxEdgWLnp/tF2GwkUkJoSGpBuiFs1AJvTZT32pCdQKbQaKjBV5rI6LU
 n6eweXSxneCbZ4cxtjXzf/ZLNukv4Pi4Y/4FUsg1q22JtPzCqyX0uMHU8uXjvNF+U8yr
 u6rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcCCSEinSV5urIP3t5mmwLJJzfcoiZDzUwzEBknamRzSIJW0z3LyzKiXMYuh+WJskx4/3ZsU/5rnryabakrkhauZv1Tv4=
X-Gm-Message-State: AOJu0Yy+SPmVJtFphP6bMptR4zhVbSiFgIEaOsW+u0AyQq6vL/TSuImw
 hYHya5cYvik2fgDz8/c8UPFP+Euz1ThDhDRrXmZJ+LK6s6sjKlayamNP0S0GyShzXUb0MrksnTV
 e7N2Pr3KNk/SpKOTx0dF3EebRcp4UIUEjalgASt25A5+n+ib6yvcq
X-Received: by 2002:a0c:f9ca:0:b0:69e:9a89:21a7 with SMTP id
 j10-20020a0cf9ca000000b0069e9a8921a7mr3674747qvo.29.1713448446332; 
 Thu, 18 Apr 2024 06:54:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk/aDefW8/AZ4fuZmj6gpC7Yxj7ZEsynhFTjLs2Df1p1vBZxXm3/Vc/wy3OfyRBkudokjZbQ==
X-Received: by 2002:a0c:f9ca:0:b0:69e:9a89:21a7 with SMTP id
 j10-20020a0cf9ca000000b0069e9a8921a7mr3674718qvo.29.1713448445945; 
 Thu, 18 Apr 2024 06:54:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 x9-20020a0ce0c9000000b0069b192e63bfsm657451qvk.91.2024.04.18.06.54.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 06:54:05 -0700 (PDT)
Message-ID: <7a5ac306-0733-4818-8215-33d3d61f18c6@redhat.com>
Date: Thu, 18 Apr 2024 15:54:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 05/13] hw/arm/smmu-common: Support nested
 translation
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240408140818.3799590-1-smostafa@google.com>
 <20240408140818.3799590-6-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240408140818.3799590-6-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Mostafa,

On 4/8/24 16:08, Mostafa Saleh wrote:
> When nested translation is requested, do the following:
>
> - Translate stage-1 IPA using stage-2 to a physical address.
> - Translate stage-1 PTW walks using stage-2.
> - Combine both to create a single TLB entry, for that we choose
>   the smallest entry to cache, which means that if the smallest
>   entry comes from stage-2, and stage-2 use different granule,
>   TLB lookup for stage-1 (in nested config) will always miss.
>   Lookup logic is modified for nesting to lookup using stage-2
>   granule if stage-1 granule missed and they are different.
>
> Also, add more visibility in trace points, to make it easier to debug.
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  hw/arm/smmu-common.c         | 153 ++++++++++++++++++++++++++++-------
>  hw/arm/trace-events          |   6 +-
>  include/hw/arm/smmu-common.h |   3 +-
>  3 files changed, 131 insertions(+), 31 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 771b9c79a3..2cf27b490b 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -66,8 +66,10 @@ SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
>      return key;
>  }
>  
> -SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> -                                SMMUTransTableInfo *tt, hwaddr iova)
> +static SMMUTLBEntry *smmu_iotlb_lookup_all_levels(SMMUState *bs,
> +                                                  SMMUTransCfg *cfg,
> +                                                  SMMUTransTableInfo *tt,
> +                                                  hwaddr iova)
this helper can be introduced in a separate patch to ease the code review
>  {
>      uint8_t tg = (tt->granule_sz - 10) / 2;
>      uint8_t inputsize = 64 - tt->tsz;
> @@ -88,10 +90,29 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
>          }
>          level++;
>      }
> +    return entry;
> +}
> +
> +SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> +                                SMMUTransTableInfo *tt, hwaddr iova)
> +{
> +    SMMUTLBEntry *entry = NULL;
> +
> +    entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova);
> +    /*
> +     * For nested translation also use the s2 granule, as the TLB will insert
> +     * the smallest of both, so the entry can be cached with the s2 granule.
> +     */
> +    if (!entry && (cfg->stage == SMMU_NESTED) &&
> +        (cfg->s2cfg.granule_sz != tt->granule_sz)) {
> +        tt->granule_sz = cfg->s2cfg.granule_sz;
> +        entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova);
this is also the kind of stuff that can be introduced and reviewed
separately without tkaing any risk until NESTED is not support. In this
new patch you could also document the TLB strategy.
> +    }
>  
>      if (entry) {
>          cfg->iotlb_hits++;
>          trace_smmu_iotlb_lookup_hit(cfg->asid, cfg->s2cfg.vmid, iova,
> +                                    entry->entry.addr_mask,
can be moved to a separate fix. same for the trace point changes
>                                      cfg->iotlb_hits, cfg->iotlb_misses,
>                                      100 * cfg->iotlb_hits /
>                                      (cfg->iotlb_hits + cfg->iotlb_misses));
> @@ -117,7 +138,7 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new)
>      *key = smmu_get_iotlb_key(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
>                                tg, new->level);
>      trace_smmu_iotlb_insert(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
> -                            tg, new->level);
> +                            tg, new->level, new->entry.translated_addr);
>      g_hash_table_insert(bs->iotlb, key, new);
>  }
>  
> @@ -286,6 +307,27 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
>      return NULL;
>  }
>  
> +/* Return the correct table address based on configuration. */
does the S2 translation for a PTE table?
> +static inline int translate_table_s1(dma_addr_t *table_addr, SMMUTransCfg *cfg,
> +                                     SMMUPTWEventInfo *info, SMMUState *bs)
> +{
> +    dma_addr_t addr = *table_addr;
> +    SMMUTLBEntry *cached_entry;
> +
> +    if (cfg->stage != SMMU_NESTED) {
> +        return 0;
> +    }
> +
> +    CALL_FUNC_CFG_S2(cfg, cached_entry, smmu_translate,
> +                     bs, cfg, addr, IOMMU_RO, info);
> +
> +    if (cached_entry) {
> +        *table_addr = CACHED_ENTRY_TO_ADDR(cached_entry, addr);
> +        return 0;
> +    }
> +    return -EINVAL;
> +}
> +
>  /**
>   * smmu_ptw_64_s1 - VMSAv8-64 Walk of the page tables for a given IOVA
>   * @cfg: translation config
> @@ -301,7 +343,8 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
>   */
>  static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
>                            dma_addr_t iova, IOMMUAccessFlags perm,
> -                          SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
> +                          SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info,
> +                          SMMUState *bs)
>  {
>      dma_addr_t baseaddr, indexmask;
>      SMMUStage stage = cfg->stage;
> @@ -349,6 +392,10 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
>                  goto error;
>              }
>              baseaddr = get_table_pte_address(pte, granule_sz);
> +            /* In case of failure, retain stage-2 fault. */
link to the doc?
> +            if (translate_table_s1(&baseaddr, cfg, info, bs)) {
let's avoid that call if S1 only

What about the error handling. I am not sure we are covering all the
cases listed in 7.3.12 F_WALK_EABT for instance?
> +                goto error_no_stage;
> +            }
>              level++;
>              continue;
>          } else if (is_page_pte(pte, level)) {
> @@ -384,7 +431,7 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
>          tlbe->entry.translated_addr = gpa;
>          tlbe->entry.iova = iova & ~mask;
>          tlbe->entry.addr_mask = mask;
> -        tlbe->entry.perm = PTE_AP_TO_PERM(ap);
> +        tlbe->parent_perm = tlbe->entry.perm = PTE_AP_TO_PERM(ap);
>          tlbe->level = level;
>          tlbe->granule = granule_sz;
>          return 0;
> @@ -393,6 +440,7 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
>  
>  error:
>      info->stage = SMMU_STAGE_1;
> +error_no_stage:
>      tlbe->entry.perm = IOMMU_NONE;
>      return -EINVAL;
>  }
> @@ -505,7 +553,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
>          tlbe->entry.translated_addr = gpa;
>          tlbe->entry.iova = ipa & ~mask;
>          tlbe->entry.addr_mask = mask;
> -        tlbe->entry.perm = s2ap;
> +        tlbe->parent_perm = tlbe->entry.perm = s2ap;
>          tlbe->level = level;
>          tlbe->granule = granule_sz;
>          return 0;
> @@ -518,6 +566,28 @@ error:
>      return -EINVAL;
>  }
>  
> +/* Combine 2 TLB enteries and return in tlbe. */
entries.
Would suggest combine
> +static void combine_tlb(SMMUTLBEntry *tlbe, SMMUTLBEntry *tlbe_s2,
> +                        dma_addr_t iova, SMMUTransCfg *cfg)
> +{
> +        if (cfg->stage == SMMU_NESTED) {
> +            tlbe->entry.addr_mask = MIN(tlbe->entry.addr_mask,
> +                                        tlbe_s2->entry.addr_mask);
> +            tlbe->entry.translated_addr = CACHED_ENTRY_TO_ADDR(tlbe_s2,
> +                                          tlbe->entry.translated_addr);
> +
> +            tlbe->granule = MIN(tlbe->granule, tlbe_s2->granule);
could you add a link to the spec so we can clearly check what this code
is written against?
> +            tlbe->level = MAX(tlbe->level, tlbe_s2->level);
> +            tlbe->entry.iova = iova & ~tlbe->entry.addr_mask;
> +            /* parent_perm has s2 perm while perm has s1 perm. */
> +            tlbe->parent_perm = tlbe_s2->entry.perm;
> +            return;
> +        }
> +
> +        /* That was not nested, use the s2. */
should be removed and tested ;-)
> +        memcpy(tlbe, tlbe_s2, sizeof(*tlbe));
You shall avoid doing that memcpy if not necessary. I would advocate for
separate paths for S2 and nested.
> +}
> +
>  /**
>   * smmu_ptw - Walk the page tables for an IOVA, according to @cfg
need to update the above args desc
>   *
> @@ -530,28 +600,59 @@ error:
>   * return 0 on success
>   */
>  int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
> -             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
> +             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info, SMMUState *bs)
>  {
> -    if (cfg->stage == SMMU_STAGE_1) {
> -        return smmu_ptw_64_s1(cfg, iova, perm, tlbe, info);
> -    } else if (cfg->stage == SMMU_STAGE_2) {
> -        /*
> -         * If bypassing stage 1(or unimplemented), the input address is passed
> -         * directly to stage 2 as IPA. If the input address of a transaction
> -         * exceeds the size of the IAS, a stage 1 Address Size fault occurs.
> -         * For AA64, IAS = OAS according to (IHI 0070.E.a) "3.4 Address sizes"
> -         */
> -        if (iova >= (1ULL << cfg->oas)) {
> -            info->type = SMMU_PTW_ERR_ADDR_SIZE;
> -            info->stage = SMMU_STAGE_1;
> -            tlbe->entry.perm = IOMMU_NONE;
> -            return -EINVAL;
> +    int ret = 0;
> +    SMMUTLBEntry tlbe_s2;
> +    dma_addr_t ipa = iova;
> +
> +    if (cfg->stage & SMMU_STAGE_1) {
> +        ret = smmu_ptw_64_s1(cfg, iova, perm, tlbe, info, bs);
> +        if (ret) {
> +            return ret;
>          }
> +        /* This is the IPA for next stage.*/
but you don't necessarily have the S2 enabled so this is not necessarily
an IPA
> +        ipa = CACHED_ENTRY_TO_ADDR(tlbe, iova);
> +    }
>  
> -        return smmu_ptw_64_s2(cfg, iova, perm, tlbe, info);
> +    /*
> +     * The address output from the translation causes a stage 1 Address Size
> +     * fault if it exceeds the range of the effective IPA size for the given CD.
> +     * If bypassing stage 1(or unimplemented), the input address is passed
> +     * directly to stage 2 as IPA. If the input address of a transaction
> +     * exceeds the size of the IAS, a stage 1 Address Size fault occurs.
> +     * For AA64, IAS = OAS according to (IHI 0070.E.a) "3.4 Address sizes"
> +     */
> +    if (ipa >= (1ULL << cfg->oas)) {
in case we have S2 only, would be clearer to use ias instead (despite
above comment say they are the same)
> +        info->type = SMMU_PTW_ERR_ADDR_SIZE;
> +        info->stage = SMMU_STAGE_1;
What does the stage really means. That should be documented in the
struct I think
> +        tlbe->entry.perm = IOMMU_NONE;
> +        return -EINVAL;
>      }
this check also is introduced for S1 only. If this is a fix this should
be brought separately.
Also the above comment refers to IPA. Does it also hold for S1 only. Is
the check identical in that case?
>  
> -    g_assert_not_reached();
> +    if (cfg->stage & SMMU_STAGE_2) {
> +        ret = smmu_ptw_64_s2(cfg, ipa, perm, &tlbe_s2, info);
> +        if (ret) {
> +            return ret;
> +        }
> +        combine_tlb(tlbe, &tlbe_s2, iova, cfg);
> +    }
I think I would prefer the S1, S2, nested cases cleary separated at the
price of some code duplication. I am afraid serializing stuff make the
code less maintainable.
Also it is important the S1 case is not altered in terms of perf.
> +
> +    return ret;
> +}
> +
> +static int validate_tlb_entry(SMMUTLBEntry *cached_entry, IOMMUAccessFlags flag,
> +                              SMMUPTWEventInfo *info)
> +{
> +        if ((flag & IOMMU_WO) && !(cached_entry->entry.perm &
> +            cached_entry->parent_perm & IOMMU_WO)) {
> +            info->type = SMMU_PTW_ERR_PERMISSION;
> +            info->stage = !(cached_entry->entry.perm & IOMMU_WO) ?
> +                          SMMU_STAGE_1 :
> +                          SMMU_STAGE_2;
> +            return -EINVAL;
> +        }
> +        return 0;
>  }
>  
>  SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
> @@ -595,16 +696,14 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
>  
>      cached_entry = smmu_iotlb_lookup(bs, cfg, &tt_combined, aligned_addr);
>      if (cached_entry) {
> -        if ((flag & IOMMU_WO) && !(cached_entry->entry.perm & IOMMU_WO)) {
> -            info->type = SMMU_PTW_ERR_PERMISSION;
> -            info->stage = cfg->stage;
> +        if (validate_tlb_entry(cached_entry, flag, info)) {
>              return NULL;
>          }
>          return cached_entry;
>      }
>  
>      cached_entry = g_new0(SMMUTLBEntry, 1);
> -    status = smmu_ptw(cfg, aligned_addr, flag, cached_entry, info);
> +    status = smmu_ptw(cfg, aligned_addr, flag, cached_entry, info, bs);
>      if (status) {
>              g_free(cached_entry);
>              return NULL;
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index cc12924a84..5f23f0b963 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -15,9 +15,9 @@ smmu_iotlb_inv_asid(uint16_t asid) "IOTLB invalidate asid=%d"
>  smmu_iotlb_inv_vmid(uint16_t vmid) "IOTLB invalidate vmid=%d"
>  smmu_iotlb_inv_iova(uint16_t asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
>  smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
> -smmu_iotlb_lookup_hit(uint16_t asid, uint16_t vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
> -smmu_iotlb_lookup_miss(uint16_t asid, uint16_t vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
> -smmu_iotlb_insert(uint16_t asid, uint16_t vmid, uint64_t addr, uint8_t tg, uint8_t level) "IOTLB ++ asid=%d vmid=%d addr=0x%"PRIx64" tg=%d level=%d"
> +smmu_iotlb_lookup_hit(int asid, uint16_t vmid, uint64_t addr, uint64_t mask, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d vmid=%d addr=0x%"PRIx64" mask=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
> +smmu_iotlb_lookup_miss(int asid, uint16_t vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
> +smmu_iotlb_insert(int asid, uint16_t vmid, uint64_t addr, uint8_t tg, uint8_t level, uint64_t translate_addr) "IOTLB ++ asid=%d vmid=%d addr=0x%"PRIx64" tg=%d level=%d translate_addr=0x%"PRIx64
>  
>  # smmuv3.c
>  smmuv3_read_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 2772175115..03ff0f02ba 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -91,6 +91,7 @@ typedef struct SMMUTLBEntry {
>      IOMMUTLBEntry entry;
>      uint8_t level;
>      uint8_t granule;
> +    IOMMUAccessFlags parent_perm;
>  } SMMUTLBEntry;
>  
>  /* Stage-2 configuration. */
> @@ -198,7 +199,7 @@ static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
>   * pair, according to @cfg translation config
>   */
>  int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
> -             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info);
> +             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info, SMMUState *bs);
>  
>  
>  /*
To be honest this patch is quite complex to review. I would suggest you
try to split it.

Thanks

Eric


