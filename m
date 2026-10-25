Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4247606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=aFt2cAcf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsa5-0007qI-2R; Sun, 25 Oct 2026 03:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZR-0006G3-3D
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:10 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZP-00043t-3H
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:08 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a4d7ae1ae9so4571275e9.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912984; x=1793517784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=diL0TcgiEBqRaulGddm7Ct284O02HU3+F12fEQm/COM=;
 b=aFt2cAcfxYYcPEIXB/WwRFi3ObkHZvK2pKIefk0XjMf4Ajz61m8HMKesMH8oYTIhOT
 RNjShbgT/V5QqMrlz9KHWvrNkTBOgygr3XYonYJiTxxhtBvZKcJqQxWYX14pFkwwXqyF
 DbzolUOSY9r8k94e5Lf+Olv3M5BZ1FrrIy9k1cNp1PPKmWXOBcTPGtn5VShOwYa7GsBk
 SNai1pbw9DOg9p/kxMda1igjn+tRnXNo+5fvM6TULqo33Vn8wWVbUUDfpw3F0Dpso0RR
 qnXDMW9YXOiJLZtlLQSwWfK8998xMGHRfYg/jqvxVSgshnvVGumys18fy9cRhOmqkYu9
 Mpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912984; x=1793517784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=diL0TcgiEBqRaulGddm7Ct284O02HU3+F12fEQm/COM=;
 b=zs3vjKdu4Kf+XTUyxRg36/tO45CA1RbaxIeEbsxE+LncLT9zVNB8XbTwuyVJFMJkeD
 RQjn1tUHIhGAjxRg9d84viMkexN3bHFX5pW0gh7BWFtGEkyz+AkrwuOGxj8txF9OSRZf
 J58+57oTxLPdCc3FYsS/CAi8XjXUEyvvnIB40fEEPCq506sq2lESf4p4ypIEKwiSXuxt
 OH42oArawYFvmR1pB75/aTaTryeG7ACh2ITroIm9aCX/KurczR4+FF2GG5hMZyoblque
 I2ASVtHYA5GrYBuvFMkY+96clQ1k8IO/CSbaJkYTDdGTO5F+YOckJElbvv8Kfl3e0ZbQ
 OMyw==
X-Gm-Message-State: AFq9FYKihIqJfQlfULKL8KUKy5Y8YtqLok471CpHLr8hNCVvUjZsJc9y
 4jRn96XDRQe8tU4CaaTvzsoZLfiqVNMyRgkrhT0putxMCPYFa5wRJ6RNV96NPKUa02QIPMd4jlh
 MkhZKH2k=
X-Gm-Gg: AYBFou3KHFnjgQZIaVRbOqrBszWbDxnmQc8JVMwmaLNdvDzu7x0sXWKE11RJTQm0LTv
 7H4P3AA0t9yAlJvGYQRkED+/6i+K4TvoqU4B73eO+SoYxykCfqEEPyHRKLmwzn6BpDmHjRTaBPg
 C4EjRcNt+mjQhzlqH9gOSjjjlAmqPVaixFwONM/+bevosKFxYNaBZ6eFHPPvBxccZhYczs2Q4uK
 UcNjKfIa4DalLx8A/Uorufdtbis5liRL78vZWp1P6z3CRwpInXo7l2YHPdyChrb70Y3ZR/da4xx
 mPDI9vZ0+G2Tb9iwRzdYgemJZqAGbu/mZrobLUXGTbcbpy6vZQZsBH1Fp4ARJZvyBpqKDTzlXUp
 vzwycTa1D6qmYCZM46dn96GdRzTE2aNIlZ0UTM2kxGDDxV3bkrz6T2d5jKd3umwlBbxyk2Vtnru
 bgRf0K+qTISjj3SFPaM/rk5zLs4+dRw0mbQUkl0ZkESsbs/w3Z9CAc0b5bFQVp9p/Ig1D5HTvd5
 BTf/qcsaEzf3+JH1TNJjbj9xKfPBn1D3HBvN6R/7T9sf80zW/sQsR6OoFo=
