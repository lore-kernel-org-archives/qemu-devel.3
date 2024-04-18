Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03484C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 12:53:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxRFK-000059-Fa; Thu, 18 Apr 2024 08:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rxRFI-0008Vo-MM
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 08:52:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1rxRFG-0000dt-Ox
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 08:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713444725;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=A41FhCSxupmqIC7HJofH8JMJ/ww9mWA6JtBS9LbA+rs=;
 b=GzYmVZeJWNM/BkJi0jB6f5bkZn1ccYhpcZs33UdQLPEVEvczeIXa8FB/7z1ZmuNsV/6ug7
 NL5FLW09ixUi6liHcymtF/Jl19/cEdWTHZgQnbG69OBeWJ+iFCHZxJLA+acbtYXLddTdaV
 FpcCRFi3K3sMCAY6u8NwLq0jDyT48uY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-JjF1BXRENIChef0qQu6WQQ-1; Thu, 18 Apr 2024 08:52:04 -0400
X-MC-Unique: JjF1BXRENIChef0qQu6WQQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5176a78b813so1033618e87.1
 for <qemu-devel@nongnu.org>; Thu, 18 Apr 2024 05:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713444722; x=1714049522;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A41FhCSxupmqIC7HJofH8JMJ/ww9mWA6JtBS9LbA+rs=;
 b=aC/PXMuRwzjArqKBui+Q5TU2hOv+/X2DWCwlTlIclCB5anXvpnbUAeqP6ZkqI4Ua1/
 B5O0FUBA0tEjSMoUm8eHG5ERLbWBj4qdXBTNUc61VndF+9Ty8Y/ov6baFdDiYpP+M6uc
 4AF4Y9QnnC1l1F1qB1B2wP8GBm3znwwOONWOdP11pwf92uFdz+MkN/a4vWbCjhSiaZM/
 VX2S/OS2XIzRPl5mUqQfV367x2hNCHz6aBDBsjhl8TLdVJaA+YF9s5+YGnB0n2cdfQAb
 Q8DXGKeoM4t97VKPkkPF4GPXj+f9vN748XanPe8EMcGV5EyW308NwfAu02RoEAqmInDT
 ab4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX286KwrT2AUXEA9c+C67Ge8WsRyk5jk/OCzIsMLWya//MlG8CNWLWLyLeGe6skZx7wKeMjAexGTNdiNaIQ2eCe99r3h0o=
X-Gm-Message-State: AOJu0YxRT7dSmP+8Ersv81IT64ao8BTDDSRaZq47NX3+T3r5ihXIsgUF
 cKQDRd92Xj3f6ePw185EbRPt8QONpCPHdkdacz2Qv22qXUfFbN6LxeDAZEHA2cGm7n2xKm41yKa
 hhatB9f+KbrLpnjU51ghpbaH9yTbrWPrvI7NyW6MhzPTVoM+UhaqJ
X-Received: by 2002:a05:6512:368e:b0:516:ce34:e4fc with SMTP id
 d14-20020a056512368e00b00516ce34e4fcmr598961lfs.31.1713444722504; 
 Thu, 18 Apr 2024 05:52:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNioJn1jXiRr/k7qLI5dle6TfOLMlzZbYDac5A6wqxFbs+7k4KtCBRvZB7HZKBnoS9e4J1ug==
X-Received: by 2002:a05:6512:368e:b0:516:ce34:e4fc with SMTP id
 d14-20020a056512368e00b00516ce34e4fcmr598942lfs.31.1713444721974; 
 Thu, 18 Apr 2024 05:52:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 w1-20020ac254a1000000b00516d264366fsm223809lfk.245.2024.04.18.05.52.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Apr 2024 05:52:01 -0700 (PDT)
Message-ID: <34b66166-9343-4c4e-836a-dbc605572ad3@redhat.com>
Date: Thu, 18 Apr 2024 14:51:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 04/13] hw/arm/smmuv3: Translate CD and TT using
 stage-2 table
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240408140818.3799590-1-smostafa@google.com>
 <20240408140818.3799590-5-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240408140818.3799590-5-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
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
> According to the user manual (ARM IHI 0070 F.b),
s/user manual/ARM SMMU architecture specification
> In "5.2 Stream Table Entry":
>  [51:6] S1ContextPtr
>  If Config[1] == 1 (stage 2 enabled), this pointer is an IPA translated by
>  stage 2 and the programmed value must be within the range of the IAS.
>
> In "5.4.1 CD notes":
>  The translation table walks performed from TTB0 or TTB1 are always performed
>  in IPA space if stage 2 translations are enabled.
>
> So translate both the CD and the TTBx in this patch if nested
translate the S1 context descriptor pointer and TTBx base addresses
through the S2 stage (IPA -> PA)

