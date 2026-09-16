Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC65C982C7
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pKZ-0002Nr-C3; Wed, 16 Sep 2026 09:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJx-0001UN-RZ
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:05:05 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJv-0000Uq-Fp
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:05:05 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 00721157ae682-85d43db0c29so7142997b3.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563902; x=1790168702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=J2jzham0sp1Pnj8xD8iAsee0l+4w5DFO7FCHd8VARjc=;
 b=mpHJbEfg4MkqqmpgdSiOpHFPICwAbCs9ZfiWQWV8vKjox3SLQi595+wpmabW/XuB1z
 ziIgvYvu4zPuLCw8CX306Q4JUGEWm3RiHe9LX+bQSxPbrHMr+vStDOUbMVLPaZHAExDH
 SsvBI+5QuolZ1N3rUnXBeLlnRqmm5TC7WW7kQAu+MlGNjTJ66TMiLe0lRp3lnKr7WQMD
 wzUcCUzOzvoRojW5vItCogyq3SPG+SZg6A/nDPzzGWuKwbDYU6WXbuxrmcoUPpp7G+1d
 6elCBpnNODi2m0d7FzQckXkxGNqQAkITCbUAbBnLb+/CABR+2z9mEIZTgSlp/fillON9
 bmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563902; x=1790168702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=J2jzham0sp1Pnj8xD8iAsee0l+4w5DFO7FCHd8VARjc=;
 b=H6Z1EF1S+9qjflT0pnO1Bi+a3OlGnBRvWmYn07sJ+66gwwiAHT8hcV5TS/bQBNKp0m
 xFqrwF+kfMHRU3PqmKZlM85tBb+CVKV90m73lQb3coTX2UQehP+Up5E2HzH04zzUyq2U
 6AtcZ1Yu2hdG4Rndiz8V+H2zUy7h8faLOmcnMZCLkAqgvofTGZJLlVQeNWN8eM3agJhT
 6zsga6F4m6UJJL+p5v1Ce4d0UE7JlydjWuni5MOLgvePXt3CSRsrq3LhaNbdeKQwUQs1
 W3hqXYGcOVUfWcWe6qcEyLlIZ6DVH+YyOerA4ElucMFplQ3iYiOipJyDV9QHsVvUEViJ
 ZhyA==
X-Gm-Message-State: AFuF++njVo54P88fEojX6JB52Joh9jlxowKee+JTFxHByrePcVTH3e0q
 HtMbWTd3H/ySaJcoJrLj/utZP1MXhaufdCRtjOUwgkPJ2w6QHEpkCXnsFRVs7KCEvawFKOSGPV4
 y2Gzrlus=
X-Gm-Gg: AYBFou2by5pM75sMk6gas5oir0BcEyRRPz9v3scVsZZ3glBa6sAbqTmD06K20+5dA2a
 g1JIzMXeLd7wakRn7Ic+9FhnilNUEXVOfSJ1Xy/eCbvkt411T3OXKzRI740+YWMd09PgtQhjD8p
 KuNRX+lLmyaqtnEi3b6Nu4E4f0RhCKOQual+NMte0yWHx8X1eBoDcWIHMkux4gLMukfvtSq6Dsg
 1QocLA7CVrmBouloxnmU7irbVCfSnvTr6nqRYOzwCWzdP1qWDFfQnZ4Gqih4P1V6H2wi1U2gLAN
 4IB+eHthrK7mWPXqISTOBEXM8Z6XLj21v7XrXT1Rjqs88mSoDI2uJWRBb+NTuBk9oUtceUzdoHl
 QW6qu+jpX3yxpGoWNX4pkQ4kFUqGvplUIE11hYcDPZEClvOr188N1lxHOl9+4+nl3c6jq6BL8XP
 WzzIvDpwqtLZaXZ6QKjVxc8gpY5316+trpL9RvVar4D6X2MgNNceI0oHVM8JX36oY+c3fUzwtXC
 3Do0P4=
X-Received: by 2002:a05:690c:386:b0:873:5c6b:a313 with SMTP id
 00721157ae682-8922996fa76mr6984677b3.65.1789563902105; 
 Wed, 16 Sep 2026 06:05:02 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.05.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:05:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 31/92] tcg: Generic expansion of tcg_gen_div_*
Date: Wed, 16 Sep 2026 03:03:06 -1000
Message-ID: <20260916130409.3382710-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-yx2-x10.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 52 +++++++++++++++++-------------------
 3 files changed, 25 insertions(+), 30 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index a8dffa7c5cb..2f8a9f48eda 100644
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
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 20007c90680..473d472823c 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -5,6 +5,7 @@ DEF3(addi, TCGV, TCGV, TINT)
 DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
+DEF3(div, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 5577f14ef62..a6b7e68514a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -121,6 +121,14 @@ static TCGOp *gen_op_ttii(TCGOpcode opc, TCGType type,
     return tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), a2, a3);
 }
 
+static TCGOp *gen_op_ttttt(TCGOpcode opc, TCGType type,
+                           TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
+                           TCGTemp *t3, TCGTemp *t4)
+{
+    return tcg_gen_op5(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2),
+                       temp_arg(t3), temp_arg(t4));
+}
+
 /*
  * With CONFIG_DEBUG_TCG, tcgv_*_tmp via tcgv_*_arg, is an out-of-line
  * assertion check.  Force tail calls to avoid too much code expansion.
@@ -451,6 +459,22 @@ static void gen_discard(TCGType type, TCGTemp *src)
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
 }
 
+static void gen_div(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_divs, type, 0)) {
+        gen_op_ttt(INDEX_op_divs, type, dst, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_divs2, type, 0)) {
+        TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
+        int width = tcg_type_size(type) * 8;
+
+        gen_sari(type, tmp, src1, width - 1);
+        gen_op_ttttt(INDEX_op_divs2, type, dst, tmp, src1, tmp, src2);
+        tcg_temp_free_internal(tmp);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
 static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -649,20 +673,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
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
@@ -1577,20 +1587,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
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


