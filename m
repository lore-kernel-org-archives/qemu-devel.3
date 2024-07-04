Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E58CAC3271F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 18:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPQmL-0003Rr-8n; Thu, 04 Jul 2024 14:01:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPQmF-0003RB-Uv
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:01:52 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1sPQmE-0007VQ-55
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 14:01:51 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2ebe40673d8so10468611fa.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 11:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720116108; x=1720720908; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MzoctlUTiSFA9iUoFOMhm1Km2jWzaVUvPlzy/f/ntRQ=;
 b=kBySCAGFyFHPZTE+MUb5A0XeQSQq4N4tVVrfzOTJvzNcl6McL65cbyZ+XomMqvoUmb
 rCmdQQIM7pFdUYyh0YcsCFSlJXaIJEg6a8bVjsJRAJr/n3obhK0OX1ck04yOZgdAVlD3
 KnGekfJPuH57FfPiCsJKtVR9GjAGbv6rmK8Cf7AHP2rBgj9K1c0pGJgX6M+WQUyXwYw9
 TG8rszy/njxiGt5+Pvzf79Bpcsm7WLMBNwYz9w3+FhYBeWTpR5yLsfEGyf/Zylpy2IPa
 FYpmtN3dDRO+8Y+FErJwQ+BUXDBydkl4HPSzmZYVVJncVPAXUS0ZZdirKVnMhSi153u6
 zh2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720116108; x=1720720908;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MzoctlUTiSFA9iUoFOMhm1Km2jWzaVUvPlzy/f/ntRQ=;
 b=LQV/XcsU7vv57IwOg7eTNlUVidX5cbhb9BNlFy6cRz3OC1IQoKvv/FhRG6+1nuS4Qu
 gKGWZgkv74/8ZcKhpVPkGgAb+YfzHSoT5kbJoOLzBgZjdwIN110ovP9+RoYIrZx73wZB
 suw5OINL9mldn8YBOlYkkvGWM/n7C+UPBCSgmJfD3BSm/gWRS7Nc5/yGzojDjlEtgevw
 w0ERz9UhQHHcWCx3HhgGCvQAmHxzxZA/lJ8oHcHtn0Ns9WONGLhUnmlkRQYSz2xgYV7n
 9+MjDtFLvesgtJoIOawbCe7Pk9L+Fb3A2K0mQ6L9v9nZis6OVLPSzRkuXN33sUVaJdFw
 my/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMaWUaMjSTmmLaynT2OuZ1qf7ApZZ0p1arSN3lt+iIu3IaziB2Ei0DAmYxVi5IOsnjL3Mz2Qp4XHivZPk913fHuc2aDTQ=
X-Gm-Message-State: AOJu0YyrySJACiOSy4MZIu/jjobjt6GEDFPlAmjJK3Q3arqlF98+NRoS
 c//+Jy1yjIj/WKeday+SsxIsTm9ocXK6ui9OhzwIpwF280aFV5395obC+P+foR0=
X-Google-Smtp-Source: AGHT+IGWlUZflrOohLJm9FWDJ2ZIwkpKWiMbT6ZmSab8MO7lnu3U8gyuyVMB8rG/qS8O7YCf6JkYHg==
X-Received: by 2002:a2e:9953:0:b0:2ec:3e02:972a with SMTP id
 38308e7fff4ca-2ee8ed3df76mr16794871fa.11.1720116108203; 
 Thu, 04 Jul 2024 11:01:48 -0700 (PDT)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367a494e7a1sm613421f8f.112.2024.07.04.11.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 11:01:47 -0700 (PDT)
Date: Thu, 4 Jul 2024 19:02:00 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: qemu-arm@nongnu.org, eric.auger@redhat.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
Subject: Re: [PATCH v4 03/19] hw/arm/smmuv3: Fix encoding of CLASS in events
Message-ID: <20240704180200.GC1693268@myrica>
References: <20240701110241.2005222-1-smostafa@google.com>
 <20240701110241.2005222-4-smostafa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240701110241.2005222-4-smostafa@google.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=jean-philippe@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Jul 01, 2024 at 11:02:25AM +0000, Mostafa Saleh wrote:
> The SMMUv3 spec (ARM IHI 0070 F.b - 7.3 Event records) defines the
> class of events faults as:
> 
> CLASS: The class of the operation that caused the fault:
> - 0b00: CD, CD fetch.
> - 0b01: TTD, Stage 1 translation table fetch.
> - 0b10: IN, Input address
> 
> However, this value was not set and left as 0 which means CD and not
> IN (0b10).
> While at it, add an enum for class as it would be used for nesting.
> However, at the moment stage-1 and stage-2 use the same class values.
> 
> Fixes: 9bde7f0674 “hw/arm/smmuv3: Implement translate callback”
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  hw/arm/smmuv3-internal.h | 6 ++++++
>  hw/arm/smmuv3.c          | 6 +++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index e4dd11e1e6..0f3ecec804 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -32,6 +32,12 @@ typedef enum SMMUTranslationStatus {
>      SMMU_TRANS_SUCCESS,
>  } SMMUTranslationStatus;
>  
> +typedef enum SMMUTranslationClass {
> +    SMMU_CLASS_CD,
> +    SMMU_CLASS_TT,
> +    SMMU_CLASS_IN,
> +} SMMUTranslationClass;
> +
>  /* MMIO Registers */
>  
>  REG32(IDR0,                0x0)
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 9dd3ea48e4..1eb5b160d2 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -942,7 +942,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>              event.type = SMMU_EVT_F_WALK_EABT;
>              event.u.f_walk_eabt.addr = addr;
>              event.u.f_walk_eabt.rnw = flag & 0x1;
> -            event.u.f_walk_eabt.class = 0x1;
> +            event.u.f_walk_eabt.class = SMMU_CLASS_TT;

For EABT I think we have to differentiate S1/S2:

* s1-only walk that encounters EABT on S1 descriptor access is reported as
  class=TT, 
* s2 walk that encounters EABT on S2 descriptor while translating
  non-descriptor IPA is reported as class=IN, even when doing s2-only.

Maybe it can be done in the later patch where you propagate the different
classes, because it's a minor detail.

Thanks,
Jean

>              event.u.f_walk_eabt.addr2 = ptw_info.addr;
>              break;
>          case SMMU_PTW_ERR_TRANSLATION:
> @@ -950,6 +950,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>                  event.type = SMMU_EVT_F_TRANSLATION;
>                  event.u.f_translation.addr = addr;
>                  event.u.f_translation.addr2 = ptw_info.addr;
> +                event.u.f_translation.class = SMMU_CLASS_IN;
>                  event.u.f_translation.rnw = flag & 0x1;
>              }
>              break;
> @@ -958,6 +959,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>                  event.type = SMMU_EVT_F_ADDR_SIZE;
>                  event.u.f_addr_size.addr = addr;
>                  event.u.f_addr_size.addr2 = ptw_info.addr;
> +                event.u.f_translation.class = SMMU_CLASS_IN;
>                  event.u.f_addr_size.rnw = flag & 0x1;
>              }
>              break;
> @@ -966,6 +968,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>                  event.type = SMMU_EVT_F_ACCESS;
>                  event.u.f_access.addr = addr;
>                  event.u.f_access.addr2 = ptw_info.addr;
> +                event.u.f_translation.class = SMMU_CLASS_IN;
>                  event.u.f_access.rnw = flag & 0x1;
>              }
>              break;
> @@ -974,6 +977,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>                  event.type = SMMU_EVT_F_PERMISSION;
>                  event.u.f_permission.addr = addr;
>                  event.u.f_permission.addr2 = ptw_info.addr;
> +                event.u.f_translation.class = SMMU_CLASS_IN;
>                  event.u.f_permission.rnw = flag & 0x1;
>              }
>              break;
> -- 
> 2.45.2.803.g4e1b14247a-goog
> 

