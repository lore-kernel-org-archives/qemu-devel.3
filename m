Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557E8C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 23:22:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAHYa-0007tQ-GY; Thu, 23 May 2024 19:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYQ-0007ea-DX; Thu, 23 May 2024 19:09:00 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sAHYN-0005jq-3M; Thu, 23 May 2024 19:08:58 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f8e819cf60so313599b3a.0; 
 Thu, 23 May 2024 16:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716505732; x=1717110532; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+iY/kBMow51uMtzxGSmwrak6utqbZiCpZl+sQ4Cr0YA=;
 b=XF95yUAPhPd4pP5dSEfo1wGwP0SgPBM3/+7SqH3HNgs9YENZngoSL1Tfcsi470be/y
 TUvjvVMBlZyHrwyK+b48UukFGl4n3UpsYxc2Daiwv2CcMD2Lr25hVCEzIvjUQDD2Gxf2
 dZrCo2C0c7sqh51G+0hws7Gh1O+VAPNdEDh/k1h0ZVuilvKycq7wJTV0HmGPsAtoqsfA
 7R72nX7MyYkWtG2oEn4/3YK3SBy/E+TvKvwyneUfNnvgMw6vEIlCrtFDAWOIbeFm+LuC
 VM/G4oC66+FP0kzQ3hAunbKIneujNdQkq2rfESaKlUPW3gGCGRh0DxcUqdQaBQ4kLCFh
 NLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716505732; x=1717110532;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+iY/kBMow51uMtzxGSmwrak6utqbZiCpZl+sQ4Cr0YA=;
 b=gXThhstokkmsJK6hldBCNeWPkk7IWTP9Y52rhQqhKNMKbyS3eOc7gR/zWhvJyJ69Ee
 EyPseURRzNxntfO6oqwqQphPKbTsAMbOe5ngnnwZpsXKbWN5GMRSiVZfsdv3+XErgVSv
 Z7zxFjLasnMcpDdJUd9v4yO+UWT1sv4ke2TyWG/ZWEfYfq5P52ayndliSKtUPKMqY0hW
 toicgR51Vlg1BIzmy7G3T/OcIoE+cAsUIiDwLHR6FueaLVwFS9O+4wJ5/NNoUVkm2hNi
 fjckU4U3A1Nh0ZvkobCiUF0s5ETaXM3l5EPpFbCi5gWN/2Gy6Dcg9w4Rb4+j5uRjAs7U
 VMGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLzJxAt6QtnPx3oN7Z0vPtg8sb4ytg5EHhdrTOs+YA3qvdQIocEaJKUa+Pb7mrgeGGevDSkbhC/jIjW4UXfKw3xNWw
X-Gm-Message-State: AOJu0YwnpkE0c2qsUIPAsoJFVCPdpn+d/Ij23W9oyCXo66V/HsoMgeJ9
 yU8oFvhrSzl8HiENGPhdq76cm9wFtajKmskcThluUoiTIzysCnq3QJ1lnA==
X-Google-Smtp-Source: AGHT+IEOPmdtbs9d+BcOD/96voVyCUX8WSuaMhmCg0IaHHsXKeKDiE1hMQTAiI7cBLJgZ0M4AALgHA==
X-Received: by 2002:a05:6a20:7484:b0:1b1:f3d6:18c0 with SMTP id
 adf61e73a8af0-1b212d00534mr1121333637.19.1716505731958; 
 Thu, 23 May 2024 16:08:51 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682227f1838sm87041a12.46.2024.05.23.16.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 16:08:51 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Chinmay Rath <rathc@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 17/72] target/ppc: Move cmp{rb, eqb}, tw[i], td[i],
 isel instructions to decodetree.
Date: Fri, 24 May 2024 09:06:50 +1000
Message-ID: <20240523230747.45703-18-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240523230747.45703-1-npiggin@gmail.com>
References: <20240523230747.45703-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Chinmay Rath <rathc@linux.ibm.com>

Moving the following instructions to decodetree specification :

	cmp{rb, eqb}, t{w, d}	: X-form
	t{w, d}i		: D-form
	isel			: A-form

