Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892EC606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=f050Jdmn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXDa-0001oY-0N; Wed, 21 Oct 2026 10:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXD7-0001V4-9u
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:43 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXD5-00028d-6l
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:33 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso607609f8f.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592549; x=1793197349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0CMRlZ+YN2I1dlcsQcRxDFBp9UMaSuIH9sydtAVrqBQ=;
 b=f050JdmnoDwJD+McQVuf6HxH/yGj3Z7Wfud60bYch1dE5a15SyRzWBOaCEAJVGE4yL
 9V7qoqGJpcUloKzgqLSQIEUnmZxbkf1LyvvqIpPsiUaon8ljE7wp9/cO8ajugj8FXEdk
 JsP3T3uwscXAiMCKCetyOUSuhdGKO1dXl+5vETPAG21cSpJDOpxarbDVWXilTWPkNdN/
 fnlKnG6vw9QY/i5Rm8sr9+WEq2hsGD6vgm5dnUIdZlN4qXYka3P7yC2qNzi4zjan1BAE
 ZawkozR+bdg30+M5JlpsUyheUR3jfRxy3xTLigCzX6nIV7lzQTXnMT+qYzlrhsKZsJPB
 np8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592549; x=1793197349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0CMRlZ+YN2I1dlcsQcRxDFBp9UMaSuIH9sydtAVrqBQ=;
 b=C7pt/y59lOQx+2KixMSEv2Qyp+DVCmFVs0FrIj0c4SJJFJFwt5LHtYGxPuVPwtREyn
 TgKyHfrK/NTsslYxPkf1F9tmILZNlSJoD1epUVwczxZp9Sf+n0VKNgZmzIPGMym7QGCw
 a0qXLjqljB+s6Kuo19Wje1CXaRgnGD9SlESUGD/Wflo2AWyC/nIpOS5+vOp6cr3i0VUF
 zF9cy3sksbOeSIIivAekRcNeNp3/irGhKH4O0msBD5/Wb9vRwuaYQYbyBBSxZEO9oIfI
 RLO4xvZkvz8HcpKd2Mm1W3RIl3VeBM1tmsP4dggeL2GM4tAB8A0O2jrVQ+88qv8jx+Pp
 4XEw==
X-Gm-Message-State: AFq9FYL6Nakk1ZGu1dtDXUqkC7OkBfKtbw/u4TNVuZQhRDQRHbZTzA35
 rxqWOndD8gLYednbrjtFziWSFTxJT0tG7oOOLuNO7jVV+eBCRLkihUbZyr13/6YvdxwlL4NlvIY
 g9QVO7Lw=
X-Gm-Gg: AYBFou27YNyL9g1LPpyQHLt7VLzW9oOqjFkG6xv6mdO9ceAgxNOCyhqrJxD5ZJfTg3c
 SQKrsyEikWgtnB9vsyBvgbJsep6vFqXSYStvGgTa7z/iXcoEDZBBB+Tg/afZKNUclKUyyBNiCPU
 Y5lC2hgfaTxJIyN2IPbeHrmSP3X4YxIPK2nF/wge4hANWHsz0ErJ/YLCbXwBzEOJ6CSNcN98HWG
 62Ga20LKh/Uo7QuqdN28lidqB5M36bb9tyOEJ8Oq0nsgqtiUlPbLUbcpbMFD3NoOxi+aWjmrkKK
 tVg8acRjOr8znskw/PnUz2hR1HiaTWZjND4KEEo9SSNExRmxrTtA2KbfDZYYzyOUHoc5qvcdnut
 oJfYmPvrTQwHp0FcIabqittLaQSTUg8TpsNu0OOpzFh0GYaJGFemzBRzEoXV/cEsJrPuJARnC8E
 jA8MFQwep40FMbeMTYJ0E6hWh9QymU67qATBAPHzak4Pdx0DJIwq9mwQASCU9k5dDszpLQRiGmr
 SNF+eVMAsQ+jQu05+Ucb2P22ahZkiEeQL0deFHm5T1JaILqtVTLdOOuYYq1nmQCYNfRXwdslV6Q
 S1AwbIro/8OERfloXasAUj4rPTU=
X-Received: by 2002:a5d:5f96:0:b0:48e:22ff:3f9 with SMTP id
 ffacd0b85a97d-48e264ab398mr5104211f8f.10.1792592549430; 
 Wed, 21 Oct 2026 07:22:29 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 050/100] tcg: Generic expansion of tcg_gen_clz_*
Date: Wed, 21 Oct 2026 16:16:02 +0200
Message-ID: <20261021141652.363109-51-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x436.google.com
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


