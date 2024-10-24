Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B33BCE8E6D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 12:42:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3x9N-0001on-Qr; Thu, 24 Oct 2024 08:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1t3x9B-0001nd-OT; Thu, 24 Oct 2024 08:41:01 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>)
 id 1t3x97-0000z5-JW; Thu, 24 Oct 2024 08:41:00 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Axjq9QQBpn08AKAA--.1119S3;
 Thu, 24 Oct 2024 20:40:48 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMAx7uBKQBpnLJgPAA--.20295S3;
 Thu, 24 Oct 2024 20:40:45 +0800 (CST)
Subject: Re: [PATCH v5 2/3] hw/acpi: Upgrade ACPI SPCR table to support SPCR
 table revision 4 format
To: Sia Jee Heng <jeeheng.sia@starfivetech.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 sunilvl@ventanamicro.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com
References: <20240829015920.95778-1-jeeheng.sia@starfivetech.com>
 <20240829015920.95778-3-jeeheng.sia@starfivetech.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <449f736a-dadf-cb6e-9564-8622d6d5bcb3@loongson.cn>
Date: Thu, 24 Oct 2024 20:40:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240829015920.95778-3-jeeheng.sia@starfivetech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAx7uBKQBpnLJgPAA--.20295S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3XrWfCw47XFWxGrWDWw17Arc_yoW7tF4DpF
 4qv3y3tr9xXryfZ3ZIyrnFkF1rWr4kGa4jk3y09r18Jay2g340yF15Ka1aka4ayw1kGF95
 CF12qF48Wa1xZFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8zw
 Z7UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.5,
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



On 2024/8/29 上午9:59, Sia Jee Heng wrote:
> Update the SPCR table to accommodate the SPCR Table revision 4 [1].
> The SPCR table has been modified to adhere to the revision 4 format [2].
> 
> [1]: https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
> [2]: https://github.com/acpica/acpica/pull/931
> 
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   hw/acpi/aml-build.c         | 20 ++++++++++++++++----
>   hw/arm/virt-acpi-build.c    |  8 ++++++--
>   hw/riscv/virt-acpi-build.c  | 12 +++++++++---
>   include/hw/acpi/acpi-defs.h |  7 +++++--
>   include/hw/acpi/aml-build.h |  2 +-
>   5 files changed, 37 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 6d4517cfbe..99a1b403e2 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -1996,7 +1996,7 @@ static void build_processor_hierarchy_node(GArray *tbl, uint32_t flags,
>   
>   void build_spcr(GArray *table_data, BIOSLinker *linker,
>                   const AcpiSpcrData *f, const uint8_t rev,
> -                const char *oem_id, const char *oem_table_id)
> +                const char *oem_id, const char *oem_table_id, const char *name)

Sorry for late response. LoongArch virt-machine uses function 
build_spcr() also. Maybe there need small modification on it.

