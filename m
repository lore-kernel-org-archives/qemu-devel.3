Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9ADEC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 18:09:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPQsn-00083G-1L; Thu, 04 Jul 2024 14:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPQsl-00082f-CD
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:08:35 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPQsi-0003Il-W5
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:08:35 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2ee7885aa5fso9465381fa.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 11:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720116510; x=1720721310; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tzgyf9A1Taw5ulsQof2vD8qwZ2xu8UjoUPYYj9ywsDE=;
 b=OL+oIJYQS+7GG/tpQGyZC85C46K5bLan/zSmGG2+KLVBKYnRCSf7hU0hFIrC/NwiQ3
 h7+FReegB0YMv6HbFUQ+VKq4Bcx/Bcm/5skaztEVhwXlxeVnX925NRP8aC80qPO+Emkb
 6pDxgki/PfooH2bFEe3Iu3xL8HfQspqbng2WGuuEl/9Kwp6eVDpzVPaslmvtlg5sBhvW
 w2zCquOhf9t4LQamSQf0Mi1Wn+xYNjU5F/rD+JhNwJbAxp+jZke2XrZLJoTP8681us2Y
 oR7C10dwKxWYlkv+caxLrnANvNFHKeRb0D6h4k+VckqUa+6sA4BmNZHBnyhT0aPJW5nr
 ycOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720116510; x=1720721310;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tzgyf9A1Taw5ulsQof2vD8qwZ2xu8UjoUPYYj9ywsDE=;
 b=ikEH27kkm48gydO8419Q/KNBnmSMXueNQaJvmlREb3u9OU7J+xJL8E3OodAt4XwWXh
 62G3N/xNqqCyqOvogWDo0HO999xB5aFMds284kUo2PWw/upKlB8X0UVAj/iM0DutB8HQ
 Q3bvt5H+QwpiWZ46+DUILowFJn621wIJuN+YhZUA4YPFqT9C0K/o9KrVMN2TPi2bO4Tk
 lGLTFyWmafOYkFeXrW+GMZYr+T7GzFeZiVlH6b/Sjg7EKVeIXvb4xZYuJ/e4Qoa56aIS
 jlTOFik1CX1+zdhDAsE4r+wEotqwOyfql+cc9cHEXdgPSWa7ohKyhgQT0pKfP5yY28sB
 Z8lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIFZ75SiVQ/p3txqT8Zr5/2xUkz7xqMufi1UEP+Sws/lfqCupouAErHxF8f4sUPYyeliIdZVnsf8/mqUz7mRHri4Wjr/k=
X-Gm-Message-State: AOJu0YyTB02nxRqMbUJZdDTDpGyz8mOgFg2oCMiiErzKRmPYDom4kYUX
 qsng46aIBdWGcnHZ3KMLrOvk/fNnWJCAF5M8g5ZRIM6JsH/SnLGNWZX/8H0gHzM=
X-Google-Smtp-Source: AGHT+IFYn4vnLHdVAn7FnuKiuNyGQ5bQeBO4lnrY4ZusylpN+4fuUE4l9ZDRZpS0PUv3jNnE4wrsaQ==
X-Received: by 2002:a2e:9a89:0:b0:2ee:8171:8e13 with SMTP id
 38308e7fff4ca-2ee8ee13eebmr17662841fa.44.1720116510356; 
 Thu, 04 Jul 2024 11:08:30 -0700 (PDT)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a1f23c1sm32732125e9.28.2024.07.04.11.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 11:08:30 -0700 (PDT)
Date: Thu, 4 Jul 2024 19:08:43 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v4 08/19] hw/arm/smmuv3: Translate CD and TT using
 stage-2 table
