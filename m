Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC92C52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 02:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbWaH-0008BF-I3; Tue, 06 Aug 2024 22:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbWaG-00089u-Gc
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 22:39:28 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbWaD-0003XO-U1
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 22:39:28 -0400
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3db23a60850so812692b6e.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 19:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722998363; x=1723603163; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZEL44PdqXW112ScjhCJ0zFIyC5Fctui0PiefUm92gWw=;
 b=VwNGOndFUgdYhXGwC3gCOQ0MVAWM7KZNV+BC8t2z0UdYQmo8Hsp5Gk93/7ePO1kBL4
 O/xKQ7rnm6QjlBYwPVXLBYJNnSTSDRJ5H5ZUGvUjeNZLjIY1Qfsf8UCAxAqjn/e1W7Jy
 5udbZZ7dRbuprlK0Qzc4WvFu+hFQH9irjqaBPacGCuYtxBq5B5JwjVofjuvrlxRhLWeW
 TNwiSdx/Vw+X7WHz4kOAmOVBLNo/aHI1CCStXxeQUBI0ZNxMn4cetwJsrynO+b13nkpF
 8EmAx+G0YwVQc3eNa9r9wlE2xNVoqx9Kd4CkEqB35B8bsVDL5Rxl6wr/aGa4vzN1zvjz
 jtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722998363; x=1723603163;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZEL44PdqXW112ScjhCJ0zFIyC5Fctui0PiefUm92gWw=;
 b=gXnZZVkssB8dE/4OpHIAtTV+SFqdPfsbHDGNRKQgMy/1WtSHKfZ33qR6/Sae8hQqaq
 hMxi3lxdTIdRPI7ooSEaMT53b2zH6Z9xSmGGKxfcTWaUTgcYQVFE+9Z8seFCCyk5c5fV
 ALyZZggLrupmrN/1ZMEiSvoMTk7mNro/T4fPrd8yRC6PuFvHHPfA6RkkVeLaw+6NNgtP
 0s5EL9J0wuM48QUdEYLSFEBRR3XpraQdAcKUmqxAyiyHf+3FAve3lncgw/nsWW++qoK1
 w2QYKtDhPiZQ8Ag6wjluvA0nVDyO1+urDxzf1ry7CC82JbZoGJUD7mBZJrfY9Rodze0e
 kpBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOFAnuwWIAxVC+gA3zxYrSaCjZI3l01h0RFrYi3QPE9YOZ49DB6kip/vmud4RWRNZxu/6AuPfvmDSnOgO9qIA1ElXwARs=
X-Gm-Message-State: AOJu0Yw3lklIk7ziauh7M8LFNQEpgW8IOWGw34pCguHDfDin8aXaD4um
 iGoNb7GNXyOWv+cNol+832skuoQJ2+dEloFIReI82VeOiWcDWC1USjIT3B/zVAY=
X-Google-Smtp-Source: AGHT+IF5O05Y/VlpYusBUeFR4wMZ0allQ0B/GZMW8tceQu/YdZELPCIc+GD3igxoZRQecMm8usWG1A==
X-Received: by 2002:a05:6870:b6a3:b0:261:1339:1cb9 with SMTP id
 586e51a60fabf-26891eb200bmr21662164fac.35.1722998363470; 
 Tue, 06 Aug 2024 19:39:23 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:e01b:92e5:d779:1bc0?
 (2403-580a-f89b-0-e01b-92e5-d779-1bc0.ip6.aussiebb.net.
 [2403:580a:f89b:0:e01b:92e5:d779:1bc0])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ed0d43asm7766845b3a.143.2024.08.06.19.39.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 19:39:22 -0700 (PDT)
