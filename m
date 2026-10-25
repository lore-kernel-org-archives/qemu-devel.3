Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C82F606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nNF64Emd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKscp-00087a-KC; Sun, 25 Oct 2026 03:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZf-0006XQ-EA
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:26 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZc-00046j-GI
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:23 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so1810705e9.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912999; x=1793517799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jW7Et0X4IvxK261vcSwErQpyRbHFz3VVf5F8yS4fKsI=;
 b=nNF64EmdOQKpFjh3DzU7jUC5ywPnLKtMpEv6+OHmX55ZRlLqkbmRDlQPiH7YN6gn0O
 vruB0VvXdAJZuAiMsooyV2qILYSyN8bRPxlVJY8/pySNonPiZuCQ0j9P7ildLSuYD9k+
 XmRSTPO8Ql5Xf46Hpmz+UM6bCubJ2JixmyHLDgxUkc4Y5z2qoeggGi9mT7I30UyvDW5+
 vbfO/oFYWVnr1rVWILV0/iSl8DcmGgbv8/fu3gpuLeehKwL5MMkSJpHiuIHOYWXP2G8j
 BvdlnBOU8eMpMx9D1boGTN1xZUB1LCCaRwluYbeVt5MjssyYowNhirpbCR6hT/htElaA
 vPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912999; x=1793517799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jW7Et0X4IvxK261vcSwErQpyRbHFz3VVf5F8yS4fKsI=;
 b=zCWmjneh//Iiz2sHjqR5K9xOvaVja7scvoaauCG31+TQSnWtEqr5CAZCFbUNvTvvJE
 R4XdojQlF6UqbVbM9fwMYcRCEpqFCUOrVEnx5CXqHaeicqB3dgRy4XzwxSKgr32egJ52
 KKAWr+OTL8jV2IZtVAVwiUgtvHQEDFtBJDSSpdIk4Jfpg+sIGHuxo5cqx47B6KPbPxs+
 N8ZzF1cbIPOmyv1/HyRzyEPpAhgd8J4tv6IFpd5JIaEANw7lLAbL9Cm/flucyOMndv7d
 WgGi/d0kUR8eVhUks60c37hWFF0h18+sAlWacG0vAv0DMk4pE8YMxX+GRpWmp3FURRmm
 gRYQ==
X-Gm-Message-State: AFq9FYJhaRsF0iJsmXHkMr4lRp0CweWABZpnjbvhzM49sZvDE7z9GL3m
 Cc3svoVhCh+e7LtVy0ga4USFAPQwtqmiZy6mEHMKzWMy4czNVaHINKqEhAbVxy1utPx/XTBqD4r
 Rs+nCdFY=
X-Gm-Gg: AYBFou2hyYsnkI+hHiLRigIYyuV1w2Mu6ftgernBxbPqXN2sM43u59L0lhrfNfn3CM1
 wQ8PC+hNWpqgi4E9Zf7G2oOqFvLvV51M1gzR1erVpLrSwllIBQdZhvXMBA8vDMBFZ7UvR++J+FF
 pfN6G/6dlmqKLrEefVx0D4S+mLtznz0+qLuu30rDz+02viMvGxk50bxhbmaCGtP9Nvbh9T4b+c1
 u7bknk3ry14I+XTbczdeuFfK9uLfUFGcgItVgnN4AkB0phLB9TMs0jICexRUWQuULL2th6VXizg
 mQ0RvKuRXybAsIcCm9OHUnRlhM7JxtI2vlXlnRfnsFOZL+DvEvZVfkumgdGy6t1h/fXx39ZVwoa
 7yHOSbptSQ5QaFWYGoSv10UmA6aDpFX5cI4MS/KyHdXralSAes4mfMqtjgU5oSXW1HDS1RdHXUL
 KfdIlPJTP5e5B5s+PQtjuIZ123voIvwZgNdTxHe2bBRa3haScCTor5DHQSDGimyfJ7+Kz9SQenP
 lHqt5f8wApPchMgkyfKoEq4OJmKH3gVa1fJRaSDDF8v1ZdiJa99XvO9aiI=
X-Received: by 2002:a05:600c:4f05:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4a35ae71b30mr63275225e9.5.1792912998815; 
 Sun, 25 Oct 2026 00:23:18 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 058/100] tcg: Generic expansion of tcg_gen_rotr_*
Date: Sun, 25 Oct 2026 08:18:33 +0100
Message-ID: <20261025071915.1123867-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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
 tcg/tcg-op.c                 | 62 ++++++++++++------------------------
 3 files changed, 21 insertions(+), 44 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e653c12a18..2d05728a88 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -130,7 +130,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_deposit_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2,
                          unsigned int ofs, unsigned int len);
@@ -184,7 +183,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 /* 64 bit ops */
 
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_deposit_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2,
                          unsigned int ofs, unsigned int len);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index f832e286ab..84ef1d5378 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -35,6 +35,7 @@ DEF3(orc, TCGV, TCGV, TCGV)
 DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(rotl, TCGV, TCGV, TCGV)
+DEF3(rotr, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
 DEF4(setcond, TCGCond, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 97acd9ebc8..5a85dfbf70 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -764,6 +764,26 @@ void tcg_gen_rotl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_rotr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_rotr, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_rotr, type, dst, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_rotl, type, 0)) {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+        tcg_gen_neg(type, tmp, src2);
+        tcg_gen_op_ttt(INDEX_op_rotl, type, dst, src1, tmp);
+    } else {
+        g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+
+        tcg_gen_shr(type, t0, src1, src2);
+        tcg_gen_neg(type, t1, src2);
+        tcg_gen_shl(type, t1, src1, t1);
+        tcg_gen_or(type, dst, t0, t1);
+    }
+}
+
 void tcg_gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
@@ -877,27 +897,6 @@ void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
-void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_neg_i32(t0, arg2);
-        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        tcg_gen_shr_i32(t0, arg1, arg2);
-        tcg_gen_neg_i32(t1, arg2);
-        tcg_gen_shl_i32(t1, arg1, t1);
-        tcg_gen_or_i32(ret, t0, t1);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 void tcg_gen_rotri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1687,27 +1686,6 @@ void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_neg_i64(t0, arg2);
-        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_shr_i64(t0, arg1, arg2);
-        tcg_gen_neg_i64(t1, arg2);
-        tcg_gen_shl_i64(t1, arg1, t1);
-        tcg_gen_or_i64(ret, t0, t1);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_rotri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-- 
2.53.0


