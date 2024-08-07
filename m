Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD5BC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 20:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbnNf-0006nr-1t; Wed, 07 Aug 2024 16:35:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbnNW-0006J2-7j
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 16:35:27 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sbnNS-00081y-5g
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 16:35:24 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70d1d6369acso975469b3a.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 13:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723062919; x=1723667719;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DKr93pR1XK5BA1tKwYwaK+nfrLrIfwiMYTLLLKDiWho=;
 b=bNfaLUOh6hvu3kA1O0FOIQ+wVF5UrmqKvJlk7V6gIMXbvrGC5UYN9xszVzgMGrAQ9x
 fODI8MhvwaPRg4xn1H2R9nbsOcqWrpgFu/IzvPIuxQixM2giM08PiSvmabohtk8P4/MY
 CDu/S98dmCpZMvPYpNs2Lhu3fVUDTmyzx7LhzJUZdMPbbNjLN1pOBklRbUx7lOfZzYm2
 m3bxyx6Pxl9rHGApiWhCKad8FWEDv82L5pLA4ur0+cmrGYRvJiimd0jbVJVrrFzcJR9u
 Uh7J1RNH/C6jfYHC5BfXNVJsmGPiCKOxtB7BmNfxAvFf026AwPl+TDTcmNwF6BAbDibc
 bWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723062919; x=1723667719;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DKr93pR1XK5BA1tKwYwaK+nfrLrIfwiMYTLLLKDiWho=;
 b=BIF7sXqiLmy8AMM9FF9jNPas8/pLJIWva/aCBicPpoiOGVyrWflcVugPIM6m0rnWXv
 Xm+WxbGzKbxqXFtVD6D8w9af6SKeGfIWPr7cnaw+2cpyWtRx54RynJasTKrTZ75S51j1
 TbRI7jMDkn4KK9+/vAoCvvOO5oACHVrQEB4I72y60nTcE8YazFLKe6kayFw1vAmbbxWA
 j1jaToLA5P8Ck0s/3t97vS9naHnL3qe898gaLKY19lzJuIbKdwggzum/0ItcUA0+BPbk
 3YMwuxwKmcze4T/yMNyDktCMlOGeIGRTfFocaxgcDEujIz4VeXMEv2+45kEwq8JBndsw
 0r1Q==
X-Gm-Message-State: AOJu0YxfPToBNE4Ec7Cgsi9FreaLphf7Sy2A6C2GpZZYhISAkk1HdRoi
 NSOJH6IXIpfO20oiPEj4TCvcK4eKlIYMXzv/zPHMwijD5U/atcNUl6BvDXPJulA=
X-Google-Smtp-Source: AGHT+IH0vumHwQ9ZcNmBFLyA1j7OFcc8tGbwjVenn22g/qHFRDxdUZMn0+kHnT2IdJj30+W3gwl5Fg==
X-Received: by 2002:a05:6a00:91c5:b0:70e:cf2a:4503 with SMTP id
 d2e1a72fcca58-710bc95738fmr5623486b3a.11.1723062919294; 
 Wed, 07 Aug 2024 13:35:19 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7106ec73aedsm9055796b3a.90.2024.08.07.13.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 13:35:18 -0700 (PDT)
Date: Wed, 7 Aug 2024 13:35:16 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Jim Shu <jim.shu@sifive.com>,
 Andy Chiu <andy.chiu@sifive.com>
Subject: Re: [PATCH v3 12/20] target/riscv: implement zicfiss instructions
Message-ID: <ZrPahK85WquFOM51@debug.ba.rivosinc.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-13-debug@rivosinc.com>
 <199f7ee2-411c-48ec-bf69-34fceab8f48a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <199f7ee2-411c-48ec-bf69-34fceab8f48a@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=debug@rivosinc.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Aug 07, 2024 at 12:39:15PM +1000, Richard Henderson wrote:
