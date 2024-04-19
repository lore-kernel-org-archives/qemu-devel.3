Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5354AC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 10:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxlP6-0005nf-6I; Fri, 19 Apr 2024 06:23:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1rxlP3-0005n5-5N
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 06:23:33 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1rxlP0-0007jQ-U9
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 06:23:32 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-418426e446bso47005e9.1
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 03:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1713522209; x=1714127009; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1EgeUPAo0ZhaNzUj3VLilqEyJQlw7wVrDzZhHO0kCoE=;
 b=qt+35PFtW3obFphjST8nzQYHs6tyb14jxMLOy0iaFZP5/zAB1oQEiCp6QuQjcNURQ2
 k5OryGWy79cogiZ9is5IJxiB8EiTHgZZ5D4Su8CDAiMiPYR3uj8bU6FdaX6oCswbI8eK
 sAMJ3Mu4f18dSQ1BmGZNFPvl/c54ouCIUIUBgJIcKtD5eD4Q4a9OdtfTiwk3XEY3oOxW
 ezgDh4n8cRu0/wqvhqulC/+93mVQgMQek1timmPPdq8Lh42qL+CY2xbHupUQ+7+ao3OJ
 +A3KftRxz6y4LSZiM2yevgqPGMim8zX20CtjMhzUt8qz+kB8fuHu7eCijPcNYTP1wBwn
 eqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713522209; x=1714127009;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1EgeUPAo0ZhaNzUj3VLilqEyJQlw7wVrDzZhHO0kCoE=;
 b=BCVxadmh/JR5FYkxFu+o2Z+vBP6AmRbIsOhhZEqSm0KAvXqLCWs0mCHebz7VMPPefn
 C2Q58vdpomxadBm+wyMDKcNEtbM0xFLJ8Btb8taFthoPvtZ4DXe3ptlNT3mgdHEqKeTZ
 mF6a+aXtI3IGrX43m7nmduz0+lEiGSsAxdn74TZIo7p3u2RlVJXQLZSlgopgAMC0yN2R
 3nr62jkYAX7vYfrcU9YTW/2EuuSt9Rk+R3jY6ZApn9tz15ckr8m/L85mefNFHHs0xAHs
 u9gKDxm7RRNOHZUJ1quRT16+L6oO070KTYIb3Zn1o0vsOtExwCb03aMXfKlYwaBjjTz7
 iC6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ9nuKlFNm0NcE0XDwhJqbSiPA55GYmXhFXUcCX6uxsibBwexOrIGJLMslQbpzut+eFigClUJ2h8uEIAXlwJm5wAYjmzs=
X-Gm-Message-State: AOJu0YwIbyUxgoqT2WdQEKDZetbu5rHHVU/IYGJ4TpfKXBMNTfkju51I
 yCp4nMNaofOLMahGk7gumPW3AaMLI9BgdL83wWKuAIuv5ui3dKqAdvE6hQU1yQ==
X-Google-Smtp-Source: AGHT+IENpfzfghQkhnr5Nd/8VRHlrRgBh9Lm0w43tANieO/cebb8oS41BzuAm+eGDGM/6EUb5qh8xA==
X-Received: by 2002:a05:600c:3b15:b0:418:f770:3215 with SMTP id
 m21-20020a05600c3b1500b00418f7703215mr119153wms.5.1713522209045; 
 Fri, 19 Apr 2024 03:23:29 -0700 (PDT)
Received: from google.com (180.232.140.34.bc.googleusercontent.com.
 [34.140.232.180]) by smtp.gmail.com with ESMTPSA id
 a12-20020a056000050c00b00349ac818326sm4058707wrf.43.2024.04.19.03.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 03:23:28 -0700 (PDT)
Date: Fri, 19 Apr 2024 10:23:21 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [RFC PATCH v2 04/13] hw/arm/smmuv3: Translate CD and TT using
 stage-2 table
Message-ID: <ZiJGGScryLmYf6yQ@google.com>
References: <20240408140818.3799590-1-smostafa@google.com>
 <20240408140818.3799590-5-smostafa@google.com>
 <34b66166-9343-4c4e-836a-dbc605572ad3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34b66166-9343-4c4e-836a-dbc605572ad3@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=smostafa@google.com; helo=mail-wm1-x32b.google.com
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

