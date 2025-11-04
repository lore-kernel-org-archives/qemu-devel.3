Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1712CCCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 12:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGGZl-00053W-Hg; Tue, 04 Nov 2025 07:55:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vGGZi-00053G-V5
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 07:55:51 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1vGGZh-0003tU-9d
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 07:55:50 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7c53a8d1e42so4394960a34.0
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 04:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1762260947; x=1762865747; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1B4aL6lmDAS1Q4KBKTEZjTi3iqC833O0hT7WUDB03bc=;
 b=SVE9fc2PYRotp9bsUnBxNjJij0FRqlbnXJfHEcPbcFMn1P13ci8qOLyrvKaUC5gm36
 vMdu4snORfKGQSvU5BuWLTsz7cXnpy3nYrqb2/hGeic6zlMaZ3tN0T6TEIqgUARRnrGG
 lN7dPG0GFATlgU3XqmaEUnkqoxL+T2n+1L8oqXELlUkmFwVVRER4f4faT7bWBRpxX+W4
 Hl6KrdtK+r7VKm/kQc07dkLzzuYlcmFG4b9NRiA1sVhcmMNPBgofz2VJ4UWe9kW1sR2F
 CiQQTPLeQwCh/YPmXYNzjW3m6aHVxtbnSX8LxamPVw/I3vkkGg5/qxdhBkQ2MrHYkM/P
 BbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762260947; x=1762865747;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1B4aL6lmDAS1Q4KBKTEZjTi3iqC833O0hT7WUDB03bc=;
 b=ZXXAZddMnK6SneXkvzbdLwfDp4n6u3SyOApRPojU1tS94SI5cZutUOalnoIgQP0eSK
 0ztLmxeLTs5mUQGhYl8QdbloWqBMxptsBNyFo4eNqqBUTxpSkIX+R6Z18MkgtNg8t3YC
 08AjLv6ZHtA+9z1bWLDy/9nRkVwK7wwoWU+In8Bhe6D4Fk+jhuaXnAoNVlWzorgiFr0x
 VGmxy7SDxOkg0L0VAHaqoOQ7Ziq7sQSFO/Cv2zLtsQ1948hFuX+15mEvTrevMX91Iybf
 f/XcGPb7TOzYbyYYS/64/A9RAjESHSrLJiVhzy+Ck5ItOGXBue8khiMFF4fcoFxHNYv5
 x1Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeV60DeXYve+co7F1mqh7ty+pxpxZc0FT3ayBnFRdHPKAqLZ3Hb7LuXCE6TzFYc41WNNgJEfcBsYUQ@nongnu.org
X-Gm-Message-State: AOJu0YxNFVfqzaOuiQLmKyw447aExXx8LPKRL8UpJkTZ62uDCGUHGst6
 v1TabD6semXDCATMHGI97tdS7dmxo80xUGWqgLkbCV9RFEmV1CpS9X6CoQ+Z/tm4Mjw=
X-Gm-Gg: ASbGncvUcwX3gSBtcViRMgKV6HFeWM5CsSXsNBQklx7x/AWxhosL1i3MjPwgx1Q3G3N
 Pbl+8i4MwOTBVwQicNGgV9g1A7yZjnCoI355P4chPD6hP9//Q5/3qwU2hov/qtRLsp9T8WHxeRu
 zAlhv60UT0qrAvJFL0zc2Q9DKEFpP9RYBnrp8PoxgHgYsTl/suJ+t/+eJC0FjggbfTtaqcaZhM/
 wFLgL7L58BR18xWM/J9z9DJWvNwYd/cT6bT0z797O+Ohk5DcFm3MtqeIH5uRrjlq+Ihrgqr6LGD
 nGVxeIkiAnGYCkTXeUVZd/wuweVcNbf3gewkk22mAkz2T46uNsD69K6XdHYTXAUfdpJBwpVS0kX
 q+CKOy816GCcwYQ/PpI+PXBRy+U0trhpnFZL8uDmRT0ouBN0rNmaVZ5QDL8/PuhMN3FIB+1w9OZ
 c99RWE8tB5Y7Cj+5lNBvm5tKo=
