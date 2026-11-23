Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90457606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 07:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVOXF-0000lU-9w; Mon, 23 Nov 2026 02:32:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xVOX8-0000lD-Vz
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 02:32:15 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xVOX6-0005N7-QV
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 02:32:14 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Bx79L56wNruCYiAA--.32346S3;
 Mon, 23 Nov 2026 15:32:10 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front2 (Coremail) with SMTP id qciowJDxfX_26wNrv3YNAA--.136S2;
 Mon, 23 Nov 2026 15:32:08 +0800 (CST)
Subject: Re: [PATCH v6 08/26] target/loongarch: add LVZ guest timer
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1794558695.git.prcups@krgm.moe>
 <868343e68bee1b4fb7cfa7c82cce76cab4bf4806.1794558695.git.prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <e3d6451b-9905-c227-2e6b-feeeee7e153f@loongson.cn>
Date: Mon, 23 Nov 2026 15:33:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <868343e68bee1b4fb7cfa7c82cce76cab4bf4806.1794558695.git.prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qciowJDxfX_26wNrv3YNAA--.136S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxArW3Wry7Gw1DZFWfZw4fJFc_yoW5Gw1fpr
 ZruF13try8JFZrtas7Xws8uFn8Wr17Gr129a13K34IkFsrJr1Y9F1kt39FvFsrX3yrGr4I
 qF4rZF15WFW7XFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jY
 38nUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.724,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 2026/11/13 下午4:45, SignKirigami wrote:
> Add a separate guest timer and IRQ_VTIMER. To use cpu_has_ptw(), timer init should
> be after loongarch_la464_initfn() when CPUCFG is set.
> 
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> ---
>   target/loongarch/cpu.c | 16 ++++++++++++++--
>   target/loongarch/cpu.h |  6 ++++++
>   2 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 20209c1bfc..3a351e43cc 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -738,10 +738,14 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
>       CPULoongArchState *env = cpu_env(cs);
>   
>   #ifdef CONFIG_TCG
> -    CPUTimerState *timer;
> +    CPUTimerState *timer, *guest_timer;
>   #endif
>   
> -    env->irq_nr = N_IRQS;
> +    if (cpu_has_lvz(env)) {
> +        env->irq_nr = N_VIRQS;
> +    } else {
> +        env->irq_nr = N_IRQS;
> +    }
>       qdev_init_gpio_in(dev, loongarch_cpu_set_irq, env->irq_nr);
>   #ifdef CONFIG_TCG
>       timer = env_timer(env);
> @@ -749,6 +753,14 @@ static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
>       timer->cs  = cs;
>       timer_init_ns(&timer->timer, QEMU_CLOCK_VIRTUAL,
>                     &cpu_loongarch_timer_cb, timer);
> +
> +    if (cpu_has_lvz(env)) {
> +        guest_timer = env_guest_timer(env);
> +        guest_timer->irq = IRQ_VTIMER;
> +        guest_timer->cs = cs;
> +        timer_init_ns(&guest_timer->timer, QEMU_CLOCK_VIRTUAL,
> +            &cpu_loongarch_timer_cb, guest_timer);
> +    }
>   #endif
>   
>       cpu_common_realize(cs, &local_err);
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 22f2b0aa47..c1a59882f7 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -245,6 +245,7 @@ extern const char * const fregnames[32];
>   #define IRQ_IPI     12
>   #define INT_DMSI    14
>   #define N_VIRQS     (N_IRQS * 2)
> +#define IRQ_VTIMER  (N_IRQS + IRQ_TIMER)
>   
>   #define MAX_PERF_EVENTS        16
>   #define LOONGARCH_STLB         2048 /* 2048 STLB */
> @@ -582,6 +583,11 @@ static inline CPUTimerState *env_timer(CPULoongArchState *env)
>       return &env->sys_states[0].timer_state;
>   }
>   
> +static inline CPUTimerState *env_guest_timer(CPULoongArchState *env)
> +{
> +    return &env->sys_states[1].timer_state;
> +}
> +
I think env_timer()/env_guest_timer() can use one one API:
     CPUTimerState *env_timer(CPULoongArchState *env, int vm_level)

Regards
Bibo Mao
>   static inline bool is_la64(CPULoongArchState *env)
>   {
>       return FIELD_EX32(env->cpucfg[1], CPUCFG1, ARCH) == CPUCFG1_ARCH_LA64;
> 


