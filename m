Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DE5C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 18:13:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPQwW-0001CN-9s; Thu, 04 Jul 2024 14:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPQwU-0001Bp-Lh
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:12:26 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPQwS-0005QV-VS
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:12:26 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42565697036so12603855e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 11:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720116743; x=1720721543; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TXesRPbPkumApHoZmaR24s0c1P7vUuR8yECnDIGAfTE=;
 b=LiBpeP+fgw1OjWgi8GNtyxb1utv6fsUbaBuqviuvZ+OORHw/dwidWMRCyb/k2wshYJ
 ekfXOo0MIe1d1WJ9JJmUHidWVbyMDjn0m05t2szy7R4n9441/T9wEMnepBWlR0qgPXKO
 PToLEU76JoaS2EAhr4a4vRsE1mChb28CbtCi3QjcIy5pL2s/m+sRQOGL3kHdiuxJUBbg
 ZP3eNcyGDHA+3StzaUhs5YNqhepkUG/SeaLCAMvTHcdPwkW5OMB4sA5qCxTilt2isFrZ
 WQCDyWohbKSTGhuTc5RO20iR6CfirlFb5xKb+scK6OMZGI9OHn8l8XxvpUPI56Hflbg7
 WNGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720116743; x=1720721543;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TXesRPbPkumApHoZmaR24s0c1P7vUuR8yECnDIGAfTE=;
 b=dDPxTN2nTI6bZCJFbt9mZZH0nS2rd0O4rAcUVEQ/Wk5NssY+J4TeI4QE1AsZ7xEJcA
 TS8N5Xgu//AwdIIw1MUB0xXCPAKUEOw69IAbxtKQ9W59OaiNGDk4gSrPrnRevjClttnk
 vYCGthrlSDpaIfoI4bKA7NatQJjbWqu1M0YD+zoOsV/bsRvYwrytGiocyg4SJogEmT3y
 ZXyabafeUZ0deXl+Sf3fU+89iZuaDTYe917RIbhdAApHa2UEval29ugKvoq6MWqHMGy7
 xU+P+F9nn2f2XlxFKy/CKipyADT9uGUeqvsv40NJ6hopJv3zLQf2I7xxSaJc0TC/MG8L
 M8fQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+joL5jNht0nyAc5E32H+fmagNTH4tdrmjhtjeaDw6f8Phxl+DI1TpBTq6q3X0g5BjYXr8eLBN1WWtbRRifimV68tNqnU=
X-Gm-Message-State: AOJu0YwlapprYIuAuddWyYJ01R215RoCYDzPjJTdQ0kJ1T9e6CxhKsBN
 NfuA6+7eoLbr4ZEXc+4Rv82ZRgfkR+UY21M0h0cdSDvnrUqlAeLkxleKLypYx0U=
X-Google-Smtp-Source: AGHT+IGirTrbqLd+pfV1OysBTuGjDi1zFi5uEmNsa8X/0BB4iUhkXhsVYvNyH1HQJCOj40UXBoRCPg==
X-Received: by 2002:a05:600c:218e:b0:424:acbf:c068 with SMTP id
 5b1f17b1804b1-4264b162dcamr25056965e9.16.1720116743001; 
 Thu, 04 Jul 2024 11:12:23 -0700 (PDT)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264d5101ffsm19102105e9.16.2024.07.04.11.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 11:12:22 -0700 (PDT)
Date: Thu, 4 Jul 2024 19:12:35 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v4 09/19] hw/arm/smmu-common: Rework TLB lookup for nesting
Message-ID: <20240704181235.GF1693268@myrica>
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-10-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701110241.2005222-10-smostafa@google.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32b.google.com
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

On Mon, Jul 01, 2024 at 11:02:31AM +0000, Mostafa Saleh wrote:
> In the next patch, combine_tlb() will be added which combines 2 TLB
> entries into one for nested translations, which chooses the granule
> and level from the smallest entry.
> 
> This means that with nested translation, an entry can be cached with
> the granule of stage-2 and not stage-1.
> 
> However, currently, the lookup for an IOVA is done with input stage
> granule, which is stage-1 for nested configuration, which will not
> work with the above logic.
> This patch reworks lookup in that case, so it falls back to stage-2
> granule if no entry is found using stage-1 granule.

Why not initialize tt_combined to the minimum granule of stages 1 and 2?
It looks like you introduced it for this. I'm wondering if we lookup the
wrong IOVA if changing the granule size after the address is masked in
smmu_translate()

Thanks,
Jean

> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  hw/arm/smmu-common.c | 36 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 34 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 21982621c0..0840b5cffd 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -66,8 +66,10 @@ SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
>      return key;
>  }
>  
> -SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> -                                SMMUTransTableInfo *tt, hwaddr iova)
> +static SMMUTLBEntry *smmu_iotlb_lookup_all_levels(SMMUState *bs,
> +                                                  SMMUTransCfg *cfg,
> +                                                  SMMUTransTableInfo *tt,
> +                                                  hwaddr iova)
>  {
>      uint8_t tg = (tt->granule_sz - 10) / 2;
>      uint8_t inputsize = 64 - tt->tsz;
> @@ -88,6 +90,36 @@ SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
>          }
>          level++;
>      }
> +    return entry;
> +}
> +
> +/**
> + * smmu_iotlb_lookup - Look up for a TLB entry.
> + * @bs: SMMU state which includes the TLB instance
> + * @cfg: Configuration of the translation
> + * @tt: Translation table info (granule and tsz)
> + * @iova: IOVA address to lookup
> + *
> + * returns a valid entry on success, otherwise NULL.
> + * In case of nested translation, tt can be updated to include
> + * the granule of the found entry as it might different from
> + * the IOVA granule.
> + */
> +SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
> +                                SMMUTransTableInfo *tt, hwaddr iova)
> +{
> +    SMMUTLBEntry *entry = NULL;
> +
> +    entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova);
> +    /*
> +     * For nested translation also try the s2 granule, as the TLB will insert
> +     * it if the size of s2 tlb entry was smaller.
> +     */
> +    if (!entry && (cfg->stage == SMMU_NESTED) &&
> +        (cfg->s2cfg.granule_sz != tt->granule_sz)) {
> +        tt->granule_sz = cfg->s2cfg.granule_sz;
> +        entry = smmu_iotlb_lookup_all_levels(bs, cfg, tt, iova);
> +    }
>  
>      if (entry) {
>          cfg->iotlb_hits++;
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 

