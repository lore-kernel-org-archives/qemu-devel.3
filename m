Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58ADFC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 10:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxlt9-0007DM-1a; Fri, 19 Apr 2024 06:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1rxlt5-0007Cn-F3
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 06:54:36 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1rxlt2-0006cO-9u
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 06:54:34 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-418820e6effso49225e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 03:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1713524070; x=1714128870; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CRxWRc2unHvIKryZOD5Ybsv4SCTGl8Ez5fQsZj3bQpc=;
 b=S4e32zJ8RG0uGIx63hdxYL20UtHhCazxnr9Mh790ATi5VV5CTgD/RwnFsHPgShVi+F
 ypWm0T4reha4b6sDUA1qXlRuL+agu84fe3Ye/9Ok3JYDZlm/LMLk4+tuw+xr6r5u+nH+
 aS79rYu/ijZ0XpE3qgHRWEtiVwPs/6FIhNwfw73Tf5gFErIiMM7lfopOzzNp0H3HkLlf
 vJd05J+lM3XBJuAEkdEVM6RgalLMzWKpo0dZl0kv8ohy30avovgaeJFJ4k5xm6Qz9TDP
 CrO4ESHU2p6SZd/j55hVmm37FciRsLqgQTd+Xh+L2PfS9kwDFcb5wA4DqWx9aoBd/VOy
 lk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713524070; x=1714128870;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CRxWRc2unHvIKryZOD5Ybsv4SCTGl8Ez5fQsZj3bQpc=;
 b=HCsN/sBhnrkdneIbxsRDwh0gTtsZp0C9LPLY+CHZ4ek4/ka1ZIy2Prtf9qo/Kxyggv
 xqjviIrVTsncMV5mh+K+yUahVaxfIYbPaIA/5v6eWps0CETBCrLj1oBhrLmJ59rBkN9u
 /vm0ufLmrqqtqEEe8G4R+7zxMGiYyyhhmT1S1OZJU5HdO5bVSQ1D/3iXJUB8ulJbi7p+
 SX+Ush0x5aiA8GdHMAEQULNrxyMzm0KCjgR2M+MYZlXYun6h9fUujp6VCMlYAaXNhPfs
 /Unue9Vkqe7hzUZ+kM5tAy+O3rruN9RvRJLGuw7BfYIzEJcx/b3sgZQXzcQ5P3INnJlJ
 g7Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQGs3gqaTrDGo0Urle4hwj8WWWiegUZvCXC7FRM23siYW9ByHfgGXIpEbuNlhETjDTFCwUjxlOnV8LRCviT7EEJipFOeU=
X-Gm-Message-State: AOJu0YzEc5cyfRzWX/2WiENVQR/eMPiV+qMAfWQddLIzypnoim3qqim2
 d9g2j9GkVZyUIDPqTHDAwpHgH3ItQYYQlNXjKUFkHgTH9swO49MSYnbjygheHg==
X-Google-Smtp-Source: AGHT+IFe96+O6oDkD2JwB1o3Dg+NLPDGYL8YE8ZuKyA4MBT9trke1KeRe08sSdBUtrmPiN/daHr/WA==
X-Received: by 2002:a05:600c:1d14:b0:416:bc07:a3c9 with SMTP id
 l20-20020a05600c1d1400b00416bc07a3c9mr170003wms.6.1713524070302; 
 Fri, 19 Apr 2024 03:54:30 -0700 (PDT)
Received: from google.com (180.232.140.34.bc.googleusercontent.com.
 [34.140.232.180]) by smtp.gmail.com with ESMTPSA id
 n12-20020a5d67cc000000b0034a51283404sm1597857wrw.72.2024.04.19.03.54.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 03:54:29 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:54:25 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [RFC PATCH v2 05/13] hw/arm/smmu-common: Support nested
 translation
Message-ID: <ZiJNYa5rC8V3H7gc@google.com>
References: <20240408140818.3799590-1-smostafa@google.com>
 <20240408140818.3799590-6-smostafa@google.com>
 <7a5ac306-0733-4818-8215-33d3d61f18c6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7a5ac306-0733-4818-8215-33d3d61f18c6@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=smostafa@google.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Eric,

