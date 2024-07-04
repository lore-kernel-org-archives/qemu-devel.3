Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DEAC3271F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 18:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPRKd-0004w6-6n; Thu, 04 Jul 2024 14:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPRKb-0004pq-C9
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:37:21 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPRKQ-0006Kr-Cj
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:37:21 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-35f06861ae6so551303f8f.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 11:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720118229; x=1720723029; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=iMf1a2w7VycJ9es19fvo3ydFWICUzfaziKIWRKUyz3Q=;
 b=c8XMLyHiY8UDtXWHG7RwF7N++M+323uwKqJzew389Qm6hTaf4KWYpGbN/8SQUXK8PG
 Xe09Tk6RNZbrtSALrFzYsaPpzkToYjTLyjkKb2PlwDXoHysVFxyDDcXsHN06iLHpyx51
 lK9YbHe7C02kHmjvDS9dwW7H9GrCAufj6jjQMga3j3WAU+B0+M+DQwK+E/g+aJAzrBAA
 HoHsYfZiUzER+wuP8folpVRSaSqI9lo5AQmP/xtO1Fo1PbC5kmIt7Gj5+xFqGIQ/00x9
 KAayk3QCIXgiYYFnm87uWD3t2qy4ZCCy1PAE4jJKIrYFSeF2gilnBvcSNM3cz0hWqpqd
 uRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720118229; x=1720723029;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iMf1a2w7VycJ9es19fvo3ydFWICUzfaziKIWRKUyz3Q=;
 b=twi9xtbRI2GbjF2ZRx/QgIfNJMt/vUB1KoOkYE3A9pEIsNEM8/9e2mppCFLDeOJueB
 AdTn6gfnR6Q32jArHzQoU5dkhy+Gs9HWkkQPoV9O/WorobytDVyl+qXBQU0zWu8ZGyup
 fQ2u75pJm/+hby7fLWmPC8yJEwfCnL4rh+HZ7t1Mxf7EIaIy4cGw6xdb7aGygflZUA4z
 Q9MM5JMimACZB3nyn2eJTqjeLScOb8oONSCJ1PGmknhkaxxm7tnpv65w2gOV7Rm6nxot
 ikrMVQWls4MZPCu13P89Q92a1VjLG+Crfdz1RhF+5KPNhiayAyFBL/ja+p1/TbMP+kC2
 lCTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2pHTXbyymAXHrZpKpUADh/OmM0EDJWdjBt0KzETMdjQMVdu9yCynZExmUgVsBUcVXCqdNUDl+GfLeeOCtslqR+er16Xw=
X-Gm-Message-State: AOJu0YzCg8VoPS8AoqvCk+c9/u3u7UbFETI7dlVtS2Kv+09+ISjxepH4
 nO61FPMNF0/5CYr1PlnHtcg+RMInux5bo/AcZusx4x12sgQeysHyWH7Ac+tAwOBLFdwou24x597
 9
X-Google-Smtp-Source: AGHT+IErKuRR4tcYeAJJxFKJdMpKQelJaP0GUTVGnGsivPfYaOWuPGzg2OVSKUNVmrrOJp18x6rBwg==
X-Received: by 2002:a5d:48c9:0:b0:367:8a39:85ce with SMTP id
 ffacd0b85a97d-3679dd806a8mr1754794f8f.70.1720118228471; 
 Thu, 04 Jul 2024 11:37:08 -0700 (PDT)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367956ca37asm4535626f8f.75.2024.07.04.11.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 11:37:08 -0700 (PDT)
