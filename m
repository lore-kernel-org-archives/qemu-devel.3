Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA448C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 05:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJQpd-0005ka-L8; Mon, 26 May 2025 01:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJQpb-0005ja-74
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:57:03 -0400
Received: from mail-vk1-xa44.google.com ([2607:f8b0:4864:20::a44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uJQpZ-0004xS-15
 for qemu-devel@nongnu.org; Mon, 26 May 2025 01:57:02 -0400
Received: by mail-vk1-xa44.google.com with SMTP id
 71dfb90a1353d-527a2b89a11so626956e0c.2
 for <qemu-devel@nongnu.org>; Sun, 25 May 2025 22:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748239019; x=1748843819; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0333nFR5VO93Qg/vZWJTPw0awU+N/Ed9pswmK7swKVE=;
 b=DWW6DP4cRIpDnNiQtqjpc5ukwotMl8eeNfLAVvmEJMeCLlP0JOHKgl2mEwDjQDwQQh
 rGtGxXtKfKMKE7z+ex63KX3uZ0s7a+sfztBYN2/dZoHCsH42ckADIuH9NfNKZcJK6R1R
 P1/FCY9YGD7LudDrxsb1lRqBVuraxF7x9Zooh3FtXqK8/PqbFsCQq5A6P3tEBTZJ7zee
 OQsIudPK397QaOGw1wslrd/EofnqA2CTL2R2IDvGtiJGAKhsLveIcI1EhvEswndnOkFx
 pYUzMMfuxU3I6Q8XsQlcOQiivmzzmx/+gDDXdiko5Az8M6W6TAM3veIPpUZhy5zEXoY9
 p9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748239019; x=1748843819;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0333nFR5VO93Qg/vZWJTPw0awU+N/Ed9pswmK7swKVE=;
 b=i/3M+X578Gd078wuZB4ZJhk1JQr+lXmv/ugEsu+wxGo+EOt4J8E+E6xgHmfRpUtVUX
 nACCDye5FIZ9K83NM1Yj5clmAYV09z1dh7oXNiWjA4FFitOk2EEBYJaCvi6ajRQh9/JS
 M0GdQkVsrHUBz09owBsx9EyTa0Dy5aRiL/u9pEv1gyF7c5qaIew9uXfK8Cty9wRFY5oM
 K5Zp4UZYpHMXCxzO5Yie28dJXiiuysgfNbQGy6GwJrB5oTc+yhJVRDp7qtS3dfznaPG7
 fUFxS3agj2wqyJpgPmn4l2LAEBo6jIaQBT7cJqw93MsKhTO+lpUimc8XFsSvp0ruJWSG
 eAYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmuon9ai38/9Go42qaeq719d97ms+NCE+s9kRDk8iMRo4Cz6D7yKW9UxF1YqytazFPih6X22cI7jfe@nongnu.org
X-Gm-Message-State: AOJu0YzhLoto7g/AbdGSSu7zl4s3ClhjbUZash5xaqn2AcIfJ8OlxCJR
 K9U8HOXyKb8P/chD3s52kPj9S6a0378dG4BioaHtarwpHaoKeem65IOuRPj2Mgja+dw=
X-Gm-Gg: ASbGnctyiA18DaNnv8d6ypEBV2hejgnc0Ifa6BvcolZAtDh/JwuvWC6hzr88qJS2I4T
 09KGFJiQjWQBSQl4gqQujTlGlUrPdncp3pmWNxciFVxuzKv061YwTk1oMc5oUyCybLzOW6nuk30
 ALwXw1hvn4IMRSEp+WhwMq70jLsg+IKrGvwRPeAry5CmfCw1LK9TyU5qG/TQOyFVoNsFy+HD4Db
 APswARSp7de7KS2cNCxE2wBgsfxQEWiMGcAX9fhQX6mDDQ4oQwULwBxJFh1gzedLR5rREsPqtjL
 +uqId7XqB726+QmC2L5PDvYm8tolQbsUIAWynRyqtVS3OP8uChG+YxzVlndBttbpS/Kzfyy1XNU
 aJ6RYeumzAf78qsJFxLHkfF7xTdwaNQ==
X-Google-Smtp-Source: AGHT+IEpguk25WFNnLKETKuWVWCEyBDS7G3shu/fATyNoQ8dz38JeHWJfOZLVMITnPDbkSWP7kD5ZA==
X-Received: by 2002:a05:6122:182a:b0:52d:bc0d:83f with SMTP id
 71dfb90a1353d-52f2c5b5bc9mr5724786e0c.11.1748239019183; 
 Sun, 25 May 2025 22:56:59 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b402:6ba2:d081:510e:25da:56a5?
 ([2804:7f0:b402:6ba2:d081:510e:25da:56a5])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-52dba910b92sm17245357e0c.1.2025.05.25.22.56.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 May 2025 22:56:58 -0700 (PDT)
Message-ID: <6b7b0e20-546b-4b72-9489-4468fafb76ba@linaro.org>
Date: Mon, 26 May 2025 02:55:57 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/22] ACPI PCI Hotplug support on ARM
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com, philmd@linaro.org
References: <20250514170431.2786231-1-eric.auger@redhat.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250514170431.2786231-1-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a44;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vk1-xa44.google.com
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

Hi Eric,

On 5/14/25 14:00, Eric Auger wrote:
> This series enables ACPI PCI hotplug/hotunplug on ARM
> and makes it default for 10.1 machine type. This aligns with
> x86 q35 machine. Expected benefits should be similar to
> those listed in [1].
> 
> It is still possible to disable it using a virt machine
> option: virt,acpi-pcihp=off and restore the legacy behavior.
> 
> The infrastructure used in x86 is heavily reused and a
> huge part of the series consists in moving code from
> hw/i386/acpi-build.c to a generic place and slightly
> adapting it to make it usable on ARM. The DSDT table is
> augmented to support ACPI PCI hotplug elements.
> 
> On ARM we use use a GED event to notify the OS about
> hotplug events.
> 
> I have not noticed any tests/qtest/bios-tables-test failures
> neither on x86 nor ARM. x86 DSDT table has not changed.
> ARM DSDT table definitively has but there are no tests
> impacted. ARM misses hotplug tests that do exist on x86. This
> most probably should be considered in the future.

I've just posted a v1 for a acpi-pcihp=on test:

https://mail.gnu.org/archive/html/qemu-devel/2025-05/msg05824.html

The odd thing is that I noticed failures in the existing aarch64
acpi tests in tests/qtest/bios-tables-test. At least the rename
of the variable 'CTRL' to 'Local0' in the _OSC method should cause
a mismatch against the current base DSDT? So I had to handle it
via patches 1/5, 2/5, and 3/5. The diff is in the 3/5 commit body.


Cheers,
Gustavo

> Best Regards
> 
> Eric
> 
> This series can be found at:
> https://github.com/eauger/qemu/tree/arm-acpi-pcihp-v1
> 
> previous RFC:
> https://github.com/eauger/qemu/tree/arm-acpi-pcihp-rfc
> 
> History:
> RFC -> v1:
> - First 3 trivial patches were pulled separately
> - Fix of the register region size (0x18), ie. ACPI_PCIHP_SIZE
> - addition of aml_pci_edsm which was not called in RFC
> - acpi-index feature is now fixed. vms->bus was not set on
>    acpi_pcihp_init. The init sequence is still hacky though. Suggestions
>    appreciated.
> 
> [1] [PATCH v6 0/6] Use ACPI PCI hot-plug for Q35
> https://lore.kernel.org/all/20210713004205.775386-1-jusual@redhat.com/
> 
> 
> Eric Auger (22):
>    hw/i386/acpi-build: Make aml_pci_device_dsm() static
>    hw/arm/virt: Introduce machine state acpi pcihp flags and props
>    hw/acpi: Rename and move build_x86_acpi_pci_hotplug to pcihp
>    hw/pci-host/gpex-acpi: Add native_pci_hotplug arg to
>      acpi_dsdt_add_pci_osc
>    hw/pci-host/gpex-acpi: Split host bridge OSC and DSM generation
>    hw/pci-host/gpex-acpi: Propagate hotplug type info from virt machine
>      downto gpex
>    hw/i386/acpi-build: Turn build_q35_osc_method into a generic method
>    hw/pci-host/gpex-acpi: Use build_pci_host_bridge_osc_method
>    hw/i386/acpi-build: Introduce build_append_pcihp_resources() helper
>    hw/acpi/pcihp: Add an AmlRegionSpace arg to build_acpi_pci_hotplug
>    hw/i386/acpi-build: Move build_append_notification_callback to pcihp
>    hw/i386/acpi-build: Move build_append_pci_bus_devices/pcihp_slots to
>      pcihp
>    hw/i386/acpi-build: Introduce and use acpi_get_pci_host
>    hw/i386/acpi-build: Move aml_pci_edsm to a generic place
>    hw/arm/virt-acpi-build: Modify the DSDT ACPI table to enable ACPI PCI
>      hotplug
>    hw/acpi/ged: Prepare the device to react to PCI hotplug events
>    hw/acpi/ged: Call pcihp plug callbacks in hotplug handler
>      implementation
>    hw/acpi/ged: Support migration of AcpiPciHpState
>    hw/core/sysbus: Introduce sysbus_mmio_map_name() helper
>    hw/arm/virt: Let virt support pci hotplug/unplug GED event
>    hw/arm/virt: Plug pcihp hotplug/hotunplug callbacks
>    hw/arm/virt: Use ACPI PCI hotplug by default
> 
>   hw/i386/acpi-build.h                   |   4 -
>   include/hw/acpi/aml-build.h            |   2 +
>   include/hw/acpi/generic_event_device.h |   5 +
>   include/hw/acpi/pci.h                  |   4 +-
>   include/hw/acpi/pcihp.h                |  19 +-
>   include/hw/arm/virt.h                  |   4 +
>   include/hw/pci-host/gpex.h             |   1 +
>   include/hw/sysbus.h                    |   1 +
>   hw/acpi/aml-build.c                    |  50 +++
>   hw/acpi/generic_event_device.c         |  55 +++
>   hw/acpi/pci.c                          |  20 +
>   hw/acpi/pcihp.c                        | 482 ++++++++++++++++++++-
>   hw/arm/virt-acpi-build.c               |  27 ++
>   hw/arm/virt.c                          | 107 ++++-
>   hw/core/sysbus.c                       |  11 +
>   hw/i386/acpi-build.c                   | 552 +------------------------
>   hw/pci-host/gpex-acpi.c                |  75 +---
>   hw/arm/Kconfig                         |   2 +
>   18 files changed, 806 insertions(+), 615 deletions(-)
> 