Message-ID: <20240704180843.GE1693268@myrica>
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-9-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701110241.2005222-9-smostafa@google.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=jean-philippe@linaro.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Jul 01, 2024 at 11:02:30AM +0000, Mostafa Saleh wrote:
> According to ARM SMMU architecture specification (ARM IHI 0070 F.b),
> In "5.2 Stream Table Entry":
>  [51:6] S1ContextPtr
>  If Config[1] == 1 (stage 2 enabled), this pointer is an IPA translated by
>  stage 2 and the programmed value must be within the range of the IAS.
> 
> In "5.4.1 CD notes":
>  The translation table walks performed from TTB0 or TTB1 are always performed
>  in IPA space if stage 2 translations are enabled.
> 
> This patch implements translation of the S1 context descriptor pointer and
> TTBx base addresses through the S2 stage (IPA -> PA)
> 
> smmuv3_do_translate() is updated to have one arg which is translation
> class, this is useful to:
>  - Decide wether a translation is stage-2 only or use the STE config.
>  - Populate the class in case of faults, WALK_EABT is left unchanged,
>    as it is always triggered from TT access so no need to use the
>    input class.
> 
> In case for stage-2 only translation, used in the context of nested
> translation, the stage and asid are saved and restored before and
> after calling smmu_translate().
> 
> Translating CD or TTBx can fail for the following reasons:
> 1) Large address size: This is described in
>    (3.4.3 Address sizes of SMMU-originated accesses)
>    - For CD ptr larger than IAS, for SMMUv3.1, it can trigger either
>      C_BAD_STE or Translation fault, we implement the latter as it
>      requires no extra code.
>    - For TTBx, if larger than the effective stage 1 output address size, it
>      triggers C_BAD_CD.
> 
> 2) Faults from PTWs (7.3 Event records)
>    - F_ADDR_SIZE: large address size after first level causes stage 2 Address
>      Size fault (Also in 3.4.3 Address sizes of SMMU-originated accesses)
>    - F_PERMISSION: Same as an address translation. However, when
>      CLASS == CD, the access is implicitly Data and a read.
>    - F_ACCESS: Same as an address translation.
>    - F_TRANSLATION: Same as an address translation.
>    - F_WALK_EABT: Same as an address translation.
>   These are already implemented in the PTW logic, so no extra handling
>   required.
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  hw/arm/smmuv3.c | 91 +++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 80 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 229b3c388c..86f95c1e40 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -337,14 +337,35 @@ static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
>  
>  }
>  
> +static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
> +                                                 SMMUTransCfg *cfg,
> +                                                 SMMUEventInfo *event,
> +                                                 IOMMUAccessFlags flag,
> +                                                 SMMUTLBEntry **out_entry,
> +                                                 SMMUTranslationClass class);
>  /* @ssid > 0 not supported yet */
> -static int smmu_get_cd(SMMUv3State *s, STE *ste, uint32_t ssid,
> -                       CD *buf, SMMUEventInfo *event)
> +static int smmu_get_cd(SMMUv3State *s, STE *ste, SMMUTransCfg *cfg,
> +                       uint32_t ssid, CD *buf, SMMUEventInfo *event)
>  {
>      dma_addr_t addr = STE_CTXPTR(ste);
>      int ret, i;
> +    SMMUTranslationStatus status;
> +    SMMUTLBEntry *entry;
>  
>      trace_smmuv3_get_cd(addr);
> +
> +    if (cfg->stage == SMMU_NESTED) {
> +        status = smmuv3_do_translate(s, addr, cfg, event,
> +                                     IOMMU_RO, &entry, SMMU_CLASS_CD);
> +
> +        /* Same PTW faults are reported but with CLASS = CD. */
> +        if (status != SMMU_TRANS_SUCCESS) {

In this case I think we're reporting InputAddr as the CD address, but it
should be the IOVA

> +            return -EINVAL;
> +        }
> +
> +        addr = CACHED_ENTRY_TO_ADDR(entry, addr);
> +    }
> +
>      /* TODO: guarantee 64-bit single-copy atomicity */
>      ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf),
>                            MEMTXATTRS_UNSPECIFIED);
> @@ -659,10 +680,13 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>      return 0;
>  }
>  
> -static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
> +static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
> +                     CD *cd, SMMUEventInfo *event)
>  {
>      int ret = -EINVAL;
>      int i;
> +    SMMUTranslationStatus status;
> +    SMMUTLBEntry *entry;
>  
>      if (!CD_VALID(cd) || !CD_AARCH64(cd)) {
>          goto bad_cd;
> @@ -713,9 +737,26 @@ static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
>  
>          tt->tsz = tsz;
>          tt->ttb = CD_TTB(cd, i);
> +
>          if (tt->ttb & ~(MAKE_64BIT_MASK(0, cfg->oas))) {
>              goto bad_cd;
>          }
> +
> +        /* Translate the TTBx, from IPA to PA if nesting is enabled. */
> +        if (cfg->stage == SMMU_NESTED) {
> +            status = smmuv3_do_translate(s, tt->ttb, cfg, event, IOMMU_RO,
> +                                         &entry, SMMU_CLASS_TT);
> +            /*
> +             * Same PTW faults are reported but with CLASS = TT.
> +             * If TTBx is larger than the effective stage 1 output addres
> +             * size, it reports C_BAD_CD, which is handled by the above case.
> +             */
> +            if (status != SMMU_TRANS_SUCCESS) {

Here too, we should report InputAddr as the IOVA

> +                return -EINVAL;
> +            }
> +            tt->ttb = CACHED_ENTRY_TO_ADDR(entry, tt->ttb);
> +        }
> +
>          tt->had = CD_HAD(cd, i);
>          trace_smmuv3_decode_cd_tt(i, tt->tsz, tt->ttb, tt->granule_sz, tt->had);
>      }
> @@ -767,12 +808,12 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
>          return 0;
>      }
>  
> -    ret = smmu_get_cd(s, &ste, 0 /* ssid */, &cd, event);
> +    ret = smmu_get_cd(s, &ste, cfg, 0 /* ssid */, &cd, event);
>      if (ret) {
>          return ret;
>      }
>  
> -    return decode_cd(cfg, &cd, event);
> +    return decode_cd(s, cfg, &cd, event);
>  }
>  
>  /**
> @@ -832,13 +873,40 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>                                                   SMMUTransCfg *cfg,
>                                                   SMMUEventInfo *event,
>                                                   IOMMUAccessFlags flag,
> -                                                 SMMUTLBEntry **out_entry)
> +                                                 SMMUTLBEntry **out_entry,
> +                                                 SMMUTranslationClass class)
>  {
>      SMMUPTWEventInfo ptw_info = {};
>      SMMUState *bs = ARM_SMMU(s);
>      SMMUTLBEntry *cached_entry = NULL;
> +    int asid, stage;
> +    bool S2_only = class != SMMU_CLASS_IN;
> +
> +    /*
> +     * The function uses the argument class to indentify which stage is used:

identify

> +     * - CLASS = IN: Means an input translation, determine the stage from STE.
> +     * - CLASS = CD: Means the addr is an IPA of the CD, and it would be
> +     *   tranlsated using the stage-2.

translated

> +     * - CLASS = TT: Means the addr is an IPA of the stage-1 translation table
> +     *   and it would be tranlsated using the stage-2.

translated

> +     * For the last 2 cases instead of having intrusive changes in the common
> +     * logic, we modify the cfg to be a stage-2 translation only in case of
> +     * nested, and then restore it after.
> +     */
> +    if (S2_only) {

"S2_only" seems a bit confusing because in the spec "stage 2-only" means
absence of nesting, which is the opposite of what we're handling here.
I don't have a good alternative though, maybe "desc_s2_translation"

Thanks,
Jean

> +        asid = cfg->asid;
> +        stage = cfg->stage;
> +        cfg->asid = -1;
> +        cfg->stage = SMMU_STAGE_2;
> +    }
>  
>      cached_entry = smmu_translate(bs, cfg, addr, flag, &ptw_info);
> +
> +    if (S2_only) {
> +        cfg->asid = asid;
> +        cfg->stage = stage;
> +    }
> +
>      if (!cached_entry) {
>          /* All faults from PTW has S2 field. */
>          event->u.f_walk_eabt.s2 = (ptw_info.stage == SMMU_STAGE_2);
> @@ -855,7 +923,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>                  event->type = SMMU_EVT_F_TRANSLATION;
>                  event->u.f_translation.addr = addr;
>                  event->u.f_translation.addr2 = ptw_info.addr;
> -                event->u.f_translation.class = SMMU_CLASS_IN;
> +                event->u.f_translation.class = class;
>                  event->u.f_translation.rnw = flag & 0x1;
>              }
>              break;
> @@ -864,7 +932,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>                  event->type = SMMU_EVT_F_ADDR_SIZE;
>                  event->u.f_addr_size.addr = addr;
>                  event->u.f_addr_size.addr2 = ptw_info.addr;
> -                event->u.f_addr_size.class = SMMU_CLASS_IN;
> +                event->u.f_addr_size.class = class;
>                  event->u.f_addr_size.rnw = flag & 0x1;
>              }
>              break;
> @@ -873,7 +941,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>                  event->type = SMMU_EVT_F_ACCESS;
>                  event->u.f_access.addr = addr;
>                  event->u.f_access.addr2 = ptw_info.addr;
> -                event->u.f_access.class = SMMU_CLASS_IN;
> +                event->u.f_access.class = class;
>                  event->u.f_access.rnw = flag & 0x1;
>              }
>              break;
> @@ -882,7 +950,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>                  event->type = SMMU_EVT_F_PERMISSION;
>                  event->u.f_permission.addr = addr;
>                  event->u.f_permission.addr2 = ptw_info.addr;
> -                event->u.f_permission.class = SMMU_CLASS_IN;
> +                event->u.f_permission.class = class;
>                  event->u.f_permission.rnw = flag & 0x1;
>              }
>              break;
> @@ -943,7 +1011,8 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>          goto epilogue;
>      }
>  
> -    status = smmuv3_do_translate(s, addr, cfg, &event, flag, &cached_entry);
> +    status = smmuv3_do_translate(s, addr, cfg, &event, flag,
> +                                 &cached_entry, SMMU_CLASS_IN);
>  
>  epilogue:
>      qemu_mutex_unlock(&s->mutex);
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 

