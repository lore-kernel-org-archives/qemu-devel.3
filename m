Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 632D0D148A0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdick-00082O-Ea; Thu, 08 Jan 2026 00:31:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdicK-0007pV-E6
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:31:28 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdicI-0005Ug-Iq
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:31:28 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7aa9be9f03aso1812432b3a.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850285; x=1768455085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nmpUZl7uu93xpl03P28ZJOpHBDsxSLhCt5E8UK4/dbM=;
 b=gPyZcjv0RMjfq0r1glRAS2MhPRXzp0TwiXGNmiZnsldqcx1LvASIbsRNQSJ6cuZHr3
 CHtx4F0k6o2ev6IYqXpkW0xIQqLqKLvb0bpDCfBKd5uMRefFHfCHufTSidx8QemcNNDA
 Xjr8dbWquprOZWCYjsLSQ/fXdbFHU4AA21p4VC2Rvnr0amFPKq/vxzySIp1T52byZFYK
 1EkBPcN2VnrA2FzE/EVACqLqFZYe/X/ZJzZfnxDSRABdPgD6ZmaeFE7Q9V8wB+1gZbHG
 PIMHzuro8+4VE3NHA89dgvu5i7S/mcJGyyyPde0l3+ivzhgszbxx6od1DESkS2S2oi6B
 zApw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850285; x=1768455085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nmpUZl7uu93xpl03P28ZJOpHBDsxSLhCt5E8UK4/dbM=;
 b=GDifo5IXA4ZpZjbU5mfrvjAx2uUSKSOowJ5mw0sxYWbW0xXjjbG6/1ugCGgQbkIcRz
 eQ9achBgscAkpKPAxbVJUtMpu7GW3C3A/6PAfwm+2Kng+uyuIZTEKqGlCYDnr5biDMhr
 hUIlxH5Cm1MRyRVGkUS3J8CpSYu7h2NcnmSDBiPfCOKf/6ynQ9FDBVMaOAtD/VtKGEH0
 RWx6cIdCncU8DvIT0pAu0wZLA0QZ9f76+4eJ9NnK+lOp5zGFivWFDM0otlIoHKkc6yeu
 YZ67wRwuxIu30eS/gcaYaUKAKg02T3MFKB0WsmyF3YVR0tlWZacXbtW1imSicIZHiwjs
 Kitw==
X-Gm-Message-State: AOJu0YyODtmtSGehm7YQd6YNNtwIV78WDVFwDdehJ1MOVj8dQkwaJBC+
 Y9jcQwQomGp3t5AUatcS3gH6AchG29rLdD/hIeLIewbq/o5OYZRENhVHSxJRz0Z58n/zLwhP6LD
 +RF+OcZQ=
X-Gm-Gg: AY/fxX5OklpNZMImWTcDVYWVhOmbpWwtnyzUmNdLbNAZyKwrL/Y7OHmjh0jzYNwGXXy
 dYgoFJpYtI89VPGsgYqbL7kpHRjLsu4YE1PlvFlb5m23isz477Rdv4CxD5iVBdXWfmyPV7HwOPS
 Qj+KdQtU7ZL/JPTFMJ5mwLcpzJFzzKsFesG1tEEweM9i2YXlstoUJUKnrNf/ti9rY2aGVE0ValQ
 ejl0G5e8M5EVK9/LiEnta4qQfIkhWpPrT30ZSbPBmCkEsiBUIeyshXqwTLhBx2KK9z4c+5ypgjX
 iBXHE0NXsPiGg3DzKu/DBbWPbMPx9A2W7mSOROAQSxm4z2/6nivu8Y0gV9xL7oUqZ7TO66q4EJS
 FZPBFZhyeaNtBxzMzbVpHdGxoPWUEC3bVAlwKqoT7Eq+gU+vIcNpnqHoVTa/+8SPL7i9nb1UfVm
 BsYzXAT9DfEMxxcY2quA==
X-Google-Smtp-Source: AGHT+IEyRmnbTIiC3ZA4ooyLvpsOKlzyZKaXPGEgmgLWvFrF81n3zaXsnfwPcF/p+U2hDlSCXkH1LA==
X-Received: by 2002:a05:6a21:3381:b0:366:14b0:4b04 with SMTP id
 adf61e73a8af0-3898f97be3emr4587218637.64.1767850285045; 
 Wed, 07 Jan 2026 21:31:25 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm7036552a12.16.2026.01.07.21.31.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:31:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 31/50] include/tcg: Drop TCG_TARGET_REG_BITS tests
