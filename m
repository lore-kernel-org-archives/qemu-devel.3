Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5262EC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 18:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPRHd-0000Le-7c; Thu, 04 Jul 2024 14:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPRHb-0000H6-GR
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:34:15 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPRHZ-0004Mx-Kg
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:34:15 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4264a3847b6so6055995e9.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 11:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720118052; x=1720722852; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZOyZIM2oMhU/q1qfOkv3NvnCzlYt7sTiv5uJYduiYpQ=;
 b=SRGGopdjbRS/OwZr4Cl9rY4YHzcwkrXMV4E5OwXMyjh4n1fzzWK4FBnewLwOXJTKFS
 wdQBxx2Tayud1G63bhvafY2Z/KxYZcLMOUVBum9BVYYIFuiC0JdfPynCjFlek193tv6w
 DH3aNsiH7b5OFpSOFuuSS1wl5tkR2Ke+uuUU6lckKROQneDfUSAXosk9rKPhjZNJHann
 BfFEd/Lrqlo/Hq61vobL33GtR6/tpkI1v7JVKCC/lVfrygrNmU726/T+9DV0NFNikbmY
 wU/mk/Mx0/r9UW0eQ0T327X2hJiMO9zF16jHnVqd04kXjGx4iSKtNXkLjvXc/4PkxQPw
 IKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720118052; x=1720722852;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZOyZIM2oMhU/q1qfOkv3NvnCzlYt7sTiv5uJYduiYpQ=;
 b=HRSuHGt8BkeoP5eqzSfToe7Qmp9QHEVKQMtfQG3z95ZYBvZbp9Ik9scAmJtrn82zrX
 JOxZVIDjTFSSepFNTPjQieQxKpBIycm9cpQkXANOihAj2i/KOIxGGALrDECcLe/58bZJ
 H97p2ej6ItBw6OExBwaH7F+Y5KI9j9jD+HaBuzrmV5ZwRbqJNWV1kjCpE9FuEE5G8NHD
 hy79wmoxOd6OQi3OS9UyH4rE2exJbb07Sz3ncYMH0WHS18W4Tbj7g4yCPeW7Y+I6yRRi
 6DgiAQQLquoR/MSIunNYQX9frTulOirt4bC6M/dU22xnHyX6JUsna/WE/NjEf2ddZFoL
 DigQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2izYPvTqytPc8supsHcVGjwmstAoA4CpZ3DUgQ7Clkn9ws7Xtbv7vc8kBcvR/pV2FaaAjnEDvVyqbA/R2vnp4sJ1T6C8=
X-Gm-Message-State: AOJu0YwznXvDlCqz+pxYjfFBrtetFltf/jvdbvBxplR0tmgg5dYN2K0z
 5oEFl3JrYUMI7ios3AWR8Jl15xrdSEgJKXdGVQFOw6uoZmi4f2xXyJG1cYh52Ig=
X-Google-Smtp-Source: AGHT+IGDP/oPx4p9eJ5ihhFeWt4g6wnzwssdFXvt3XLdCfuKfeLjKOoBBZE8mI+EBGOJWwIhq3jmpg==
X-Received: by 2002:a05:600c:4b17:b0:424:a578:fc7 with SMTP id
 5b1f17b1804b1-4264a3cc9f5mr20260265e9.3.1720118051911; 
 Thu, 04 Jul 2024 11:34:11 -0700 (PDT)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-426487c1c66sm15431045e9.0.2024.07.04.11.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 11:34:11 -0700 (PDT)
Date: Thu, 4 Jul 2024 19:34:24 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v4 14/19] hw/arm/smmu: Support nesting in the rest of
 commands
Message-ID: <20240704183424.GK1693268@myrica>
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-15-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701110241.2005222-15-smostafa@google.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32f.google.com
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