On Thu, Apr 18, 2024 at 02:51:59PM +0200, Eric Auger wrote:
> Hi Mostafa,
> 
> On 4/8/24 16:08, Mostafa Saleh wrote:
> > According to the user manual (ARM IHI 0070 F.b),
> s/user manual/ARM SMMU architecture specification
> > In "5.2 Stream Table Entry":
> >  [51:6] S1ContextPtr
> >  If Config[1] == 1 (stage 2 enabled), this pointer is an IPA translated by
> >  stage 2 and the programmed value must be within the range of the IAS.
> >
> > In "5.4.1 CD notes":
> >  The translation table walks performed from TTB0 or TTB1 are always performed
> >  in IPA space if stage 2 translations are enabled.
> >
> > So translate both the CD and the TTBx in this patch if nested
> translate the S1 context descriptor pointer and TTBx base addresses
> through the S2 stage (IPA -> PA)
> 
> You may describe what you put in place to do the translation in the
> commit msg, new functions, macro, ...

Will do.

> > translation is requested.
> >
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  hw/arm/smmuv3.c              | 49 ++++++++++++++++++++++++++++++------
> >  include/hw/arm/smmu-common.h | 17 +++++++++++++
> >  2 files changed, 59 insertions(+), 7 deletions(-)
> >
> > diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> > index 897f8fe085..a7cf543acc 100644
> > --- a/hw/arm/smmuv3.c
> > +++ b/hw/arm/smmuv3.c
> > @@ -337,14 +337,36 @@ static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
> >  
> >  }
> >  
> > +static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
> > +                                                 SMMUTransCfg *cfg,
> > +                                                 SMMUEventInfo *event,
> > +                                                 IOMMUAccessFlags flag,
> > +                                                 SMMUTLBEntry **out_entry);
> >  /* @ssid > 0 not supported yet */
> > -static int smmu_get_cd(SMMUv3State *s, STE *ste, uint32_t ssid,
> > -                       CD *buf, SMMUEventInfo *event)
> > +static int smmu_get_cd(SMMUv3State *s, STE *ste, SMMUTransCfg *cfg,
> > +                       uint32_t ssid, CD *buf, SMMUEventInfo *event)
> >  {
> >      dma_addr_t addr = STE_CTXPTR(ste);
> >      int ret, i;
> > +    SMMUTranslationStatus status;
> > +    SMMUTLBEntry *entry;
> >  
> >      trace_smmuv3_get_cd(addr);
> > +
> > +    if (cfg->stage == SMMU_NESTED) {
> > +        CALL_FUNC_CFG_S2(cfg, status, smmuv3_do_translate, s, addr,
> > +                         cfg, event, IOMMU_RO, &entry);
> the fact we pass 2 times cfg looks pretty weird from a caller pov. See
> my comment below.

Yes, I don’t like it also as I mentioned in the cover letter,
(see me comment below also)

> 
> do we somewhere check addr is within the proper addr range, IAS if S2,
> OAS if S1. This was missing for S1 but I think it is worth improving now.
> see 3.4.3
Yes, this was added in the next patch.

> > +        /*
> > +         * It is not clear what should happen if this fails, so we return here
> > +         * which gets propagated as a translation error.
> but the error event might be different, no?

But the event is passed to the translate function so the right translation
error will be in the event (addr size, permission…).
It isn't clear to me from the specs if this should be a translation error
or some F_CD_FETCH/C_BAD_CD, and hence the comment, but I though the
translation error info would be more useful for SW that's why I used it.

> > +         */
> > +        if (status != SMMU_TRANS_SUCCESS) {
> > +            return -EINVAL;
> > +        }
> > +
> > +        addr = CACHED_ENTRY_TO_ADDR(entry, addr);
> > +    }
> > +
> >      /* TODO: guarantee 64-bit single-copy atomicity */
> >      ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf),
> >                            MEMTXATTRS_UNSPECIFIED);
> > @@ -659,10 +681,13 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
> >      return 0;
> >  }
> >  
> > -static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
> > +static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
> > +                     CD *cd, SMMUEventInfo *event)
> >  {
> >      int ret = -EINVAL;
> >      int i;
> > +    SMMUTranslationStatus status;
> > +    SMMUTLBEntry *entry;
> >  
> >      if (!CD_VALID(cd) || !CD_AARCH64(cd)) {
> >          goto bad_cd;
> > @@ -713,6 +738,17 @@ static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
> >  
> >          tt->tsz = tsz;
> >          tt->ttb = CD_TTB(cd, i);
> > +
> > +        /* Translate the TTBx, from IPA to PA if nesting is enabled. */
> > +        if (cfg->stage == SMMU_NESTED) {
> > +            CALL_FUNC_CFG_S2(cfg, status, smmuv3_do_translate, s,
> > +                             tt->ttb, cfg, event, IOMMU_RO, &entry);
> > +            /* See smmu_get_cd(). */
> ditto
> > +            if (status != SMMU_TRANS_SUCCESS) {
> > +                return -EINVAL;
> > +            }
> > +            tt->ttb = CACHED_ENTRY_TO_ADDR(entry, tt->ttb);
> > +        }
> >          if (tt->ttb & ~(MAKE_64BIT_MASK(0, cfg->oas))) {
> >              goto bad_cd;
> >          }
> > @@ -767,12 +803,12 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
> >          return 0;
> >      }
> >  
> > -    ret = smmu_get_cd(s, &ste, 0 /* ssid */, &cd, event);
> > +    ret = smmu_get_cd(s, &ste, cfg, 0 /* ssid */, &cd, event);
> >      if (ret) {
> >          return ret;
> >      }
> >  
> > -    return decode_cd(cfg, &cd, event);
> > +    return decode_cd(s, cfg, &cd, event);
> >  }
> >  
> >  /**
> > @@ -942,8 +978,7 @@ epilogue:
> >      switch (status) {
> >      case SMMU_TRANS_SUCCESS:
> >          entry.perm = cached_entry->entry.perm;
> > -        entry.translated_addr = cached_entry->entry.translated_addr +
> > -                                    (addr & cached_entry->entry.addr_mask);
> > +        entry.translated_addr = CACHED_ENTRY_TO_ADDR(cached_entry, addr);
> >          entry.addr_mask = cached_entry->entry.addr_mask;
> >          trace_smmuv3_translate_success(mr->parent_obj.name, sid, addr,
> >                                         entry.translated_addr, entry.perm,
> > diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> > index 96eb017e50..2772175115 100644
> > --- a/include/hw/arm/smmu-common.h
> > +++ b/include/hw/arm/smmu-common.h
> > @@ -37,6 +37,23 @@
> >  #define VMSA_IDXMSK(isz, strd, lvl)         ((1ULL << \
> >                                               VMSA_BIT_LVL(isz, strd, lvl)) - 1)
> >  
> > +#define CACHED_ENTRY_TO_ADDR(ent, addr)      (ent)->entry.translated_addr + \
> > +                                             ((addr) & (ent)->entry.addr_mask);
> > +
> > +/*
> > + * From nested context, some functions might need to translate IPA addresses.
> > + * As cfg has SMMU_NESTED, this won't work, this macro calls a function with
> > + * making it a stage-2 cfg and then restore it after.
> > + */
> > +#define CALL_FUNC_CFG_S2(cfg, ret, fn, ...)  ({ \
> > +                                                   int asid = cfg->asid; \
> > +                                                   cfg->stage = SMMU_STAGE_2; \
> > +                                                   cfg->asid = -1; \
> > +                                                   ret = fn(__VA_ARGS__); \
> At this stage of the reading this is not obvious why you need fn()
> parameter, can't you simply call
> 
> smmuv3_do_translate(). If this is useful at some point in the series, you shall document that in the commit msg. 
> Also I think I would prefer a proper function instead of this macro.
> 
> Besides, can't we add an extra parameter to the translate function forcing the S2_only translation although the cfg is a nested one. I think this would make things clearer
> 
This macro is reused with “smmu_translate” in the next patches, I had a
look with adding a a separate arg and I didn’t like it either, I can try
again or may be have a clear separate wrapper for this.


Thanks,
Mostafa
> > +                                                   cfg->asid = asid; \
> > +                                                   cfg->stage = SMMU_NESTED; \
> > +                                              })
> > +
> >  /*
> >   * Page table walk error types
> >   */
> Thanks
> 
> Eric
> 

