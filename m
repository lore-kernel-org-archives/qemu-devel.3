Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C29EAC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 12:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Djn-0003co-Um; Wed, 15 May 2024 08:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s7Djm-0003c0-7Z
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:28:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s7Djk-00089x-Ef
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715776078;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AaeqkP6PPe9K5SSu45mB7EqksnjY8lmh0nHD4tF6fFI=;
 b=DDHF1d2mljmXIGXtiq435ZSbmOyuek2YpLufH2ZK9DWakrmCcrzLHsCnHUki08BmsVjE++
 ZuvWP/nfjEfPXPLQ3w0rUUCmGsiiLiqShw/PoZ9FQdjnpOAvxDTOceR7mzYpDn4vNGOi+C
 8vTccmQrzooQH3YOPwpJNQl7O5JQoI4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-WTvRxNIsMkuN7xQY8lvd_w-1; Wed, 15 May 2024 08:27:51 -0400
X-MC-Unique: WTvRxNIsMkuN7xQY8lvd_w-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-6507e2f0615so1255225a12.1
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 05:27:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715776071; x=1716380871;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AaeqkP6PPe9K5SSu45mB7EqksnjY8lmh0nHD4tF6fFI=;
 b=Do+JkgmON9ZvpeUQbd9/31BXq2VVUehCf3yS6lV7OtwEhIijied90YYsOqAkpit7Ao
 mHngIh50bF7HQGpociOM1gy6MfrIYYFXubzFXPFzzpFf2AUhLTe4zxKYWdNOIBrRs5ps
 9Oq0keUP1jAGo6E7tgoSl/nVLpb+Ulmc0juvKB/FtyQWxXP0Rt5ROF1wkaBPNFPaseXQ
 5xeWFZlX0z0ml22jdTW7bWjMo66EjMPj4H3ba6QQ0HhZAZXJrAqZ0XxBPHJpjPr3I0S1
 qTxC9wNgyb4Vw93SjSaYsjF3snHlpEokPKBcM/GdpkqZy2veY+qmAL0pnI1Ssde2M0i5
 svzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmobYHxBSmm3DFEZSw/heRJawNs27yHYv1KjciNWAy02tiI/z3YtA9X6gJvojxzlupGJHA/SHh+98VUxV8G9clOgw8Do0=
X-Gm-Message-State: AOJu0YzNJE34fy+R+IxH1SV4v9r0BXvrKC0SaxwIvgJEjCF+i4udruB+
 rOxsmDDo4edxQGQnC93Rk7lyOlGwmXJOsGixKxzuv6YT8jOqXuKcC6K9mSE1odroLpiG7AHstp+
 +LpwyH0ns9kBtrI/4nSnR12NtulLSeWPFlOhtc0hOUCPi2aXf+dWQ
X-Received: by 2002:a17:902:cec3:b0:1e4:346e:74d8 with SMTP id
 d9443c01a7336-1ef4404bcd4mr175898195ad.61.1715776070727; 
 Wed, 15 May 2024 05:27:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDGuHmU+W3NBqrb57TDKur2PdJpbEs7RVULjhpZcpTve3+va9r85x6jygAgsRZsvsKDW6ggw==
X-Received: by 2002:a17:902:cec3:b0:1e4:346e:74d8 with SMTP id
 d9443c01a7336-1ef4404bcd4mr175897975ad.61.1715776070290; 
 Wed, 15 May 2024 05:27:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ef0bada405sm117435485ad.92.2024.05.15.05.27.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 05:27:49 -0700 (PDT)
Message-ID: <2ca04dfa-61bb-4f35-954a-b5f107bf8f36@redhat.com>
Date: Wed, 15 May 2024 14:27:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 03/18] hw/arm/smmuv3: Fix encoding of CLASS in
 events
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-4-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240429032403.74910-4-smostafa@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
If this fixes somethings please add a Fixes: tag.

Also you may add that until nested gets implemented, CLASS values are
the same for stage 1 and stage2. This will change later on.

Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

>
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


