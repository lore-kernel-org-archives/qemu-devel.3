Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E42E9C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 09:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8zd9-00062H-On; Mon, 20 May 2024 05:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s8zd8-00061e-1H
 for qemu-devel@nongnu.org; Mon, 20 May 2024 05:48:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s8zd6-0007f3-7h
 for qemu-devel@nongnu.org; Mon, 20 May 2024 05:48:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716198507;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UK/95iBmAg6EpTL6BggqtUeHWkOQSZit6swmc+zIvbo=;
 b=beB/MC9wp1yc3EUQCDg4E9D3fCSksS181NhfzCr713gc9THIs2trS/nGRNWQa0MifaEfwX
 6r+nxCxjN4xnPfbM4MP4gfl8/VE8FFiwJACwB2VchqoNyQ3IV03mQIGKlA1n1ACWacICXv
 3bowboHuLg8W9v2qEUI6YYvn8QbfxMA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-4yPgp9eWNuSgnSbWJsbg1g-1; Mon, 20 May 2024 05:48:25 -0400
X-MC-Unique: 4yPgp9eWNuSgnSbWJsbg1g-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-792b96c3c5fso1566514485a.2
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 02:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716198505; x=1716803305;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UK/95iBmAg6EpTL6BggqtUeHWkOQSZit6swmc+zIvbo=;
 b=LfF9gEkoP9ij6oWvF5txwdlSFB7ehIi/W8a3lzmcY+RCRgdB/w1fYAXGCR8xkpd0og
 fRi7zVWCltBWueMvHuKnHY99DO1su+6AhaI7r247q/4bCTQZqQThPklDT7MnAs7mKygC
 6Y1oNj3EklsMhmIZHwwliAUrIOgZgGCC1+AHFhrBXAKMF1DfFj6Wo2X1NtwK+CZPRPJW
 0940ELudkh1Iq9rJ3wNhfqKkT/sch3heyeGnNRnavIq4ITb58TWSGTkOAPXjuUZ3oSFT
 vPBz0n/7UANdjFo3u36JoWJcKia1Iv2Ow93nF6aZ7J3n2E1W0s7+SXPV/Znu3R0FLvjn
 JAvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeW+cNu8sBG2tHDpjOK6sAsKlILjiC1fSy3LvMFjjvrV7Qbw/Yo4bkLahrDqEpe64elhGaWxbOln1uXxMysd8xEDpHtvY=
X-Gm-Message-State: AOJu0YxtqbIr5EqXcJsFQNDbCjPAMYBnlrP4qbpp6HzvJ5Fpur26RS+r
 t02UN5xr7xLN6eM5JI9otWlwkN49+nsga9T6sMMagReXtKPe36ys+Wqref/veTKc9dgE1zVS1//
 ZECP/4+qV8PDmbEkv8x4deComa6eJ9WMR6NzdJT2iFkWtDk8lS0Bd
X-Received: by 2002:a05:6214:590b:b0:6a9:4917:7341 with SMTP id
 6a1803df08f44-6a949177651mr54596266d6.18.1716198504796; 
 Mon, 20 May 2024 02:48:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqqjU/X1veMuhr59Odvi5En0iJfBw3Zl7a76psy7A6Ic4Y7amQiw8NymAlixI+SuujnOQpHA==
X-Received: by 2002:a05:6214:590b:b0:6a9:4917:7341 with SMTP id
 6a1803df08f44-6a949177651mr54596066d6.18.1716198504267; 
 Mon, 20 May 2024 02:48:24 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ab6d76e124sm952916d6.46.2024.05.20.02.48.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 May 2024 02:48:23 -0700 (PDT)
Message-ID: <770312ee-8093-431a-bfdf-b01ca90945cf@redhat.com>
Date: Mon, 20 May 2024 11:48:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 10/18] hw/arm/smmu-common: Support nested
 translation
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-11-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240429032403.74910-11-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.383,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 4/29/24 05:23, Mostafa Saleh wrote:
> When nested translation is requested, do the following:
>
> - Translate stage-1 IPA using stage-2 to a physical address.
stage-1 table address IPA into PA through S2 stage

