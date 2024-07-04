Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E602C3271F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 18:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPRJg-00034I-5v; Thu, 04 Jul 2024 14:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPRJe-00033j-Dm
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:36:22 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPRJc-0005Ri-Jt
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:36:22 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-425624255f3so6023345e9.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 11:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720118168; x=1720722968; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xUcX8OSnZPAM+qJh3gAPm0zyGoKendARxFQeDBD8NZA=;
 b=dnoOaSzpLDrihEY0bYK7UuuoFTXL340A7mwtxlqyy7hz95mQm3blDEAEE1/EFqmeGD
 3uoTTI7KKfMcu2WGM5/9rnpnSEgOgvjs7jwhYtwAmNtx857y65QXhuAALqaNsGQmOjYg
 +aso32nd/NNIuXqMnhThyDxoj1J5WEHzZOAUVOMMPetDQwqZ2UN/7yPJTxDuHScbKeJt
 GX95A5pORbrVfys1JaFe4atOS+uwFEOJPrY6XptFToX03H2KHHf3DG7IZoe4YgYcw/zz
 T324NvcjSaofisKgQMHh4bjqHpGjh8nYiwBM/grIji4lao3u/dRiBFkg434FLTpu/qxI
 MmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720118168; x=1720722968;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xUcX8OSnZPAM+qJh3gAPm0zyGoKendARxFQeDBD8NZA=;
 b=qfSssBoR/MtKt9rX71XStC1BEyny6UfLXagbh5cJwiQHReDZbJX8frsSaOVtdoCN3L
 qg1Rh1CWoAciY7BBrqYiCIjy+iqo+EYAJIXNfoeHXvj04lHLbwCvhLp68Xd55QaVYEI6
 cDSNYNiy60graJftrdZ03HpJY+QKtbf++R4N0x1zyNPd9zI8YuEhA8RPXg7beJEI4dON
 uWYwhKhsMqDmjvVWoi3WLQ4HHcacHovECbVUkOP8sKSB+9IgYDKGUkDtV7E5UR9ED/7m
 8jwhWWXhAiYH7AeWSSYv16dEfZTPYBV3CHp2MECTPXC9HtpraBrjddvIcUNauHyVSyfS
 V4fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiM0KIYwJ8wsotbJo0NkBVxtkMVy5kaR81PPajgxSMb0ruryssbntr0Q8uY65MqnDBKNXU8T1EZkP68jke5OiwObd7Pjk=
X-Gm-Message-State: AOJu0YzaqHGbT78uPyCUnowerB+OHhdqWZ2QCxj6XjD8lQIi0jWegt6N
 TKzLp04Abes+RMFDnDwBI58OllHm5P98+8ZBzOZmNoHMQHzIscW6eYvsuqzjRyE=
X-Google-Smtp-Source: AGHT+IHn5Baii57+Pho6BH3Ld6xrqD6gYO2Fd5H3MYHn8Pb70IW1TVB0XxglA8RSyp/gs4iJgHwQVQ==
X-Received: by 2002:a05:600c:3154:b0:424:895c:b84b with SMTP id
 5b1f17b1804b1-4264b0cc4d0mr21803195e9.4.1720118168617; 
 Thu, 04 Jul 2024 11:36:08 -0700 (PDT)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264d6d41cesm18764715e9.16.2024.07.04.11.36.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 11:36:08 -0700 (PDT)
Date: Thu, 4 Jul 2024 19:36:21 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v4 16/19] hw/arm/smmuv3: Handle translation faults
 according to SMMUPTWEventInfo
Message-ID: <20240704183621.GM1693268@myrica>
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-17-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701110241.2005222-17-smostafa@google.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32c.google.com
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

On Mon, Jul 01, 2024 at 11:02:38AM +0000, Mostafa Saleh wrote:
> Previously, to check if faults are enabled, it was sufficient to check
> the current stage of translation and check the corresponding
> record_faults flag.
> 
> However, with nesting, it is possible for stage-1 (nested) translation
> to trigger a stage-2 fault, so we check SMMUPTWEventInfo as it would
> have the correct stage set from the page table walk.
> 
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  hw/arm/smmuv3.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 36eb6f514a..6c18dc0acf 100644
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

I guess this could be simplified as "(info.stage == STAGE_1) ? s1cfg : s2cfg"
Anyway:

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

>  
>  /**
>   * smmuv3_trigger_irq - pulse @irq if enabled and update
> @@ -919,7 +920,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>              event->u.f_walk_eabt.addr2 = ptw_info.addr;
>              break;
>          case SMMU_PTW_ERR_TRANSLATION:
> -            if (PTW_RECORD_FAULT(cfg)) {
> +            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
>                  event->type = SMMU_EVT_F_TRANSLATION;
>                  event->u.f_translation.addr = addr;
>                  event->u.f_translation.addr2 = ptw_info.addr;
> @@ -928,7 +929,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>              }
>              break;
>          case SMMU_PTW_ERR_ADDR_SIZE:
> -            if (PTW_RECORD_FAULT(cfg)) {
> +            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
>                  event->type = SMMU_EVT_F_ADDR_SIZE;
>                  event->u.f_addr_size.addr = addr;
>                  event->u.f_addr_size.addr2 = ptw_info.addr;
> @@ -937,7 +938,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>              }
>              break;
>          case SMMU_PTW_ERR_ACCESS:
> -            if (PTW_RECORD_FAULT(cfg)) {
> +            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
>                  event->type = SMMU_EVT_F_ACCESS;
>                  event->u.f_access.addr = addr;
>                  event->u.f_access.addr2 = ptw_info.addr;
> @@ -946,7 +947,7 @@ static SMMUTranslationStatus smmuv3_do_translate(SMMUv3State *s, hwaddr addr,
>              }
>              break;
>          case SMMU_PTW_ERR_PERMISSION:
> -            if (PTW_RECORD_FAULT(cfg)) {
> +            if (PTW_RECORD_FAULT(ptw_info, cfg)) {
>                  event->type = SMMU_EVT_F_PERMISSION;
>                  event->u.f_permission.addr = addr;
>                  event->u.f_permission.addr2 = ptw_info.addr;
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 

