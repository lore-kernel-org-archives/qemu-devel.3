Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC8EC021A9
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 06:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkHD2-0005AP-JP; Tue, 18 Feb 2025 01:35:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1tkHCu-00058C-Ez
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 01:35:49 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1tkHCl-0005Wp-A9
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 01:35:45 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Bx12kwKrRnEIZ5AA--.13296S3;
 Tue, 18 Feb 2025 14:35:28 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMBxb8ctKrRn_MgZAA--.32810S3;
 Tue, 18 Feb 2025 14:35:28 +0800 (CST)
Subject: Re: [PATCH 1/1] target/loongarch: fix 'make check-functional failed'
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
Cc: richard.henderson@linaro.org, yangxiaojuan@loongson.cn
References: <20250217005439.249587-1-gaosong@loongson.cn>
From: bibo mao <maobibo@loongson.cn>
Message-ID: <2a05b1a2-ac29-ac39-d96f-3ed9fa046f29@loongson.cn>
Date: Tue, 18 Feb 2025 14:34:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250217005439.249587-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMBxb8ctKrRn_MgZAA--.32810S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxtF47Wr1UKF43KF45Jr1rZrc_yoW7Zr1rpF
 W7CrWqkFW8KrZ7A3WSq3W5tr1DZw4UKw4xZan3K34FkanxXrZ7XrWvq3sIgF1kJ3y5WF1I
 vF1vyry8uFW5XacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j8yCJU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.369,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 2025/2/17 上午8:54, Song Gao wrote:
> For LoongArch th min tlb_ps is 12(4KB), for TLB code,
> the tlb_ps may be 0,this may case UndefinedBehavior
> Add a check-tlb_ps fuction to check tlb_ps, when use
> csrwr insn to write CRMD PG=1, check the tlb_ps, and when
> use csrwr insn to write STLBPS, check the tlb_ps value.
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   target/loongarch/helper.h                     |  2 +
>   target/loongarch/internals.h                  |  1 +
>   target/loongarch/tcg/csr_helper.c             | 52 +++++++++++++++++++
>   .../tcg/insn_trans/trans_privileged.c.inc     |  2 +
>   target/loongarch/tcg/tlb_helper.c             |  4 ++
>   5 files changed, 61 insertions(+)
> 
> diff --git a/target/loongarch/helper.h b/target/loongarch/helper.h
> index 943517b5f2..4f1490a465 100644
> --- a/target/loongarch/helper.h
> +++ b/target/loongarch/helper.h
> @@ -100,6 +100,8 @@ DEF_HELPER_1(rdtime_d, i64, env)
>   DEF_HELPER_1(csrrd_pgd, i64, env)
>   DEF_HELPER_1(csrrd_cpuid, i64, env)
>   DEF_HELPER_1(csrrd_tval, i64, env)
> +DEF_HELPER_2(csrwr_crmd, i64, env,tl)
> +DEF_HELPER_2(csrwr_stlbps, i64, env, tl)
>   DEF_HELPER_2(csrwr_estat, i64, env, tl)
>   DEF_HELPER_2(csrwr_asid, i64, env, tl)
>   DEF_HELPER_2(csrwr_tcfg, i64, env, tl)
> diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
> index 7b254c5f49..bb1644f0a0 100644
> --- a/target/loongarch/internals.h
> +++ b/target/loongarch/internals.h
> @@ -43,6 +43,7 @@ enum {
>       TLBRET_PE = 7,
>   };
>   
> +void check_tlb_ps(CPULoongArchState *env);
>   extern const VMStateDescription vmstate_loongarch_cpu;
>   
>   void loongarch_cpu_set_irq(void *opaque, int irq, int level);
> diff --git a/target/loongarch/tcg/csr_helper.c b/target/loongarch/tcg/csr_helper.c
> index 6c95be9910..32c9716f42 100644
> --- a/target/loongarch/tcg/csr_helper.c
> +++ b/target/loongarch/tcg/csr_helper.c
> @@ -97,6 +97,58 @@ target_ulong helper_csrwr_ticlr(CPULoongArchState *env, target_ulong val)
>       return old_v;
>   }
>   
> +void check_tlb_ps(CPULoongArchState *env)
> +{
> +    for (int i=0; i<LOONGARCH_TLB_MAX; i++)
> +    {
> +        LoongArchTLB*tlb =&env->tlb[i];
> +        uint8_t tlb_ps;
> +        if(i >= LOONGARCH_STLB) {
> +            tlb_ps = FIELD_EX64(tlb->tlb_misc,TLB_MISC,PS);
It is strange why tlb entries is check here? If I am understanding 
right, TLB page size should comes from these two areas:
    FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE); or
    FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS,PS);

If page size of CSR_PWCL is equal to CSR_STLBPS, it is put to STLB, else 
it is put to MTLB. If so, it will be ok if these CSR registers are checked.
    FIELD_EX64(env->CSR_PWCL, CSR_PWCL, PTBASE)
    FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS,PS)

