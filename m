Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A208C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 09:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9Lri-00080m-5r; Tue, 21 May 2024 05:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s9Lrd-000809-CX
 for qemu-devel@nongnu.org; Tue, 21 May 2024 05:32:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1s9Lrb-0001Gz-QS
 for qemu-devel@nongnu.org; Tue, 21 May 2024 05:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716283973;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FxuNXruQERn88CJvHXojix949xQDC5DeLTI9DnbBVtg=;
 b=MQraS8KSCW4F+Fr4NZSdhHqLHlUaZtUPQ91D9cscrdUrJlTd1uDF/wRrrDaXDqXoEsqNC9
 5Kfq5V5XKxfhEWtQmWqlV+KHoRrTB61W+zM9bAsQt5G9iOMFygM5tBhTbYrYa9Aoigmg9z
 x9aIa7QgaPt5rcfLZzFg4Kr1KyW/i7E=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-g3N8qUtXMsuJR9EOHe_LBA-1; Tue, 21 May 2024 05:32:52 -0400
X-MC-Unique: g3N8qUtXMsuJR9EOHe_LBA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a51fdbd06c8so813010266b.3
 for <qemu-devel@nongnu.org>; Tue, 21 May 2024 02:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716283971; x=1716888771;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FxuNXruQERn88CJvHXojix949xQDC5DeLTI9DnbBVtg=;
 b=XuBn3k+aQOYHsXTtUTxSW1FOgXYf3ZIAW0uYr/TE1MlNWOgvbSZOidrA71l///05wH
 uv9ft/o2EQoeR7L3pHT39O6sJxWKQByrrFZHG3SvTCWpZQ6bMYKM1bHjiYWwcrM+kImd
 fOnzq/GFI99nld+cbBToIQOjzFoFMOB2imfHL3/FruSEJdmAaFUP3OXzxRguDF2ACyVj
 jrl7HzD+3Ka2we3fzKdq/d5rEKidFc7irEWGfxB3+ECjPF6ldXfQPhSnHGkgw7GiOalR
 DrPxpbAOKSFIpToyQYKG19Ee37n4F0rtdY2BMpsehGqkBikQdci2pbFi4e7uU4aU+VyG
 KWGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU129giL0Gj+kLQTXsDSrHhrXih3NHeT6XES+1XqoK3ncXHxN3/wFcwe4UNYfe4aZCBSwZwWGS5eEHexjbeUwnV4VBIDJg=
X-Gm-Message-State: AOJu0YxlODsA8+H+3y+RohnmO699Io4kN9LGMFBZUVXVE56Nw7Uu9tFK
 RzCL5KRJusUJjuHxJwX25wzt6exXzlfKMm7TFxIgv5rodzrvQbrHBgu/VWwoPgD6ctT2KKryf6a
 8JeC0fOsqqer/0Brl5Uas/Ds3Xk0GuqnXaGJa+T9voe8pSSsF2IQA
X-Received: by 2002:a17:907:2d89:b0:a59:a0b6:638 with SMTP id
 a640c23a62f3a-a5a2d66a7demr2519374766b.61.1716283971161; 
 Tue, 21 May 2024 02:32:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZL5j24+Vao4Lw13GaB1X6iszI+8BxAr0V/hpql1AiYotNhCp0vUXyZD7KxRS6jaaXfnb9qg==
X-Received: by 2002:a17:907:2d89:b0:a59:a0b6:638 with SMTP id
 a640c23a62f3a-a5a2d66a7demr2519372966b.61.1716283970799; 
 Tue, 21 May 2024 02:32:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a17b01602sm1599919366b.147.2024.05.21.02.32.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 May 2024 02:32:50 -0700 (PDT)
Message-ID: <689f6ac7-86ce-482f-a59a-fd17f8a5216d@redhat.com>
Date: Tue, 21 May 2024 11:32:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 17/18] hw/arm/smmuv3: Add property for OAS
Content-Language: en-US
To: Mostafa Saleh <smostafa@google.com>, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 nicolinc@nvidia.com, julien@xen.org, richard.henderson@linaro.org,
 marcin.juszkiewicz@linaro.org
