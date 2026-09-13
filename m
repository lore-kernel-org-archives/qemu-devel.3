Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9596C88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:39:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a7P-0008Om-2D; Sat, 12 Sep 2026 22:39:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7F-0008Nt-R8
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:38:51 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7E-0000xH-2m
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:38:49 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccafb752so1044651a91.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267125; x=1789871925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uQFQAp0hUoGyPy/HNREU0P752UtsQogAcAehe06GS40=;
 b=assRMdiitFKCZdQP50skiAmxjQQ9oQuF5BbYIMBLrkA4K5yt7zNopqriQMaW8Sqyhm
 f0r+NbRS7WskKE6Vxv2kbjO1oaw/HZZdAd7/A0eRb3BZjXrXrce/NVJSSfX2Hlk+QbY6
 NXzSox3Gc+kSYwONaYayj/QjsvwkOciOf1BzLtJ/JyYA0hRrCDL8H6CMSA8EAhtiGF1U
 5wjrbewtaczKPZXe8UP/e17p7uwSzyzfvujYQhCgoEjPp1/QSalHwwAzw0thSYCBxm1U
 RTWgTGxcqu/nkF4C/o3kuseCCSoTxKeDcsY6dDF3/i87iIRHuPtoHLwjk+yyBPN36Djt
 Ya3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267125; x=1789871925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uQFQAp0hUoGyPy/HNREU0P752UtsQogAcAehe06GS40=;
 b=O3W2pd2gTdBQuBJjjb/IERk223lowL7GlHvxJ7QG3+7eMU1uEEPCa0AxRWMiFGCrmV
 9fiuz65bzQxTxqXNBO8mtOCCrIotiDYCq5V3cBvmN9kMvPZ4LJcysFJCmsbyZVzoCoHB
 HRNG+k6aBPh4CVPlAJuymUbvTsGcT1Qx533YeAH0eAdcgOSQbh1qLfNHjuLSXIwCGkFv
 4ofsEKZhfSb8qhieHeg91OCkzP6xa7H0FjrlXLSbb9RN8Dg6MICsmmLB+6U1S83qk3iU
 E0kaa3vdVWAI0kpQQ6JP6eQsUSLxMUhvpZzmL7LNzdGxw8ieisIC8CpgSduldhpkUwiV
 CX9Q==
X-Gm-Message-State: AFuF++kAcgg772frqZIdaXAQ4dhvSVyWlmUoqB6qn8M+9+3jPq10oyf9
 9P6ce//D1wrGh4CAlGsNcvpL6xSoPSIZQGl3KxxbrA5wUvOjuM1WlAGTlTcT6SDRYSVkug79QUn
 eD66iYWw=
X-Gm-Gg: AYBFou1d1X3WGnam2lZE3GVzVFwwz9EjXOaAkAWn7QEzmTQe1GxjNE8KPEN1mmQT4ov
 mjuCfYb1E2WqlHwhjddDCMGJi3D3dticAm8/frDED2yMDThD80UCBCUWfSsHLxKRfTKXCHYaRsx
 JY3cyrPBJALGpRrQxQUJ93lSRsr9YSQY7lPB9x7SsCmFnYxa8PcrfCYWLw6m/5J4E7qeFDj2knz
 dPm1LBNOy0gwNKA9mpVH58wl0Mfsc/gzfkainuvGTrahH2A3GAfj8qv5mDAnlmmJ99tz/JGnMoM
 Ul7Tr7XZjd61PQXqMdzPVrbST42mQPJOb+38YC2X8auzRKDDhGJ36BHYxGE5OdFgpeA1v2tb9HM
 b2OCRdoc2VMcMhSgdVrKbqCDdg6ac8yHiJKRm1UPLu6t5L1A8vycpCGyMW+QbgbXw7fxSo9v9wf
 vFAsB5B324I2u2OTKjj5WfL/t2PtfnVjMBJCXCCambRudKC53Fn5VapBUjJYI/ZhlWLcat/W9MH
 oi0+LC7jtj+/zk2Lw==
X-Received: by 2002:a17:90b:548f:b0:392:b509:b1a5 with SMTP id
 98e67ed59e1d1-39d9c1db3d4mr20009140a91.14.1789267125418; 
 Sat, 12 Sep 2026 19:38:45 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.38.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:38:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/86] tcg: Generic expansion of tcg_gen_movi_*
Date: Sat, 12 Sep 2026 16:37:15 -1000
Message-ID: <20260913023837.741866-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 8a42ff1f456..fd603b2de7f 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -117,7 +117,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg);
 void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
 void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -224,7 +223,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg);
 void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
 void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index ebfaf0b8188..5de7648ed48 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -1,3 +1,4 @@
 /* SPDX-License-Identifier: MIT */
 
 DEF2(mov, TCGV, TCGV)
+DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 511b34b143c..82f15205c36 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -392,6 +392,11 @@ static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
     }
 }
 
+static void gen_movi(TCGType type, TCGTemp *dst, int64_t src)
+{
+    gen_op_tt(INDEX_op_mov, type, dst, tcg_constant_internal(type, src));
+}
+
 /* 32 bit ops */
 
 void tcg_gen_discard_i32(TCGv_i32 arg)
@@ -399,11 +404,6 @@ void tcg_gen_discard_i32(TCGv_i32 arg)
     tcg_gen_op1_i32(INDEX_op_discard, TCG_TYPE_I32, arg);
 }
 
-void tcg_gen_movi_i32(TCGv_i32 ret, int32_t arg)
-{
-    tcg_gen_mov_i32(ret, tcg_constant_i32(arg));
-}
-
 void tcg_gen_add_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_op3_i32(INDEX_op_add, ret, arg1, arg2);
@@ -1466,11 +1466,6 @@ void tcg_gen_discard_i64(TCGv_i64 arg)
     tcg_gen_op1_i64(INDEX_op_discard, TCG_TYPE_I64, arg);
 }
 
-void tcg_gen_movi_i64(TCGv_i64 ret, int64_t arg)
-{
-    tcg_gen_mov_i64(ret, tcg_constant_i64(arg));
-}
-
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_ld8u, ret, arg2, offset);
-- 
2.53.0