X-Google-Smtp-Source: AGHT+IF233HHzX/K9Z7CJlxn4TRSkM2HGWcF9lCUerVSygtAut12j/M00IgFO5dlx/Cb/0N1A7F9VA==
X-Received: by 2002:a9d:768b:0:b0:7c2:91cd:2776 with SMTP id
 46e09a7af769-7c6c5c528camr1113254a34.17.1762260947259; 
 Tue, 04 Nov 2025 04:55:47 -0800 (PST)
Received: from [192.168.68.110] ([179.93.21.233])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6c2448b20sm1008660a34.1.2025.11.04.04.55.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 04:55:45 -0800 (PST)
Message-ID: <4e825697-e57c-4f77-8920-9f18b787e425@ventanamicro.com>
Date: Tue, 4 Nov 2025 09:55:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 1/1] hw/riscv/server_platform_ref.c: add virtio bus
To: Chao Liu <chao.liu.riscv@isrc.iscas.ac.cn>, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 Andrew Jones <ajones@ventanamicro.com>
References: <cover.1762172539.git.chao.liu.riscv@isrc.iscas.ac.cn>
 <38a180e7ed4014ba7d401dc9b8de755fadf33bea.1762172539.git.chao.liu.riscv@isrc.iscas.ac.cn>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <38a180e7ed4014ba7d401dc9b8de755fadf33bea.1762172539.git.chao.liu.riscv@isrc.iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32b.google.com
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

CCing Drew since he's the TG chair for this spec

