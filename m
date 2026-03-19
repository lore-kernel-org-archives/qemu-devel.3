Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E68FC107528A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 09:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3A2w-0005Rm-WA; Thu, 19 Mar 2026 05:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w3A2v-0005RT-LG
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 05:52:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1w3A2t-0002yb-JO
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 05:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773913922;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kn4kZnZGVOHmLZP7ZfKCvV0EIEJGEFBn3r/O2PtU5oU=;
 b=hHZiq3g8iBseSRFmr3/Y+vFHjO3m5L4V4MRGCKYDQ0yKTsE5avYaHlCC4T59MU3TpecQQM
 38v2LOJmq5be/Fs15cH8KhflFaz/TOe4Ufeuvzs+dh5WMfXM0Y6DObllsQLGEzbe/L+iG0
 n1su6IMWam9mPtg/tsp4q8gn/aszgxQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-a6QTFNerNAOOCnWQf1RcWw-1; Thu, 19 Mar 2026 05:52:00 -0400
X-MC-Unique: a6QTFNerNAOOCnWQf1RcWw-1
X-Mimecast-MFC-AGG-ID: a6QTFNerNAOOCnWQf1RcWw_1773913919
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4837b6f6b93so11134795e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 02:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773913919; x=1774518719;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kn4kZnZGVOHmLZP7ZfKCvV0EIEJGEFBn3r/O2PtU5oU=;
 b=Q6zTXqnGe4jvRrri0+bXJy2/lNwz32cwC35Xz55noL1kGU7RlGe7nyENAfy71M7d4Q
 vuQ9ybDvnlGZrM4AwFfAqzTnrVUJjaxfLSnx8bYHcJ+iMVL9KVMVgJYg/FcLXdZPVStf
 nDkbheGz97PAy/nXljNIz/UVFWIBlZfAcfHP2MUB33x/doFqSKUdU3hPtYPi0q9Jqk6X
 M6Udzdpdoi5diN0pvoX7FltBqW7jynrTmvBAT78FXTbnzplUv8X+5IMQi5k5B/ELJ60H
 wsePYDCM+QB6dNM79eoAI1Pg1ncPttJY3bwXm6jOefHHL2l4bi25Sd03CpODuOGBXnY+
 duTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlS6ZD/9QYj2ax1OjSkF9zdZPcUFNtyhlwxKAwZIKY2wEZAQKTQ9mk3kVC0x99RAE0ZX7kzvpgrwL8@nongnu.org
X-Gm-Message-State: AOJu0Yz333NGFYnNktvnfq5S4wnHNYMUKAP+uAfqzjR+1pI+r+A2hAHm
 62H1GFGFjkhGzZqbk8Er55WywurKG8UbtinJXBMMFX6+CUSmedgzQ+xppiF/NPcA8XJqrGrQWnY
 c80f/7mSYgvRhM49dpJUI+boAE5E0eTad8Z9TmYwOqWwr8J/P0Qd/DDIr
X-Gm-Gg: ATEYQzxHTjBFuphdUYAdQ/axGvq2TcFsc6csbplzkqDs5InGicnjAK8+lutEjweJUzu
 Fvz0vssMEcuPvWm241yGd1lzsWQU3V877PwJ+p6MhnhCeJnEbSkxfZCIqAmIkogBJlUQfE2teMi
 YTBOR7aHbfWXSTeQYYvmpo0iBqXb2H5nCrG2Mw1LX9bPbehY4maiu0uRr8I+I4sKysE1tlkdRmM
 NMa3qOY+xTbOyAB+N9rOxuXzyRhLkgTKTTNCrzz/N2kvKj1ObLXKL/H3V59fW8wZzgpf9Ot2wJh
 LKZOZzVCeIU8u+gRJKO9qHsGP0wKhcRlaARC5HlT77lSU8Np9d1OuerMjsBmDr10/88fOBFoMrU
 eKb7x8wWTOuzTPhEw2y1+u5cXIfAZEMZu8jom7qMNjXLwnulSIS1eKGLRy5zblxLQNLX8yQ==
X-Received: by 2002:a05:600c:8a6:b0:485:35ee:f836 with SMTP id
 5b1f17b1804b1-486f4422104mr68953235e9.2.1773913919333; 
 Thu, 19 Mar 2026 02:51:59 -0700 (PDT)
X-Received: by 2002:a05:600c:8a6:b0:485:35ee:f836 with SMTP id
 5b1f17b1804b1-486f4422104mr68952905e9.2.1773913918798; 
 Thu, 19 Mar 2026 02:51:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8c4aa85sm44356135e9.12.2026.03.19.02.51.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 02:51:58 -0700 (PDT)
