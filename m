Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2DA4C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 07:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR57C-0004CR-4b; Tue, 09 Jul 2024 03:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sR57B-0004BS-2T
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 03:18:17 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sR579-000208-5N
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 03:18:16 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4266edcc54cso54595e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 00:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1720509494; x=1721114294; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Musi4DnUVQiysf3Si/fZahewrumXdr82z0dzErgcTnM=;
 b=WtF+Dkb0+hX/KBLpRblC/brujyaR3YI2jk0JYaEha1g/p9eMTBK3XWdXEYbcwy6nkL
 drg1HxAsKIc3NQTm5lvKW5an+5SrNW6AveV+HuWLjGlpt/MAZwX6HtXs4Wo7QFtB2anB
 cIr6SM1oymKmUlpGXj3YmjU3O1HgCphHl/hhWcw2EopDgY/Tb/IH6FhZ3Y9DKUJ4yyGM
 2bNZWK4Nov7gHfVtNfBduYkb5xN1x1yDNpDL6MTti4Z4CXOcuUpRWthuOzbDwuo9Pw8P
 bMYafVWnHKbUcD5KgPJMBvH6kpgwB/QzIZRQ8Gmg/OLhmw4XQffZTmmly1QEzpSgxhDg
 SPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720509494; x=1721114294;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Musi4DnUVQiysf3Si/fZahewrumXdr82z0dzErgcTnM=;
 b=HRuS3Nq41leDk4lHmahEp5sREvwRFhlujTSQQipuw+OaFcouRG4EGsxcH3OdFxVV/S
 Kd5dzSYW12r8VIOqQPlQPpKCIH771LjMRD5DxNglGPs3Hz9P92qQEYp81Xgb2tQgkY24
 gSm0GDtQkJCiBWE+6DQyzZXOs0Iz1M0K0fnebAkpO+NTLvjPhNsQiLZSAzB1J3URnG9f
 dyinJqyCQzSRkd3vabsLAcKMnw2uDKp4P1l0rv1lwoWggcL0iodKADIsnr1PmQc5mNRG
 OPAEHRPJCRMDCJ03BdjrP1HF2NpWzPXrn/NhVSE8Vl2ovNaamZsbmNQLK8HBH/goPrwE
 DhMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlDhXPo1qMcuSX8b2Zb68EIZHHFM6anLH/IdT9opzj0rPWyi2soMkYqJEe2kxhbjaC6RqNggAVJ84QKOBHx7H6bxcpP6o=
X-Gm-Message-State: AOJu0Yz2/hfQg3thjEXwNqNx9AxAaiXd6bNilukyBJtrDV5h2NcjTwQQ
 jxzxcjxKYy3HFyvqEQ6oc1Dcx5sArBduD9ADsFMGhc6Czk0lHFPfx4+Su5WMOw==
X-Google-Smtp-Source: AGHT+IGp4At/VP2RpsC7Be5pUQN3L8Rl28VlLihB9a4ZAUkZ/jUVIwlwvTTLYSqlz59kJ8ALA2PiEw==
X-Received: by 2002:a05:600c:1d1f:b0:424:898b:522b with SMTP id
 5b1f17b1804b1-42673175a65mr945905e9.1.1720509493343; 
 Tue, 09 Jul 2024 00:18:13 -0700 (PDT)
Received: from google.com (205.215.190.35.bc.googleusercontent.com.
 [35.190.215.205]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f74159csm26491475e9.42.2024.07.09.00.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 00:18:12 -0700 (PDT)
Date: Tue, 9 Jul 2024 07:18:08 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v4 11/19] hw/arm/smmu-common: Support nested translation
Message-ID: <ZozkMGIq9VHE3HXS@google.com>
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-12-smostafa@google.com>
 <86fc9221-f24e-4a7f-8a0d-b19102f981f0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86fc9221-f24e-4a7f-8a0d-b19102f981f0@redhat.com>
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

