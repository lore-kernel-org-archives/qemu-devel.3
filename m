Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E14EC3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 07:16:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR551-0007Vm-3n; Tue, 09 Jul 2024 03:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sR550-0007VD-0A
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 03:16:02 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sR54k-0001pO-96
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 03:16:01 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4266f796e67so32695e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 00:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1720509342; x=1721114142; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ceKsXZzQxORr8UWHBarU6dV06z8zBsqvjsSzDv+Qvk4=;
 b=L8IMeXNLCKSjAuqf2+hFH3b+RzBhXCZW5Lu4liBXw0/naagk2SlyZxq7I7sfYjK5G7
 SqTdffDUMOkPZSJnh8G/rPz+Jx+FrMbByOrXS9yKST+uQGfeNzPOaj1UohvI/QCK3fly
 v5zeMtVhcJJPt+qSW4JFqgBXZUtw1t0ZhqUfN2Q7gM3qmQ7nWR2LncFlN6q15FraOMBg
 rg6V6HJkNHtm/yBr4SauaMD9Tv8VcpbzdwhG25b3LpktJfJjL62/K+DKMcT9KjFybNyX
 HaPwrpy1HKaHIpVYf9mNOSf+uKopPM/CPKG7UtNbW+mAro6KHz8O5ayyz1B3ijNlooz3
 lBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720509342; x=1721114142;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ceKsXZzQxORr8UWHBarU6dV06z8zBsqvjsSzDv+Qvk4=;
 b=wHaO/WqxKL4x/8RA45LGsHMJkYk6E30y2Lx8zIQ1CcslhI0oQRh+P/bh0qIRyW50E+
 Vhkj9OAY5fQinTG30PSnOVasllnI7mCMvlCbhbtsQzI/+9qpw2/Exk5rousT1p7qfxTL
 M2yyF5/UMUTPmit/1vq26Ceb8P5WbVXIpaAiZq/rnQXbiq+9q364WIs6FP+AH4LiBiQX
 FEiWi1rXu8ij3HVbD90WrBH1kPt8olY48SoRgPB1WLKmn6R1rNbo8HY6tA+Q8FQ74HSC
 MUuQvGg0Ok0pVn1GHYo4fFjPncoyT9pFu/01xWdhaB8xAr1vhItPPZ7Qa82/wCoOccjd
 l0Pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzIrlYCEJ6KjvU19BSiZqXshHEKoJyuWD/vTOnZkois3t+8Yo0WaTLYLwtw34vq/eRxRhp9gODn6MX8sEOmlSi6GM2mHg=
X-Gm-Message-State: AOJu0YwWjD3zM/VD2EIvQCaOal/Ruuv0D47foczu3bkJRNnE2t6uoNjE
 QqJlfGYn0Fs0GNIBHYJcTdAeUNXnLKbdaqdYbjsy8aozsTQfO3iOv2lxDBfsNQ==
X-Google-Smtp-Source: AGHT+IG3DMnFJjtxqkCBLCVbSVQFXZsMDyPt+vTKtslQwi5FyD2Km3SczSl5xVdz+eD5SuNGtxPNWQ==
X-Received: by 2002:a05:600c:1d1f:b0:41a:444b:e1d9 with SMTP id
 5b1f17b1804b1-42671c0a692mr1287645e9.4.1720509342294; 
 Tue, 09 Jul 2024 00:15:42 -0700 (PDT)
Received: from google.com (205.215.190.35.bc.googleusercontent.com.
 [35.190.215.205]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4266f7416dbsm26508955e9.39.2024.07.09.00.15.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 00:15:41 -0700 (PDT)
Date: Tue, 9 Jul 2024 07:15:37 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v4 11/19] hw/arm/smmu-common: Support nested translation
Message-ID: <ZozjmZ1ZodrUBT5s@google.com>
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-12-smostafa@google.com>
 <20240704183110.GH1693268@myrica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704183110.GH1693268@myrica>
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=smostafa@google.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Jean,

On Thu, Jul 04, 2024 at 07:31:10PM +0100, Jean-Philippe Brucker wrote:
> On Mon, Jul 01, 2024 at 11:02:33AM +0000, Mostafa Saleh wrote:
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
> 
> I don't think the text applies to this case, the context is:
> 
> 	A stage 2 table walk can encounter EABT accessing the physical
> 	address of a stage 2 descriptor, because of a:
> 	[...]
> 	* Translation of an IPA for Stage 1 descriptor fetch
> 
> So EABT is when failing to load the stage 2 descriptor. I can't find
> exact text for this case but looking at the flowchart 15.5, I think
> this should be F_TRANSLATION/F_ADDR_SIZE/F_PERMISSION/F_ACCESS with
> CLASS=TT and S2.

I see, thanks for clarifying, I guess that would be another argument that
we propagate more info in SMMUPTWEventInfo so we can set the fault CLASS.

Thanks,
Mostafa

> 
> Thanks,
> Jean
> 
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
> > -- 
> > 2.45.2.803.g4e1b14247a-goog
> > 

