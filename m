Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0B3606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=NXSWTb5v
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWN-0006Pc-TJ; Sun, 25 Oct 2026 03:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWL-0006MJ-75
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:58 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWJ-0003kG-8e
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:56 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48df0fa43c5so1224226f8f.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912794; x=1793517594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pUeHrseQFClENXnB/MDBICodxSrjf6ctDcR56LHElkY=;
 b=NXSWTb5vss9zo6uJQhn+d3dYKnUxdjzTUeCkCnIpboBa9Q/V34oqiT4FZwbujhJg97
 nxuouUP0gm6/ZpT6VOva4/f54YQSDTjSAqm1bXIPBhJTnniD2Nrb2K1hzkGrZTi0nJN5
 HqReObGTeajJ6RIqJKoAtdsjGX9E/JAdCYF49hQVlVwSiYrU+jBWGesaPuNgv5hMXvJR
 +rKbI9c4glvNuchg5SFIkkTIJAWAzNqwQbChfZbO9WJtENhMAgrr8I8S0hEc6YBwa4e/
 yFTXZDJJnisRP3YQ/Ar+UmSI+MmTfSiGGr/hBv+jUhCiwlhqFFyf26KNXfuCd3GxSF4E
 3XLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912794; x=1793517594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pUeHrseQFClENXnB/MDBICodxSrjf6ctDcR56LHElkY=;
 b=mbDYJU1KT7D62h7jLb/A5h407Ix64eQs4QI+f9hc6X9Ae28Af+V8kIE5OZztx7iPle
 SpDHu7MveCFamdRF8ZA9pgwbyVPkb41TLgKSGTKSlE0UiU4qi8k4Kc7EMW9WcawF5uBx
 1PIk1NV5zEaaqfuv2+Q0uE807QuGLHH0gQkFrSlVoS3SSfn/yDACvLF+tvW3Ha1wgtwL
 ju/s4BkTibdQu3DKKgm2FvzVMOMDKmgS69rGFlYEfaH8eq0d6hzGuKKXYQ5zOyrv+1Xd
 w3kfiMwlh7dgds3mYfvg9CmXX8YqpFq1jUbV/m3pvnZWaY9z8QVOKCEnJXgQ7hCsc7jQ
 BdKg==
X-Gm-Message-State: AFq9FYIZ5VXTwWnTMW1zdwpqLSqSlWcTbzIf79lB7wOdPYqH5Emtn+IV
 dQFg5fuI/7DFL9DItrY2Pz6GSq/Uw6oRb1Js/jyZr6bQZfxdhr60kuKW46v+yuDsfMMfpXjN4Yq
 Uw6g2FdA=
X-Gm-Gg: AYBFou24/1AwWnuGK5NRJJZb+/PMPrfiZfMUoPsVEbOIefQajfAnVQa5GYgFLZKMhX/
 YjcugBZM3c9+qkUphH+I+5JRxD1T0ypojqoCDF6XEKjjXJB3VvQPOx4UaR8Rkh4tsvUGWCLZcpL
 CSL2M4xUvRNk+s1aj10lOU6rCD5MjEZELRnSwQwV+zuayiPEqRMRK843gpAnay7EgjQ2ehWSgVD
 96/mnfoW/WxAbubbaMt5pfv7/FbpP8PVbLN9CU2IVsUih+kkN9mINgLxGu3zh44Q4QtnuyZcZ2U
 1fGtGxzADZ3drk0BTJdLYULMyM+Rtdz8r26320PARjsGw7j2a2/ba6A+o9iyA2jGFsI6pkZjbO/
 WTiDqFPZSSLJnCtJ3nis4pnHP6XF7akIjBlDV5aHJ0j3F72Mr6Qtq31kTi+/k4k0EARVcoyQMPR
 eAp0bdTMItUpH4eOqp2oMqOTZ0puj/hdqpBpc/8p0g6aZL1GAdczdD72wRJMxQY5o3RYioXClyZ
 mpqXPWRQClVenX7PZrEilJWpAi2syoXr7auAPleCSlZZs3cvMEYZ4F/fw==
X-Received: by 2002:a5d:6e4d:0:b0:48d:bae5:41c with SMTP id
 ffacd0b85a97d-48e3eb7e458mr4766578f8f.17.1792912793759; 
 Sun, 25 Oct 2026 00:19:53 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 032/100] tcg: Generic expansion of tcg_gen_div_*
Date: Sun, 25 Oct 2026 08:18:07 +0100
Message-ID: <20261025071915.1123867-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 tcg/tcg-internal.h           |  8 +++++++
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 42 ++++++++++++------------------------
 4 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index df6563af9b..b0c5a1f5cf 100644
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
index 76c8f026a6..6b65228241 100644
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
index 8c9d3d99c4..778854286c 100644
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
index 09e417b760..8854006022 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -411,6 +411,20 @@ void tcg_gen_discard(TCGType type, TCGTemp *src)
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
 }
 
+void tcg_gen_div(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_divs, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_divs, type, dst, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_divs2, type, 0)) {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+        tcg_gen_sari(type, tmp, src1, tcg_type_bits(type) - 1);
+        tcg_gen_op_ttttt(INDEX_op_divs2, type, dst, tmp, src1, tmp, src2);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -609,20 +623,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
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
@@ -1537,20 +1537,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
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


