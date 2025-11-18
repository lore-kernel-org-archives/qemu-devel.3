Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6361CEBF61
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 01:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLAww-0005Pd-Ca; Mon, 17 Nov 2025 20:56:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vLAwo-0005PC-H2
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 20:55:59 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vLAwk-0007ux-JH
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 20:55:57 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxK9Ij0htpOL0kAA--.11427S3;
 Tue, 18 Nov 2025 09:55:47 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxrcEg0htpz7g2AQ--.60648S3;
 Tue, 18 Nov 2025 09:55:46 +0800 (CST)
Subject: Re: [PATCH V3 2/2] fix pci device can't alloc irq from fdt
To: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>
References: <cover.1763347485.git.lixianglai@loongson.cn>
 <894d7a034593e5ccd53b7f3695569c05cd2620e0.1763347485.git.lixianglai@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <4e77e390-6c09-96f7-4732-b2601e69c5fb@loongson.cn>
Date: Tue, 18 Nov 2025 09:53:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <894d7a034593e5ccd53b7f3695569c05cd2620e0.1763347485.git.lixianglai@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxrcEg0htpz7g2AQ--.60648S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxZF1kGF4rXr4DWrWfCr47Jrc_yoWrKF1rpr
 WDC3ZIgrWIqr1I939xA3WUWF15Kr1fCFyUJwnxXr10kwnxuw1xXr4DK3y7tFy7K3ykJayU
 XFnIgayIg3WUJagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j8yCJU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.064,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2025/11/17 下午3:14, Xianglai Li wrote:
