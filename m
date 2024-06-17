Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99822C27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 15:04:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJDtb-0007TW-Ct; Mon, 17 Jun 2024 11:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sJDta-0007TC-IO
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 11:03:46 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <smostafa@google.com>)
 id 1sJDtY-0002ha-Nu
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 11:03:46 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-422954bbe29so100845e9.1
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 08:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718636623; x=1719241423; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rOvfbNKeAp1OHxpNPkoYNzSFqsgvdhQULu/ykYcZVHc=;
 b=OhqFWR57B2Z6cX3V8ATlzJvhB8lrfyBzWnbGwtlKIRW8aZHqPOQZEvSB+3xtqF9D4j
 z+/sRMVpt0sJzrqyzTYhqljLbOW5dEfeQ41H/0FFt8AkTL/+liN8HIseBBgGZuqjRgt4
 7eESXs0kIuy+bgTQxbBIdctvBm3yY/tUDZxPifiOpXHAXi7ZkSPFOxoRkKYwoYO/MUAg
 R6huD/wEcW96/77QUq+7bkj+xO7psE8B5Z/EJ7oawZ6XucLeOmOKJ75m5o+O3UgR5ZQq
 T7inI473IEJ//61m5GY7F+KjatfYbUlUMtE4BIVbHka96LTYkCRq3Auy9GBAbzJMu6Nm
 PfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718636623; x=1719241423;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rOvfbNKeAp1OHxpNPkoYNzSFqsgvdhQULu/ykYcZVHc=;
 b=lyKSiish3M3CDhYZwVNUHLFIOZHUDfOt0JJAyWnj+5cQbmce/WLL2RFYYKA5cCUh9a
 Vy6F/cmdhsiyF3qmS654TRPpWNqaa791TgOnZfMVkIGoULfp/VMRw7ng9goomQD8Z++q
 4RvPyivKxm4BiDQ2einx1xdlUXVVDvh6sWjXvvfjxl0r3h1KILNqINiiWCyVZO3A6lZT
 x3fv3NSDB5xA043KPsZmFxu1I47KkBemyhoRRckZ4rsc+BhMj/mVx7BF9hVQtaN2ad8h
 e0bgR//s9glteyFDIxM8XUi6qDeB0ie9+P7593PrOeEaOlL9NuUpTSIHaIvI4voac9gv
 uCtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoJlxWXAUfEA8K9CMCJm+GlLvx3xuxhsFkHe2Dm5xRVYn+J7VkBDlKvf+YDJktAzRBvegWNw9YBjqPaPhYBUNUdYqSTso=
X-Gm-Message-State: AOJu0YwBB0aJu7JCdj7EdKNa+HmOT7exCp2jYkmtYIawkEcjkM/JD08n
 rqPF+IZ6OfKfA5TKz+J7VuEVFl2V1OJr0I4iRJ17cci2vZFrlmmbn1QX+bUmeA==
X-Google-Smtp-Source: AGHT+IFLcOb7Y3G7ULHlJmHgWhrOf3QTI3TEDE4bBgWF/MDHU3Z40INphhmg9wNHJoUqfKnzm+LWcQ==
X-Received: by 2002:a05:600c:3483:b0:421:5288:8360 with SMTP id
 5b1f17b1804b1-423b5d68360mr3824035e9.0.1718636622815; 
 Mon, 17 Jun 2024 08:03:42 -0700 (PDT)
