Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF95606A333
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 02:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVKBR-0006HK-6U; Sun, 22 Nov 2026 21:53:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xVKBL-0006H7-Re
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 21:53:27 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xVKBI-0001h5-Ow
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 21:53:27 -0500
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8DxztCdqgNrDRkiAA--.7216S3;
 Mon, 23 Nov 2026 10:53:17 +0800 (CST)
Received: from [127.0.0.1] (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJDxxMydqgNrScU2AA--.16939S2;
 Mon, 23 Nov 2026 10:53:17 +0800 (CST)
Subject: Re: [PATCH v6 05/26] target/loongarch: add definition about guest
 mmu_idx
To: SignKirigami <prcups@krgm.moe>, qemu-devel@nongnu.org
Cc: Hengyu Yu <yuhengyu25@mails.ucas.ac.cn>
References: <cover.1794558695.git.prcups@krgm.moe>
 <455f9e7061ffb73d3bb9ef9b43bc1029e9ac145b.1794558695.git.prcups@krgm.moe>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <9408f0df-83e4-6a6e-9361-3e93b1df74a6@loongson.cn>
Date: Mon, 23 Nov 2026 10:54:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <455f9e7061ffb73d3bb9ef9b43bc1029e9ac145b.1794558695.git.prcups@krgm.moe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxxMydqgNrScU2AA--.16939S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxArW3tFWrJF15CFy3Xr4kXwc_yoWrZF47pr
 y8CFyUKF1UKrZ7Jw1fX343Ar45Xrn3Gw4I9a43Kr93AFZxXr18Zr1Fgrn09F4rJ3W8WryI
 qa1kCF4UCFy8XagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
 wI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
 WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUclAp
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
> index ff22cde702..14316fc9c5 100644
> --- a/target/loongarch/cpu.h
> +++ b/target/loongarch/cpu.h
> @@ -516,6 +516,24 @@ struct LoongArchCPUClass {
>   #define MMU_KERNEL_IDX   MMU_PLV_KERNEL
>   #define MMU_USER_IDX     MMU_PLV_USER
>   #define MMU_DA_IDX       4
> +#define MMU_GUEST_IDX    5
> +#define MMU_GUEST_DA_IDX (MMU_GUEST_IDX + MMU_DA_IDX)
how about something like this:
#define MMU_GUEST_IDX_BASE    5
#define MMU_GUEST_KERNEL_IDX  (MMU_GUEST_IDX_BASE + MMU_PLV_KERNEL)
#define MMU_GUEST_USER_IDX    (MMU_GUEST_IDX_BASE + MMU_PLV_USER)
#define MMU_GUEST_DA_IDX      (MMU_GUEST_IDX_BASE + MMU_DA_IDX)

> +
> +static inline int mmu_idx_vm_level(int mmu_idx)
> +{
> +    return mmu_idx >= MMU_GUEST_IDX;
how about return "mmu_idx / MMU_GUEST_IDX_BASE" to support nest VM in 
future?
> +}
> +
> +static inline int mmu_idx_to_plv(int mmu_idx)
> +{
> +    if (mmu_idx == MMU_DA_IDX || mmu_idx == MMU_GUEST_DA_IDX) {
> +        return 0;
> +    }
> +    if (mmu_idx_vm_level(mmu_idx)) {
> +        return mmu_idx - MMU_GUEST_IDX;
> +    }
how about something like this:
     mmu_idx = mmu_idx % MMU_GUEST_IDX_BASE;
     if (mmu_idx == MMU_DA_IDX) {
         return 0;
     }

     return mmu_idx;
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
> index c2792c8db1..7babc1a1f9 100644
> --- a/target/loongarch/tcg/tcg_cpu.c
> +++ b/target/loongarch/tcg/tcg_cpu.c
> @@ -269,6 +269,13 @@ static int loongarch_cpu_mmu_index(CPUState *cs, bool ifetch)
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
how about something like this?
+    int mmu_idx;

      if (FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PG)) {
-        return FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PLV);
+        mmu_idx = FIELD_EX64(sys->CSR_CRMD, CSR_CRMD, PLV);
      }
-    return MMU_DA_IDX;
+    mmu_idx = MMU_DA_IDX;
+
+    return mmu_idx + env_vm_level(env) * MMU_GUEST_IDX_BASE;
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
how about something like this
        ctx->mem_idx += MMU_GUEST_IDX_BASE * (ctx->base.tb->flags >> 
HW_FLAGS_GUEST_MODE);

In general, I think "vm_level with int type" is better than guest_mode 
with bool type.

Regards
Bibo Mao
>   
>       /* Bound the number of insns to execute to those left on the page.  */
>       bound = -(ctx->base.pc_first | TARGET_PAGE_MASK) / 4;
> 


