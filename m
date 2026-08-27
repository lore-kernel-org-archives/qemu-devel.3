Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D45C61DC2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzZFq-0008WM-7H; Thu, 27 Aug 2026 08:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1wzZFX-0008K4-6t; Thu, 27 Aug 2026 08:30:31 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>)
 id 1wzZFT-00054B-UN; Thu, 27 Aug 2026 08:30:30 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Axj9HbLZBqnK8FAA--.15998S3;
 Thu, 27 Aug 2026 20:30:19 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJAxmM3aLZBqx0cUAA--.38948S2;
 Thu, 27 Aug 2026 20:30:18 +0800 (CST)
Subject: Re: [PATCH v4 10/20] target/loongarch: Constify CPULoongArchState for
 various cpu_*() getters
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Song Gao <17746591750@163.com>,
 Xianglai Li <lixianglai@loongson.cn>
References: <20260824111711.26297-1-philmd@oss.qualcomm.com>
 <20260824111711.26297-11-philmd@oss.qualcomm.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <97be02b2-103b-fb9e-c50c-9061e8218f64@loongson.cn>
Date: Thu, 27 Aug 2026 20:30:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20260824111711.26297-11-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxmM3aLZBqx0cUAA--.38948S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGF1rtr1rXw13XFyrGF4rZwc_yoW5Wr4fpr
 W7CF13Xr4UKrWjva4kK3s0gF1DZr13Wrya9a1SkryrGanxJr1xWrn5t39F9F1UA3y8WFyI
 vF1rA3WUWa17Z3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jO
 uc_UUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.247,
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



On 2026/8/24 下午7:16, Philippe Mathieu-Daudé wrote:
> Add the const qualifier to CPULoongArchState when
> the argument is accessed without modification.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   target/loongarch/cpu.h       | 6 +++---
>   target/loongarch/internals.h | 2 +-
>   target/loongarch/cpu.c       | 2 +-
>   3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 97db3b453fe..ad8e7497279 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -486,7 +486,7 @@ struct LoongArchCPUClass {
>   #define MMU_USER_IDX     MMU_PLV_USER
>   #define MMU_DA_IDX       4
>   
> -static inline CPUSysState *env_sys(CPULoongArchState *env)
> +static inline CPUSysState *env_sys(const CPULoongArchState *env)
>   {
>       return env->sys_state;
>   }
> @@ -496,12 +496,12 @@ static inline void set_sys_state(CPULoongArchState *env, CPUSysState *sys)
>       env->sys_state = sys;
>   }
>   
> -static inline bool is_la64(CPULoongArchState *env)
> +static inline bool is_la64(const CPULoongArchState *env)
>   {
>       return FIELD_EX32(env->cpucfg[1], CPUCFG1, ARCH) == CPUCFG1_ARCH_LA64;
>   }
>   
> -static inline bool is_va32(CPULoongArchState *env)
> +static inline bool is_va32(const CPULoongArchState *env)
>   {
>       /* VA32 if !LA64 or VA32L[1-3] */
>       bool va32 = !is_la64(env);
> diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
> index 50f0fe2e9be..d6f31161e85 100644
> --- a/target/loongarch/internals.h
> +++ b/target/loongarch/internals.h
> @@ -38,7 +38,7 @@ uint64_t cpu_loongarch_get_constant_timer_counter(LoongArchCPU *cpu);
>   uint64_t cpu_loongarch_get_constant_timer_ticks(LoongArchCPU *cpu);
>   void cpu_loongarch_store_constant_timer_config(LoongArchCPU *cpu,
>                                                  uint64_t value);
> -bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env);
> +bool cpu_loongarch_hw_interrupts_pending(const CPULoongArchState *env);
>   #endif /* !CONFIG_USER_ONLY */
>   
>   uint64_t read_fcc(CPULoongArchState *env);
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index d9c1e871027..2dbe2203b20 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -82,7 +82,7 @@ void loongarch_cpu_set_irq(void *opaque, int irq, int level)
>   }
>   
>   /* Check if there is pending and not masked out interrupt */
> -bool cpu_loongarch_hw_interrupts_pending(CPULoongArchState *env)
> +bool cpu_loongarch_hw_interrupts_pending(const CPULoongArchState *env)
>   {
>       uint32_t pending;
>       uint32_t status;
> 
Reviewed-by: Bibo Mao <maobibo@loongson.cn>