X-Received: by 2002:a05:600c:6095:b0:49f:e701:51c8 with SMTP id
 5b1f17b1804b1-4a35ac7f0d2mr51023485e9.9.1792912984151; 
 Sun, 25 Oct 2026 00:23:04 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 042/100] tcg: Generic expansion of tcg_gen_brcondi_*
Date: Sun, 25 Oct 2026 08:18:17 +0100
Message-ID: <20261025071915.1123867-43-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x329.google.com
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
 include/tcg/tcg-op-common.h  | 10 ++--------
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 25 +++++++++++--------------
 3 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index ca249b999f..cad36f76eb 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1, int32_t arg2, TCGLabel *);
 void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
                          TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
@@ -218,7 +217,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *);
 void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
                          TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
@@ -487,12 +485,8 @@ QEMU_ARG_NONNULL void tcg_gen_add_ptr(TCGv_ptr r, TCGv_ptr a, TCGv_ptr b);
 QEMU_ARG_NONNULL void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b);
 QEMU_ARG_NONNULL void tcg_gen_mov_ptr(TCGv_ptr d, TCGv_ptr s);
 QEMU_ARG_NONNULL void tcg_gen_movi_ptr(TCGv_ptr d, intptr_t s);
-
-static inline void tcg_gen_brcondi_ptr(TCGCond cond, TCGv_ptr a,
-                                       intptr_t b, TCGLabel *label)
-{
-    glue(tcg_gen_brcondi_,PTR)(cond, (NAT)a, b, label);
-}
+QEMU_ARG_NONNULL void tcg_gen_brcondi_ptr(TCGCond cond, TCGv_ptr a,
+                                          intptr_t b, TCGLabel *label);
 
 static inline void tcg_gen_ext_i32_ptr(TCGv_ptr r, TCGv_i32 a)
 {
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 10ed0438fd..a863215ffe 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -7,6 +7,7 @@ DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
 DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
+DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a8752e916a..1039104ca6 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -426,6 +426,12 @@ void tcg_gen_brcond(TCGType type, TCGCond cond, TCGTemp *src1,
     }
 }
 
+void tcg_gen_brcondi(TCGType type, TCGCond cond, TCGTemp *src1,
+                     int64_t src2, TCGLabel *l)
+{
+    tcg_gen_brcond(type, cond, src1, tcg_constant_internal(type, src2), l);
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -683,15 +689,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_brcondi_i32(TCGCond cond, TCGv_i32 arg1, int32_t arg2, TCGLabel *l)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_br(l);
-    } else if (cond != TCG_COND_NEVER) {
-        tcg_gen_brcond_i32(cond, arg1, tcg_constant_i32(arg2), l);
-    }
-}
-
 void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
                          TCGv_i32 arg1, TCGv_i32 arg2)
 {
@@ -1482,11 +1479,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *l)
-{
-    tcg_gen_brcond_i64(cond, arg1, tcg_constant_i64(arg2), l);
-}
-
 void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
                          TCGv_i64 arg1, TCGv_i64 arg2)
 {
@@ -2450,6 +2442,11 @@ void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b)
     tcg_gen_addi(TCG_TYPE_PTR, tcgv_ptr_temp(r), tcgv_ptr_temp(a), b);
 }
 
+void tcg_gen_brcondi_ptr(TCGCond cond, TCGv_ptr a, intptr_t b, TCGLabel *label)
+{
+    tcg_gen_brcondi(TCG_TYPE_PTR, cond, tcgv_ptr_temp(a), b, label);
+}
+
 void tcg_gen_discard_ptr(TCGv_ptr s)
 {
     tcg_gen_discard(TCG_TYPE_PTR, tcgv_ptr_temp(s));
-- 
2.53.0


