Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D861DC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 11:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6U9x-0003zd-AF; Mon, 13 May 2024 07:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s6U9q-0003tK-UH
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:47:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s6U9o-0004aP-PT
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:47:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715600871;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cYI058oCZP5dRs8SiHki1bY0FtB7y7O7BEdWatNL1Fk=;
 b=MHG8qryKCRs+onnC08LetLZC2arSKJtWaOvnxi1F5AjlnchiVQRKMH2InWKr5BKjkvjUmR
 ZLJYVdXQ4rf6EdyV6Q4N9TAfuNLhPhPxo+v0t8hhZJ2h1vllleqwvjRb+ItdmlPj244nuG
 ySe85HVWRaySgaeci9Kv8c8wi6MjrUU=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-vEWLS1FVNMCD1JlHZsiAog-1; Mon, 13 May 2024 07:47:49 -0400
X-MC-Unique: vEWLS1FVNMCD1JlHZsiAog-1
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-4df237c3edaso3206726e0c.2
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 04:47:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715600869; x=1716205669;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cYI058oCZP5dRs8SiHki1bY0FtB7y7O7BEdWatNL1Fk=;
 b=gj9p9iGVkrtdQaCOEg/tt0uaFZvvnY8eIisKqWDOurlc8g04Qaz60X2uezBzb8UFgo
 kbxzZR3NOm9LS0PwAMXz6RuTzNfxas389f6E09XjodLXI4EmlGoj2/YIz59F2XTvjzl3
 e+bbAwDgI0iB2D/6ZfUL2hz1oeLFj0bYXohujB7EPrzaArwgbnr4aTx0tN5nrZRnv+oA
 oEv7f9ZCAIRZMiJIz5zRGB55FTYNulpw5xUFXufeu7zXeEDpvX3fq+qo+NFVRs4TxWyO
 SrjHzocdCpDY4pFHu1slzTxFmR8lHJAO/c5p54bkIpJ5I6XPRtKYYwozvuG0X25TwXnU
 FZBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS9bM0EjYPNeL51bzZxMQqNtH7nGObx9InZLPrU1IIDTPBdAEM2X+6zZc1rJ+8SoATJUxzi3yoNIJEB9mPnVZ5jtpf3Mk=
X-Gm-Message-State: AOJu0YzAIrm3WFcNcsdaXuXqGyPri3zlvX9i3fESO38oLZ9GpDVWouJS
 PMFT++hJqOkvbEe5Ga331NOPDmAvmjpSCd2G1/cXwmbtc8dHu5Rj+No0Trib56wkH2bAWr2dPds
 VRxa/0QDDML71e9L4wjUMs/ygEkJLtFsiNKy/pMbpA73duYKx99eP
X-Received: by 2002:a05:6122:1806:b0:4d3:b326:5ae8 with SMTP id
 71dfb90a1353d-4df8838024emr7760800e0c.14.1715600869147; 
 Mon, 13 May 2024 04:47:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM4Ehh1ScrSdKoJTVKgbFYKhVFdcILL8wcPwUA+eMCHu+tpkNi5MjlNpuh9f+fNyOz91U0+Q==
X-Received: by 2002:a05:6122:1806:b0:4d3:b326:5ae8 with SMTP id
 71dfb90a1353d-4df8838024emr7760778e0c.14.1715600868706; 
 Mon, 13 May 2024 04:47:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-792bf310c16sm447321185a.114.2024.05.13.04.47.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 04:47:48 -0700 (PDT)