> When we use the -kernel parameter to start an elf format kernel relying on
> fdt, we get the following error:
> 
> pcieport 0000:00:01.0: of_irq_parse_pci: failed with rc=-22
> pcieport 0000:00:01.0: enabling device (0000 -> 0003)
> pcieport 0000:00:01.0: PME: Signaling with IRQ 19
> pcieport 0000:00:01.0: AER: enabled with IRQ 19
> pcieport 0000:00:01.1: of_irq_parse_pci: failed with rc=-22
> pcieport 0000:00:01.1: enabling device (0000 -> 0003)
> pcieport 0000:00:01.1: PME: Signaling with IRQ 20
> pcieport 0000:00:01.1: AER: enabled with IRQ 20
> pcieport 0000:00:01.2: of_irq_parse_pci: failed with rc=-22
> pcieport 0000:00:01.2: enabling device (0000 -> 0003)
> pcieport 0000:00:01.2: PME: Signaling with IRQ 21
> pcieport 0000:00:01.2: AER: enabled with IRQ 21
> pcieport 0000:00:01.3: of_irq_parse_pci: failed with rc=-22
> pcieport 0000:00:01.3: enabling device (0000 -> 0003)
> pcieport 0000:00:01.3: PME: Signaling with IRQ 22
> pcieport 0000:00:01.3: AER: enabled with IRQ 22
> pcieport 0000:00:01.4: of_irq_parse_pci: failed with rc=-22
> 
> This is because  the description of interrupt-cell is missing in the pcie
> irq map.  And there is a lack of a description of the interrupt trigger
> type.  Now it is corrected and the correct interrupt-cell is added in the
> pcie irq map.
> 
> Refer to the implementation in arm and add some comments.
> 
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> ---
> Cc: Bibo Mao <maobibo@loongson.cn>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: Song Gao <gaosong@loongson.cn>
> 
>   hw/loongarch/virt-fdt-build.c | 44 ++++++++++++++++++++++-------------
>   1 file changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/hw/loongarch/virt-fdt-build.c b/hw/loongarch/virt-fdt-build.c
> index 7333019cf7..52082b2483 100644
> --- a/hw/loongarch/virt-fdt-build.c
> +++ b/hw/loongarch/virt-fdt-build.c
> @@ -321,6 +321,8 @@ static void fdt_add_pcie_irq_map_node(const LoongArchVirtMachineState *lvms,
>       uint32_t full_irq_map[PCI_NUM_PINS * PCI_NUM_PINS * 10] = {};
>       uint32_t *irq_map = full_irq_map;
>       const MachineState *ms = MACHINE(lvms);
> +    uint32_t pin_mask;
> +    uint32_t devfn_mask;
>   
>       /*
>        * This code creates a standard swizzle of interrupts such that
> @@ -333,37 +335,45 @@ static void fdt_add_pcie_irq_map_node(const LoongArchVirtMachineState *lvms,
>        */
>   
>       for (dev = 0; dev < PCI_NUM_PINS; dev++) {
> -        int devfn = dev * 0x8;
> +        int devfn = PCI_DEVFN(dev, 0);
>   
>           for (pin = 0; pin < PCI_NUM_PINS; pin++) {
> -            int irq_nr = 16 + ((pin + PCI_SLOT(devfn)) % PCI_NUM_PINS);
> +            int irq_nr = VIRT_DEVICE_IRQS + \
> +                         ((pin + PCI_SLOT(devfn)) % PCI_NUM_PINS);
>               int i = 0;
>   
> -            /* Fill PCI address cells */
> -            irq_map[i] = cpu_to_be32(devfn << 8);
> -            i += 3;
> -
> -            /* Fill PCI Interrupt cells */
> -            irq_map[i] = cpu_to_be32(pin + 1);
> -            i += 1;
> -
> -            /* Fill interrupt controller phandle and cells */
> -            irq_map[i++] = cpu_to_be32(*pch_pic_phandle);
> -            irq_map[i++] = cpu_to_be32(irq_nr);
> +            uint32_t map[] = {
> +                cpu_to_be16(devfn), 0, 0,     /* devfn */
here it seems that it should be devfn << 8 rather than cpu_to_be16(devfn).

Otherwise look good to me.

Reviewed-by: Bibo Mao <maobibo@loongson.cn>
> +                pin + 1,                      /* PCI pin */
> +                *pch_pic_phandle,             /* interrupt controller handle */
> +                irq_nr,                       /* irq number */
> +                FDT_IRQ_TYPE_LEVEL_HIGH };    /* irq trigger level */
>   
>               if (!irq_map_stride) {
> -                irq_map_stride = i;
> +                irq_map_stride = sizeof(map) / sizeof(uint32_t);
>               }
> +
> +            /* Convert map to big endian */
> +            for (i = 0; i < irq_map_stride; i++) {
> +                irq_map[i] = cpu_to_be32(map[i]);
> +            }
> +
>               irq_map += irq_map_stride;
>           }
>       }
>   
> -
>       qemu_fdt_setprop(ms->fdt, nodename, "interrupt-map", full_irq_map,
>                        PCI_NUM_PINS * PCI_NUM_PINS *
>                        irq_map_stride * sizeof(uint32_t));
> +
> +    /* The pci slot only needs to specify the matching of the lower bit */
> +    devfn_mask = cpu_to_be16(PCI_DEVFN((PCI_NUM_PINS - 1), 0));
> +    /* The pci interrupt only needs to match the specified low bit */
> +    pin_mask = (1 << ((PCI_NUM_PINS - 1))) - 1;
> +
>       qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupt-map-mask",
> -                     0x1800, 0, 0, 0x7);
> +                           devfn_mask, 0, 0,  /* address cells */
> +                           pin_mask);
>   }
>   
>   static void fdt_add_pcie_node(const LoongArchVirtMachineState *lvms,
> @@ -400,6 +410,8 @@ static void fdt_add_pcie_node(const LoongArchVirtMachineState *lvms,
>                                    2, base_mmio, 2, size_mmio);
>       qemu_fdt_setprop_cells(ms->fdt, nodename, "msi-map",
>                              0, *pch_msi_phandle, 0, 0x10000);
> +
> +    qemu_fdt_setprop_cell(ms->fdt, nodename, "#interrupt-cells", 1);
>       fdt_add_pcie_irq_map_node(lvms, nodename, pch_pic_phandle);
>       g_free(nodename);
>   }
> 


