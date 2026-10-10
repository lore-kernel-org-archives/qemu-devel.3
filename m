Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F01DCA6004
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 03:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFNt9-0002Mu-AB; Fri, 09 Oct 2026 23:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xFNrh-0002HP-3Z
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 23:35:38 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xFNrb-0007z0-K5
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 23:35:15 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8CxfdJisslqg2AUAA--.59326S3;
 Sat, 10 Oct 2026 11:34:58 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJDxTs9esslq0bgqAA--.24824S2;
 Sat, 10 Oct 2026 11:34:56 +0800 (CST)
Subject: Re: [PATCH v5 06/23] target/loongarch: add definition about guest
 mmu_idx
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1791514848.git.prcups@krgm.moe>
 <59b45ba32b5b18dad94f39b0a9047a5d36812ead.1791514848.git.prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <688d4993-d5a6-87fb-c578-cb6a4dc6416d@loongson.cn>
Date: Sat, 10 Oct 2026 11:36:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <59b45ba32b5b18dad94f39b0a9047a5d36812ead.1791514848.git.prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxTs9esslq0bgqAA--.24824S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF48WFWkXF48ur1fCFW5XFc_yoW5trWxpr
 W7CF18KFW8KrZ7Ja4fX3y5Arn8Zr1fGw4I9a43Kr93CFZxXr18Zr1Fg39IgF4rJa18WryI
 qa1vkrWUCFW8XacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_Ma
 UUUUU
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
> Add MMU_GUEST_IDX and MMU_GUEST_DA_IDX. Provide is_guest_mmu idx() and
> mmu_idx_to_plv to calculate plv with new mmu_idx.
> 
> Signed-off-by: SignKirigami <prcups@krgm.moe>
> Signed-off-by: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
> ---
>   target/loongarch/cpu.h                         | 18 ++++++++++++++++++
>   .../tcg/insn_trans/trans_privileged.c.inc      |  2 +-
>   target/loongarch/tcg/tcg_cpu.c                 |  7 +++++++
>   target/loongarch/tcg/translate.c               |  3 +++
>   4 files changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
> index 183210efd8..9eea1badaf 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -513,6 +513,24 @@ struct LoongArchCPUClass {
>   #define MMU_KERNEL_IDX   MMU_PLV_KERNEL
>   #define MMU_USER_IDX     MMU_PLV_USER
>   #define MMU_DA_IDX       4
> +#define MMU_GUEST_IDX    5
> +#define MMU_GUEST_DA_IDX 9
how about replace constant 9 with (MMU_DA_IDX + MMU_GUEST_DA_IDX).

> +
> +static inline bool is_guest_mmu_idx(int mmu_idx)
> +{
> +    return mmu_idx >= MMU_GUEST_IDX;
> +}
> +
> +static inline int mmu_idx_to_plv(int mmu_idx)
> +{
> +    if (mmu_idx == MMU_DA_IDX || mmu_idx == MMU_GUEST_DA_IDX) {
> +        return 0;
> +    }
> +    if (is_guest_mmu_idx(mmu_idx)) {
> +        return mmu_idx - MMU_GUEST_IDX;
> +    }
> +    return mmu_idx;
> +}
>   
>   static inline CPUSysState *env_sys(CPULoongArchState *env)
>   {
> diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> index 6728ce5ec9..7ee3bb8e27 100644
> --- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> @@ -249,7 +249,7 @@ TRANS64(iocsrwr_d, IOCSR, gen_iocsrwr, gen_helper_iocsrwr_d)
>   
>   static void check_mmu_idx(DisasContext *ctx)
>   {
> -    if (ctx->mem_idx != MMU_DA_IDX) {
> +    if (ctx->mem_idx != MMU_DA_IDX && ctx->mem_idx != MMU_GUEST_DA_IDX) {
>           tcg_gen_movi_tl(cpu_pc, ctx->base.pc_next + 4);
>           ctx->base.is_jmp = DISAS_EXIT;
>       }
> diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
> index 14fa5f5809..b60d9e7cf8 100644
> --- a/target/loongarch/tcg/tcg_cpu.c
> +++ b/target/loongarch/tcg/tcg_cpu.c
> @@ -309,6 +309,13 @@ static int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch)
>       CPULoongArchState *env = cpu_env(cs);
>       CPUSysState *sys = env_sys(env);
>   
> +    if (env_vm_level(env) == VM_LEVEL1) {
> +        if (FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PG)) {
> +            return MMU_GUEST_IDX + FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PLV);
> +        }
> +        return MMU_GUEST_DA_IDX;
> +    }
> +
>       if (FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PG)) {
>           return FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PLV);
>       }
> diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
> index 124dce6269..4ab06b48da 100644
> --- a/target/loongarch/tcg/translate.c
> +++ b/target/loongarch/tcg/translate.c
> @@ -129,6 +129,9 @@ static void loongarch_tr_init_disas_context(DisasContextBase *dcbase,
>       } else {
>           ctx->mem_idx = MMU_DA_IDX;
>       }
> +    if (ctx->base.tb->flags & HW_FLAGS_GUEST_MODE) {
> +        ctx->mem_idx += MMU_GUEST_IDX;
> +    }
>   
>       /* Bound the number of insns to execute to those left on the page.  */
>       bound = -(ctx->base.pc_first | TARGET_PAGE_MASK) / 4;
> 


