Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69199C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 13:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7EzU-0002dw-Ta; Wed, 15 May 2024 09:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s7EzU-0002dK-3T
 for qemu-devel@nongnu.org; Wed, 15 May 2024 09:48:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s7EzS-0001rC-G6
 for qemu-devel@nongnu.org; Wed, 15 May 2024 09:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715780897;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yN/W4znmh25KeMkw0tN9v+vwAvSt9Dl+q3bnDyXcLEo=;
 b=PIAwQCPduOlXpEWsibT2E/e0rROJWrzYCWDJRDH+jYpGpSPFjDj2MOCJkOrG1YG3qIPkSF
 zZ5/ksPuAcvquKohFpqMEJWP6v8ghvkIeW5HmqONdDBxtlAv3fDP3396GoDGA5gqCggxJY
 ylDhw/ZSWMe9b114kerxAwPxVar8KKc=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-CPUsLpdINFK_7sZxpawzJg-1; Wed, 15 May 2024 09:48:11 -0400
X-MC-Unique: CPUsLpdINFK_7sZxpawzJg-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-622cd439764so77271477b3.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 06:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715780891; x=1716385691;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yN/W4znmh25KeMkw0tN9v+vwAvSt9Dl+q3bnDyXcLEo=;
 b=AWEKvIZsagQxqJuRKNb4B+u5joTJaJDqL1BFVjHU7p1dpcDDYKzeooUzR7fDYqH8a4
 5jBh8/yJu03O+/CsPjsaFAihXmG/3zXoGDlAWS7dF8d3RBQpx21pxwLCLt/Kz+hCDOD+
 SJg38o8em4K19PNvVU8wvPtz22TBggdoF7CHc2XiYPAFnKkp4OG+9ecJKg2X8FZC8Njd
 yIOCzhk83f4FxS2qfyYSrpWxhAbj0CpGQGYOysXfXXYBtUM2sx3J4cdkVM9MwwWVoUpy
 3NLYIkSXE2zQY/NwURlr0BTt00lF4/iUXkLvgae4CZDWE49bByLEGLPydaYqSxlJ2Y2a
 5dIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmZAZafhqnX1IIPIt2m2s8FNt9189M3No/nb/AedVQYxdDiAqQYyr7jR/YXq0cnMH/4U754pQtDPmoupNYyJAjDi35aM4=
X-Gm-Message-State: AOJu0YyXg7Q/555paeLctxC1S+Phpw2Otl1JQp17b5gNhGaJCrkmxTUb
 btJbrJU96xSFFpIG54nNj+eJtnq0lxSWBgCeDmSmMmUQLo/gxkf8njVNxMXGF0YzklHgExmlCFY
 hr1oIyDW2r6rjnMjBO1AUrgvkqCpN7HzlqLKQrFp/oCbUoOLyHSy1
X-Received: by 2002:a05:690c:4382:b0:618:79f5:8d32 with SMTP id
 00721157ae682-622b0164185mr115967327b3.48.1715780890393; 
 Wed, 15 May 2024 06:48:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5msgqMMzWyxTSd4+12hEd02bBeFd8vmRia4Akin7LVB+jiO9lYH9P5SlLG/5ofkeXbx/msg==
X-Received: by 2002:a05:690c:4382:b0:618:79f5:8d32 with SMTP id
 00721157ae682-622b0164185mr115966947b3.48.1715780889669; 
 Wed, 15 May 2024 06:48:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43e0d56dce5sm54520001cf.58.2024.05.15.06.48.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 06:48:09 -0700 (PDT)
Message-ID: <dc8d52ac-68af-4426-9a60-07ad909c86b0@redhat.com>
Date: Wed, 15 May 2024 15:48:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 08/18] hw/arm/smmu-common: Add support for nested
 TLB
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-9-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240429032403.74910-9-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
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

On 4/29/24 05:23, Mostafa Saleh wrote:
> This patch adds support for nested(combined) TLB entries.
space between nested and (.
> The main function combine_tlb() is not used here but in the next
> patches, but to simplify the patches it is introduced first.
>
> Main changes:
> 1) New entry added in the TLB, parent_perm, for nested TLB, holds the
s/entry/field, s/TLB/SMMUTLBEntry struct
>    stage-2 permission, this can be used to know the origin of a
>    permission fault from a cached entry as caching the “and” of the
>    permissions loses this information.
>
>    SMMUPTWEventInfo is used to hold information about PTW faults so
>    the event can be populated, the value of stage (which maps to S2
>    in the event) used to be set based on the current stage for TLB
I don't understand "(which maps to S2 in the event)". What do you mean?
This could be S1 or S2 depending on the active stage, no?
>    permission faults, however with the parent_perm, it is now set
>    based on which perm has the missing permission
>
>    When nesting is not enabled it has the same value as perm which
>    doesn't change the logic.
>
> 2) As combined TLB implementation is used, the combination logic
>    chooses:
>    - tg and level from the entry which has the smallest addr_mask.
tbh I am scared bout swapping s1/s2 tg and level. In smmu_iotlb_lookup()
I see tt->granule_sz being used which is s1 data. I mean it is not
obvious to me this is correct. Could you maybe give more explanations
detailing why/how this is guaranted to work.

