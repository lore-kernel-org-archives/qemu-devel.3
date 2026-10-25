Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6166B606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zc7VyVg8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKscS-0007yU-37; Sun, 25 Oct 2026 03:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZt-0006hi-0z
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:39 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZr-00049W-8N
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:36 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so10663635e9.2
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913014; x=1793517814; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JTRT5fOF9u18k8W4qLngte6uipVH5fK9Fi+QdRd5T9M=;
 b=zc7VyVg8KGSlzHS8X+yIZDJrb6/0RBOwMsLSOpkR+gzrBJl0dx+iKVWNHIZtmaktmK
 bepYtWaVk6fSdwQQ3NH7CQaPxC1kGLNT+ZzsxiJkVajCmn7Q57SY0IhcdTK2pcsoENdz
 I2wIi/1c7cG3TlQ8TE79k/gdJKIt5Gknhkp4zhFRWrbof0KvTjf6dNbbNyojTOtflBpI
 jxyPwWPa4na86Js35DE581x8VqiurafavP8YjNaCP9hgWNwcqnlp7sScEDmuPD5s+QoH
 JYYehrtcFsI6d5r+myFkrsdbJiUWc/p8/cpagyVY++kc5VQDYT3AOpqp75/RJZx5IUwd
 zyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913014; x=1793517814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JTRT5fOF9u18k8W4qLngte6uipVH5fK9Fi+QdRd5T9M=;
 b=TuJRi3X+Dx32La+xeEuGnEJ3MVx07tc7RiDUug/CmODSMbrvm5dH5Vw8neUdyiN3Eo
 1I3EfoLznSl3XLMjsHjudXmmCybf/y1R65reD7FMDwQFpFXf9lPCj6LAa5EBqOavzumN
 Rz50phNgK+STIAEbaRzq8zwcPifGPPnQPFy0br8mbplEwth7OL5vKWq9flLFSQlUHI5C
 c0mC2/Aa6iZkrPt4+Ho/J1aXnN8Bup4h/7XVzDfBzPNgvu6JFl/Wx3f+J+lpaPf8BsIY
 QSQN+BtMCba6hnO0K8s72XGRo011gszdbjm/VkXaj5OfdkiCCg8uLeUQwMkHPQWYEvV3
 smHA==
X-Gm-Message-State: AFq9FYKxJK0rKnGa2AcLb+I3IJJlzXSF0LCn1omTfevKmUknOKw0wO7L
 G1Z86nn4msxg+Mpr7iAuLQ8o0xO9dP+lPDaZK3p7pgQ+ljQHwO7j61c/HzvoTccPKKKFQBUDp7/
 3Hve2CTk=
X-Gm-Gg: AYBFou2qOeRmmdEyfrxsxSAUQv1xUHSckcdcxptkB/QoKdyoiwrxdryM500/NrvOGw0
 ko7eDk6nBlxTPcka39eGPdG+8xeZc+xjIUIS8srKpbnWDqmD1E4YkkRjvn5+ps8TRpXGHe9LlEe
 pd7Hpstp7pfP/TxoLviqNQadFmeSZsqf80pDimkANe+Tx04R2ZLShrCZRwJW7YHnJyGYDmI6rEc
 zkwYlHJruPu/I4XIihZ/kssjfEBLLXUBbJWCkEFGilZJ4PsnJo8BCE9jp1zrgRNhHfiNvO5Y/oP
 iRKWt1aCX5WpA/B7TTDjEh2Lx68mSryiVaWYGdDT/hyyefVfRTYzBJ8eRGVGrwdrV/YewrJZlRA
 KtVO2Gy/yT6yR2RPfiq3se9cQgl5oL6L23ee2rnLi66zK+atfMOi5c5TfnVL/3HEnPoQ3gEkjZW
 FjrSK7yqTDUTDjeCvGZ26KETFYMEGe8rpdNIPoVtZuCqk92G9aY36A6xwiavtZx0s+YHWvq0PAE
 yx4sn+/C+RCtW3lhgjxrttmSESUG9G4GSeuq9EhR3Mh9STkjMxDUwie5/0=
X-Received: by 2002:a05:600c:8108:b0:4a2:17f0:ec8e with SMTP id
 5b1f17b1804b1-4a35ac9b471mr47036395e9.17.1792913013609; 
 Sun, 25 Oct 2026 00:23:33 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 073/100] tcg: Generic expansion of tcg_gen_umax_*
Date: Sun, 25 Oct 2026 08:18:48 +0100
Message-ID: <20261025071915.1123867-74-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
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
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 27 +++++++++------------------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e23f247b90..4a79e3e1f6 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -186,7 +185,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
 void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 7d1035a8c8..3c93c20704 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -60,6 +60,7 @@ DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
+DEF3(umax, TCGV, TCGV, TCGV)
 DEF3(umin, TCGV, TCGV, TCGV)
 DEF3(xor, TCGV, TCGV, TCGV)
 DEF3(xori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 7a5e992557..a288c14813 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1050,6 +1050,15 @@ void tcg_gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_umax(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_umax, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_umax, type, dst, src1, src2);
+    } else {
+        tcg_gen_movcond(type, TCG_COND_GTU, dst, src1, src2, src1, src2);
+    }
+}
+
 void tcg_gen_umin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_umin, type, 0)) {
@@ -1356,15 +1365,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_umax, ret, a, b);
-    } else {
-        tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, b, a);
-    }
-}
-
 void tcg_gen_ussub_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
     TCGv_i32 t = tcg_temp_ebb_new_i32();
@@ -1869,15 +1869,6 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t2);
 }
 
-void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_umax, ret, a, b);
-    } else {
-        tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, b, a);
-    }
-}
-
 void tcg_gen_ussub_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 {
     TCGv_i64 t = tcg_temp_ebb_new_i64();
-- 
2.53.0


