Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7B6C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 07:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxMdG-000637-3C; Thu, 18 Apr 2024 03:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rxMdB-00062b-F1
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 03:56:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rxMd9-0003BR-7j
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 03:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713426985;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+AJRVK1J2Bm1IOcAddMTRzH20GLdSfC9QEoO87nKsR0=;
 b=AWGwoUFcy74u6NFaIgW/hCM2QsyM+YLNa0Od64Ve4Ymc9LWuucpm4gpPykY/OEoV9bTjhj
 1GACgcVs8QpS6HqcUorpF8B1aPIJJ52vxe4QEbNbbtMmpuqPA7MVBDODsQN2GZs9wbGz5I
 X0LWnVCO7IsIPeS/f4QHluOgnSuNnHM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-QyGD7hxOOeq0PUevHrJIZA-1; Thu, 18 Apr 2024 03:56:23 -0400
X-MC-Unique: QyGD7hxOOeq0PUevHrJIZA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-78f08178393so157734585a.1
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 00:56:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713426983; x=1714031783;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+AJRVK1J2Bm1IOcAddMTRzH20GLdSfC9QEoO87nKsR0=;
 b=bJIwWogfyea+1top8PFeacrKp063p74E5He+nTZnRTgi9zYzXJgeKx110YDxbzxwO2
 IFHQTJFyuQp3v6OluDvFIMx1cUBySpxPgv5whLtrv/iiqJJkLoLhq+NMSSZnTNrwHwdb
 oDyg5r0wcnvrEoHulQ4RHrC6eR7utsX/SCM/CnLByR2UORZN2xvgOAdQLFgGMVqEXHxq
 m7w/Dt5WFK2gUC+3ZEeOmVS0ES4EgiZSZDt5PUD76QAoLz3IsVHfX18J3hX343xxE08V
 sovgvY18BjzKgh7T+l/VuqXcGqTXFuRlovSPIMBfHzrZIaIgGZhABu5JzI7lrbK+Ge8b
 jlzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwWlxWAuzQiBpq8mZTff8MHDQoLkK0e9ch+d+sH4B8a2QxhU0K/qA2Z/Kd7wgCZTQ+VKrw2LbsI1c7jqcGdkx2lghRhgA=
X-Gm-Message-State: AOJu0Yxex+uj7kEjglz1gcTd5nqg7Tk2M14yNbwDvEs5ut0GvafzjAxc
 XF6aubMftDXBElaHJ9ES4eCNfiGjIFE5w2jNDpVADpNAk6muID4SWZq85n1xAnHASyefwPIuKfY
 Bqe/A9eTGs3y9dZBukmlqzoFskC1c5+t4wcRmiVFbH00ZbHQbcX5R
X-Received: by 2002:a05:620a:40c3:b0:78d:68f2:11af with SMTP id
 g3-20020a05620a40c300b0078d68f211afmr2564028qko.23.1713426982886; 
 Thu, 18 Apr 2024 00:56:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqBd5trvbhrBaKzfVhby8oVW4m43A5tllZVeebv10lyGpM0JxtpqlGRG4rJfyl3xvIFiDD+g==
X-Received: by 2002:a05:620a:40c3:b0:78d:68f2:11af with SMTP id
 g3-20020a05620a40c300b0078d68f211afmr2564017qko.23.1713426982521; 
 Thu, 18 Apr 2024 00:56:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 y21-20020a05620a44d500b0078ecd71114dsm413360qkp.69.2024.04.18.00.56.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 00:56:21 -0700 (PDT)
Message-ID: <74b42fab-7731-4826-974f-dec9f0413b7d@redhat.com>
Date: Thu, 18 Apr 2024 09:56:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 03/13] hw/arm/smmu: Consolidate ASID and VMID types
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240408140818.3799590-1-smostafa@google.com>
 <20240408140818.3799590-4-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240408140818.3799590-4-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
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
> ASID and VMID used to be uint16_t in the translation config, however,
> in other contexts they can be int as -1 in case of TLB invalidation,
> to represent all(don’t care).
> When stage-2 was added asid was set to -1 in stage-2 and vmid to -1
> in stage-1 configs. However, that meant they were set as (65536),
> this was not an issue as nesting was not supported and no
> commands/lookup targets both.
>
> With nesting, it’s critical to get this right as translation must be
> tagged correctly with ASID/VMID, and with ASID=-1 meaning stage-2.
> Represent ASID/VMID everywhere as int.

