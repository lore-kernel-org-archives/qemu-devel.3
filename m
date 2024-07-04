Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9498BC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 18:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPRJm-00036D-9g; Thu, 04 Jul 2024 14:36:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPRJk-00035d-PR
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:36:28 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPRJj-0005T8-3a
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:36:28 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-424ad991c1cso7794095e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 11:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720118186; x=1720722986; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jtchTFG44Pvi0xc80JWiSIr27cVk869TIYOe8ewITfk=;
 b=ZGZBgvBSGqJUh5PkT9GAzdsjKs+iYDCT/Tmz1hCDNR6gGJfjkGqVft4OJS0agxlAky
 9G/i6DNaaTZ5JQt7J850PdqU8iN5oemtqwoklLuiowe4hoqLdYOIfqJZY75iKgsYFKEW
 MlECfUbVWZTTWeYsenLRJkJ0yQOJh4GinvvvhG95agbDFW4EQw2TDKHQ0OR2VK4sfnf4
 AYXM5BinScEbxaxu8MaDaSrtNKvTbgrqy8bn9bZPtdnF5JlisjB8hfbqQmZaQoBwz5fX
 RxwNH54Y8m6sCz3f0dz5EqlI1j63e0YUNgKfH+MxQ2oUj8pq9JMe9jPLvS/6eMSEAoM8
 /eqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720118186; x=1720722986;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jtchTFG44Pvi0xc80JWiSIr27cVk869TIYOe8ewITfk=;
 b=HXi3293KP4g5l+M+V4ISBMt2Y7N6qbIWbelUR7vR2L/Hp0oflOLJQcEfDXt8sgTyOU
 dUFOeH2EjNufLFpxOvkcWu0TmElM7GutZk2lSYGF/rEkZB4BEh2Lw090DutmGbe258ZG
 wdW6abcl5jI4tb0/nvQyalQ+EPIo+8VFr1+e3YQ8bphj+ZBaGCwFJKqpmwR7dBaJ30od
 ztP0q3iA68DbrUIUwS6KVxgqjBoYS+mmOzLmQ1l8XnhtQoJLKBRrxXvY38URCqVdf7P7
 8gkyoDt5pCFxaTLC6VKCqvjgEPTmJRB1/9RnpFn7ml7ma3RdtNz9xr56TW7hZDMQiPMn
 PAwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPJp5sPVf5nbfKVPCjuTwx2fYhSSopuCaKVxlE/MoRPXkA0KoRiUSNog76WvSltJYAvhzcgasUQSoshOw/Hop1QiOjzwQ=
X-Gm-Message-State: AOJu0YySINIrD8EMEuTH5f51JEw8vA3SoQ1tB21CI5oPJCi+4yP8yFRo
 xQ9DK8zciCMOp6XqIK/+I9sBqgvXLesvhSajHpcZUh2e9mPSRr2+12a4PqiFcjHfftIXBXYqE4N
 z
X-Google-Smtp-Source: AGHT+IFjppCCHp9hGEa/evewe8nL2nya5EaB6eXY4LPE+mw35bR99F6MN/2QN4lwO5FRk5PBuzUMig==
X-Received: by 2002:a5d:4207:0:b0:367:9cd5:c608 with SMTP id
 ffacd0b85a97d-3679dd31836mr2020532f8f.36.1720118185853; 
 Thu, 04 Jul 2024 11:36:25 -0700 (PDT)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367900fd1e5sm5669181f8f.63.2024.07.04.11.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 11:36:25 -0700 (PDT)
Date: Thu, 4 Jul 2024 19:36:38 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v4 17/19] hw/arm/smmuv3: Support and advertise nesting
Message-ID: <20240704183638.GN1693268@myrica>
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-18-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701110241.2005222-18-smostafa@google.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 01, 2024 at 11:02:39AM +0000, Mostafa Saleh wrote:
> Everything is in place, consolidate parsing of STE cfg and setting
> translation stage.
> 
> Advertise nesting if stage requested is "nested".
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  hw/arm/smmuv3.c | 35 ++++++++++++++++++++++++++---------
>  1 file changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 6c18dc0acf..807f26f2da 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -261,6 +261,9 @@ static void smmuv3_init_regs(SMMUv3State *s)
>      /* Based on sys property, the stages supported in smmu will be advertised.*/
>      if (s->stage && !strcmp("2", s->stage)) {
>          s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S2P, 1);
> +    } else if (s->stage && !strcmp("nested", s->stage)) {
> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S1P, 1);
> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S2P, 1);
>      } else {
>          s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S1P, 1);
>      }
> @@ -425,8 +428,6 @@ static bool s2_pgtable_config_valid(uint8_t sl0, uint8_t t0sz, uint8_t gran)
>  
>  static int decode_ste_s2_cfg(SMMUTransCfg *cfg, STE *ste)
>  {
> -    cfg->stage = SMMU_STAGE_2;
> -
>      if (STE_S2AA64(ste) == 0x0) {
>          qemu_log_mask(LOG_UNIMP,
>                        "SMMUv3 AArch32 tables not supported\n");
> @@ -509,6 +510,27 @@ bad_ste:
>      return -EINVAL;
>  }
>  
> +static void decode_ste_config(SMMUTransCfg *cfg, uint32_t config)
> +{
> +
> +    if (STE_CFG_ABORT(config)) {
> +        cfg->aborted = true;
> +        return;
> +    }
> +    if (STE_CFG_BYPASS(config)) {
> +        cfg->bypassed = true;
> +        return;
> +    }
> +
> +    if (STE_CFG_S1_ENABLED(config)) {
> +        cfg->stage = SMMU_STAGE_1;
> +    }
> +
> +    if (STE_CFG_S2_ENABLED(config)) {
> +        cfg->stage |= SMMU_STAGE_2;
> +    }
> +}
> +
>  /* Returns < 0 in case of invalid STE, 0 otherwise */
>  static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
>                        STE *ste, SMMUEventInfo *event)
> @@ -525,13 +547,9 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
>  
>      config = STE_CONFIG(ste);
>  
> -    if (STE_CFG_ABORT(config)) {
> -        cfg->aborted = true;
> -        return 0;
> -    }
> +    decode_ste_config(cfg, config);
>  
> -    if (STE_CFG_BYPASS(config)) {
> -        cfg->bypassed = true;
> +    if (cfg->aborted || cfg->bypassed) {
>          return 0;
>      }
>  
> @@ -704,7 +722,6 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
>  
>      /* we support only those at the moment */
>      cfg->aa64 = true;
> -    cfg->stage = SMMU_STAGE_1;
>  
>      cfg->oas = oas2bits(CD_IPS(cd));
>      cfg->oas = MIN(oas2bits(SMMU_IDR5_OAS), cfg->oas);
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 