Message-ID: <5d9a0c0d-fd74-4e71-9117-2bafbdb36fcc@redhat.com>
Date: Thu, 19 Mar 2026 10:51:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] hw/arm/smmuv3-accel: Change OAS property to OasMode
Content-Language: en-US
To: Nathan Chen <nathanc@nvidia.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260318184907.4060030-1-nathanc@nvidia.com>
 <20260318184907.4060030-8-nathanc@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260318184907.4060030-8-nathanc@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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



On 3/18/26 7:49 PM, Nathan Chen wrote:
> From: Nathan Chen <nathanc@nvidia.com>
>
> Change accel SMMUv3 OAS property from uint8_t to OasMode. The
> 'auto' value is not implemented, as this commit is meant to
> set the property to the correct type and avoid breaking JSON/QMP
> when the auto mode is introduced. A future patch will implement
> resolution of 'auto' value to match the host SMMUv3 OAS value.
>
> Fixes: a015ac990fd3 ("hw/arm/smmuv3-accel: Add property to specify OAS bits")
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmuv3-accel.c          |  2 +-
>  hw/arm/smmuv3.c                | 16 ++++++++--------
>  include/hw/arm/smmuv3-common.h |  2 --
>  include/hw/arm/smmuv3.h        |  2 +-
>  4 files changed, 10 insertions(+), 12 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index bc6cbfebc2..65c2f44880 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -850,7 +850,7 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>      }
>  
>      /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
> -    if (s->oas == SMMU_OAS_48BIT) {
> +    if (s->oas == OAS_MODE_48) {
>          s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
>      }
>  
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 79018f8d66..c67819d6f2 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1984,6 +1984,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>          error_setg(errp, "ssidsize auto mode is not supported");
>          return false;
>      }
> +    if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48) {
> +        error_setg(errp, "OAS can only be set to 44 or 48 bits");
> +        return false;
> +    }
>  
>      if (!s->accel) {
>          if (s->ril == ON_OFF_AUTO_OFF) {
> @@ -1994,7 +1998,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>              error_setg(errp, "ats can only be enabled if accel=on");
>              return false;
>          }
> -        if (s->oas != SMMU_OAS_44BIT) {
> +        if (s->oas > OAS_MODE_44) {
>              error_setg(errp, "OAS must be 44 bits when accel=off");
>              return false;
>          }
> @@ -2012,11 +2016,6 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>          return false;
>      }
>  
> -    if (s->oas != SMMU_OAS_44BIT && s->oas != SMMU_OAS_48BIT) {
> -        error_setg(errp, "OAS can only be set to 44 or 48 bits");
> -        return false;
> -    }
> -
>      return true;
>  }
>  
> @@ -2143,7 +2142,7 @@ static const Property smmuv3_properties[] = {
>      /* RIL can be turned off for accel cases */
>      DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
>      DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
> -    DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
> +    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_44),
>      DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
>                                SSID_SIZE_MODE_0),
>  };
> @@ -2180,7 +2179,8 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>          "supported.");
>      object_class_property_set_description(klass, "oas",
>          "Specify Output Address Size (for accel=on). Supported values "
> -        "are 44 or 48 bits. Defaults to 44 bits");
> +        "are 44 or 48 bits. Defaults to 44 bits. oas=auto is not "
> +        "supported.");
>      object_class_property_set_description(klass, "ssidsize",
>          "Number of bits used to represent SubstreamIDs (SSIDs). "
>          "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
> diff --git a/include/hw/arm/smmuv3-common.h b/include/hw/arm/smmuv3-common.h
> index 7f0f992dfd..4609975edf 100644
> --- a/include/hw/arm/smmuv3-common.h
> +++ b/include/hw/arm/smmuv3-common.h
> @@ -342,8 +342,6 @@ REG32(IDR5,                0x14)
>       FIELD(IDR5, VAX,        10, 2);
>       FIELD(IDR5, STALL_MAX,  16, 16);
>  
> -#define SMMU_OAS_44BIT 44
> -#define SMMU_OAS_48BIT 48
>  #define SMMU_IDR5_OAS_44 4
>  #define SMMU_IDR5_OAS_48 5
>  
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index ddf472493d..82f18eb090 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -72,7 +72,7 @@ struct SMMUv3State {
>      Error *migration_blocker;
>      OnOffAuto ril;
>      OnOffAuto ats;
> -    uint8_t oas;
> +    OasMode oas;
>      SsidSizeMode ssidsize;
>  };
>  


