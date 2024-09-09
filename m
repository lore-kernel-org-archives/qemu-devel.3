Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B66D7ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 12:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sndt1-0007RB-9k; Mon, 09 Sep 2024 08:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sndsy-0007Q7-JW
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 08:52:52 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sndsw-0002XR-04
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 08:52:52 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Cxyumb795m59QCAA--.6475S3;
 Mon, 09 Sep 2024 20:52:44 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front2 (Coremail) with SMTP id qciowMBxe8aY795meoMCAA--.11615S3;
 Mon, 09 Sep 2024 20:52:40 +0800 (CST)
Subject: Re: [PATCH] hw/loongarch: Add acpi SPCR table support
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 "Jason A . Donenfeld" <Jason@zx2c4.com>
References: <20240907073037.243353-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <08e4eacd-bc37-13a7-e5db-a41168f02af0@loongson.cn>
Date: Mon, 9 Sep 2024 20:53:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240907073037.243353-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qciowMBxe8aY795meoMCAA--.11615S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJw1DWryDKrWUGF4kCF4rJFc_yoW5XryUpF
 W8GF98tr4aqryfJ3ZxJF1jvF1rJr48Gayaqwn7t3yvgan0gryvqr4xt39Iya4DAw1kJrWx
 ZF1qyryI9a18AwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1Ek
 sDUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-3.396, SPF_HELO_NONE=0.001,
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

ÔÚ 2024/9/7 ÏÂÎç3:30, Bibo Mao Ð´µÀ:
> Serial port console redirection table can be used for default serial
> port selection, like chosen stdout-path selection with FDT method.
>
> With acpi SPCR table added, early debug console can be parsed from
> SPCR table with simple kernel parameter earlycon rather than
> earlycon=uart,mmio,0x1fe001e0
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/loongarch/acpi-build.c | 40 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 40 insertions(+)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks
Song Gao
> diff --git a/hw/loongarch/acpi-build.c b/hw/loongarch/acpi-build.c
> index 2638f87434..3912c8d307 100644
> --- a/hw/loongarch/acpi-build.c
> +++ b/hw/loongarch/acpi-build.c
> @@ -241,6 +241,44 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
>       acpi_table_end(linker, &table);
>   }
>   
> +/*
> + * Serial Port Console Redirection Table (SPCR)
> + * https://learn.microsoft.com/en-us/windows-hardware/drivers/serports/serial-port-console-redirection-table
> + */
> +static void
> +spcr_setup(GArray *table_data, BIOSLinker *linker, MachineState *machine)
> +{
> +    LoongArchVirtMachineState *lvms;
> +    AcpiSpcrData serial = {
> +        .interface_type = 0,       /* 16550 compatible */
> +        .base_addr.id = AML_AS_SYSTEM_MEMORY,
> +        .base_addr.width = 32,
> +        .base_addr.offset = 0,
> +        .base_addr.size = 1,
> +        .base_addr.addr = VIRT_UART_BASE,
> +        .interrupt_type = 0,       /* Interrupt not supported */
> +        .pc_interrupt = 0,
> +        .interrupt = VIRT_UART_IRQ,
> +        .baud_rate = 7,            /* 115200 */
> +        .parity = 0,
> +        .stop_bits = 1,
> +        .flow_control = 0,
> +        .terminal_type = 3,        /* ANSI */
> +        .language = 0,             /* Language */
> +        .pci_device_id = 0xffff,   /* not a PCI device*/
> +        .pci_vendor_id = 0xffff,   /* not a PCI device*/
> +        .pci_bus = 0,
> +        .pci_device = 0,
> +        .pci_function = 0,
> +        .pci_flags = 0,
> +        .pci_segment = 0,
> +    };
> +
> +    lvms = LOONGARCH_VIRT_MACHINE(machine);
> +    build_spcr(table_data, linker, &serial, 2, lvms->oem_id,
> +               lvms->oem_table_id);
> +}
> +
>   typedef
>   struct AcpiBuildState {
>       /* Copy of table in RAM (for patching). */
> @@ -477,6 +515,8 @@ static void acpi_build(AcpiBuildTables *tables, MachineState *machine)
>   
>       acpi_add_table(table_offsets, tables_blob);
>       build_srat(tables_blob, tables->linker, machine);
> +    acpi_add_table(table_offsets, tables_blob);
> +    spcr_setup(tables_blob, tables->linker, machine);
>   
>       if (machine->numa_state->num_nodes) {
>           if (machine->numa_state->have_numa_distance) {
>
> base-commit: 7b87a25f49a301d3377f3e71e0b4a62540c6f6e4


