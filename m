Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3382C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:03:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAklN-0003Ze-7k; Sun, 27 Sep 2026 05:01:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkm-0002ZR-3z
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:01:03 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkke-0007Tj-Jd
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:57 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 98e67ed59e1d1-396ccdaea76so711076a91.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499646; x=1791104446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4gegqgHhIfw0fSNSSLYb7jpm5LlIpAnZqVYYYGQkO/E=;
 b=gGRDZo5AkWs6RE2FlEV3zSINBe60r8DetR7BTUnI+1ltDODdtsxIG2dnt2AycrjoX4
 PGkEWoSNCZnrmmAqJ/ggg6VLxeWfAl04sPp3NmaKritnbrIblbGPhPY2iL66EV6ePKej
 Z8de+YYLgxFjlCsRtUK2LUYgrjfF4Iibc3FNSrdIZ0X42VSpZwY5GtyJVBymMqwvSIXm
 JAfP6G5ytN7oOZ+g4vbovdzuDqtM/QBZdmeS/ME+OsO6Zdkgln/3GDtsnUqFnlToC1RT
 SLsRx9FeJkoUnNVo8BdnsknEVS2k6Deyf9agKlw/VrFwGyWHf6gYwXed7IpKX28bNkvh
 m0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499646; x=1791104446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4gegqgHhIfw0fSNSSLYb7jpm5LlIpAnZqVYYYGQkO/E=;
 b=Ze+5ujtcxRI1W8o3upebkz+0UblmFW0wjIJ8XEc0jDzstDuqqE+5vrB1AOkPsrjRy5
 ShChNgh75wmxEwWGrPKARAdlcXaLXqCe+X4kVNHOSJ9tEhMyfL9uSAbKNJjOlmQO4CZg
 Q2fAVHrlBzxUSWB16Qm7QbCm49gg52aLaZsuMVwl2JPt6XKz+bBHRlBIiEs3e5n3MFwj
 R8fYATjSTgrGMLnSeZYJWZqWGIqkQV8yTZ5HjjTILky+8KWdlw8DSxDMxHClM/4BHPCG
 LxQG2be+UfqInOdtEHX0P/ObIufKqQp/+WL+dhtF7ymSqR09uKpxOGMVA5SQX+f1idL6
 VeJw==
X-Gm-Message-State: AFq9FYLGaDg97DJfeB9GFTbg6gAP5iwXI5FBwoBE9k7e6aQspoL/r6sv
 2KzOm3dakBb8MZwB5HH1JDt6Znx4F/rFcPzJVVZeORawCL2JUqXJIZiOQKkQHbeh039YChZgMEt
 c7Apu
X-Gm-Gg: AYBFou0Yi+ekfby+TcA7q8JshGNw2T6lY6cIqlK11bOFFIAebpHdxXS3BK5ZKGJlc8H
 /m/6fI52pnD1r06RAB7bVdIljq2qwwzFyKKq1kzH1o+O7qhojSpGOKglAx0m7yyzu+3ebRQt0CI
 zvJ0MuLIHruT/lGjvjBMo8YUgzi7Atdd2vikjSAjZbGhEuV50GksqREo9aWNNGJLU1VW/b5YCP6
 gSvDeYkErZNot95E1d2H7G8xO/UesCR11BrsGso+hhoEwUGflxDrRv18UhfGlxkhvYDMJA/Zmnu
 EkFHnNboboMialH8fAD1uPHUP9LbYa5kXWuGsS+iRC6fJw/v6DFg7idEj5WsOdf7k0Ch7PM+Ico
 SnVnMTmyxRbY5yLSox3YOyTJneQGHOPLTeGyJH/EnZHcYYA6crQrjL+mRamXmN3AApE51zQdWcz
 ognRtXcawBO2jQQ5yeMzBwJNNVRkYYp0dmlRqgE7q2p3x1ScpROzlPoEjnh7vjT7yE2C4/lN3HJ
 1u9b7eMoASe5LrxWhy9pG8/fXQrWfINLfl9URTo
X-Received: by 2002:a17:90b:3bcf:b0:3a0:bdcc:51b0 with SMTP id
 98e67ed59e1d1-3a0bdcc52ffmr3601431a91.30.1790499645684; 
 Sun, 27 Sep 2026 02:00:45 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 034/101] tcg: Generic expansion of tcg_gen_div_*
Date: Sun, 27 Sep 2026 01:59:04 -0700
Message-ID: <20260927090011.10724-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 include/tcg/tcg-op-common.h  |  2 --
 tcg/tcg-internal.h           |  8 +++++++
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 43 +++++++++++++-----------------------
 4 files changed, 24 insertions(+), 30 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index aa4fe339d8e..bfda3c1f444 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -205,7 +204,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 76c8f026a64..6b65228241e 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -120,6 +120,14 @@ static inline TCGOp *tcg_gen_op_ttii(TCGOpcode opc, TCGType type, TCGTemp *t0,
     return tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), a2, a3);
 }
 
+static inline void tcg_gen_op_ttttt(TCGOpcode opc, TCGType type,
+                                    TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
+                                    TCGTemp *t3, TCGTemp *t4)
+{
+    tcg_gen_op5(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2),
+                temp_arg(t3), temp_arg(t4));
+}
+
 QEMU_RET_ARG_NONNULL
 TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op,
                             TCGOpcode, TCGType, unsigned nargs);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 8c9d3d99c48..778854286cc 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -6,6 +6,7 @@ DEF3(addi, TCGV, TCGV, TINT)
 DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
+DEF3(div, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 67ba4a0307a..203de8909fa 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -411,6 +411,21 @@ void tcg_gen_discard(TCGType type, TCGTemp *src)
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
 }
 
+void tcg_gen_div(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_divs, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_divs, type, dst, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_divs2, type, 0)) {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+        int width = tcg_type_size(type) * 8;
+
+        tcg_gen_sari(type, tmp, src1, width - 1);
+        tcg_gen_op_ttttt(INDEX_op_divs2, type, dst, tmp, src1, tmp, src2);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -609,20 +624,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_divs, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_sari_i32(t0, arg1, 31);
-        tcg_gen_op5_i32(INDEX_op_divs2, ret, t0, arg1, t0, arg2);
-        tcg_temp_free_i32(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_rems, TCG_TYPE_I32, 0)) {
@@ -1537,20 +1538,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
-void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_divs, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_divs, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divs2, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_sari_i64(t0, arg1, 63);
-        tcg_gen_op5_i64(INDEX_op_divs2, ret, t0, arg1, t0, arg2);
-        tcg_temp_free_i64(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_rems, TCG_TYPE_I64, 0)) {
-- 
2.53.0