>On 8/7/24 10:06, Deepak Gupta wrote:
>>zicfiss has following instructions
>>  - sspopchk: pops a value from shadow stack and compares with x1/x5.
>>    If they dont match, reports a sw check exception with tval = 3.
>>  - sspush: pushes value in x1/x5 on shadow stack
>>  - ssrdp: reads current shadow stack
>>  - ssamoswap: swaps contents of shadow stack atomically
>>
>>sspopchk/sspush/ssrdp default to zimop if zimop implemented and SSE=0
>>
>>If SSE=0, ssamoswap is illegal instruction exception.
>>
>>This patch implements shadow stack operations for qemu-user and shadow
>>stack is not protected.
>>
>>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>Co-developed-by: Jim Shu <jim.shu@sifive.com>
>>Co-developed-by: Andy Chiu <andy.chiu@sifive.com>
>>---
>>  target/riscv/cpu_bits.h                       |   2 +
>>  target/riscv/insn32.decode                    |  17 +-
>>  target/riscv/insn_trans/trans_rva.c.inc       |  47 ++++++
>>  target/riscv/insn_trans/trans_rvzicfiss.c.inc | 149 ++++++++++++++++++
>>  target/riscv/translate.c                      |   1 +
>>  5 files changed, 214 insertions(+), 2 deletions(-)
>>  create mode 100644 target/riscv/insn_trans/trans_rvzicfiss.c.inc
>>
>>diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
>>index 226157896d..5ebc4dd5b3 100644
>>--- a/target/riscv/cpu_bits.h
>>+++ b/target/riscv/cpu_bits.h
>>@@ -702,6 +702,8 @@ typedef enum RISCVException {
>>  /* zicfilp defines lp violation results in sw check with tval = 2*/
>>  #define RISCV_EXCP_SW_CHECK_FCFI_TVAL      2
>>+/* zicfiss defines ss violation results in sw check with tval = 3*/
>>+#define RISCV_EXCP_SW_CHECK_BCFI_TVAL      3
>>  #define RISCV_EXCP_INT_FLAG                0x80000000
>>  #define RISCV_EXCP_INT_MASK                0x7fffffff
>>diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
>>index c963c59c8e..c59c992ce2 100644
>>--- a/target/riscv/insn32.decode
>>+++ b/target/riscv/insn32.decode
>>@@ -65,8 +65,10 @@
>>  # Formats 32:
>>  @r       .......   ..... ..... ... ..... ....... &r                %rs2 %rs1 %rd
>>  @i       ............    ..... ... ..... ....... &i      imm=%imm_i     %rs1 %rd
>>+@ss_pop  ............    ..... ... ..... ....... &i      imm=0 %rs1 rd=0
>>  @b       .......   ..... ..... ... ..... ....... &b      imm=%imm_b %rs2 %rs1
>>  @s       .......   ..... ..... ... ..... ....... &s      imm=%imm_s %rs2 %rs1
>>+@ss_push .......   ..... ..... ... ..... ....... &s      imm=0 %rs2 rs1=0
>
>No need for single-use formats, or even forcing them into specific argument sets.
>

Noted.

>>+{
>>+  # zicfiss instructions carved out of mop.r
>>+  ssrdp      1100110 11100     00000 100 ..... 1110011 %rd
>>+  sspopchk   1100110 11100     ..... 100 00000 1110011 @ss_pop
>
>You can check x1/x5 here:
>
>{
>  [
>    ssrdp     1100110 111000 00000 100 rd:5  1110011
>    sspopchk  1100110 111000 00001 100 00000 1110011  rs1=1
>    sspopchk  1100110 111000 00101 100 00000 1110011  rs1=5
>  ]
>  mop_r_n ...
>}
>
>which will make things easier for the next insn carved out of mop_r_n.
>

Will fix as you suggesting.

>
>>diff --git a/target/riscv/insn_trans/trans_rva.c.inc b/target/riscv/insn_trans/trans_rva.c.inc
>>index 39bbf60f3c..db6c03f6a8 100644
>>--- a/target/riscv/insn_trans/trans_rva.c.inc
>>+++ b/target/riscv/insn_trans/trans_rva.c.inc
>>@@ -18,6 +18,8 @@
>>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>>   */
>>+#include "exec/memop.h"
>>+
>>  #define REQUIRE_A_OR_ZAAMO(ctx) do {                      \
>>      if (!ctx->cfg_ptr->ext_zaamo && !has_ext(ctx, RVA)) { \
>>          return false;                                     \
>>@@ -114,6 +116,28 @@ static bool trans_amoswap_w(DisasContext *ctx, arg_amoswap_w *a)
>>      return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TESL);
>>  }
>>+static bool trans_ssamoswap_w(DisasContext *ctx, arg_amoswap_w *a)
>>+{
>>+    REQUIRE_A_OR_ZAAMO(ctx);
>>+    /* default for qemu-user, use regular RW memory and thus mmu_idx=0 */
>>+    int ss_mmu_idx = 0;
>>+
>>+    /* back cfi was not enabled, return false */
>>+    if (!ctx->bcfi_enabled) {
>>+        return false;
>>+    }
>>+
>>+    TCGv dest = dest_gpr(ctx, a->rd);
>>+    TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
>>+
>>+    decode_save_opc(ctx);
>>+    src1 = get_address(ctx, a->rs1, 0);
>>+
>>+    tcg_gen_atomic_xchg_tl(dest, src1, src2, ss_mmu_idx, (MO_ALIGN | MO_TESL));
>>+    gen_set_gpr(ctx, a->rd, dest);
>>+    return true;
>>+}
>>+
>>  static bool trans_amoadd_w(DisasContext *ctx, arg_amoadd_w *a)
>>  {
>>      REQUIRE_A_OR_ZAAMO(ctx);
>>@@ -183,6 +207,29 @@ static bool trans_amoswap_d(DisasContext *ctx, arg_amoswap_d *a)
>>      return gen_amo(ctx, a, &tcg_gen_atomic_xchg_tl, MO_TEUQ);
>>  }
>>+static bool trans_ssamoswap_d(DisasContext *ctx, arg_amoswap_w *a)
>>+{
>>+    REQUIRE_64BIT(ctx);
>>+    REQUIRE_A_OR_ZAAMO(ctx);
>>+    /* default for qemu-user, use regular RW memory and thus mmu_idx=0 */
>>+    int ss_mmu_idx = 0;
>>+
>>+    /* back cfi was not enabled, return false */
>>+    if (!ctx->bcfi_enabled) {
>>+        return false;
>>+    }
>>+
>>+    TCGv dest = dest_gpr(ctx, a->rd);
>>+    TCGv src1, src2 = get_gpr(ctx, a->rs2, EXT_NONE);
>>+
>>+    decode_save_opc(ctx);
>>+    src1 = get_address(ctx, a->rs1, 0);
>>+
>>+    tcg_gen_atomic_xchg_tl(dest, src1, src2, ss_mmu_idx, (MO_ALIGN | MO_TESQ));
>>+    gen_set_gpr(ctx, a->rd, dest);
>>+    return true;
>>+}
>
>Why are these in trans_rva.c.inc instead of in trans_rvzicfiss.c.inc?

encodings are coming out of existing unused atomics and this is why zicfiss is dependent on 
'A' extension.

Although if shadow stack are not enabled for the execution environment then it should be
illegal instruction.

I am fine placing it in trans_rvzicfiss.c.inc as well. Let me know.
>
>>+static MemOp mxl_memop(DisasContext *ctx)
>>+{
>>+    switch (get_xl(ctx)) {
>>+    case MXL_RV32:
>>+        return MO_TEUL;
>>+
>>+    case MXL_RV64:
>>+        return MO_TEUQ;
>>+
>>+    case MXL_RV128:
>>+        return MO_TEUO;
>>+
>>+    default:
>>+        g_assert_not_reached();
>>+    }
>>+}
>
>This should be
>
>  return get_xl(ctx) + 1) | MO_TE;
>
>and probably placed next to get_xlen() et al.