The changes were verified by validating that the tcg ops generated by those
instructions remain the same, which were captured using the '-d in_asm,op' flag.
Also for CMPRB, following review comments :
Replaced repetition of arithmetic right shifting (tcg_gen_shri_i32) followed
by extraction of last 8 bits (tcg_gen_ext8u_i32) with extraction of the required
bits using offsets (tcg_gen_extract_i32).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
[np: 32-bit compile fix]
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c                   |   4 +-
 target/ppc/helper.h                        |   6 +-
 target/ppc/insn32.decode                   |  16 +++
 target/ppc/int_helper.c                    |   2 +-
 target/ppc/translate.c                     | 133 +--------------------
 target/ppc/translate/fixedpoint-impl.c.inc | 132 ++++++++++++++++++++
 6 files changed, 157 insertions(+), 136 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index 9df17f93bf..2e3f36a3ef 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -2742,7 +2742,7 @@ void helper_rfmci(CPUPPCState *env)
 }
 #endif /* !CONFIG_USER_ONLY */
 
-void helper_tw(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
+void helper_TW(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
                uint32_t flags)
 {
     if (!likely(!(((int32_t)arg1 < (int32_t)arg2 && (flags & 0x10)) ||
@@ -2756,7 +2756,7 @@ void helper_tw(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
 }
 
 #ifdef TARGET_PPC64
-void helper_td(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
+void helper_TD(CPUPPCState *env, target_ulong arg1, target_ulong arg2,
                uint32_t flags)
 {
     if (!likely(!(((int64_t)arg1 < (int64_t)arg2 && (flags & 0x10)) ||
diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index b5a76f1365..b8af2cf878 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -1,8 +1,8 @@
 DEF_HELPER_FLAGS_3(raise_exception_err, TCG_CALL_NO_WG, noreturn, env, i32, i32)
 DEF_HELPER_FLAGS_2(raise_exception, TCG_CALL_NO_WG, noreturn, env, i32)
-DEF_HELPER_FLAGS_4(tw, TCG_CALL_NO_WG, void, env, tl, tl, i32)
+DEF_HELPER_FLAGS_4(TW, TCG_CALL_NO_WG, void, env, tl, tl, i32)
 #if defined(TARGET_PPC64)
-DEF_HELPER_FLAGS_4(td, TCG_CALL_NO_WG, void, env, tl, tl, i32)
+DEF_HELPER_FLAGS_4(TD, TCG_CALL_NO_WG, void, env, tl, tl, i32)
 #endif
 DEF_HELPER_4(HASHST, void, env, tl, tl, tl)
 DEF_HELPER_4(HASHCHK, void, env, tl, tl, tl)
@@ -67,7 +67,7 @@ DEF_HELPER_FLAGS_2(PEXTD, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_FLAGS_1(CDTBCD, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_1(CBCDTD, TCG_CALL_NO_RWG_SE, tl, tl)
 #if defined(TARGET_PPC64)
-DEF_HELPER_FLAGS_2(cmpeqb, TCG_CALL_NO_RWG_SE, i32, tl, tl)
+DEF_HELPER_FLAGS_2(CMPEQB, TCG_CALL_NO_RWG_SE, i32, tl, tl)
 DEF_HELPER_FLAGS_1(popcntw, TCG_CALL_NO_RWG_SE, tl, tl)
 DEF_HELPER_FLAGS_2(bpermd, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 DEF_HELPER_3(srad, tl, env, tl, tl)
diff --git a/target/ppc/insn32.decode b/target/ppc/insn32.decode
index c7cb6e7f37..cb1e4bd307 100644
--- a/target/ppc/insn32.decode
+++ b/target/ppc/insn32.decode
@@ -29,6 +29,9 @@
 &A_tb           frt frb rc:bool
 @A_tb           ...... frt:5 ..... frb:5 ..... ..... rc:1       &A_tb
 
+&A_tab_bc       rt ra rb bc
+@A_tab_bc       ...... rt:5 ra:5 rb:5 bc:5 ..... .              &A_tab_bc
+
 &D              rt ra si:int64_t
 @D              ...... rt:5 ra:5 si:s16                         &D
 
@@ -340,6 +343,19 @@ CMP             011111 ... - . ..... ..... 0000000000 - @X_bfl
 CMPL            011111 ... - . ..... ..... 0000100000 - @X_bfl
 CMPI            001011 ... - . ..... ................   @D_bfs
 CMPLI           001010 ... - . ..... ................   @D_bfu
+CMPRB           011111 ... - . ..... ..... 0011000000 - @X_bfl
+CMPEQB          011111 ... -- ..... ..... 0011100000 -  @X_bf
+
+### Fixed-Point Trap Instructions
+
+TW              011111 ..... ..... ..... 0000000100 -   @X
+TD              011111 ..... ..... ..... 0001000100 -   @X
+TWI             000011 ..... ..... ................     @D
+TDI             000010 ..... ..... ................     @D
+
+### Fixed-Point Select Instruction
+
+ISEL            011111 ..... ..... ..... ..... 01111 -  @A_tab_bc
 
 ### Fixed-Point Arithmetic Instructions
 
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 585c2b65d3..d12dcc28e1 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -159,7 +159,7 @@ uint64_t helper_DIVDE(CPUPPCState *env, uint64_t rau, uint64_t rbu, uint32_t oe)
 /* When you XOR the pattern and there is a match, that byte will be zero */
 #define hasvalue(x, n)  (haszero((x) ^ pattern(n)))
 
-uint32_t helper_cmpeqb(target_ulong ra, target_ulong rb)
+uint32_t helper_CMPEQB(target_ulong ra, target_ulong rb)
 {
     return hasvalue(rb, ra) ? CRF_GT : 0;
 }
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index ba7c1fdf43..e1ccb82f10 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1563,66 +1563,6 @@ static inline void gen_set_Rc0(DisasContext *ctx, TCGv reg)
     }
 }
 
-/* cmprb - range comparison: isupper, isaplha, islower*/
-static void gen_cmprb(DisasContext *ctx)
-{
-    TCGv_i32 src1 = tcg_temp_new_i32();
-    TCGv_i32 src2 = tcg_temp_new_i32();
-    TCGv_i32 src2lo = tcg_temp_new_i32();
-    TCGv_i32 src2hi = tcg_temp_new_i32();
-    TCGv_i32 crf = cpu_crf[crfD(ctx->opcode)];
-
-    tcg_gen_trunc_tl_i32(src1, cpu_gpr[rA(ctx->opcode)]);
-    tcg_gen_trunc_tl_i32(src2, cpu_gpr[rB(ctx->opcode)]);
-
-    tcg_gen_andi_i32(src1, src1, 0xFF);
-    tcg_gen_ext8u_i32(src2lo, src2);
-    tcg_gen_shri_i32(src2, src2, 8);
-    tcg_gen_ext8u_i32(src2hi, src2);
-
-    tcg_gen_setcond_i32(TCG_COND_LEU, src2lo, src2lo, src1);
-    tcg_gen_setcond_i32(TCG_COND_LEU, src2hi, src1, src2hi);
-    tcg_gen_and_i32(crf, src2lo, src2hi);
-
-    if (ctx->opcode & 0x00200000) {
-        tcg_gen_shri_i32(src2, src2, 8);
-        tcg_gen_ext8u_i32(src2lo, src2);
-        tcg_gen_shri_i32(src2, src2, 8);
-        tcg_gen_ext8u_i32(src2hi, src2);
-        tcg_gen_setcond_i32(TCG_COND_LEU, src2lo, src2lo, src1);
-        tcg_gen_setcond_i32(TCG_COND_LEU, src2hi, src1, src2hi);
-        tcg_gen_and_i32(src2lo, src2lo, src2hi);
-        tcg_gen_or_i32(crf, crf, src2lo);
-    }
-    tcg_gen_shli_i32(crf, crf, CRF_GT_BIT);
-}
-
-#if defined(TARGET_PPC64)
-/* cmpeqb */
-static void gen_cmpeqb(DisasContext *ctx)
-{
-    gen_helper_cmpeqb(cpu_crf[crfD(ctx->opcode)], cpu_gpr[rA(ctx->opcode)],
-                      cpu_gpr[rB(ctx->opcode)]);
-}
-#endif
-
-/* isel (PowerPC 2.03 specification) */
-static void gen_isel(DisasContext *ctx)
-{
-    uint32_t bi = rC(ctx->opcode);
-    uint32_t mask = 0x08 >> (bi & 0x03);
-    TCGv t0 = tcg_temp_new();
-    TCGv zr;
-
-    tcg_gen_extu_i32_tl(t0, cpu_crf[bi >> 2]);
-    tcg_gen_andi_tl(t0, t0, mask);
-
-    zr = tcg_constant_tl(0);
-    tcg_gen_movcond_tl(TCG_COND_NE, cpu_gpr[rD(ctx->opcode)], t0, zr,
-                       rA(ctx->opcode) ? cpu_gpr[rA(ctx->opcode)] : zr,
-                       cpu_gpr[rB(ctx->opcode)]);
-}
-
 /* cmpb: PowerPC 2.05 specification */
 static void gen_cmpb(DisasContext *ctx)
 {
@@ -4187,76 +4127,20 @@ static void gen_scv(DisasContext *ctx)
 /***                                Trap                                   ***/
 
 /* Check for unconditional traps (always or never) */
-static bool check_unconditional_trap(DisasContext *ctx)
+static bool check_unconditional_trap(DisasContext *ctx, int to)
 {
     /* Trap never */
-    if (TO(ctx->opcode) == 0) {
+    if (to == 0) {
         return true;
     }
     /* Trap always */
-    if (TO(ctx->opcode) == 31) {
+    if (to == 31) {
         gen_exception_err(ctx, POWERPC_EXCP_PROGRAM, POWERPC_EXCP_TRAP);
         return true;
     }
     return false;
 }
 
-/* tw */
-static void gen_tw(DisasContext *ctx)
-{
-    TCGv_i32 t0;
-
-    if (check_unconditional_trap(ctx)) {
-        return;
-    }
-    t0 = tcg_constant_i32(TO(ctx->opcode));
-    gen_helper_tw(tcg_env, cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)],
-                  t0);
-}
-
-/* twi */
-static void gen_twi(DisasContext *ctx)
-{
-    TCGv t0;
-    TCGv_i32 t1;
-
-    if (check_unconditional_trap(ctx)) {
-        return;
-    }
-    t0 = tcg_constant_tl(SIMM(ctx->opcode));
-    t1 = tcg_constant_i32(TO(ctx->opcode));
-    gen_helper_tw(tcg_env, cpu_gpr[rA(ctx->opcode)], t0, t1);
-}
-
-#if defined(TARGET_PPC64)
-/* td */
-static void gen_td(DisasContext *ctx)
-{
-    TCGv_i32 t0;
-
-    if (check_unconditional_trap(ctx)) {
-        return;
-    }
-    t0 = tcg_constant_i32(TO(ctx->opcode));
-    gen_helper_td(tcg_env, cpu_gpr[rA(ctx->opcode)], cpu_gpr[rB(ctx->opcode)],
-                  t0);
-}
-
-/* tdi */
-static void gen_tdi(DisasContext *ctx)
-{
-    TCGv t0;
-    TCGv_i32 t1;
-
-    if (check_unconditional_trap(ctx)) {
-        return;
-    }
-    t0 = tcg_constant_tl(SIMM(ctx->opcode));
-    t1 = tcg_constant_i32(TO(ctx->opcode));
-    gen_helper_td(tcg_env, cpu_gpr[rA(ctx->opcode)], t0, t1);
-}
-#endif
-
 /***                          Processor control                            ***/
 
 /* mcrxr */
@@ -6058,12 +5942,7 @@ GEN_HANDLER_E(brw, 0x1F, 0x1B, 0x04, 0x0000F801, PPC_NONE, PPC2_ISA310),
 GEN_HANDLER_E(brh, 0x1F, 0x1B, 0x06, 0x0000F801, PPC_NONE, PPC2_ISA310),
 #endif
 GEN_HANDLER(invalid, 0x00, 0x00, 0x00, 0xFFFFFFFF, PPC_NONE),
-#if defined(TARGET_PPC64)
-GEN_HANDLER_E(cmpeqb, 0x1F, 0x00, 0x07, 0x00600000, PPC_NONE, PPC2_ISA300),
-#endif
 GEN_HANDLER_E(cmpb, 0x1F, 0x1C, 0x0F, 0x00000001, PPC_NONE, PPC2_ISA205),
-GEN_HANDLER_E(cmprb, 0x1F, 0x00, 0x06, 0x00400001, PPC_NONE, PPC2_ISA300),
-GEN_HANDLER(isel, 0x1F, 0x0F, 0xFF, 0x00000001, PPC_ISEL),
 GEN_HANDLER2(andi_, "andi.", 0x1C, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER2(andis_, "andis.", 0x1D, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(cntlzw, 0x1F, 0x1A, 0x00, 0x00000000, PPC_INTEGER),
@@ -6160,12 +6039,6 @@ GEN_HANDLER(hrfid, 0x13, 0x12, 0x08, 0x03FF8001, PPC_64H),
 /* Top bit of opc2 corresponds with low bit of LEV, so use two handlers */
 GEN_HANDLER(sc, 0x11, 0x11, 0xFF, 0x03FFF01D, PPC_FLOW),
 GEN_HANDLER(sc, 0x11, 0x01, 0xFF, 0x03FFF01D, PPC_FLOW),
-GEN_HANDLER(tw, 0x1F, 0x04, 0x00, 0x00000001, PPC_FLOW),
-GEN_HANDLER(twi, 0x03, 0xFF, 0xFF, 0x00000000, PPC_FLOW),
-#if defined(TARGET_PPC64)
-GEN_HANDLER(td, 0x1F, 0x04, 0x02, 0x00000001, PPC_64B),
-GEN_HANDLER(tdi, 0x02, 0xFF, 0xFF, 0x00000000, PPC_64B),
-#endif
 GEN_HANDLER(mcrxr, 0x1F, 0x00, 0x10, 0x007FF801, PPC_MISC),
 GEN_HANDLER(mfcr, 0x1F, 0x13, 0x00, 0x00000801, PPC_MISC),
 GEN_HANDLER(mfmsr, 0x1F, 0x13, 0x02, 0x001FF801, PPC_MISC),
diff --git a/target/ppc/translate/fixedpoint-impl.c.inc b/target/ppc/translate/fixedpoint-impl.c.inc
index 2ada7473ea..872fed664d 100644
--- a/target/ppc/translate/fixedpoint-impl.c.inc
+++ b/target/ppc/translate/fixedpoint-impl.c.inc
@@ -289,6 +289,50 @@ TRANS(CMPL, do_cmp_X, false);
 TRANS(CMPI, do_cmp_D, true);
 TRANS(CMPLI, do_cmp_D, false);
 
+static bool trans_CMPRB(DisasContext *ctx, arg_CMPRB *a)
+{
+    TCGv_i32 src1 = tcg_temp_new_i32();
+    TCGv_i32 src2 = tcg_temp_new_i32();
+    TCGv_i32 src2lo = tcg_temp_new_i32();
+    TCGv_i32 src2hi = tcg_temp_new_i32();
+    TCGv_i32 crf = cpu_crf[a->bf];
+
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+    tcg_gen_trunc_tl_i32(src1, cpu_gpr[a->ra]);
+    tcg_gen_trunc_tl_i32(src2, cpu_gpr[a->rb]);
+
+    tcg_gen_andi_i32(src1, src1, 0xFF);
+    tcg_gen_ext8u_i32(src2lo, src2);
+    tcg_gen_extract_i32(src2hi, src2, 8, 8);
+
+    tcg_gen_setcond_i32(TCG_COND_LEU, src2lo, src2lo, src1);
+    tcg_gen_setcond_i32(TCG_COND_LEU, src2hi, src1, src2hi);
+    tcg_gen_and_i32(crf, src2lo, src2hi);
+
+    if (a->l) {
+        tcg_gen_extract_i32(src2lo, src2, 16, 8);
+        tcg_gen_extract_i32(src2hi, src2, 24, 8);
+        tcg_gen_setcond_i32(TCG_COND_LEU, src2lo, src2lo, src1);
+        tcg_gen_setcond_i32(TCG_COND_LEU, src2hi, src1, src2hi);
+        tcg_gen_and_i32(src2lo, src2lo, src2hi);
+        tcg_gen_or_i32(crf, crf, src2lo);
+    }
+    tcg_gen_shli_i32(crf, crf, CRF_GT_BIT);
+    return true;
+}
+
+static bool trans_CMPEQB(DisasContext *ctx, arg_CMPEQB *a)
+{
+    REQUIRE_64BIT(ctx);
+    REQUIRE_INSNS_FLAGS2(ctx, ISA300);
+#if defined(TARGET_PPC64)
+    gen_helper_CMPEQB(cpu_crf[a->bf], cpu_gpr[a->ra], cpu_gpr[a->rb]);
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
 /*
  * Fixed-Point Arithmetic Instructions
  */
@@ -690,6 +734,94 @@ static bool trans_DIVDEU(DisasContext *ctx, arg_DIVDEU *a)
 TRANS64(MODSD, do_modd, true);
 TRANS64(MODUD, do_modd, false);
 
+/*
+ * Fixed-Point Select Instructions
+ */
+
+static bool trans_ISEL(DisasContext *ctx, arg_ISEL *a)
+{
+    REQUIRE_INSNS_FLAGS(ctx, ISEL);
+    uint32_t bi = a->bc;
+    uint32_t mask = 0x08 >> (bi & 0x03);
+    TCGv t0 = tcg_temp_new();
+    TCGv zr;
+
+    tcg_gen_extu_i32_tl(t0, cpu_crf[bi >> 2]);
+    tcg_gen_andi_tl(t0, t0, mask);
+
+    zr = tcg_constant_tl(0);
+    tcg_gen_movcond_tl(TCG_COND_NE, cpu_gpr[a->rt], t0, zr,
+                       a->ra ? cpu_gpr[a->ra] : zr,
+                       cpu_gpr[a->rb]);
+    return true;
+}
+
+/*
+ * Fixed-Point Trap Instructions
+ */
+
+static bool trans_TW(DisasContext *ctx, arg_TW *a)
+{
+    TCGv_i32 t0;
+
+    if (check_unconditional_trap(ctx, a->rt)) {
+        return true;
+    }
+    t0 = tcg_constant_i32(a->rt);
+    gen_helper_TW(tcg_env, cpu_gpr[a->ra], cpu_gpr[a->rb], t0);
+    return true;
+}
+
+static bool trans_TWI(DisasContext *ctx, arg_TWI *a)
+{
+    TCGv t0;
+    TCGv_i32 t1;
+
+    if (check_unconditional_trap(ctx, a->rt)) {
+        return true;
+    }
+    t0 = tcg_constant_tl(a->si);
+    t1 = tcg_constant_i32(a->rt);
+    gen_helper_TW(tcg_env, cpu_gpr[a->ra], t0, t1);
+    return true;
+}
+
+static bool trans_TD(DisasContext *ctx, arg_TD *a)
+{
+    REQUIRE_64BIT(ctx);
+#if defined(TARGET_PPC64)
+    TCGv_i32 t0;
+
+    if (check_unconditional_trap(ctx, a->rt)) {
+        return true;
+    }
+    t0 = tcg_constant_i32(a->rt);
+    gen_helper_TD(tcg_env, cpu_gpr[a->ra], cpu_gpr[a->rb], t0);
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
+static bool trans_TDI(DisasContext *ctx, arg_TDI *a)
+{
+    REQUIRE_64BIT(ctx);
+#if defined(TARGET_PPC64)
+    TCGv t0;
+    TCGv_i32 t1;
+
+    if (check_unconditional_trap(ctx, a->rt)) {
+        return true;
+    }
+    t0 = tcg_constant_tl(a->si);
+    t1 = tcg_constant_i32(a->rt);
+    gen_helper_TD(tcg_env, cpu_gpr[a->ra], t0, t1);
+#else
+    qemu_build_not_reached();
+#endif
+    return true;
+}
+
 static bool trans_INVALID(DisasContext *ctx, arg_INVALID *a)
 {
     gen_invalid(ctx);
-- 
2.43.0