Message-ID: <4161c29f-411c-480e-abca-84e8963ce0ab@redhat.com>
Date: Mon, 13 May 2024 13:47:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 02/18] hw/arm/smmu: Fix IPA for stage-2 events
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-3-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240429032403.74910-3-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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
> For the following events (ARM IHI 0070 F.b - 7.3 Event records):
> - F_TRANSLATION
> - F_ACCESS
> - F_PERMISSION
> - F_ADDR_SIZE
>
> If fault occurs at stage 2, S2 == 1 and:
>   - If translating an IPA for a transaction (whether by input to
>     stage 2-only configuration, or after successful stage 1 translation),
>     CLASS == IN, and IPA is provided.
CLASS == IN sounds a bit confusing here since the class value depends on
what is being translated and class is not handled in that patch.
>
> However, this was not implemented correctly, as for stage 2, we Qemu
s/we QEMU/ the code
> only sets the  S2 bit but not the IPA.
If this is a fix, please add the "Fixes:" tag and fixed commit sha1.
>
> This field has the same bits as FetchAddr in F_WALK_EABT which is
> populated correctly, so we don’t change that.
> The population of this field should be done from the walker as the IPA address
s/population/setting? I am not a native english speaker though
> wouldn't be known in case of nesting.
>
> For stage 1, the spec says:
>   If fault occurs at stage 1, S2 == 0 and:
>   CLASS == IN, IPA is UNKNOWN.
>
> So, no need to set it to for stage 1, as ptw_info is initialised by zero in
> smmuv3_translate().
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  hw/arm/smmu-common.c | 10 ++++++----
>  hw/arm/smmuv3.c      |  4 ++++
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
> index eb2356bc35..8a8c718e6b 100644
> --- a/hw/arm/smmu-common.c
> +++ b/hw/arm/smmu-common.c
> @@ -448,7 +448,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
>       */
>      if (ipa >= (1ULL << inputsize)) {
>          info->type = SMMU_PTW_ERR_TRANSLATION;
> -        goto error;
> +        goto error_ipa;
>      }
>  
>      while (level < VMSA_LEVELS) {
> @@ -494,13 +494,13 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
>           */
>          if (!PTE_AF(pte) && !cfg->s2cfg.affd) {
>              info->type = SMMU_PTW_ERR_ACCESS;
> -            goto error;
> +            goto error_ipa;
>          }
>  
>          s2ap = PTE_AP(pte);
>          if (is_permission_fault_s2(s2ap, perm)) {
>              info->type = SMMU_PTW_ERR_PERMISSION;
> -            goto error;
> +            goto error_ipa;
>          }
>  
>          /*
> @@ -509,7 +509,7 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
>           */
>          if (gpa >= (1ULL << cfg->s2cfg.eff_ps)) {
>              info->type = SMMU_PTW_ERR_ADDR_SIZE;
> -            goto error;
> +            goto error_ipa;
>          }
>  
>          tlbe->entry.translated_addr = gpa;
> @@ -522,6 +522,8 @@ static int smmu_ptw_64_s2(SMMUTransCfg *cfg,
>      }
>      info->type = SMMU_PTW_ERR_TRANSLATION;
>  
> +error_ipa:
> +    info->addr = ipa;
>  error:
>      info->stage = 2;
>      tlbe->entry.perm = IOMMU_NONE;
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 2d1e0d55ec..9dd3ea48e4 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -949,6 +949,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>              if (PTW_RECORD_FAULT(cfg)) {
>                  event.type = SMMU_EVT_F_TRANSLATION;
>                  event.u.f_translation.addr = addr;
> +                event.u.f_translation.addr2 = ptw_info.addr;
>                  event.u.f_translation.rnw = flag & 0x1;
>              }
>              break;
> @@ -956,6 +957,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>              if (PTW_RECORD_FAULT(cfg)) {
>                  event.type = SMMU_EVT_F_ADDR_SIZE;
>                  event.u.f_addr_size.addr = addr;
> +                event.u.f_addr_size.addr2 = ptw_info.addr;
>                  event.u.f_addr_size.rnw = flag & 0x1;
>              }
>              break;
> @@ -963,6 +965,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>              if (PTW_RECORD_FAULT(cfg)) {
>                  event.type = SMMU_EVT_F_ACCESS;
>                  event.u.f_access.addr = addr;
> +                event.u.f_access.addr2 = ptw_info.addr;
>                  event.u.f_access.rnw = flag & 0x1;
>              }
>              break;
> @@ -970,6 +973,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>              if (PTW_RECORD_FAULT(cfg)) {
>                  event.type = SMMU_EVT_F_PERMISSION;
>                  event.u.f_permission.addr = addr;
> +                event.u.f_permission.addr2 = ptw_info.addr;
>                  event.u.f_permission.rnw = flag & 0x1;
>              }
>              break;
>
After taking into account above comments,
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