Date: Thu,  8 Jan 2026 16:29:59 +1100
Message-ID: <20260108053018.626690-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op.h  |  9 +++------
 include/tcg/tcg-opc.h |  5 +----
 include/tcg/tcg.h     | 27 ++-------------------------
 3 files changed, 6 insertions(+), 35 deletions(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 232733cb71..ee379994e7 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -31,8 +31,7 @@
 #if TARGET_INSN_START_EXTRA_WORDS == 0
 static inline void tcg_gen_insn_start(target_ulong pc)
 {
-    TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
-                            INSN_START_WORDS * 64 / TCG_TARGET_REG_BITS);
+    TCGOp *op = tcg_emit_op(INDEX_op_insn_start, INSN_START_WORDS);
     tcg_set_insn_start_param(op, 0, pc);
     tcg_set_insn_start_param(op, 1, 0);
     tcg_set_insn_start_param(op, 2, 0);
@@ -40,8 +39,7 @@ static inline void tcg_gen_insn_start(target_ulong pc)
 #elif TARGET_INSN_START_EXTRA_WORDS == 1
 static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1)
 {
-    TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
-                            INSN_START_WORDS * 64 / TCG_TARGET_REG_BITS);
+    TCGOp *op = tcg_emit_op(INDEX_op_insn_start, INSN_START_WORDS);
     tcg_set_insn_start_param(op, 0, pc);
     tcg_set_insn_start_param(op, 1, a1);
     tcg_set_insn_start_param(op, 2, 0);
@@ -50,8 +48,7 @@ static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1)
 static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1,
                                       target_ulong a2)
 {
-    TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
-                            INSN_START_WORDS * 64 / TCG_TARGET_REG_BITS);
+    TCGOp *op = tcg_emit_op(INDEX_op_insn_start, INSN_START_WORDS);
     tcg_set_insn_start_param(op, 0, pc);
     tcg_set_insn_start_param(op, 1, a1);
     tcg_set_insn_start_param(op, 2, a2);
diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 28806057c5..61f1c28858 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -109,9 +109,7 @@ DEF(extu_i32_i64, 1, 1, 0, 0)
 DEF(extrl_i64_i32, 1, 1, 0, 0)
 DEF(extrh_i64_i32, 1, 1, 0, 0)
 
-#define DATA64_ARGS  (TCG_TARGET_REG_BITS == 64 ? 1 : 2)
-
-DEF(insn_start, 0, 0, DATA64_ARGS * INSN_START_WORDS, TCG_OPF_NOT_PRESENT)
+DEF(insn_start, 0, 0, INSN_START_WORDS, TCG_OPF_NOT_PRESENT)
 
 DEF(exit_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
 DEF(goto_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
@@ -184,5 +182,4 @@ DEF(last_generic, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 
 #include "tcg-target-opc.h.inc"
 
-#undef DATA64_ARGS
 #undef DEF
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 067150c542..60942ce05c 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -43,19 +43,10 @@
 #define CPU_TEMP_BUF_NLONGS 128
 #define TCG_STATIC_FRAME_SIZE  (CPU_TEMP_BUF_NLONGS * sizeof(long))
 
-#if TCG_TARGET_REG_BITS == 32
-typedef int32_t tcg_target_long;
-typedef uint32_t tcg_target_ulong;
-#define TCG_PRIlx PRIx32
-#define TCG_PRIld PRId32
-#elif TCG_TARGET_REG_BITS == 64
 typedef int64_t tcg_target_long;
 typedef uint64_t tcg_target_ulong;
 #define TCG_PRIlx PRIx64
 #define TCG_PRIld PRId64
-#else
-#error unsupported
-#endif
 
 #if TCG_TARGET_NB_REGS <= 32
 typedef uint32_t TCGRegSet;
@@ -147,11 +138,7 @@ typedef enum TCGType {
 #define TCG_TYPE_COUNT  (TCG_TYPE_V256 + 1)
 
     /* An alias for the size of the host register.  */
-#if TCG_TARGET_REG_BITS == 32
-    TCG_TYPE_REG = TCG_TYPE_I32,
-#else
     TCG_TYPE_REG = TCG_TYPE_I64,
-#endif
 
     /* An alias for the size of the native pointer.  */
 #if UINTPTR_MAX == UINT32_MAX
@@ -605,23 +592,13 @@ static inline void tcg_set_insn_param(TCGOp *op, unsigned arg, TCGArg v)
 static inline uint64_t tcg_get_insn_start_param(TCGOp *op, unsigned arg)
 {
     tcg_debug_assert(arg < INSN_START_WORDS);
-    if (TCG_TARGET_REG_BITS == 64) {
-        return tcg_get_insn_param(op, arg);
-    } else {
-        return deposit64(tcg_get_insn_param(op, arg * 2), 32, 32,
-                         tcg_get_insn_param(op, arg * 2 + 1));
-    }
+    return tcg_get_insn_param(op, arg);
 }
 
 static inline void tcg_set_insn_start_param(TCGOp *op, unsigned arg, uint64_t v)
 {
     tcg_debug_assert(arg < INSN_START_WORDS);
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_set_insn_param(op, arg, v);
-    } else {
-        tcg_set_insn_param(op, arg * 2, v);
-        tcg_set_insn_param(op, arg * 2 + 1, v >> 32);
-    }
+    tcg_set_insn_param(op, arg, v);
 }
 
 /* The last op that was emitted.  */
-- 
2.43.0


