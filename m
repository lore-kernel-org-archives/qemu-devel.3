Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4150C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L5X-00031k-6t; Sat, 12 Sep 2026 06:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4x-0008UB-0n
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:27 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L4u-0008MT-2N
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:26 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d8fb334e72so6859955ad.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209322; x=1789814122; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YcncWtTVp6UfcNywzRunqJeXDpsUJB5J4Wh++F49y8c=;
 b=G1NKV0aIr2Isq+RcarndF/wtm25KixlwJA092/x85IocCC37qRbR1FUodCLM+HDtJ+
 gRNkI9ddJWhAjGBethQUs0fj2fVzIB2pk+2VRfAMs2CnOQzEGEQZ7y4pjUoo4LZdcye2
 rBMETbqDDZ3TE69z1NW/BdJd6O4uCZSbj+GIS6Z9MDI9jAHzGu3rBfKzDhOKwiRSDWkv
 oi12ik3QxM+wQ6tCLb57GC50AhmTOl87ZLvCCSM4WlyaTvpYQZwguqXkANdickWv4FNG
 pmdrY77bMxfccDblJvwFr1lyzFh7XCtCulrlmsAzkkhgX9I7+FtuNnJQH2b8guEpFz30
 g0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209322; x=1789814122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YcncWtTVp6UfcNywzRunqJeXDpsUJB5J4Wh++F49y8c=;
 b=EdPTotXyQ0dfPE/YU8TeRmtI+cQSnOtf4rJZMb6jvEuzpAWHMzjMv6aRqqObxS+uOf
 j2zBF8cXiabHNIhLyvf5wO1sY/AZuWi0IRZg+q/uqMAKGCjBgKtMX4+eJyGB54NXpfQv
 7OSUQ3yfXxYDkshgOwD6Tfb4CwhZFjC4Cux34bubnnY3t5dxxL0vpP0lK/q5PT+GH+4+
 zLlkymAp/Z+QvoZszo7heT1hYTQgHNe2JcFwAh6/Q7rVEc4RzG9Dsqc832OU5S+Y1FLU
 9A/bL5meWyt9LDHQFm14cTeUKNcn0fDpkgyrCUAXqKYXc6xGe6Q2p/usO5wyPHvpVVEk
 +2rA==
X-Gm-Message-State: AFuF++mSubKiNbQHt0n++YmRSNjdWjYCp3/At0oUnLsrgvN1wm8R6MJ2
 tKG1llhlKP5mjx8PB7KZs/6dPSAZ0xajy/W8p/LLruHhEOEY0OJavw9wKwCWQZ+LTvXr/0Eo1zw
 Ms6LE6dc=
X-Gm-Gg: AYBFou2IPzBh8nAZtrJuSZEmnj4GthMlP3vm06zTfL9AZ2i/7CKE2/psWjyfEICN6yf
 NM3I3rAbgUpSUBJbS/aN6IhFMXbPJeFTDndo18JnJ73AdrqvTEGDG+5zET/wOKTWEe9FllTvxnL
 f3C8nb+yCpUpiNmRQHs7cyylCOMcZII7DYnGO6KGrfAYeeYFoI02ki4J3+vH/GmQLVz3tGOluKi
 BB7aycg2fRVKO7OkFAbCud5bgZrdoTChVMZg7uOp/R7pwwfuQHTmyt+Wg1mF4tBYRQkVYcq8e3q
 18fjR2K9KYS9anCwZyXE9pzY8L87Vz220OBKUbAf/uTT8Puk/gh+w++GyJUg8z5hY7ezpcujSaW
 EJyDwTbk+bNdihjSr1NzspuxAK6gdxWI4BPXe6B8++5G/gx3nr+/QbDAtEFi+0/GvPs3M36HHd3
 41liQ4x/zn+9SQR3xQR/4gSsj7As33atn0iCeAlDkZTP5vgAelLi018l6FKX7D8pDsC6uFScgyd
 tnQznw=
X-Received: by 2002:a17:902:db0f:b0:2d9:520c:38e7 with SMTP id
 d9443c01a7336-2dd2a1ce7edmr150109595ad.1.1789209322307; 
 Sat, 12 Sep 2026 03:35:22 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 55/82] tcg: Generic expansion of tcg_gen_rotl_*
Date: Sat, 12 Sep 2026 00:30:59 -1000
Message-ID: <20260912103126.598030-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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
 include/tcg/tcg-op-common.h   |  2 --
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 63 ++++++++++++-----------------------
 3 files changed, 22 insertions(+), 44 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index cdaa805c47b..94f880a81e7 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -142,7 +142,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -197,7 +196,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 0f370e4e04b..61d00fa493d 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -41,6 +41,7 @@ DEF_RRR(or)
 DEF_RRR(orc)
 DEF_RRR(rem)
 DEF_RRR(remu)
+DEF_RRR(rotl)
 DEF_RRR(sar)
 DEF_RRR(shl)
 DEF_RRR(shr)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 549d257de8b..677e93736f5 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -806,6 +806,27 @@ static void gen_remu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_rotl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_rotl, type, 0)) {
+        gen_op_ttt(INDEX_op_rotl, type, dst, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_rotr, type, 0)) {
+        TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
+        gen_neg(type, tmp, src2);
+        gen_op_ttt(INDEX_op_rotr, type, dst, src1, tmp);
+        tcg_temp_free_internal(tmp);
+    } else {
+        TCGTemp *t0 = tcg_temp_new_internal(type, TEMP_EBB);
+        TCGTemp *t1 = tcg_temp_new_internal(type, TEMP_EBB);
+        gen_shl(type, t0, src1, src2);
+        gen_neg(type, t1, src2);
+        gen_shr(type, t1, src1, t1);
+        gen_or(type, dst, t0, t1);
+        tcg_temp_free_internal(t0);
+        tcg_temp_free_internal(t1);
+    }
+}
+
 static void gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -972,27 +993,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_neg_i32(t0, arg2);
-        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        tcg_gen_shl_i32(t0, arg1, arg2);
-        tcg_gen_neg_i32(t1, arg2);
-        tcg_gen_shr_i32(t1, arg1, t1);
-        tcg_gen_or_i32(ret, t0, t1);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1803,27 +1803,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_neg_i64(t0, arg2);
-        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_shl_i64(t0, arg1, arg2);
-        tcg_gen_neg_i64(t1, arg2);
-        tcg_gen_shr_i64(t1, arg1, t1);
-        tcg_gen_or_i64(ret, t0, t1);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-- 
2.53.0