On Thu, Apr 18, 2024 at 03:54:01PM +0200, Eric Auger wrote:
> Hi Mostafa,
> 
> On 4/8/24 16:08, Mostafa Saleh wrote:
> > When nested translation is requested, do the following:
> >
> > - Translate stage-1 IPA using stage-2 to a physical address.
> > - Translate stage-1 PTW walks using stage-2.
> > - Combine both to create a single TLB entry, for that we choose
> >   the smallest entry to cache, which means that if the smallest
> >   entry comes from stage-2, and stage-2 use different granule,
> >   TLB lookup for stage-1 (in nested config) will always miss.
> >   Lookup logic is modified for nesting to lookup using stage-2
> >   granule if stage-1 granule missed and they are different.
> >
> > Also, add more visibility in trace points, to make it easier to debug.
> >
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  hw/arm/smmu-common.c         | 153 ++++++++++++++++++++++++++++-------
> >  hw/arm/trace-events          |   6 +-
> >  include/hw/arm/smmu-common.h |   3 +-
> >  3 files changed, 131 insertions(+), 31 deletions(-)
> >
> > diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> > index 771b9c79a3..2cf27b490b 100644
> > --- a/hw/arm/smmu-common.c
> > +++ b/hw/arm/smmu-common.c
> > @@ -66,8 +66,10 @@ SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
> >      return key;
> >  }
> >  
> > -SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> > -                                SMMUTransTableInfo *tt, hwaddr iova)
> > +static SMMUTLBEntry *smmu_iotlb_lookup_all_levels(SMMUState *bs,
> > +                                                  SMMUTransCfg *cfg,
> > +                                                  SMMUTransTableInfo *tt,
> > +                                                  hwaddr iova)
> this helper can be introduced in a separate patch to ease the code review

Will do.

> >  {
> >      uint8_t tg = (tt->granule_sz - 10) / 2;
> >      uint8_t inputsize = 64 - tt->tsz;
> > @@ -88,10 +90,29 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> >          }
> >          level++;
> >      }
> > +    return entry;
> > +}
> > +
> > +SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> > +                                SMMUTransTableInfo *tt, hwaddr iova)
> > +{
> > +    SMMUTLBEntry *entry = NULL;
> > +
> > +    entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova);
> > +    /*
> > +     * For nested translation also use the s2 granule, as the TLB will insert
> > +     * the smallest of both, so the entry can be cached with the s2 granule.
> > +     */
> > +    if (!entry && (cfg->stage == SMMU_NESTED) &&
> > +        (cfg->s2cfg.granule_sz != tt->granule_sz)) {
> > +        tt->granule_sz = cfg->s2cfg.granule_sz;
> > +        entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova);
> this is also the kind of stuff that can be introduced and reviewed
> separately without tkaing any risk until NESTED is not support. In this
> new patch you could also document the TLB strategy.

Will do.

> > +    }
> >  
> >      if (entry) {
> >          cfg->iotlb_hits++;
> >          trace_smmu_iotlb_lookup_hit(cfg->asid, cfg->s2cfg.vmid, iova,
> > +                                    entry->entry.addr_mask,
> can be moved to a separate fix. same for the trace point changes

Will do.

> >                                      cfg->iotlb_hits, cfg->iotlb_misses,
> >                                      100 * cfg->iotlb_hits /
> >                                      (cfg->iotlb_hits + cfg->iotlb_misses));
> > @@ -117,7 +138,7 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *new)
> >      *key = smmu_get_iotlb_key(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
> >                                tg, new->level);
> >      trace_smmu_iotlb_insert(cfg->asid, cfg->s2cfg.vmid, new->entry.iova,
> > -                            tg, new->level);
> > +                            tg, new->level, new->entry.translated_addr);
> >      g_hash_table_insert(bs->iotlb, key, new);
> >  }
> >  
> > @@ -286,6 +307,27 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
> >      return NULL;
> >  }
> >  
> > +/* Return the correct table address based on configuration. */
> does the S2 translation for a PTE table?

The intention was to abstract that, and it just return the table address
with or with translation, but I can move the check outside and this
always translates.

