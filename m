Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2112CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 15:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFw11-0007m2-W0; Mon, 03 Nov 2025 09:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFw0p-0007jN-VJ
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 09:58:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vFw0d-0007le-Gb
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 09:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762181891;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R0l/XsXj++MM9FLcwLUjgi1BUhXKqPw/Lw9GEigIpLo=;
 b=gZiA6agUlZyPbBbYbT+Ib2EC1aqLLSE2C59u4Z5IN3Q5dEdQlHwZmnnsvKuZML5MS1Gu8B
 4Qn6g4DAtC8kR1JR1HpP/gurU4v0GPCNzpihyGbvabVStv+x2d/QRZCieRD3/f/6d/Zxc7
 YuFh5Lveed3kB98/29OUVXVYIWbaw5w=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-PQoCoQnhMQ-ID1N38cxvAw-1; Mon, 03 Nov 2025 09:58:10 -0500
X-MC-Unique: PQoCoQnhMQ-ID1N38cxvAw-1
X-Mimecast-MFC-AGG-ID: PQoCoQnhMQ-ID1N38cxvAw_1762181889
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-429c95fdba8so1202596f8f.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 06:58:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762181889; x=1762786689;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R0l/XsXj++MM9FLcwLUjgi1BUhXKqPw/Lw9GEigIpLo=;
 b=JescR1YwskGwuiuBW/4RP6EJ4gK2w4Gau1Lh2gjRdyV42gzvbWm6FbcgpOkmp7bFlu
 UhpMpDTUnnyydEKqU3iRo0ALj9XkEUFKtpo2HyIaZtEiv2qt/kN1VTnqUUhCB1n5NGW1
 UsqC+Y1NxBwcSugRq5RxYVUr9/Hd0tfH90GfQMJfRgWrdfVZ9h61M+gIXo6fLZ92WQQb
 rVhla6qC3y75DQWJQmOi8oNNc0dN0jcJvIOSEE5Rj2kJdPjvXCG/A5McrcTnKpQV4CSb
 mRPOfV3/8HhnO8H9kFz6xh+xVyT0+X6Apl26Iz3zb1D0hS5M+NUg2fa/1v5dO88ttMwZ
 DOhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrwIYj3HPVFF7pgK+5eAlc1ZpFxVXy5w6dqN9z7h8tJ7if7yZKI1sDaIhCIcdbRpuMyzAakmfqqiUS@nongnu.org
X-Gm-Message-State: AOJu0YxT2014RHNqi7wnYr2bf5SP28zKzFs0JaLdV2Z37FX2ThKepIqa
 fsW2P5McADxBTPTCq0Wo5DJXP/jt3+/r1dyBX5mG0k/8Ng8BRUWlOJqTBxIy7u/mSQtpgebNd8U
 6ZINkR12uKGMSSkTC6AJZpgTWFQxZCxgdkHqRlkdkk3xkq9DnF6qN/GsJ
X-Gm-Gg: ASbGncs5YLF1MTnaO9mU0FOpii1iLJv2/xSXwba2FMTjgwywPofPrUb3Vw6ShNyZihE
 v1NKcGm9w0dE3v9oYj+zbSRUFqJdUxNA0aghh+FB5Fo8s5jGX8VF273cYEQz3qh7zNNYEdXIcS5
 DUGs/++Xjyr3msU3XXqHxqrA9Uyvkc5dmID4QuNsgenjXazWRqcYdlUXg2ru1lNJVJZR4YSGy0Y
 WlYcEXCk7M7VO8bEQkNjDWivkNE9v63KIF8J2s47hj30YbHkiTtf6KrJ6NuC0hmpLJcQ/kwpZZF
 s8OTX8QLR1HbWm2FyVRyyoMJJgJ4ib1k3Yjr3rbGerHlgeolkjqnoiT/a8ZAbTtk35CGKuDI+L6
 VbBRjD1JOgD8ThGNjuB/RjW8eSXqEMyMZkTjMnj1GTKPmRw==
X-Received: by 2002:a05:6000:240a:b0:429:d742:87cd with SMTP id
 ffacd0b85a97d-429d7428af2mr2107240f8f.27.1762181888906; 
 Mon, 03 Nov 2025 06:58:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXzzt+tZAvBtU8xV3UC/AP6lUKJBAWliYhy5WWOZov5Uc6hPcOWmxrCbLHtKfB0IEPPPWCJw==
X-Received: by 2002:a05:6000:240a:b0:429:d742:87cd with SMTP id
 ffacd0b85a97d-429d7428af2mr2107213f8f.27.1762181888467; 
 Mon, 03 Nov 2025 06:58:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c54498dfsm17235878f8f.34.2025.11.03.06.58.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Nov 2025 06:58:08 -0800 (PST)
Message-ID: <28dd6856-71ce-445c-9b9c-d4b6502a92bb@redhat.com>
Date: Mon, 3 Nov 2025 15:58:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 21/32] hw/arm/virt: Set PCI preserve_config for accel
 SMMUv3
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com,
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com,
 mochs@nvidia.com, smostafa@google.com, wangzhou1@hisilicon.com,
 jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 zhangfei.gao@linaro.org, zhenzhong.duan@intel.com, yi.l.liu@intel.com,
 kjaju@nvidia.com
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-22-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20251031105005.24618-22-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 10/31/25 11:49 AM, Shameer Kolothum wrote:
> Introduce a new pci_preserve_config field in virt machine state which
> allows  the generation of DSM #5. This field is only set if accel SMMU
> is instantiated.
>
> In a subsequent patch, SMMUv3 accel mode will make use of IORT RMR nodes
> to enable nested translation of MSI doorbell addresses. IORT RMR requires
> _DSM #5 to be set for the PCI host bridge so that the Guest kernel
> preserves the PCI boot configuration.
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/virt-acpi-build.c | 8 ++++++++
>  hw/arm/virt.c            | 4 ++++
>  include/hw/arm/virt.h    | 1 +
>  3 files changed, 13 insertions(+)
>
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 8bb6b60515..d51da6e27d 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -163,6 +163,14 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
>          .pci_native_hotplug = !acpi_pcihp,
>      };
>  
> +    /*
> +     * Accel SMMU requires RMRs for MSI 1-1 mapping, which require _DSM for
> +     * preserving PCI Boot Configurations
as suggested in v4 you can be more precise and explictly state

_DSM function 5 (Ignore PCI Boot Configuration)

> +     */
> +    if (vms->pci_preserve_config) {
> +        cfg.preserve_config = true;
> +    }
> +
>      if (vms->highmem_mmio) {
>          cfg.mmio64 = memmap[VIRT_HIGH_PCIE_MMIO];
>      }
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 175023897a..8a347a6e39 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -3091,6 +3091,10 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>              }
>  
>              create_smmuv3_dev_dtb(vms, dev, bus);
> +            if (object_property_find(OBJECT(dev), "accel") &&
why do you need to test

object_property_find(OBJECT(dev), "accel")?

> +                object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
> +                vms->pci_preserve_config = true;
> +            }
>          }
>      }
>  
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 04a09af354..60db5d40b2 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -182,6 +182,7 @@ struct VirtMachineState {
>      bool ns_el2_virt_timer_irq;
>      CXLState cxl_devices_state;
>      bool legacy_smmuv3_present;
> +    bool pci_preserve_config;
>  };
>  
>  #define VIRT_ECAM_ID(high) (high ? VIRT_HIGH_PCIE_ECAM : VIRT_PCIE_ECAM)
With those changes takin into account
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