On Mon, Jul 08, 2024 at 05:19:59PM +0200, Eric Auger wrote:
> Hi Mostafa,
> 
> On 7/1/24 13:02, Mostafa Saleh wrote:
> > When nested translation is requested, do the following:
> >
> > - Translate stage-1 table address IPA into PA through stage-2.
> > - Translate stage-1 table walk output (IPA) through stage-2.
> > - Create a single TLB entry from stage-1 and stage-2 translations
> >   using logic introduced before.
> >
> > For stage-1 table translation, the spec (ARM IHI 0070 F.b) says in:
> >     7.3.12 F_WALK_EABT:
> >         Translation of an IPA for Stage 1 descriptor fetch:
> > 	S2 == 1 (stage 2), CLASS == T
> > So, F_WALK_EABT is used which propagtes to CLASS == TT.
> >
> > smmu_ptw() has a new argument SMMUState which include the TLB as
> > stage-1 table address can be cached in there.
> >
> > Also in smmu_ptw() a separate path used for nesting to simplify the
> > code, although some logic can be combined.
> >
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  hw/arm/smmu-common.c         | 72 +++++++++++++++++++++++++++++++-----
> >  include/hw/arm/smmu-common.h |  2 +-
> >  2 files changed, 64 insertions(+), 10 deletions(-)
> >
> > diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> > index 24b7d09e2b..71afd486ba 100644
> > --- a/hw/arm/smmu-common.c
> > +++ b/hw/arm/smmu-common.c
> > @@ -318,6 +318,38 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
> >      return NULL;
> >  }
> >  
> > +/* Translate stage-1 table address using stage-2 page table. */
> > +static inline int translate_table_addr_ipa(dma_addr_t *table_addr,
> > +                                           SMMUTransCfg *cfg,
> > +                                           SMMUPTWEventInfo *info,
> > +                                           SMMUState *bs)
> Nit: in general the SMMUState if the 1st arg, as the most global state.
> > +{
> > +    dma_addr_t addr = *table_addr;
> > +    SMMUTLBEntry *cached_entry;
> > +    int asid;
> > +
> > +    /*
> > +     * The translation table walks performed from TTB0 or TTB1 are always
> > +     * performed in IPA space if stage 2 translations are enabled.
> > +     */
> > +    asid = cfg->asid;
> > +    cfg->stage = SMMU_STAGE_2;
> > +    cfg->asid = -1;
> > +    cached_entry = smmu_translate(bs, cfg, addr, IOMMU_RO, info);
> > +    cfg->asid = asid;
> > +    cfg->stage = SMMU_NESTED;
> > +
> > +    if (cached_entry) {
> > +        *table_addr = CACHED_ENTRY_TO_ADDR(cached_entry, addr);
> > +        return 0;
> > +    }
> > +
> > +    info->stage = SMMU_STAGE_2;
> > +    info->type = SMMU_PTW_ERR_WALK_EABT;
> > +    info->addr = addr;
> so I guess also here the recorded address should be the IOVA (Jean's
> previous comment)?

This address maps to FetchAddr and not InputAddr, which is set from the
calling function, so that should be correct. (besides event type as Jean
mentioned it needs be fixed).

Thanks,
Mostafa

> 
> Eric
> > +    return -EINVAL;
> > +}
> > +
> >  /**
> >   * smmu_ptw_64_s1 - VMSAv8-64 Walk of the page tables for a given IOVA
> >   * @cfg: translation config
> > @@ -333,7 +365,8 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
> >   */
> >  static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
> >                            dma_addr_t iova, IOMMUAccessFlags perm,
> > -                          SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
> > +                          SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info,
> > +                          SMMUState *bs)
> >  {
> >      dma_addr_t baseaddr, indexmask;
> >      SMMUStage stage = cfg->stage;
> > @@ -381,6 +414,11 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
> >                  goto error;
> >              }
> >              baseaddr = get_table_pte_address(pte, granule_sz);
> > +            if (cfg->stage == SMMU_NESTED) {
> > +                if (translate_table_addr_ipa(&baseaddr, cfg, info, bs)) {
> > +                    goto error;
> > +                }
> > +            }
> >              level++;
> >              continue;
> >          } else if (is_page_pte(pte, level)) {
> > @@ -568,10 +606,8 @@ error:
> >   * combine S1 and S2 TLB entries into a single entry.
> >   * As a result the S1 entry is overriden with combined data.
> >   */
> > -static void __attribute__((unused)) combine_tlb(SMMUTLBEntry *tlbe,
> > -                                                SMMUTLBEntry *tlbe_s2,
> > -                                                dma_addr_t iova,
> > -                                                SMMUTransCfg *cfg)
> > +static void combine_tlb(SMMUTLBEntry *tlbe, SMMUTLBEntry *tlbe_s2,
> > +                        dma_addr_t iova, SMMUTransCfg *cfg)
> >  {
> >      if (tlbe_s2->entry.addr_mask < tlbe->entry.addr_mask) {
> >          tlbe->entry.addr_mask = tlbe_s2->entry.addr_mask;
> > @@ -596,14 +632,19 @@ static void __attribute__((unused)) combine_tlb(SMMUTLBEntry *tlbe,
> >   * @perm: tentative access type
> >   * @tlbe: returned entry
> >   * @info: ptw event handle
> > + * @bs: smmu state which includes TLB instance
> >   *
> >   * return 0 on success
> >   */
> >  int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
> > -             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
> > +             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info, SMMUState *bs)
> >  {
> > +    int ret;
> > +    SMMUTLBEntry tlbe_s2;
> > +    dma_addr_t ipa;
> > +
> >      if (cfg->stage == SMMU_STAGE_1) {
> > -        return smmu_ptw_64_s1(cfg, iova, perm, tlbe, info);
> > +        return smmu_ptw_64_s1(cfg, iova, perm, tlbe, info, bs);
> >      } else if (cfg->stage == SMMU_STAGE_2) {
> >          /*
> >           * If bypassing stage 1(or unimplemented), the input address is passed
> > @@ -621,7 +662,20 @@ int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
> >          return smmu_ptw_64_s2(cfg, iova, perm, tlbe, info);
> >      }
> >  
> > -    g_assert_not_reached();
> > +    /* SMMU_NESTED. */
> > +    ret = smmu_ptw_64_s1(cfg, iova, perm, tlbe, info, bs);
> > +    if (ret) {
> > +        return ret;
> > +    }
> > +
> > +    ipa = CACHED_ENTRY_TO_ADDR(tlbe, iova);
> > +    ret = smmu_ptw_64_s2(cfg, ipa, perm, &tlbe_s2, info);
> > +    if (ret) {
> > +        return ret;
> > +    }
> > +
> > +    combine_tlb(tlbe, &tlbe_s2, iova, cfg);
> > +    return 0;
> >  }
> >  
> >  SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
> > @@ -677,7 +731,7 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
> >      }
> >  
> >      cached_entry = g_new0(SMMUTLBEntry, 1);
> > -    status = smmu_ptw(cfg, aligned_addr, flag, cached_entry, info);
> > +    status = smmu_ptw(cfg, aligned_addr, flag, cached_entry, info, bs);
> >      if (status) {
> >              g_free(cached_entry);
> >              return NULL;
> > diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> > index 1db566d451..cf0fd3ec74 100644
> > --- a/include/hw/arm/smmu-common.h
> > +++ b/include/hw/arm/smmu-common.h
> > @@ -185,7 +185,7 @@ static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
> >   * pair, according to @cfg translation config
> >   */
> >  int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
> > -             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info);
> > +             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info, SMMUState *bs);
> >  
> >  
> >  /*
> 

