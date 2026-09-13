Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92741C88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a88-0001CK-Q2; Sat, 12 Sep 2026 22:39:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7n-0008Ul-G0
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:25 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7j-000153-HH
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:22 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-cc4d03f95dfso1181497a12.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267156; x=1789871956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8kwqgM0BLxs8oIZVolw+c1jT3pCCVpXDnyKJRxNOapk=;
 b=hUpuyPQAvlG8X4JRZBMwub3AX1o1O9yD2X6gsJ202IAubKcWYfdglbzBqX5Xgnu3OP
 3hFfY3IoSnNF3M1dCxeurdpvDFrc4qxY5pclyAXxV/gx0Uml6+yzCWjUUjDEt4ge5j6G
 c+6W1kLmwzY5Gy0XlAzzgKcinf7CjGWfYC5Z+zzx0HrgFRtncpO4ubsZFpduHJQuZN0p
 hDK/LK45SxCsEu41v0ndscJlb0ksLxvzGSBay9uExLNmoEEdMmJw5ec2zD3ugfL4kcrc
 QkJ5xycap16xO/qYljOIWbjxRHEBMCDwyqExtfx1vaQweVlk3MBMamNErY24ymIa1SE5
 EDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267156; x=1789871956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8kwqgM0BLxs8oIZVolw+c1jT3pCCVpXDnyKJRxNOapk=;
 b=Fn3i/ZgKBGDRKzh47LXytqG/jUfu8FdStgPaocCzlnZ7lmpqWdKUHBILNG4U9wjVuK
 xvhnTt1g4f0roOxba66ipnX2FzsKlSR+Xll53a9JMqi/91xe1fBgZztwzqLkwx3Svd/c
 wnwu2c3N6yy24ZlGcf/AtHIYlz8BXw7+TKdAv6kl8TC6to27rPVYrXh/GQIaYruUOHLo
 Wu46fkBsMAKD5hH8fT7sjOHb8hmgGUcT6muR1BWjp8SvSyzYDUWZBKdvNZ3i683Tmk7f
 t1c/AaYTCCkBkVLfrr/h54ZNsPbpe0UH3MDFaHbYO986FviSSHYRKfHqJI4LSNJ0G+n3
 xmYw==
X-Gm-Message-State: AFuF++nxBUaapS57BCCAFmIn8PDiBkUdK4zX7frLDKnQ6HKP4l/ogHlt
 Auez2r4jsuaHj2dhcinj8wjyY1bT7n/PfIHCy6psK1AV0l+A93qKWmddt7N9y1hfyjNsuIlNiES
 B71+pdN8=
X-Gm-Gg: AYBFou3Goh365bIoEgrUUofasykx3owjRf0vK0xfAKs4sCtpkFUMtNb+bFlp2y9zo/U
 8tl9g/anrxfo/cS3unEJR3l1eWb/Xr2ugC8pO8Vy40q1ULQJCdp4uUb34vRhRazis4HVGox9hZF
 sFaYMT151x9f95nBXWzHxVhWUy/Ic60sc4fSrzJFFoQwe11UT5U8OG0NoQLFBuc8xgcdWhSyYIP
 Xj4b71dAnxDLHanh6gW962cUSf/12DT5Wu+CggWfI2lzDj84nlQ6KW2I0KlVqwyBtUw+f6c35mv
 AEZ/Tq1m6DTjHJyGDWQY2qWktDCSbbbTb1LgBO6injAJZqn7HOCt6qPqe1xkmwSlGivi2EO2nR+
 Sy8gXTElM9aE0YXezAnEUWQ8AUlCdNCJlJU55RL3bgnFGMOswue1s79t24swgvMDihjZLxc5i4k
 oaMX2R4paB/R/fYp+wkvZNiG9bMSUwJigsLxrWqikVUkjTxQpyDVlauYc4T6PCpfNy8ccVOeiac
 oVUEPQS
X-Received: by 2002:a05:6a20:1611:b0:3d7:eb3e:1c58 with SMTP id
 adf61e73a8af0-3daed1c1684mr22441905637.8.1789267155914; 
 Sat, 12 Sep 2026 19:39:15 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.39.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:39:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 31/86] tcg: Generic expansion of tcg_gen_remu_*
Date: Sat, 12 Sep 2026 16:37:42 -1000
Message-ID: <20260913023837.741866-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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
 include/tcg/tcg-op-common.h  |  2 -
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 75 ++++++++++--------------------------
 3 files changed, 22 insertions(+), 56 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index c2cff4419aa..4bcc8890af3 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -202,7 +201,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index e67f11176d8..cffbb4d08a8 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -16,6 +16,7 @@ DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
 DEF3(rem, TCGV, TCGV, TCGV)
+DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF3(shl, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8e7f92d5251..89b62d1d526 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -236,20 +236,6 @@ static TCGOp * DNI tcg_gen_op4ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                        tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3, a4);
 }
 
-static void DNI tcg_gen_op5_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                TCGv_i32 a3, TCGv_i32 a4, TCGv_i32 a5)
-{
-    tcg_gen_op5(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), tcgv_i32_arg(a4), tcgv_i32_arg(a5));
-}
-
-static void DNI tcg_gen_op5_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                TCGv_i64 a3, TCGv_i64 a4, TCGv_i64 a5)
-{
-    tcg_gen_op5(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5));
-}
-
 static void DNI tcg_gen_op5ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
                                   TCGv_i32 a3, TCGArg a4, TCGArg a5)
 {
@@ -571,6 +557,27 @@ static void gen_rem(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_remu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_remu, type, 0)) {
+        gen_op_ttt(INDEX_op_remu, type, dst, src1, src2);
+    } else {
+        TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
+
+        if (tcg_op_supported(INDEX_op_divu, type, 0)) {
+            gen_op_ttt(INDEX_op_divu, type, tmp, src1, src2);
+            gen_mul(type, tmp, tmp, src2);
+            gen_sub(type, dst, src1, tmp);
+        } else if (tcg_op_supported(INDEX_op_divu2, type, 0)) {
+            TCGTemp *zero = tcg_constant_internal(type, 0);
+            gen_op_ttttt(INDEX_op_divu2, type, tmp, dst, src1, zero, src2);
+        } else {
+            g_assert_not_reached();
+        }
+        tcg_temp_free_internal(tmp);
+    }
+}
+
 static void gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -710,26 +717,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_remu, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_remu, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_divu, t0, arg1, arg2);
-        tcg_gen_mul_i32(t0, t0, arg2);
-        tcg_gen_sub_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 zero = tcg_constant_i32(0);
-        tcg_gen_op5_i32(INDEX_op_divu2, t0, ret, arg1, zero, arg2);
-        tcg_temp_free_i32(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_andc, TCG_TYPE_I32, 0)) {
@@ -1590,26 +1577,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
-void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_remu, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_remu, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_divu, t0, arg1, arg2);
-        tcg_gen_mul_i64(t0, t0, arg2);
-        tcg_gen_sub_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 zero = tcg_constant_i64(0);
-        tcg_gen_op5_i64(INDEX_op_divu2, t0, ret, arg1, zero, arg2);
-        tcg_temp_free_i64(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 8);
-- 
2.53.0


