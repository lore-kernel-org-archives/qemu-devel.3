Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DDD606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 07:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVOUP-00084H-Vy; Mon, 23 Nov 2026 02:29:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xVOUN-000848-UL
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 02:29:23 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xVOUK-0004Jp-9y
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 02:29:23 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxfdBK6wNrbyYiAA--.4039S3;
 Mon, 23 Nov 2026 15:29:14 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front2 (Coremail) with SMTP id qciowJCxrn9D6wNrqHYNAA--.201S2;
 Mon, 23 Nov 2026 15:29:09 +0800 (CST)
Subject: Re: [PATCH v6 07/26] target/loongarch: add LVZ guest interrupt state
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1794558695.git.prcups@krgm.moe>
 <015462504acdaaa48e6af38ac3bd1825c936f317.1794558695.git.prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <44449581-bf15-ed23-97f4-93b1cb3f6258@loongson.cn>
Date: Mon, 23 Nov 2026 15:30:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <015462504acdaaa48e6af38ac3bd1825c936f317.1794558695.git.prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qciowJCxrn9D6wNrqHYNAA--.201S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Ww13AFW8Cw1xur45ur1fZrc_yoW3CrWxpF
 W7uFyagr48KrWDJ3s5tas0vFn8Zr1xWw129ana934Skr4DXr18Xr1kt39ruFn8C34UWw1j
 qFn5u3WDuay7XFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jO
 F4_UUUUU=
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
> Route configured hardware interrupts into the guest CSR bank, track guest
> interrupt requests separately, and expose guest pending and enable checks
> to the TCG runtime.
> 
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> ---
>   target/loongarch/cpu.c            | 32 +++++++++++++++++++--------
>   target/loongarch/cpu.h            |  3 +++
>   target/loongarch/internals.h      |  4 ++--
>   target/loongarch/tcg/csr_helper.c |  2 +-
>   target/loongarch/tcg/tcg_cpu.c    | 36 ++++++++++++++++++++++---------
>   5 files changed, 55 insertions(+), 22 deletions(-)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index fc432cfda0..20209c1bfc 100644
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
> @@ -75,13 +79,19 @@ static void loongarch_cpu_self_set_irq(CPUState *cs, run_on_cpu_data data)
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
> @@ -104,11 +114,11 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
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
> @@ -123,7 +133,11 @@ static bool loongarch_cpu_has_work(CPUState *cs)
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
> index 14316fc9c5..22f2b0aa47 100644
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
> index bc32bba7f7..616afd2e94 100644
> --- a/target/loongarch/internals.h
> +++ b/target/loongarch/internals.h
> @@ -31,14 +31,14 @@ void restore_fp_status(CPULoongArchState *env);
>   #ifndef CONFIG_USER_ONLY
>   extern const VMStateDescription vmstate_loongarch_cpu;
>   
> -void loongarch_cpu_update_irq(LoongArchCPU *cpu);
> +void loongarch_cpu_update_irq(LoongArchCPU *cpu, int vm_level);
>   void loongarch_cpu_set_irq(void *opaque, int irq, int level);
>   
>   void cpu_loongarch_timer_cb(void *opaque);
>   uint64_t cpu_loongarch_get_timer_counter(CPUTimerState *timer);
>   uint64_t cpu_loongarch_get_timer_ticks(CPUTimerState *timer);
>   void cpu_loongarch_set_timer_config(CPUTimerState *timer, uint64_t value);
> -bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env);
> +bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env, int vm_level);
>   #endif /* !CONFIG_USER_ONLY */
>   
>   const char *loongarch_exception_name(int exception);
> diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
> index 7cba8035df..e0fcac8da8 100644
> --- a/target/loongarch/tcg/csr_helper.c
> +++ b/target/loongarch/tcg/csr_helper.c
> @@ -111,7 +111,7 @@ target_ulong HELPER(csrwr_estat)(CPULoongArchState *env, target_ulong val)
>        */
>       if (sys->CSR_ESTAT != old_v) {
>           bql_lock();
> -        loongarch_cpu_update_irq(env_archcpu(env));
> +        loongarch_cpu_update_irq(env_archcpu(env), false);
I think it should be:
            loongarch_cpu_update_irq(env_archcpu(env), env_vm_level(env));

Regards
Bibo Mao

>           bql_unlock();
>       }
>   
> diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
> index 7babc1a1f9..8765bda0d1 100644
> --- a/target/loongarch/tcg/tcg_cpu.c
> +++ b/target/loongarch/tcg/tcg_cpu.c
> @@ -198,10 +198,10 @@ static void loongarch_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
>       }
>   }
>   
> -static inline bool cpu_loongarch_hw_interrupts_enabled(CPULoongArchState *env)
> +static inline bool cpu_loongarch_hw_interrupts_enabled(CPULoongArchState *env, int vm_level)
>   {
>       bool ret = 0;
> -    CPUSysState *sys = env_sys(env);
> +    CPUSysState *sys = get_sys(env, vm_level);
>   
>       ret = (FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, IE) &&
>             !(FIELD_EX64(sys->CSR_DBG, CSR_DBG, DST)));
> @@ -211,17 +211,33 @@ static inline bool cpu_loongarch_hw_interrupts_enabled(CPULoongArchState *env)
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


