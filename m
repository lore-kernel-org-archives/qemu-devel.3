Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D913C00A94
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 09:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvD0x-0002eF-1i; Fri, 12 Apr 2024 05:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rvD0s-0002dE-Ng
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 05:16:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rvD0p-0001TS-GS
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 05:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712913354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=STt9A/a+9/d2iC/Ukekn+zLalCOcNBmhcUjt+fpbm4s=;
 b=cq9eKgheksFulA57hS2jsldjw19Yt9gMD1W9JQ3cWqcIA7P0hgMoDiiqnrjxPv1RZLgbWO
 a4Bahr2oBPdOy24MmSuqKpDJmLR1w4ak/Q0KyUEUg9U/b/sw5xmru8qS7J7cWws3nyrknZ
 pPyREo6237VfvmR9ET7DQVldl1rGMGk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-v-trwtIhN5-ae-Az0mqnNg-1; Fri, 12 Apr 2024 05:15:50 -0400
X-MC-Unique: v-trwtIhN5-ae-Az0mqnNg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-78ed20d9423so6656385a.3
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 02:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712913349; x=1713518149;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=STt9A/a+9/d2iC/Ukekn+zLalCOcNBmhcUjt+fpbm4s=;
 b=GxtEXF2fWy0exLgIoj+YMmqzf/zP5jaXanCuzWhlLCeQGQK5KJH1LZDligtvvlIySG
 EFTVVnxxlBq+owW7ikKJqKSrUs+2lFQx0qS7h7YHfNgh8aaBo1EjmSPATsRJCkzEefHw
 zAa1HMkYkKk/Sl5zxZoRDogfctqvSssH3bKwJQpGBLaIuEQUvjaLgKltkQcD1lACtUCN
 J0Xh5KMSLTiT1pgCi/gd+OKxD+n63khtJVLU0lhRyHI0QbYE8j20+6WG1ppoulUCwVU5
 V2JIHVVZd84dWo5b9JqAme3joKfQ2ERzVymIjSsZQl5GFCxEglzZo9hBnBW+ryDOokWw
 bTKg==
X-Gm-Message-State: AOJu0YywQu0PgZ/zysMxiNxF5i87peMQVIfeRk8jmjO6yUqItfEMo6NO
 qPwr8dt+ixvKhotZKEQ/dKoIAnYbaHTurA0ly5vWzUY69esdYhfWGt5zGE1jTSe9ZEmAGVacPnQ
 e2ObEos9SWrP3NGsVQI2ODwK/tN4MxuOaMkZ+mZ0dGx7FVvA0dnMl2yOVkvaObpXTAnpw5Zk+gQ
 BLVV+yi58XBOznVPLknkWNCZdJV83m1Ttt
X-Received: by 2002:a05:620a:b84:b0:78d:5afc:eeec with SMTP id
 k4-20020a05620a0b8400b0078d5afceeecmr1822485qkh.20.1712913349598; 
 Fri, 12 Apr 2024 02:15:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6L8Qo456VhwNR5y9Xd9Qtq3e8DHYpzf55Ip0I0lUeVwAAy90WOfT3zcCjwo7uLbXQgg7dUg==
X-Received: by 2002:a05:620a:b84:b0:78d:5afc:eeec with SMTP id
 k4-20020a05620a0b8400b0078d5afceeecmr1822466qkh.20.1712913349280; 
 Fri, 12 Apr 2024 02:15:49 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-179-142.web.vodafone.de.
 [109.43.179.142]) by smtp.gmail.com with ESMTPSA id
 qp13-20020a05620a388d00b0078ec3c4452dsm1788403qkn.9.2024.04.12.02.15.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 02:15:48 -0700 (PDT)
Message-ID: <12d6a650-a0a9-4e25-9ad1-68aa03064794@redhat.com>
Date: Fri, 12 Apr 2024 11:15:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw: Add a Kconfig switch for the TYPE_CPU_CLUSTER
 device
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20240412062042.105174-1-thuth@redhat.com>
 <20240412062042.105174-3-thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240412062042.105174-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.49,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/04/2024 08.20, Thomas Huth wrote:
> The cpu-cluster device is only needed for some few arm and riscv
> machines. Let's avoid compiling and linking it if it is not really
> necessary.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/arm/Kconfig     | 3 +++
>   hw/cpu/Kconfig     | 3 +++
>   hw/cpu/meson.build | 2 +-
>   hw/riscv/Kconfig   | 2 ++
>   4 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index d97015c45c..5d4015b75a 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -485,6 +485,7 @@ config XLNX_ZYNQMP_ARM
>       select AHCI
>       select ARM_GIC
>       select CADENCE
> +    select CPU_CLUSTER
>       select DDC
>       select DPCD
>       select SDHCI
> @@ -503,6 +504,7 @@ config XLNX_VERSAL
>       default y
>       depends on TCG && AARCH64
>       select ARM_GIC
> +    select CPU_CLUSTER
>       select PL011
>       select CADENCE
>       select VIRTIO_MMIO
> @@ -688,6 +690,7 @@ config ARMSSE
>       select CMSDK_APB_DUALTIMER
>       select CMSDK_APB_UART
>       select CMSDK_APB_WATCHDOG
> +    select CPU_CLUSTER
>       select IOTKIT_SECCTL
>       select IOTKIT_SYSCTL
>       select IOTKIT_SYSINFO
> diff --git a/hw/cpu/Kconfig b/hw/cpu/Kconfig
> index f776e884cd..baff478e1b 100644
> --- a/hw/cpu/Kconfig
> +++ b/hw/cpu/Kconfig
> @@ -12,3 +12,6 @@ config A15MPCORE
>   config ARM11MPCORE
>       bool
>       select ARM11SCU
> +
> +config CPU_CLUSTER
> +    bool
> diff --git a/hw/cpu/meson.build b/hw/cpu/meson.build
> index 38cdcfbe57..43a34c4c6e 100644
> --- a/hw/cpu/meson.build
> +++ b/hw/cpu/meson.build
> @@ -1,4 +1,4 @@
> -system_ss.add(files('core.c', 'cluster.c'))
> +system_ss.add(when: 'CONFIG_CPU_CLUSTER', if_true: files('core.c', 'cluster.c'))

Oops, sorry, the switch should only be used for cluster.c, not for core.c. 
I'll change it in v2 ...

  Thomas