And when system is set with Page-mode by writing CRMD register, TLB 
entry should be empty in theory.

> +	    if (tlb_ps < 12) {
> +                tlb->tlb_misc = FIELD_DP64(tlb->tlb_misc, TLB_MISC, PS, 12);
> +            }
> +        } else {
> +            tlb_ps = FIELD_EX64(env->CSR_STLBPS, CSR_STLBPS,PS);
> +            if (tlb_ps < 12) {
> +               env->CSR_STLBPS= FIELD_DP64(env->CSR_STLBPS, CSR_STLBPS, PS, 12);
> +           }
> +       }
> +    }
> +}
> +
> +target_ulong helper_csrwr_crmd(CPULoongArchState *env, target_ulong val)
> +{
> +    uint8_t pg;
> +    int64_t old_v = env->CSR_CRMD;
> +
> +    pg = FIELD_EX64(val, CSR_CRMD, PG);
Do you mean that it is the first time that Page-mode is set. If so, it 
had better be:
        old = FIELD_EX64(old_v, CSR_CRMD, PG);
        if (pg && !old) {

Regards
Bibo Mao
> +    if (pg) {
> +        check_tlb_ps(env);
> +    }
> +    env->CSR_CRMD = val;
> +    return old_v;
> +}
> +
> +target_ulong helper_csrwr_stlbps(CPULoongArchState *env, target_ulong val)
> +{
> +    uint8_t tlb_ps;
> +    int64_t old_v = env->CSR_STLBPS;
> +
> +    /*
> +     * The real hardware only supports the min tlb_ps is 12
> +     * tlb_ps=0 may cause undefined-behavior.
> +     */
> +    tlb_ps = FIELD_EX64(val, CSR_STLBPS, PS);
> +    if (tlb_ps  < 12) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "Attempted set ps %d\n",tlb_ps);
> +        val = FIELD_DP64(val, CSR_STLBPS, PS, 12);
> +    }
> +    env->CSR_STLBPS = val;
> +    return old_v;
> +}
> +
>   target_ulong helper_csrwr_pwcl(CPULoongArchState *env, target_ulong val)
>   {
>       int shift;
> diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> index 3afa23af79..d6b1f8319f 100644
> --- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> @@ -74,6 +74,8 @@ static bool set_csr_trans_func(unsigned int csr_num, GenCSRRead readfn,
>   
>   void loongarch_csr_translate_init(void)
>   {
> +    SET_CSR_FUNC(CRMD, NULL,gen_helper_csrwr_crmd);
> +    SET_CSR_FUNC(STLBPS, NULL,gen_helper_csrwr_stlbps);
>       SET_CSR_FUNC(ESTAT, NULL, gen_helper_csrwr_estat);
>       SET_CSR_FUNC(ASID,  NULL, gen_helper_csrwr_asid);
>       SET_CSR_FUNC(PGD,   gen_helper_csrrd_pgd, NULL);
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index a323606e5a..fc9c7823e7 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -449,7 +449,11 @@ void helper_invtlb_page_asid_or_g(CPULoongArchState *env,
>                                     target_ulong info, target_ulong addr)
>   {
>       uint16_t asid = info & 0x3ff;
> +    uint8_t pg = FIELD_EX64(env->CSR_CRMD, CSR_CRMD, PG);
>   
> +    if (!pg) {
> +        return;
> +    }
>       for (int i = 0; i < LOONGARCH_TLB_MAX; i++) {
>           LoongArchTLB *tlb = &env->tlb[i];
>           uint8_t tlb_g = FIELD_EX64(tlb->tlb_entry0, TLBENTRY, G);
> 


