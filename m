Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFEF5CD4F4C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 01:24:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snT7h-0000W5-GU; Sun, 08 Sep 2024 21:23:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1snT7d-0000VG-Qf
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 21:23:17 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1snT7b-0004z0-4O
 for qemu-devel@nongnu.org; Sun, 08 Sep 2024 21:23:17 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Dxlej0Td5mbFsCAA--.4393S3;
 Mon, 09 Sep 2024 09:23:00 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front2 (Coremail) with SMTP id qciowMAxU+TxTd5mlhkCAA--.9681S3;
 Mon, 09 Sep 2024 09:22:59 +0800 (CST)
Subject: Re: [PATCH v3] hw/loongarch: virt: support up to 4 serial ports
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com, qemu-devel@nongnu.org, thomas@t-8ch.de,
 xry111@xry111.site
References: <20240906143146.2553953-1-Jason@zx2c4.com>
 <20240907143439.2792924-1-Jason@zx2c4.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <8af05876-53cc-cf74-1ebf-ba29dd154862@loongson.cn>
Date: Mon, 9 Sep 2024 09:22:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240907143439.2792924-1-Jason@zx2c4.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qciowMAxU+TxTd5mlhkCAA--.9681S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3JrWDJw43GrW3Zw15Cr1ktFc_yoWxXFWkpF
 WDCFnavr4UWr13WrySv3W5WF47Jrs7Cay29w47GrW0kFykWr1IqrW0k39xtryUA395JFWY
 vFyqq3sF93W2qrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.046,
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



