Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB14606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=yQAj0med
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsc0-0007Sx-Jf; Sun, 25 Oct 2026 03:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZy-00079b-73
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:42 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZw-0004Ai-5w
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:41 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a59100fa83so962075e9.0
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913019; x=1793517819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8A6TnqtNIsYamoJGB5mV741uozf8MLwpYMfM2NyuSyA=;
 b=yQAj0medKQ3IpZmaw4wINSjZ02VeUDXOKd0pSWpiCgDTRraZcMlLGOmhnsLWNYtNnA
 l89GwvRkkakIrH3SjY9SBMP45dXR8sQ+n4/kaZbLlDQcWjnJ6U2TWMDKYYFvyKDKS4Cz
 oF4nCYWqcAoNee7U4yRdRIam5Ru8dTiVrs14hyMjgdBKCnR1Sgx+SnD3nNYR2RS3fva7
 YkzKcfbD9ExSCVxREaasrIsEHH5AuceFqObw/TH/1V1GvqDlG3m8COpPcOaBoBW3oQC3
 b6QyyGsDpMkcH9rJ0HZnKKcNludSQG8pOn5HtW6Cm7+wkOxDPrjBfBEH2O9IkOorgkUA
 +bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913019; x=1793517819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8A6TnqtNIsYamoJGB5mV741uozf8MLwpYMfM2NyuSyA=;
 b=I8xQ72Wwl+8Agwlz8+ZkI1Land7rSWLpnHiVAa2qshw0VQOuFy4do2vpRx637SodIe
 L0NfMUjSrYXYpN8Zunhg6/e+6Sh39TxCkpOzysoM4HO3Ub5aWSuCJWi08ZeuVPw7edyi
 Sp8AThdwExY2eVJx8s/uk9MgB3jbiM06g+c/DxhdPjHQ8w65neMCU8ZBsL0KXd9w/DCA
 +t13yNFBrbpijtI/tgU7I7KJUN/0fL8QP4iYBUyWSDGKIzZp+q3ec//4CTj321QwC3Wx
 US5XGmYqmVaB9puyULV/57JUKObj1YnX97QCnjnRDjqUxIOg5tUhm8VV441pPJg3JMSB
 EqTg==
X-Gm-Message-State: AFq9FYIQQN/ztQkj34hmwfnIQiZDH1WF35pF/HeE/WxquX1jAw7YPrZd
 WBTiVXpWjRtXnWUzW0oIE3/14O8WBmelWuG4dW0mb+Z5bafsnjnMaCXkbMUA7cORWJzhwF0e5Mh
 yO0Ufw3s=
X-Gm-Gg: AYBFou3IkqKmjjg6X0HORLs5JDhZOgBMl+qvj1x23R9fXEt9rnemVCWRN1uwsbmOsvd
 5/bXquKSJEwyEViujRD6GH+xkCCSdVTjjZLncnJ/BpXgpaTbrlhmyBmAIF5F5Zr/kBtia4JN+wN
 OujExGX7XlHbIfSMRET5O/HxbqxhaYy70S636FCWtdV5Vpd4Xx2S0Gve7Yn2cuL56oFz8xbO+s7
 rFZig69vI+IOvfyqf8HpGXiCrlPga2jSVAhFBfUUS1bCASL5NXPB2epSwVNt6d5Cq2WPhhga48X
 MfdtuD6opLzOsMgz5ogcqF58Asq+NWi/RFGdGm1GP2KZhMPHZ1T55rcKhlcWbKfvnnRd5dFnfX1
 JeMj7TLzs0+bi3LldEXLkKaokx3yBfXR60CinBqZY+w8EmsHNCj9ks2tUh7rHY7SmxJYfwhm+Gu
 margMmN/5CJSA6BxJDMvQUT4dPlPTw7KSYRVwJ0zshll+bslFCK6MG5BrIbSY/v3VZ+Oe8IwYeu
 2I5+TeQtif41EtaMWmlrbEmMgaPf6ZZsEb6sGnEB/cF3zmPZjRsADXG4do=
X-Received: by 2002:a05:600c:46cb:b0:4a5:1cf1:b7b8 with SMTP id
 5b1f17b1804b1-4a51cf1b81bmr17397075e9.28.1792913018583; 
 Sun, 25 Oct 2026 00:23:38 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 079/100] tcg: Generic expansion of tcg_gen_add2_*
Date: Sun, 25 Oct 2026 08:18:54 +0100
Message-ID: <20261025071915.1123867-80-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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
 include/tcg/tcg-op-common.h  |  4 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 64 +++++++++++-------------------------
 3 files changed, 20 insertions(+), 49 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 84fdadc63b..109cad57ea 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,8 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
-                      TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -160,8 +158,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
-                      TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 003384b65d..e9f0b971a2 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -4,6 +4,7 @@
 DEF2(abs, TCGV, TCGV)
 DEF3(add, TCGV, TCGV, TCGV)
 DEF3(addi, TCGV, TCGV, TINT)
+DEF6(add2, TCGV, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF5(addcio, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1f8c8d57e8..3de5f4ca0c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -345,6 +345,25 @@ void tcg_gen_addi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_add2(TCGType type, TCGTemp *rl, TCGTemp *rh, TCGTemp *al,
+                  TCGTemp *ah, TCGTemp *bl, TCGTemp *bh)
+{
+    g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
+
+    if (tcg_op_supported(INDEX_op_addci, type, 0)) {
+        tcg_gen_op_ttt(INDEX_op_addco, type, t0, al, bl);
+        tcg_gen_op_ttt(INDEX_op_addci, type, rh, ah, bh);
+    } else {
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+
+        tcg_gen_add(type, t0, al, bl);
+        tcg_gen_setcond(type, TCG_COND_LTU, t1, t0, al);
+        tcg_gen_add(type, rh, ah, bh);
+        tcg_gen_add(type, rh, rh, t1);
+    }
+    tcg_gen_mov(type, rl, t0);
+}
+
 void tcg_gen_addcio(TCGType type, TCGTemp *r, TCGTemp *co,
                     TCGTemp *a, TCGTemp *b, TCGTemp *ci)
 {
@@ -1146,28 +1165,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
-                      TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
-{
-    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_addco, t0, al, bl);
-        tcg_gen_op3_i32(INDEX_op_addci, rh, ah, bh);
-        tcg_gen_mov_i32(rl, t0);
-        tcg_temp_free_i32(t0);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        tcg_gen_add_i32(t0, al, bl);
-        tcg_gen_setcond_i32(TCG_COND_LTU, t1, t0, al);
-        tcg_gen_add_i32(rh, ah, bh);
-        tcg_gen_add_i32(rh, rh, t1);
-        tcg_gen_mov_i32(rl, t0);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
@@ -1655,29 +1652,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
-                      TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
-{
-    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_REG, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-
-        tcg_gen_op3_i64(INDEX_op_addco, t0, al, bl);
-        tcg_gen_op3_i64(INDEX_op_addci, rh, ah, bh);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_add_i64(t0, al, bl);
-        tcg_gen_setcond_i64(TCG_COND_LTU, t1, t0, al);
-        tcg_gen_add_i64(rh, ah, bh);
-        tcg_gen_add_i64(rh, rh, t1);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
 {
     tcg_debug_assert(n > 2);
-- 
2.53.0


