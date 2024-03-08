Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73979C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 08:44:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riVpt-0008UQ-8I; Fri, 08 Mar 2024 03:44:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1riVpr-0008UE-GG
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:44:11 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1riVpo-0005V3-Oi
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 03:44:11 -0500
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8Dx6ujVz+plqzoWAA--.35093S3;
 Fri, 08 Mar 2024 16:44:05 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Ax3c7Sz+pl4i1RAA--.18858S3; 
 Fri, 08 Mar 2024 16:44:04 +0800 (CST)
Subject: Re: [PATCH v6 14/17] hw/loongarch: fdt adds pcie irq_map node
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240307164835.300412-1-gaosong@loongson.cn>
 <20240307164835.300412-15-gaosong@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <b5f219b3-304a-47bf-278a-023f6bd57dc5@loongson.cn>
Date: Fri, 8 Mar 2024 16:44:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240307164835.300412-15-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Ax3c7Sz+pl4i1RAA--.18858S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCF48uF1UtFykXF4DGF47Jrc_yoWruF4xpF
 WUuF9xtr47JF1xWFZav34jvFnxAr1xuryj9r12kr4IkF98Wr97trW8G3y2yF48G3y8Wa4F
 qFs0qFWIg3WxJ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07j8
 CztUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.08,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 2024/3/8 上午12:48, Song Gao wrote:
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> Message-Id: <20240301093839.663947-15-gaosong@loongson.cn>
> ---
>   hw/loongarch/virt.c | 73 ++++++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 69 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 1e767c49f8..d00343f0c2 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -352,7 +352,62 @@ static void fdt_add_fw_cfg_node(const LoongArchMachineState *lams)
>       g_free(nodename);
>   }
>   
> -static void fdt_add_pcie_node(const LoongArchMachineState *lams)
> +static void fdt_add_pcie_irq_map_node(const LoongArchMachineState *lams,
> +                                      char *nodename,
> +                                      uint32_t *pch_pic_phandle)
> +{
> +    int pin, dev;
> +    uint32_t irq_map_stride = 0;
> +    uint32_t full_irq_map[GPEX_NUM_IRQS *GPEX_NUM_IRQS * 10] = {};
> +    uint32_t *irq_map = full_irq_map;
> +    const MachineState *ms = MACHINE(lams);
> +
> +    /* This code creates a standard swizzle of interrupts such that
> +     * each device's first interrupt is based on it's PCI_SLOT number.
> +     * (See pci_swizzle_map_irq_fn())
> +     *
> +     * We only need one entry per interrupt in the table (not one per
> +     * possible slot) seeing the interrupt-map-mask will allow the table
> +     * to wrap to any number of devices.
> +     */
> +
> +    for (dev = 0; dev < GPEX_NUM_IRQS; dev++) {
> +        int devfn = dev * 0x8;
> +
> +        for (pin = 0; pin  < GPEX_NUM_IRQS; pin++) {
> +            int irq_nr = 16 + ((pin + PCI_SLOT(devfn)) % GPEX_NUM_IRQS);
> +            int i = 0;
> +
> +            /* Fill PCI address cells */
> +            irq_map[i] = cpu_to_be32(devfn << 8);
> +            i += 3;
> +
> +            /* Fill PCI Interrupt cells */
> +            irq_map[i] = cpu_to_be32(pin + 1);
> +            i += 1;
> +
> +            /* Fill interrupt controller phandle and cells */
> +            irq_map[i++] = cpu_to_be32(*pch_pic_phandle);
> +            irq_map[i++] = cpu_to_be32(irq_nr);
> +
> +            if (!irq_map_stride) {
> +                irq_map_stride = i;
> +            }
> +            irq_map += irq_map_stride;
> +        }
> +    }
> +
> +
> +    qemu_fdt_setprop(ms->fdt, nodename, "interrupt-map", full_irq_map,
> +                     GPEX_NUM_IRQS * GPEX_NUM_IRQS *
> +                     irq_map_stride * sizeof(uint32_t));
> +    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupt-map-mask",
> +                     0x1800, 0, 0, 0x7);
> +}
> +
> +static void fdt_add_pcie_node(const LoongArchMachineState *lams,
> +                              uint32_t *pch_pic_phandle,
> +                              uint32_t *pch_msi_phandle)
>   {
>       char *nodename;
>       hwaddr base_mmio = VIRT_PCI_MEM_BASE;
> @@ -383,6 +438,11 @@ static void fdt_add_pcie_node(const LoongArchMachineState *lams)
>                                    2, base_pio, 2, size_pio,
>                                    1, FDT_PCI_RANGE_MMIO, 2, base_mmio,
>                                    2, base_mmio, 2, size_mmio);
> +    qemu_fdt_setprop_cells(ms->fdt, nodename, "msi-map",
> +                           0, *pch_msi_phandle, 0, 0x10000);
> +
> +    fdt_add_pcie_irq_map_node(lams, nodename, pch_pic_phandle);
> +
>       g_free(nodename);
>   }
>   
> @@ -541,7 +601,10 @@ static DeviceState *create_platform_bus(DeviceState *pch_pic)
>       return dev;
>   }
>   
> -static void loongarch_devices_init(DeviceState *pch_pic, LoongArchMachineState *lams)
> +static void loongarch_devices_init(DeviceState *pch_pic,
> +                                   LoongArchMachineState *lams,
> +                                   uint32_t *pch_pic_phandle,
> +                                   uint32_t *pch_msi_phandle)
>   {
>       MachineClass *mc = MACHINE_GET_CLASS(lams);
>       DeviceState *gpex_dev;
> @@ -587,6 +650,9 @@ static void loongarch_devices_init(DeviceState *pch_pic, LoongArchMachineState *
>           gpex_set_irq_num(GPEX_HOST(gpex_dev), i, 16 + i);
>       }
>   
> +    /* Add pcie node */
> +    fdt_add_pcie_node(lams, pch_pic_phandle, pch_msi_phandle);
> +
>       serial_mm_init(get_system_memory(), VIRT_UART_BASE, 0,
>                      qdev_get_gpio_in(pch_pic,
>                                       VIRT_UART_IRQ - VIRT_GSI_BASE),
> @@ -733,7 +799,7 @@ static void loongarch_irq_init(LoongArchMachineState *lams)
>       /* Add PCH MSI node */
>       fdt_add_pch_msi_node(lams, &eiointc_phandle, &pch_msi_phandle);
>   
> -    loongarch_devices_init(pch_pic, lams);
> +    loongarch_devices_init(pch_pic, lams, &pch_pic_phandle, &pch_msi_phandle);
>   }
>   
>   static void loongarch_firmware_init(LoongArchMachineState *lams)
> @@ -956,7 +1022,6 @@ static void loongarch_init(MachineState *machine)
>       lams->powerdown_notifier.notify = virt_powerdown_req;
>       qemu_register_powerdown_notifier(&lams->powerdown_notifier);
>   
> -    fdt_add_pcie_node(lams);
>       /*
>        * Since lowmem region starts from 0 and Linux kernel legacy start address
>        * at 2 MiB, FDT base address is located at 1 MiB to avoid NULL pointer
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