Noted.

>
>>+
>>+static bool trans_sspopchk(DisasContext *ctx, arg_sspopchk *a)
>>+{
>>+    /* default for qemu-user, use regular RW memory and thus mmu_idx=0 */
>>+    int ss_mmu_idx = 0;
>
>This can't be right, since 0 is M_MODE.

This is 0 only when qemu-user.
If not qemu-user, its obtained differently.

>
>>+
>>+    /* sspopchk only supported on 32bit and 64bit */
>>+    if (get_xl(ctx) != MXL_RV32 && get_xl(ctx) != MXL_RV64) {
>>+        return false;
>>+    }
>
>Again, where is this prohibited?  Even if your implementation doesn't 
>allow RV128 (as certainly it would be a separate code path here) this 
>should be checked at startup, not all over the implementation.
>

It's a left over from when I was starting out and didn't know a lot on qemu (still don't :-))
and RISC-V.

Will remove this and at other places as well.

>>+    /*
>>+     * get data in TCGv using get_gpr
>>+     * get addr in TCGv using gen_helper_csrr on CSR_SSP
>>+     * use some tcg subtract arithmetic (subtract by XLEN) on addr
>>+     * perform ss store on computed address
>>+     */
>>+
>>+    TCGv addr = tcg_temp_new();
>>+    TCGLabel *skip = gen_new_label();
>>+    uint32_t tmp = (get_xl(ctx) == MXL_RV64) ? 8 : 4;
>>+    TCGv_i32 ssp_csr = tcg_constant_i32(CSR_SSP);
>>+    TCGv data = tcg_temp_new();
>>+    gen_helper_csrr(addr, tcg_env, ssp_csr);
>
>I think you can skip the helper.  You've just validated the extension is enabled:
>
>  tcg_gen_ld_tl(addr, tcg_env, offsetof(CPURISCVState, ssp));

Yeah that's right, will do that.

>
>>+    TCGv rs1 = get_gpr(ctx, a->rs1, EXT_NONE);
>>+    tcg_gen_brcond_tl(TCG_COND_EQ, data, rs1, skip);
>>+    gen_helper_raise_sw_check_excep(tcg_env,
>>+        tcg_constant_tl(RISCV_EXCP_SW_CHECK_BCFI_TVAL), data, rs1);
>>+    gen_set_label(skip);
>>+    tcg_gen_addi_tl(addr, addr, tmp);
>>+    gen_helper_csrw(tcg_env, ssp_csr, addr);
>
>  tcg_gen_st_tl(addr, tcg_env, ...);
>
>>+static bool trans_sspush(DisasContext *ctx, arg_sspush *a)
>
>Same comments apply.
>
>
>r~

