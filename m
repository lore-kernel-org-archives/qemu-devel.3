Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E4AC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 15:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU6Gi-00013w-Am; Wed, 17 Jul 2024 11:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU6GL-0000rh-Ap
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:08:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1sU6GH-000468-Rq
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 11:08:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721228888;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8usRwtiMatigIKv6SUJ2naiRlabsyo6rGgCib1jD/ac=;
 b=Z1PyVYT28ajYXMzhg6REffm6EGrs1OqF7kG65TF0ZdMIhOkYclFHdh+c6Lpf9knHqvvmLm
 /TPjRtJzwyNzNav4xzfbT5GNpOyUKrHCbVHI0Ix4fAIGqMI8suCm0Wbne64o0e/Ige1O/u
 ydgcTKT1uBTYzwGBx8ZvmwnAqL5wzv8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-73-Bm_0wbSeMlG0QCe6pzw-zA-1; Wed, 17 Jul 2024 11:08:06 -0400
X-MC-Unique: Bm_0wbSeMlG0QCe6pzw-zA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6b75e880a12so78963356d6.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 08:08:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721228885; x=1721833685;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8usRwtiMatigIKv6SUJ2naiRlabsyo6rGgCib1jD/ac=;
 b=vZqOYKUGaGJvehGyHBHJbe4IuXr+N65+YRP37Iz9e3KrB4tpXWcQlhQXW1dC0f1DTY
 tvkUcnRoihU65KEmKkYOBrEXc3PzjRQyGRV4/PJcA8cIF1JNmXClG9C2y65jsi+ThSto
 euEyY9md+OctWTMLEL6IfSEeWZ/4fTr6re4DazyJaX8ITTjxl2oDbhksz9bme65lTYEj
 JbSGHbfnIJGKwCaqstwv0UOS9nVQH2sx9VVnhvGeVFlhLLUy6C/JKHLDaTD8CqpA8h2q
 sWkACtlrROS6smWswQClFnWBlwT+3mjndFyIBN32SQznS1IYNFLcXepIfe4EfyEzjRMX
 Q/MA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoOrwc/9AzI12F5ZQw4Yc9SKi9LCqnPqpeErazHEbsChxu9wf8+qxuvAsxrvoxdQk1Y95Rr5X5TRwHr4yBljoZuyqosUk=
X-Gm-Message-State: AOJu0Yzns+jJAXVzK3/yvLDC5bdeH/sg5oaBpPnpDIWPHsyrOsHH0qe0
 9LY3y9ldC+OEkR+9fSArYbAlVItPok6ed/uyMFvglxBUQE2fCsA4fWy265291PnjV7EHjseq6kT
 fgn51HQ0vWo7sQzsWe+oTws5Nz43GBlj8N3pv01fT3THCGVCquqUv
X-Received: by 2002:ad4:5fc9:0:b0:6b5:403:ea7b with SMTP id
 6a1803df08f44-6b78e2d542emr16343646d6.54.1721228885191; 
 Wed, 17 Jul 2024 08:08:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR9vpHp9xjYR2GD6fFbHgxylArez110L9Gt1n1In8Pxprc6d77SZZpxlmlRR78nM3Witx4+w==
X-Received: by 2002:ad4:5fc9:0:b0:6b5:403:ea7b with SMTP id
 6a1803df08f44-6b78e2d542emr16342656d6.54.1721228882580; 
 Wed, 17 Jul 2024 08:08:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b7619a283dsm42554156d6.68.2024.07.17.08.08.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 08:08:02 -0700 (PDT)
Message-ID: <cb687788-4bf4-4bc1-94e1-5f023b731b9c@redhat.com>
Date: Wed, 17 Jul 2024 17:07:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/18] hw/arm/smmuv3: Fix encoding of CLASS in events
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240715084519.1189624-1-smostafa@google.com>
 <20240715084519.1189624-4-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240715084519.1189624-4-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Jean,

On 7/15/24 10:45, Mostafa Saleh wrote:
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
>
> Another problem was that stage-2 class is considered IN not TT for
> EABT, according to the spec:
>     Translation of an IPA after successful stage 1 translation (or,
>     in stage 2-only configuration, an input IPA)
>     - S2 == 1 (stage 2), CLASS == IN (Input to stage)
>
> This would change soon when nested translations are supported.
>
> While at it, add an enum for class as it would be used for nesting.
> However, at the moment stage-1 and stage-2 use the same class values,
> except for EABT.
>
> Fixes: 9bde7f0674 “hw/arm/smmuv3: Implement translate callback”
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  hw/arm/smmuv3-internal.h | 6 ++++++
>  hw/arm/smmuv3.c          | 8 +++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
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
> index 9dd3ea48e4..3d214c9f57 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -942,7 +942,9 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>              event.type = SMMU_EVT_F_WALK_EABT;
>              event.u.f_walk_eabt.addr = addr;
>              event.u.f_walk_eabt.rnw = flag & 0x1;
> -            event.u.f_walk_eabt.class = 0x1;
> +            /* Stage-2 (only) is class IN while stage-1 is class TT */
> +            event.u.f_walk_eabt.class = (ptw_info.stage == 2) ?
> +                                         SMMU_CLASS_IN : SMMU_CLASS_TT;
does it match your expectations. While reading your previous comment I
have the impression what you had in mind was more complicated than that

* s2 walk that encounters EABT on S2 descriptor while translating
  non-descriptor IPA is reported as class=IN, even when doing s2-only.

Thanks

Eric

>              event.u.f_walk_eabt.addr2 = ptw_info.addr;
>              break;
>          case SMMU_PTW_ERR_TRANSLATION:
> @@ -950,6 +952,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>                  event.type = SMMU_EVT_F_TRANSLATION;
>                  event.u.f_translation.addr = addr;
>                  event.u.f_translation.addr2 = ptw_info.addr;
> +                event.u.f_translation.class = SMMU_CLASS_IN;
>                  event.u.f_translation.rnw = flag & 0x1;
>              }
>              break;
> @@ -958,6 +961,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>                  event.type = SMMU_EVT_F_ADDR_SIZE;
>                  event.u.f_addr_size.addr = addr;
>                  event.u.f_addr_size.addr2 = ptw_info.addr;
> +                event.u.f_translation.class = SMMU_CLASS_IN;
>                  event.u.f_addr_size.rnw = flag & 0x1;
>              }
>              break;
> @@ -966,6 +970,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>                  event.type = SMMU_EVT_F_ACCESS;
>                  event.u.f_access.addr = addr;
>                  event.u.f_access.addr2 = ptw_info.addr;
> +                event.u.f_translation.class = SMMU_CLASS_IN;
>                  event.u.f_access.rnw = flag & 0x1;
>              }
>              break;
> @@ -974,6 +979,7 @@ static IOMMUTLBEntry smmuv3_translate(IOMMUMemoryRegion *mr, hwaddr addr,
>                  event.type = SMMU_EVT_F_PERMISSION;
>                  event.u.f_permission.addr = addr;
>                  event.u.f_permission.addr2 = ptw_info.addr;
> +                event.u.f_translation.class = SMMU_CLASS_IN;
>                  event.u.f_permission.rnw = flag & 0x1;
>              }
>              break;


