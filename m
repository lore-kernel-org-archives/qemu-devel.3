Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A471F606A31B
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=bhUZF2z1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWT-0006eM-Nq; Sun, 25 Oct 2026 03:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWO-0006QV-AG
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:20:00 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWM-0003kj-0v
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:59 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48e0d1da913so1570608f8f.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912797; x=1793517597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lDBvrjLrrOvSe2txJboIbF+Yamog8rJsbFjqpY161Ik=;
 b=bhUZF2z1w8EtJC4lh92BFexjSdYZqT+C01RhHZffmniQ00CaqGsEIrHd7EUsg3fJud
 Z2DWcHWR/2VnXXw70B9vxEYEGTFCZFiYgq+VyVc9CiV8orVGgfmE+KSiSWCAlJRs7CeI
 MfX1vXJRdN3W87ieXntolPsg1DcFdhy0QKha5VVD49iGD/u+uvNDRYOH6qEa/0nrU/Ji
 tPjWMEbFghv6gtalMl6JaGgKfXE8RW14N6f6SUB9mXHVjCBqVCIaOVHunAWAQqci2ePo
 +S+3CGzsu4d4u22MCcyyRDJG22l8UcsdFvnFdUoR9j7hQELYupQnI0ec15sqAieGPRhV
 Xd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912797; x=1793517597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lDBvrjLrrOvSe2txJboIbF+Yamog8rJsbFjqpY161Ik=;
 b=LfF+dF6cXcIe8e3a0eV5y0EKhAAiKJzPbfV+NhogDC0hineFkDqQ3IJx5cuboFZsZ3
 iggyJ8IWVsux0Tuug2T7nefb2QuX/fWQvd+UPD62Ktt279aPlaKlOFizmWW2E6szKLSZ
 OZE/Qpi6Mta2vyUSIgPP2jI86PnwiXOqHv/7LAmDtR8LvlNY9ljDFwHF4J4rCECUa1vu
 CgNbF1hH7MPj7t8pHzv6aqSU4JKtgFqW12O6nedp/P5yoYfkfyz5q8CpeAAUa6PqRnv8
 aKfUcWEDDSHKlFd2lN4zpjXv+5mBrHO/BRczz7r6weGzHiAshiuPz4vXA8mAyyljphkh
 33Rw==
X-Gm-Message-State: AFq9FYJQfdZZFKRTtxT/RXsdubWlPfSW+IFDO2A1X6aovbiRyjdrcuqs
 EUC8ceYOIDC6+d6T9TP+S/CPPw9fzUBbZGBVjtvO/uZ8l87v4yd/cbPHt+ak05jHf9kVM+I0qIE
 IIOpKfd4=
X-Gm-Gg: AYBFou094BCNPAVTndgC0FVzVPE63IxE6I/xrhj7qhbnFX6Ni90m7laP6CUS3H1XKxv
 bb1tNWc1AWlHyQXblsBiOamOP9LaR+HT0iJEq7nUiA/1uBPa61lx1plQPOWHAmxsFXw4iZPxhG3
 XckFRrpp2HO5UcW2uAH0zMp1I23MgK6bBr89uOm2gcw+aAf3empDN2nTrVUhrPDd6y/hU6bkUTh
 AorrKoSDEJcBj4XAu2TMZcMRPtD1KvbysNMwGcAnAAFUeg16q+gc1p50p62HabjGrZeSGoZS2+s
 9okUvrAwGj7Jt/bzUWX79RrAZTdHPYPayaERisv3g3gWkk4GZIZ3SnFNUsfGX1SQm3nNmJisAS1
 xYh1ZgsQy31ZdsVAAHntstPPiah7FWDk5Cj3uQjm13n7dGU4cZRhXcwuMhzcZX8wewsPAd27KKr
 9CQ5+IKmWQzD/0A8AW+sX8xeI137rfDftYdUsQpYybBUXRt+r91bu8kEdLk1UPrCu08amlI2J4R
 BMgcA8VJWivOyBTjtCUWlfrGOk32YA8tS6veSFZroRX/Ydm3z3kNWX2A1A=
X-Received: by 2002:adf:fc4d:0:b0:48e:3c5f:a24e with SMTP id
 ffacd0b85a97d-48e3eb73979mr4265503f8f.11.1792912796642; 
 Sun, 25 Oct 2026 00:19:56 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 035/100] tcg: Generic expansion of tcg_gen_remu_*
Date: Sun, 25 Oct 2026 08:18:10 +0100
Message-ID: <20261025071915.1123867-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42c.google.com
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

Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 -
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 74 ++++++++++--------------------------
 3 files changed, 21 insertions(+), 56 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 9024963c06..d4d670dfed 100644
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
index 1b108d9f14..cfa19a0a81 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -17,6 +17,7 @@ DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
 DEF3(rem, TCGV, TCGV, TCGV)
+DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF3(shl, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1bfefb9d65..fa6c152164 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -211,20 +211,6 @@ static TCGOp * DNI tcg_gen_op4ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
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
@@ -518,6 +504,26 @@ void tcg_gen_rem(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_remu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_remu, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_remu, type, dst, src1, src2);
+    } else {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+        if (tcg_op_supported(INDEX_op_divu, type, 0)) {
+            tcg_gen_op_ttt(INDEX_op_divu, type, tmp, src1, src2);
+            tcg_gen_mul(type, tmp, tmp, src2);
+            tcg_gen_sub(type, dst, src1, tmp);
+        } else if (tcg_op_supported(INDEX_op_divu2, type, 0)) {
+            tcg_gen_op_ttttt(INDEX_op_divu2, type, tmp, dst, src1,
+                             tcg_constant_internal(type, 0), src2);
+        } else {
+            g_assert_not_reached();
+        }
+    }
+}
+
 void tcg_gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -657,26 +663,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
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
@@ -1537,26 +1523,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
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


