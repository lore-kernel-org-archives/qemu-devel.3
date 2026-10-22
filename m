Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A79C606A31B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 03:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJjO0-000341-Gz; Wed, 21 Oct 2026 23:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1xJjNw-00033i-Rs
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 23:22:33 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1xJjNt-0008St-H4
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 23:22:32 -0400
Received: from loongson.cn (unknown [10.20.42.166])
 by gateway (Coremail) with SMTP id _____8BxrtJpgdlqCUYYAA--.5482S3;
 Thu, 22 Oct 2026 11:22:18 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJCxf89mgdlqUA0vAA--.34869S2;
 Thu, 22 Oct 2026 11:22:16 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Add dynamic irq_nr field
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <17746591750@163.com>
Cc: qemu-devel@nongnu.org
References: <20261012075234.2323986-1-maobibo@loongson.cn>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <426273f0-baeb-3cc2-6337-04999b195360@loongson.cn>
Date: Thu, 22 Oct 2026 11:20:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261012075234.2323986-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJCxf89mgdlqUA0vAA--.34869S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr13JrW3Xr1xGw4xAF1kWFX_yoW8CrW7pr
 ZruF42gF48JFWqv3s7CayF9ryDXr47Gr129a13tryxCrZ8Jrs0g3WktwsFgF4DXa4rWF4I
 vF1ru3W5XF47XacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL05UU
 UUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.689,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed-by:  Xianglai Li <lixianglai@loongson.cn>

> By default, the number of IRQs on the CPU side is N_IRQS. It will become
> N_IRQS * 2 if LVZ is enabled in the future. This patch adds a
> CPUArchState::irq_nr field to record the supported IRQ count.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu.c | 8 +++++---
>   target/loongarch/cpu.h | 1 +
>   2 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 54c2699897..9cf566f0f6 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -88,8 +88,9 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
>   {
>       LoongArchCPU *cpu = opaque;
>       CPUState *cs = CPU(cpu);
> +    CPULoongArchState *env = &cpu->env;
>   
> -    if (irq < 0 || irq >= N_IRQS) {
> +    if (irq < 0 || irq >= env->irq_nr) {
>           return;
>       }
>   
> @@ -724,12 +725,13 @@ static void loongarch_cpu_init(Object *obj)
>   {
>   #ifndef CONFIG_USER_ONLY
>       LoongArchCPU *cpu = LOONGARCH_CPU(obj);
> -#ifdef CONFIG_TCG
>       CPULoongArchState *env = &cpu->env;
> +#ifdef CONFIG_TCG
>       CPUTimerState *timer;
>   #endif
>   
> -    qdev_init_gpio_in(DEVICE(cpu), loongarch_cpu_set_irq, N_IRQS);
> +    env->irq_nr = N_IRQS;
> +    qdev_init_gpio_in(DEVICE(cpu), loongarch_cpu_set_irq, env->irq_nr);
>   #ifdef CONFIG_TCG
>       timer = env_timer(env);
>       timer->irq = IRQ_TIMER;
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index c592f69885..77ea8f03f9 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -437,6 +437,7 @@ typedef struct CPUArchState {
>       uint32_t mp_state;
>   #endif
>       CPUSysState *sys_state;
> +    unsigned int irq_nr;
>   } CPULoongArchState;
>   
>   typedef struct LoongArchCPUTopo {
>
> base-commit: 615ece3c406b262996e569f29ea6eed0d81c4d8d