You may describe what you put in place to do the translation in the
commit msg, new functions, macro, ...
> translation is requested.
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  hw/arm/smmuv3.c              | 49 ++++++++++++++++++++++++++++++------
>  include/hw/arm/smmu-common.h | 17 +++++++++++++
>  2 files changed, 59 insertions(+), 7 deletions(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 897f8fe085..a7cf543acc 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -337,14 +337,36 @@ static int smmu_get_ste(SMMUv3State *s, dma_addr_t addr, STE *buf,
>  
>  }
>  
> +static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
> +                                                 SMMUTransCfg *cfg,
> +                                                 SMMUEventInfo *event,
> +                                                 IOMMUAccessFlags flag,
> +                                                 SMMUTLBEntry **out_entry);
>  /* @ssid > 0 not supported yet */
> -static int smmu_get_cd(SMMUv3State *s, STE *ste, uint32_t ssid,
> -                       CD *buf, SMMUEventInfo *event)
> +static int smmu_get_cd(SMMUv3State *s, STE *ste, SMMUTransCfg *cfg,
> +                       uint32_t ssid, CD *buf, SMMUEventInfo *event)
>  {
>      dma_addr_t addr = STE_CTXPTR(ste);
>      int ret, i;
> +    SMMUTranslationStatus status;
> +    SMMUTLBEntry *entry;
>  
>      trace_smmuv3_get_cd(addr);
> +
> +    if (cfg->stage == SMMU_NESTED) {
> +        CALL_FUNC_CFG_S2(cfg, status, smmuv3_do_translate, s, addr,
> +                         cfg, event, IOMMU_RO, &entry);
the fact we pass 2 times cfg looks pretty weird from a caller pov. See
my comment below.

do we somewhere check addr is within the proper addr range, IAS if S2,
OAS if S1. This was missing for S1 but I think it is worth improving now.
see 3.4.3
> +        /*
> +         * It is not clear what should happen if this fails, so we return here
> +         * which gets propagated as a translation error.
but the error event might be different, no?
> +         */
> +        if (status != SMMU_TRANS_SUCCESS) {
> +            return -EINVAL;
> +        }
> +
> +        addr = CACHED_ENTRY_TO_ADDR(entry, addr);
> +    }
> +
>      /* TODO: guarantee 64-bit single-copy atomicity */
>      ret = dma_memory_read(&address_space_memory, addr, buf, sizeof(*buf),
>                            MEMTXATTRS_UNSPECIFIED);
> @@ -659,10 +681,13 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>      return 0;
>  }
>  
> -static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
> +static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
> +                     CD *cd, SMMUEventInfo *event)
>  {
>      int ret = -EINVAL;
>      int i;
> +    SMMUTranslationStatus status;
> +    SMMUTLBEntry *entry;
>  
>      if (!CD_VALID(cd) || !CD_AARCH64(cd)) {
>          goto bad_cd;
> @@ -713,6 +738,17 @@ static int decode_cd(SMMUTransCfg *cfg, CD *cd, SMMUEventInfo *event)
>  
>          tt->tsz = tsz;
>          tt->ttb = CD_TTB(cd, i);
> +
> +        /* Translate the TTBx, from IPA to PA if nesting is enabled. */
> +        if (cfg->stage == SMMU_NESTED) {
> +            CALL_FUNC_CFG_S2(cfg, status, smmuv3_do_translate, s,
> +                             tt->ttb, cfg, event, IOMMU_RO, &entry);
> +            /* See smmu_get_cd(). */
ditto
> +            if (status != SMMU_TRANS_SUCCESS) {
> +                return -EINVAL;
> +            }
> +            tt->ttb = CACHED_ENTRY_TO_ADDR(entry, tt->ttb);
> +        }
>          if (tt->ttb & ~(MAKE_64BIT_MASK(0, cfg->oas))) {
>              goto bad_cd;
>          }
> @@ -767,12 +803,12 @@ static int smmuv3_decode_config(IOMMUMemoryRegion *mr, SMMUTransCfg *cfg,
>          return 0;
>      }
>  
> -    ret = smmu_get_cd(s, &ste, 0 /* ssid */, &cd, event);
> +    ret = smmu_get_cd(s, &ste, cfg, 0 /* ssid */, &cd, event);
>      if (ret) {
>          return ret;
>      }
>  
> -    return decode_cd(cfg, &cd, event);
> +    return decode_cd(s, cfg, &cd, event);
>  }
>  
>  /**
> @@ -942,8 +978,7 @@ epilogue:
>      switch (status) {
>      case SMMU_TRANS_SUCCESS:
>          entry.perm = cached_entry->entry.perm;
> -        entry.translated_addr = cached_entry->entry.translated_addr +
> -                                    (addr & cached_entry->entry.addr_mask);
> +        entry.translated_addr = CACHED_ENTRY_TO_ADDR(cached_entry, addr);
>          entry.addr_mask = cached_entry->entry.addr_mask;
>          trace_smmuv3_translate_success(mr->parent_obj.name, sid, addr,
>                                         entry.translated_addr, entry.perm,
> diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
> index 96eb017e50..2772175115 100644
> --- a/include/hw/arm/smmu-common.h
> +++ b/include/hw/arm/smmu-common.h
> @@ -37,6 +37,23 @@
>  #define VMSA_IDXMSK(isz, strd, lvl)         ((1ULL << \
>                                               VMSA_BIT_LVL(isz, strd, lvl)) - 1)
>  
> +#define CACHED_ENTRY_TO_ADDR(ent, addr)      (ent)->entry.translated_addr + \
> +                                             ((addr) & (ent)->entry.addr_mask);
> +
> +/*
> + * From nested context, some functions might need to translate IPA addresses.
> + * As cfg has SMMU_NESTED, this won't work, this macro calls a function with
> + * making it a stage-2 cfg and then restore it after.
> + */
> +#define CALL_FUNC_CFG_S2(cfg, ret, fn, ...)  ({ \
> +                                                   int asid = cfg->asid; \
> +                                                   cfg->stage = SMMU_STAGE_2; \
> +                                                   cfg->asid = -1; \
> +                                                   ret = fn(__VA_ARGS__); \
At this stage of the reading this is not obvious why you need fn()
parameter, can't you simply call

smmuv3_do_translate(). If this is useful at some point in the series, you shall document that in the commit msg. 
Also I think I would prefer a proper function instead of this macro.

Besides, can't we add an extra parameter to the translate function forcing the S2_only translation although the cfg is a nested one. I think this would make things clearer

> +                                                   cfg->asid = asid; \
> +                                                   cfg->stage = SMMU_NESTED; \
> +                                              })
> +
>  /*
>   * Page table walk error types
>   */
Thanks

Eric


