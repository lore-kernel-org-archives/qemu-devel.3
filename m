Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E154BC2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 07:58:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR5jl-0002E3-Vb; Tue, 09 Jul 2024 03:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sR5jk-0002Cc-Gu
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 03:58:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sR5ji-0002Gy-Mm
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 03:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720511886;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c6J+z0Ci5pTyFQJVT66jGF0m2Wt8JtchuNNRk9yGDFg=;
 b=UpI+As5H/XnB/N/XaR3mCxHljOiKswYym8i+PFxQ28+Hlw6rRSicon24aA9or8KdrtZC1B
 RrfLM1vjJCxK/qnNuFE2aWbmzBnsv2Q0NCOBblwCuwozckAR7Az1l193klJPTKp6xaEAsC
 e0maRu7+0Hd9JC24QfyJz4RAg65XdOU=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-irfepypIPnqlcJEjfvqpxg-1; Tue, 09 Jul 2024 03:58:04 -0400
X-MC-Unique: irfepypIPnqlcJEjfvqpxg-1
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-4f2e6b30167so1861541e0c.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 00:58:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720511883; x=1721116683;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c6J+z0Ci5pTyFQJVT66jGF0m2Wt8JtchuNNRk9yGDFg=;
 b=UxHfnVThOKQq7S7KGPuBcwYVrcxB7ZJWwLGQG/rOs7+YO3TNkVozpdekC9zKVJtUxY
 f94G5cF7eunNCusEQv/SJxVLy3I57fAtaC4MG33OVKF5FgEekzm+2wrz5sC1BH+FknXm
 rccFiF7g4xf8oz47taMWXwb45QTuzkLHU3JHFeVxiXLrjsM1MsZuUVLYx3TD2w7n6Eaf
 cX8ZZjGlw9oXvdEPo52NCnRe6YHNi0vXByCJqYq1Tb+WbVX0+x3rWdnfbTKSaUvrwmZE
 dN5npkfstjgmlRNxF33TdXRtt6Jy8cEgkG4dYQw5xvjChpW0FX5dZihl60y+bfaEBlwR
 27zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4DtbXpfT+itA/jcTtQVKIiaDi+CCy6cAXct9TCFQL9o4vKhNUeAWXv+Pd61oFP2YMXnohaSD9lnxx6m6bEy8xkArLpUg=
X-Gm-Message-State: AOJu0YyHiG2lKIpg4muvtv4TSev2XEqKKw4xqWWpHfsu1AfqYxy8pLI/
 WPJnEG3tng72MwGeK5WZk5KKGuCmjNWrpIwEd4I5RtdsjNwQ5lX+zbUUdBT0edUC1wr6JcJdnMH
 4JcU6XK8kXqFRMNpKd0RQP6pfIGpIBzMTJuI0nfXEsn2ReIIUVfdB
X-Received: by 2002:a05:6122:1797:b0:4e4:ed90:27e6 with SMTP id
 71dfb90a1353d-4f33f1e8210mr2452468e0c.5.1720511883576; 
 Tue, 09 Jul 2024 00:58:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUrEhc/f571jiY4+baDerLMQmbA/tyfHT1kEPnu7HTmWY77yzf2J1oWUKp8jwYFDmfichiqA==
X-Received: by 2002:a05:6122:1797:b0:4e4:ed90:27e6 with SMTP id
 71dfb90a1353d-4f33f1e8210mr2452440e0c.5.1720511883191; 
 Tue, 09 Jul 2024 00:58:03 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-79f18ff69ebsm71448185a.22.2024.07.09.00.57.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jul 2024 00:58:02 -0700 (PDT)
Message-ID: <d30fe053-cc62-4141-9b50-980f7e0b175b@redhat.com>
Date: Tue, 9 Jul 2024 09:57:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/19] hw/arm/smmu-common: Support nested translation
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-12-smostafa@google.com>
 <86fc9221-f24e-4a7f-8a0d-b19102f981f0@redhat.com>
 <ZozkMGIq9VHE3HXS@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <ZozkMGIq9VHE3HXS@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/9/24 09:18, Mostafa Saleh wrote:
> Hi Eric,
>
> On Mon, Jul 08, 2024 at 05:19:59PM +0200, Eric Auger wrote:
>> Hi Mostafa,
>>
>> On 7/1/24 13:02, Mostafa Saleh wrote:
>>> When nested translation is requested, do the following:
>>>
>>> - Translate stage-1 table address IPA into PA through stage-2.
>>> - Translate stage-1 table walk output (IPA) through stage-2.
>>> - Create a single TLB entry from stage-1 and stage-2 translations
>>>   using logic introduced before.
>>>
>>> For stage-1 table translation, the spec (ARM IHI 0070 F.b) says in:
>>>     7.3.12 F_WALK_EABT:
>>>         Translation of an IPA for Stage 1 descriptor fetch:
>>> 	S2 == 1 (stage 2), CLASS == T
>>> So, F_WALK_EABT is used which propagtes to CLASS == TT.
>>>
>>> smmu_ptw() has a new argument SMMUState which include the TLB as
>>> stage-1 table address can be cached in there.
>>>
>>> Also in smmu_ptw() a separate path used for nesting to simplify the
>>> code, although some logic can be combined.
>>>
>>> Signed-off-by: Mostafa Saleh <smostafa@google.com>
>>> ---
>>>  hw/arm/smmu-common.c         | 72 +++++++++++++++++++++++++++++++-----
>>>  include/hw/arm/smmu-common.h |  2 +-
>>>  2 files changed, 64 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
>>> index 24b7d09e2b..71afd486ba 100644
>>> --- a/hw/arm/smmu-common.c
>>> +++ b/hw/arm/smmu-common.c
>>> @@ -318,6 +318,38 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
>>>      return NULL;
>>>  }
>>>  
>>> +/* Translate stage-1 table address using stage-2 page table. */
>>> +static inline int translate_table_addr_ipa(dma_addr_t *table_addr,
>>> +                                           SMMUTransCfg *cfg,
>>> +                                           SMMUPTWEventInfo *info,
>>> +                                           SMMUState *bs)
>> Nit: in general the SMMUState if the 1st arg, as the most global state.
>>> +{
>>> +    dma_addr_t addr = *table_addr;
>>> +    SMMUTLBEntry *cached_entry;
>>> +    int asid;
>>> +
>>> +    /*
>>> +     * The translation table walks performed from TTB0 or TTB1 are always
>>> +     * performed in IPA space if stage 2 translations are enabled.
>>> +     */
>>> +    asid = cfg->asid;
>>> +    cfg->stage = SMMU_STAGE_2;
>>> +    cfg->asid = -1;
>>> +    cached_entry = smmu_translate(bs, cfg, addr, IOMMU_RO, info);
>>> +    cfg->asid = asid;
>>> +    cfg->stage = SMMU_NESTED;
>>> +
>>> +    if (cached_entry) {
>>> +        *table_addr = CACHED_ENTRY_TO_ADDR(cached_entry, addr);
>>> +        return 0;
>>> +    }
>>> +
>>> +    info->stage = SMMU_STAGE_2;
>>> +    info->type = SMMU_PTW_ERR_WALK_EABT;
>>> +    info->addr = addr;
>> so I guess also here the recorded address should be the IOVA (Jean's
>> previous comment)?
> This address maps to FetchAddr and not InputAddr, which is set from the
> calling function, so that should be correct. (besides event type as Jean
> mentioned it needs be fixed).
Ah OK I mixed them up. Sorry for the noise then

Eric
>
> Thanks,
> Mostafa
>
>> Eric
>>> +    return -EINVAL;
>>> +}
>>> +
>>>  /**
>>>   * smmu_ptw_64_s1 - VMSAv8-64 Walk of the page tables for a given IOVA
>>>   * @cfg: translation config
>>> @@ -333,7 +365,8 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
>>>   */
>>>  static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
>>>                            dma_addr_t iova, IOMMUAccessFlags perm,
>>> -                          SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
>>> +                          SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info,
>>> +                          SMMUState *bs)
>>>  {
>>>      dma_addr_t baseaddr, indexmask;
>>>      SMMUStage stage = cfg->stage;
>>> @@ -381,6 +414,11 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
>>>                  goto error;
>>>              }
>>>              baseaddr = get_table_pte_address(pte, granule_sz);
>>> +            if (cfg->stage == SMMU_NESTED) {
>>> +                if (translate_table_addr_ipa(&baseaddr, cfg, info, bs)) {
>>> +                    goto error;
>>> +                }
>>> +            }
>>>              level++;
>>>              continue;
>>>          } else if (is_page_pte(pte, level)) {
>>> @@ -568,10 +606,8 @@ error:
>>>   * combine S1 and S2 TLB entries into a single entry.
>>>   * As a result the S1 entry is overriden with combined data.
>>>   */
>>> -static void __attribute__((unused)) combine_tlb(SMMUTLBEntry *tlbe,
>>> -                                                SMMUTLBEntry *tlbe_s2,
>>> -                                                dma_addr_t iova,
>>> -                                                SMMUTransCfg *cfg)
>>> +static void combine_tlb(SMMUTLBEntry *tlbe, SMMUTLBEntry *tlbe_s2,
>>> +                        dma_addr_t iova, SMMUTransCfg *cfg)
>>>  {
>>>      if (tlbe_s2->entry.addr_mask < tlbe->entry.addr_mask) {
>>>          tlbe->entry.addr_mask = tlbe_s2->entry.addr_mask;
>>> @@ -596,14 +632,19 @@ static void __attribute__((unused)) combine_tlb(SMMUTLBEntry *tlbe,
>>>   * @perm: tentative access type
>>>   * @tlbe: returned entry
>>>   * @info: ptw event handle
>>> + * @bs: smmu state which includes TLB instance
>>>   *
>>>   * return 0 on success
>>>   */
>>>  int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
>>> -             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
>>> +             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info, SMMUState *bs)
>>>  {
>>> +    int ret;
>>> +    SMMUTLBEntry tlbe_s2;
>>> +    dma_addr_t ipa;
>>> +
>>>      if (cfg->stage == SMMU_STAGE_1) {
>>> -        return smmu_ptw_64_s1(cfg, iova, perm, tlbe, info);
>>> +        return smmu_ptw_64_s1(cfg, iova, perm, tlbe, info, bs);
>>>      } else if (cfg->stage == SMMU_STAGE_2) {
>>>          /*
>>>           * If bypassing stage 1(or unimplemented), the input address is passed
>>> @@ -621,7 +662,20 @@ int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
>>>          return smmu_ptw_64_s2(cfg, iova, perm, tlbe, info);
>>>      }
>>>  
>>> -    g_assert_not_reached();
>>> +    /* SMMU_NESTED. */
>>> +    ret = smmu_ptw_64_s1(cfg, iova, perm, tlbe, info, bs);
>>> +    if (ret) {
>>> +        return ret;
>>> +    }
>>> +
>>> +    ipa = CACHED_ENTRY_TO_ADDR(tlbe, iova);
>>> +    ret = smmu_ptw_64_s2(cfg, ipa, perm, &tlbe_s2, info);
>>> +    if (ret) {
>>> +        return ret;
>>> +    }
>>> +
>>> +    combine_tlb(tlbe, &tlbe_s2, iova, cfg);
>>> +    return 0;
>>>  }
>>>  
>>>  SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
>>> @@ -677,7 +731,7 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
>>>      }
>>>  
>>>      cached_entry = g_new0(SMMUTLBEntry, 1);
>>> -    status = smmu_ptw(cfg, aligned_addr, flag, cached_entry, info);
>>> +    status = smmu_ptw(cfg, aligned_addr, flag, cached_entry, info, bs);
>>>      if (status) {
>>>              g_free(cached_entry);
>>>              return NULL;
>>> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
>>> index 1db566d451..cf0fd3ec74 100644
>>> --- a/include/hw/arm/smmu-common.h
>>> +++ b/include/hw/arm/smmu-common.h
>>> @@ -185,7 +185,7 @@ static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
>>>   * pair, according to @cfg translation config
>>>   */
>>>  int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
>>> -             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info);
>>> +             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info, SMMUState *bs);
>>>  
>>>  
>>>  /*


