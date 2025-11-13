Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA880CD4F30
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 01:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJM1T-000396-CE; Wed, 12 Nov 2025 20:21:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1vJM1A-0002ZK-Qu
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 20:20:56 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1vJM17-0006Tl-Gl
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 20:20:56 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxaNFpMhVpzawiAA--.10052S3;
 Thu, 13 Nov 2025 09:20:41 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxQ+RnMhVpMhUxAQ--.14748S3;
 Thu, 13 Nov 2025 09:20:41 +0800 (CST)
Subject: Re: [PATCH V2 1/2] Modify the interrupt trigger type in loongarch
 virt fdt to macro definition
To: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, Song Gao <gaosong@loongson.cn>
References: <cover.1762917185.git.lixianglai@loongson.cn>
 <56832788ca15ee896e4e7bd2a635e65e188d75c2.1762917185.git.lixianglai@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <1910ee77-f492-63f7-af62-c711e055cdb2@loongson.cn>
Date: Thu, 13 Nov 2025 09:18:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <56832788ca15ee896e4e7bd2a635e65e188d75c2.1762917185.git.lixianglai@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxQ+RnMhVpMhUxAQ--.14748S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF47Zry3JrW7Cry3Zw4DJrc_yoW8uF4fpF
 W7Aa1DXr4DJr9xG39xua4Y9w1fAr1rGr1jgFnrur40kryDWw1fXr40k39rtF17u34rJ3WF
 vFsYgr9xWa42qrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU25EfUUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.736,
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



On 2025/11/12 上午11:26, Xianglai Li wrote:
> In the loongarch virt fdt file, the interrupt trigger type directly
> uses magic numbers. Now, refer to the definitions in the linux kernel and
> use macro definitions.
> 
> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> ---
> Cc: Bibo Mao <maobibo@loongson.cn>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: Song Gao <gaosong@loongson.cn>
> 
>   hw/loongarch/virt-fdt-build.c | 11 +++++++++--
>   1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/loongarch/virt-fdt-build.c b/hw/loongarch/virt-fdt-build.c
> index 1f0ba01f71..7333019cf7 100644
> --- a/hw/loongarch/virt-fdt-build.c
> +++ b/hw/loongarch/virt-fdt-build.c
> @@ -16,6 +16,11 @@
>   #include "system/reset.h"
>   #include "target/loongarch/cpu.h"
>   
> +#define FDT_IRQ_TYPE_EDGE_RISING  1
> +#define FDT_IRQ_TYPE_EDGE_FALLING 2
> +#define FDT_IRQ_TYPE_LEVEL_HIGH   4
> +#define FDT_IRQ_TYPE_LEVEL_LOW    8
> +
>   static void create_fdt(LoongArchVirtMachineState *lvms)
>   {
>       MachineState *ms = MACHINE(lvms);
> @@ -415,7 +420,8 @@ static void fdt_add_uart_node(LoongArchVirtMachineState *lvms,
>       if (chosen) {
>           qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", nodename);
>       }
> -    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts", irq, 0x4);
> +    qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts", irq,
> +                           FDT_IRQ_TYPE_LEVEL_HIGH);
>       qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
>                             *pch_pic_phandle);
>       g_free(nodename);
> @@ -435,7 +441,8 @@ static void fdt_add_rtc_node(LoongArchVirtMachineState *lvms,
>                               "loongson,ls7a-rtc");
>       qemu_fdt_setprop_sized_cells(ms->fdt, nodename, "reg", 2, base, 2, size);
>       qemu_fdt_setprop_cells(ms->fdt, nodename, "interrupts",
> -                           VIRT_RTC_IRQ - VIRT_GSI_BASE , 0x4);
> +                           VIRT_RTC_IRQ - VIRT_GSI_BASE ,
> +                           FDT_IRQ_TYPE_LEVEL_HIGH);
>       qemu_fdt_setprop_cell(ms->fdt, nodename, "interrupt-parent",
>                             *pch_pic_phandle);
>       g_free(nodename);
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


