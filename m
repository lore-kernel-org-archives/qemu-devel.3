Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A87BC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 13:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s92t2-0000Dq-4i; Mon, 20 May 2024 09:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s92sl-0000Bu-UJ
 for qemu-devel@nongnu.org; Mon, 20 May 2024 09:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s92si-0001Bm-8U
 for qemu-devel@nongnu.org; Mon, 20 May 2024 09:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716211006;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pVZkvusaM0CkwClRERHObKOMN2wWsmfdEdfvVwoQBIw=;
 b=GvcoNz0EdgQ78hvhmq6i2lqFHQwHwaonaFzKogyasmS0CXXBbHq4dN8QwoSQrJ3LFeGUyA
 p+dy2iSoUSOH+fEqYUWGypXLhqY4TTTWEpF7dg5Spt8DNSVVHjf1VNp0M/SsA8j7B1RGyK
 Y9SHqWYKDh0/Z4PIjHfbK8umTNw5qFM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-UXj8NqfbPfKji7cRlqzw0A-1; Mon, 20 May 2024 09:16:44 -0400
X-MC-Unique: UXj8NqfbPfKji7cRlqzw0A-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a5a1b50d45cso685996966b.2
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 06:16:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716211003; x=1716815803;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pVZkvusaM0CkwClRERHObKOMN2wWsmfdEdfvVwoQBIw=;
 b=qt+NfCevCNDDzVXGyiJLqhg+ai093his5memufz2LOPGPKQN7Ez4c3uSOWqlUP13th
 m5OGfzWeO465zQPq0+2uGOWDED2J94YR9dgpY4zWN0qGB7JPXKxI3GJ22sKkBHdGTntT
 WWvztD2LRLXUfzU752jBPlIumU8ArAnaDekhyGVSMHL+wMjT1TnEnUbuLHshBOYg+TnS
 2xrRxYuO3IwocU+bHPsARZpMGDH0lHvUwFEltcfXK0KFO3Qb7IFelUCtFL8FvQ3Lf6mx
 +QL96/w8GGzCa5uW+9sRrWQU+qtgsltn+aTMEXFj/HO8jlV2mMCZMB+eJHkELE4MFSUi
 AtwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZWgjiyyhDuPY0q9Ll+3kPdwdKz7hbLlWBKyOZTUEGlAiPiWDVx/ozQiHTBr0+g53/++oWy+SWHXHOjMJPMchf+Vo7R2w=
X-Gm-Message-State: AOJu0YxL2ZamgxAIf9RpOYzj7LNoaY0UciUDWcqc9hj3XPUSYBbYxg5b
 J/vbnjin8AI/Ol3KZm6B0crRZM6nGuUNAj96tvDs9eGxr0Bz28OaJBFbbH9OEGv/3UcWUba+r2T
 7I8ds/WXZIae3p1Imk1/Zy31f1vHMvVaSxyhdrAcZKFfKPPBDg4/A
X-Received: by 2002:a17:906:b0c:b0:a59:b342:3ed5 with SMTP id
 a640c23a62f3a-a5a2d54d194mr1958214066b.15.1716211003051; 
 Mon, 20 May 2024 06:16:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFznu5A5EksWqXKUnpRfUQgi5TKTlELmt6cN55JFjdB5JEzPVn/5Bcb8hZ2q7/naHdYddCxTQ==
X-Received: by 2002:a17:906:b0c:b0:a59:b342:3ed5 with SMTP id
 a640c23a62f3a-a5a2d54d194mr1958211066b.15.1716211002535; 
 Mon, 20 May 2024 06:16:42 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781d6bfsm1452021366b.31.2024.05.20.06.16.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 May 2024 06:16:42 -0700 (PDT)
