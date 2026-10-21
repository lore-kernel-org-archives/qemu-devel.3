Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CB4606A31B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=DE0riAS8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXAE-0005lf-6W; Wed, 21 Oct 2026 10:19:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX9B-0004lt-4G
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:18:36 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX99-0001aa-6i
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:18:28 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so542570f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592305; x=1793197105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hnJ24G8iZ/T5m8en43ab8M2encxaekBHIaz4gUs1qGs=;
 b=DE0riAS8hzePRshSXA8RIfViwVv2P3i15mTBQJb0W8XDLz4mb8cGT9hx6ijTepdkgm
 fd6WXoTjzuFY3vaBnb3YLkvEGOdKEfboSHIe9XjEpmh9Ew5oINXZwotNz0R+HjUnVaxE
 rM6a4Rz528Ss+TPpwiq9iTfo9AYBgL7dUA1eAEjCww3iavIjjO5EJGHrwXg3uwZ8WYp8
 +nssXbpm8GpHehLcJn9Nwf740y1v3SyiiDf44qS7U8HsbHhFftnuzOWiUCbfp5igiodO
 pZrSR+NTF+zzToN9fDTNcaohFnZBfDqeNBks0hme0YtvvNIkkoQLRLiFpUoLaTLQMdC5
 pdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592305; x=1793197105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hnJ24G8iZ/T5m8en43ab8M2encxaekBHIaz4gUs1qGs=;
 b=Vfa4DcCXPfZodMq2O5LEF4IWdxvdeEMHW3AVnpQsv1/9Ypa3bFyZa1GW7ssEkvDwm0
 mZVaPqbU2eCvGW2t2KuEHUUJSxY15lMmRtO+GZdtp/4rHvuQKSOh9QT39ALLNnjAhvgK
 qDK7UjnoSuIWrOKFxHaRceRtFXORhcxSXJATTEJ3hPzjfC8DDC672kkbu0XRpe9pU5Ov
 dY77vRDyq5JDf2hl1ktCEFUEKM3GmlCgCYOaNi4hpdOnmimkfzFoHrRzvxXTxfH7l3w6
 u5SSproidJkX3fzT0Hzf5077NszHp1Xs3/uNNZQYFfmHRJ3k4E02WbhEBCHfLTb3SL4x
 mFNg==
X-Gm-Message-State: AFq9FYLUXS38N/rzV8Wbd1/H/1S9M02r9apK4PEnUqRwdrDwWpxyiaQQ
 acaepfq5/538m1B3P5OA/uZrWXH2SSmSBfiZk1AeEKdKf7tgTFctwuyCFjEv1sQBqF2dCZDA09e
 HikeWiPg=
X-Gm-Gg: AYBFou0HYsEfO8OhIfReEXejXXYE58XmpUuL8wfnY1nrpRZuakj3l7k1yf4yl8MlN0R
 boUAyEUH+Vegh3A4uPnBPcvMm8ZLd88NaevLhfznKPhROJMKtbCQx/+S1cMwf0nAQQ4q0mCrZCk
 sIf0lNY20By0VDOcmkRgSW7IHQh8IcW7zcu+rJIArLIduc+Q1IAlsR1kr4aL7sj4ESvo9nTu4xe
 WOfojHXP3GaGkfb/JUUNJ3VwAroKizXJhTKXX5In+nnwZY9Xb+cfQfz52Uy6RNIU0a5ILhlc/ZN
 t0YOYzd7g8bfkw4BLJeHJBhVGpSiLQh0+kdjoZkSQ4z+O8mUbadCUzCrcPekqVtP7AUHJTFUPJ/
 0w/WvrAhMc+F+0kLS+MTC0OpuDfRRENjzo4nuuCuHhI9xycYrBQTV6jRC8vrw/8KXBHhfWDdGqI
 BRtE2Nl8Qhr8DXZU/1uYs+936OadWHZ3nWAK8wjieXy3XcZAi5A/AIn6ab6WmsTQIxZjp6pxHs0
 FY+GHjytwfx3gzikpbDlBj7I2EQRJCCmqKdLAhK+tpSDq4YBwx/Oc6LGyQYYvWM+wYoCSmgiZl3
 vZjoscLEjJHrNg5NeylkhaPshnqycjz17180SmoMbKxGxHKW
X-Received: by 2002:a05:600c:4585:b0:4a1:6c79:fd31 with SMTP id
 5b1f17b1804b1-4a1fdb132afmr48159615e9.12.1792592303960; 
 Wed, 21 Oct 2026 07:18:23 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:18:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 026/100] tcg: Generic expansion of tcg_gen_andi_*
Date: Wed, 21 Oct 2026 16:15:38 +0200
Message-ID: <20261021141652.363109-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 -
 tcg/tcg-internal.h           |  6 +++
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 84 +++++++++++-------------------------
 4 files changed, 31 insertions(+), 62 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 7ca448b922..1108d185e8 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -211,7 +210,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 0da1a9c440..76c8f026a6 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -114,6 +114,12 @@ static inline void tcg_gen_op_ttt(TCGOpcode opc, TCGType type,
     tcg_gen_op3(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2));
 }
 
+static inline TCGOp *tcg_gen_op_ttii(TCGOpcode opc, TCGType type, TCGTemp *t0,
+                                     TCGTemp *t1, TCGArg a2, TCGArg a3)
+{
+    return tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), a2, a3);
+}
+
 QEMU_RET_ARG_NONNULL
 TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op,
                             TCGOpcode, TCGType, unsigned nargs);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 2108082ce6..f7e7f4d2a1 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -4,6 +4,7 @@
 DEF3(add, TCGV, TCGV, TCGV)
 DEF3(addi, TCGV, TCGV, TINT)
 DEF3(and, TCGV, TCGV, TCGV)
+DEF3(andi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8c298ae79a..34e1e736be 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -382,6 +382,30 @@ void tcg_gen_and(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_and, type, dst, src1, src2);
 }
 
+void tcg_gen_andi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    if (src2 == 0) {
+        tcg_gen_movi(type, dst, 0);
+    } else if (src2 == -1) {
+        tcg_gen_mov(type, dst, src1);
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
+                tcg_gen_op_ttii(INDEX_op_extract, type, dst, src1, 0, len);
+                return;
+            }
+        }
+        tcg_gen_and(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -485,36 +509,6 @@ void tcg_gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 
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
@@ -1493,36 +1487,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
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


