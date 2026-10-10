Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C9FCA6004
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 04:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFOI1-0006B6-W7; Sat, 10 Oct 2026 00:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xFOHv-0006At-BU
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 00:02:23 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xFOHs-0002vi-CH
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 00:02:23 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxntLGuMlqpmEUAA--.59287S3;
 Sat, 10 Oct 2026 12:02:14 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJAx3c7CuMlqE7sqAA--.24909S2;
 Sat, 10 Oct 2026 12:02:10 +0800 (CST)
Subject: Re: [PATCH v5 07/23] target/loongarch: add LVZ guest interrupt state
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1791514848.git.prcups@krgm.moe>
 <9fefcc4b677adbcbc4860bec1793a15337eedb31.1791514848.git.prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <359b5fa8-9f8c-f580-a456-e8b5ea7bc027@loongson.cn>
Date: Sat, 10 Oct 2026 12:03:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9fefcc4b677adbcbc4860bec1793a15337eedb31.1791514848.git.prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAx3c7CuMlqE7sqAA--.24909S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Ww17ArW7ArWkCrW5ZFWrJFc_yoW3uFykpr
 W7uFyagr48KrWDJ3s5ta4YkFn8Zr1xWw129ana9ryfCr4DXr18Xr1kt39rWFn8C348Wr1j
 qF1rZ3WDuay7XFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8PC
 zJUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.591,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2026/10/9 上午11:05, SignKirigami wrote:
> Route configured hardware interrupts into the guest CSR bank, track guest
> interrupt requests separately, and expose guest pending and enable checks
> to the TCG runtime.
> 
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> ---
>   target/loongarch/cpu.c            | 35 +++++++++++++++++++--------
>   target/loongarch/cpu.h            |  3 +++
>   target/loongarch/internals.h      |  4 ++--
>   target/loongarch/tcg/csr_helper.c |  2 +-
>   target/loongarch/tcg/tcg_cpu.c    | 39 ++++++++++++++++++++++---------
>   5 files changed, 59 insertions(+), 24 deletions(-)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index 664763137d..5cef63a778 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -58,16 +58,20 @@ static vaddr loongarch_cpu_get_pc(CPUState *cs)
>   #ifndef CONFIG_USER_ONLY
>   #include "hw/loongarch/virt.h"
>   
> -void loongarch_cpu_update_irq(LoongArchCPU *cpu)
> +void loongarch_cpu_update_irq(LoongArchCPU *cpu, int vm_level)
>   {
>       CPULoongArchState *env = &cpu->env;
>       CPUState *cs = CPU(cpu);
> -    CPUSysState *sys = env_sys(env);
> +    CPUSysState *sys = get_sys(env, vm_level);
> +    int interrupt = vm_level ? CPU_INTERRUPT_GUEST : CPU_INTERRUPT_HARD;
>   
> +    if (vm_level == VM_LEVEL1 && env_vm_level(env) != VM_LEVEL1) {
> +        return;
> +    }
>       if (FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS)) {
> -        cpu_interrupt(cs, CPU_INTERRUPT_HARD);
> +        cpu_interrupt(cs, interrupt);
>       } else {
> -        cpu_reset_interrupt(cs, CPU_INTERRUPT_HARD);
> +        cpu_reset_interrupt(cs, interrupt);
>       }
>   }
>   
> @@ -75,21 +79,28 @@ static void loongarch_cpu_self_set_irq(CPUState *cs, run_on_cpu_data data)
>   {
>       LoongArchCPU *cpu = LOONGARCH_CPU(cs);
>       CPULoongArchState *env = cpu_env(cs);
> -    CPUSysState *sys = env_sys(env);
> +    CPUSysState *sys;
> +    int vm_level = 0;
>       int irq, level;
>   
>       irq = data.host_int & ~BIT(31);
>       level = (data.host_int >> 31) & 1;
> +    if (irq >= N_IRQS) {
> +        irq -= N_IRQS;
> +        vm_level = 1;
> +    }
> +    sys = get_sys(env, vm_level);
>       sys->CSR_ESTAT = deposit64(sys->CSR_ESTAT, irq, 1, level != 0);
> -    loongarch_cpu_update_irq(cpu);
> +    loongarch_cpu_update_irq(cpu, vm_level);
>   }
>   
>   void loongarch_cpu_set_irq(void *opaque, int irq, int level)
>   {
>       LoongArchCPU *cpu = opaque;
>       CPUState *cs = CPU(cpu);
> +    CPULoongArchState *env = cpu_env(cs);
>   
> -    if (irq < 0 || irq >= N_IRQS) {
> +    if (irq < 0 || irq >= (cpu_has_lvz(env) ? N_VIRQS : N_IRQS)) {
>           return;
>       }
>   
> @@ -103,11 +114,11 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
>   }
>   
>   /* Check if there is pending and not masked out interrupt */
> -bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
> +bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env, int vm_level)
>   {
>       uint32_t pending;
>       uint32_t status;
> -    CPUSysState *sys = env_sys(env);
> +    CPUSysState *sys = get_sys(env, vm_level);
>   
>       pending = FIELD_EX64(sys->CSR_ESTAT, CSR_ESTAT, IS);
>       status  = FIELD_EX64(sys->CSR_ECFG, CSR_ECFG, LIE);
> @@ -122,7 +133,11 @@ bool loongarch_cpu_has_work(CPUState *cs)
>       bool has_work = false;
>   
>       if (cpu_test_interrupt(cs, CPU_INTERRUPT_HARD) &&
> -        cpu_loongarch_hw_interrupts_pending(cpu_env(cs))) {
> +        cpu_loongarch_hw_interrupts_pending(cpu_env(cs), VM_LEVEL0)) {
> +        has_work = true;
> +    }
> +    if (cpu_test_interrupt(cs, CPU_INTERRUPT_GUEST) &&
> +        cpu_loongarch_hw_interrupts_pending(cpu_env(cs), VM_LEVEL1)) {
>           has_work = true;
>       }
>   
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 9eea1badaf..8939dbc748 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -20,6 +20,8 @@
>   #include "cpu-csr.h"
>   #include "cpu-qom.h"
>   
> +#define CPU_INTERRUPT_GUEST CPU_INTERRUPT_TGT_EXT_0
> +
>   #define FCSR0_M1    0x1f         /* FCSR1 mask, Enables */
>   #define FCSR0_M2    0x1f1f0000   /* FCSR2 mask, Cause and Flags */
>   #define FCSR0_M3    0x300        /* FCSR3 mask, Round Mode */
> @@ -242,6 +244,7 @@ extern const char * const fregnames[32];
>   #define IRQ_TIMER   11
>   #define IRQ_IPI     12
>   #define INT_DMSI    14
> +#define N_VIRQS     (N_IRQS * 2)
>   
>   #define MAX_PERF_EVENTS        16
>   #define LOONGARCH_STLB         2048 /* 2048 STLB */
> diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
> index ff956823fd..c11cefc4ee 100644
> --- a/target/loongarch/internals.h
> +++ b/target/loongarch/internals.h
> @@ -31,7 +31,7 @@ void restore_fp_status(CPULoongArchState *env);
>   #ifndef CONFIG_USER_ONLY
>   extern const VMStateDescription vmstate_loongarch_cpu;
>   
> -void loongarch_cpu_update_irq(LoongArchCPU *cpu);
> +void loongarch_cpu_update_irq(LoongArchCPU *cpu, int vm_level);
>   void loongarch_cpu_set_irq(void *opaque, int irq, int level);
>   
>   void cpu_loongarch_timer_cb(void *opaque);
> @@ -39,7 +39,7 @@ uint64_t cpu_loongarch_get_timer_counter(CPUTimerState *timer);
>   uint64_t cpu_loongarch_get_timer_ticks(CPUTimerState *timer);
>   void cpu_loongarch_set_timer_config(CPUTimerState *timer, uint64_t value);
>   bool loongarch_cpu_has_work(CPUState *cs);
> -bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env);
> +bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env, int vm_level);
>   #endif /* !CONFIG_USER_ONLY */
>   
>   uint64_t read_fcc(CPULoongArchState *env);
> diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
> index 1a6919417f..ecfba63228 100644
> --- a/target/loongarch/tcg/csr_helper.c
> +++ b/target/loongarch/tcg/csr_helper.c
> @@ -111,7 +111,7 @@ target_ulong helper_csrwr_estat(CPULoongArchState *env, target_ulong val)
>        */
>       if (sys->CSR_ESTAT != old_v) {
>           bql_lock();
> -        loongarch_cpu_update_irq(env_archcpu(env));
> +        loongarch_cpu_update_irq(env_archcpu(env), false);
why is it false, I think it should be current VM_LEVEL.

>           bql_unlock();
>       }
>   
> diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
> index b60d9e7cf8..101fe6fc7a 100644
> --- a/target/loongarch/tcg/tcg_cpu.c
> +++ b/target/loongarch/tcg/tcg_cpu.c
> @@ -238,30 +238,47 @@ static void loongarch_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
>       }
>   }
>   
> -static inline bool cpu_loongarch_hw_interrupts_enabled(CPULoongArchState *env)
> +static inline bool cpu_loongarch_hw_interrupts_enabled(CPULoongArchState *env, int vm_level)
>   {
>       bool ret = 0;
> -    CPUSysState *sys = env_sys(env);
> +    CPUSysState *sys = get_sys(env, vm_level);
> +    CPUSysState *host = get_sys(env, VM_LEVEL0);
>   
>       ret = (FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, IE) &&
> -          !(FIELD_EX64(sys->CSR_DBG, CSR_DBG, DST)));
> +          !(FIELD_EX64(host->CSR_DBG, CSR_DBG, DST)));
why checking CSR_DBG of host here, it is a little strange.

