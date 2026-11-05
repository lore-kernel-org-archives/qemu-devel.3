Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA7A606A32C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 06:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOrDf-0004id-WF; Thu, 05 Nov 2026 01:45:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1xOrDc-0004gk-3g
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 01:45:04 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1xOrDa-0008DL-4H
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 01:45:03 -0500
Received: from loongson.cn (unknown [10.20.42.166])
 by gateway (Coremail) with SMTP id _____8Bxn9HsJexq2o4cAA--.16510S3;
 Thu, 05 Nov 2026 14:45:00 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJAxFs3rJexqrIEyAA--.46395S2;
 Thu, 05 Nov 2026 14:44:59 +0800 (CST)
Subject: Re: [PATCH 1/2] target/loongarch: Replace kvm_cpu_has_msgint() with
 cpu_has_msgint()
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <17746591750@163.com>
Cc: qemu-devel@nongnu.org
References: <20261029085654.78806-1-maobibo@loongson.cn>
 <20261029085654.78806-2-maobibo@loongson.cn>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <22315f72-6485-1c87-9ef3-de9d4f2f50df@loongson.cn>
Date: Thu, 5 Nov 2026 14:43:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261029085654.78806-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJAxFs3rJexqrIEyAA--.46395S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWr45Kw15CryUCw13Kry7CFX_yoW5WF4Upr
 W7AF4UKFW8KrZrA3Z5Xa90gry7Zr47Kw429ayIkryvkFs8Gr18Zr1vq39rtFn8Aay8Wr10
 9F1rCF15Wa17Z3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
 0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8QJ
 57UUUUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
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

Reviewed-by:  Xianglai Li <lixianglai@loongson.cn>

> target/loongarch: Use cpu_has_msgint() and FIELD_EX32 for cpucfg
>
> cpu_has_msgint() is more generic and can be used in TCG mode, so use it
> instead of the KVM-specific feature check.
>
> The cpucfg register is 32 bits wide; use FIELD_EX32() rather than
> FIELD_EX64() when extracting its fields.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   target/loongarch/cpu.h     |  6 ++++++
>   target/loongarch/kvm/kvm.c | 11 ++---------
>   target/loongarch/machine.c |  2 +-
>   3 files changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 5cc2370da2..e8867ea2a7 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -540,6 +540,12 @@ static inline bool is_va32(CPULoongArchState *env)
>       return va32;
>   }
>   
> +static inline bool cpu_has_msgint(CPULoongArchState *env)
> +{
> +
> +    return FIELD_EX32(env->cpucfg[1], CPUCFG1, MSG_INT);
> +}
> +
>   static inline void set_pc(CPULoongArchState *env, uint64_t value)
>   {
>       if (is_va32(env)) {
> diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
> index 7ca95181a1..8732f55e06 100644
> --- a/target/loongarch/kvm/kvm.c
> +++ b/target/loongarch/kvm/kvm.c
> @@ -36,13 +36,6 @@ const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
>       KVM_CAP_LAST_INFO
>   };
>   
> -static bool kvm_cpu_has_msgint(CPUState *cs)
> -{
> -    LoongArchCPU *cpu = LOONGARCH_CPU(cs);
> -
> -    return FIELD_EX64(cpu->env.cpucfg[1], CPUCFG1, MSG_INT);
> -}
> -
>   static int kvm_get_stealtime(CPUState *cs)
>   {
>       CPULoongArchState *env = cpu_env(cs);
> @@ -374,7 +367,7 @@ static int kvm_loongarch_get_csr(CPUState *cs)
>        * Since register CSR_ESTAT will sync software pending MSGINT status to
>        * hardware register and modify HW CSR MSGIS registers.
>        */
> -    if (kvm_cpu_has_msgint(cs)) {
> +    if (cpu_has_msgint(env)) {
>           ret |= kvm_get_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(0)),
>                                  &sys->CSR_MSGIS[0]);
>   
> @@ -564,7 +557,7 @@ static int kvm_loongarch_put_csr(CPUState *cs, KvmPutState level)
>   
>       ret |= kvm_loongarch_put_pmu(cs);
>   
> -    if (kvm_cpu_has_msgint(cs)) {
> +    if (cpu_has_msgint(env)) {
>           ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_MSGIS(0)),
>                                  &sys->CSR_MSGIS[0]);
>   
> diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
> index 952c5497af..4acab2a4a3 100644
> --- a/target/loongarch/machine.c
> +++ b/target/loongarch/machine.c
> @@ -49,7 +49,7 @@ static bool msgint_needed(void *opaque)
>   {
>       LoongArchCPU *cpu = opaque;
>   
> -    return FIELD_EX64(cpu->env.cpucfg[1], CPUCFG1, MSG_INT);
> +    return cpu_has_msgint(&cpu->env);
>   }
>   
>   static const VMStateDescription vmstate_msgint = {