> > +static inline int translate_table_s1(dma_addr_t *table_addr, SMMUTransCfg *cfg,
> > +                                     SMMUPTWEventInfo *info, SMMUState *bs)
> > +{
> > +    dma_addr_t addr = *table_addr;
> > +    SMMUTLBEntry *cached_entry;
> > +
> > +    if (cfg->stage != SMMU_NESTED) {
> > +        return 0;
> > +    }
> > +
> > +    CALL_FUNC_CFG_S2(cfg, cached_entry, smmu_translate,
> > +                     bs, cfg, addr, IOMMU_RO, info);
> > +
> > +    if (cached_entry) {
> > +        *table_addr = CACHED_ENTRY_TO_ADDR(cached_entry, addr);
> > +        return 0;
> > +    }
> > +    return -EINVAL;
> > +}
> > +
> >  /**
> >   * smmu_ptw_64_s1 - VMSAv8-64 Walk of the page tables for a given IOVA
> >   * @cfg: translation config
> > @@ -301,7 +343,8 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
> >   */
> >  static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
> >                            dma_addr_t iova, IOMMUAccessFlags perm,
> > -                          SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
> > +                          SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info,
> > +                          SMMUState *bs)
> >  {
> >      dma_addr_t baseaddr, indexmask;
> >      SMMUStage stage = cfg->stage;
> > @@ -349,6 +392,10 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
> >                  goto error;
> >              }
> >              baseaddr = get_table_pte_address(pte, granule_sz);
> > +            /* In case of failure, retain stage-2 fault. */
> link to the doc?

Will do.

> > +            if (translate_table_s1(&baseaddr, cfg, info, bs)) {
> let's avoid that call if S1 only

Will do.

> 
> What about the error handling. I am not sure we are covering all the
> cases listed in 7.3.12 F_WALK_EABT for instance?

Yes, I think that can be used for some of the S2 fetch errors, it seems
also overlap with other events, for example:
F_WALK_EABT:
     Translation of an IPA after successful stage 1 translation (or, in stage 2-only
     configuration, an input IPA)

F_TRANSLATION
    If translating an IPA for a transaction (whether by input to stage 2-only
    configuration, or after successful stage 1 translation), CLASS == IN, and IPA is
    provided.


I will have a deeper look and rework any missing events or add comments.

> > +                goto error_no_stage;
> > +            }
> >              level++;
> >              continue;
> >          } else if (is_page_pte(pte, level)) {
> > @@ -384,7 +431,7 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
> >          tlbe->entry.translated_addr = gpa;
> >          tlbe->entry.iova = iova & ~mask;
> >          tlbe->entry.addr_mask = mask;
> > -        tlbe->entry.perm = PTE_AP_TO_PERM(ap);
> > +        tlbe->parent_perm = tlbe->entry.perm = PTE_AP_TO_PERM(ap);
> >          tlbe->level = level;
> >          tlbe->granule = granule_sz;
> >          return 0;
> > @@ -393,6 +440,7 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
> >  
> >  error:
> >      info->stage = SMMU_STAGE_1;
> > +error_no_stage:
> >      tlbe->entry.perm = IOMMU_NONE;
> >      return -EINVAL;
> >  }
> > @@ -505,7 +553,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
> >          tlbe->entry.translated_addr = gpa;
> >          tlbe->entry.iova = ipa & ~mask;
> >          tlbe->entry.addr_mask = mask;
> > -        tlbe->entry.perm = s2ap;
> > +        tlbe->parent_perm = tlbe->entry.perm = s2ap;
> >          tlbe->level = level;
> >          tlbe->granule = granule_sz;
> >          return 0;
> > @@ -518,6 +566,28 @@ error:
> >      return -EINVAL;
> >  }
> >  
> > +/* Combine 2 TLB enteries and return in tlbe. */
> entries.
> Would suggest combine

Will do.

> > +static void combine_tlb(SMMUTLBEntry *tlbe, SMMUTLBEntry *tlbe_s2,
> > +                        dma_addr_t iova, SMMUTransCfg *cfg)
> > +{
> > +        if (cfg->stage == SMMU_NESTED) {
> > +            tlbe->entry.addr_mask = MIN(tlbe->entry.addr_mask,
> > +                                        tlbe_s2->entry.addr_mask);
> > +            tlbe->entry.translated_addr = CACHED_ENTRY_TO_ADDR(tlbe_s2,
> > +                                          tlbe->entry.translated_addr);
> > +
> > +            tlbe->granule = MIN(tlbe->granule, tlbe_s2->granule);
> could you add a link to the spec so we can clearly check what this code
> is written against?

The spec doesn’t define the microarchitecture of the TLBs, it is an
implementation choice as long as it satisfies the TLB requirements
(mentioned in the cover letter)
- ARM ARM DDI 0487J.a: RLGSCG, RTVTYQ, RGNJPZ
- ARM IHI 0070F.b: 16.2 Caching

I will better document the TLB architecture.

> > +            tlbe->level = MAX(tlbe->level, tlbe_s2->level);
> > +            tlbe->entry.iova = iova & ~tlbe->entry.addr_mask;
> > +            /* parent_perm has s2 perm while perm has s1 perm. */
> > +            tlbe->parent_perm = tlbe_s2->entry.perm;
> > +            return;
> > +        }
> > +
> > +        /* That was not nested, use the s2. */
> should be removed and tested ;-)

