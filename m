Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18B6DC88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L5J-0002CT-Ai; Sat, 12 Sep 2026 06:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L59-00013E-7T
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:39 -0400
Received: from mail-pz2-x1f.google.com ([2607:f8b0:4864:3b::1f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L57-0008Su-AS
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:38 -0400
Received: by mail-pz2-x1f.google.com with SMTP id
 41be03b00d2f7-cc1cea50dc3so262541a12.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209336; x=1789814136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ldWn7snxHOcB+mXrFkvAGABF21kvv1rR3g+gRwUheG4=;
 b=aKg5+BPXkUVExR+p76/9mxLXQ7VYOryIIh+dJR58GH2nDbwJZcRIlsIxF+Szm3eI6H
 wnOJwQbkUxACpsoWBfYa5qOuixBo7kbfciiVjxx/skGT5CGNPPOSh91oQiCk0Bd51mRm
 UnTTsq5liTy1hXukoKXq3x1WlJOK1zrqeQACNTqA3FqQcUvZpTArr0ny5/eK4fR25wOp
 1uyJEcAj6XbNdlyFyZdIJCBbcUoJP7PQXuXlUqBhFbZ1NcH86Ixh615NPqcnIroJFDzg
 +3rrRXUa3c7bQDyK2lEvrxaCExhLY1jBuec3+hg6x+srKButsciiP/KW6lrB2cK1nIE0
 VUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209336; x=1789814136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ldWn7snxHOcB+mXrFkvAGABF21kvv1rR3g+gRwUheG4=;
 b=OzsTzMGHyfsU1HmjQmOVwCs6BndEXTS2avWz3f6onLAdL2BjuIrABVBzpe5iDhlx/w
 EW2QiqTcn9jCLGnXuHglUII4qfy3+PVujIgsObPsgnw+2ZWjPXrDmraCCYp4ly3L4lR3
 nHaxbRkWIE/bAYTf5+wUTtkR97Z5l+pL4ittBu+FW3wP7GTEkqIdvYoqVSQE0qC6Gmw6
 9wxwaIpj5c3Ti7nApSeluPPM771kn+VagCSE1xZ7grNvZKvQfEe+g2g1r41mzRtfMeVS
 qAxOf6CxgD/6ni1w+qfqSkjbkuoDyEhgh8T0bTx6kj74o2mgGfO2tWiFtlp7QkZO+U17
 46Lw==
X-Gm-Message-State: AFuF++ne8hOyqwZyfOvIUfEKz5fkU4panr3D1q06sBzX2I21LSH6k8Od
 3OSYE0NTz2tcLUDUYEcczgsWARv14Py4GMbp6UnDvx8uxD23lOqTPC/NZloVGdYdGqbaQdKWjir
 RnHlwL+g=
X-Gm-Gg: AYBFou3ZcAkFBV+R7X2Xebo1DIDW3nYfs6Tcn6hmyzFQEbIB4feKO5lbcoaLbOY7r+F
 FRoxBTG+/0Z88t4OYiC0e/V04GRsTgj1ZBHoKqP9BSDfUnx7hoDyW/Uj3ePwQVmgJbL8rWxjtYJ
 S8aR+TJ3Rtf9ZIKX+mZ93Yl8inQuSsk/g8F+QuXkoh4HimGQ7ndUv0OZAEuM2tZkRm8n5qBj/HX
 VMDSXvSoR9ZSYTJlGfne8VdUwmNWOA0LlmteITQ9Ab2Ti20SLweF1vujjEolU+dR8aZ3Vu4FjE2
 raE0Hhly1kWh12uZ/5HcWxEyTkJD26q+D2pkoz4G0bra8ooSHn466wVKHqEKLdm79RPScX/G/ee
 peSJlabYX/kzQI2dOXlydg1zoYJ77p9E7pK7007oGZ1W3ZY+MOzUzxnZHpVbyYFE51pbaOkQvm+
 VAxPN47Sd0qU/il87VsO++UnGNtFiubrR7JbHjGifWxTneIzgX0rzJLsbH7mUQUVGPcqRmhRotw
 VAkEu0=
X-Received: by 2002:a05:6a21:6016:b0:3cc:9618:f51a with SMTP id
 adf61e73a8af0-3db0e0ea40amr3913764637.8.1789209335811; 
 Sat, 12 Sep 2026 03:35:35 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 69/82] tcg: Generic expansion of tcg_gen_smax_*
Date: Sat, 12 Sep 2026 00:31:13 -1000
Message-ID: <20260912103126.598030-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::1f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x1f.google.com
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
 include/tcg/tcg-op-common.h   |  2 --
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 27 +++++++++------------------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index f5c9248fc93..e751e721a84 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -166,7 +166,6 @@ void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_smax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -209,7 +208,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index f616e27a228..6eb33424581 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -52,6 +52,7 @@ DEF_RRR(rotr)
 DEF_RRR(sar)
 DEF_RRR(shl)
 DEF_RRR(shr)
+DEF_RRR(smax)
 DEF_RRR(smin)
 DEF_RRR(sub)
 DEF_RRR(xor)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 34f1ee060ac..d72e64e709f 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1073,6 +1073,15 @@ static void gen_shri(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_smax(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_smax, type, 0)) {
+        gen_op_ttt(INDEX_op_smax, type, dst, src1, src2);
+    } else {
+        gen_movcond(type, TCG_COND_GT, dst, src1, src2, src1, src2);
+    }
+}
+
 static void gen_smin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_smin, type, 0)) {
@@ -1505,15 +1514,6 @@ void tcg_gen_umin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
     }
 }
 
-void tcg_gen_smax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    if (tcg_op_supported(INDEX_op_smax, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_smax, ret, a, b);
-    } else {
-        tcg_gen_movcond_i32(TCG_COND_LT, ret, a, b, b, a);
-    }
-}
-
 void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
     if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I32, 0)) {
@@ -2036,15 +2036,6 @@ void tcg_gen_umin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
     }
 }
 
-void tcg_gen_smax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    if (tcg_op_supported(INDEX_op_smax, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_smax, ret, a, b);
-    } else {
-        tcg_gen_movcond_i64(TCG_COND_LT, ret, a, b, b, a);
-    }
-}
-
 void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 {
     if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I64, 0)) {
-- 
2.53.0