small conflict  due to
0b796f3810  hw/arm/smmu: Avoid using inlined functions with external
linkage again

Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  hw/arm/smmu-common.c         | 10 +++++-----
>  hw/arm/smmuv3.c              |  4 ++--
>  include/hw/arm/smmu-common.h | 14 +++++++-------
>  3 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index 20630eb670..771b9c79a3 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -57,7 +57,7 @@ static gboolean smmu_iotlb_key_equal(gconstpointer v1, gconstpointer v2)
>             (k1->vmid == k2->vmid);
>  }
>  
> -SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint16_t vmid, uint64_t iova,
> +SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
>                                  uint8_t tg, uint8_t level)
>  {
>      SMMUIOTLBKey key = {.asid = asid, .vmid = vmid, .iova = iova,
> @@ -130,7 +130,7 @@ void smmu_iotlb_inv_all(SMMUState *s)
>  static gboolean smmu_hash_remove_by_asid(gpointer key, gpointer value,
>                                           gpointer user_data)
>  {
> -    uint16_t asid = *(uint16_t *)user_data;
> +    int asid = *(int *)user_data;
>      SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
>  
>      return SMMU_IOTLB_ASID(*iotlb_key) == asid;
> @@ -139,7 +139,7 @@ static gboolean smmu_hash_remove_by_asid(gpointer key, gpointer value,
>  static gboolean smmu_hash_remove_by_vmid(gpointer key, gpointer value,
>                                           gpointer user_data)
>  {
> -    uint16_t vmid = *(uint16_t *)user_data;
> +    int vmid = *(int *)user_data;
>      SMMUIOTLBKey *iotlb_key = (SMMUIOTLBKey *)key;
>  
>      return SMMU_IOTLB_VMID(*iotlb_key) == vmid;
> @@ -191,13 +191,13 @@ void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>                                  &info);
>  }
>  
> -void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid)
> +void smmu_iotlb_inv_asid(SMMUState *s, int asid)
>  {
>      trace_smmu_iotlb_inv_asid(asid);
>      g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_asid, &asid);
>  }
>  
> -inline void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid)
> +inline void smmu_iotlb_inv_vmid(SMMUState *s, int vmid)
>  {
>      trace_smmu_iotlb_inv_vmid(vmid);
>      g_hash_table_foreach_remove(s->iotlb, smmu_hash_remove_by_vmid, &vmid);
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index f081ff0cc4..897f8fe085 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1235,7 +1235,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>          }
>          case SMMU_CMD_TLBI_NH_ASID:
>          {
> -            uint16_t asid = CMD_ASID(&cmd);
> +            int asid = CMD_ASID(&cmd);
>  
>              if (!STAGE1_SUPPORTED(s)) {
>                  cmd_error = SMMU_CERROR_ILL;
> @@ -1268,7 +1268,7 @@ static int smmuv3_cmdq_consume(SMMUv3State *s)
>              break;
>          case SMMU_CMD_TLBI_S12_VMALL:
>          {
> -            uint16_t vmid = CMD_VMID(&cmd);
> +            int vmid = CMD_VMID(&cmd);
>  
>              if (!STAGE2_SUPPORTED(s)) {
>                  cmd_error = SMMU_CERROR_ILL;
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 5944735632..96eb017e50 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -84,7 +84,7 @@ typedef struct SMMUS2Cfg {
>      bool record_faults;     /* Record fault events (S2R) */
>      uint8_t granule_sz;     /* Granule page shift (based on S2TG) */
>      uint8_t eff_ps;         /* Effective PA output range (based on S2PS) */
> -    uint16_t vmid;          /* Virtual Machine ID (S2VMID) */
> +    int vmid;               /* Virtual Machine ID (S2VMID) */
>      uint64_t vttb;          /* Address of translation table base (S2TTB) */
>  } SMMUS2Cfg;
>  
> @@ -108,7 +108,7 @@ typedef struct SMMUTransCfg {
>      uint64_t ttb;              /* TT base address */
>      uint8_t oas;               /* output address width */
>      uint8_t tbi;               /* Top Byte Ignore */
> -    uint16_t asid;
> +    int asid;
>      SMMUTransTableInfo tt[2];
>      /* Used by stage-2 only. */
>      struct SMMUS2Cfg s2cfg;
> @@ -132,8 +132,8 @@ typedef struct SMMUPciBus {
>  
>  typedef struct SMMUIOTLBKey {
>      uint64_t iova;
> -    uint16_t asid;
> -    uint16_t vmid;
> +    int asid;
> +    int vmid;
>      uint8_t tg;
>      uint8_t level;
>  } SMMUIOTLBKey;
> @@ -205,11 +205,11 @@ IOMMUMemoryRegion *smmu_iommu_mr(SMMUState *s, uint32_t sid);
>  SMMUTLBEntry *smmu_iotlb_lookup(SMMUState *bs, SMMUTransCfg *cfg,
>                                  SMMUTransTableInfo *tt, hwaddr iova);
>  void smmu_iotlb_insert(SMMUState *bs, SMMUTransCfg *cfg, SMMUTLBEntry *entry);
> -SMMUIOTLBKey smmu_get_iotlb_key(uint16_t asid, uint16_t vmid, uint64_t iova,
> +SMMUIOTLBKey smmu_get_iotlb_key(int asid, int vmid, uint64_t iova,
>                                  uint8_t tg, uint8_t level);
>  void smmu_iotlb_inv_all(SMMUState *s);
> -void smmu_iotlb_inv_asid(SMMUState *s, uint16_t asid);
> -void smmu_iotlb_inv_vmid(SMMUState *s, uint16_t vmid);
> +void smmu_iotlb_inv_asid(SMMUState *s, int asid);
> +void smmu_iotlb_inv_vmid(SMMUState *s, int vmid);
>  void smmu_iotlb_inv_iova(SMMUState *s, int asid, int vmid, dma_addr_t iova,
>                           uint8_t tg, uint64_t num_pages, uint8_t ttl);
>  


