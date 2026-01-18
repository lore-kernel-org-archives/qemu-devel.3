Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FC9FC9830C
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Jan 2026 22:06:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhauP-0005ei-QY; Sun, 18 Jan 2026 17:06:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhau3-0004X4-JJ
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:47 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhaty-0000wV-Jg
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 17:05:46 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-29f0f875bc5so25188625ad.3
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 14:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768773941; x=1769378741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SRTKY77Q5AGOWWtgWUqll/eZ5kBhHSvVz6RI7rqXw3s=;
 b=CHoH1mn7qz6q6W51iyKzq3z69hwUZw+e4Wkaz4DlOWCx4c+R6bqc0r7pT5FWojw4nT
 lZqcOY5baY6IGw1UoG7+yq9rR/b3GZAuF2eGuT403mZXaW5QUcOoxQYWstW5IhcX415+
 HDANawinJcZBWv4NW/9359vvYC5qrEC0kKKxexhxWWC7SuDPvzxA/+dcUH0ca64VSRos
 49YGyBgwmgypJgQffBtNG+GyFafC2UMyx46Cyf0cVITdsZtnKJaCBdh8RhF54dakkxAc
 AmPyUq1Vyq//iXCa4JJFQnt5idTVnPO94Zbz+w9Lt40GWP+lGlZNKNZDuS9DqN76MTTR
 PObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768773941; x=1769378741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SRTKY77Q5AGOWWtgWUqll/eZ5kBhHSvVz6RI7rqXw3s=;
 b=skh6sBkMclOoeeViwuUiLAGi3n8pdzY/BIBvxkEys7eeWWThDTzFbapRMjv9pfAJMA
 f1luy4anPPknTB48MEVEpj/TycXpTICqc9OymaoAfdiaBfij8gYSpXIU8afPIWpbJsNd
 /mx45RErjRSHk+5ie2moRyZXciWPvufs6aijikKrFQhhYi37mW9tch22IVI4K7U0pAnu
 QaMRKk+ZAr8uSkO1uZY0l1XUmbpbWBc46JeQg2Hi5Vz5MM2So4Meo0TDhPCwSG2nQ8up
 CNqMsYc5mlLSb4ch2UEiozmuX1RsFOcOpiGxkR1Ftm0YxzxXNXv9EnExL3t8rvIE8Gul
 Nyvw==
X-Gm-Message-State: AOJu0YzrvGRItapHNME3C4lnejt8YXqIjHFdf7UMBNLZbIEiBCRr7XCF
 kRyRfXb8JgbCQ0g/hcgSV1bg5am07dFyQKsV7cNpg4O4T0yX7NhukA6JJlUzi6gZDa5cgKVtyGq
 v557e25JOfA==
X-Gm-Gg: AY/fxX7uDsnfbwtEI0vyYWpQYmXIN+r6tOlP/JUK6TcOvKO8qGeG/2EQpuHF3NIs5Xs
 3/zw+Yaliz6/af+r1JzFKgXXcp9tX0xBBlLtWLvc/7x3Wy7fiUXzvBJ/2gz43dbsZIkDC7zdCXc
 kK0Rn0Xo1qyV73r/O0E3AmTsjaf1J72brCQflucV4o996W1wtjlSSToJLeH4KO1aN+UzzyQEV/y
 UECGPK/M1jGlCC6s+y+vrkTiUIpFyQq0Dm5lrLeCtj9vvAMyKl+FwDPo/LxqyArwQCz9+2uP1s3
 2LBk+rZ9Q0qRYqbSnPXr7GAqpvYtKx0kOxDuM5vxRTbspfvo/vlLKjqtifC89rbcrbgd82RXnki
 NreFr1AUZlS/iiDWmbYGM+58C0Qs9yuK0CCwRZR0MqqJQEinXD3J4RIwsoemw1V8zn3ND9lbwIN
 lQtYHn/PV5ofwgTuBB8A==
X-Received: by 2002:a17:903:40cb:b0:2a0:faf1:782 with SMTP id
 d9443c01a7336-2a717519edbmr68746205ad.9.1768773940990; 
 Sun, 18 Jan 2026 14:05:40 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7193dbb74sm74402865ad.56.2026.01.18.14.05.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 14:05:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 34/54] include/tcg: Drop TCG_TARGET_REG_BITS tests
Date: Mon, 19 Jan 2026 09:03:54 +1100
Message-ID: <20260118220414.8177-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260118220414.8177-1-richard.henderson@linaro.org>
References: <20260118220414.8177-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


