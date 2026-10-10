Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794A2CA6004
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 03:19:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFNc4-0008Gu-6B; Fri, 09 Oct 2026 23:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xFNc1-0008Gg-Da
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 23:19:05 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xFNbx-0006gP-G9
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 23:19:05 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Bx69GYrslqgF8UAA--.59095S3;
 Sat, 10 Oct 2026 11:18:48 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxTs+VrslqSLcqAA--.24814S2;
 Sat, 10 Oct 2026 11:18:47 +0800 (CST)
Subject: Re: [PATCH v5 03/23] target/loongarch: add LVZ feature switcher
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1791514848.git.prcups@krgm.moe>
 <7c70892a1a7155a2ad3fe1495cdf29168ec6fe5b.1791514848.git.prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <bbfa3413-20cd-2d5c-0720-6fe445cc9453@loongson.cn>
Date: Sat, 10 Oct 2026 11:20:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <7c70892a1a7155a2ad3fe1495cdf29168ec6fe5b.1791514848.git.prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxTs+VrslqSLcqAA--.24814S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWrWUWF45Gw17Wr15tw45CFX_yoWrZF1rpr
 W7CF4Y9FWUtFZ7Zwsxtay5Krn5Xr4xWr42qF1fGrZ7uFs8JF1xXFykJ39rAFW8A34UJrW0
 gF4rAa98WFsxtFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU70Pf
 DUUUU
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



On 2026/10/9 上午11:04, SignKirigami wrote:
> Add LVZ property and AVAIL_LVZ macro based on cpucfg.
> 
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> ---
>   target/loongarch/cpu.c       | 33 +++++++++++++++++++++++++++++++--
>   target/loongarch/cpu.h       |  6 ++++++
>   target/loongarch/translate.h |  1 +
>   3 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
> index e1245235be..664763137d 100644
> --- a/target/loongarch/cpu.c
> +++ b/target/loongarch/cpu.c
> @@ -267,11 +267,33 @@ static void loongarch_set_ptw(Object *obj, bool value, Error **errp)
>       cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, HPTW, value);
>   }
>   
> +static bool loongarch_get_lvz(Object *obj, Error **errp)
> +{
> +    return LOONGARCH_CPU(obj)->lvz != ON_OFF_AUTO_OFF;
> +}
> +
> +static void loongarch_set_lvz(Object *obj, bool value, Error **errp)
> +{
> +    LoongArchCPU *cpu = LOONGARCH_CPU(obj);
> +
> +    cpu->lvz = value ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
> +
> +    if (kvm_enabled()) {
> +        /* lvz can not be only enabled in kvm mode currently */
> +        return;
> +    }
This can be removed if tcg_enabled() is added lvz option.
> +
> +    cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, LVZ, value);
> +    cpu->env.cpucfg[2] = FIELD_DP32(cpu->env.cpucfg[2], CPUCFG2, LVZ_VER,
> +                                    value ? 1 : 0);
> +}
> +
>   static void loongarch_cpu_post_init(Object *obj)
>   {
>       LoongArchCPU *cpu = LOONGARCH_CPU(obj);
>   
>       cpu->lbt = ON_OFF_AUTO_OFF;
> +    cpu->lvz = ON_OFF_AUTO_AUTO;
>       cpu->pmu = ON_OFF_AUTO_OFF;
>       cpu->lsx = ON_OFF_AUTO_AUTO;
>       cpu->lasx = ON_OFF_AUTO_AUTO;
> @@ -283,6 +305,9 @@ static void loongarch_cpu_post_init(Object *obj)
>                                loongarch_set_msgint);
>       object_property_add_bool(obj, "ptw", loongarch_get_ptw,
>                                loongarch_set_ptw);
> +    object_property_add_bool(obj, "lvz", loongarch_get_lvz,
> +                             loongarch_set_lvz);
> +
how about adding if (tcg_enabled()) with lvz property.

>       /* lbt is enabled only in kvm mode, not supported in tcg mode */
>   
>       if (kvm_enabled()) {
> @@ -336,8 +361,12 @@ static void loongarch_la464_initfn(Object *obj)
>       data = FIELD_DP32(data, CPUCFG2, FP_SP, 1);
>       data = FIELD_DP32(data, CPUCFG2, FP_DP, 1);
>       data = FIELD_DP32(data, CPUCFG2, FP_VER, 1);
> -    data = FIELD_DP32(data, CPUCFG2, LSX, 1),
> -    data = FIELD_DP32(data, CPUCFG2, LASX, 1),
> +    data = FIELD_DP32(data, CPUCFG2, LSX, 1);
> +    data = FIELD_DP32(data, CPUCFG2, LASX, 1);
Good catch, thanks for change , with ;   :=)

The others look good to me.

Regards
Bibo Mao
> +    if (tcg_enabled()) {
> +        data = FIELD_DP32(data, CPUCFG2, LVZ, 1);
> +        data = FIELD_DP32(data, CPUCFG2, LVZ_VER, 1);
> +    }
>       data = FIELD_DP32(data, CPUCFG2, LLFTP, 1);
>       data = FIELD_DP32(data, CPUCFG2, LLFTP_VER, 1);
>       data = FIELD_DP32(data, CPUCFG2, LSPW, 1);
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index c0edcc9065..918378ee9a 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -460,6 +460,7 @@ struct ArchCPU {
>       CPULoongArchState env;
>       uint32_t  phy_id;
>       OnOffAuto lbt;
> +    OnOffAuto lvz;
>       OnOffAuto pmu;
>       OnOffAuto ptw;
>       OnOffAuto lsx;
> @@ -520,6 +521,11 @@ static inline CPUSysState *get_sys(CPULoongArchState *env, int vm_level)
>       return &env->sys_states[vm_level];
>   }
>   
> +static inline bool cpu_has_lvz(CPULoongArchState *env)
> +{
> +    return FIELD_EX32(env->cpucfg[2], CPUCFG2, LVZ);
> +}
> +
>   static inline CPUTimerState *env_timer(CPULoongArchState *env)
>   {
>       return &env->sys_states[0].timer_state;
> diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
> index 8aa8325dc6..a7c165982c 100644
> --- a/target/loongarch/translate.h
> +++ b/target/loongarch/translate.h
> @@ -24,6 +24,7 @@
>   #define avail_FP(C)     (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP))
>   #define avail_FP_SP(C)  (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP_SP))
>   #define avail_FP_DP(C)  (FIELD_EX32((C)->cpucfg2, CPUCFG2, FP_DP))
> +#define avail_LVZ(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LVZ))
>   #define avail_LSPW(C)   (FIELD_EX32((C)->cpucfg2, CPUCFG2, LSPW))
>   #define avail_LAM(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAM))
>   #define avail_LAM_BH(C) (FIELD_EX32((C)->cpucfg2, CPUCFG2, LAM_BH))
> 


