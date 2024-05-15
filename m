Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463E5C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 12:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7E5A-0005kk-Bb; Wed, 15 May 2024 08:50:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.cheng.linux@gmail.com>)
 id 1s7858-0002Ji-9e; Wed, 15 May 2024 02:25:42 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eric.cheng.linux@gmail.com>)
 id 1s7856-0003eE-EY; Wed, 15 May 2024 02:25:42 -0400
Received: by mail-pg1-x544.google.com with SMTP id
 41be03b00d2f7-6001399f22bso4411213a12.0; 
 Tue, 14 May 2024 23:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715754338; x=1716359138; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VL3eWkqSKi0DqUXx6X9gpbwc7M71wrmWxptUiwzGgmA=;
 b=czNytM2hkK7GaWoS6YaSVrz2o2hKrlg7Hi6DJgE0N0e80ZzNlY93ghEehBHEQzCzwg
 ZT/9ga5zH6OOWjYk5cUcokOL3NEPlr5OoQgt+sTnmLdy025Kg1n6lGv3euuqdHCHpk0H
 dWh6w55y+lQozTw147xbjCkhM67fn9RVzbfwLHKOAPJZmWroglLMfbZrlLJPAGsN2zMI
 dMDo85nZy0CaXRGSsn2UmdeANh6bd95IGysq6+lrINR/vFgrRbM1QTPxBKzvaS2+VA7D
 0ifHxwteePQBMv4yUxa6CwHYPTPbzYksinOxcIRohPDEZkGBFQqV7mIzMxrresQS/UE9
 STEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715754338; x=1716359138;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VL3eWkqSKi0DqUXx6X9gpbwc7M71wrmWxptUiwzGgmA=;
 b=dQ0lTn1SwGLOl6kwAQyu77MmwyYCdy0nWMstxBaM3vxY8yLrEXx5OGhkqwznTzeT9C
 jlmkLEbWTrkPJwlepnA3qZXPbgTYRd7Yt9H9H6GhW5Z/ZmreDmV75QSvrNxFZDOELoUr
 v2G/zNDhqlNyIzuVtvky84QX4j3uH0yXo/pZvCtJakwUpMhIOwbSV0dgARx2lvWXnqvk
 +269OZD7Oepm/9EsMUpANhip9ISp1ecyiuVIq9S3j1H0CtSrgf5cHijSnAPQDd5dVG2B
 hqSP8Rmwa5webMzrbDiuy7haHj1aBKHnaNjQUffUI2V23cRc8lZZJ97Yf4MDWE7d4n00
 /Hiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiHa1CLLaJ+4ZAcSgo3k/UXth0/HFG1jTT3zI8haTfF9mhRfKtyKUyrwJXhEHIQGXVBcB4Y1Ts0q5MCW0PfefpZ0wx+DU=
X-Gm-Message-State: AOJu0YxcOiGZzi+hDR/F4GWHWGuaPIo3pH3oOrXmFN93c3vBmMpMFCUu
 Z93zTKOfec7ch2S/kowYWEZ78oEkALqo6w1WoX5bRBt0b+KYqksY
X-Google-Smtp-Source: AGHT+IEtBLz0p61NdoN9T5a1ukaH7Cb4jvNohnNRtSNsyRVsSu5/fQK5VpbsqWGMor5sgyNuINO1uQ==
X-Received: by 2002:a17:90a:4a15:b0:2b9:e3:3561 with SMTP id
 98e67ed59e1d1-2b900e336b2mr6478984a91.43.1715754337592; 
 Tue, 14 May 2024 23:25:37 -0700 (PDT)
Received: from [172.27.234.192]
 (ec2-16-163-40-128.ap-east-1.compute.amazonaws.com. [16.163.40.128])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b62886d069sm12685522a91.25.2024.05.14.23.25.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 May 2024 23:25:37 -0700 (PDT)
