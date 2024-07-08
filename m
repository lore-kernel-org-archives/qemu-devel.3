Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99577C3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 15:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQpwq-0004Kp-Nc; Mon, 08 Jul 2024 11:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sQpwo-0004Fw-73
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 11:06:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sQpwm-000219-K5
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 11:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720451191;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5fWBx2O4/T0rCdOxeNBt4ocg3FTts1GcdR6N3DCMmAw=;
 b=CZ+opVKM0H2Ig8ujldFUa+BTA03OdL9SSAgq0gXJIZ5VOESNJMhZu5hT+qsgSzKlt+5tA/
 tC9BUBnsBCPT01H90gEqwKRi9r9MpCEcWM26HVl7f2qNiOIS0SAHL0x7gDQZsd1iH+zk/I
 Fx5gKjhisSY9xTCbBW37YstEMCYFJjw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-YtKFGu5_MEai067Oemncng-1; Mon, 08 Jul 2024 11:06:30 -0400
X-MC-Unique: YtKFGu5_MEai067Oemncng-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3678f832c75so3740190f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 08:06:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720451188; x=1721055988;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5fWBx2O4/T0rCdOxeNBt4ocg3FTts1GcdR6N3DCMmAw=;
 b=rHS4U+RIOOheGD+2uay0HTSzqpPw0GMN2S4wVQzXlGMWuO6IXbhO540TC1epD4rQLD
 u4xq6NUxIVDPpDfVfXn85FsZHka9DWKK97dnqmPobMir7TYIKknCZJIWX9xN9XgcLTcA
 NnyyxTxSEHgwI4w9qcZJGIl3rQ49TqgqpTy1NPyi3vEJVUEtJuhxVHVk4wy2lDFF+8MO
 9WgzYqOS9vrWbHjrsK9IJ+Pgbv82z0C+kFrxjGUXITdUaxayrCjVBHRARG0CXMVKxPHm
 yfjJ0zA8lCwGL41j4lomAOYeVyajRlJofZUqbNc0ALGlPLXUjqoOuIkxFdjWcuB7ngw7
 wzAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWz6rm0PB7AlTdDM/Ja6PMVeaTNII46Dw6A4mrpO4s6yNrulOiZKEmBc3Rc0agXhO9v2EePer4bU62irhOROKR3RL9eQPU=
X-Gm-Message-State: AOJu0YzpKHJohDreQ/l4EWTeVztC2o4Bo+6BEZWTS5W1AO6v9vBUMXbH
 EPdRZ1lt9RXPHjvUKNeJRpBZqZRiowkvUG1i1uX4+RyObpQVmvbjnJvtNajquT7Gi7vWRn9GWXK
 +0ogIsqi9Y6UE4U19okoz9iiNdYqCU89/uMPyQrZLatb4pCUJVU3R+qqBPQ6b
X-Received: by 2002:adf:e68b:0:b0:367:938d:7065 with SMTP id
 ffacd0b85a97d-3679dd6583bmr10053992f8f.56.1720451187985; 
 Mon, 08 Jul 2024 08:06:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG//R4vUh4kXQFSkEoY1+3/myBMH+8sX8FIeSCFcPoRX8p0gRzZIg/4BmccZ0EQ3R/GQrCG/w==
X-Received: by 2002:adf:e68b:0:b0:367:938d:7065 with SMTP id
 ffacd0b85a97d-3679dd6583bmr10053961f8f.56.1720451187595; 
 Mon, 08 Jul 2024 08:06:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cde84be6sm25691f8f.48.2024.07.08.08.06.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 08:06:27 -0700 (PDT)
Message-ID: <a16f0e3e-d5af-410e-9631-5e77f39931e7@redhat.com>
Date: Mon, 8 Jul 2024 17:06:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/19] hw/arm/smmu-common: Add support for nested TLB
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-11-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240701110241.2005222-11-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
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



On 7/1/24 13:02, Mostafa Saleh wrote:
> This patch adds support for nested (combined) TLB entries.
> The main function combine_tlb() is not used here but in the next
> patches, but to simplify the patches it is introduced first.
>
> Main changes:
> 1) New field added in the SMMUTLBEntry struct: parent_perm, for
>    nested TLB, holds the stage-2 permission, this can be used to know
>    the origin of a permission fault from a cached entry as caching
>    the “and” of the permissions loses this information.
>
>    SMMUPTWEventInfo is used to hold information about PTW faults so
>    the event can be populated, the value of stage used to be set
>    based on the current stage for TLB permission faults, however
>    with the parent_perm, it is now set based on which perm has
>    the missing permission
>
>    When nesting is not enabled it has the same value as perm which
>    doesn't change the logic.
>
> 2) As combined TLB implementation is used, the combination logic
>    chooses:
>    - tg and level from the entry which has the smallest addr_mask.
>    - Based on that the iova that would be cached is recalculated.
>    - Translated_addr is chosen from stage-2.
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmu-common.c         | 37 ++++++++++++++++++++++++++++++++----
>  include/hw/arm/smmu-common.h |  1 +
>  2 files changed, 34 insertions(+), 4 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 0840b5cffd..24b7d09e2b 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -426,7 +426,8 @@ static int smmu_ptw_64_s1(SMMUTransCfg *cfg,
>          tlbe->entry.translated_addr = gpa;
>          tlbe->entry.iova = iova & ~mask;
>          tlbe->entry.addr_mask = mask;
> -        tlbe->entry.perm = PTE_AP_TO_PERM(ap);
> +        tlbe->parent_perm = PTE_AP_TO_PERM(ap);
> +        tlbe->entry.perm = tlbe->parent_perm;
>          tlbe->level = level;
>          tlbe->granule = granule_sz;
>          return 0;
> @@ -547,7 +548,8 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
>          tlbe->entry.translated_addr = gpa;
>          tlbe->entry.iova = ipa & ~mask;
>          tlbe->entry.addr_mask = mask;
> -        tlbe->entry.perm = s2ap;
> +        tlbe->parent_perm = s2ap;
> +        tlbe->entry.perm = tlbe->parent_perm;
>          tlbe->level = level;
>          tlbe->granule = granule_sz;
>          return 0;
> @@ -562,6 +564,30 @@ error:
>      return -EINVAL;
>  }
>  
> +/*
> + * combine S1 and S2 TLB entries into a single entry.
> + * As a result the S1 entry is overriden with combined data.
> + */
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
> +    /* parent_perm has s2 perm while perm keeps s1 perm. */
> +    tlbe->parent_perm = tlbe_s2->entry.perm;
> +    return;
> +}
> +
>  /**
>   * smmu_ptw - Walk the page tables for an IOVA, according to @cfg
>   *
> @@ -639,9 +665,12 @@ SMMUTLBEntry *smmu_translate(SMMUState *bs, SMMUTransCfg *cfg, dma_addr_t addr,
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


