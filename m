Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6EEC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 16:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQr25-00079w-Dr; Mon, 08 Jul 2024 12:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sQr20-00075P-K5
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:16:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sQr1x-0001xp-UU
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 12:15:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720455356;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n3t2Sy52xezSz/ZX79pDsxXJ5AwAQfMwMcyAwGI6YbA=;
 b=HSc9fi+Bg6yMlQ1ZrrfXwLwlf0ULU0hHfr4G3RRliH1k6EFPC1nK8kcfhlA9sw6cpZ6+nl
 dxpN56FFgGaf3VYRIcrMXk4jb9vqLs+u9Sf7BYefUMvxf34g0XCNnBPvCiIjr/x8mcF6gy
 eRz3Fb45LcW4E+XqGkLh8FngtDmWw7M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-4euNaTpuOVWKMCgK-_ZYQg-1; Mon, 08 Jul 2024 12:15:53 -0400
X-MC-Unique: 4euNaTpuOVWKMCgK-_ZYQg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-367a064472aso2765886f8f.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 09:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720455352; x=1721060152;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n3t2Sy52xezSz/ZX79pDsxXJ5AwAQfMwMcyAwGI6YbA=;
 b=hG6qmNk0qE0f0PbSCQcNxtzHZmTRQzyfSEJXxC5c5ge3V9GdDFBxUH4UsdjyL0kXcO
 p1HRf4HhpHLzv9hyvtfEb2dXED7GlaqEgvV27HoSPkIXeNvSTqssSRnE36IiOKbIVHvw
 2JD5vVazTZO6R/B8OJda49qtE/AlfK4ZCu6lh9Eit1LhvCzUW5JGbzr6IVEKNSUaNdEu
 J3RvohfqcLRzukiyEIHy0kK3TNiDKUcyLBZWAj9MdhxK1SnZIrPL6Kw+9GQxSA+WiNxa
 EKFB1M9ovLIJi9NO6oBUNsLHejX7cHDQI/HA8m/o6jZbyAN9GhWt6HUAEuOpkUKPAJH4
 wsbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLP7Exlxheqnl1Qh4D8LgQBE2aqTQzyEHAWeTfdJhAQZUQSZV35mEKxOinrkvPf7r2SDE4dq55UQkLUD8fuSF9W3Txhlw=
X-Gm-Message-State: AOJu0YxemmqtSnFJn5h+AGy4kaFOIwhmalMJc/KF7v6bs+CPxymoGCjG
 LxPsSAcoP+CxcgTaqKAL2TO5f1zUxhBLQ+t5iHBsT6GQrpGeFCTwxlxyWbIVucm0ZmHczXGDRC8
 vGi6XHIDrZdJLVyGVCL0QsgqT/wOREaziEUBNV4PZZjWqRr8y60Fz
X-Received: by 2002:a05:6000:1041:b0:367:13a:5276 with SMTP id
 ffacd0b85a97d-367cea737c1mr54930f8f.20.1720455352649; 
 Mon, 08 Jul 2024 09:15:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpJqgc8DpPmwQ/AfqNXQ6I2RFiaM48ryCrl65esrbNz6l8+UAY1K+y69GDpTl4yig52daYLA==
X-Received: by 2002:a05:6000:1041:b0:367:13a:5276 with SMTP id
 ffacd0b85a97d-367cea737c1mr54908f8f.20.1720455352281; 
 Mon, 08 Jul 2024 09:15:52 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367cdfa0613sm165495f8f.88.2024.07.08.09.15.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jul 2024 09:15:52 -0700 (PDT)
Message-ID: <b42ec5e5-befe-4c1f-a3f2-944dcc66ad4f@redhat.com>
Date: Mon, 8 Jul 2024 18:15:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/19] hw/arm/smmu: Support nesting in the rest of
 commands
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-15-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240701110241.2005222-15-smostafa@google.com>
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



On 7/1/24 13:02, Mostafa Saleh wrote:
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

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Eric

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


