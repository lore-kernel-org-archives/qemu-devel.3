Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8CEF46C45
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9lVo-0003A0-7e; Mon, 06 Apr 2026 11:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lVm-00038r-Qm
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:05:10 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lVk-00046U-UW
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:05:10 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ab46931cf1so33229415ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 08:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775487907; x=1776092707; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MwdNd4FHCrq25/1aSpiuowhEqZjmmXC6pqpEfiyTzXI=;
 b=MBJekGlQgLR/CUftYVERvpLjogsgBtvPKwdhWLgzMJSRXaTDpXFXIVn+MW68ImkF5p
 tGRCmLXb6JyagHjiKgV8R9/5eSsfzgAhH+FuwIoNoRC5ivIp5gHaLyIOBfpMGNyBLNvc
 Px9zFoCnALnud+El/ZqnecDTZu/osGiTWI9AAjpByUu6UyUp95+jKEgoDnBkD9/sC9vD
 nVqsIBvhtN3jgm9FdpEe2LTKONOksyJiU3BFox1YfKNmqLDLmlpqYg4Dr+7FZTdVjZTx
 P9fds+yKCiGyHXhaYT3gNT3T0rnD2p1XVxDhoq2DrC8Vju7FqDyJiRu2m5P7Qxmwkde0
 X1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775487907; x=1776092707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MwdNd4FHCrq25/1aSpiuowhEqZjmmXC6pqpEfiyTzXI=;
 b=S8l9azq4j69jDWLlJFrVWkb5xd/0UC2mGgz4wGQasNnOu8ajmC3xPVnWS7ixC21X1W
 66WnocM2s1ZV3YZPb3z2J6BGPQBhd4Wf6iCqHFmGZSoQUa/+mbpIPWw+NaJZ42YKhHKF
 vAHnqqfh/knDkzIT9RQZRgnP6qM19MRc9PUvqZxR9z4gdytvReAlPhnRm6Ykj15a2mZK
 ZhGhBMMHS7Ub6GKt67k6rH2nXoZX06EwhhDIzn0bgQrpnuF7DdncR9eZgWIipPEl/mRX
 8hznt/ixySykJvy12r67qm4FFOOCMZyrLhoviaiEdaGzvNjKnGOipBp5p8mPnpj92FQs
 mmaA==
X-Gm-Message-State: AOJu0Yz78eAt8xfr862Px+EBI2i3z7WErSidz8AoE1ZKxdSTp1N+4Ser
 rtbmkYDN1fo0bhyhyevyAxEoDa1fXlHQE+rCZVedZ4IrSHEc2AeeC2cU7NCT6JCS6LRh9WNvNdJ
 OyIAqvaLGcQ==
X-Gm-Gg: AeBDiesnoGSb7gU4JMrp9fH0ul69qgaR82goYV9nHsjr/4Rx893xKm3xlXJXihZt38k
 kddOht+DOK04Au6vVwvNJhXfaTnz5ofhDuJvjn4i2gT3t6iJmTMnPsfWEjZ3uXoNAei/MSXK2aQ
 BMZQVgptat1Xwn/F8E0RabeKttiCQwstEj7Ey6DdWhsTN1drD6dXDM6HV8uibXnUnLgzK6E91La
 gCt7to046BVSByRPQraY5cdDABZlyN1+uIcpIGQllwqYdcxSibJYiuxEspEJj2/YrrP4p9RnRVq
 8zoCiTLbvw8D+BYM1lmBM8hako+yngpL/sZ/ht1sGqfoHv01w/r8kdYZKo/EJ/JQhKbdYoQM8dS
 csfFtacQ4z/bBPGxQjdL9iGTNomUmf2WEOGa96fKNrZVgRkVrM/ssHPA1IaP7Yk1qYuRnefj9lC
 mjct2kC64HXojSFK1W6alS3StTNoaTOjxwGkYe03Cdh2JEj0x5CVo4u6DmBXWjNEBZ8wQXcYeDn
 P8g
