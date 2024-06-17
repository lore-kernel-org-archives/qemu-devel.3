Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5FCC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 14:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJDo6-0003pF-LL; Mon, 17 Jun 2024 10:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sJDo4-0003ov-Rc
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 10:58:04 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sJDo3-0001md-0m
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 10:58:04 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-57c8bd6b655so19734a12.0
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 07:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718636281; x=1719241081; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LClY+ytfGOwlAzSQulAJXPrfM8v3DyO3USmlzR5XHgA=;
 b=FBMpke23G4ZiQAczRVEW8ePIcToCRP8CbXkpZ7kYsrZJ2C4w6J9pihv84rbjl+YV/p
 1DmIkd2DBgbpm45J3eWR3XrrpXQBRn9M3vdojVSerbMlpeDCLPaziymD90OaQwwkvQ6/
 TZ43/JS/dSAk+FxP2Gqor6AKhNW3SU9mqbt8lCnylffBcrvaLdDAPIHRvMIK8U3lvft4
 ELGQwXcK4Qd5d43oSYZx+91hshLFzqThByw4pb18auqjc9loSmWUuUn+rCC6Y9zcJdDP
 djRKnZdMnKfn20rq56Ep4diMvBrsmKe0ohvroV9/KxAqFfgFYOUDDS3iLwPSLgYezihE
 sZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718636281; x=1719241081;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LClY+ytfGOwlAzSQulAJXPrfM8v3DyO3USmlzR5XHgA=;
 b=QmIbFJVs1XqhPurY/Nx4asvOkMy7xqLFfs49DchCdU6iNsr08uwO1EE2ruZq7NzMmb
 J+robwtJciFC1fQ/OnnfCa8qAChuULA4r1O0fzOLEmrc0WplarKib4hMO5Nn4eDqZa1q
 Fs5mKTuH08YVEnyK3qJiwtdZp24R8wJPGyLt3xyDtr1aDsCCYIiJl6X1xkJ6VgrfMiSO
 az+TaND4Vr9tUy69vay6qD2mwXx1dWYlAVnYOgxeCs0kl5pjgqLvD4q2et16E32ww9NI
 ny0DrT3UhuUIx859Ny2o4+5o9sOb1sLUtjmapqDg0Zk5h1H8J3I1z1xi1zO8boyU9t/d
 IDiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwhn776zpVlHPoGl67mCAoNBGxRLJrlkgQyL1oVtzb/pcpSFersE52Y+HewUfisWlzYI4c6+4RIxhUdBYYXMxVNIkLPJo=
X-Gm-Message-State: AOJu0YysWD+/ipuV6Zzh43j8jH4dYzTc2g7kRcg2J8F7bIZDcR9Ey0S7
 PuWFoTij3z/P1pHCPT3KIIPAOkBrOzJMwzWf0Cz41BC4zhJp6FyDkArIyHU8mHWH7uQDbMztZcT
 FYA==
X-Google-Smtp-Source: AGHT+IFr8aGbWOuAdX2QRqHLmlfGpPUOen7MKLZczDu+MOZplLrWiCPhaBe26bjjCnTplyz6NZQbAw==
X-Received: by 2002:a05:6402:50d2:b0:57c:cfa9:837b with SMTP id
 4fb4d7f45d1cf-57ccfa98704mr201922a12.0.1718636280537; 
 Mon, 17 Jun 2024 07:58:00 -0700 (PDT)
