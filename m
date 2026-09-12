Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF68C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L21-00063C-DV; Sat, 12 Sep 2026 06:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1U-0004ru-Px
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:57 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1S-0007JQ-V9
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:52 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2dd4b3c752fso7572715ad.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209109; x=1789813909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gOejFpznoDwQMPvboJzR2oYG0+hbpPdBs8bLYbMA+FU=;
 b=YuKh3O+baLg0Fh/+nVn2tDsoxRos1NZhAlt676rjnxEVpVyoGzwBdyyHi+xbAA65xS
 0oOf1XAWi9VVURh5/1gZe4HcCFBLgdcWQCoP4deLAWl9H9yjY7wNcaxYwdYsCElV/NAn
 oBSW9Rvn74w8NdQ6eIHFEu95So45V97HzrfTC24vuTQLoehw+URVvIimuu5FXQK9BNKd
 7Ju/9UnswfFUSlDYgBu9j0oil0iRj0JIiobkpIDuSxNAuGAWwJ3GhWzPfwnrIsQiIFQE
 /gpt2YLJd5yE5qwwWCVb/XtT4NmM5X/9hiAPxTkxIa4PmKaVvHkYIxM7MfUlANL/qvGG
 9fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209109; x=1789813909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gOejFpznoDwQMPvboJzR2oYG0+hbpPdBs8bLYbMA+FU=;
 b=GUQabIzhxGKNGe+NasAfGfpLO9ZxLn3s7zjb/hjvUO26Y3qop0aDxjLvPjnwLUk4Mc
 2F2PeLJWhB6E0WI/F4CM23TmARmsUZ85Ajzq2BqmMU9QO3Mp3opDCCrkKB9VnBC85lno
 RIOXgv5apVWDg8F752/9JwnciskW1aHqM/EjRKnrX+XYQmWHMIdeq9Fc+b7ixiVEo6Jk
 ztsc2/wN9dRisjYN8uHMat/l1kVnYYK/gTW3WQ7VSJyHEZ5DrwUldcLRiLEFTMYn6Yvf
 SPWv4L35u1QDc/V8bJbxHCXScG6l/+WD6cI2T34jojNzB3XqHFrhp2RSrtHIJOcO19NJ
 pRIA==
X-Gm-Message-State: AFuF++mfltNhpKksq+4b+J4MwjVTmgLRuhGKwOkL9vgQYDUrih5q5euw
 204BpQr4B6ohSTHeYXNGkl6oRaB/vcViahT8IqWgNS9aTJL2wy/YdpM6SHh184V7HTRgV/VhUal
 Ny2kxEW4=
X-Gm-Gg: AYBFou1z7XN9IeDhIWUswOW2Efg3/AkPRTBLpXZFYWar/98UUTgbuFVCds3bHh7THNP
 3WdhQSfCq4GkyVgthBSDc8qljkMgRTKBZw+0KrDa5SpJz0bNfo1oiAbmSjK3QE9N9T9K4rgjZjB
 cNhBn7/Vk8Ej2qfLUwm4aS7SeKErbTbz74jjLMMyCv87f0tmozppRS16Qu7rWu5L24USYUnHqY/
 0sDo8HnFm/Cmw29EpzwJLAJy1n0ynj9HzcHMhRc1lLdZNLHyjazTFIMf92Jy4jjjp+rS83LhYZu
 P/9TFXqRn7UwXahHmy3YiPQOAFvoNkIZUVoLbMX4USXpKPAOXGGmnWu7sorAkOXCd19ZyqfAYXl
 GCw0eAS796cva0QAvZl8zaa8J8k+tpvJdpGfRJ89b2A2Xf+rUr86pLR7+xWWHYoZvW5prcs4/+L
 S29QiJm8vNDWzm9bj0htu2rzOotfnvnHtlA28A73BcFgrxCWmcTMuutS+gFwF5sVnTxkKvLUrM0
 WupB64=
X-Received: by 2002:a17:90b:4b0e:b0:398:9be5:b41d with SMTP id
 98e67ed59e1d1-39d9c368348mr13707520a91.24.1789209109471; 
 Sat, 12 Sep 2026 03:31:49 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 22/82] tcg: Generic expansion of tcg_gen_andi_*
