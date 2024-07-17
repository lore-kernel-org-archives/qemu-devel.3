Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878F0C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 15:29:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU6aY-0007h0-FD; Wed, 17 Jul 2024 11:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU6aX-0007cv-Cp
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:29:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU6aV-0003AZ-BZ
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721230142;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dqkFYoMCBmaYlBCn43LVLHVoG26nrATtJOLsRiV6fxo=;
 b=WuKmAwsdTWK3i52TuCyu/PeiY15jEr70lSLY0Oct48R9XkcNpUlmcZ5QRGqVEtOPnOAXih
 FK8HimpWYDr66gMCziPoM6AB8EKyUGThO6CbZ0Uj+Ild0odbtuzKhLY+NJK/SJX3ONP8Pg
 d7OeSVQUOo0LM6hAqGi+lC3yAZ4lGo4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-k_4951pENMyLFoBQP3T-BQ-1; Wed, 17 Jul 2024 11:29:01 -0400
X-MC-Unique: k_4951pENMyLFoBQP3T-BQ-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-79efed0e796so198807585a.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 08:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721230140; x=1721834940;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dqkFYoMCBmaYlBCn43LVLHVoG26nrATtJOLsRiV6fxo=;
 b=fL4ljwA5mMylWh8rAnHqD8vrzq7fVQlr+rwc/gyo4PtS+WC/OFJiHGcpdnY0mu4poF
 Qv44Lx3hz5BvU0EQK7Dv6ZDfewGGdk0oTiNm9A3k7ytverxkUJkfSFw8fMp5Ee/H5mEs
 lw3Da1W2nmo18R55ORPsEX2Zoo4UoRXRml3LSy14sErYrVn9V+4z40PR3DX53jH7xBr8
 kNgPKFE+FTOKQN7L13xGwhHEZFaiKww2sqQbVYbjxIJvbZ6eJPh2BvN5LEEf72tcU+Ok
 5fcaVQM+YwwWzOinfZYwqXNd/F23sz8MvhgMMfJdjBQUt/9mww1whyVjUmKsBC2Tayvv
 Ap/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWefcUGhDuCZm7AroOfl770idAV0QPXTMoiQnzXBcC8/AIjIFJw5XmKCkR+ajJfziEBIM0p97Auex5irRD5173UmOy+4GI=
X-Gm-Message-State: AOJu0Yxgbdg17MHAQNBB96WSoDw3YGXRAmAMxjhcrD5NCjn4jwjwWoZK
 mWKEN557bR7Bs6YzA+LFSyZSGTbBhugYRfDF9GvA99d+Kx2PlOaAqv0AtbEDSReroiVuXguFzAz
 u9PgAOzxAcTa5Q8OqFZe1FNitWGnXkVw1qXfpx8XL1eMAHBW3SFuk
X-Received: by 2002:a05:620a:2994:b0:79f:741:5d4f with SMTP id
 af79cd13be357-7a18da57f8dmr1662885a.3.1721230140445; 
 Wed, 17 Jul 2024 08:29:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbuzG0qsnXcJ0nUZ8yAZ5ii/25UCqSBRwC7aD1ZSl0lt+c/gDp8dWAJWZA+wnWAq6pBMlKRQ==
X-Received: by 2002:a05:620a:2994:b0:79f:741:5d4f with SMTP id
 af79cd13be357-7a18da57f8dmr1658785a.3.1721230140016; 
 Wed, 17 Jul 2024 08:29:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a160b92ba7sm414925685a.27.2024.07.17.08.28.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 08:28:59 -0700 (PDT)
