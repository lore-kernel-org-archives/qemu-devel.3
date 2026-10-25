Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F968606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=K+T0FUxv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsaX-0000ZR-9f; Sun, 25 Oct 2026 03:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZX-0006N0-VL
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:16 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZU-00045F-WC
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:15 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4a2084d62cdso16537395e9.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912991; x=1793517791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fzAFeMkkhBBt+34pnHcb3kBMLp1Z6itS82tlzknnwPc=;
 b=K+T0FUxv3LA35OcVsCgKFbXW5+umFroM4OzAybeaCIpRDrgPAEXVh9Xki1kuLsd80Y
 oWlZfezkWCwIezxm7WCy389D+IXVkmvJ1FV88T5XDupPsIxhyYykUO8SnoBNuwMBn01m
 0A03dGhgpLe4jAirZl3M5X7E6nAvs1d2xsLuWqjwG2ghAGwI8TnspPI8o6oNCblNZKnq
 +DjfdvWfKJWZ+XJd4kEVOuvNDtOWBq+6L9tkMDlmPV1W7nJDg3FUrviTkDn/eFtYAMR0
 IBkD9PD7EXbS/SuYzNbkpFoFAALdvrGwqcCpRzHhjBlMhacirq5P6fr3AChC3TCaChjs
 Qeow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912991; x=1793517791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fzAFeMkkhBBt+34pnHcb3kBMLp1Z6itS82tlzknnwPc=;
 b=hB3IgnSpXyXrzToBE6r+1bolfvhBKK8qZS+RgGGuIxCt/gbswUneLcqiMtRFrZ6gAr
 zdGa8OtPXJLvXq6sZr0fBrracNFAKs2mVOFqtmIIaOmgsUf/iVDW0kBd9dDmhGRnobw5
 3IjEYc62HLBONlJoFOsEjxcj0uPksK3/ji9h7t3redXPZCRjoomdw12gQY6Stb0jkaQ7
 oRJ9rckZpnpr0WYu24/gmEhXjzlrsbxBLI74vhsL1B4jJ3MmSJD7va+iuC+Ev4Ub9fzB
 Lu5QkrzuitqqDwXLmp+ZQvk9ETc1cWo468e9FqUIpwpq9Ve7FivYRFO8JsXqlbqh3oaL
 GHQA==
X-Gm-Message-State: AFq9FYKWPhpgoj+1QgEoWzK8MsqbxtSwTISnYDdhvuRafy6/kJxEf598
 /o8zKAVJHaEBaQB81kpJcgalUnClaIfbViwM8e68UYgnrKi/CmBYGMJaiCN7FrpEslcR7wQYrXZ
 BW4AsVrQ=
X-Gm-Gg: AYBFou1zulIw5FqJSeGN563GMcjz2nSCw0r2nLam1uUcFmH4bpd2+44DmJYx40C5G6C
 FFRoeJVw3XBPb9nocdWsXDlbtu69vGRnWme1rNaYT7qUE6X0H0gb1+Y+zWPIcy99xHA8Ez4cspT
 8hMxt/UCEPS00tKhjCy76ChePKe4iJg5+AsZFkvbF6M0lGh3FuzAtG8I3WfcaaBfYIm4O1hh9X4
 n5SY+YTkAb+a+v3Unzz9k8Yik2ZsG3oT3Z9wcNIyPkoBDb8O1cogaWlZRlALTkHPYeeFXGahvuS
 yOXwNMICDGqp/E6Dv6hamxchAW+RwK2sCm0X2H3qXsOn3YWTeFZMzQTXeqNzrg2k0C6kM7O2aS3
 qJ7EmfjDQTgbGot4JEvhpoITynjObpDLQxPcYzEXotm82eCoQfQdNj3r4+GSx1XQjM8HIE2wbtA
 0NAIRD5eTIeASSFxnPycr3188203YZD/05yEl7zF/x7yyC7ppb6d56nPmmhHr8tvnr5Dck3epDm
 OlNQy8AYIrzIXnqPvhsp5q1yjE97i6rvspIltdq7cwz5zp9Lqi8e+PubimYvy/5Oe+2rPac3z84
 Di9M
X-Received: by 2002:a05:600d:84ca:20b0:4a1:97c6:d2e8 with SMTP id
 5b1f17b1804b1-4a35acb35dbmr35913765e9.32.1792912991231; 
 Sun, 25 Oct 2026 00:23:11 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 050/100] tcg: Generic expansion of tcg_gen_clz_*
Date: Sun, 25 Oct 2026 08:18:25 +0100
Message-ID: <20261025071915.1123867-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
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
 tcg/tcg-op.c                 | 52 ++++++++++++++++--------------------
 3 files changed, 24 insertions(+), 31 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 0ad0301e17..8dae7096aa 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -129,7 +129,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
@@ -190,7 +189,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
 void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index a1c1e9b918..74c68f46b7 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -8,6 +8,7 @@ DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
 DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
+DEF3(clz, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 75bc8a6a91..ee80ab9323 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -422,6 +422,29 @@ void tcg_gen_brcondi(TCGType type, TCGCond cond, TCGTemp *src1,
     tcg_gen_brcond(type, cond, src1, tcg_constant_internal(type, src2), l);
 }
 
+void tcg_gen_clz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_clz, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_clz, type, dst, src1, src2);
+    } else if (type == TCG_TYPE_I64) {
+        gen_helper_clz_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src1),
+                           temp_tcgv_i64(src2));
+    } else if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(TCG_TYPE_I64);
+        g_autoptr(TCGTemp) t2 = tcg_temp_new_ebb(TCG_TYPE_I64);
+
+        tcg_gen_extu(t1, src1);
+        tcg_gen_extu(t2, src2);
+        tcg_gen_addi(TCG_TYPE_I64, t2, t2, 32);
+        tcg_gen_op_ttt(INDEX_op_clz, TCG_TYPE_I64, t1, t1, t2);
+        tcg_gen_extrl(dst, t1);
+        tcg_gen_addi(TCG_TYPE_I32, dst, dst, -32);
+    } else {
+        gen_helper_clz_i32(temp_tcgv_i32(dst), temp_tcgv_i32(src1),
+                           temp_tcgv_i32(src2));
+    }
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -728,26 +751,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_clz, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t2 = tcg_temp_ebb_new_i64();
-        tcg_gen_extu_i32_i64(t1, arg1);
-        tcg_gen_extu_i32_i64(t2, arg2);
-        tcg_gen_addi_i64(t2, t2, 32);
-        tcg_gen_clz_i64(t1, t1, t2);
-        tcg_gen_extrl_i64_i32(ret, t1);
-        tcg_temp_free_i64(t1);
-        tcg_temp_free_i64(t2);
-        tcg_gen_subi_i32(ret, ret, 32);
-    } else {
-        gen_helper_clz_i32(ret, arg1, arg2);
-    }
-}
-
 void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2)
 {
     tcg_gen_clz_i32(ret, arg1, tcg_constant_i32(arg2));
@@ -1669,15 +1672,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_clz, ret, arg1, arg2);
-    } else {
-        gen_helper_clz_i64(ret, arg1, arg2);
-    }
-}
-
 void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2)
 {
     tcg_gen_clz_i64(ret, arg1, tcg_constant_i64(arg2));
-- 
2.53.0


