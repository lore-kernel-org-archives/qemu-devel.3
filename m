Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478F9606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=ktk8wgDU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXAM-0006jq-En; Wed, 21 Oct 2026 10:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX9j-00057Q-PL
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:19:09 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJX9h-0001gC-Vg
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:19:03 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48df4e9d2d4so504054f8f.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592340; x=1793197140; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0ES8mmtHULSKmA9zK4IaqJ2RmQ11CWJa0mSyK5YF43E=;
 b=ktk8wgDUrQXHGxS+erE7EJKNMSUKwc6Cxt8HqO22rf/QWV+UEFzFTW+VsQ2nTB5Ha6
 //WUps3XUp+DDMJaqlAFmC0HJciXkjn55J7SE3x/tOXX6JVCv5gMZPU7ja2eKhQoB+Dg
 1d0EQ5N7fT2JYJmmM9WnhmDtxzvJdbTYNuSlSURrMj3+RspwBRCP9hsW4mJ3WrAJZ4ys
 +M+wTScy4VSl1pdghR0jcUOjMf4LUgS77LiJrEQ9uGxV6eO3Fxw1ZDoWUpX0YW0Tl3kL
 Fxf4qPKWtK29M43CRxqFnjae6FuwSaxaFxiDurNk79ZdgJ1+ivTaIEjh7n6c/lhpQzGa
 PgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592340; x=1793197140;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0ES8mmtHULSKmA9zK4IaqJ2RmQ11CWJa0mSyK5YF43E=;
 b=pEvJLQzz2ZY4eWzheZYxDxwrSnozWRta9Lc24ijfEE+Vo2VtbAv6KlVD9+2QWZ6LBF
 pS3nPAUxcEwRKcWEaQG8VzuXZreKcq5wFPGfYtWBbKA7pvQAFoQTbJsrtzGceDjcVvoL
 JvgDCpEUqszU2ABoFosGh0Esi7PhwcsIQTEjLyGWyv19QcSl3efVecpdPnXfUSf10Xyn
 NMeI6nRqtUVuLIdFsnNbPbGzndPmLDjYMPHZYS8ubiJLZrISWXU8Po1NsCbe2wPE2NNk
 tNa2ExvyZzHgBU/m5xH9mM9VxEZq1IbZswratljnIAjQiNi3iqmWsR0RzRSuAq4EjEmE
 IMiA==
X-Gm-Message-State: AFq9FYIOGWBl4JqvmjjET5/KROhn4bFtkmOtikg5XKVC9IyNqQGAkXJ9
 k8FNPppesQArqYZdpkB+3NCisLgoN7OPrLLQJD+AwuelUTWiv7FKRaltTHkCIMPP/L9Hzp3HMoF
 ZZoSmNQk=
X-Gm-Gg: AYBFou1NsOWyP6gR+cTDugz80QBMXCSK93kX9zdeZj1Oi67H9PQXU2ZJvsK92866miw
 ixFhis5OqGmnxy0tI1xE/Kj1HKoHL+0zS7aChGjieZHDjLV3z3q9LLfcEunhRHJdLq+UWzqK0BE
 pus8az1YgvXcZdVLevRfSoK0p/ACF3lTKJKCGjYveFQGZ79a0j5+qFwmWpEwzas5QV2OaMPCYe9
 oJLYE6LiXLjZryzYo3kC6ZndHJG0OwR3LrNTE0JogGz1dTMB2++VRlZ8QzR3iBoLPYymjk8q8dI
 8LKGngrfBeBeZuXzXKfKcoSQmQ1xSQ3lGBa0uEmV0cMb9ywX9M3XWMFrur10CT6R9RJaqyiW3wc
 sum7llKXz3BZJ15DNZgLVkYiWHGfAaGr56V7Q3E8qu1horgmdD9fQqUmGmupnChJg2AV2SaMPmo
 QGPtTAib22GUF2FRPo7w3qCF1pqMQoQNU9rY0onuP/NnwRrq/7gKbxKKFYWSOC7PA0MqX60PBAX
 77DpnrqzWkNyPPZg0iwJuKnlAIQ5UZ5H64RBEaTxPDMf/oMFvKuWW57h8hvJZTcXr1d4HD1kjQv
 b05VFrhPTI4Vo9xRkjme7ASnlibGlJPZIhQCLf4JpUQXPE43
X-Received: by 2002:a05:600c:4f53:b0:4a1:ce33:1536 with SMTP id
 5b1f17b1804b1-4a1fdd20d2amr48583575e9.9.1792592340498; 
 Wed, 21 Oct 2026 07:19:00 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1f2c242dcsm147113845e9.0.2026.10.21.07.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:18:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 027/100] tcg: Generic expansion of tcg_gen_ori_*
Date: Wed, 21 Oct 2026 16:15:39 +0200
Message-ID: <20261021141652.363109-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 35 +++++++++++------------------------
 3 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 1108d185e8..dc5c7f7cb2 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -210,7 +209,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index f7e7f4d2a1..f7a7dc69c9 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -11,6 +11,7 @@ DEF2(movi, TCGV, TINT)
 DEF3(mul, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
+DEF3(ori, TCGV, TCGV, TINT)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF3(shl, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 34e1e736be..668c946c03 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -438,6 +438,17 @@ void tcg_gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
 }
 
+void tcg_gen_ori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    if (src2 == -1) {
+        tcg_gen_movi(type, dst, -1);
+    } else if (src2 == 0) {
+        tcg_gen_mov(type, dst, src1);
+    } else {
+        tcg_gen_or(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 void tcg_gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -509,18 +520,6 @@ void tcg_gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 
 /* 32 bit ops */
 
-void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    /* Some cases can be optimized here.  */
-    if (arg2 == -1) {
-        tcg_gen_movi_i32(ret, -1);
-    } else if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_or_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -1487,18 +1486,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    /* Some cases can be optimized here.  */
-    if (arg2 == -1) {
-        tcg_gen_movi_i64(ret, -1);
-    } else if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_or_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* Some cases can be optimized here.  */
-- 
2.53.0


