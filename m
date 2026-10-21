Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD32E606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IIFcRMKB
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXDt-00027d-Rz; Wed, 21 Oct 2026 10:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDM-0001YL-Ig
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:50 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXD8-00029L-HN
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:46 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a0286c981dso8016265e9.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592553; x=1793197353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wv9wWmrGwlQLouzLLQY0LmWs7baHztS7crR/a5OcQ+g=;
 b=IIFcRMKBL++kMaz0CvB7oF3hffrte2WPEtRrHjC4ynUunwKpTG/e2r405FVuJvdtOj
 n4IIv9m2OjghEGumQ0lk9p4yw5Bp5IdcASF3pq2WlODAy16t3kM+2nW90vJgCU4xcgQH
 9O02M0poYuBt2qJSFbNw4rBrMjLQB48tHLRbNHpF5Gk5VnNNccGQJELOqnGPKw11V8zA
 JdETutJYqXu8i2qKNwOhrqwC0pk5V/HmzKLBzgFn6uUYrb5peQxAhP7WiikHugeVPuV5
 k5Rsdc9fplr1vmUFT7saUEUqv0MLUZoAy/HCmGemkJl/+e/GZTc4c0HycVwXPc4diMpl
 r4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592553; x=1793197353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wv9wWmrGwlQLouzLLQY0LmWs7baHztS7crR/a5OcQ+g=;
 b=XVK3fCCBhdBW+YVaU6gmWLJMOODoE4U7kfRCAgcTsZAZsqLEbACL40i3jsMc8RWoBN
 dBk/VCu56w2hVxc1k4iyVX0U0CKKZjwpl+8hiI/uM4ocBJOhL6gPv9J0oZkK4eiYJsrl
 Zmya13S2b6Mwr3Qnt3waNEJBq25fqlk3b9AkWIQW19uPHnx739ypYLgogydcn3t3Dmqt
 xxkptjn8/u8jgkQGe0QTunL4zuvTpIycs+/9/NT0fpc7MLM66jhLqX5CbU2F1t80Jk5o
 avXi9O30Y7VxP666y8i9/NxiO0cnOy2Bqarf4PplImGioyH9K9Am7V5Jp6D0fWrH5KQF
 tVew==
X-Gm-Message-State: AFq9FYIL4nR2TDoOjk8sMxR2pALhjVP8FDkkYCE72tNq0/8pNv2Q9B8O
 36j1kIxD3ll5sQvmoEiQrrL1/pOeNALe7lvobaabf1dsPdmCJDxTIDZTj+3+XZ+bNyevkcCdOVV
 3mq7YxpA=
X-Gm-Gg: AYBFou1E/5dPbPVwZxXYnmMSrm1tpUYP8z8XzsvB+TM+2K3caNiByVz3e2OaHeX0P40
 GmDb1KJIg+tFgJoSm6CsNcihh4UOB5SDo7GcEVIFGOdURWavQ1FGmYtoYcPp3lOI2nblXS5glBg
 bA+Xcu6jYXgzlPhvJbA/zS1odAYBB02Fps7vAmqcrgc4zxrDZqyF6/EX7FOltTClCbN/EyN+A39
 AlPHxw8xDqcjDbLE+8GPWH8TlCWH3meZQoN5Vd+cI041XzaT5HTRGkHGiWoUN2Ic1uYPDnR/ZA5
 rk/Lywsd0igVYeo+QoBGdu7rwkPTMn+O6es5MpAbAf6xn4WYCuvwpBzenPTEjM05BDiatL9nv9o
 H4IB/8WlUi3LfxpOvQh3MthFnANN60eaoUm7vgdl5wrrx1U2ut2jkWI8Oox85WJ6AY9qbi7MUAR
 Avs5NRm6LsP+dGexIyvbGVjh7lZZGYQzJdfNdTfD6lIm1tmLemrL7CoZH/6dSZ+x34MQ90vLP0L
 co/0YkeLeP0T32hnflTEm8kga86NUuVKQofwQLIg07mhkkhBw3IDY71S8AZl4hvpqimLPpypy8/
 tclq4dw5hGWiBB02PIdwLRGOfb72
X-Received: by 2002:a05:600c:3b22:b0:4a1:dade:f049 with SMTP id
 5b1f17b1804b1-4a1fdd19f80mr47214305e9.15.1792592552982; 
 Wed, 21 Oct 2026 07:22:32 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 054/100] tcg: Generic expansion of tcg_gen_ctz_*
Date: Wed, 21 Oct 2026 16:16:06 +0200
Message-ID: <20261021141652.363109-55-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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
 include/tcg/tcg-op-common.h  |   2 -
 include/tcg/tcg-op-def.h.inc |   1 +
 tcg/tcg-op.c                 | 115 ++++++++++++++---------------------
 3 files changed, 47 insertions(+), 71 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 8c1b7a1968..4c8ef80474 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -129,7 +129,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -187,7 +186,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 66977cada1..2436fea04d 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -11,6 +11,7 @@ DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
 DEF3(clz, TCGV, TCGV, TCGV)
 DEF3(clzi, TCGV, TCGV, TINT)
 DEF2(ctpop, TCGV, TCGV)
