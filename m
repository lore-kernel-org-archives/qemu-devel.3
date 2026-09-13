Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40EC0C88E5A
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:45:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aB5-0002mQ-Pb; Sat, 12 Sep 2026 22:42:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aAv-0001hY-QD
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:37 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aAt-0001sQ-U2
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:37 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2d6e954afbdso16523195ad.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267354; x=1789872154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WlwlrVY/DkWl6vYBCl2k+q6ogIoFX6D/yFCJIEDRLt4=;
 b=ODPMY77pEVOhl6K5O3Z3M8r792sCESrtfegZTytRPNwUWs7e8LOkm4Ikm+u3qd6CPT
 4/rP6fi+9Iu+ko9ArLQv+Gngm00yBTrPglhTQozcCIoY3M18EC+iz6R0EtUk72tA3P9r
 x/lh7rSxPOcNp4ClpWzgWOvPg8jKt6P6d25hszDae2bnvZxlfy6w9/KiiVn4E4t6TK7W
 MBs74+hz81M2nvPjWERPvzJ4U2yyKEv41v1n9kgw8bIuzq5Jl89WsqY9YKRuuoSGpds5
 urUxpWY6kRqCb+xkzOQtsi5qhcPOOnmWqsCdqV9t6qxS1mYNDnjVKS9b19u2Sq2OebKn
 /AvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267354; x=1789872154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=WlwlrVY/DkWl6vYBCl2k+q6ogIoFX6D/yFCJIEDRLt4=;
 b=DR2xQoBTV5YZku+waw30QA9v9guJEqcRjeoXHO+bplYKd9zIzA0Bztj/nt9axNOl5t
 /0TObh5u0Z+guuZBMdU8teX2udFo+LCKd8y/sWdnL4lools4IIKf8/2Wpyu2PEW2QkVV
 txdPRZoiNsYGH0cjGtHo91g51TTn/IwM9nIE7ht1Vogat6pDE79yLmm45Fu9HMMPDPch
 TCSESKeiwBb+lFVsfqnNXIuM9sf2GLJiPk9yWrWmGj01xxM3C/ptbPX3P7cGkJ0OMBrT
 Qt8gf4bRIBZG0KM8oNZzrd7m397rQkHNVaa4LO6nBYM8aBpJs2+Ka5UibWrKDZADkV3e
 RamA==
X-Gm-Message-State: AFuF++nDm4qasg7W4dDVZaTMLDK1xzm5xgmJKMIGb66iaHSe1L7C3EF+
 fvAm+dHM2ex2wmqMMi3047ZjPl2z1F6yAvMZ/GkwPMiu1LXDLwuj1oefFgai7GInt9hbHb+XaVW
 QRDZQ
X-Gm-Gg: AYBFou2TsQADgYbf2jbQj0Scrl/RBmPX7cpS6lqzdzCndvC7paRVN7Lemw9Xtla5CJq
 en2U5+yaGMLOHpXeFyvTgWMMo02CoRAvHpP4OqZ1drqHnM+1iCqLxbT2RP1l7K206ITwWXUm3YD
 Img5WZRHaDQPmcWzDzHgNVJEgW1hts7L077wZByMdOFL2i1c2Q4GsAQ65ti0FbDEp33ZKIFzgBK
 5Q9DG94iN+W0xV0j1y6TplOOaqlf+SPi215H+C9YMxIWv1wYvisJjwcMTwKHg7QETwqFsCvXs9R
 w0EgSTe3m1mN/fXMeU0QlUcq3HuaNH5k/idZoUiW+x3aaQuxVxHsMw3hCXb5hbrRf/NjLzVZEtS
 zwkpsgC+0njM+jVTulE6EPAv3xR7I5qurkQ3Ur1lbdSoEC2ksgX6YvaZDryD4PLpuqoeNqY39/M
 4nEy+YVMyqKbR4cKr9yDcyaTtp6n0TA/jsDX0fk2pHTFlHtpwlQeqomfncESR27tZKOLbJ1PZCy
 os1clg=
X-Received: by 2002:a17:90b:39af:b0:398:bf7e:b267 with SMTP id
 98e67ed59e1d1-39d9bc0cdcfmr19114875a91.2.1789267354297; 
 Sat, 12 Sep 2026 19:42:34 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 48/86] tcg: Generic expansion of tcg_gen_clz_*
Date: Sat, 12 Sep 2026 16:37:59 -1000
Message-ID: <20260913023837.741866-49-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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
 tcg/tcg-op.c                 | 54 +++++++++++++++++-------------------
 3 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index b674d4c3c65..755e89d7715 100644
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
index 26583254111..202df7a62a8 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -7,6 +7,7 @@ DEF3(andi, TCGV, TCGV, TINT)
 DEF3(andc, TCGV, TCGV, TCGV)
 DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
+DEF3(clz, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index fae6cd7450d..fabec509aa9 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -496,6 +496,31 @@ static void gen_brcondi(TCGType type, TCGCond cond, TCGTemp *src1,
     gen_brcond(type, cond, src1, tcg_constant_internal(type, src2), l);
 }
 
+static void gen_clz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_clz, type, 0)) {
+        gen_op_ttt(INDEX_op_clz, type, dst, src1, src2);
+    } else if (type == TCG_TYPE_I64) {
+        gen_helper_clz_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src1),
+                           temp_tcgv_i64(src2));
+    } else if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
+        TCGTemp *t1 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+        TCGTemp *t2 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+
+        gen_extu_i32_i64(t1, src1);
+        gen_extu_i32_i64(t2, src2);
+        gen_addi(TCG_TYPE_I64, t2, t2, 32);
+        gen_op_ttt(INDEX_op_clz, TCG_TYPE_I64, t1, t1, t2);
+        gen_extrl_i64_i32(dst, t1);
+        tcg_temp_free_internal(t1);
+        tcg_temp_free_internal(t2);
+        gen_subi(TCG_TYPE_I32, dst, dst, 32);
+    } else {
+        gen_helper_clz_i32(temp_tcgv_i32(dst), temp_tcgv_i32(src1),
+                           temp_tcgv_i32(src2));
+    }
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -828,26 +853,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
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
@@ -1769,15 +1774,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
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