Regards
Bibo Mao
>   {
>       AcpiTable table = { .sig = "SPCR", .rev = rev, .oem_id = oem_id,
>                           .oem_table_id = oem_table_id };
> @@ -2042,9 +2042,21 @@ void build_spcr(GArray *table_data, BIOSLinker *linker,
>       build_append_int_noprefix(table_data, f->pci_flags, 4);
>       /* PCI Segment */
>       build_append_int_noprefix(table_data, f->pci_segment, 1);
> -    /* Reserved */
> -    build_append_int_noprefix(table_data, 0, 4);
> -
> +    if (rev < 4) {
> +        /* Reserved */
> +        build_append_int_noprefix(table_data, 0, 4);
> +    } else {
> +        /* UartClkFreq */
> +        build_append_int_noprefix(table_data, f->uart_clk_freq, 4);
> +        /* PreciseBaudrate */
> +        build_append_int_noprefix(table_data, f->precise_baudrate, 4);
> +        /* NameSpaceStringLength */
> +        build_append_int_noprefix(table_data, f->namespace_string_length, 2);
> +        /* NameSpaceStringOffset */
> +        build_append_int_noprefix(table_data, f->namespace_string_offset, 2);
> +        /* NamespaceString[] */
> +        g_array_append_vals(table_data, name, f->namespace_string_length);
> +    }
>       acpi_table_end(linker, &table);
>   }
>   /*
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index f76fb117ad..0b6f5f8d8d 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -464,8 +464,12 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
>           .pci_flags = 0,
>           .pci_segment = 0,
>       };
> -
> -    build_spcr(table_data, linker, &serial, 2, vms->oem_id, vms->oem_table_id);
> +    /*
> +     * Passing NULL as the SPCR Table for Revision 2 doesn't support
> +     * NameSpaceString.
> +     */
> +    build_spcr(table_data, linker, &serial, 2, vms->oem_id, vms->oem_table_id,
> +               NULL);
>   }
>   
>   /*
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 36d6a3a412..68ef15acac 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -200,14 +200,15 @@ acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
>   
>   /*
>    * Serial Port Console Redirection Table (SPCR)
> - * Rev: 1.07
> + * Rev: 1.10
>    */
>   
>   static void
>   spcr_setup(GArray *table_data, BIOSLinker *linker, RISCVVirtState *s)
>   {
> +    const char name[] = ".";
>       AcpiSpcrData serial = {
> -        .interface_type = 0,       /* 16550 compatible */
> +        .interface_type = 0x12,       /* 16550 compatible */
>           .base_addr.id = AML_AS_SYSTEM_MEMORY,
>           .base_addr.width = 32,
>           .base_addr.offset = 0,
> @@ -229,9 +230,14 @@ spcr_setup(GArray *table_data, BIOSLinker *linker, RISCVVirtState *s)
>           .pci_function = 0,
>           .pci_flags = 0,
>           .pci_segment = 0,
> +        .uart_clk_freq = 0,
> +        .precise_baudrate = 0,
> +        .namespace_string_length = sizeof(name),
> +        .namespace_string_offset = 88,
>       };
>   
> -    build_spcr(table_data, linker, &serial, 2, s->oem_id, s->oem_table_id);
> +    build_spcr(table_data, linker, &serial, 4, s->oem_id, s->oem_table_id,
> +               name);
>   }
>   
>   /* RHCT Node[N] starts at offset 56 */
> diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
> index 0e6e82b339..2e6e341998 100644
> --- a/include/hw/acpi/acpi-defs.h
> +++ b/include/hw/acpi/acpi-defs.h
> @@ -112,7 +112,6 @@ typedef struct AcpiSpcrData {
>       uint8_t flow_control;
>       uint8_t terminal_type;
>       uint8_t language;
> -    uint8_t reserved1;
>       uint16_t pci_device_id;    /* Must be 0xffff if not PCI device */
>       uint16_t pci_vendor_id;    /* Must be 0xffff if not PCI device */
>       uint8_t pci_bus;
> @@ -120,7 +119,11 @@ typedef struct AcpiSpcrData {
>       uint8_t pci_function;
>       uint32_t pci_flags;
>       uint8_t pci_segment;
> -    uint32_t reserved2;
> +    uint32_t uart_clk_freq;
> +    uint32_t precise_baudrate;
> +    uint32_t namespace_string_length;
> +    uint32_t namespace_string_offset;
> +    char namespace_string[];
>   } AcpiSpcrData;
>   
>   #define ACPI_FADT_ARM_PSCI_COMPLIANT  (1 << 0)
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index a3784155cb..68c0f2dbee 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -500,5 +500,5 @@ void build_tpm2(GArray *table_data, BIOSLinker *linker, GArray *tcpalog,
>   
>   void build_spcr(GArray *table_data, BIOSLinker *linker,
>                   const AcpiSpcrData *f, const uint8_t rev,
> -                const char *oem_id, const char *oem_table_id);
> +                const char *oem_id, const char *oem_table_id, const char *name);
>   #endif
> 