Received: from google.com (205.215.190.35.bc.googleusercontent.com.
 [35.190.215.205]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-360750f2263sm12184651f8f.83.2024.06.17.07.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 07:58:00 -0700 (PDT)
Date: Mon, 17 Jun 2024 14:57:55 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [RFC PATCH v3 10/18] hw/arm/smmu-common: Support nested
 translation
Message-ID: <ZnBO8wuegTVZZBRV@google.com>
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-11-smostafa@google.com>
 <770312ee-8093-431a-bfdf-b01ca90945cf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <770312ee-8093-431a-bfdf-b01ca90945cf@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=smostafa@google.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=unavailable autolearn_force=no
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

On Mon, May 20, 2024 at 11:48:18AM +0200, Eric Auger wrote:
> Hi Mostafa,
> 
> On 4/29/24 05:23, Mostafa Saleh wrote:
> > When nested translation is requested, do the following:
> >
> > - Translate stage-1 IPA using stage-2 to a physical address.
> stage-1 table address IPA into PA through S2 stage
> 
Will do.

> > - Translate stage-1 table walks using stage-2.
> output of S1 stage (IPA) through S2.
Will do.

> > - Combine both to create a single TLB entry using the logic
> >   introduced before.
> this applies to second only. First one is associated with an S2 TLB
> entry, right?
Yes, I will clarify that.

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
> >  hw/arm/smmu-common.c         | 67 ++++++++++++++++++++++++++++++------
> >  include/hw/arm/smmu-common.h |  2 +-
> >  2 files changed, 58 insertions(+), 11 deletions(-)
> >
> > diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> > index c67af3bc6d..d48ec08947 100644
> > --- a/hw/arm/smmu-common.c
> > +++ b/hw/arm/smmu-common.c
> > @@ -306,6 +306,32 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
> >      return NULL;
> >  }
> >  
> > +/* Translate stage-1 table address using stage-2 page table. */
> > +static inline int translate_table_s1(dma_addr_t *table_addr, SMMUTransCfg *cfg,
> > +                                     SMMUPTWEventInfo *info, SMMUState *bs)
> would suggest translate_table_addr_ipa().
Wil do.
> > +{
> > +    dma_addr_t addr = *table_addr;
> > +    SMMUTLBEntry *cached_entry;
> > +    int asid;
> > +
> > +    asid = cfg->asid;
> > +    cfg->stage = SMMU_STAGE_2;
> > +    cfg->asid = -1;
> > +    cached_entry = smmu_translate(bs, cfg, addr, IOMMU_RO, info);
> so this is going to be cached as an S2 entry. Maybe worth adding a comment.

This is part of the IPA space and it is translated using a stage-2 page table,
so it would be cached as an S2, I will add a comment quoting the spec.

Thanks,
Mostafa
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
> > @@ -321,7 +347,8 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
> >   */
> >  static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
> >                            dma_addr_t iova, IOMMUAccessFlags perm,
> > -                          SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
> > +                          SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info,
> > +                          SMMUState *bs)
> >  {
> >      dma_addr_t baseaddr, indexmask;
> >      SMMUStage stage = cfg->stage;
> > @@ -369,6 +396,11 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
> >                  goto error;
> >              }
> >              baseaddr = get_table_pte_address(pte, granule_sz);
> > +            if (cfg->stage == SMMU_NESTED) {
> > +                if (translate_table_s1(&baseaddr, cfg, info, bs)) {
> > +                    goto error;
> > +                }
> > +            }
> >              level++;
> >              continue;
> >          } else if (is_page_pte(pte, level)) {
> > @@ -551,10 +583,8 @@ error:
> >  }
> >  
> >  /* combine 2 TLB entries and return in tlbe in nested config. */
> > -static void __attribute__((unused)) combine_tlb(SMMUTLBEntry *tlbe,
> > -                                                SMMUTLBEntry *tlbe_s2,
> > -                                                dma_addr_t iova,
> > -                                                SMMUTransCfg *cfg)
> > +static void combine_tlb(SMMUTLBEntry *tlbe, SMMUTLBEntry *tlbe_s2,
> > +                        dma_addr_t iova, SMMUTransCfg *cfg)
> >  {
> >      if (tlbe_s2->entry.addr_mask < tlbe->entry.addr_mask) {
> >          tlbe->entry.addr_mask = tlbe_s2->entry.addr_mask;
> > @@ -579,14 +609,19 @@ static void __attribute__((unused)) combine_tlb(SMMUTLBEntry *tlbe,
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
> > @@ -600,11 +635,23 @@ int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
> >              tlbe->entry.perm = IOMMU_NONE;
> >              return -EINVAL;
> >          }
> > -
> spurious line change
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
> > @@ -660,7 +707,7 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
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
> Thanks
> 
> Eric
> 