Message-ID: <199f7ee2-411c-48ec-bf69-34fceab8f48a@linaro.org>
Date: Wed, 7 Aug 2024 12:39:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/20] target/riscv: implement zicfiss instructions
To: Deepak Gupta <debug@rivosinc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: pbonzini@redhat.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 laurent@vivier.eu, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Jim Shu <jim.shu@sifive.com>, Andy Chiu <andy.chiu@sifive.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-13-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240807000652.1417776-13-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/7/24 10:06, Deepak Gupta wrote:
> zicfiss has following instructions
>   - sspopchk: pops a value from shadow stack and compares with x1/x5.
>     If they dont match, reports a sw check exception with tval = 3.
>   - sspush: pushes value in x1/x5 on shadow stack
>   - ssrdp: reads current shadow stack
>   - ssamoswap: swaps contents of shadow stack atomically
> 
> sspopchk/sspush/ssrdp default to zimop if zimop implemented and SSE=0
> 
> If SSE=0, ssamoswap is illegal instruction exception.
> 
> This patch implements shadow stack operations for qemu-user and shadow
> stack is not protected.
> 
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> Co-developed-by: Jim Shu <jim.shu@sifive.com>
> Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
> ---
>   target/riscv/cpu_bits.h                       |   2 +
>   target/riscv/insn32.decode                    |  17 +-
>   target/riscv/insn_trans/trans_rva.c.inc       |  47 ++++++
>   target/riscv/insn_trans/trans_rvzicfiss.c.inc | 149 ++++++++++++++++++
>   target/riscv/translate.c                      |   1 +
>   5 files changed, 214 insertions(+), 2 deletions(-)
>   create mode 100644 target/riscv/insn_trans/trans_rvzicfiss.c.inc
> 
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 226157896d..5ebc4dd5b3 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -702,6 +702,8 @@ typedef enum RISCVException {
>   
>   /* zicfilp defines lp violation results in sw check with tval = 2*/
>   #define RISCV_EXCP_SW_CHECK_FCFI_TVAL      2
> +/* zicfiss defines ss violation results in sw check with tval = 3*/
> +#define RISCV_EXCP_SW_CHECK_BCFI_TVAL      3
>   
>   #define RISCV_EXCP_INT_FLAG                0x80000000
>   #define RISCV_EXCP_INT_MASK                0x7fffffff
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index c963c59c8e..c59c992ce2 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -65,8 +65,10 @@
>   # Formats 32:
>   @r       .......   ..... ..... ... ..... ....... &r                %rs2 %rs1 %rd
>   @i       ............    ..... ... ..... ....... &i      imm=%imm_i     %rs1 %rd
> +@ss_pop  ............    ..... ... ..... ....... &i      imm=0 %rs1 rd=0
>   @b       .......   ..... ..... ... ..... ....... &b      imm=%imm_b %rs2 %rs1
>   @s       .......   ..... ..... ... ..... ....... &s      imm=%imm_s %rs2 %rs1
> +@ss_push .......   ..... ..... ... ..... ....... &s      imm=0 %rs2 rs1=0

No need for single-use formats, or even forcing them into specific argument sets.

> +{
> +  # zicfiss instructions carved out of mop.r
> +  ssrdp      1100110 11100     00000 100 ..... 1110011 %rd
> +  sspopchk   1100110 11100     ..... 100 00000 1110011 @ss_pop

You can check x1/x5 here:

{
   [
     ssrdp     1100110 111000 00000 100 rd:5  1110011
     sspopchk  1100110 111000 00001 100 00000 1110011  rs1=1
     sspopchk  1100110 111000 00101 100 00000 1110011  rs1=5
   ]
   mop_r_n ...
}

which will make things easier for the next insn carved out of mop_r_n.


> diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
> index 39bbf60f3c..db6c03f6a8 100644
> --- a/target/riscv/insn_trans/trans_rva.c.inc
> +++ b/target/riscv/insn_trans/trans_rva.c.inc
> @@ -18,6 +18,8 @@
>    * this program.  If not, see <http://www.gnu.org/licenses/>.
>    */
>   
> +#include "exec/memop.h"
> +
>   #define REQUIRE_A_OR_ZAAMO(ctx) do {                      \
>       if (!ctx->cfg_ptr->ext_zaamo && !has_ext(ctx, RVA)) { \
>           return false;                                     \
> @@ -114,6 +116,28 @@ static bool trans_amoswap_w(DisasContext *ctx, arg_amoswap_w *a)
>       return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TESL);
>   }
>   
> +static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
> +{
> +    REQUIRE_A_OR_ZAAMO(ctx);
> +    /* default for qemu-user, use regular RW memory and thus mmu_idx=0 */
> +    int ss_mmu_idx = 0;
> +
> +    /* back cfi was not enabled, return false */
> +    if (!ctx->bcfi_enabled) {
> +        return false;
> +    }
> +
> +    TCGv dest = dest_gpr(ctx, a->rd);
> +    TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
> +
> +    decode_save_opc(ctx);
> +    src1 = get_address(ctx, a->rs1, 0);
> +
> +    tcg_gen_atomic_xchg_tl(dest, src1, src2, ss_mmu_idx, (MO_ALIGN | MO_TESL));
> +    gen_set_gpr(ctx, a->rd, dest);
> +    return true;
> +}
> +
>   static bool trans_amoadd_w(DisasContext *ctx, arg_amoadd_w *a)
>   {
>       REQUIRE_A_OR_ZAAMO(ctx);
> @@ -183,6 +207,29 @@ static bool trans_amoswap_d(DisasContext *ctx, arg_amoswap_d *a)
>       return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TEUQ);
>   }
>   
> +static bool trans_ssamoswap_d(DisasContext *ctx, arg_amoswap_w *a)
> +{
> +    REQUIRE_64BIT(ctx);
> +    REQUIRE_A_OR_ZAAMO(ctx);
> +    /* default for qemu-user, use regular RW memory and thus mmu_idx=0 */
> +    int ss_mmu_idx = 0;
> +
> +    /* back cfi was not enabled, return false */
> +    if (!ctx->bcfi_enabled) {
> +        return false;
> +    }
> +
> +    TCGv dest = dest_gpr(ctx, a->rd);
> +    TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
> +
> +    decode_save_opc(ctx);
> +    src1 = get_address(ctx, a->rs1, 0);
> +
> +    tcg_gen_atomic_xchg_tl(dest, src1, src2, ss_mmu_idx, (MO_ALIGN | MO_TESQ));
> +    gen_set_gpr(ctx, a->rd, dest);
> +    return true;
> +}

