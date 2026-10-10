Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A09CA6017
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 08:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFSvU-0005vM-VC; Sat, 10 Oct 2026 04:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xFSvS-0005uy-2j
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 04:59:30 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xFSvO-0002pG-U9
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 04:59:29 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8BxbdJr_slqy3AUAA--.60747S3;
 Sat, 10 Oct 2026 16:59:23 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJAxmM1q_slqRc8qAA--.23738S2;
 Sat, 10 Oct 2026 16:59:22 +0800 (CST)
Subject: Re: [PATCH v5 12/23] target/loongarch: add gid management functions
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1791514848.git.prcups@krgm.moe>
 <250dacc824c93affe3062fc8c232ec1afcd7e6e2.1791514848.git.prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <6d570d6e-eca8-0198-ce23-e3293cd60e5c@loongson.cn>
Date: Sat, 10 Oct 2026 17:00:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <250dacc824c93affe3062fc8c232ec1afcd7e6e2.1791514848.git.prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxmM1q_slqRc8qAA--.23738S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw18KryrtF4kJr1DCr15trc_yoW8tw48pr
 W7CFZxKFW0gFZrA3Zaq34YgF98Zw18KwsFq3WfKr95AFsxJrW29r1kKwsF9F18J3y5Cr18
 XFsa9r1UCFZFqacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jn
 UUUUUUUU=
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
> Add get_gid(), get_tgid() and tlb_entry_matches_gid(), to get and use gid in
> lvz functions.
> 
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> ---
>   target/loongarch/cpu.h            | 21 +++++++++++++++++++++
>   target/loongarch/tcg/tlb_helper.c |  5 +++++
>   2 files changed, 26 insertions(+)
> 
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 3e3ae2bfa7..a42c5fe170 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -583,6 +583,27 @@ static inline bool will_return_to_guest(CPULoongArchState *env)
>       return FIELD_EX64(get_sys(env, VM_LEVEL0)->CSR_GSTAT, CSR_GSTAT, PVM);
>   }
>   
> +static inline uint8_t get_gid(CPULoongArchState *env)
> +{
> +    return FIELD_EX64(get_sys(env, VM_LEVEL0)->CSR_GSTAT, CSR_GSTAT, GID);
> +}
> +
> +static inline uint8_t get_tgid(CPULoongArchState *env)
> +{
> +    CPUSysState *host = get_sys(env, VM_LEVEL0);
> +
> +    if (env_vm_level(env) == VM_LEVEL1) {
> +        return get_gid(env);
> +    }
> +
> +    if (FIELD_EX64(host->CSR_GTLBC, CSR_GTLBC, USETGID)) {
> +        return FIELD_EX64(host->CSR_GTLBC, CSR_GTLBC, TGID);
> +    } else if (will_return_to_guest(env)) {
> +        return get_gid(env);
> +    }why there is such checking with tgid()?, I think it is simple to come 
from TGID field of CSR_GTLBC even in host mode, such as:
    return FIELD_EX64(host->CSR_GTLBC, CSR_GTLBC, TGID);

Regards
Bibo Mao
> +    return 0;
> +}
> +
>   static inline CPUTimerState *env_timer(CPULoongArchState *env)
>   {
>       return &env->sys_states[0].timer_state;
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index d1f1d233fd..821aa26328 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -35,6 +35,11 @@ static bool tlb_match_asid(bool global, int asid, int tlb_asid)
>       return !global && tlb_asid == asid;
>   }
>   
> +static inline bool tlb_entry_matches_gid(const LoongArchTLB *tlb, uint8_t gid)
> +{
> +    return FIELD_EX64(tlb->tlb_misc, TLB_MISC, GID) == gid;
> +}
> +
>   bool check_ps(CPULoongArchState *env, uint8_t tlb_ps)
>   {
>       CPUSysState *sys = env_sys(env);
> 


