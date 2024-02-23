Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC873C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 07:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdQMg-0004hr-In; Fri, 23 Feb 2024 02:53:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdQMe-0004ZX-EU
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 02:53:00 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdQMb-0006kw-HG
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 02:53:00 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a3e6f79e83dso9441466b.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 23:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708674775; x=1709279575; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D1n8pZZY1u3W1iEF75d2YpeAs348P/yfiKpOXMFoJQQ=;
 b=xpo6AKsE2JxCYrWzPmP+ZVxvgBadJauHAPQlUotygTOvsyOKH6iReCOhP1jfqRp5H6
 gvFJsX4iONhUa3LFBR7C32OIM24DTbcZ+20gzJB7kIritwc9rh9vQ/lIHKLlbKApiXko
 Gi1CQmfYNIsfpcgwHmep7JSrhGu8KgayKQNt+txXJjc7VliDhEPU8Lh677WTDO2qmHJN
 nZADieHX37I8X0lFB6reioW5CI+rMPStvSQewVKDK6DPGmAhl/0DxKzk0PcLR71HGk47
 GC9TKrb+7IC69OlrdJM9723HacEDaSiuSBfsyTLKLnwhagsGXuRhB4hp1RPfgqC9MEJe
 ueUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708674775; x=1709279575;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D1n8pZZY1u3W1iEF75d2YpeAs348P/yfiKpOXMFoJQQ=;
 b=fJuUvdPbtSE93qf1Cj/ZbjGUSoiJQw8kPQotgc2YnQvfD8B6r4ABUaYsVLl0xZVta9
 evt5GvzakFYKakIJWgfSjbf5YX0ySepevJ9uLRpCdZuePChyr5FdZA+j6egnwvRGIl5b
 KGbjxw79mPozGnj+2AiJv/jftBMeMXR6CvnPsxItfKW9IAgWe7TTWoEi2/zSXJqTCpqK
 eBl6eYc8Ss0RnvsM+1/dSlDJY5Tn22yokZWGoi1AWX3E6scxHn4IKlbfOF19UAzkhor/
 EweBi4PADKqHdqYb4VK9gaLsnWQ4oJJOyy7fHBTtQEmDGeB5mnQrQ6PkPPWvHhVPrbKk
 pgPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqNwPq+5i4pRHKlf6aAcQMi72FextnKnhOFcd02A6PB+1/sc95DGyrj0qF5Z0ZBucg7I7sJg2FQ3FpmTWhBtqjDraxPac=
X-Gm-Message-State: AOJu0YzFnNwKSlPPBihC00T+jc1PYAq3XUcQMqNzHFWL/YvaFcJ2/PfP
 3U3+9D48/NNy28ORVlmt4McDGQtFA8XgdKX4S19pOyBaEUVJaMsfkLaGeL4bErc=
X-Google-Smtp-Source: AGHT+IHjAA3i5A+AcXwfqepQWCdkHXJ6B1f7QZbvJjTzQunwk4ICE6tA6Iu31tZuV2YC1/aX6g4iIg==
X-Received: by 2002:a17:906:6b8c:b0:a3e:fd1b:3fb5 with SMTP id
 l12-20020a1709066b8c00b00a3efd1b3fb5mr768844ejr.1.1708674775497; 
 Thu, 22 Feb 2024 23:52:55 -0800 (PST)
Received: from [192.168.69.100] (sto95-h01-176-184-18-96.dsl.sta.abo.bbox.fr.
 [176.184.18.96]) by smtp.gmail.com with ESMTPSA id
 tk7-20020a170907c28700b00a3f98d28befsm1033252ejc.50.2024.02.22.23.52.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 23:52:55 -0800 (PST)
Message-ID: <07d4a2a4-1880-4402-a12a-94eeb649f8b0@linaro.org>
Date: Fri, 23 Feb 2024 08:52:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] qdev: Add a granule_mode property
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 jean-philippe@linaro.org, peter.maydell@linaro.org, clg@redhat.com,
 yanghliu@redhat.com, Markus Armbruster <armbru@redhat.com>
Cc: alex.williamson@redhat.com, zhenzhong.duan@intel.com,
 jasowang@redhat.com, pbonzini@redhat.com, berrange@redhat.com
References: <20240223074459.63422-1-eric.auger@redhat.com>
 <20240223074459.63422-2-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240223074459.63422-2-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Eric,

On 23/2/24 08:27, Eric Auger wrote:
> Introduce a new enum type property allowing to set an
> IOMMU granule. Values are 4K, 8K, 16K, 64K and host.
> This latter indicates the vIOMMU granule will match
> the host page size.
> 
> A subsequent patch will add such a property to the
> virtio-iommu device.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v3 -> v4:
> - Add 8K
> ---
>   include/hw/qdev-properties-system.h |  3 +++
>   include/hw/virtio/virtio-iommu.h    | 11 +++++++++++
>   hw/core/qdev-properties-system.c    | 15 +++++++++++++++
>   hw/virtio/virtio-iommu.c            | 11 +++++++++++
>   4 files changed, 40 insertions(+)


> diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
> index 5fbe4677c2..e22327548f 100644
> --- a/include/hw/virtio/virtio-iommu.h
> +++ b/include/hw/virtio/virtio-iommu.h
> @@ -31,6 +31,17 @@ OBJECT_DECLARE_SIMPLE_TYPE(VirtIOIOMMU, VIRTIO_IOMMU)
>   
>   #define TYPE_VIRTIO_IOMMU_MEMORY_REGION "virtio-iommu-memory-region"
>   
> +typedef enum GranuleMode {
> +    GRANULE_MODE_4K,
> +    GRANULE_MODE_8K,
> +    GRANULE_MODE_16K,
> +    GRANULE_MODE_64K,
> +    GRANULE_MODE_HOST,
> +    GRANULE_MODE__MAX,
> +} GranuleMode;
> +
> +extern const QEnumLookup GranuleMode_lookup;

Aren't this, ...

> diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> index 2ec5ef3cd1..a9bdc03d12 100644
> --- a/hw/virtio/virtio-iommu.c
> +++ b/hw/virtio/virtio-iommu.c
> @@ -44,6 +44,17 @@
>   #define VIOMMU_DEFAULT_QUEUE_SIZE 256
>   #define VIOMMU_PROBE_SIZE 512
>   
> +const QEnumLookup GranuleMode_lookup = {
> +    .array = (const char *const[]) {
> +        [GRANULE_MODE_4K]   = "4K",
> +        [GRANULE_MODE_8K]   = "8K",
> +        [GRANULE_MODE_16K]  = "16K",
> +        [GRANULE_MODE_64K]  = "64K",
> +        [GRANULE_MODE_HOST] = "host",
> +    },
> +    .size = GRANULE_MODE__MAX
> +};
... and this supposed to be QAPI generated?