Message-ID: <41835d3f-d9e2-4ace-8add-f5bb6c525c5f@gmail.com>
Date: Wed, 15 May 2024 14:25:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/15] hw/riscv/virt.c: support for RISC-V IOMMU
 PCIDevice hotplug
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com, tjeznach@rivosinc.com
References: <20240307160319.675044-1-dbarboza@ventanamicro.com>
 <20240307160319.675044-7-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Eric Cheng <eric.cheng.linux@gmail.com>
In-Reply-To: <20240307160319.675044-7-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=eric.cheng.linux@gmail.com; helo=mail-pg1-x544.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 15 May 2024 08:50:03 -0400
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

On 3/8/2024 12:03 AM, Daniel Henrique Barboza wrote:
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
> 
> Generate device tree entry for riscv-iommu PCI device, along with
> mapping all PCI device identifiers to the single IOMMU device instance.
> 
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> ---
>   hw/riscv/virt.c | 33 ++++++++++++++++++++++++++++++++-
>   1 file changed, 32 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index a094af97c3..67a8267747 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -32,6 +32,7 @@
>   #include "hw/core/sysbus-fdt.h"
>   #include "target/riscv/pmu.h"
>   #include "hw/riscv/riscv_hart.h"
> +#include "hw/riscv/iommu.h"
>   #include "hw/riscv/virt.h"
>   #include "hw/riscv/boot.h"
>   #include "hw/riscv/numa.h"
> @@ -1004,6 +1005,30 @@ static void create_fdt_virtio_iommu(RISCVVirtState *s, uint16_t bdf)
>                              bdf + 1, iommu_phandle, bdf + 1, 0xffff - bdf);
>   }
>   
> +static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
> +{
> +    const char comp[] = "riscv,pci-iommu";
> +    void *fdt = MACHINE(s)->fdt;
> +    uint32_t iommu_phandle;
> +    g_autofree char *iommu_node = NULL;
> +    g_autofree char *pci_node = NULL;
> +
> +    pci_node = g_strdup_printf("/soc/pci@%lx",
> +                               (long) virt_memmap[VIRT_PCIE_ECAM].base);
> +    iommu_node = g_strdup_printf("%s/iommu@%x", pci_node, bdf);
> +    iommu_phandle = qemu_fdt_alloc_phandle(fdt);
> +    qemu_fdt_add_subnode(fdt, iommu_node);
> +
> +    qemu_fdt_setprop(fdt, iommu_node, "compatible", comp, sizeof(comp));
> +    qemu_fdt_setprop_cell(fdt, iommu_node, "#iommu-cells", 1);
> +    qemu_fdt_setprop_cell(fdt, iommu_node, "phandle", iommu_phandle);
> +    qemu_fdt_setprop_cells(fdt, iommu_node, "reg",
> +                           bdf << 8, 0, 0, 0, 0);
> +    qemu_fdt_setprop_cells(fdt, pci_node, "iommu-map",
> +                           0, iommu_phandle, 0, bdf,
> +                           bdf + 1, iommu_phandle, bdf + 1, 0xffff - bdf);
> +}

Is it really necessary to add this iommu-pci device in riscv virt machine, 
rather than other 'physical' machine type? virt machine already has its 
virtio-iommu.

> +
>   static void finalize_fdt(RISCVVirtState *s)
>   {
>       uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
> @@ -1712,9 +1737,11 @@ static HotplugHandler *virt_machine_get_hotplug_handler(MachineState *machine,
>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>   
>       if (device_is_dynamic_sysbus(mc, dev) ||
> -        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
> +        object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI) ||
> +        object_dynamic_cast(OBJECT(dev), TYPE_RISCV_IOMMU_PCI)) {
>           return HOTPLUG_HANDLER(machine);
>       }
> +
>       return NULL;
>   }
>   
> @@ -1735,6 +1762,10 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>       if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
>           create_fdt_virtio_iommu(s, pci_get_bdf(PCI_DEVICE(dev)));
>       }
> +
> +    if (object_dynamic_cast(OBJECT(dev), TYPE_RISCV_IOMMU_PCI)) {
> +        create_fdt_iommu(s, pci_get_bdf(PCI_DEVICE(dev)));
> +    }
>   }
>   
>   static void virt_machine_class_init(ObjectClass *oc, void *data)


