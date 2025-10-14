Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A30CCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 08:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8alv-0004iQ-46; Tue, 14 Oct 2025 04:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1v8als-0004iE-P3
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 04:52:40 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1v8alp-000719-KJ
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 04:52:40 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxndJRD+5o1vEVAA--.46500S3;
 Tue, 14 Oct 2025 16:52:33 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJBxysBND+5oXkjhAA--.16304S3;
 Tue, 14 Oct 2025 16:52:33 +0800 (CST)
Subject: Re: [PATCH 2/2] hw/loongarch/virt: Sort order by hardware device base
 address
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20251013063516.688936-1-maobibo@loongson.cn>
 <20251013063516.688936-3-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <9fd8157c-23c3-15c4-7730-2d7031c2d278@loongson.cn>
Date: Tue, 14 Oct 2025 16:52:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20251013063516.688936-3-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJBxysBND+5oXkjhAA--.16304S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCry5uF1UXFy5Gr4fCFy3Awc_yoWrWFy3pF
 yavF90gr48Ja17Gw1vg3Z8Xr17JwsrCFyj9r47W3y8Aan8Ww18uryjqwsIqrWUZrZ5GryI
 qryktw129a4DWwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7XTmDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-2.658, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

ÔÚ 2025/10/13 ÏÂÎç2:35, Bibo Mao Ð´µÀ:
> With header file include/hw/loongarch/virt.h, hardware device definition
> order is sorted by its base address. Add remove unused macro
> VIRT_IOAPIC_REG_BASE and VIRT_MISC_REG_BASE.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/loongarch/virt.c         |  2 +-
>   include/hw/loongarch/virt.h | 42 +++++++++++++++++--------------------
>   2 files changed, 20 insertions(+), 24 deletions(-)
Signed-off-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index efd1f9ac49..49434ad182 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -520,7 +520,7 @@ static void virt_irq_init(LoongArchVirtMachineState *lvms)
>           }
>   
>           /* PCH_PIC memory region */
> -        memory_region_add_subregion(get_system_memory(), VIRT_IOAPIC_REG_BASE,
> +        memory_region_add_subregion(get_system_memory(), VIRT_PCH_REG_BASE,
>                       sysbus_mmio_get_region(SYS_BUS_DEVICE(pch_pic), 0));
>   
>           /* Connect pch_pic irqs to extioi */
> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
> index 0cc1b499a7..27b1755802 100644
> --- a/include/hw/loongarch/virt.h
> +++ b/include/hw/loongarch/virt.h
> @@ -13,50 +13,47 @@
>   #include "hw/block/flash.h"
>   #include "hw/loongarch/boot.h"
>   
> -#define IOCSRF_TEMP             0
> -#define IOCSRF_NODECNT          1
> -#define IOCSRF_MSI              2
> -#define IOCSRF_EXTIOI           3
> -#define IOCSRF_CSRIPI           4
> -#define IOCSRF_FREQCSR          5
> -#define IOCSRF_FREQSCALE        6
> -#define IOCSRF_DVFSV1           7
> -#define IOCSRF_GMOD             9
> -#define IOCSRF_VM               11
> -#define IOCSRF_DMSI             15
> -
>   /* IOCSR region */
>   #define VERSION_REG             0x0
>   #define FEATURE_REG             0x8
> +#define  IOCSRF_TEMP             0
> +#define  IOCSRF_NODECNT          1
> +#define  IOCSRF_MSI              2
> +#define  IOCSRF_EXTIOI           3
> +#define  IOCSRF_CSRIPI           4
> +#define  IOCSRF_FREQCSR          5
> +#define  IOCSRF_FREQSCALE        6
> +#define  IOCSRF_DVFSV1           7
> +#define  IOCSRF_GMOD             9
> +#define  IOCSRF_VM               11
> +#define  IOCSRF_DMSI             15
>   #define VENDOR_REG              0x10
>   #define CPUNAME_REG             0x20
>   #define MISC_FUNC_REG           0x420
> -#define IOCSRM_EXTIOI_EN        48
> -#define IOCSRM_EXTIOI_INT_ENCODE 49
> -#define IOCSRM_DMSI_EN          51
> +#define  IOCSRM_EXTIOI_EN         48
> +#define  IOCSRM_EXTIOI_INT_ENCODE 49
> +#define  IOCSRM_DMSI_EN           51
>   
>   #define LOONGARCH_MAX_CPUS      256
>   
>   /* MMIO memory region */
>   #define VIRT_PCH_REG_BASE       0x10000000UL
>   #define VIRT_PCH_REG_SIZE       0x400
> -#define VIRT_IOAPIC_REG_BASE    (VIRT_PCH_REG_BASE)
> -#define VIRT_MISC_REG_BASE      (VIRT_PCH_REG_BASE + 0x00080000)
> -#define VIRT_RTC_REG_BASE       (VIRT_MISC_REG_BASE + 0x00050100)
> +#define VIRT_RTC_REG_BASE       0x100d0100UL
>   #define VIRT_RTC_LEN            0x100
>   #define VIRT_PLATFORM_BUS_BASEADDRESS   0x16000000UL
>   #define VIRT_PLATFORM_BUS_SIZE          0x02000000
>   #define VIRT_PCI_IO_BASE        0x18004000UL
>   #define VIRT_PCI_IO_OFFSET      0x4000
>   #define VIRT_PCI_IO_SIZE        0xC000
> -#define VIRT_FWCFG_BASE         0x1e020000UL
>   #define VIRT_BIOS_BASE          0x1c000000UL
> -#define VIRT_BIOS_SIZE          (16 * MiB)
> +#define VIRT_BIOS_SIZE          0x01000000UL
>   #define VIRT_FLASH_SECTOR_SIZE  (256 * KiB)
>   #define VIRT_FLASH0_BASE        VIRT_BIOS_BASE
>   #define VIRT_FLASH0_SIZE        VIRT_BIOS_SIZE
>   #define VIRT_FLASH1_BASE        0x1d000000UL
> -#define VIRT_FLASH1_SIZE        (16 * MiB)
> +#define VIRT_FLASH1_SIZE        0x01000000UL
> +#define VIRT_FWCFG_BASE         0x1e020000UL
>   #define VIRT_UART_BASE          0x1fe001e0UL
>   #define VIRT_UART_SIZE          0x100
>   #define VIRT_PCI_CFG_BASE       0x20000000UL
> @@ -70,6 +67,7 @@
>   
>   #define VIRT_LOWMEM_BASE        0
>   #define VIRT_LOWMEM_SIZE        0x10000000
> +#define FDT_BASE                0x100000
>   #define VIRT_HIGHMEM_BASE       0x80000000
>   #define VIRT_GED_EVT_ADDR       0x100e0000
>   #define VIRT_GED_MEM_ADDR       QEMU_ALIGN_UP(VIRT_GED_EVT_ADDR + ACPI_GED_EVT_SEL_LEN, 4)
> @@ -94,8 +92,6 @@
>   
>   #define COMMAND_LINE_SIZE       512
>   
> -#define FDT_BASE                0x100000
> -
>   struct LoongArchVirtMachineState {
>       /*< private >*/
>       MachineState parent_obj;


