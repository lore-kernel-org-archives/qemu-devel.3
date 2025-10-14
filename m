Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1A0CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 09:18:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8bAv-0006le-6e; Tue, 14 Oct 2025 05:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1v8bAs-0006l9-Us
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:18:31 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1v8bAm-0001gP-HY
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:18:30 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Dxb_BeFe5oLvQVAA--.47516S3;
 Tue, 14 Oct 2025 17:18:22 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJDx6sBcFe5o+1LhAA--.16597S3;
 Tue, 14 Oct 2025 17:18:21 +0800 (CST)
Subject: Re: [PATCH 4/4] target/loongarch: Do not use target_ulong type for
 LDDIR level
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson
 <anjo@rev.ng>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20251009201947.34643-1-philmd@linaro.org>
 <20251009201947.34643-5-philmd@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <4ef3db81-7835-23c0-8491-92fbe4a3bb75@loongson.cn>
Date: Tue, 14 Oct 2025 17:18:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20251009201947.34643-5-philmd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJDx6sBcFe5o+1LhAA--.16597S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXr1rtFWUKrWftF1UAw45CFX_yoWrXr4Upr
 W7Cr45tF48GrZ7J3Z7Xa4YqF1DZw13Kw42va1ftryF9a13Xr97Xr1kt39F9F18JayUWr4Y
 q3ZYyw1UZFW8X3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
 xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07josjUU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.658,
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

在 2025/10/10 上午4:19, Philippe Mathieu-Daudé 写道:
> The LDDIR level page table is a 5-bit immediate. Using the
> uint32_t type for it is sufficient. Avoid the target_ulong type.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/loongarch/cpu-mmu.h                             | 2 +-
>   target/loongarch/tcg/helper.h                          | 2 +-
>   target/loongarch/cpu_helper.c                          | 2 +-
>   target/loongarch/tcg/tlb_helper.c                      | 4 ++--
>   target/loongarch/tcg/insn_trans/trans_privileged.c.inc | 2 +-
>   5 files changed, 6 insertions(+), 6 deletions(-)
Signed-off-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/target/loongarch/cpu-mmu.h b/target/loongarch/cpu-mmu.h
> index 0068d22efcb..dbc69c7c0f2 100644
> --- a/target/loongarch/cpu-mmu.h
> +++ b/target/loongarch/cpu-mmu.h
> @@ -34,7 +34,7 @@ TLBRet get_physical_address(CPULoongArchState *env, MMUContext *context,
>                               MMUAccessType access_type, int mmu_idx,
>                               int is_debug);
>   void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
> -                               uint64_t *dir_width, target_ulong level);
> +                        uint64_t *dir_width, unsigned int level);
>   hwaddr loongarch_cpu_get_phys_page_debug(CPUState *cpu, vaddr addr);
>   
>   #endif  /* LOONGARCH_CPU_MMU_H */
> diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
> index db57dbfc167..7e508c5a7b9 100644
> --- a/target/loongarch/tcg/helper.h
> +++ b/target/loongarch/tcg/helper.h
> @@ -129,7 +129,7 @@ DEF_HELPER_2(invtlb_all_asid, void, env, tl)
>   DEF_HELPER_3(invtlb_page_asid, void, env, tl, tl)
>   DEF_HELPER_3(invtlb_page_asid_or_g, void, env, tl, tl)
>   
> -DEF_HELPER_4(lddir, tl, env, tl, tl, i32)
> +DEF_HELPER_4(lddir, tl, env, tl, i32, i32)
>   DEF_HELPER_4(ldpte, void, env, tl, tl, i32)
>   DEF_HELPER_1(ertn, void, env)
>   DEF_HELPER_1(idle, void, env)
> diff --git a/target/loongarch/cpu_helper.c b/target/loongarch/cpu_helper.c
> index 4a9db3ea4c1..867e7c88670 100644
> --- a/target/loongarch/cpu_helper.c
> +++ b/target/loongarch/cpu_helper.c
> @@ -17,7 +17,7 @@
>   #include "tcg/tcg_loongarch.h"
>   
>   void get_dir_base_width(CPULoongArchState *env, uint64_t *dir_base,
> -                        uint64_t *dir_width, target_ulong level)
> +                        uint64_t *dir_width, unsigned int level)
>   {
>       switch (level) {
>       case 1:
> diff --git a/target/loongarch/tcg/tlb_helper.c b/target/loongarch/tcg/tlb_helper.c
> index 8cfce48a297..f85b68fa53d 100644
> --- a/target/loongarch/tcg/tlb_helper.c
> +++ b/target/loongarch/tcg/tlb_helper.c
> @@ -595,7 +595,7 @@ bool loongarch_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>   }
>   
>   target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
> -                          target_ulong level, uint32_t mem_idx)
> +                          uint32_t level, uint32_t mem_idx)
>   {
>       CPUState *cs = env_cpu(env);
>       target_ulong badvaddr, index, phys;
> @@ -603,7 +603,7 @@ target_ulong helper_lddir(CPULoongArchState *env, target_ulong base,
>   
>       if (unlikely((level == 0) || (level > 4))) {
>           qemu_log_mask(LOG_GUEST_ERROR,
> -                      "Attepted LDDIR with level %"PRId64"\n", level);
> +                      "Attepted LDDIR with level %u\n", level);
>           return base;
>       }
>   
> diff --git a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> index a407ab51b74..64e53a44606 100644
> --- a/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> +++ b/target/loongarch/tcg/insn_trans/trans_privileged.c.inc
> @@ -380,7 +380,7 @@ static bool trans_lddir(DisasContext *ctx, arg_lddir *a)
>       if (check_plv(ctx)) {
>           return false;
>       }
> -    gen_helper_lddir(dest, tcg_env, src, tcg_constant_tl(a->imm), mem_idx);
> +    gen_helper_lddir(dest, tcg_env, src, tcg_constant_i32(a->imm), mem_idx);
>       return true;
>   }
>   