Received: from google.com (205.215.190.35.bc.googleusercontent.com.
 [35.190.215.205]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f6127d78sm163993445e9.25.2024.06.17.08.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 08:03:42 -0700 (PDT)
Date: Mon, 17 Jun 2024 15:03:37 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [RFC PATCH v3 14/18] hw/arm/smmuv3: Support and advertise nesting
Message-ID: <ZnBQSYqwdpKFGuDQ@google.com>
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-15-smostafa@google.com>
 <38005c2a-0e1d-4140-b046-8fbc82be7d8c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38005c2a-0e1d-4140-b046-8fbc82be7d8c@redhat.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=smostafa@google.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01, USER_IN_DEF_DKIM_WL=-7.5,
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

On Mon, May 20, 2024 at 03:16:40PM +0200, Eric Auger wrote:
> Hi Mostafa,
> 
> On 4/29/24 05:23, Mostafa Saleh wrote:
> > Everything is in place, add the last missing bits:
> > - Handle fault checking according to the actual PTW event and not the
> >   the translation stage.
> missing the "why". Can't it be moved in a separate patch?

Sure, I will split.

Thanks,
Mostafa

> > - Consolidate parsing of STE cfg and setting translation stage.
> >
> > Advertise nesting if stage requested is "nested".
> I would move the introduction of the nested option in a separate patch
> and in the associated commit msg properly document how the new option
> shall be used.
> >
> > Signed-off-by: Mostafa Saleh <smostafa@google.com>
> > ---
> >  hw/arm/smmuv3.c | 50 +++++++++++++++++++++++++++++++++----------------
> >  1 file changed, 34 insertions(+), 16 deletions(-)
> >
> > diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> > index 96d07234fe..88f6473d33 100644
> > --- a/hw/arm/smmuv3.c
> > +++ b/hw/arm/smmuv3.c
> > @@ -34,9 +34,10 @@
> >  #include "smmuv3-internal.h"
> >  #include "smmu-internal.h"
> >  
> > -#define PTW_RECORD_FAULT(cfg)   (((cfg)->stage == SMMU_STAGE_1) ? \
> > -                                 (cfg)->record_faults : \
> > -                                 (cfg)->s2cfg.record_faults)
> > +#define PTW_RECORD_FAULT(ptw_info, cfg) (((ptw_info).stage == SMMU_STAGE_1 && \
> > +                                        (cfg)->record_faults) || \
> > +                                        ((ptw_info).stage == SMMU_STAGE_2 && \
> > +                                        (cfg)->s2cfg.record_faults))
> >  
> >  /**
> >   * smmuv3_trigger_irq - pulse @irq if enabled and update
> > @@ -260,6 +261,9 @@ static void smmuv3_init_regs(SMMUv3State *s)
> >      /* Based on sys property, the stages supported in smmu will be advertised.*/
> >      if (s->stage && !strcmp("2", s->stage)) {
> >          s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S2P, 1);
> > +    } else if (s->stage && !strcmp("nested", s->stage)) {
> > +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S1P, 1);
> > +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S2P, 1);
> >      } else {
> >          s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S1P, 1);
> >      }
> > @@ -422,8 +426,6 @@ static bool s2_pgtable_config_valid(uint8_t sl0, uint8_t t0sz, uint8_t gran)
> >  
> >  static int decode_ste_s2_cfg(SMMUTransCfg *cfg, STE *ste)
> >  {
> > -    cfg->stage = SMMU_STAGE_2;
> > -
> >      if (STE_S2AA64(ste) == 0x0) {
> >          qemu_log_mask(LOG_UNIMP,
> >                        "SMMUv3 AArch32 tables not supported\n");
> > @@ -506,6 +508,27 @@ bad_ste:
> >      return -EINVAL;
> >  }
> >  
> > +static void decode_ste_config(SMMUTransCfg *cfg, uint32_t config)
> > +{
> > +
> > +    if (STE_CFG_ABORT(config)) {
> > +        cfg->aborted = true;
> > +        return;
> > +    }
> > +    if (STE_CFG_BYPASS(config)) {
> > +        cfg->bypassed = true;
> > +        return;
> > +    }
> > +
> > +    if (STE_CFG_S1_ENABLED(config)) {
> > +        cfg->stage = SMMU_STAGE_1;
> > +    }
> > +
> > +    if (STE_CFG_S2_ENABLED(config)) {
> > +        cfg->stage |= SMMU_STAGE_2;
> > +    }
> > +}
> > +
> >  /* Returns < 0 in case of invalid STE, 0 otherwise */
> >  static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
> >                        STE *ste, SMMUEventInfo *event)
> > @@ -522,13 +545,9 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
> >  
> >      config = STE_CONFIG(ste);
> >  
> > -    if (STE_CFG_ABORT(config)) {
> > -        cfg->aborted = true;
> > -        return 0;
> > -    }
> > +    decode_ste_config(cfg, config);
> >  
> > -    if (STE_CFG_BYPASS(config)) {
> > -        cfg->bypassed = true;
> > +    if (cfg->aborted || cfg->bypassed) {
> >          return 0;
> >      }
> >  
> > @@ -701,7 +720,6 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
> >  
> >      /* we support only those at the moment */
> >      cfg->aa64 = true;
> > -    cfg->stage = SMMU_STAGE_1;
> >  
> >      cfg->oas = oas2bits(CD_IPS(cd));
> >      cfg->oas = MIN(oas2bits(SMMU_IDR5_OAS), cfg->oas);
> > @@ -901,7 +919,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
> >              event->u.f_walk_eabt.addr2 = ptw_info.addr;
> >              break;
> >          case SMMU_PTW_ERR_TRANSLATION:
> > -            if (PTW_RECORD_FAULT(cfg)) {
> > +            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
> >                  event->type = SMMU_EVT_F_TRANSLATION;
> >                  event->u.f_translation.addr = addr;
> >                  event->u.f_translation.addr2 = ptw_info.addr;
> > @@ -910,7 +928,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
> >              }
> >              break;
> >          case SMMU_PTW_ERR_ADDR_SIZE:
> > -            if (PTW_RECORD_FAULT(cfg)) {
> > +            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
> >                  event->type = SMMU_EVT_F_ADDR_SIZE;
> >                  event->u.f_addr_size.addr = addr;
> >                  event->u.f_addr_size.addr2 = ptw_info.addr;
> > @@ -919,7 +937,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
> >              }
> >              break;
> >          case SMMU_PTW_ERR_ACCESS:
> > -            if (PTW_RECORD_FAULT(cfg)) {
> > +            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
> >                  event->type = SMMU_EVT_F_ACCESS;
> >                  event->u.f_access.addr = addr;
> >                  event->u.f_access.addr2 = ptw_info.addr;
> > @@ -928,7 +946,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
> >              }
> >              break;
> >          case SMMU_PTW_ERR_PERMISSION:
> > -            if (PTW_RECORD_FAULT(cfg)) {
> > +            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
> >                  event->type = SMMU_EVT_F_PERMISSION;
> >                  event->u.f_permission.addr = addr;
> >                  event->u.f_permission.addr2 = ptw_info.addr;
> Thanks
> 
> Eric
> 

