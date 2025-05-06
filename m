Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E7AC3ABB6
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 00:13:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC5wT-0008Ul-09; Mon, 05 May 2025 20:13:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uC5wP-0008PU-TV
 for qemu-devel@nongnu.org; Mon, 05 May 2025 20:13:46 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uC5wN-0000FT-NW
 for qemu-devel@nongnu.org; Mon, 05 May 2025 20:13:45 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-739be717eddso4084079b3a.2
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 17:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746490421; x=1747095221; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7tMzkpLpD5LRZmab/4DzH4SXMTJDCn4ory0YOGcHN3M=;
 b=wm70vdWsHdMHjR7Jrtw8e6wZ0hnn+9YNtKNDp4JFyWxYReAmZUZktMgNpDHWqXvbE4
 MeW1a/Rtd/GLjwP5NWnyLG4qhAf/RTF5rVGuefzdgtQrWvSm80jyMLWNvP1iZoG3z+c4
 RUan0108VcV/Ots1ID3BhWhVMWxOUaXfwCRPJecURriX3zf8j8Vsk5Nexw2GqOocgJsh
 QIrLNIFItY6B1KQ2BZkCm0HH6ZnEwKH3y4UW+tz/iN/1T4ZoTsCrKN0Snd4AW0hSwsfz
 gVGN0RBUusZoJ/HpunzkoEoXy9Evq9gWRcVDyEC9pbMZrdkXCxatvaii3LVb4Fh9meHm
 UpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746490421; x=1747095221;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7tMzkpLpD5LRZmab/4DzH4SXMTJDCn4ory0YOGcHN3M=;
 b=FVepv+1JG3p1YL12kzcD0dXdiYH4a0CkYAIxBNQV1nXEeWtQIIVPCRsql10i3u7hTJ
 diN8xeGSWIeIYGZzYHXoBddkG1J3QzoxwRUGdMFVC0NUqUOB7vB+ibmaXeMbKycgMloo
 JjVcKZz0Bf5puEXRJGmv7PYqfb9i9clPfd3aqn/2p1cnmhNkp9FQlbQaPWzGNWrGIb6G
 8p7wc/QrtQJaK4lmGYBiayYFjWh4ulEdlq99yVF0/7TmCJgi5HrxyGSD4ISONcgF2TLS
 Zb6209L9X0+0H/xry7J7FNbNuS0Nnuw1qHwfQX4h8Ab9NEq7b7Yhh0d+sxcm2Xaqqowd
 tN/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTM9i0ihHSvUsQzepreJdWHYzsz5ivh5eHsqoX375LrG4R+LyDUOjTUjOH9tofhXQnBCXNfhIhplgq@nongnu.org
X-Gm-Message-State: AOJu0YzAPgbkmcQIUjOzFDtNgEXGncoW4DTzQA+kLdVdO+f7a0eIubFe
 FJGpRE9c5zNqlbXOEL6dRJp8Ujs2ZY/AwkRL+7we7UVhib3Gg7H6UQWaTIogeIk=
X-Gm-Gg: ASbGncv71lllbJJTCym/zBhVpEYnMRyH3/WqLEjNHZVBjzKr4Y2bzbjeZx46QXsggEF
 YTUxfgyE7F8bNVbXTFvJYj3mjg94KONQcxW3uXeAtEgPVfUcl9Pk3nsUEvDAmOyL+F6shnaF0Z0
 H+6o7fE3euAI4z9F/qYpNvX2pxIVqUA/3SoqMUdG5Oa7AxU+31Ds1Ocsi47juhXC/SHrkFigAHT
 7XxCA+SFfCXpDdjrs1iUPzJpTTQXu/Xjuw3e/oQdJKc7Uu2g+MZenHz2MDIihmvMB1pEtY5n48q
 NlId+UGQcTw1eLjh5rboG/SXS9S58hCbrnpYoefiB4GmRjmvmoJOlXvHwruHNpJWrGKrzHBr294
 HPzngS7xkaqepAEofStA=
X-Google-Smtp-Source: AGHT+IG171eEDGSX0K3/qjWPRfQvD/L7R6HyzzjJ6FVjrXwUqIsdEL77SYW3Ch09VNp4Xsy/CDTKdA==
X-Received: by 2002:a05:6a00:6314:b0:740:91e4:8107 with SMTP id
 d2e1a72fcca58-74091e481e1mr970010b3a.0.1746490421122; 
 Mon, 05 May 2025 17:13:41 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b400:8604:71fc:f75a:e2f5:e7b5?
 ([2804:7f0:b400:8604:71fc:f75a:e2f5:e7b5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059020faesm7805760b3a.95.2025.05.05.17.13.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 17:13:40 -0700 (PDT)
Message-ID: <1b19582a-3587-486b-9794-b60d70b12a1f@linaro.org>
Date: Mon, 5 May 2025 21:13:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [RFC 09/24] hw/pci-host/gpex-acpi: Propagate hotplug type info
 from virt machine downto gpex
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com
References: <20250428102628.378046-1-eric.auger@redhat.com>
 <20250428102628.378046-10-eric.auger@redhat.com>
Content-Language: en-US
In-Reply-To: <20250428102628.378046-10-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42c.google.com
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

Hi Eric,

On 4/28/25 07:25, Eric Auger wrote:
> Propagate the type of pci hotplug mode downto the gpex
> acpi code. In case machine acpi_pcihp is unset we configure
> pci native hotplug on pci0. For expander bridges we keep
> legacy pci native hotplug, as done on x86 q35.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   include/hw/pci-host/gpex.h | 1 +
>   hw/arm/virt-acpi-build.c   | 1 +
>   hw/pci-host/gpex-acpi.c    | 3 ++-
>   3 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
> index 84471533af..feaf827474 100644
> --- a/include/hw/pci-host/gpex.h
> +++ b/include/hw/pci-host/gpex.h
> @@ -45,6 +45,7 @@ struct GPEXConfig {
>       MemMapEntry pio;
>       int         irq;
>       PCIBus      *bus;
> +    bool        pci_native_hotplug;
>   };
>   
>   typedef struct GPEXIrq GPEXIrq;
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 3ac8f8e178..46c5a43d27 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -129,6 +129,7 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
>           .ecam   = memmap[ecam_id],
>           .irq    = irq,
>           .bus    = vms->bus,
> +        .pci_native_hotplug = !vms->acpi_pcihp,
>       };
>   
>       if (vms->highmem_mmio) {
> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> index 9d9f5ed7c6..9a521145bd 100644
> --- a/hw/pci-host/gpex-acpi.c
> +++ b/hw/pci-host/gpex-acpi.c
> @@ -204,6 +204,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>               if (is_cxl) {
>                   build_cxl_osc_method(dev);
>               } else {
> +                /* pxb bridges do not have ACPI PCI Hot-plug enabled */
>                   acpi_dsdt_add_host_bridge_methods(dev, true);
>               }
>   
> @@ -279,7 +280,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>       }
>       aml_append(dev, aml_name_decl("_CRS", rbuf));
>   
> -    acpi_dsdt_add_host_bridge_methods(dev, true);
> +    acpi_dsdt_add_host_bridge_methods(dev, cfg->pci_native_hotplug);
>   
>       Aml *dev_res0 = aml_device("%s", "RES0");
>       aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