Ah, who needs testing :)

> > +        memcpy(tlbe, tlbe_s2, sizeof(*tlbe));
> You shall avoid doing that memcpy if not necessary. I would advocate for
> separate paths for S2 and nested.

Will do.

> > +}
> > +
> >  /**
> >   * smmu_ptw - Walk the page tables for an IOVA, according to @cfg
> need to update the above args desc

Will do.

> >   *
> > @@ -530,28 +600,59 @@ error:
> >   * return 0 on success
> >   */
> >  int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
> > -             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
> > +             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info, SMMUState *bs)
> >  {
> > -    if (cfg->stage == SMMU_STAGE_1) {
> > -        return smmu_ptw_64_s1(cfg, iova, perm, tlbe, info);
> > -    } else if (cfg->stage == SMMU_STAGE_2) {
> > -        /*
> > -         * If bypassing stage 1(or unimplemented), the input address is passed
> > -         * directly to stage 2 as IPA. If the input address of a transaction
> > -         * exceeds the size of the IAS, a stage 1 Address Size fault occurs.
> > -         * For AA64, IAS = OAS according to (IHI 0070.E.a) "3.4 Address sizes"
> > -         */
> > -        if (iova >= (1ULL << cfg->oas)) {
> > -            info->type = SMMU_PTW_ERR_ADDR_SIZE;
> > -            info->stage = SMMU_STAGE_1;
> > -            tlbe->entry.perm = IOMMU_NONE;
> > -            return -EINVAL;
> > +    int ret = 0;
> > +    SMMUTLBEntry tlbe_s2;
> > +    dma_addr_t ipa = iova;
> > +
> > +    if (cfg->stage & SMMU_STAGE_1) {
> > +        ret = smmu_ptw_64_s1(cfg, iova, perm, tlbe, info, bs);
> > +        if (ret) {
> > +            return ret;
> >          }
> > +        /* This is the IPA for next stage.*/
> but you don't necessarily have the S2 enabled so this is not necessarily
> an IPA

I will update the comment.

> > +        ipa = CACHED_ENTRY_TO_ADDR(tlbe, iova);
> > +    }
> >  
> > -        return smmu_ptw_64_s2(cfg, iova, perm, tlbe, info);
> > +    /*
> > +     * The address output from the translation causes a stage 1 Address Size
> > +     * fault if it exceeds the range of the effective IPA size for the given CD.
> > +     * If bypassing stage 1(or unimplemented), the input address is passed
> > +     * directly to stage 2 as IPA. If the input address of a transaction
> > +     * exceeds the size of the IAS, a stage 1 Address Size fault occurs.
> > +     * For AA64, IAS = OAS according to (IHI 0070.E.a) "3.4 Address sizes"
> > +     */
> > +    if (ipa >= (1ULL << cfg->oas)) {
> in case we have S2 only, would be clearer to use ias instead (despite
> above comment say they are the same)

It was written this as it can be used in both cases where IAS is
limited by the CD, I will double check.

> > +        info->type = SMMU_PTW_ERR_ADDR_SIZE;
> > +        info->stage = SMMU_STAGE_1;
> What does the stage really means. That should be documented in the
> struct I think

This should update the s2 field in translation events (event->u.*.s2),
I will add a comment.


> > +        tlbe->entry.perm = IOMMU_NONE;
> > +        return -EINVAL;
> >      }
> this check also is introduced for S1 only. If this is a fix this should
> be brought separately.
> Also the above comment refers to IPA. Does it also hold for S1 only. Is
> the check identical in that case?

I believe that is a fix, I will double check and add it in a separate patch.

> >  
> > -    g_assert_not_reached();
> > +    if (cfg->stage & SMMU_STAGE_2) {
> > +        ret = smmu_ptw_64_s2(cfg, ipa, perm, &tlbe_s2, info);
> > +        if (ret) {
> > +            return ret;
> > +        }
> > +        combine_tlb(tlbe, &tlbe_s2, iova, cfg);
> > +    }
> I think I would prefer the S1, S2, nested cases cleary separated at the
> price of some code duplication. I am afraid serializing stuff make the
> code less maintainable.
> Also it is important the S1 case is not altered in terms of perf.

I see, I will have that in mind when splitting the patches.

> > +
> > +    return ret;
> > +}
> > +
> > +static int validate_tlb_entry(SMMUTLBEntry *cached_entry, IOMMUAccessFlags flag,
> > +                              SMMUPTWEventInfo *info)
> > +{
> > +        if ((flag & IOMMU_WO) && !(cached_entry->entry.perm &
> > +            cached_entry->parent_perm & IOMMU_WO)) {
> > +            info->type = SMMU_PTW_ERR_PERMISSION;
> > +            info->stage = !(cached_entry->entry.perm & IOMMU_WO) ?
> > +                          SMMU_STAGE_1 :
> > +                          SMMU_STAGE_2;
> > +            return -EINVAL;
> > +        }
> > +        return 0;
> >  }
> >  
> >  SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
> > @@ -595,16 +696,14 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
> >  
> >      cached_entry = smmu_iotlb_lookup(bs, cfg, &tt_combined, aligned_addr);
> >      if (cached_entry) {
> > -        if ((flag & IOMMU_WO) && !(cached_entry->entry.perm & IOMMU_WO)) {
> > -            info->type = SMMU_PTW_ERR_PERMISSION;
> > -            info->stage = cfg->stage;
> > +        if (validate_tlb_entry(cached_entry, flag, info)) {
> >              return NULL;
> >          }
> >          return cached_entry;
> >      }
> >  
> >      cached_entry = g_new0(SMMUTLBEntry, 1);
> > -    status = smmu_ptw(cfg, aligned_addr, flag, cached_entry, info);
> > +    status = smmu_ptw(cfg, aligned_addr, flag, cached_entry, info, bs);
> >      if (status) {
> >              g_free(cached_entry);
> >              return NULL;
> > diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> > index cc12924a84..5f23f0b963 100644
> > --- a/hw/arm/trace-events
> > +++ b/hw/arm/trace-events
> > @@ -15,9 +15,9 @@ smmu_iotlb_inv_asid(uint16_t asid) "IOTLB invalidate asid=%d"
> >  smmu_iotlb_inv_vmid(uint16_t vmid) "IOTLB invalidate vmid=%d"
> >  smmu_iotlb_inv_iova(uint16_t asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
> >  smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
> > -smmu_iotlb_lookup_hit(uint16_t asid, uint16_t vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
> > -smmu_iotlb_lookup_miss(uint16_t asid, uint16_t vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
> > -smmu_iotlb_insert(uint16_t asid, uint16_t vmid, uint64_t addr, uint8_t tg, uint8_t level) "IOTLB ++ asid=%d vmid=%d addr=0x%"PRIx64" tg=%d level=%d"
> > +smmu_iotlb_lookup_hit(int asid, uint16_t vmid, uint64_t addr, uint64_t mask, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d vmid=%d addr=0x%"PRIx64" mask=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
> > +smmu_iotlb_lookup_miss(int asid, uint16_t vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache MISS asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
> > +smmu_iotlb_insert(int asid, uint16_t vmid, uint64_t addr, uint8_t tg, uint8_t level, uint64_t translate_addr) "IOTLB ++ asid=%d vmid=%d addr=0x%"PRIx64" tg=%d level=%d translate_addr=0x%"PRIx64
> >  
> >  # smmuv3.c
> >  smmuv3_read_mmio(uint64_t addr, uint64_t val, unsigned size, uint32_t r) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x(%d)"
> > diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> > index 2772175115..03ff0f02ba 100644
> > --- a/include/hw/arm/smmu-common.h
> > +++ b/include/hw/arm/smmu-common.h
> > @@ -91,6 +91,7 @@ typedef struct SMMUTLBEntry {
> >      IOMMUTLBEntry entry;
> >      uint8_t level;
> >      uint8_t granule;
> > +    IOMMUAccessFlags parent_perm;
> >  } SMMUTLBEntry;
> >  
> >  /* Stage-2 configuration. */
> > @@ -198,7 +199,7 @@ static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
> >   * pair, according to @cfg translation config
> >   */
> >  int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
> > -             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info);
> > +             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info, SMMUState *bs);
> >  
> >  
> >  /*
> To be honest this patch is quite complex to review. I would suggest you
> try to split it.

Yes, sorry about that :/ I thought it might be easier to have related
stuff in one patch, I will split it to 4-5 patches.


Thanks,
Mostafa
> Thanks
> 
> Eric
> 

