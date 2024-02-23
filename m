Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 555C4C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 07:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdQRA-0007tA-Qp; Fri, 23 Feb 2024 02:57:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdQR6-0007ry-Ff
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 02:57:36 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdQQz-0007lk-BX
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 02:57:36 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a3e75e30d36so108699066b.1
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 23:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708675047; x=1709279847; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hpe6qfp0CO2lq3XA1sJLcXs28EMH9yFGoQ8txnA/syQ=;
 b=MCKa4YK3oxd5KoOC1BGzuVKBj+v0R7TVpPpqhJnYUaYe7W+qSgaULtupu+uRgHhsQb
 hZ2FVQG/tXGT2yhc5PHmmzuxkAmYnQSmI1eTJPZ468Xc8arD+umOUr3Vuo39s0xHjfTO
 JPPmVuOvub6ctNJOjiIhRhWToTTskcOJmZcALBbGcBqMDA1052KSKzHPjQTX3NgQO98F
 2PITd7+2Xo4xv/SyBsVEF5fOA89+8M1WkZ2jGj4Yx6J5cbKVb9zwKxdAcJbpI5VeiX+U
 COC4uRKHfnvZ2n4OGXR0NVRF1WRnpObNRux7gevNpXxAd7SE32Of8YvQPYOJJn7SSma/
 KB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708675047; x=1709279847;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hpe6qfp0CO2lq3XA1sJLcXs28EMH9yFGoQ8txnA/syQ=;
 b=LCCsDc1j/n++nfRW5Wuj1BbUWYFuZ7LGkiDDpcFO7Ln0GgWPk3NanxBlZgzaj5JgLG
 P49ZDwwTxDdKDXrE9+lpOw9RcGmnFYZlz+S3W5Ouj3P75aySovettYea3N2cwDArvgdb
 L9jldtR+zKxhGYcM4Eg90k/zOKqnGu9fWU9ynOZaJTKYyJCZ+Bc55M1Xr1ik9VKBm88W
 V3hLW6x1+bQPE1VV3yzLMJRXb6EJs6/FsQ7VbiNpObbnog7opW18P/Pl1J/SAa5oHcEl
 sv+dBspcuPgqAfcigtixX+ctkjsn97pa+djW7YuNbcN/RQqwHR9v5K69BmOxqQ+OoRZq
 6ZdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsn32rbAqHLUfkhqESVtrPteVBfkfUcF6zA5bEvH4IPKywuw1CVedcphX76eB+qI/i86GsvBqUWfBprG1vNOYmAkBoMR4=
X-Gm-Message-State: AOJu0Yz4wSqUOnaGdDyccNk9Ua5cnmTMP9ZZoXz3ICuhDRiH1dLS1x+G
 ywn5lkAqhzj8unqWFQaI8Jd2K4rujWTg7mWRK+oVRnbzJ8lBw4Aw1lz7+LQz2n0=
X-Google-Smtp-Source: AGHT+IEfEZypEfHXP2NHN4F5WRVPfGhwlcsqhdtrIAi/5DrhakmoBt/VTEh1b67CxUczsRNoy+wAVQ==
X-Received: by 2002:a17:907:76d5:b0:a3f:4315:5960 with SMTP id
 kf21-20020a17090776d500b00a3f43155960mr3684634ejc.32.1708675047562; 
 Thu, 22 Feb 2024 23:57:27 -0800 (PST)
Received: from [192.168.69.100] (sto95-h01-176-184-18-96.dsl.sta.abo.bbox.fr.
 [176.184.18.96]) by smtp.gmail.com with ESMTPSA id
 cw4-20020a170907160400b00a3e4c47bad1sm5772626ejd.8.2024.02.22.23.57.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 23:57:27 -0800 (PST)
Message-ID: <fcca3389-7862-4ecc-865a-404091e3d697@linaro.org>
Date: Fri, 23 Feb 2024 08:57:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] virtio-iommu: Add a granule property
Content-Language: en-US
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, mst@redhat.com,
 jean-philippe@linaro.org, peter.maydell@linaro.org, clg@redhat.com,
 yanghliu@redhat.com
Cc: alex.williamson@redhat.com, zhenzhong.duan@intel.com,
 jasowang@redhat.com, pbonzini@redhat.com, berrange@redhat.com
References: <20240223074459.63422-1-eric.auger@redhat.com>
 <20240223074459.63422-3-eric.auger@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240223074459.63422-3-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 23/2/24 08:27, Eric Auger wrote:
> This allows to choose which granule will be used by
> default by the virtio-iommu. Current page size mask
> default is qemu_target_page_mask so this translates
> into a 4K granule.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> 
> ---
> 
> v3 -> v4:
> - granule_mode introduction moved to that patch
> ---
>   include/hw/virtio/virtio-iommu.h |  1 +
>   hw/virtio/virtio-iommu.c         | 27 ++++++++++++++++++++++++---
>   qemu-options.hx                  |  3 +++
>   3 files changed, 28 insertions(+), 3 deletions(-)


> @@ -1324,7 +1324,26 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
>        * in vfio realize
>        */
>       s->config.bypass = s->boot_bypass;
> -    s->config.page_size_mask = qemu_target_page_mask();
> +
> +    switch (s->granule_mode) {
> +    case GRANULE_MODE_4K:
> +        s->config.page_size_mask = ~0xFFF;

Alternatively:

           s->config.page_size_mask = -(4 * KiB);

> +        break;
> +    case GRANULE_MODE_8K:
> +        s->config.page_size_mask = ~0x1FFF;

           s->config.page_size_mask = -(8 * KiB);

> +        break;
> +    case GRANULE_MODE_16K:
> +        s->config.page_size_mask = ~0x3FFF;

...

> +        break;
> +    case GRANULE_MODE_64K:
> +        s->config.page_size_mask = ~0xFFFF;
> +        break;
> +    case GRANULE_MODE_HOST:
> +        s->config.page_size_mask = qemu_real_host_page_mask();
> +        break;
> +    default:
> +        error_setg(errp, "Unsupported granule mode");
> +    }