Date: Thu, 4 Jul 2024 19:37:21 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v4 19/19] hw/arm/smmu: Refactor SMMU OAS
Message-ID: <20240704183721.GP1693268@myrica>
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-20-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701110241.2005222-20-smostafa@google.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=jean-philippe@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Mon, Jul 01, 2024 at 11:02:41AM +0000, Mostafa Saleh wrote:
> SMMUv3 OAS is currently hardcoded in the code to 44 bits, for nested
> configurations that can be a problem, as stage-2 might be shared with
> the CPU which might have different PARANGE, and according to SMMU manual
> ARM IHI 0070F.b:
>     6.3.6 SMMU_IDR5, OAS must match the system physical address size.
> 
> This patch doesn't change the SMMU OAS, but refactors the code to
> make it easier to do that:
> - Rely everywhere on IDR5 for reading OAS instead of using the
>   SMMU_IDR5_OAS macro, so, it is easier just to change IDR5 and
>   it propagages correctly.
> - Add additional checks when OAS is greater than 48bits.
> - Remove unused functions/macros: pa_range/MAX_PA.
> 
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  hw/arm/smmu-common.c     |  7 ++++---
>  hw/arm/smmuv3-internal.h | 13 -------------
>  hw/arm/smmuv3.c          | 35 ++++++++++++++++++++++++++++-------
>  3 files changed, 32 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index faba4adc49..2cff80e5dd 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -452,7 +452,8 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
>      inputsize = 64 - tt->tsz;
>      level = 4 - (inputsize - 4) / stride;
>      indexmask = VMSA_IDXMSK(inputsize, stride, level);
> -    baseaddr = extract64(tt->ttb, 0, 48);
> +
> +    baseaddr = extract64(tt->ttb, 0, cfg->oas);
>      baseaddr &= ~indexmask;
>  
>      while (level < VMSA_LEVELS) {
> @@ -576,8 +577,8 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
>       * Get the ttb from concatenated structure.
>       * The offset is the idx * size of each ttb(number of ptes * (sizeof(pte))
>       */
> -    uint64_t baseaddr = extract64(cfg->s2cfg.vttb, 0, 48) + (1 << stride) *
> -                                  idx * sizeof(uint64_t);
> +    uint64_t baseaddr = extract64(cfg->s2cfg.vttb, 0, cfg->s2cfg.eff_ps) +
> +                                  (1 << stride) * idx * sizeof(uint64_t);
>      dma_addr_t indexmask = VMSA_IDXMSK(inputsize, stride, level);
>  
>      baseaddr &= ~indexmask;
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index 0f3ecec804..0ebf2eebcf 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -602,19 +602,6 @@ static inline int oas2bits(int oas_field)
>      return -1;
>  }
>  
> -static inline int pa_range(STE *ste)
> -{
> -    int oas_field = MIN(STE_S2PS(ste), SMMU_IDR5_OAS);
> -
> -    if (!STE_S2AA64(ste)) {
> -        return 40;
> -    }
> -
> -    return oas2bits(oas_field);
> -}
> -
> -#define MAX_PA(ste) ((1 << pa_range(ste)) - 1)
> -
>  /* CD fields */
>  
>  #define CD_VALID(x)   extract32((x)->word[0], 31, 1)
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 88378e83dd..6954b385c7 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -410,10 +410,10 @@ static bool s2t0sz_valid(SMMUTransCfg *cfg)
>      }
>  
>      if (cfg->s2cfg.granule_sz == 16) {
> -        return (cfg->s2cfg.tsz >= 64 - oas2bits(SMMU_IDR5_OAS));
> +        return (cfg->s2cfg.tsz >= 64 - cfg->s2cfg.eff_ps);
>      }
>  
> -    return (cfg->s2cfg.tsz >= MAX(64 - oas2bits(SMMU_IDR5_OAS), 16));
> +    return (cfg->s2cfg.tsz >= MAX(64 - cfg->s2cfg.eff_ps, 16));
>  }
>  
>  /*
> @@ -434,8 +434,11 @@ static bool s2_pgtable_config_valid(uint8_t sl0, uint8_t t0sz, uint8_t gran)
>      return nr_concat <= VMSA_MAX_S2_CONCAT;
>  }
>  
> -static int decode_ste_s2_cfg(SMMUTransCfg *cfg, STE *ste)
> +static int decode_ste_s2_cfg(SMMUv3State *s, SMMUTransCfg *cfg,
> +                             STE *ste)
>  {
> +    uint8_t oas = FIELD_EX32(s->idr[5], IDR5, OAS);
> +
>      if (STE_S2AA64(ste) == 0x0) {
>          qemu_log_mask(LOG_UNIMP,
>                        "SMMUv3 AArch32 tables not supported\n");
> @@ -468,7 +471,15 @@ static int decode_ste_s2_cfg(SMMUTransCfg *cfg, STE *ste)
>      }
>  
>      /* For AA64, The effective S2PS size is capped to the OAS. */
> -    cfg->s2cfg.eff_ps = oas2bits(MIN(STE_S2PS(ste), SMMU_IDR5_OAS));
> +    cfg->s2cfg.eff_ps = oas2bits(MIN(STE_S2PS(ste), oas));
> +    /*
> +     * For SMMUv3.1 and later, when OAS == IAS == 52, the stage 2 input
> +     * range is further limited to 48 bits unless STE.S2TG indicates a
> +     * 64KB granule.
> +     */
> +    if (cfg->s2cfg.granule_sz != 16) {
> +        cfg->s2cfg.eff_ps = MIN(cfg->s2cfg.eff_ps, 48);
> +    }
>      /*
>       * It is ILLEGAL for the address in S2TTB to be outside the range
>       * described by the effective S2PS value.
> @@ -544,6 +555,7 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
>                        STE *ste, SMMUEventInfo *event)
>  {
>      uint32_t config;
> +    uint8_t oas = FIELD_EX32(s->idr[5], IDR5, OAS);
>      int ret;
>  
>      if (!STE_VALID(ste)) {
> @@ -587,8 +599,8 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
>           * Stage-1 OAS defaults to OAS even if not enabled as it would be used
>           * in input address check for stage-2.
>           */
> -        cfg->oas = oas2bits(SMMU_IDR5_OAS);
> -        ret = decode_ste_s2_cfg(cfg, ste);
> +        cfg->oas = oas2bits(oas);
> +        ret = decode_ste_s2_cfg(s, cfg, ste);
>          if (ret) {
>              goto bad_ste;
>          }
> @@ -714,6 +726,7 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
>      int i;
>      SMMUTranslationStatus status;
>      SMMUTLBEntry *entry;
> +    uint8_t oas = FIELD_EX32(s->idr[5], IDR5, OAS);
>  
>      if (!CD_VALID(cd) || !CD_AARCH64(cd)) {
>          goto bad_cd;
> @@ -732,7 +745,7 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
>      cfg->aa64 = true;
>  
>      cfg->oas = oas2bits(CD_IPS(cd));
> -    cfg->oas = MIN(oas2bits(SMMU_IDR5_OAS), cfg->oas);
> +    cfg->oas = MIN(oas2bits(oas), cfg->oas);
>      cfg->tbi = CD_TBI(cd);
>      cfg->asid = CD_ASID(cd);
>      cfg->affd = CD_AFFD(cd);
> @@ -761,6 +774,14 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
>              goto bad_cd;
>          }
>  
> +        /*
> +         * An address greater than 48 bits in size can only be output from a
> +         * TTD when, in SMMUv3.1 and later, the effective IPS is 52 and a 64KB
> +         * granule is in use for that translation table
> +         */
> +        if (tt->granule_sz != 16) {
> +            cfg->oas = MIN(cfg->oas, 48);
> +        }
>          tt->tsz = tsz;
>          tt->ttb = CD_TTB(cd, i);
>  
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 