X-Received: by 2002:a17:902:ce0b:b0:2b0:c060:aab8 with SMTP id
 d9443c01a7336-2b277d9b788mr144035945ad.9.1775487907068; 
 Mon, 06 Apr 2026 08:05:07 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979d72sm137770075ad.51.2026.04.06.08.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 08:05:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org,
 jim.macarthur@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 14/14] target/arm/tcg/translate.c: replace TCGv with TCGv_va
Date: Mon,  6 Apr 2026 08:04:34 -0700
Message-ID: <20260406150434.407201-15-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406150434.407201-1-pierrick.bouvier@linaro.org>
References: <20260406150434.407201-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

We know this file is for 32-bit runtime target, so we can set
TCG_ADDRESS_BITS and pass the correct addr_type to translator_loop.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index ebcf68aea97..6ea48efbac2 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -22,7 +22,8 @@
 
 #include "translate.h"
 #include "translate-a32.h"
-#include "tcg/tcg-op.h"
+#define TCG_ADDRESS_BITS 32
+#include "tcg/tcg-op-mem.h"
 #include "qemu/log.h"
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
@@ -909,14 +910,14 @@ MemOp pow2_align(unsigned i)
  * that the address argument is TCGv_i32 rather than TCGv.
  */
 
-static TCGv gen_aa32_addr(DisasContext *s, TCGv_i32 a32, MemOp op)
+static TCGv_va gen_aa32_addr(DisasContext *s, TCGv_i32 a32, MemOp op)
 {
-    TCGv addr = tcg_temp_new();
-    tcg_gen_extu_i32_tl(addr, a32);
+    TCGv_va addr = tcgv_va_temp_new();
+    tcg_gen_mov_i32(addr, a32);
 
     /* Not needed for user-mode BE32, where we use MO_BE instead.  */
     if (!IS_USER_ONLY && s->sctlr_b && (op & MO_SIZE) < MO_32) {
-        tcg_gen_xori_tl(addr, addr, 4 - (1 << (op & MO_SIZE)));
+        tcg_gen_xori_i32(addr, addr, 4 - (1 << (op & MO_SIZE)));
     }
     return addr;
 }