References: <20240429032403.74910-1-smostafa@google.com>
 <20240429032403.74910-18-smostafa@google.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20240429032403.74910-18-smostafa@google.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/29/24 05:24, Mostafa Saleh wrote:
> Add property that sets the OAS of the SMMU, this in not used in this
> patch.
>
> Signed-off-by: Mostafa Saleh <smostafa@google.com>
> ---
>  hw/arm/smmuv3-internal.h |  3 ++-
>  hw/arm/smmuv3.c          | 29 ++++++++++++++++++++++++++++-
>  include/hw/arm/smmuv3.h  |  1 +
>  3 files changed, 31 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index 0ebf2eebcf..dd91807624 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -111,7 +111,8 @@ REG32(IDR5,                0x14)
>       FIELD(IDR5, VAX,        10, 2);
>       FIELD(IDR5, STALL_MAX,  16, 16);
>  
> -#define SMMU_IDR5_OAS 4
> +#define SMMU_IDR5_OAS_DEF 4 /* 44 bits. */
> +#define SMMU_IDR5_OAS_MAX 5 /* 48 bits. */
>  
>  REG32(IIDR,                0x18)
>  REG32(AIDR,                0x1c)
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 4ac818cf7a..39d03e7e24 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -299,7 +299,9 @@ static void smmuv3_init_regs(SMMUv3State *s)
>      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, 1);
>      s->idr[3] = FIELD_DP32(s->idr[3], IDR3, BBML, 2);
>  
> -    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS); /* 44 bits */
> +    /* PTW doesn't support 52 bits. */
remove the point
> +    s->oas = MIN(s->oas, SMMU_IDR5_OAS_MAX);
> +    s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, s->oas);
>      /* 4K, 16K and 64K granule support */
>      s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN4K, 1);
>      s->idr[5] = FIELD_DP32(s->idr[5], IDR5, GRAN16K, 1);
> @@ -1901,11 +1903,34 @@ static const VMStateDescription vmstate_gbpa = {
>      }
>  };
>  
> +static const VMStateDescription vmstate_oas = {
> +    .name = "smmuv3/oas",
> +    .version_id = 1,
> +    .minimum_version_id = 1,
don't you need a .needed function?

I tested backward migration and this fails
qemu-system-aarch64: error while loading state for instance 0x0 of
device 'smmuv3'
qemu-system-aarch64: load of migration failed: No such file or directory
post-processing ...

Thanks

Eric
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_INT32(oas, SMMUv3State),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static int smmuv3_preload(void *opaque)
> +{
> +    SMMUv3State *s = opaque;
> +
> +    /*
> +     * In case it wasn't migrated, use the value used
> +     * by older QEMU.
> +     */
> +    s->oas = SMMU_IDR5_OAS_DEF;
> +    return 0;
> +}
> +
>  static const VMStateDescription vmstate_smmuv3 = {
>      .name = "smmuv3",
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .priority = MIG_PRI_IOMMU,
> +    .pre_load = smmuv3_preload,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINT32(features, SMMUv3State),
>          VMSTATE_UINT8(sid_size, SMMUv3State),
> @@ -1933,6 +1958,7 @@ static const VMStateDescription vmstate_smmuv3 = {
>      },
>      .subsections = (const VMStateDescription * const []) {
>          &vmstate_gbpa,
> +        &vmstate_oas,
>          NULL
>      }
>  };
> @@ -1945,6 +1971,7 @@ static Property smmuv3_properties[] = {
>       * Defaults to stage 1
>       */
>      DEFINE_PROP_STRING("stage", SMMUv3State, stage),
> +    DEFINE_PROP_INT32("oas", SMMUv3State, oas, SMMU_IDR5_OAS_DEF),
>      DEFINE_PROP_END_OF_LIST()
>  };
>  
> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
> index d183a62766..00a9eb4467 100644
> --- a/include/hw/arm/smmuv3.h
> +++ b/include/hw/arm/smmuv3.h
> @@ -63,6 +63,7 @@ struct SMMUv3State {
>      qemu_irq     irq[4];
>      QemuMutex mutex;
>      char *stage;
> +    int32_t oas;
>  };
>  
>  typedef enum {