Can you give additional details about what s1+s2 combinations were tested?
>    - Based on that the iova that would be cached is recalculated.
>    - Translated_addr is chosen from stage-2.
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  hw/arm/smmu-common.c         | 32 ++++++++++++++++++++++++++++----
>  include/hw/arm/smmu-common.h |  1 +
>  2 files changed, 29 insertions(+), 4 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 21982621c0..0d6945fa54 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -394,7 +394,7 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
>          tlbe->entry.translated_addr = gpa;
>          tlbe->entry.iova = iova & ~mask;
>          tlbe->entry.addr_mask = mask;
> -        tlbe->entry.perm = PTE_AP_TO_PERM(ap);
> +        tlbe->parent_perm = tlbe->entry.perm = PTE_AP_TO_PERM(ap);
nit: I would prefer on separate lines.
>          tlbe->level = level;
>          tlbe->granule = granule_sz;
>          return 0;
> @@ -515,7 +515,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
>          tlbe->entry.translated_addr = gpa;
>          tlbe->entry.iova = ipa & ~mask;
>          tlbe->entry.addr_mask = mask;
> -        tlbe->entry.perm = s2ap;
> +        tlbe->parent_perm = tlbe->entry.perm = s2ap;
>          tlbe->level = level;
>          tlbe->granule = granule_sz;
>          return 0;
> @@ -530,6 +530,27 @@ error:
>      return -EINVAL;
>  }
>  
> +/* combine 2 TLB entries and return in tlbe in nested config. */
suggestion: combine S1 and S2 TLB entries into a single entry. As a
result the S1 entry is overriden with combined data.
> +static void __attribute__((unused)) combine_tlb(SMMUTLBEntry *tlbe,
> +                                                SMMUTLBEntry *tlbe_s2,
> +                                                dma_addr_t iova,
> +                                                SMMUTransCfg *cfg)
> +{
> +    if (tlbe_s2->entry.addr_mask < tlbe->entry.addr_mask) {
> +        tlbe->entry.addr_mask = tlbe_s2->entry.addr_mask;
> +        tlbe->granule = tlbe_s2->granule;
> +        tlbe->level = tlbe_s2->level;
> +    }
> +
> +    tlbe->entry.translated_addr = CACHED_ENTRY_TO_ADDR(tlbe_s2,
> +                                    tlbe->entry.translated_addr);
> +
> +    tlbe->entry.iova = iova & ~tlbe->entry.addr_mask;
> +    /* parent_perm has s2 perm while perm has s1 perm. */

 suggestion: while perm keeps s1 perm.

> +    tlbe->parent_perm = tlbe_s2->entry.perm;
> +    return;
> +}
> +
>  /**
>   * smmu_ptw - Walk the page tables for an IOVA, according to @cfg
>   *
> @@ -607,9 +628,12 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
>  
>      cached_entry = smmu_iotlb_lookup(bs, cfg, &tt_combined, aligned_addr);
>      if (cached_entry) {
> -        if ((flag & IOMMU_WO) && !(cached_entry->entry.perm & IOMMU_WO)) {
> +        if ((flag & IOMMU_WO) && !(cached_entry->entry.perm &
> +            cached_entry->parent_perm & IOMMU_WO)) {
>              info->type = SMMU_PTW_ERR_PERMISSION;
> -            info->stage = cfg->stage;
> +            info->stage = !(cached_entry->entry.perm & IOMMU_WO) ?
> +                          SMMU_STAGE_1 :
> +                          SMMU_STAGE_2;
>              return NULL;
>          }
>          return cached_entry;
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 09d3b9e734..1db566d451 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -77,6 +77,7 @@ typedef struct SMMUTLBEntry {
>      IOMMUTLBEntry entry;
>      uint8_t level;
>      uint8_t granule;
> +    IOMMUAccessFlags parent_perm;
>  } SMMUTLBEntry;
>  
>  /* Stage-2 configuration. */
Thanks

Eric