On Mon, Jul 01, 2024 at 11:02:36AM +0000, Mostafa Saleh wrote:
> Some commands need rework for nesting, as they used to assume S1
> and S2 are mutually exclusive:
> 
> - CMD_TLBI_NH_ASID: Consider VMID if stage-2 is supported
> - CMD_TLBI_NH_ALL: Consider VMID if stage-2 is supported, otherwise
>   invalidate everything, this required a new vmid invalidation
>   function for stage-1 only (ASID >= 0)
> 
> Also, rework trace events to reflect the new implementation.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  hw/arm/smmu-common.c         | 16 ++++++++++++++++
>  hw/arm/smmuv3.c              | 28 ++++++++++++++++++++++++++--
>  hw/arm/trace-events          |  6 ++++--
>  include/hw/arm/smmu-common.h |  1 +
>  4 files changed, 47 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index d0309a95b2..faba4adc49 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -178,6 +178,16 @@ static gboolean smmu_hash_remove_by_vmid(gpointer key, gpointer value,
>      return SMMU_IOTLB_VMID(*iotlb_key) == vmid;
>  }
>  
> +static gboolean smmu_hash_remove_by_vmid_s1(gpointer key, gpointer value,
> +                                            gpointer user_data)
> +{
> +    int vmid = *(int *)user_data;
> +    SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
> +
> +    return (SMMU_IOTLB_VMID(*iotlb_key) == vmid) &&
> +           (SMMU_IOTLB_ASID(*iotlb_key) >= 0);
> +}
> +
>  static gboolean smmu_hash_remove_by_asid_vmid_iova(gpointer key, gpointer value,
>                                                gpointer user_data)
>  {
> @@ -288,6 +298,12 @@ void smmu_iotlb_inv_vmid(SMMUState *s, int vmid)
>      g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &vmid);
>  }
>  
> +inline void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid)
> +{
> +    trace_smmu_iotlb_inv_vmid_s1(vmid);
> +    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid_s1, &vmid);
> +}
> +
>  /* VMSAv8-64 Translation */
>  
>  /**
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 928f125523..e9007af3cd 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1321,25 +1321,49 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>          case SMMU_CMD_TLBI_NH_ASID:
>          {
>              int asid = CMD_ASID(&cmd);
> +            int vmid = -1;
>  
>              if (!STAGE1_SUPPORTED(s)) {
>                  cmd_error = SMMU_CERROR_ILL;
>                  break;
>              }
>  
> +            /*
> +             * VMID is only matched when stage 2 is supported, otherwise set it
> +             * to -1 as the value used for stage-1 only VMIDs.
> +             */
> +            if (STAGE2_SUPPORTED(s)) {
> +                vmid = CMD_VMID(&cmd);
> +            }
> +
>              trace_smmuv3_cmdq_tlbi_nh_asid(asid);
>              smmu_inv_notifiers_all(&s->smmu_state);
> -            smmu_iotlb_inv_asid_vmid(bs, asid, -1);
> +            smmu_iotlb_inv_asid_vmid(bs, asid, vmid);
>              break;
>          }
>          case SMMU_CMD_TLBI_NH_ALL:
> +        {
> +            int vmid = -1;
> +
>              if (!STAGE1_SUPPORTED(s)) {
>                  cmd_error = SMMU_CERROR_ILL;
>                  break;
>              }
> +
> +            /*
> +             * If stage-2 is supported, invalidate for this VMID only, otherwise
> +             * invalidate the whole thing.
> +             */
> +            if (STAGE2_SUPPORTED(s)) {
> +                vmid = CMD_VMID(&cmd);
> +                trace_smmuv3_cmdq_tlbi_nh(vmid);
> +                smmu_iotlb_inv_vmid_s1(bs, vmid);
> +                break;
> +            }
>              QEMU_FALLTHROUGH;
> +        }
>          case SMMU_CMD_TLBI_NSNH_ALL:
> -            trace_smmuv3_cmdq_tlbi_nh();
> +            trace_smmuv3_cmdq_tlbi_nsnh();
>              smmu_inv_notifiers_all(&s->smmu_state);
>              smmu_iotlb_inv_all(bs);
>              break;
> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 7d9c1703da..593cc571da 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -11,8 +11,9 @@ smmu_ptw_page_pte(int stage, int level,  uint64_t iova, uint64_t baseaddr, uint6
>  smmu_ptw_block_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr, uint64_t pte, uint64_t iova, uint64_t gpa, int bsize_mb) "stage=%d level=%d base@=0x%"PRIx64" pte@=0x%"PRIx64" pte=0x%"PRIx64" iova=0x%"PRIx64" block address = 0x%"PRIx64" block size = %d MiB"
>  smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte) "baseaddr=0x%"PRIx64" index=0x%x, pteaddr=0x%"PRIx64", pte=0x%"PRIx64
>  smmu_iotlb_inv_all(void) "IOTLB invalidate all"
> -smmu_iotlb_inv_asid(int asid) "IOTLB invalidate asid=%d"
> +smmu_iotlb_inv_asid_vmid(int asid, int vmid) "IOTLB invalidate asid=%d vmid=%d"
>  smmu_iotlb_inv_vmid(int vmid) "IOTLB invalidate vmid=%d"
> +smmu_iotlb_inv_vmid_s1(int vmid) "IOTLB invalidate vmid=%d"
>  smmu_iotlb_inv_iova(int asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
>  smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
>  smmu_iotlb_lookup_hit(int asid, int vmid, uint64_t addr, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d vmid=%d addr=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
> @@ -47,7 +48,8 @@ smmuv3_cmdq_cfgi_cd(uint32_t sid) "sid=0x%x"
>  smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache HIT for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
>  smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
>  smmuv3_range_inval(int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf, int stage) "vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d stage=%d"
> -smmuv3_cmdq_tlbi_nh(void) ""
> +smmuv3_cmdq_tlbi_nh(int vmid) "vmid=%d"
> +smmuv3_cmdq_tlbi_nsnh(void) ""
>  smmuv3_cmdq_tlbi_nh_asid(int asid) "asid=%d"
>  smmuv3_cmdq_tlbi_s12_vmid(int vmid) "vmid=%d"
>  smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 2bc9a03d47..361e639630 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -214,6 +214,7 @@ SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
>  void smmu_iotlb_inv_all(SMMUState *s);
>  void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid);
>  void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
> +void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid);
>  void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>                           uint8_t tg, uint64_t num_pages, uint8_t ttl);
>  void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 

