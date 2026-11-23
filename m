Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97009606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 02:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVJwf-0004Tw-SK; Sun, 22 Nov 2026 21:38:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xVJwd-0004Tn-5a
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 21:38:15 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xVJwa-0007WN-F3
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 21:38:14 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxztIMpwNrRhgiAA--.31161S3;
 Mon, 23 Nov 2026 10:38:05 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJCxPs8LpwNrHcQ2AA--.43383S2;
 Mon, 23 Nov 2026 10:38:03 +0800 (CST)
Subject: Re: [PATCH v6 04/26] target/loongarch: add vm level 1 definition
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1794558695.git.prcups@krgm.moe>
 <4d1d8f40f581a9a0a5986480eceadc4c62e576c8.1794558695.git.prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <46c8b57d-0c01-b512-ca4d-030cf7a671a5@loongson.cn>
Date: Mon, 23 Nov 2026 10:39:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4d1d8f40f581a9a0a5986480eceadc4c62e576c8.1794558695.git.prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxPs8LpwNrHcQ2AA--.43383S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxArWfWr1DAryrAFWkGr4ftFc_yoW5ZF13p3
 yxCFy5KF48KFW7A3s7twn8GFn8Zr1xCw1293Wa9r95KFZ8JryFga4vqw4DKF48Jayrur4x
 XFn3Aw15WFZrW3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJwAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
 Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_
 JF1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
 CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48J
 MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI
 0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc40Y
 0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
 IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8XVy3UUUU
 U==
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
> Add VM_LEVEL1 macro, env_vm_level() and trigger_vm_exit() functions, preparing
> for later interrupt virtualization.
> 
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> ---
>   target/loongarch/cpu.h         | 22 +++++++++++++++++++++-
>   target/loongarch/tcg/tcg_cpu.c |  3 +++
>   2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 05309336d2..ff22cde702 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -324,7 +324,8 @@ typedef struct CPUTimerState {
>   } CPUTimerState;
>   
>   #define VM_LEVEL0   0
> -#define VM_LEVELS   1
> +#define VM_LEVEL1   1
> +#define VM_LEVELS   2
>   
>   #define CPU_VENDOR_LOONGSON   "Loongson"
>   #define CPU_MODEL_3A5000      "3A5000"
> @@ -448,6 +449,7 @@ typedef struct CPUArchState {
>   #endif
>       int vm_level;
>       unsigned int irq_nr;
> +    bool vm_exit;
>   } CPULoongArchState;
>   
>   typedef struct LoongArchCPUTopo {
> @@ -520,6 +522,11 @@ static inline CPUSysState *env_sys(CPULoongArchState *env)
>       return &env->sys_states[env->vm_level];
>   }
>   
> +static inline int env_vm_level(CPULoongArchState *env)
> +{
> +    return env_sys(env) - env->sys_states;
> +}
> +
>   static inline void set_sys(CPULoongArchState *env, int vm_level)
>   {
>       if (vm_level >= 0 && vm_level <  VM_LEVELS) {
> @@ -537,6 +544,18 @@ static inline bool cpu_has_lvz(CPULoongArchState *env)
>       return FIELD_EX32(env->cpucfg[2], CPUCFG2, LVZ);
>   }
>   
> +static inline void trigger_vm_exit(CPULoongArchState *env)
> +{
> +    CPUSysState *host = get_sys(env, VM_LEVEL0);
> +
> +    if (env_vm_level(env) != VM_LEVEL1) {
> +        return;
> +    }
> +
> +    host->CSR_GSTAT = FIELD_DP64(host->CSR_GSTAT, CSR_GSTAT, PVM, 1);
> +    env->vm_exit = true;
> +}
> +
>   static inline CPUTimerState *env_timer(CPULoongArchState *env)
>   {
>       return &env->sys_states[0].timer_state;
> @@ -583,6 +602,7 @@ static inline void set_pc(CPULoongArchState *env, uint64_t value)
>   #define HW_FLAGS_CRMD_PG    R_CSR_CRMD_PG_MASK   /* 0x10 */
>   #define HW_FLAGS_VA32       0x20
>   #define HW_FLAGS_EUEN_ASXE  0x40
> +#define HW_FLAGS_GUEST_MODE 0x80
Suggest rename HW_FLAGS_GUEST_MODE with HW_FLAGS_VM_LEVEL.

>   
>   #define CPU_RESOLVING_TYPE TYPE_LOONGARCH_CPU
>   
> diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
> index 0549506035..c2792c8db1 100644
> --- a/target/loongarch/tcg/tcg_cpu.c
> +++ b/target/loongarch/tcg/tcg_cpu.c
> @@ -239,6 +239,9 @@ static TCGTBCPUState loongarch_get_tb_cpu_state(CPUState *cs)
>       uint32_t flags;
>   
>       flags = sys->CSR_CRMD & (R_CSR_CRMD_PLV_MASK | R_CSR_CRMD_PG_MASK);
> +    if (env_vm_level(env) == VM_LEVEL1) {
> +        flags |= HW_FLAGS_GUEST_MODE;
> +    }
how about something like this:
         flags |= env_vm_level(env) << HW_FLAGS_VM_LEVEL;

Regards
Bibo Mao
>       flags |= FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
>       flags |= FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SXE;
>       flags |= FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, ASXE) * HW_FLAGS_EUEN_ASXE;
> 