On 2024/9/7 下午10:34, Jason A. Donenfeld wrote:
> In order to support additional channels of communication using
> `-serial`, add several serial ports, up to the standard 4 generally
> supported by the 8250 driver.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>   hw/loongarch/acpi-build.c  | 23 +++++++++++++++--------
>   hw/loongarch/virt.c        | 23 +++++++++++++----------
>   include/hw/pci-host/ls7a.h |  9 +++++----
>   3 files changed, 33 insertions(+), 22 deletions(-)
> 
> diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
> index 3912c8d307..459d2b5f84 100644
> --- a/hw/loongarch/acpi-build.c
> +++ b/hw/loongarch/acpi-build.c
> @@ -31,6 +31,7 @@
>   
>   #include "hw/acpi/generic_event_device.h"
>   #include "hw/pci-host/gpex.h"
> +#include "sysemu/sysemu.h"
>   #include "sysemu/tpm.h"
>   #include "hw/platform-bus.h"
>   #include "hw/acpi/aml-build.h"
> @@ -290,23 +291,27 @@ struct AcpiBuildState {
>       MemoryRegion *linker_mr;
>   } AcpiBuildState;
>   
> -static void build_uart_device_aml(Aml *table)
> +static void build_uart_device_aml(Aml *table, int index)
>   {
>       Aml *dev;
>       Aml *crs;
>       Aml *pkg0, *pkg1, *pkg2;
> -    uint32_t uart_irq = VIRT_UART_IRQ;
> -
> -    Aml *scope = aml_scope("_SB");
> -    dev = aml_device("COMA");
> +    Aml *scope;
> +    uint32_t uart_irq;
> +    uint64_t base;
> +
> +    uart_irq = VIRT_UART_IRQ + index;
> +    base = VIRT_UART_BASE + index * VIRT_UART_SIZE;
> +    scope = aml_scope("_SB");
> +    dev = aml_device("COM%d", index);
>       aml_append(dev, aml_name_decl("_HID", aml_string("PNP0501")));
> -    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
> +    aml_append(dev, aml_name_decl("_UID", aml_int(index)));
>       aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
>       crs = aml_resource_template();
>       aml_append(crs,
>           aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
>                            AML_NON_CACHEABLE, AML_READ_WRITE,
> -                         0, VIRT_UART_BASE, VIRT_UART_BASE + VIRT_UART_SIZE - 1,
> +                         0, base, base + VIRT_UART_SIZE - 1,
>                            0, VIRT_UART_SIZE));
>       aml_append(crs, aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
>                                     AML_SHARED, &uart_irq, 1));
> @@ -439,6 +444,7 @@ static void acpi_dsdt_add_tpm(Aml *scope, LoongArchVirtMachineState *vms)
>   static void
>   build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>   {
> +    int i;
>       Aml *dsdt, *scope, *pkg;
>       LoongArchVirtMachineState *lvms = LOONGARCH_VIRT_MACHINE(machine);
>       AcpiTable table = { .sig = "DSDT", .rev = 1, .oem_id = lvms->oem_id,
> @@ -446,7 +452,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>   
>       acpi_table_begin(&table, table_data);
>       dsdt = init_aml_allocator();
> -    build_uart_device_aml(dsdt);
> +    for (i = VIRT_UART_COUNT; i --> 0;)
> +        build_uart_device_aml(dsdt, i);
>       build_pci_device_aml(dsdt, lvms);
>       build_la_ged_aml(dsdt, machine);
>       build_flash_aml(dsdt, lvms);
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 4151fc5e0c..b9bd88d3f4 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -319,10 +319,10 @@ static void fdt_add_ged_reset(LoongArchVirtMachineState *lvms)
>   }
>   
>   static void fdt_add_uart_node(LoongArchVirtMachineState *lvms,
> -                              uint32_t *pch_pic_phandle)
> +                              uint32_t *pch_pic_phandle, hwaddr base,
> +                              int irq, bool chosen)
>   {
>       char *nodename;
> -    hwaddr base = VIRT_UART_BASE;
>       hwaddr size = VIRT_UART_SIZE;
>       MachineState *ms = MACHINE(lvms);
>   
> @@ -331,9 +331,9 @@ static void fdt_add_uart_node(LoongArchVirtMachineState *lvms,
>       qemu_fdt_setprop_string(ms->fdt, nodename, "compatible", "ns16550a");
>       qemu_fdt_setprop_cells(ms->fdt, nodename, "reg", 0x0, base, 0x0, size);
>       qemu_fdt_setprop_cell(ms->fdt, nodename, "clock-frequency", 100000000);
> -    qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
> -    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
> -                           VIRT_UART_IRQ - VIRT_GSI_BASE, 0x4);
> +    if (chosen)
> +        qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
> +    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts", irq, 0x4);
>       qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
>                             *pch_pic_phandle);
>       g_free(nodename);
> @@ -750,11 +750,14 @@ static void virt_devices_init(DeviceState *pch_pic,
>       /* Add pcie node */
>       fdt_add_pcie_node(lvms, pch_pic_phandle, pch_msi_phandle);
>   
> -    serial_mm_init(get_system_memory(), VIRT_UART_BASE, 0,
> -                   qdev_get_gpio_in(pch_pic,
> -                                    VIRT_UART_IRQ - VIRT_GSI_BASE),
> -                   115200, serial_hd(0), DEVICE_LITTLE_ENDIAN);
> -    fdt_add_uart_node(lvms, pch_pic_phandle);
> +    for (i = VIRT_UART_COUNT; i --> 0;) {
> +        hwaddr base = VIRT_UART_BASE + i * VIRT_UART_SIZE;
> +        int irq = VIRT_UART_IRQ + i - VIRT_GSI_BASE;
> +        serial_mm_init(get_system_memory(), base, 0,
> +                       qdev_get_gpio_in(pch_pic, irq),
> +                       115200, serial_hd(i), DEVICE_LITTLE_ENDIAN);
> +        fdt_add_uart_node(lvms, pch_pic_phandle, base, irq, i == 0);
> +    }
>   
>       /* Network init */
>       pci_init_nic_devices(pci_bus, mc->default_nic);
> diff --git a/include/hw/pci-host/ls7a.h b/include/hw/pci-host/ls7a.h
> index cd7c9ec7bc..79d4ea8501 100644
> --- a/include/hw/pci-host/ls7a.h
> +++ b/include/hw/pci-host/ls7a.h
> @@ -36,17 +36,18 @@
>   #define VIRT_PCH_PIC_IRQ_NUM     32
>   #define VIRT_GSI_BASE            64
>   #define VIRT_DEVICE_IRQS         16
> +#define VIRT_UART_COUNT          4
>   #define VIRT_UART_IRQ            (VIRT_GSI_BASE + 2)
>   #define VIRT_UART_BASE           0x1fe001e0
> -#define VIRT_UART_SIZE           0X100
> -#define VIRT_RTC_IRQ             (VIRT_GSI_BASE + 3)
> +#define VIRT_UART_SIZE           0x100
> +#define VIRT_RTC_IRQ             (VIRT_GSI_BASE + 6)
>   #define VIRT_MISC_REG_BASE       (VIRT_PCH_REG_BASE + 0x00080000)
>   #define VIRT_RTC_REG_BASE        (VIRT_MISC_REG_BASE + 0x00050100)
>   #define VIRT_RTC_LEN             0x100
> -#define VIRT_SCI_IRQ             (VIRT_GSI_BASE + 4)
> +#define VIRT_SCI_IRQ             (VIRT_GSI_BASE + 7)
>   
>   #define VIRT_PLATFORM_BUS_BASEADDRESS   0x16000000
>   #define VIRT_PLATFORM_BUS_SIZE          0x2000000
>   #define VIRT_PLATFORM_BUS_NUM_IRQS      2
> -#define VIRT_PLATFORM_BUS_IRQ           (VIRT_GSI_BASE + 5)
> +#define VIRT_PLATFORM_BUS_IRQ           (VIRT_GSI_BASE + 8)
>   #endif
> 
Tested-by: Bibo Mao <maobibo@loongson.cn>