> - Translate stage-1 table walks using stage-2.
output of S1 stage (IPA) through S2.
> - Combine both to create a single TLB entry using the logic
>   introduced before.
this applies to second only. First one is associated with an S2 TLB
entry, right?
>
> For stage-1 table translation, the spec (ARM IHI 0070 F.b) says in:
>     7.3.12 F_WALK_EABT:
>         Translation of an IPA for Stage 1 descriptor fetch:
> 	S2 == 1 (stage 2), CLASS == T
> So, F_WALK_EABT is used which propagtes to CLASS == TT.
>
> smmu_ptw() has a new argument SMMUState which include the TLB as
> stage-1 table address can be cached in there.
>
> Also in smmu_ptw() a separate path used for nesting to simplify the
> code, although some logic can be combined.
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  hw/arm/smmu-common.c         | 67 ++++++++++++++++++++++++++++++------
>  include/hw/arm/smmu-common.h |  2 +-
>  2 files changed, 58 insertions(+), 11 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index c67af3bc6d..d48ec08947 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -306,6 +306,32 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
>      return NULL;
>  }
>  
> +/* Translate stage-1 table address using stage-2 page table. */
> +static inline int translate_table_s1(dma_addr_t *table_addr, SMMUTransCfg *cfg,
> +                                     SMMUPTWEventInfo *info, SMMUState *bs)
would suggest translate_table_addr_ipa().
> +{
> +    dma_addr_t addr = *table_addr;
> +    SMMUTLBEntry *cached_entry;
> +    int asid;
> +
> +    asid = cfg->asid;
> +    cfg->stage = SMMU_STAGE_2;
> +    cfg->asid = -1;
> +    cached_entry = smmu_translate(bs, cfg, addr, IOMMU_RO, info);
so this is going to be cached as an S2 entry. Maybe worth adding a comment.
> +    cfg->asid = asid;
> +    cfg->stage = SMMU_NESTED;
> +
> +    if (cached_entry) {
> +        *table_addr = CACHED_ENTRY_TO_ADDR(cached_entry, addr);
> +        return 0;
> +    }
> +
> +    info->stage = SMMU_STAGE_2;
> +    info->type = SMMU_PTW_ERR_WALK_EABT;
> +    info->addr = addr;
> +    return -EINVAL;
> +}
> +
>  /**
>   * smmu_ptw_64_s1 - VMSAv8-64 Walk of the page tables for a given IOVA
>   * @cfg: translation config
> @@ -321,7 +347,8 @@ SMMUTransTableInfo *select_tt(SMMUTransCfg *cfg, dma_addr_t iova)
>   */
>  static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
>                            dma_addr_t iova, IOMMUAccessFlags perm,
> -                          SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
> +                          SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info,
> +                          SMMUState *bs)
>  {
>      dma_addr_t baseaddr, indexmask;
>      SMMUStage stage = cfg->stage;
> @@ -369,6 +396,11 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
>                  goto error;
>              }
>              baseaddr = get_table_pte_address(pte, granule_sz);
> +            if (cfg->stage == SMMU_NESTED) {
> +                if (translate_table_s1(&baseaddr, cfg, info, bs)) {
> +                    goto error;
> +                }
> +            }
>              level++;
>              continue;
>          } else if (is_page_pte(pte, level)) {
> @@ -551,10 +583,8 @@ error:
>  }
>  
>  /* combine 2 TLB entries and return in tlbe in nested config. */
> -static void __attribute__((unused)) combine_tlb(SMMUTLBEntry *tlbe,
> -                                                SMMUTLBEntry *tlbe_s2,
> -                                                dma_addr_t iova,
> -                                                SMMUTransCfg *cfg)
> +static void combine_tlb(SMMUTLBEntry *tlbe, SMMUTLBEntry *tlbe_s2,
> +                        dma_addr_t iova, SMMUTransCfg *cfg)
>  {
>      if (tlbe_s2->entry.addr_mask < tlbe->entry.addr_mask) {
>          tlbe->entry.addr_mask = tlbe_s2->entry.addr_mask;
> @@ -579,14 +609,19 @@ static void __attribute__((unused)) combine_tlb(SMMUTLBEntry *tlbe,
>   * @perm: tentative access type
>   * @tlbe: returned entry
>   * @info: ptw event handle
> + * @bs: smmu state which includes TLB instance
>   *
>   * return 0 on success
>   */
>  int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
> -             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info)
> +             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info, SMMUState *bs)
>  {
> +    int ret;
> +    SMMUTLBEntry tlbe_s2;
> +    dma_addr_t ipa;
> +
>      if (cfg->stage == SMMU_STAGE_1) {
> -        return smmu_ptw_64_s1(cfg, iova, perm, tlbe, info);
> +        return smmu_ptw_64_s1(cfg, iova, perm, tlbe, info, bs);
>      } else if (cfg->stage == SMMU_STAGE_2) {
>          /*
>           * If bypassing stage 1(or unimplemented), the input address is passed
> @@ -600,11 +635,23 @@ int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
>              tlbe->entry.perm = IOMMU_NONE;
>              return -EINVAL;
>          }
> -
spurious line change
>          return smmu_ptw_64_s2(cfg, iova, perm, tlbe, info);
>      }
>  
> -    g_assert_not_reached();
> +    /* SMMU_NESTED. */
> +    ret = smmu_ptw_64_s1(cfg, iova, perm, tlbe, info, bs);
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
> @@ -660,7 +707,7 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
>      }
>  
>      cached_entry = g_new0(SMMUTLBEntry, 1);
> -    status = smmu_ptw(cfg, aligned_addr, flag, cached_entry, info);
> +    status = smmu_ptw(cfg, aligned_addr, flag, cached_entry, info, bs);
>      if (status) {
>              g_free(cached_entry);
>              return NULL;
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 1db566d451..cf0fd3ec74 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -185,7 +185,7 @@ static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
>   * pair, according to @cfg translation config
>   */
>  int smmu_ptw(SMMUTransCfg *cfg, dma_addr_t iova, IOMMUAccessFlags perm,
> -             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info);
> +             SMMUTLBEntry *tlbe, SMMUPTWEventInfo *info, SMMUState *bs);
>  
>  
>  /*
Thanks

Eric


