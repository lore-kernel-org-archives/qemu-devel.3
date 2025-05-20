Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC91C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 12:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHM7m-00039J-AS; Tue, 20 May 2025 08:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uHM7g-00038L-JP
 for qemu-devel@nongnu.org; Tue, 20 May 2025 08:31:10 -0400
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uHM7Z-0004ey-6l
 for qemu-devel@nongnu.org; Tue, 20 May 2025 08:31:08 -0400
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-525da75d902so1780572e0c.3
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 05:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747744257; x=1748349057; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UJGR+g/Y+CLu5+h11cSkPA43CVX76D8jK97YeC0XAaM=;
 b=Ks2uB2Y62TF1BIsTKwTI8KF9b803j6Kgoy0qpGr6O80sOsYcXNtYCm47vxM6jQrU5Z
 J/vzv3t28yZLAc8gh2aAadhdsyBrTEUltMltMAudcPm9V+gSIG2TV0bGsD2MmT9ogeYY
 Pz7z4IsOO2XU8UrEPpemUxpYM/SBe/gRDC5e2KIGZ4yQjHb3IhlKv1c6Cd3I5jlpBwNX
 Ej0d3u16GEw1L3tcOMgI8NajLyx6/Ue7DQmFlfb63DQYXxrftyYqKMhQpbXGlI9npvzW
 BYBj72pXEeUM2GAEvMzXXKqv0L7pDKvet2B+fjBevnYv1FSVmTW0h0XIs3eGJxDWeh2N
 cCjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747744257; x=1748349057;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UJGR+g/Y+CLu5+h11cSkPA43CVX76D8jK97YeC0XAaM=;
 b=aSt98hTyuJMqEsiWpuqYJgBDdXlz1eO4yrNJ2ERiwtNsXWgxIvx2WesmK0+MXvyXtg
 n7JtKaqGMS/2zmbKh0KjrX3hTXAX9CxxD1aQ1L/2uXCtJQQoLPQKbWP1gI2rWDe7s5EL
 1f/Bahgfl/0ZUNbL+Rc66YkE03qOE/9PipCWRWSdCqEQ/HiCgV5Xi2AtOqW6lMM8Ov4M
 lHOsEOnwP4G6+8eXSBgQZ+J/pWm9b1vUHYHUnqJAKULR4ilA0oZtuSjITkXRDHjTOVgM
 ikyUnWSaqGQXjCh65dzXbKthZRA7PZJuvRpQ2e/amaXFN8/g2Gluo1dN8Zr2j8k0Dyyn
 tFQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2abozo+Owy1rviBbftDXqki2tJRRs/l4Qd0s0UkQTbXxcqZzNJRyM3RsYbLhDaJvfgU4dY1UtGCtv@nongnu.org
X-Gm-Message-State: AOJu0Yx4zwVYgTUcDFnQ8pSgqR6PQwDe1+CyaVpJ02Ny0/ZHou2vX+st
 1y/9NjFMm1nqelxrdvlFNBlbOt44Hf9sY0Xh5M6xLTW4zr02Yw2rBGAL5ay+XKnSwJQ=
X-Gm-Gg: ASbGncvxn1c23eRJTIjCYp6+9/vnaDu/UZ8BRFWNDPKJzXTw35uf/N3khz2MV3Ytc4A
 Tg3sIfHGTO3IFkTZinw6EJ/M5mz4nHkAXDt/33tBKzZuIFvwMQ0JBOQoNLdb8ClF93f88rj5LT1
 ZqnM/fHRVOdBLzu4cg/TVFO4rboqsdpdaIjzzW499yVhIx4dYuY9Qs//RJo1PytQYlgHervsvhO
 kHvV303HZTo4alde+GDHvqO61SlAUQ+2sHPtA8A7Bdnv5ktLnJVy5+BRkpr2EFCzp+e7cNhhWFT
 jQUM1+63yz9kZnYi8KAm8f2ITXr0p81QIvT249cC5xbwAzIiy1nLcknKDd9R2jULBP4VzyrvWIg
 65qYKAn1Wy9ZUEPd7624O1ARWkfVIFg==
X-Google-Smtp-Source: AGHT+IGukuMUQY7/zEzohH8cH/msWOvCxz/jComzT/mR+kHrfUCqQeF4zwA+UWMZpfhQDs7CpdLCUQ==
X-Received: by 2002:a05:6122:16a7:b0:52a:ee1a:4249 with SMTP id
 71dfb90a1353d-52dba8d624fmr14816806e0c.7.1747744256846; 
 Tue, 20 May 2025 05:30:56 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b401:d47f:6989:b93e:2caa:f174?
 ([2804:7f0:b401:d47f:6989:b93e:2caa:f174])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-52dba910a60sm8454649e0c.9.2025.05.20.05.30.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 05:30:56 -0700 (PDT)
Message-ID: <a0275df9-7e4d-41ad-b417-7c27f820df9d@linaro.org>
Date: Tue, 20 May 2025 09:30:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/22] hw/i386/acpi-build: Make aml_pci_device_dsm() static
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org
References: <20250514170431.2786231-1-eric.auger@redhat.com>
 <20250514170431.2786231-2-eric.auger@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250514170431.2786231-2-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vk1-xa2b.google.com
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

On 5/14/25 14:00, Eric Auger wrote:
> No need to export aml_pci_device_dsm() as it is only used
> in hw/i386/acpi-build.c.
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   include/hw/acpi/pci.h | 1 -
>   hw/i386/acpi-build.c  | 2 +-
>   2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
> index 6359d574fd..ab0187a894 100644
> --- a/include/hw/acpi/pci.h
> +++ b/include/hw/acpi/pci.h
> @@ -36,7 +36,6 @@ typedef struct AcpiMcfgInfo {
>   
>   void build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info,
>                   const char *oem_id, const char *oem_table_id);
> -Aml *aml_pci_device_dsm(void);
>   
>   void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus);
>   void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope);
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index f40ad062f9..9e584e69fd 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -338,7 +338,7 @@ build_facs(GArray *table_data)
>       g_array_append_vals(table_data, reserved, 40); /* Reserved */
>   }
>   
> -Aml *aml_pci_device_dsm(void)
> +static Aml *aml_pci_device_dsm(void)
>   {
>       Aml *method;
>   

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

