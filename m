Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C06FC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 15:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU6Zj-0006lf-9n; Wed, 17 Jul 2024 11:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU6Zi-0006l5-44
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:28:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU6Zf-0001xv-RF
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721230090;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z3lTkBzj+LIVNyyWxcwo+WHox8RYeSSukUvm7LaVKhU=;
 b=HMkFYjVXbZXr0cbs7txnGjV3g2fFOY8IgSRyc19Db8taTJC9BDRJiW//Rl6GSibVbVB7FH
 k5q3POV0ZlhLRzhdsuiHZ5ZZx/tydzmbGG5gGQDZYCrDPD8g876YDn4evtuqqHFae/KwSP
 Mf3YclZ56b25coBk4m27OZlU2qTQn/8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-JeB5tqUAN8Covh3zoQ_xaQ-1; Wed, 17 Jul 2024 11:28:09 -0400
X-MC-Unique: JeB5tqUAN8Covh3zoQ_xaQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-79f06a617a4so182538085a.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 08:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721230088; x=1721834888;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Z3lTkBzj+LIVNyyWxcwo+WHox8RYeSSukUvm7LaVKhU=;
 b=Zkk0ozRZA9IoiaeIZa38SakqN0oJH6pGeLaGvpeLKr6OVOnSi7QSl0MIXvmCuf+BNR
 2wCG5zh0qqjui/HuWZ6MpmEJnp/TYkPJvn8x3/qPBpOyxEL3DCu7inv8ZROJBDu7LSxc
 gtydkoxigf0da14ybfJ76maqiED7JZizvGO9FCs7M0DhsHef7A7oObtsJMGoCDsFkTR6
 klLbRzfDtuX1om+3I6KtggR/UovM3Anaw2mXGw0ve0qSOOLlNKySj+otPBh9sHnKAum+
 VI3lnxMvpEeiTFzFjKmbqXPm5MvZQPb+bDwCyAKmT798kznnG0N/6HC3xTXabbMfnP/m
 UNnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv/cKgtWzOw/4oDm6dhuL4L+1zjlRRsCo/9WmRXYi6ZILPeuRwtQym2+26+zQAfN50oSesvuPiVQgaWVeioiRAewFACxU=
X-Gm-Message-State: AOJu0Yw8/koH2HrWDzb7cpRckYI9LeESSk3eLBZsR2HCKq5KIIeklUfU
 zqJer+1C4TELvGo/8bJhSpbovppr5tVS+l6KJYT15N9d0D9eBWSZsXFoBFlR+YguTlSJOqNiNk/
 rIrJ+1t5LCBPLMRlkFkodLYgjeGt4uyqXyP/UK9lj6S039mCbZmT8
X-Received: by 2002:a05:620a:2547:b0:79e:f932:7ca7 with SMTP id
 af79cd13be357-7a186eb69eamr364070885a.29.1721230088313; 
 Wed, 17 Jul 2024 08:28:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxjBWkqyHv7PVvU2le6CDYykTR4uIzJVVOknfwOpY6HneiuGDnME3Sv2lNhd4MRoHtvPJg2g==
X-Received: by 2002:a05:620a:2547:b0:79e:f932:7ca7 with SMTP id
 af79cd13be357-7a186eb69eamr364065585a.29.1721230087911; 
 Wed, 17 Jul 2024 08:28:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a160b92ba7sm414925685a.27.2024.07.17.08.28.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 08:28:07 -0700 (PDT)
Message-ID: <da5e2061-14e2-43dc-aa9b-0eccf4abba26@redhat.com>
Date: Wed, 17 Jul 2024 17:28:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/18] hw/arm/smmu-common: Rework TLB lookup for nesting
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240715084519.1189624-1-smostafa@google.com>
 <20240715084519.1189624-10-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240715084519.1189624-10-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 7/15/24 10:45, Mostafa Saleh wrote:
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
>
> Also, drop aligning the iova to avoid over-aligning in case the iova
> is cached with a smaller granule, the TLB lookup will align the iova
> anyway for each granule and level, and the page table walker doesn't
> consider the page offset bits.
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>


Eric

> ---
>  hw/arm/smmu-common.c | 64 +++++++++++++++++++++++++++++---------------
>  1 file changed, 43 insertions(+), 21 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 21982621c0..f224e9c1e0 100644
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
> @@ -569,18 +601,21 @@ int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
>  SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
>                               IOMMUAccessFlags flag, SMMUPTWEventInfo *info)
>  {
> -    uint64_t page_mask, aligned_addr;
>      SMMUTLBEntry *cached_entry = NULL;
>      SMMUTransTableInfo *tt;
>      int status;
>  
>      /*
> -     * Combined attributes used for TLB lookup, as only one stage is supported,
> -     * it will hold attributes based on the enabled stage.
> +     * Combined attributes used for TLB lookup, holds the attributes for
> +     * the input stage.
>       */
>      SMMUTransTableInfo tt_combined;
>  
> -    if (cfg->stage == SMMU_STAGE_1) {
> +    if (cfg->stage == SMMU_STAGE_2) {
> +        /* Stage2. */
> +        tt_combined.granule_sz = cfg->s2cfg.granule_sz;
> +        tt_combined.tsz = cfg->s2cfg.tsz;
> +    } else {
>          /* Select stage1 translation table. */
>          tt = select_tt(cfg, addr);
>          if (!tt) {
> @@ -590,22 +625,9 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
>          }
>          tt_combined.granule_sz = tt->granule_sz;
>          tt_combined.tsz = tt->tsz;
> -
> -    } else {
> -        /* Stage2. */
> -        tt_combined.granule_sz = cfg->s2cfg.granule_sz;
> -        tt_combined.tsz = cfg->s2cfg.tsz;
>      }
>  
> -    /*
> -     * TLB lookup looks for granule and input size for a translation stage,
> -     * as only one stage is supported right now, choose the right values
> -     * from the configuration.
> -     */
> -    page_mask = (1ULL << tt_combined.granule_sz) - 1;
> -    aligned_addr = addr & ~page_mask;
> -
> -    cached_entry = smmu_iotlb_lookup(bs, cfg, &tt_combined, aligned_addr);
> +    cached_entry = smmu_iotlb_lookup(bs, cfg, &tt_combined, addr);
>      if (cached_entry) {
>          if ((flag & IOMMU_WO) && !(cached_entry->entry.perm & IOMMU_WO)) {
>              info->type = SMMU_PTW_ERR_PERMISSION;
> @@ -616,7 +638,7 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
>      }
>  
>      cached_entry = g_new0(SMMUTLBEntry, 1);
> -    status = smmu_ptw(cfg, aligned_addr, flag, cached_entry, info);
> +    status = smmu_ptw(cfg, addr, flag, cached_entry, info);
>      if (status) {
>              g_free(cached_entry);
>              return NULL;


