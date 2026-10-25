Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AF5606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=dsA3A7qg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsWM-0006OI-IU; Sun, 25 Oct 2026 03:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWF-0006HN-Lf
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:52 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsWD-0003jH-Md
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:19:51 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-48b042c0728so487096f8f.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792912788; x=1793517588; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WetOpv71G4sVmqzEJNcHUnKf0RMeAFwhk9uDBnS9sR4=;
 b=dsA3A7qgDXQgu8dBifZAnEu2u1vZOCDiTuhY/b6PgSv9FLY+u8EEqu/w8KKCIy0yEm
 KE3Y4aGXiccWejIABujjnzQCI4QLpUyA84U0Tp0hZ64260k5fFD8XbH28ROYwFbJzf+v
 rbJWrsQmp7clz5lULVZNyN2iwEmAXSNw9pzrTVkCjoV6cZMz0XJ/VQtHwhjsebuS45mj
 WvKEw7Nn+k6wO92petVeOkC5CSZ11o6x3sLOzSJ3SRUir7VAUMJPZQaSORWWcSVLBBSM
 bHWyQQPysSq05FEnEw9T1fZj92rS3ob69UIpZn9yPPIoNze2v3nD0f560r5ltEw+GJQ6
 /2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792912788; x=1793517588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WetOpv71G4sVmqzEJNcHUnKf0RMeAFwhk9uDBnS9sR4=;
 b=SDBmcfMTUj+A6eFzhakIOzekKB2kTOeZf+xisv3vccGmtMkieTOtSzagE4w30nkUGI
 HnBMeYyjf9tLHjocuvDs/tO2iRBn9z1sTJYciU/Lb12C6O96FR7InTn7WA2+QGo9FArr
 VFPdtb1Y5T9ECambZuNsaat8/a9qakRGPhGM8N47GAZoTJ9F5y2+/dNeIgGv3mcLHWI+
 NiUdLqtT8b2eEDVBvEFfVRLCTvFYz0bDdPGH8Ljqhv9Rd8SUrCl3NyUi3/EPvGK4rlEw
 U9NmrhzhhOvhMwNeKirLNX3pA2ISb6YfcVQWBTp59xXSbSdoUqJXkfwhwNIInO9M3mCx
 JSvA==
X-Gm-Message-State: AFq9FYK9AjnxgqrK6vv1tLYpql3Eaoc1GHKniddSY4uWad6aK0q/62yT
 LvlifmrjoQYXrt63MGWYIBiOowoM1XmDU321gA7rTEPhgReRgdHFI8/EPuzxk8LUkRSZSZgHcl7
 TYCY33xc=
X-Gm-Gg: AYBFou0L8qalBKMfg5+DA1L9A4rI5ckMsPCbsiHUaip6BATW7zdNHw+vH32r88XGw30
 r479tqndtwOcWH1UKq2rgxVWNp+facbKXlDW0nN9KTfKfg3FR+1hzpj4G69wp95N88iPONntXAK
 ROWPHiY5VFPXwLA2Z/2veQ7IyZKGCojYetse9eIJ3HOBJ7jN2g+HXi8orR6XdQc7M819nXLVQgx
 K8ONnlJ9leK9nZYea72/0LY77hcx9ZqNqb30iISOg8BT9blG5HgBUXcUzTdXZGenUaeT+HecDNf
 wiLM00wikLBQX/5PqpROyNiNggKRirRk4YpVfxjXz8ABPUSUoufC1oGo/JNLhvurgwJ+jhJ5Gdj
 zMTZTPtxa+kXOUpj5LbMDJ9FCiuQs6LrKQmU0njVUBCPiCc1bdPiK/1SY6OSc4j2EiqSDxS3gQo
 1ayxZMBH4VlLrYgv0Yus7VgVZ+3h9jaJyqBQ30VCW5jEBxpCIhOPsEHxfJtbMdnATEj/OMDMHCU
 qik/tLH0HXHUaEtcVsVz94GZExZlej2DbOubmNKAv/1y+eqdockVApIrw==
X-Received: by 2002:a05:6000:2511:b0:48e:2371:3835 with SMTP id
 ffacd0b85a97d-48e3eba89a5mr5854353f8f.51.1792912787959; 
 Sun, 25 Oct 2026 00:19:47 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm4006309f8f.40.2026.10.25.00.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:19:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 026/100] tcg: Generic expansion of tcg_gen_andi_*