+DEF3(ctz, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index bad47af1c7..730962f052 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -467,6 +467,52 @@ void tcg_gen_ctpop(TCGType type, TCGTemp *dst, TCGTemp *src)
     }
 }
 
+void tcg_gen_ctz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    g_autoptr(TCGTemp) t1 = NULL;
+
+    if (tcg_op_supported(INDEX_op_ctz, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_ctz, type, dst, src1, src2);
+        return;
+    }
+    if (tcg_op_supported(INDEX_op_ctpop, type, 0)) {
+        t1 = tcg_temp_new_ebb(type);
+        tcg_gen_addi(type, t1, src1, -1);
+        tcg_gen_andc(type, t1, t1, src1);
+        tcg_gen_ctpop(type, t1, t1);
+    } else if (tcg_op_supported(INDEX_op_clz, type, 0)) {
+        int width = tcg_type_bits(type);
+
+        t1 = tcg_temp_new_ebb(type);
+        tcg_gen_neg(type, t1, src1);
+        tcg_gen_and(type, t1, t1, src1);
+        tcg_gen_clzi(type, t1, t1, width);
+        tcg_gen_xori(type, t1, t1, width - 1);
+    } else if (type == TCG_TYPE_I64) {
+        gen_helper_ctz_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src1),
+                           temp_tcgv_i64(src2));
+        return;
+    } else if (tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0) ||
+               tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0) ||
+               tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
+        g_autoptr(TCGTemp) t2 = tcg_temp_new_ebb(TCG_TYPE_I64);
+
+        t1 = tcg_temp_new_ebb(TCG_TYPE_I64);
+        tcg_gen_extu(t1, src1);
+        tcg_gen_extu(t2, src2);
+        tcg_gen_ctz(TCG_TYPE_I64, t1, t1, t2);
+        tcg_gen_extrl(dst, t1);
+        return;
+    } else {
+        gen_helper_ctz_i32(temp_tcgv_i32(dst), temp_tcgv_i32(src1),
+                           temp_tcgv_i32(src2));
+        return;
+    }
+
+    tcg_gen_movcond(type, TCG_COND_EQ, dst, src1,
+                    tcg_constant_internal(type, 0), src2, t1);
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -773,46 +819,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    TCGv_i32 z, t;
-
-    if (tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_ctz, ret, arg1, arg2);
-        return;
-    }
-    if (tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t2 = tcg_temp_ebb_new_i64();
-        tcg_gen_extu_i32_i64(t1, arg1);
-        tcg_gen_extu_i32_i64(t2, arg2);
-        tcg_gen_ctz_i64(t1, t1, t2);
-        tcg_gen_extrl_i64_i32(ret, t1);
-        tcg_temp_free_i64(t1);
-        tcg_temp_free_i64(t2);
-        return;
-    }
-    if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_REG, 0)) {
-        t = tcg_temp_ebb_new_i32();
-        tcg_gen_subi_i32(t, arg1, 1);
-        tcg_gen_andc_i32(t, t, arg1);
-        tcg_gen_ctpop_i32(t, t);
-    } else if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_REG, 0)) {
-        t = tcg_temp_ebb_new_i32();
-        tcg_gen_neg_i32(t, arg1);
-        tcg_gen_and_i32(t, t, arg1);
-        tcg_gen_clzi_i32(t, t, 32);
-        tcg_gen_xori_i32(t, t, 31);
-    } else {
-        gen_helper_ctz_i32(ret, arg1, arg2);
-        return;
-    }
-
-    z = tcg_constant_i32(0);
-    tcg_gen_movcond_i32(TCG_COND_EQ, ret, arg1, z, arg2, t);
-    tcg_temp_free_i32(t);
-}
-
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     if (arg2 == 32
@@ -1674,35 +1680,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    TCGv_i64 z, t;
-
-    if (tcg_op_supported(INDEX_op_ctz, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_ctz, ret, arg1, arg2);
-        return;
-    }
-    if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
-        t = tcg_temp_ebb_new_i64();
-        tcg_gen_subi_i64(t, arg1, 1);
-        tcg_gen_andc_i64(t, t, arg1);
-        tcg_gen_ctpop_i64(t, t);
-    } else if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-        t = tcg_temp_ebb_new_i64();
-        tcg_gen_neg_i64(t, arg1);
-        tcg_gen_and_i64(t, t, arg1);
-        tcg_gen_clzi_i64(t, t, 64);
-        tcg_gen_xori_i64(t, t, 63);
-    } else {
-        gen_helper_ctz_i64(ret, arg1, arg2);
-        return;
-    }
-
-    z = tcg_constant_i64(0);
-    tcg_gen_movcond_i64(TCG_COND_EQ, ret, arg1, z, arg2, t);
-    tcg_temp_free_i64(t);
-}
-
 void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     if (arg2 == 64
-- 
2.53.0


