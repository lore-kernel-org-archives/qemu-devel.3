Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D665C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 13:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s93Xs-0005tc-W9; Mon, 20 May 2024 09:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s93Xq-0005sq-PW
 for qemu-devel@nongnu.org; Mon, 20 May 2024 09:59:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s93Xo-0000zw-Od
 for qemu-devel@nongnu.org; Mon, 20 May 2024 09:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716213555;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W/2cXgJlqem1GpJTLgOvNgLkMQei9LGhhfTBhbVymVM=;
 b=L1Yn38ypbZyC/s0Xt1kV3yN7yFhKaeazfOVyTyo/iNjkjdqKv67CyVVHaYgehh15gVJZ5E
 gGvL0EuShwlA4z44UhXQSf7t31F/O9yWFzA7yuFojmqJvZn6jDGT1NQBn44/QUbp93JH1R
 6TfBS8Y4pOv8VXab1EtXK16zYXnnQnM=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-vNtdNnwlNCqxOf4h5ojWHg-1; Mon, 20 May 2024 09:59:14 -0400
X-MC-Unique: vNtdNnwlNCqxOf4h5ojWHg-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-de468af2b73so21078371276.0
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 06:59:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716213553; x=1716818353;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W/2cXgJlqem1GpJTLgOvNgLkMQei9LGhhfTBhbVymVM=;
 b=eMZ9yOMuT2ixSFs+WrKV6ygnVQqkuMLnsU3jzdvAYJlln/yO01iRDDQrAS3yoXWn75
 +iZBHtu2GO8SHjeKv3NjSTRt0T0J5K2/1aqm+gmcpbF0I842YjaHd6C0oGJcXgLqX5Lu
 U/YfjYuWwaHNz39g0P3Kn2dKaOzdXg/c3Q31ilJiSQCvdnmSDJ/tikNwqPCtZ97bljEq
 qRAWhsI2c66PPB/uXnGbRQLMmHGpstrlHJiLBIYMuryF0ZUC1cmVe1xxofKbBXH38Aax
 Eo28n020WjpT4IbFo/cLqRzcL1gU92o+Su40dA4+ajG9EzzUpr5Neylpw+yHEhCgN66S
 6DVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0quX+1wrR66QZHpRY5+9pPlA/tZkrxb6Zt4v1I8zwPkLkU6JqbDPqMdbmbgXyTkPJNXTRXQajAJSDRvptSFvgJJiH5J0=
X-Gm-Message-State: AOJu0YxLozWBZVuxH5Qd4iBz/iv8sGilevm/XRzxbUWaEP76XI/T0fQv
 HlncxJ5PaoIl//BtLPWAW8YrynlHe5B4TnJ9A+uiEucTpp8+jqNAWzTVzeNWQSop4g/Hmtfgmfs
 SR8QCBAwSUHGC0cK6rZZB+tQG6YSgi0/MsF+Y5X54i/Vx4EOlaZTp
X-Received: by 2002:a25:d68d:0:b0:df4:43f6:5b75 with SMTP id
 3f1490d57ef6-df443f65dd6mr16503948276.24.1716213553665; 
 Mon, 20 May 2024 06:59:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmzwxgjkzSN+eZfTFjsjbdsWtEHdU7vtUHi+FTHwPEh2YZBkTYouiDkEV12Eiz7m8CJNxbkg==
X-Received: by 2002:a25:d68d:0:b0:df4:43f6:5b75 with SMTP id
 3f1490d57ef6-df443f65dd6mr16503926276.24.1716213553254; 
 Mon, 20 May 2024 06:59:13 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43df550c10fsm148338501cf.43.2024.05.20.06.59.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 May 2024 06:59:12 -0700 (PDT)
Message-ID: <d254ae5a-baf9-49c6-a28c-fe7313a45311@redhat.com>
Date: Mon, 20 May 2024 15:59:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 16/18] hw/arm/smmu: Refactor SMMU OAS
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-17-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240429032403.74910-17-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
On 4/29/24 05:24, Mostafa Saleh wrote:
> SMMUv3 OAS is hardcoded to 44 bits, for nested configurations that
is currently hardcoded in the code.
> can be a problem as stage-2 might be shared with the CPU which might
> have different PARANGE, and according to SMMU manual ARM IHI 0070F.b:
>     6.3.6 SMMU_IDR5, OAS must match the system physical address size.
>
> This patch doesn't change the SMMU OAS, but refactors the code to
> make it easier to do that:
> - Rely everywhere on IDR5 for reading OAS instead of using the macro so
instead of using the SMMU_IDR5_OAS macro.
Also add additional checks when OAS is greater than 48bits
>   it is easier just change IDR5 and it propagages correctly.
> - Remove unused functions/macros: pa_range/MAX_PA
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  hw/arm/smmu-common.c     |  7 ++++---
>  hw/arm/smmuv3-internal.h | 13 -------------
>  hw/arm/smmuv3.c          | 35 ++++++++++++++++++++++++++++-------
>  3 files changed, 32 insertions(+), 23 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 3ed0be05ef..b559878aef 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -434,7 +434,8 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
>      inputsize = 64 - tt->tsz;
>      level = 4 - (inputsize - 4) / stride;
>      indexmask = VMSA_IDXMSK(inputsize, stride, level);
> -    baseaddr = extract64(tt->ttb, 0, 48);
> +
> +    baseaddr = extract64(tt->ttb, 0, cfg->oas);
>      baseaddr &= ~indexmask;
>  
>      while (level < VMSA_LEVELS) {
> @@ -557,8 +558,8 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
>       * Get the ttb from concatenated structure.
>       * The offset is the idx * size of each ttb(number of ptes * (sizeof(pte))
>       */
> -    uint64_t baseaddr = extract64(cfg->s2cfg.vttb, 0, 48) + (1 << stride)
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
> index 8a11e41144..4ac818cf7a 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -408,10 +408,10 @@ static bool s2t0sz_valid(SMMUTransCfg *cfg)
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
> @@ -432,8 +432,11 @@ static bool s2_pgtable_config_valid(uint8_t sl0, uint8_t t0sz, uint8_t gran)
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
> @@ -466,7 +469,15 @@ static int decode_ste_s2_cfg(SMMUTransCfg *cfg, STE *ste)
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
> @@ -542,6 +553,7 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
>                        STE *ste, SMMUEventInfo *event)
>  {
>      uint32_t config;
> +    uint8_t oas = FIELD_EX32(s->idr[5], IDR5, OAS);
>      int ret;
>  
>      if (!STE_VALID(ste)) {
> @@ -585,8 +597,8 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
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
> @@ -712,6 +724,7 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
>      int i;
>      SMMUTranslationStatus status;
>      SMMUTLBEntry *entry;
> +    uint8_t oas = FIELD_EX32(s->idr[5], IDR5, OAS);
>  
>      if (!CD_VALID(cd) || !CD_AARCH64(cd)) {
>          goto bad_cd;
> @@ -730,7 +743,7 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
>      cfg->aa64 = true;
>  
>      cfg->oas = oas2bits(CD_IPS(cd));
> -    cfg->oas = MIN(oas2bits(SMMU_IDR5_OAS), cfg->oas);
> +    cfg->oas = MIN(oas2bits(oas), cfg->oas);
>      cfg->tbi = CD_TBI(cd);
>      cfg->asid = CD_ASID(cd);
>      cfg->affd = CD_AFFD(cd);
> @@ -759,6 +772,14 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
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
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

Eric


