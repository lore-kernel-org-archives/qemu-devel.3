Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E50606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MfdkVU+P
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsW9-0006DX-PU; Sun, 25 Oct 2026 03:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsW3-0006Bz-DQ
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:39 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsVy-0003gY-VF
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:36 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so1737795f8f.2
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912773; x=1793517573; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=enSYGwAJj0uN1+QyCE5+YG/7bRGUQSB8+DdQy4vhIGA=;
 b=MfdkVU+P0zgzBGlxw1Vj7Neuqb9ZY+cW4yEJJ2gpZZQ3ykQ8B2JwalTuLZlVaL9PqT
 zPmLidF2Jre2hrU9+VdnlZ6JSghR/yOMQBhh+X9yEGiV1eOlDBqAkb08QN97xu1XXx5C
 6uXLdxaf9povzbb9Sof4A4HzL1xXJYDJGUvoHRmMveeu603eEaPLVzAa7Dm5c98blnTn
 ZwWpequqixDJzF5RbRVNx2xnOzwrhB6UrPDmJLvQs0LnprDR5A+OnZ5ySg+G0oSsz/N3
 qsyXbXKZaNuOsJ2QJhmlqm2myClO1hRfCD1hZT7eVGxDDkNmIsoWlZcIcUpg9WnLar8G
 fRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912773; x=1793517573;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=enSYGwAJj0uN1+QyCE5+YG/7bRGUQSB8+DdQy4vhIGA=;
 b=HDWzL96zfYFTG1qTgsV9thdOfPFUO8y+p4FbOz+5D0G1bh0z5YCztsWVVmnbjIMCGE
 99wx2Ek+H6IvVdiw5Wf81R1rB3QgtSdi3m59bdwASsPS33eJmgVySYdV5EwcocTKSJCp
 Q7ztJgLYsyJlIqzfh4XZqzS9ML954SaRA5lawtjQHhv1HcrHNfFRnC1OXdfoaQcvWaY0
 3WF6C0y56wczHIUMNhifK6aHzlGMKYWV7r+IvNyY9MVuVf7IoYi5swJ/e2bivmW/s38z
 Gmg6HnLnqUEHe+5FFloAWzjOrYj82wqF6n3CBT3bpihHFIKaaGMSrMFNHddTp8+uWzbi
 yjAw==
X-Gm-Message-State: AFq9FYKFtPdlcotu68z+aI2mI9c46oJMrbx0DlCC0TkeVBYkwJHdBwIO
 QW6Th4RqbHpQdCFwHDQ/z62YOAWghN32EwvMZhbjtBlVC9eoiG6lcOJ6SznjsGZUgXAmZfQzBSX
 vJuHdJX8=
X-Gm-Gg: AYBFou16BkZT6nYHM+iLFhjqRDAtcR+Yjqjjk4THybwyxNC0GwkYX4WlZP/WhMM3wzt
 /eSKqQsgFJyVD3lC50BEnfXB5CiSpGTa5Q2TW7ZfoHQPXJgKG9lCgP+1lLWP/nhX6kPRBZge0Dj
 v8b8bmsfF8karfrBH5SemVyGWaTmyAi++7WDjTn1NsuZBS3Ic+7hx9+GfBnGAdnniFebJwy5Caq
 ZgTmFuPTrBn9CUHsZqro7R+qO2WHGJW/C2u7aYv3Is0sfSw1JRlA8DnRaklddEtyDLtO7Ujo/8F
 bK+kX0WfbR44UnhZGUGopjk3M53pQOHHV2lL5cNVsj/EQGe+IGwj6w3+XI7zfhIiSy5zmEwywws
 05h80iNcnvUEr/NbTVt+H0Q2rPFzf7S4rByef4KAARMWzykcAITxurQaD6Lw2C4dl/M2qomM4ZX
 +xuGh16CEZLNn8qGz2lKIaNYqB1pEnerFLjUndG0ENERbfvVwzBRFtVXcao+YBY6iCqF8IuvHEd
 Sq26Z4aB+NgtC5ua2PWWlPfnmWDUqOoh0JMBLOysWfNyAoijd2zBJvWzA==
X-Received: by 2002:a5d:5d0b:0:b0:48e:1399:a13 with SMTP id
 ffacd0b85a97d-48e3eb9a1e0mr6120924f8f.9.1792912772824; 
 Sun, 25 Oct 2026 00:19:32 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 011/100] tcg: Generic expansion of tcg_gen_addi_*
Date: Sun, 25 Oct 2026 08:17:46 +0100
Message-ID: <20261025071915.1123867-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42e.google.com
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  9 +--------
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 34 ++++++++++++++--------------------
 3 files changed, 16 insertions(+), 28 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 879cc85bc9..61eced5ad1 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_subfi_i32(TCGv_i32 ret, int32_t arg1, TCGv_i32 arg2);
 void tcg_gen_subi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -226,7 +225,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2);
 void tcg_gen_subi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
@@ -544,12 +542,7 @@ static inline void tcg_gen_st_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t o)
 
 QEMU_ARG_NONNULL void tcg_gen_discard_ptr(TCGv_ptr a);
 QEMU_ARG_NONNULL void tcg_gen_add_ptr(TCGv_ptr r, TCGv_ptr a, TCGv_ptr b);
-
-static inline void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b)
-{
-    glue(tcg_gen_addi_,PTR)((NAT)r, (NAT)a, b);
-}
-
+QEMU_ARG_NONNULL void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b);
 QEMU_ARG_NONNULL void tcg_gen_mov_ptr(TCGv_ptr d, TCGv_ptr s);
 QEMU_ARG_NONNULL void tcg_gen_movi_ptr(TCGv_ptr d, intptr_t s);
 
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 73b1ec3d05..faa83a09b2 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -2,6 +2,7 @@
 /* Templated TCGv_i32 and TCGv_i64 operations */
 
 DEF3(add, TCGV, TCGV, TCGV)
+DEF3(addi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 83ecbaae8b..9544688daf 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -368,6 +368,15 @@ void tcg_gen_add(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_add, type, dst, src1, src2);
 }
 
+void tcg_gen_addi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    if (src2 == 0) {
+        tcg_gen_mov(type, dst, src1);
+    } else {
+        tcg_gen_add(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -387,16 +396,6 @@ void tcg_gen_movi(TCGType type, TCGTemp *dst, int64_t src)
 
 /* 32 bit ops */
 
-void tcg_gen_addi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    /* some cases can be optimized here */
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_add_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_sub_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     tcg_gen_op3_i32(INDEX_op_sub, ret, arg1, arg2);
@@ -1534,16 +1533,6 @@ void tcg_gen_mul_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_gen_op3_i64(INDEX_op_mul, ret, arg1, arg2);
 }
 
-void tcg_gen_addi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    /* some cases can be optimized here */
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_add_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_subfi_i64(TCGv_i64 ret, int64_t arg1, TCGv_i64 arg2)
 {
     if (arg1 == 0) {
@@ -2765,6 +2754,11 @@ void tcg_gen_add_ptr(TCGv_ptr r, TCGv_ptr a, TCGv_ptr b)
                 tcgv_ptr_temp(a), tcgv_ptr_temp(b));
 }
 
+void tcg_gen_addi_ptr(TCGv_ptr r, TCGv_ptr a, intptr_t b)
+{
+    tcg_gen_addi(TCG_TYPE_PTR, tcgv_ptr_temp(r), tcgv_ptr_temp(a), b);
+}
+
 void tcg_gen_discard_ptr(TCGv_ptr s)
 {
     tcg_gen_discard(TCG_TYPE_PTR, tcgv_ptr_temp(s));
-- 
2.53.0


