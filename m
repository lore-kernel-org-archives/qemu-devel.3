Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C7DC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 14:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxT4S-0000u1-JN; Thu, 18 Apr 2024 10:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rxT4C-0000sE-5Q
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 10:48:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rxT49-0006Ne-Nl
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 10:48:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713451725;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=enxY/DHRZLwIyCmI8664oAPoGfsD/JfngFCP4Fvyl8w=;
 b=gvtVks99fqFOxmOQJ+NwRDI8vqbemSLl0MzkzVYpeEmoEXlTAw1qYhvsHB0SeHfJVbJs2W
 bEOh1LUZBGOdTHSyOXpfj7ee1W2n2JK0GhDmqOfVwK5lP4LRFtUqmdUhG6hJxHBDnAFkJB
 9bsoAAal4BMc4ZQjQ2tDT1vKPShzYoA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-64uSKL2eMKuFyxvUsAx4aQ-1; Thu, 18 Apr 2024 10:48:43 -0400
X-MC-Unique: 64uSKL2eMKuFyxvUsAx4aQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5704900f94fso582826a12.1
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 07:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713451722; x=1714056522;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=enxY/DHRZLwIyCmI8664oAPoGfsD/JfngFCP4Fvyl8w=;
 b=RyCQHISmHXvlrdeQzQKkOvPiqnHOHKd/yqaOaOLkuQIDOeux3rUt0KvorF5xsYCoPG
 tDHGGOJ299byxWfko64O8K8t2N2Mm+V+l6Cq7TzwrP9Ct/LAxMCe0roH9HUMaXvwWUjD
 gLHsr4dPUom1rc/z2iea9P0N8gq9lNwUb9apkIgqun4GLj+ME9Eos5lh4LtAeYvD8es9
 vYcrje01AcPH6ej4E35UOJ3qX5G5XWNGiOILN7VQkKusUUsOgWHSCR8ekf+5wiMgwaTk
 Njky/nfZLnVPGb7WsPLTksm/DOQeaswSzKp7j2yIYkLPfBSTxrdagVrA6D4wY3JnGf20
 sZtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFpwT4YrzmyMw+9MPdVz5zQOQCKxZvXhBpBTd21qWGqMPWz7WUQRQsyZmog/rDAwE2LQdLvkm1eunqFHM+NaGdZ/Z8tYU=
X-Gm-Message-State: AOJu0Yz0hzNMa6vGIy25EbUHXRyAfVMDG5/ulRQR74ZicPKDoT35gjRI
 S0WAVnpcvPQAei92xWHvwiuU8fucdhMidVCxyJy2NkiErPHNnnMI3RtFbIMYZq8rELYu4T4Im0v
 S3nJxUYA5y7nyvW5Vq8oHt3/Z0sy628IwincYEo/lIzatyEkwuHvv
X-Received: by 2002:a17:906:4f8b:b0:a52:53f2:5ae0 with SMTP id
 o11-20020a1709064f8b00b00a5253f25ae0mr1863633eju.74.1713451722271; 
 Thu, 18 Apr 2024 07:48:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZjHCEl3WKHrjmayaOaPSImwNwiwNqlXD8/Gz1yTCv25gsjL4Z2YNS34uzf/rJov6E1khEkA==
X-Received: by 2002:a17:906:4f8b:b0:a52:53f2:5ae0 with SMTP id
 o11-20020a1709064f8b00b00a5253f25ae0mr1863618eju.74.1713451721870; 
 Thu, 18 Apr 2024 07:48:41 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 re27-20020a170906d8db00b00a521327b019sm987721ejb.197.2024.04.18.07.48.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 07:48:41 -0700 (PDT)
Message-ID: <cfb5e002-26d4-437a-91d5-7c2eb49a75b6@redhat.com>
Date: Thu, 18 Apr 2024 16:48:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 07/13] hw/arm/smmu: Support nesting in the rest of
 commands
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240408140818.3799590-1-smostafa@google.com>
 <20240408140818.3799590-8-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240408140818.3799590-8-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 4/8/24 16:08, Mostafa Saleh wrote:
> Some commands need rework for nesting, as they used to assume S1
> and S2 are mutually exclusive:
>
> - CMD_TLBI_NH_ASID: Consider VMID if stage-2 is supported
> - CMD_TLBI_NH_ALL: Consider VMID if stage-2 is supported, otherwise
>   invalidate everything, this required a new vmid invalidation
>   function for stage-1 only (ASID >= 0)
>
> Also, rework trace events to reflect the new implementation.

This does not apply for me. Could you share a branch or respin?

Thank you in advance

Eric
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  hw/arm/smmu-common.c         | 36 +++++++++++++++++++++++++++++-------
>  hw/arm/smmuv3.c              | 31 +++++++++++++++++++++++++++++--
>  hw/arm/trace-events          |  6 ++++--
>  include/hw/arm/smmu-common.h |  3 ++-
>  4 files changed, 64 insertions(+), 12 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 8b9e59b24b..b1cf1303c6 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -148,13 +148,14 @@ void smmu_iotlb_inv_all(SMMUState *s)
>      g_hash_table_remove_all(s->iotlb);
>  }
>  
> -static gboolean smmu_hash_remove_by_asid(gpointer key, gpointer value,
> -                                         gpointer user_data)
> +static gboolean smmu_hash_remove_by_asid_vmid(gpointer key, gpointer value,
> +                                              gpointer user_data)
>  {
> -    int asid = *(int *)user_data;
> +    SMMUIOTLBPageInvInfo *info = (SMMUIOTLBPageInvInfo *)user_data;
>      SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
>  
> -    return SMMU_IOTLB_ASID(*iotlb_key) == asid;
> +    return (SMMU_IOTLB_ASID(*iotlb_key) == info->asid) &&
> +           (SMMU_IOTLB_VMID(*iotlb_key) == info->vmid);
>  }
>  
>  static gboolean smmu_hash_remove_by_vmid(gpointer key, gpointer value,
> @@ -166,6 +167,16 @@ static gboolean smmu_hash_remove_by_vmid(gpointer key, gpointer value,
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
> @@ -259,10 +270,15 @@ void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,
>                                  &info);
>  }
>  
> -void smmu_iotlb_inv_asid(SMMUState *s, int asid)
> +void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid)
>  {
> -    trace_smmu_iotlb_inv_asid(asid);
> -    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid, &asid);
> +    SMMUIOTLBPageInvInfo info = {
> +        .asid = asid,
> +        .vmid = vmid,
> +    };
> +
> +    trace_smmu_iotlb_inv_asid_vmid(asid, vmid);
> +    g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid_vmid, &info);
>  }
>  
>  inline void smmu_iotlb_inv_vmid(SMMUState *s, int vmid)
> @@ -271,6 +287,12 @@ inline void smmu_iotlb_inv_vmid(SMMUState *s, int vmid)
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
> index 17bbd43c13..ece647b8bf 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1280,25 +1280,52 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
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
> +             * VMID is only matched when stage 2 is supported for the Security
> +             * state corresponding to the command queue that the command was
> +             * issued in.
> +             * QEMU ignores the field by setting to -1, similarly to what STE
> +             * decoding does. And invalidation commands ignore VMID < 0.
> +             */
> +            if (STAGE2_SUPPORTED(s)) {
> +                vmid = CMD_VMID(&cmd);
> +            }
> +
>              trace_smmuv3_cmdq_tlbi_nh_asid(asid);
>              smmu_inv_notifiers_all(&s->smmu_state);
> -            smmu_iotlb_inv_asid(bs, asid);
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
> +             * invalidate the whole thing, see SMMU_CMD_TLBI_NH_ASID()
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
> index f5c361d96e..2556f4721a 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -11,8 +11,9 @@ smmu_ptw_page_pte(int stage, int level,  uint64_t iova, uint64_t baseaddr, uint6
>  smmu_ptw_block_pte(int stage, int level, uint64_t baseaddr, uint64_t pteaddr, uint64_t pte, uint64_t iova, uint64_t gpa, int bsize_mb) "stage=%d level=%d base@=0x%"PRIx64" pte@=0x%"PRIx64" pte=0x%"PRIx64" iova=0x%"PRIx64" block address = 0x%"PRIx64" block size = %d MiB"
>  smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pte) "baseaddr=0x%"PRIx64" index=0x%x, pteaddr=0x%"PRIx64", pte=0x%"PRIx64
>  smmu_iotlb_inv_all(void) "IOTLB invalidate all"
> -smmu_iotlb_inv_asid(uint16_t asid) "IOTLB invalidate asid=%d"
> +smmu_iotlb_inv_asid_vmid(int asid, uint16_t vmid) "IOTLB invalidate asid=%d vmid=%d"
>  smmu_iotlb_inv_vmid(uint16_t vmid) "IOTLB invalidate vmid=%d"
> +smmu_iotlb_inv_vmid_s1(uint16_t vmid) "IOTLB invalidate vmid=%d"
>  smmu_iotlb_inv_iova(uint16_t asid, uint64_t addr) "IOTLB invalidate asid=%d addr=0x%"PRIx64
>  smmu_inv_notifiers_mr(const char *name) "iommu mr=%s"
>  smmu_iotlb_lookup_hit(int asid, uint16_t vmid, uint64_t addr, uint64_t mask, uint32_t hit, uint32_t miss, uint32_t p) "IOTLB cache HIT asid=%d vmid=%d addr=0x%"PRIx64" mask=0x%"PRIx64" hit=%d miss=%d hit rate=%d"
> @@ -47,7 +48,8 @@ smmuv3_cmdq_cfgi_cd(uint32_t sid) "sid=0x%x"
>  smmuv3_config_cache_hit(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache HIT for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
>  smmuv3_config_cache_miss(uint32_t sid, uint32_t hits, uint32_t misses, uint32_t perc) "Config cache MISS for sid=0x%x (hits=%d, misses=%d, hit rate=%d)"
>  smmuv3_range_inval(int vmid, int asid, uint64_t addr, uint8_t tg, uint64_t num_pages, uint8_t ttl, bool leaf, int stage) "vmid=%d asid=%d addr=0x%"PRIx64" tg=%d num_pages=0x%"PRIx64" ttl=%d leaf=%d stage=%d"
> -smmuv3_cmdq_tlbi_nh(void) ""
> +smmuv3_cmdq_tlbi_nh(int vmid) "vmid=%d"
> +smmuv3_cmdq_tlbi_nsnh(void) ""
>  smmuv3_cmdq_tlbi_nh_asid(uint16_t asid) "asid=%d"
>  smmuv3_cmdq_tlbi_s12_vmid(uint16_t vmid) "vmid=%d"
>  smmuv3_config_cache_inv(uint32_t sid) "Config cache INV for sid=0x%x"
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index df166d8477..67db30e85b 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -226,8 +226,9 @@ void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
>  SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
>                                  uint8_t tg, uint8_t level);
>  void smmu_iotlb_inv_all(SMMUState *s);
> -void smmu_iotlb_inv_asid(SMMUState *s, int asid);
> +void smmu_iotlb_inv_asid_vmid(SMMUState *s, int asid, int vmid);
>  void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
> +void smmu_iotlb_inv_vmid_s1(SMMUState *s, int vmid);
>  void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>                           uint8_t tg, uint64_t num_pages, uint8_t ttl);
>  void smmu_iotlb_inv_ipa(SMMUState *s, int vmid, dma_addr_t ipa, uint8_t tg,


