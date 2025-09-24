Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF759CAC5AE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 07:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Jpy-0002R7-J9; Wed, 24 Sep 2025 03:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1v1Jpp-0002FZ-CX
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:22:43 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1v1Jpj-0003uM-Ji
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 03:22:40 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxLvAwnNNoWfoNAA--.30006S3;
 Wed, 24 Sep 2025 15:22:24 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJAxE+QvnNNotdCqAA--.20412S3;
 Wed, 24 Sep 2025 15:22:23 +0800 (CST)
Subject: Re: [PATCH 2/3] hw/loongarch/virt: Align VIRT_GED_CPUHP_ADDR to 4
 bytes
To: Huacai Chen <chenhuacai@kernel.org>, Song Gao <gaosong@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, WANG Xuerui <git@xen0n.name>,
 qemu-devel@nongnu.org, Huacai Chen <chenhuacai@loongson.cn>,
 Nathan Chancellor <nathan@kernel.org>, WANG Rui <wangrui@loongson.cn>
References: <20250923143542.2391576-1-chenhuacai@kernel.org>
 <20250923143542.2391576-3-chenhuacai@kernel.org>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <42001195-f7ad-4348-046d-78ede6d33c46@loongson.cn>
Date: Wed, 24 Sep 2025 15:20:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250923143542.2391576-3-chenhuacai@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxE+QvnNNotdCqAA--.20412S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar48ZF4Dury5Zr1ruF48AFc_yoW8uw4rp3
 Z7Aa1vgF1UJF1xCay0qFy3WF47Xrn7GrsFkFW7K34Sy3Wvkw18uF10kwn8CrWDtan3WF4I
 vF4qkayIgas8JwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU70PfDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.829,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 2025/9/23 下午10:35, Huacai Chen wrote:
> From: Huacai Chen <chenhuacai@loongson.cn>
> 
> Now VIRT_GED_CPUHP_ADDR is not aligned to 4 bytes, but if Linux kernel
> is built with ACPI_MISALIGNMENT_NOT_SUPPORTED, it assumes the alignment,
> otherwise we get ACPI errors at boot phase:
> 
> ACPI Error: AE_AML_ALIGNMENT, Returned by Handler for [SystemMemory] (20250404/evregion-301)
> ACPI Error: Aborting method \_SB.CPUS.CSTA due to previous error (AE_AML_ALIGNMENT) (20250404/psparse-529)
> ACPI Error: Aborting method \_SB.CPUS.C000._STA due to previous error (AE_AML_ALIGNMENT) (20250404/psparse-529)
> ACPI Error: Method execution failed \_SB.CPUS.C000._STA due to previous error (AE_AML_ALIGNMENT) (20250404/uteval-68)
> 
> VIRT_GED_MEM_ADDR and VIRT_GED_REG_ADDR are already aligned now, but use
> QEMU_ALIGN_UP() to explicitly align them can make code more robust.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Suggested-by: WANG Rui <wangrui@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>   include/hw/loongarch/virt.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
> index 602feab0f0..be4f5d603f 100644
> --- a/include/hw/loongarch/virt.h
> +++ b/include/hw/loongarch/virt.h
> @@ -28,9 +28,9 @@
>   #define VIRT_LOWMEM_SIZE        0x10000000
>   #define VIRT_HIGHMEM_BASE       0x80000000
>   #define VIRT_GED_EVT_ADDR       0x100e0000
> -#define VIRT_GED_MEM_ADDR       (VIRT_GED_EVT_ADDR + ACPI_GED_EVT_SEL_LEN)
> -#define VIRT_GED_REG_ADDR       (VIRT_GED_MEM_ADDR + MEMORY_HOTPLUG_IO_LEN)
> -#define VIRT_GED_CPUHP_ADDR     (VIRT_GED_REG_ADDR + ACPI_GED_REG_COUNT)
> +#define VIRT_GED_MEM_ADDR       QEMU_ALIGN_UP(VIRT_GED_EVT_ADDR + ACPI_GED_EVT_SEL_LEN, 4)
> +#define VIRT_GED_REG_ADDR       QEMU_ALIGN_UP(VIRT_GED_MEM_ADDR + MEMORY_HOTPLUG_IO_LEN, 4)
> +#define VIRT_GED_CPUHP_ADDR     QEMU_ALIGN_UP(VIRT_GED_REG_ADDR + ACPI_GED_REG_COUNT, 4)
>   
>   #define COMMAND_LINE_SIZE       512
>   
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