Date: Sun, 25 Oct 2026 08:18:01 +0100
Message-ID: <20261025071915.1123867-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x435.google.com
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
 include/tcg/tcg-op-common.h  |  2 -
 tcg/tcg-internal.h           |  6 +++
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 84 +++++++++++-------------------------
 4 files changed, 31 insertions(+), 62 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 7ca448b922..1108d185e8 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -211,7 +210,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* 64 bit ops */
 
-void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index 0da1a9c440..76c8f026a6 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -114,6 +114,12 @@ static inline void tcg_gen_op_ttt(TCGOpcode opc, TCGType type,
     tcg_gen_op3(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2));
 }
 
+static inline TCGOp *tcg_gen_op_ttii(TCGOpcode opc, TCGType type, TCGTemp *t0,
+                                     TCGTemp *t1, TCGArg a2, TCGArg a3)
+{
+    return tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), a2, a3);
+}
+
 QEMU_RET_ARG_NONNULL
 TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op,
                             TCGOpcode, TCGType, unsigned nargs);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 2108082ce6..f7e7f4d2a1 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -4,6 +4,7 @@
 DEF3(add, TCGV, TCGV, TCGV)
 DEF3(addi, TCGV, TCGV, TINT)
 DEF3(and, TCGV, TCGV, TCGV)
+DEF3(andi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8c298ae79a..34e1e736be 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -382,6 +382,30 @@ void tcg_gen_and(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_and, type, dst, src1, src2);
 }
 
+void tcg_gen_andi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    if (src2 == 0) {
+        tcg_gen_movi(type, dst, 0);
+    } else if (src2 == -1) {
+        tcg_gen_mov(type, dst, src1);
+    } else {
+        /*
+         * Canonicalize on extract, if valid.  This aids x86 with its
+         * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcode
+         * which does not require matching operands.  Other backends can
+         * trivially expand the extract to AND during code generation.
+         */
+        if (is_power_of_2(src2 + 1)) {
+            unsigned len = cto64(src2);
+            if (TCG_TARGET_extract_valid(type, 0, len)) {
+                tcg_gen_op_ttii(INDEX_op_extract, type, dst, src1, 0, len);
+                return;
+            }
+        }
+        tcg_gen_and(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -485,36 +509,6 @@ void tcg_gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 
 /* 32 bit ops */
 
-void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    /* Some cases can be optimized here.  */
-    switch (arg2) {
-    case 0:
-        tcg_gen_movi_i32(ret, 0);
-        return;
-    case -1:
-        tcg_gen_mov_i32(ret, arg1);
-        return;
-    default:
-        /*
-         * Canonicalize on extract, if valid.  This aids x86 with its
-         * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcode
-         * which does not require matching operands.  Other backends can
-         * trivially expand the extract to AND during code generation.
-         */
-        if (!(arg2 & (arg2 + 1))) {
-            unsigned len = ctz32(~arg2);
-            if (TCG_TARGET_extract_valid(TCG_TYPE_I32, 0, len)) {
-                tcg_gen_extract_i32(ret, arg1, 0, len);
-                return;
-            }
-        }
-        break;
-    }
-
-    tcg_gen_and_i32(ret, arg1, tcg_constant_i32(arg2));
-}
-
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -1493,36 +1487,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    /* Some cases can be optimized here.  */
-    switch (arg2) {
-    case 0:
-        tcg_gen_movi_i64(ret, 0);
-        return;
-    case -1:
-        tcg_gen_mov_i64(ret, arg1);
-        return;
-    default:
-        /*
-         * Canonicalize on extract, if valid.  This aids x86 with its
-         * 2 operand MOVZBL and 2 operand AND, selecting the TCGOpcode
-         * which does not require matching operands.  Other backends can
-         * trivially expand the extract to AND during code generation.
-         */
-        if (!(arg2 & (arg2 + 1))) {
-            unsigned len = ctz64(~arg2);
-            if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, len)) {
-                tcg_gen_extract_i64(ret, arg1, 0, len);
-                return;
-            }
-        }
-        break;
-    }
-
-    tcg_gen_and_i64(ret, arg1, tcg_constant_i64(arg2));
-}
-
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     /* Some cases can be optimized here.  */
-- 
2.53.0