Message-ID: <c3ac816e-12ca-4362-a1e7-cfb75e55286a@redhat.com>
Date: Wed, 17 Jul 2024 17:28:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/18] hw/arm/smmu-common: Support nested translation
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240715084519.1189624-1-smostafa@google.com>
 <20240715084519.1189624-12-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240715084519.1189624-12-smostafa@google.com>
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
> When nested translation is requested, do the following:
> - Translate stage-1 table address IPA into PA through stage-2.
> - Translate stage-1 table walk output (IPA) through stage-2.
> - Create a single TLB entry from stage-1 and stage-2 translations
>   using logic introduced before.
>
> smmu_ptw() has a new argument SMMUState which include the TLB as
> stage-1 table address can be cached in there.
>
> Also in smmu_ptw(), a separate path used for nesting to simplify the
> code, although some logic can be combined.
>
> With nested translation class of translation fault can be different,
> from the class of the translation, as faults from translating stage-1
> tables are considered as CLASS_TT and not CLASS_IN, a new member
> "is_ipa_descriptor" added to "SMMUPTWEventInfo" to differ faults
> from walking stage 1 translation table and faults from translating
> an IPA for a transaction.
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmu-common.c         | 74 +++++++++++++++++++++++++++++++-----
>  hw/arm/smmuv3.c              | 14 +++++++
>  include/hw/arm/smmu-common.h |  7 ++--
>  3 files changed, 82 insertions(+), 13 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index c894c4c621..8ed53f5b1d 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -318,8 +318,41 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
>      return NULL;
>  }
>  
> +/* Translate stage-1 table address using stage-2 page table. */
> +static inline int translate_table_addr_ipa(SMMUState *bs,
> +                                           dma_addr_t *table_addr,
> +                                           SMMUTransCfg *cfg,
> +                                           SMMUPTWEventInfo *info)
> +{
> +    dma_addr_t addr = *table_addr;
> +    SMMUTLBEntry *cached_entry;
> +    int asid;
> +
> +    /*
> +     * The translation table walks performed from TTB0 or TTB1 are always
> +     * performed in IPA space if stage 2 translations are enabled.
> +     */
> +    asid = cfg->asid;
> +    cfg->stage = SMMU_STAGE_2;
> +    cfg->asid = -1;
> +    cached_entry = smmu_translate(bs, cfg, addr, IOMMU_RO, info);
> +    cfg->asid = asid;
> +    cfg->stage = SMMU_NESTED;
> +
> +    if (cached_entry) {
> +        *table_addr = CACHED_ENTRY_TO_ADDR(cached_entry, addr);
> +        return 0;
> +    }
> +
> +    info->stage = SMMU_STAGE_2;
> +    info->addr = addr;
> +    info->is_ipa_descriptor = true;
> +    return -EINVAL;
> +}
> +
>  /**
>   * smmu_ptw_64_s1 - VMSAv8-64 Walk of the page tables for a given IOVA
> + * @bs: smmu state which includes TLB instance
>   * @cfg: translation config
>   * @iova: iova to translate
>   * @perm: access type
> @@ -331,7 +364,7 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
>   * Upon success, @tlbe is filled with translated_addr and entry
>   * permission rights.
>   */
> -static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
> +static int smmu_ptw_64_s1(SMMUState *bs, SMMUTransCfg *cfg,
>                            dma_addr_t iova, IOMMUAccessFlags perm,
>                            SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
>  {
> @@ -381,6 +414,11 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
>                  goto error;
>              }
>              baseaddr = get_table_pte_address(pte, granule_sz);
> +            if (cfg->stage == SMMU_NESTED) {
> +                if (translate_table_addr_ipa(bs, &baseaddr, cfg, info)) {
> +                    goto error;
> +                }
> +            }
>              level++;
>              continue;
>          } else if (is_page_pte(pte, level)) {
> @@ -568,10 +606,8 @@ error:
>   * combine S1 and S2 TLB entries into a single entry.
>   * As a result the S1 entry is overriden with combined data.
>   */
> -static void __attribute__((unused)) combine_tlb(SMMUTLBEntry *tlbe,
> -                                                SMMUTLBEntry *tlbe_s2,
> -                                                dma_addr_t iova,
> -                                                SMMUTransCfg *cfg)
> +static void combine_tlb(SMMUTLBEntry *tlbe, SMMUTLBEntry *tlbe_s2,
> +                        dma_addr_t iova, SMMUTransCfg *cfg)
>  {
>      if (tlbe_s2->entry.addr_mask < tlbe->entry.addr_mask) {
>          tlbe->entry.addr_mask = tlbe_s2->entry.addr_mask;
> @@ -591,6 +627,7 @@ static void __attribute__((unused)) combine_tlb(SMMUTLBEntry *tlbe,
>  /**
>   * smmu_ptw - Walk the page tables for an IOVA, according to @cfg
>   *
> + * @bs: smmu state which includes TLB instance
>   * @cfg: translation configuration
>   * @iova: iova to translate
>   * @perm: tentative access type
> @@ -599,11 +636,15 @@ static void __attribute__((unused)) combine_tlb(SMMUTLBEntry *tlbe,
>   *
>   * return 0 on success
>   */
> -int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
> -             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
> +int smmu_ptw(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t iova,
> +             IOMMUAccessFlags perm, SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
>  {
> +    int ret;
> +    SMMUTLBEntry tlbe_s2;
> +    dma_addr_t ipa;
> +
>      if (cfg->stage == SMMU_STAGE_1) {
> -        return smmu_ptw_64_s1(cfg, iova, perm, tlbe, info);
> +        return smmu_ptw_64_s1(bs, cfg, iova, perm, tlbe, info);
>      } else if (cfg->stage == SMMU_STAGE_2) {
>          /*
>           * If bypassing stage 1(or unimplemented), the input address is passed
> @@ -621,7 +662,20 @@ int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
>          return smmu_ptw_64_s2(cfg, iova, perm, tlbe, info);
>      }
>  
> -    g_assert_not_reached();
> +    /* SMMU_NESTED. */
> +    ret = smmu_ptw_64_s1(bs, cfg, iova, perm, tlbe, info);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    ipa = CACHED_ENTRY_TO_ADDR(tlbe, iova);
> +    ret = smmu_ptw_64_s2(cfg, ipa, perm, &tlbe_s2, info);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    combine_tlb(tlbe, &tlbe_s2, iova, cfg);
> +    return 0;
>  }
>  
>  SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
> @@ -667,7 +721,7 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
>      }
>  
>      cached_entry = g_new0(SMMUTLBEntry, 1);
> -    status = smmu_ptw(cfg, addr, flag, cached_entry, info);
> +    status = smmu_ptw(bs, cfg, addr, flag, cached_entry, info);
>      if (status) {
>              g_free(cached_entry);
>              return NULL;
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 73d5a25705..06a96c65eb 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -910,6 +910,20 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>      if (!cached_entry) {
>          /* All faults from PTW has S2 field. */
>          event->u.f_walk_eabt.s2 = (ptw_info.stage == SMMU_STAGE_2);
> +        /*
> +         * Fault class is set as follows based on "class" input to
> +         * the function and to "ptw_info" from "smmu_translate()"
> +         * For stage-1:
> +         *   - EABT => CLASS_TT (hardcoded)
> +         *   - other events => CLASS_IN (input to function)
> +         * For stage-2 => CLASS_IN (input to function)
> +         * For nested, for all events:
> +         *  - CD fetch => CLASS_CD (input to function)
> +         *  - walking stage 1 translation table  => CLASS_TT (from
> +         *    is_ipa_descriptor or input in case of TTBx)
> +         *  - s2 translation => CLASS_IN (input to function)
> +         */
> +        class = ptw_info.is_ipa_descriptor ? SMMU_CLASS_TT : class;
>          switch (ptw_info.type) {
>          case SMMU_PTW_ERR_WALK_EABT:
>              event->type = SMMU_EVT_F_WALK_EABT;
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index d84de64122..a3e6ab1b36 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -63,6 +63,7 @@ typedef struct SMMUPTWEventInfo {
>      SMMUStage stage;
>      SMMUPTWEventType type;
>      dma_addr_t addr; /* fetched address that induced an abort, if any */
> +    bool is_ipa_descriptor; /* src for fault in nested translation. */
>  } SMMUPTWEventInfo;
>  
>  typedef struct SMMUTransTableInfo {
> @@ -184,9 +185,9 @@ static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
>   * smmu_ptw - Perform the page table walk for a given iova / access flags
>   * pair, according to @cfg translation config
>   */
> -int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
> -             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info);
> -
> +int smmu_ptw(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t iova,
> +             IOMMUAccessFlags perm, SMMUTLBEntry *tlbe,
> +             SMMUPTWEventInfo *info);
>  
>  /*
>   * smmu_translate - Look for a translation in TLB, if not, do a PTW.


