Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C1F606A31B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iVWHhEUF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXDy-0002Oa-CR; Wed, 21 Oct 2026 10:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXD8-0001VO-J2
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:43 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXD6-000292-Ra
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:34 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so485096f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592551; x=1793197351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uR+xOtdHTIxjNl5nhW5OSQLlZ0XlfMOSr45pXLHnR58=;
 b=iVWHhEUFXi/i2pkI0TrzHm8/q2/ABvMzr86hVMCt+X08Ymn9UYJ0NMzASZJfQ1S/f3
 Z8+6AcHRb91HIHXeqpfoGejyyzkZ3Kj6CSI2g2kJTDArhqHfuFe0DJSAbFxU7y9WCcQ6
 DZhWpsHC0fnadhEtiQJuuTCQUWouK53+aHK33n9QAhT6Ot2O3DDikw7u3zpZXbYp8Ubk
 LRLo90hPJPrI/dv8tAaAsMjia+dzOUjCYpyG0595H5Vu2Tis0LOi6OJz6+ugjF3h1C32
 K2H8mvwmmlsJhHkdG1lNx3RL56rXwI2UW3+RcHnYrPjjI238R54G5nKGHAEC9s2fEvXp
 mZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592551; x=1793197351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uR+xOtdHTIxjNl5nhW5OSQLlZ0XlfMOSr45pXLHnR58=;
 b=tVMRlQu26ZU1RNrFgOeZCX7xLcgIT8RiX7M2yeKitZ/gTvfLT/KKyy2uzi2eTv6d3E
 3Ub4l4HlGnQFUE74RrR35120K+yBuwRUYNIlPQ1Q83STKRhGJXppWcxkB0m9Ms1hQC2D
 L/Ky1cZg37Vx5gYAIKQAx3GPiZCAKZTlBbuNpZUi3gypo/KzRldqKjY7thcbEkjNDkb7
 8Zd7Qfhf3dGBezViOSnzdm1wp9Iw8MJpCMHoMbKKxyltiT2W100aA3zlYDzzfj6tVc/D
 xZAK5BHq0nNfwfE9Kv0+JtyOBB7i4IYyrLDAk0s7E5gVa1dJP9akzb79flIHhi7kFCSO
 8JlA==
X-Gm-Message-State: AFq9FYK84S5qR+m1hIpUauxPjJxpldtit2BJtoGKOY6eqchA0ohnsG9y
 GkitUMARn+5JCd03ZwDZkOc5Zg62yZo5JcvAnyM6RCwYSGqJze/3zPyvWX2wN8BMP+rxINCFLMy
 wU/tfs0M=
X-Gm-Gg: AYBFou0/PYHWedq6KvnDrH4l7MagJL7ooiqcjxfUBojyITVOIsPBzohh4cSyzS5+l/7
 D9WVz0rnOxFDMVVObdzHF8tu8cy3QtGV3+I4Z6D7iJdrqX9ZtHKQCFwtxutyMXVCdFjEUID7Szl
 Ab9wRy22nG5gCzUubJSZv5mrHzdq+Ln/AUQ1Tjs3KXW3cy5pK7fQgyj42qMzbHxh5JtHgCp0KGA
 iqmwhAXvmoZxL9DsSwx9CH2/zbfdFI4zILoP21oBe6YkimX5cakYPAsumxdntYKsfmlphnKiAm7
 u55QYXayDIZ92IIpADxx2XJpteDYf9yGzq4quI/Y6st5V4FVa5Bz7P3Ya0oNpbr4eh3eCTLXPA1
 PvuvZzRjQUmdc4xuO/jb9efDlbLJEJprXubxt12AvgrOPIhO5AB1J5hH52AsfHQ24gtR1e9p69i
 l1CrVsTBDt6dYIeiUMUazFd759mzWtE0XCD0HjRmRGxDj42kzO+0anC4o0DkEHTHNBWk9htfec5
 +ISFHq783itBYi0Gcz8Z0lO3/Jk1Wf0t/ACD4dk5qSd5Pg9Esy+5maD9BfSFSqC8eNOVHXmyipH
 bBkWU2dMZ6J7uF70AP4ASN/UIrU=
X-Received: by 2002:a05:6000:25c3:b0:48c:43a3:6a74 with SMTP id
 ffacd0b85a97d-48e2649d874mr5456532f8f.12.1792592551130; 
 Wed, 21 Oct 2026 07:22:31 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 052/100] tcg: Generic expansion of tcg_gen_clzi_*
Date: Wed, 21 Oct 2026 16:16:04 +0200
Message-ID: <20261021141652.363109-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x42b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index b5575647d3..d68362fd02 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -130,7 +130,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ctpop_i32(TCGv_i32 a1, TCGv_i32 a2);
@@ -190,7 +189,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 /* 64 bit ops */
 
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ctpop_i64(TCGv_i64 a1, TCGv_i64 a2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 74c68f46b7..cf832a6dc0 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -9,6 +9,7 @@ DEF3(andc, TCGV, TCGV, TCGV)
 DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
 DEF3(clz, TCGV, TCGV, TCGV)
+DEF3(clzi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index e623f9bbc7..efbbe4d8a1 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -445,6 +445,11 @@ void tcg_gen_clz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_clzi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    tcg_gen_clz(type, dst, src1, tcg_constant_internal(type, src2));
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -751,11 +756,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_gen_clz_i32(ret, arg1, tcg_constant_i32(arg2));
-}
-
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     TCGv_i32 z, t;
@@ -1672,11 +1672,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_gen_clz_i64(ret, arg1, tcg_constant_i64(arg2));
-}
-
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     TCGv_i64 z, t;
-- 
2.53.0