Regards
Bibo Mao
>   
>       return ret;
>   }
>   
>   static bool loongarch_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>   {
> +    CPULoongArchState *env = cpu_env(cs);
> +    bool has_interrupt = false;
> +
>       if (interrupt_request & CPU_INTERRUPT_HARD) {
> -        CPULoongArchState *env = cpu_env(cs);
> -
> -        if (cpu_loongarch_hw_interrupts_enabled(env) &&
> -            cpu_loongarch_hw_interrupts_pending(env)) {
> -            /* Raise it */
> -            cs->exception_index = EXCCODE_INT;
> -            loongarch_cpu_do_interrupt(cs);
> -            return true;
> +
> +        if (cpu_loongarch_hw_interrupts_enabled(env, VM_LEVEL0) &&
> +            cpu_loongarch_hw_interrupts_pending(env, VM_LEVEL0)) {
> +            if (env_vm_level(env) != VM_LEVEL0) {
> +                trigger_vm_exit(env);
> +            }
> +            has_interrupt = true;
>           }
> +    } else if (interrupt_request & CPU_INTERRUPT_GUEST) {
> +        if (cpu_loongarch_hw_interrupts_enabled(env, VM_LEVEL1) &&
> +            cpu_loongarch_hw_interrupts_pending(env, VM_LEVEL1) &&
> +            env_vm_level(env) == VM_LEVEL1) {
> +            has_interrupt = true;
> +        }
> +    }
> +
> +    if (has_interrupt) {
> +        /* Raise it */
> +        cs->exception_index = EXCCODE_INT;
> +        loongarch_cpu_do_interrupt(cs);
> +        return true;
>       }
> +
>       return false;
>   }
>   
> 