On 11/3/25 9:39 AM, Chao Liu wrote:
> Add an always present virtio bus for the rvsp-ref board.
> 
> The IRQs being used are similar to what the 'virt' board is using: IRQs
> 40 to 47, one IRQ for queue.
> 
> Signed-off-by: Chao Liu <chao.liu.riscv@isrc.iscas.ac.cn>
> ---
>   hw/riscv/server_platform_ref.c | 42 ++++++++++++++++++++++++++++++++--
>   1 file changed, 40 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/riscv/server_platform_ref.c b/hw/riscv/server_platform_ref.c
> index 975f07ddfb..24c3fc2e41 100644
> --- a/hw/riscv/server_platform_ref.c
> +++ b/hw/riscv/server_platform_ref.c
> @@ -46,6 +46,7 @@
>   #include "target/riscv/cpu.h"
>   #include "target/riscv/pmu.h"
>   #include "net/net.h"
> +#include "hw/virtio/virtio-mmio.h"
>   
>   #define RVSP_CPUS_MAX_BITS             9
>   #define RVSP_CPUS_MAX                  (1 << RVSP_CPUS_MAX_BITS)
> @@ -108,16 +109,20 @@ enum {
>       RVSP_PCIE_MMIO,
>       RVSP_PCIE_PIO,
>       RVSP_PCIE_ECAM,
> -    RVSP_PCIE_MMIO_HIGH
> +    RVSP_PCIE_MMIO_HIGH,
> +    RVSP_VIRTIO
>   };
>   
>   enum {
>       RVSP_UART0_IRQ = 10,
>       RVSP_RTC_IRQ = 11,
>       RVSP_PCIE_IRQ = 0x20, /* 32 to 35 */
> -    IOMMU_SYS_IRQ = 0x24 /* 36 to 39 */
> +    IOMMU_SYS_IRQ = 0x24, /* 36 to 39 */
> +    RVSP_VIRTIO_IRQ = 0x28 /* 40 to 47 */
>   };
>   
> +#define RVSP_VIRTIO_COUNT 8
> +
>   /*
>    * The server soc reference machine physical address space used by some of the
>    * devices namely ACLINT, APLIC and IMSIC depend on number of Sockets, number
> @@ -151,6 +156,7 @@ static const MemMapEntry rvsp_ref_memmap[] = {
>       [RVSP_APLIC_M] =        {  0xc000000, APLIC_SIZE(RVSP_CPUS_MAX) },
>       [RVSP_APLIC_S] =        {  0xd000000, APLIC_SIZE(RVSP_CPUS_MAX) },
>       [RVSP_UART0] =          { 0x10000000,         0x100 },
> +    [RVSP_VIRTIO] =         { 0x10001000,        0x1000 },
>       [RVSP_FLASH] =          { 0x20000000,     0x4000000 },
>       [RVSP_IMSIC_M] =        { 0x24000000, RVSP_IMSIC_MAX_SIZE },
>       [RVSP_IMSIC_S] =        { 0x28000000, RVSP_IMSIC_MAX_SIZE },
> @@ -816,6 +822,29 @@ static void create_fdt_flash(RVSPMachineState *s, const MemMapEntry *memmap)
>       qemu_fdt_setprop_cell(ms->fdt, name, "bank-width", 4);
>   }
>   
> +static void create_fdt_virtio(RVSPMachineState *s, uint32_t irq_virtio_phandle)
> +{
> +    int i;
> +    MachineState *ms = MACHINE(s);
> +    hwaddr virtio_base = rvsp_ref_memmap[RVSP_VIRTIO].base;
> +
> +    for (i = 0; i < RVSP_VIRTIO_COUNT; i++) {
> +        g_autofree char *name = NULL;
> +        uint64_t size = rvsp_ref_memmap[RVSP_VIRTIO].size;
> +        hwaddr addr = virtio_base + i * size;
> +
> +        name = g_strdup_printf("/soc/virtio_mmio@%"HWADDR_PRIx, addr);
> +
> +        qemu_fdt_add_subnode(ms->fdt, name);
> +        qemu_fdt_setprop_string(ms->fdt, name, "compatible", "virtio,mmio");
> +        qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg", 2, addr, 2, size);
> +        qemu_fdt_setprop_cell(ms->fdt, name, "interrupt-parent",
> +            irq_virtio_phandle);
> +        qemu_fdt_setprop_cells(ms->fdt, name, "interrupts",
> +                            RVSP_VIRTIO_IRQ + i, 0x4);
> +    }
> +}
> +
>   static void finalize_fdt(RVSPMachineState *s)
>   {
>       uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
> @@ -835,6 +864,8 @@ static void finalize_fdt(RVSPMachineState *s)
>       create_fdt_uart(s, rvsp_ref_memmap, irq_mmio_phandle);
>   
>       create_fdt_rtc(s, rvsp_ref_memmap, irq_mmio_phandle);
> +
> +    create_fdt_virtio(s, irq_mmio_phandle);
>   }
>   
>   static void create_fdt(RVSPMachineState *s, const MemMapEntry *memmap)
> @@ -1205,6 +1236,13 @@ static void rvsp_ref_machine_init(MachineState *machine)
>           }
>       }
>   
> +    /* VirtIO MMIO devices */
> +    for (i = 0; i < RVSP_VIRTIO_COUNT; i++) {
> +        sysbus_create_simple("virtio-mmio",
> +            memmap[RVSP_VIRTIO].base + i * memmap[RVSP_VIRTIO].size,
> +            qdev_get_gpio_in(mmio_irqchip, RVSP_VIRTIO_IRQ + i));
> +    }
> +

When you said virtio support I thought about virtio-pci and virtio-net-pci. I'm not sure if
we need a virtio-mmio for that.

Also, I can't say if adding a device like virtio-mmio might conflict with something else from
the server plat specification. Drew, care to comment?



Daniel



>       s->memmap = rvsp_ref_memmap;
>   
>       /* register system main memory (actual RAM) */


