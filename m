Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BA3CAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 01:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwVtC-0005Tt-PQ; Wed, 10 Sep 2025 21:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uwVtB-0005Ta-6h
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 21:14:17 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uwVt9-0004c1-AZ
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 21:14:16 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxndJkIsJoEAkJAA--.18978S3;
 Thu, 11 Sep 2025 09:14:12 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJBxpeRkIsJosQWNAA--.55164S3;
 Thu, 11 Sep 2025 09:14:12 +0800 (CST)
Subject: Re: [PATCH v7 08/11] hw/loongarch: Implement avec set irq
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250910091150.2424979-1-gaosong@loongson.cn>
 <20250910091150.2424979-9-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <4fc9fc1d-9659-e25a-c5b7-8c9884cb1835@loongson.cn>
Date: Thu, 11 Sep 2025 09:12:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250910091150.2424979-9-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxpeRkIsJosQWNAA--.55164S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr47WFy3GF48tw43ur4ftFc_yoW8ZFW3pa
 s7AF98WF4UtF47Zas3G345Z3Z8Jr4Igr12qFsIkr92kr17Wr18Xry8J3srZF40k395u34j
 vr1rCa15WF1UJrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2nYFDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.551,
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



On 2025/9/10 下午5:11, Song Gao wrote:
> Implement avec set irq and update CSR_MSGIS.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/intc/loongarch_avec.c | 32 ++++++++++++++++++++++++++++++--
>   1 file changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/intc/loongarch_avec.c b/hw/intc/loongarch_avec.c
> index 1f9f376898..0c90579de2 100644
> --- a/hw/intc/loongarch_avec.c
> +++ b/hw/intc/loongarch_avec.c
> @@ -16,6 +16,14 @@
>   #include "migration/vmstate.h"
>   #include "trace.h"
>   #include "hw/qdev-properties.h"
> +#include "target/loongarch/cpu.h"
> +#include "qemu/error-report.h"
> +#include "system/hw_accel.h"
> +
> +/* msg addr field */
> +FIELD(MSG_ADDR, IRQ_NUM, 4, 8)
> +FIELD(MSG_ADDR, CPU_NUM, 12, 8)
> +FIELD(MSG_ADDR, FIX, 28, 12)
>   
>   static uint64_t loongarch_avec_mem_read(void *opaque,
>                                           hwaddr addr, unsigned size)
> @@ -23,13 +31,33 @@ static uint64_t loongarch_avec_mem_read(void *opaque,
>       return 0;
>   }
>   
> +static void do_set_vcpu_avec_irq(CPUState *cs, run_on_cpu_data data)
> +{
> +    int irq = data.host_int;
> +    CPULoongArchState *env;
> +
> +    env = &LOONGARCH_CPU(cs)->env;
> +    cpu_synchronize_state(cs);
> +    set_bit(irq, env->CSR_MSGIS);
> +}
> +
>   static void loongarch_avec_mem_write(void *opaque, hwaddr addr,
>                                        uint64_t val, unsigned size)
>   {
> -    return;
> +    int irq_num, cpu_num = 0;
> +    LoongArchAVECState *s = LOONGARCH_AVEC(opaque);
> +    uint64_t msg_addr = addr + VIRT_AVEC_BASE;
> +    CPUState *cs;
> +
> +    cpu_num = FIELD_EX64(msg_addr, MSG_ADDR, CPU_NUM);
> +    cs = cpu_by_arch_id(cpu_num);
> +    irq_num = FIELD_EX64(msg_addr, MSG_ADDR, IRQ_NUM);
> +
> +    async_run_on_cpu(cs, do_set_vcpu_avec_irq,
> +                         RUN_ON_CPU_HOST_INT(irq_num));
> +    qemu_set_irq(s->cpu[cpu_num].parent_irq, 1);
>   }
>   
> -
>   static const MemoryRegionOps loongarch_avec_ops = {
>       .read = loongarch_avec_mem_read,
>       .write = loongarch_avec_mem_write,
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


