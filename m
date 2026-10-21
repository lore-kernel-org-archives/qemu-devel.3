Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9127606A323
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=xdJzrc1R
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXEZ-00031g-3t; Wed, 21 Oct 2026 10:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDU-0001km-Ut
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:58 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDS-0002Cc-5C
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:56 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso812792f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592572; x=1793197372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nYXCwTxFdP7dJKgdqlDFQr25qk2tcFqtETAgBvVKDYQ=;
 b=xdJzrc1Rc1/YjT6EdJ2BqenQLTA+iozFzRye0qcjT5Rsfh+66yVXRjizZdmO4ewb/0
 Go4erbyDBzNbVNpZfNq6bblDzkDtVfSjW82pAIpiwbiGcYylfKHDq2QwuC92iaWPxe6u
 3LagoahjR1G0+3pPIEaIoUByooX9tNzoNEJCNp7Vqp7FvUBkMX91KLb3mCeaItzwzS3a
 jH/yoHOv+jKJhBE2trxo9hpxQn1uF1eCrYiidTamR7/noOLG16voA9OLbrdfa++Ip3Pc
 w1c/FFdi708nPk5fGxRw+p3sHaSeDUXDT/4fHFuiQ7CVnBsKVjs8zYTHuZvmEjL5f/CP
 uJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592572; x=1793197372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nYXCwTxFdP7dJKgdqlDFQr25qk2tcFqtETAgBvVKDYQ=;
 b=mPQ6SUe3g3w9PXhO4zubP1pSF04HyXcRDF04D1cDTK+oeL0F5VwT+lyG6d2SnCFZn5
 vaxXDLLzJHcdDTlSyzdGuXCoRvU951t7bFjGdv2q3o5TtTpX0PrHcw919qu23ekr16X3
 cBOvcldX8xMlEVzfM1IHuNwURASnLFQv9du5rv5dtzSZqeHOKkBQP35O8rnS2hPL1rCi
 6n0467JqhhadkP323Pn02cvbjwFK208enDFuVyuEgfc5lJhl1HdJgPZOgZFokM6oQF8G
 +MicP1/oH+sCFIetPgE4ZZ60CXpsOZFLqjG9ntz9HlOnUUOv1BWeNSe6SjIHMlA32qv3
 1Vhg==
X-Gm-Message-State: AFq9FYLCvfppcV0W6sX3H2I/gzrUKt5oeatl0ETOI0cCI6c3oRSDwOuC
 AQI32+u5YMnSW5jI7+p5z6VeqgNy+ftEPSj9FX0O2VJtaK53ed+6TOtCPa8VimcRUN4Xrq2AAx5
 4hOWm+L0=
X-Gm-Gg: AYBFou29zroec8zebIzXCcX1O/umllwGw3gWgxLpn0h5275Lp7AosQecoVH6tHWXz6h
 qe+eNH5Kn8lxcPpaCHc7qeAZDaq1u4H34pHgq/jeppNdUeWEdRiFZ8G2pS7vTVs01cIJei8+pOj
 TMsK8Zdwc6qD+JEXOH4WtBZSw6s3eXj99kAEcXpp8EYwZuwV74AG8rcJQupSJba8mWDl5M9iL0a
 5Y5qcIH+Ds0JwMJ1FvSSdAhcGO6Ljuw7osfuPck3FpO/Ka1UkvPTVZDGFwbyvC0Zqu+vgThJ/22
 ceH7AZ9B7BHkc0/oW2cCYQEeR2pWdysmRyjDcGwemjPVj1N+z+nrJLzUFoG0EUhknWh+BAs/74u
 qSy0HJN1aMq5bbGSZzYcb4rdjKKlnvbInCfABQ+1sWyS2XzLD36TfnrjDep/D73rt3WXOrrf4bh
 ZCuQwJJmmggJcl5ZplDLlbD1Lqcm/AeX00g7JKdq4cZgVKGMzIx8Brui4Ma8EXGnkwyD5djye+X
 ufLjB1vCOUq1MoSYBm5I6DRMlzBar/zt1qvo8pEple8Ievx+bPdWi+nGFZyLLSzXVfBrkvWSj7I
 lPMvTTB2HauYeUV0gL7RnaYP8sc=
X-Received: by 2002:a5d:6f04:0:b0:48a:fb1c:c2a1 with SMTP id
 ffacd0b85a97d-48e264e5a1amr4377622f8f.47.1792592572479; 
 Wed, 21 Oct 2026 07:22:52 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 074/100] tcg: Generic expansion of tcg_gen_abs_*
Date: Wed, 21 Oct 2026 16:16:26 +0200
Message-ID: <20261021141652.363109-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x432.google.com
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
 tcg/tcg-op.c                 | 34 ++++++++++++++--------------------
 3 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 4a79e3e1f6..9491879685 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -147,7 +147,6 @@ void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 
@@ -186,7 +185,6 @@ void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
 void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 3c93c20704..19c6347fa7 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: MIT */
 /* Templated TCGv_i32 and TCGv_i64 operations */
 
+DEF2(abs, TCGV, TCGV)
 DEF3(add, TCGV, TCGV, TCGV)
 DEF3(addi, TCGV, TCGV, TINT)
 DEF3(and, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a288c14813..c1ce4172ef 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -331,6 +331,20 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
  * are of the proper type.
  */
 
+void tcg_gen_abs(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+    if (tcg_op_supported(INDEX_op_smax, type, 0)) {
+        tcg_gen_neg(type, tmp, src);
+        tcg_gen_smax(type, dst, tmp, src);
+    } else {
+        tcg_gen_sari(type, tmp, src, tcg_type_bits(type) - 1);
+        tcg_gen_xor(type, dst, src, tmp);
+        tcg_gen_sub(type, dst, dst, tmp);
+    }
+}
+
 void tcg_gen_add(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_add, type, dst, src1, src2);
@@ -1375,16 +1389,6 @@ void tcg_gen_ussub_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
     tcg_temp_free_i32(t);
 }
 
-void tcg_gen_abs_i32(TCGv_i32 ret, TCGv_i32 a)
-{
-    TCGv_i32 t = tcg_temp_ebb_new_i32();
-
-    tcg_gen_sari_i32(t, a, 31);
-    tcg_gen_xor_i32(ret, a, t);
-    tcg_gen_sub_i32(ret, ret, t);
-    tcg_temp_free_i32(t);
-}
-
 void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_ld8u, ret, arg2, offset);
@@ -1879,16 +1883,6 @@ void tcg_gen_ussub_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
     tcg_temp_free_i64(t);
 }
 
-void tcg_gen_abs_i64(TCGv_i64 ret, TCGv_i64 a)
-{
-    TCGv_i64 t = tcg_temp_ebb_new_i64();
-
-    tcg_gen_sari_i64(t, a, 63);
-    tcg_gen_xor_i64(ret, a, t);
-    tcg_gen_sub_i64(ret, ret, t);
-    tcg_temp_free_i64(t);
-}
-
 /* Size changing operations.  */
 
 void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
-- 
2.53.0


