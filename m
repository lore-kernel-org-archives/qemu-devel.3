Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985B4606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 02:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVJha-0000qw-J8; Sun, 22 Nov 2026 21:22:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xVJhX-0000pc-1i
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 21:22:39 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xVJhU-0002mI-9j
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 21:22:38 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxHNBfowNrhxciAA--.4017S3;
 Mon, 23 Nov 2026 10:22:23 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJDxTs9dowNrQ8M2AA--.43942S2;
 Mon, 23 Nov 2026 10:22:21 +0800 (CST)
Subject: Re: [PATCH v6 04/26] target/loongarch: add vm level 1 definition
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1794558695.git.prcups@krgm.moe>
 <4d1d8f40f581a9a0a5986480eceadc4c62e576c8.1794558695.git.prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <c39f00c6-e7b9-ad47-095a-2c59c6666dd0@loongson.cn>
Date: Mon, 23 Nov 2026 10:23:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4d1d8f40f581a9a0a5986480eceadc4c62e576c8.1794558695.git.prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxTs9dowNrQ8M2AA--.43942S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxArWfWr1DAryrAFWkGr4ftFc_yoW5CFWkpr
 WxCFy3KF48KFW7A3s2qwn8GF15Zr1xGw1293Wa9ry8KFZ8JryF9a4vq3yqgF4DJay5ur1x
 XFn3Aw1UWFZrWagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
 wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
 WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcrWF
 UUUUU
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
it is more direct to use the sentence such as:
     return env->vm_level;

Regards
Bibo Mao
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
>       flags |= FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, FPE) * HW_FLAGS_EUEN_FPE;
>       flags |= FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, SXE) * HW_FLAGS_EUEN_SXE;
>       flags |= FIELD_EX64(sys->CSR_EUEN, CSR_EUEN, ASXE) * HW_FLAGS_EUEN_ASXE;
> 