Date: Sat, 12 Sep 2026 00:30:26 -1000
Message-ID: <20260912103126.598030-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h   |  2 -
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 90 ++++++++++++-----------------------
 3 files changed, 31 insertions(+), 62 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index ebc0f1714f3..3335e127083 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -121,7 +121,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -209,7 +208,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 0a17ebf5030..898b77b00c2 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -6,6 +6,7 @@ DEF_RIR(subfi)
 DEF_RR(mov)
 DEF_RR(neg)
 DEF_RRI(addi)
+DEF_RRI(andi)
 DEF_RRI(sari)
 DEF_RRI(shli)
 DEF_RRI(shri)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 5936ac43afe..c3e897d479e 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -115,6 +115,12 @@ static TCGOp *gen_op_ttt(TCGOpcode opc, TCGType type,
     return tcg_gen_op3(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2));
 }
 
+static TCGOp *gen_op_ttii(TCGOpcode opc, TCGType type,
+                          TCGTemp *t0, TCGTemp *t1, TCGArg a2, TCGArg a3)
+{
+    return tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), a2, a3);
+}
+
 /*
  * With CONFIG_DEBUG_TCG, tcgv_*_tmp via tcgv_*_arg, is an out-of-line
  * assertion check.  Force tail calls to avoid too much code expansion.
@@ -372,6 +378,30 @@ static void gen_and(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_and, type, dst, src1, src2);
 }
 
+static void gen_andi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    if (src2 == 0) {
+        gen_movi(type, dst, 0);
+    } else if (src2 == -1) {
+        gen_mov(type, dst, src1);
+    } else {
+        /*
+         * Canonicalize on extract, if valid.  This aids x86 with its
+         * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcode
+         * which does not require matching operands.  Other backends can
+         * trivially expand the extract to AND during code generation.
+         */
+        if (is_power_of_2(src2 + 1)) {
+            unsigned len = cto64(src2);
+            if (TCG_TARGET_extract_valid(type, 0, len)) {
+                gen_op_ttii(INDEX_op_extract, type, dst, src1, 0, len);
+                return;
+            }
+        }
+        gen_and(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -512,36 +542,6 @@ static void gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 
 /* 32 bit ops */
 
-void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    /* Some cases can be optimized here.  */
-    switch (arg2) {
-    case 0:
-        tcg_gen_movi_i32(ret, 0);
-        return;
-    case -1:
-        tcg_gen_mov_i32(ret, arg1);
-        return;
-    default:
-        /*
-         * Canonicalize on extract, if valid.  This aids x86 with its
-         * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcode
-         * which does not require matching operands.  Other backends can
-         * trivially expand the extract to AND during code generation.
-         */
-        if (!(arg2 & (arg2 + 1))) {
-            unsigned len = ctz32(~arg2);
-            if (TCG_TARGET_extract_valid(TCG_TYPE_I32, 0, len)) {
-                tcg_gen_extract_i32(ret, arg1, 0, len);
-                return;
-            }
-        }
-        break;
-    }
-
-    tcg_gen_and_i32(ret, arg1, tcg_constant_i32(arg2));
-}
-
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -1520,36 +1520,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    /* Some cases can be optimized here.  */
-    switch (arg2) {
-    case 0:
-        tcg_gen_movi_i64(ret, 0);
-        return;
-    case -1:
-        tcg_gen_mov_i64(ret, arg1);
-        return;
-    default:
-        /*
-         * Canonicalize on extract, if valid.  This aids x86 with its
-         * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcode
-         * which does not require matching operands.  Other backends can
-         * trivially expand the extract to AND during code generation.
-         */
-        if (!(arg2 & (arg2 + 1))) {
-            unsigned len = ctz64(~arg2);
-            if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, len)) {
-                tcg_gen_extract_i64(ret, arg1, 0, len);
-                return;
-            }
-        }
-        break;
-    }
-
-    tcg_gen_and_i64(ret, arg1, tcg_constant_i64(arg2));
-}
-
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* Some cases can be optimized here.  */
-- 
2.53.0