Why are these in trans_rva.c.inc instead of in trans_rvzicfiss.c.inc?

> +static MemOp mxl_memop(DisasContext *ctx)
> +{
> +    switch (get_xl(ctx)) {
> +    case MXL_RV32:
> +        return MO_TEUL;
> +
> +    case MXL_RV64:
> +        return MO_TEUQ;
> +
> +    case MXL_RV128:
> +        return MO_TEUO;
> +
> +    default:
> +        g_assert_not_reached();
> +    }
> +}

This should be

   return get_xl(ctx) + 1) | MO_TE;

and probably placed next to get_xlen() et al.

> +
> +static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
> +{
> +    /* default for qemu-user, use regular RW memory and thus mmu_idx=0 */
> +    int ss_mmu_idx = 0;

This can't be right, since 0 is M_MODE.

> +
> +    /* sspopchk only supported on 32bit and 64bit */
> +    if (get_xl(ctx) != MXL_RV32 && get_xl(ctx) != MXL_RV64) {
> +        return false;
> +    }

Again, where is this prohibited?  Even if your implementation doesn't allow RV128 (as 
certainly it would be a separate code path here) this should be checked at startup, not 
all over the implementation.

> +    /*
> +     * get data in TCGv using get_gpr
> +     * get addr in TCGv using gen_helper_csrr on CSR_SSP
> +     * use some tcg subtract arithmetic (subtract by XLEN) on addr
> +     * perform ss store on computed address
> +     */
> +
> +    TCGv addr = tcg_temp_new();
> +    TCGLabel *skip = gen_new_label();
> +    uint32_t tmp = (get_xl(ctx) == MXL_RV64) ? 8 : 4;
> +    TCGv_i32 ssp_csr = tcg_constant_i32(CSR_SSP);
> +    TCGv data = tcg_temp_new();
> +    gen_helper_csrr(addr, tcg_env, ssp_csr);

I think you can skip the helper.  You've just validated the extension is enabled:

   tcg_gen_ld_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));

> +    TCGv rs1 = get_gpr(ctx, a->rs1, EXT_NONE);
> +    tcg_gen_brcond_tl(TCG_COND_EQ, data, rs1, skip);
> +    gen_helper_raise_sw_check_excep(tcg_env,
> +        tcg_constant_tl(RISCV_EXCP_SW_CHECK_BCFI_TVAL), data, rs1);
> +    gen_set_label(skip);
> +    tcg_gen_addi_tl(addr, addr, tmp);
> +    gen_helper_csrw(tcg_env, ssp_csr, addr);

   tcg_gen_st_tl(addr, tcg_env, ...);

> +static bool trans_sspush(DisasContext *ctx, arg_sspush *a)

Same comments apply.


r~