@@ -928,21 +929,21 @@ static TCGv gen_aa32_addr(DisasContext *s, TCGv_i32 a32, MemOp op)
 void gen_aa32_ld_internal_i32(DisasContext *s, TCGv_i32 val,
                               TCGv_i32 a32, int index, MemOp opc)
 {
-    TCGv addr = gen_aa32_addr(s, a32, opc);
+    TCGv_va addr = gen_aa32_addr(s, a32, opc);
     tcg_gen_qemu_ld_i32(val, addr, index, opc);
 }
 
 void gen_aa32_st_internal_i32(DisasContext *s, TCGv_i32 val,
                               TCGv_i32 a32, int index, MemOp opc)
 {
-    TCGv addr = gen_aa32_addr(s, a32, opc);
+    TCGv_va addr = gen_aa32_addr(s, a32, opc);
     tcg_gen_qemu_st_i32(val, addr, index, opc);
 }
 
 void gen_aa32_ld_internal_i64(DisasContext *s, TCGv_i64 val,
                               TCGv_i32 a32, int index, MemOp opc)
 {
-    TCGv addr = gen_aa32_addr(s, a32, opc);
+    TCGv_va addr = gen_aa32_addr(s, a32, opc);
 
     tcg_gen_qemu_ld_i64(val, addr, index, opc);
 
@@ -955,7 +956,7 @@ void gen_aa32_ld_internal_i64(DisasContext *s, TCGv_i64 val,
 void gen_aa32_st_internal_i64(DisasContext *s, TCGv_i64 val,
                               TCGv_i32 a32, int index, MemOp opc)
 {
-    TCGv addr = gen_aa32_addr(s, a32, opc);
+    TCGv_va addr = gen_aa32_addr(s, a32, opc);
 
     /* Not needed for user-mode BE32, where we use MO_BE instead.  */
     if (!IS_USER_ONLY && s->sctlr_b && (opc & MO_SIZE) == MO_64) {
@@ -2035,7 +2036,7 @@ static void gen_load_exclusive(DisasContext *s, int rt, int rt2,
          * architecturally 64-bit access, but instead do a 64-bit access
          * using MO_BE if appropriate and then split the two halves.
          */
-        TCGv taddr = gen_aa32_addr(s, addr, opc);
+        TCGv_va taddr = gen_aa32_addr(s, addr, opc);
 
         tcg_gen_qemu_ld_i64(t64, taddr, get_mem_index(s), opc);
         tcg_gen_mov_i64(cpu_exclusive_val, t64);
@@ -2064,7 +2065,7 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
 {
     TCGv_i32 t0, t1, t2;
     TCGv_i64 extaddr;
-    TCGv taddr;
+    TCGv_va taddr;
     TCGLabel *done_label;
     TCGLabel *fail_label;
     MemOp opc = size | MO_ALIGN | s->be_data;
@@ -3791,7 +3792,7 @@ static void do_ldrd_load(DisasContext *s, TCGv_i32 addr, int rt, int rt2)
      */
     int mem_idx = get_mem_index(s);
     MemOp opc = MO_64 | MO_ALIGN_4 | MO_ATOM_SUBALIGN | s->be_data;
-    TCGv taddr = gen_aa32_addr(s, addr, opc);
+    TCGv_va taddr = gen_aa32_addr(s, addr, opc);
     TCGv_i64 t64 = tcg_temp_new_i64();
     TCGv_i32 tmp = tcg_temp_new_i32();
     TCGv_i32 tmp2 = tcg_temp_new_i32();
@@ -3846,7 +3847,7 @@ static void do_strd_store(DisasContext *s, TCGv_i32 addr, int rt, int rt2)
      */
     int mem_idx = get_mem_index(s);
     MemOp opc = MO_64 | MO_ALIGN_4 | MO_ATOM_SUBALIGN | s->be_data;
-    TCGv taddr = gen_aa32_addr(s, addr, opc);
+    TCGv_va taddr = gen_aa32_addr(s, addr, opc);
     TCGv_i32 t1 = load_reg(s, rt);
     TCGv_i32 t2 = load_reg(s, rt2);
     TCGv_i64 t64 = tcg_temp_new_i64();
@@ -4067,7 +4068,7 @@ DO_LDST(STRH, store, MO_UW)
 static bool op_swp(DisasContext *s, arg_SWP *a, MemOp opc)
 {
     TCGv_i32 addr, tmp;
-    TCGv taddr;
+    TCGv_va taddr;
 
     opc |= s->be_data;
     addr = load_reg(s, a->rn);
@@ -6881,6 +6882,7 @@ void arm_translate_code(CPUState *cpu, TranslationBlock *tb,
     DisasContext dc = { };
     const TranslatorOps *ops = &arm_translator_ops;
     CPUARMTBFlags tb_flags = arm_tbflags_from_tb(tb);
+    TCGType addr_type = is_a64(cpu_env(cpu)) ? TCG_TYPE_I64 : TCG_TYPE_I32;
 
     if (EX_TBFLAG_AM32(tb_flags, THUMB)) {
         ops = &thumb_translator_ops;
@@ -6891,6 +6893,5 @@ void arm_translate_code(CPUState *cpu, TranslationBlock *tb,
     }
 #endif
 
-    translator_loop(cpu, tb, max_insns, pc, host_pc, ops, &dc.base,
-                    tcg_default_addr_type());
+    translator_loop(cpu, tb, max_insns, pc, host_pc, ops, &dc.base, addr_type);
 }
-- 
2.47.3


