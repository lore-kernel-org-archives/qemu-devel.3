Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB95FF513D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 20:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wACaV-0004Ff-Rj; Tue, 07 Apr 2026 15:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaS-0004AM-MJ
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:48 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wACaQ-0007OR-6k
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:59:48 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-35d9c7bf9a1so4848456a91.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 12:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775591985; x=1776196785; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P49JgMXtfvI/QxKp8JO4alWiNFfw7eGmQBelecFaY5M=;
 b=LU6vK0f4o1vu9ouOCfr6DvbCucey7ReJsHdXqivcCai41Sck2rCMwgnkUC/jwHi5Z4
 fGGXYvYW6Mc8n2cgpD+HHRqshD/wLaXogR8UMozgIw0kFmam/0k/9+uCVYzWH80IBDBx
 hqTOUTEGnsZ5kXQC5xoXybLclzCQQru9bPr2mhcAi/Jcgae++uAW/ZysQtX5NC1nQ7HJ
 eGn4SVLKbehIj3wo2aq/dhekMEWt/Iqx8IFQiwEmQo9lPaoFSknHNuwLDYW+XiaBlz2c
 JQx/f5mOqErVYYxY5FhogxceakyQ2Yjg1qJMdmwyQ6vrJyBWbCpwrqkMJQ562JjH7n6C
 DQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775591985; x=1776196785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=P49JgMXtfvI/QxKp8JO4alWiNFfw7eGmQBelecFaY5M=;
 b=AKQ11PTuZqaD/HHNMvcu/qPwe16o61VSDwNHlFCo2XIYfrPSccpcUdFNwiHObEaIJ8
 TAX1KHBKCKJbmexGwScZ6QU/zEAimvkU4QIJAoCPY3Tk1OSZDCSe7oDBIADJ3L1jtqJe
 r/VnA4mv/jVkEu/gpV0SglO351+nLwU6PLiEnOz/u7qZyu1ZkuiA6V5jC5BAESQQsUE+
 3ASUqn7ONH/EhQV2rjNuK7gTxKNF1GtnkSheQQS3kOy/WcGHH1FZxRHcu9yaMrlLGK8K
 xnJIY+uYo+5whMqTx8RL9qg9zyG7POjcer0dkVKkxHHVePIPWyu0kYOKc+6ZxTI1FOTn
 n+ZQ==
X-Gm-Message-State: AOJu0YzOwrvdg/pN7arLzEbDx6koMPLP5BvgKK4/hgUlk9cKnLFWI/C8
 lKJ4S8+k2cmb41W++4Ps2cYAnzojF9pxmEsiYeoYiYX9wiHTZJ8tlJ0CRgQ6cn03bzTo1ot4XPp
 rMGSwJig=
X-Gm-Gg: AeBDietxhtJSNyiq1gpmegqRxIDEJVt2R2ktPMzwQ1G2Yr2eY1pU6rSieRt1a+L5JmH
 3o5cJG/lN3hcS2N9P10IUiRG0aG++q/EKV38t+3WbesWSZGh5zk3AjJhy6tnuNikowMK3EpHh/j
 HqkxBxaXv9umffnOrVMWBPCuxV+vQ9vXLl17ClmQl7SAcizfHV9GR2jyogtU800LYXDTHjUz77G
 DICO+/LQq8Nw8tQu9OMhssvhcZiPkKrbXgpCZs4EM40vIisDAJfDWtwyDy0Cz28TPAEMq+XvYBY
 KGB8gjhBFQV9vyYUB2WT3cDVLusjahltEy6BVr/+p2GTzW3IeXOG5uOk+MUHTTB4nZmOaFnla2b
 1RDV1QmBGBKfP2/DNw4l2TD5KyjJEtsFrkOvBpnupbgyc3pRP+nuz9njkkCQr6kPJujQDLJLrpc
 YUVmPXjH/Bo5uUYZfJqSi+g+0ihA/XmBYS1oaBQ5uuB8jpwQJlJ7DPdEXrX46n4nwbbTmbzP+MB
 XUt