Message-ID: <38005c2a-0e1d-4140-b046-8fbc82be7d8c@redhat.com>
Date: Mon, 20 May 2024 15:16:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 14/18] hw/arm/smmuv3: Support and advertise nesting
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-15-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240429032403.74910-15-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 4/29/24 05:23, Mostafa Saleh wrote:
> Everything is in place, add the last missing bits:
> - Handle fault checking according to the actual PTW event and not the
>   the translation stage.
missing the "why". Can't it be moved in a separate patch?
> - Consolidate parsing of STE cfg and setting translation stage.
>
> Advertise nesting if stage requested is "nested".
I would move the introduction of the nested option in a separate patch
and in the associated commit msg properly document how the new option
shall be used.
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  hw/arm/smmuv3.c | 50 +++++++++++++++++++++++++++++++++----------------
>  1 file changed, 34 insertions(+), 16 deletions(-)
>
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 96d07234fe..88f6473d33 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -34,9 +34,10 @@
>  #include "smmuv3-internal.h"
>  #include "smmu-internal.h"
>  
> -#define PTW_RECORD_FAULT(cfg)   (((cfg)->stage == SMMU_STAGE_1) ? \
> -                                 (cfg)->record_faults : \
> -                                 (cfg)->s2cfg.record_faults)
> +#define PTW_RECORD_FAULT(ptw_info, cfg) (((ptw_info).stage == SMMU_STAGE_1 && \
> +                                        (cfg)->record_faults) || \
> +                                        ((ptw_info).stage == SMMU_STAGE_2 && \
> +                                        (cfg)->s2cfg.record_faults))
>  
>  /**
>   * smmuv3_trigger_irq - pulse @irq if enabled and update
> @@ -260,6 +261,9 @@ static void smmuv3_init_regs(SMMUv3State *s)
>      /* Based on sys property, the stages supported in smmu will be advertised.*/
>      if (s->stage && !strcmp("2", s->stage)) {
>          s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S2P, 1);
> +    } else if (s->stage && !strcmp("nested", s->stage)) {
> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S1P, 1);
> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S2P, 1);
>      } else {
>          s->idr[0] = FIELD_DP32(s->idr[0], IDR0, S1P, 1);
>      }
> @@ -422,8 +426,6 @@ static bool s2_pgtable_config_valid(uint8_t sl0, uint8_t t0sz, uint8_t gran)
>  
>  static int decode_ste_s2_cfg(SMMUTransCfg *cfg, STE *ste)
>  {
> -    cfg->stage = SMMU_STAGE_2;
> -
>      if (STE_S2AA64(ste) == 0x0) {
>          qemu_log_mask(LOG_UNIMP,
>                        "SMMUv3 AArch32 tables not supported\n");
> @@ -506,6 +508,27 @@ bad_ste:
>      return -EINVAL;
>  }
>  
> +static void decode_ste_config(SMMUTransCfg *cfg, uint32_t config)
> +{
> +
> +    if (STE_CFG_ABORT(config)) {
> +        cfg->aborted = true;
> +        return;
> +    }
> +    if (STE_CFG_BYPASS(config)) {
> +        cfg->bypassed = true;
> +        return;
> +    }
> +
> +    if (STE_CFG_S1_ENABLED(config)) {
> +        cfg->stage = SMMU_STAGE_1;
> +    }
> +
> +    if (STE_CFG_S2_ENABLED(config)) {
> +        cfg->stage |= SMMU_STAGE_2;
> +    }
> +}
> +
>  /* Returns < 0 in case of invalid STE, 0 otherwise */
>  static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
>                        STE *ste, SMMUEventInfo *event)
> @@ -522,13 +545,9 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
>  
>      config = STE_CONFIG(ste);
>  
> -    if (STE_CFG_ABORT(config)) {
> -        cfg->aborted = true;
> -        return 0;
> -    }
> +    decode_ste_config(cfg, config);
>  
> -    if (STE_CFG_BYPASS(config)) {
> -        cfg->bypassed = true;
> +    if (cfg->aborted || cfg->bypassed) {
>          return 0;
>      }
>  
> @@ -701,7 +720,6 @@ static int decode_cd(SMMUv3State *s, SMMUTransCfg *cfg,
>  
>      /* we support only those at the moment */
>      cfg->aa64 = true;
> -    cfg->stage = SMMU_STAGE_1;
>  
>      cfg->oas = oas2bits(CD_IPS(cd));
>      cfg->oas = MIN(oas2bits(SMMU_IDR5_OAS), cfg->oas);
> @@ -901,7 +919,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>              event->u.f_walk_eabt.addr2 = ptw_info.addr;
>              break;
>          case SMMU_PTW_ERR_TRANSLATION:
> -            if (PTW_RECORD_FAULT(cfg)) {
> +            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
>                  event->type = SMMU_EVT_F_TRANSLATION;
>                  event->u.f_translation.addr = addr;
>                  event->u.f_translation.addr2 = ptw_info.addr;
> @@ -910,7 +928,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>              }
>              break;
>          case SMMU_PTW_ERR_ADDR_SIZE:
> -            if (PTW_RECORD_FAULT(cfg)) {
> +            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
>                  event->type = SMMU_EVT_F_ADDR_SIZE;
>                  event->u.f_addr_size.addr = addr;
>                  event->u.f_addr_size.addr2 = ptw_info.addr;
> @@ -919,7 +937,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>              }
>              break;
>          case SMMU_PTW_ERR_ACCESS:
> -            if (PTW_RECORD_FAULT(cfg)) {
> +            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
>                  event->type = SMMU_EVT_F_ACCESS;
>                  event->u.f_access.addr = addr;
>                  event->u.f_access.addr2 = ptw_info.addr;
> @@ -928,7 +946,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>              }
>              break;
>          case SMMU_PTW_ERR_PERMISSION:
> -            if (PTW_RECORD_FAULT(cfg)) {
> +            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
>                  event->type = SMMU_EVT_F_PERMISSION;
>                  event->u.f_permission.addr = addr;
>                  event->u.f_permission.addr2 = ptw_info.addr;
Thanks

Eric