X-Received: by 2002:a17:90b:4f43:b0:359:f3b1:6811 with SMTP id
 98e67ed59e1d1-35de67db862mr16989873a91.1.1775591984669; 
 Tue, 07 Apr 2026 12:59:44 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e27c9855csm126911a91.3.2026.04.07.12.59.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 12:59:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, jim.macarthur@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>, philmd@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v10 15/21] target/arm/tcg/translate.c: replace TCGv with
 TCGv_va
Date: Tue,  7 Apr 2026 12:59:16 -0700
Message-ID: <20260407195922.196410-16-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
References: <20260407195922.196410-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1033.google.com
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
TCG_ADDRESS_BITS. TCG_TYPE_VA is derived accordingly and is already
passed to translator_loop.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index fa4c7907dcd..0b3b4ab86be 100644
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
@@ -910,14 +911,14 @@ MemOp pow2_align(unsigned i)
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
@@ -929,21 +930,21 @@ static TCGv gen_aa32_addr(DisasContext *s, TCGv_i32 a32, MemOp op)
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
 
@@ -956,7 +957,7 @@ void gen_aa32_ld_internal_i64(DisasContext *s, TCGv_i64 val,
 void gen_aa32_st_internal_i64(DisasContext *s, TCGv_i64 val,
                               TCGv_i32 a32, int index, MemOp opc)
 {
-    TCGv addr = gen_aa32_addr(s, a32, opc);
+    TCGv_va addr = gen_aa32_addr(s, a32, opc);
 
     /* Not needed for user-mode BE32, where we use MO_BE instead.  */
     if (!IS_USER_ONLY && s->sctlr_b && (opc & MO_SIZE) == MO_64) {
@@ -2036,7 +2037,7 @@ static void gen_load_exclusive(DisasContext *s, int rt, int rt2,
          * architecturally 64-bit access, but instead do a 64-bit access
          * using MO_BE if appropriate and then split the two halves.
          */
-        TCGv taddr = gen_aa32_addr(s, addr, opc);
+        TCGv_va taddr = gen_aa32_addr(s, addr, opc);
 
         tcg_gen_qemu_ld_i64(t64, taddr, get_mem_index(s), opc);
         tcg_gen_mov_i64(cpu_exclusive_val, t64);
@@ -2065,7 +2066,7 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
 {
     TCGv_i32 t0, t1, t2;
     TCGv_i64 extaddr;
-    TCGv taddr;
+    TCGv_va taddr;
     TCGLabel *done_label;
     TCGLabel *fail_label;
     MemOp opc = size | MO_ALIGN | s->be_data;
@@ -3792,7 +3793,7 @@ static void do_ldrd_load(DisasContext *s, TCGv_i32 addr, int rt, int rt2)
      */
     int mem_idx = get_mem_index(s);
     MemOp opc = MO_64 | MO_ALIGN_4 | MO_ATOM_SUBALIGN | s->be_data;
-    TCGv taddr = gen_aa32_addr(s, addr, opc);
+    TCGv_va taddr = gen_aa32_addr(s, addr, opc);
     TCGv_i64 t64 = tcg_temp_new_i64();
     TCGv_i32 tmp = tcg_temp_new_i32();
     TCGv_i32 tmp2 = tcg_temp_new_i32();
@@ -3847,7 +3848,7 @@ static void do_strd_store(DisasContext *s, TCGv_i32 addr, int rt, int rt2)
      */
     int mem_idx = get_mem_index(s);
     MemOp opc = MO_64 | MO_ALIGN_4 | MO_ATOM_SUBALIGN | s->be_data;
-    TCGv taddr = gen_aa32_addr(s, addr, opc);
+    TCGv_va taddr = gen_aa32_addr(s, addr, opc);
     TCGv_i32 t1 = load_reg(s, rt);
     TCGv_i32 t2 = load_reg(s, rt2);
     TCGv_i64 t64 = tcg_temp_new_i64();
@@ -4068,7 +4069,7 @@ DO_LDST(STRH, store, MO_UW)
 static bool op_swp(DisasContext *s, arg_SWP *a, MemOp opc)
 {
     TCGv_i32 addr, tmp;
-    TCGv taddr;
+    TCGv_va taddr;
 
     opc |= s->be_data;
     addr = load_reg(s, a->rn);
-- 
2.47.3


