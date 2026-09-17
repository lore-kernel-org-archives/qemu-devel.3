Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A61BC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:34:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73nu-00033M-Ob; Thu, 17 Sep 2026 00:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nl-00021K-QK
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:49 -0400
Received: from mail-pj2-x0f.google.com ([2607:f8b0:4864:39::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nk-0007Kk-2n
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:49 -0400
Received: by mail-pj2-x0f.google.com with SMTP id
 d9443c01a7336-2d747ec6188so2620755ad.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619567; x=1790224367; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sEpP883SAwSpdOpHf+0TMGgQuFwS/hfn5Cjwssca0Qo=;
 b=virpPNMXvNHLzxpxh7MK4rO9flpSd/L5XJd2WcHXDC0ompYgxif99QaZCSI9x4i//Q
 FbC2qW28mQStTgLfZj78PcFzZNLDNraQUxc70J1q93twz6zr5VU/tNVu7UIaYEq2zWHz
 bMDSFhkgGbDseLWfGShbrESiWYpbkLiTOXffFACAhQnA9fONAsLH02tq+aGXSDHbFlsA
 BiatwADzv3RBHGQod24npdmN5vf8RdoEsXhZVDIDWLCdVWkFJnhql55RNY6K5ZOnlJv9
 0fZ3tIEElB9svlZivgkex9waiGWGEps6d8BRlH0pxholDtCMtZnjyuie5JBKiGLgc8We
 AIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619567; x=1790224367;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sEpP883SAwSpdOpHf+0TMGgQuFwS/hfn5Cjwssca0Qo=;
 b=pQz2TxLGJbom1bLwpA/jaf202/3YWsHXaSjsaKm8DCJcaXTgv+q2BsHQyPmKGqAprP
 XFlqxC0FQLamoy/7nMeagSuYn//puxvgZZzUD+b0JeVYC9Wiv8U+9EVPcC9KeC72xj4a
 1S8qEdTMtTPi58DeNIc/mQI99d8txnI8nW3dvwEAdCcZWHZb3p1OP1668CUj8nnmw+rD
 u9SBxRHw5dcf52aBxaRRYCYhzoONF9gIsEvqawz091e4l4Q/DlMAc22xTdwLe9RN7ykR
 NsYSJDa4vfZ0zg/+LVz4W3x87bUrtaWcYS8uGkxLqx4EdpVR1Y3FixppoiW0ubSBJ8ax
 5wxw==
X-Gm-Message-State: AFuF++k/Zt6JGfAEnZvsdSYbAMVeRzuTqWFAhKS8I0TOg6kYZWKrkwHH
 5L7yuKhii757QPTq7Z+dnjpLcyqXuPR+hcUeSDWINhnJQRpN24EgnHOEOc72+2orqs2TKXXHX/C
 Lx0T/Ibo=
X-Gm-Gg: AYBFou1zramMWRZukr1d669oPmDh0R6kNSrJ0mV1rvNbqdVcjuSCOuH6J285qxG2d9y
 XcH0z73+qBUx3ghpWmu0iKczge12RtyUPFPyB6AYcTxkq1op5/w74Qp4CMGXeUkYOThgHcMLkbb
 HY7srJ64ghfWgosMb3LVtUY31FOfEdaPj/K9etla8zozTFpU7cRc283KTqSrfjmD0ILd7HULXcB
 hR537WfFTu9Rl7mjxVcwU9IjtpoJMr6GNoGRuOMXfJ5DpKh3bpD9SKGTPICnGLQwfh6t54UDP6k
 x4g9tRs9pTWnXcu75nMTXP6rTrdpSfs64CB3R6CGyeT7HIgeCWycBWqQ/n8GDw7jb7Y9etbaFLZ
 OJIWuc6DIdGZXdRxIQXYS0WFDYVztNggnPxxZptG3K3H1kLdUbtDO+jAqsKOj1OiF1QriyPz1L7
 uOG4ab2QqgI680GidJwz8rvGrZPVRzR/c4AUwm59e6SmPPc8hOS/Q2a5Moc7NLH4WgLRWlAd8/b
 alK0NRUwp1tB/I81A==
X-Received: by 2002:a17:90b:384c:b0:38e:9ef9:eb97 with SMTP id
 98e67ed59e1d1-39e1e48a0c5mr11157448a91.16.1789619566615; 
 Wed, 16 Sep 2026 21:32:46 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 077/101] tcg: Generic expansion of tcg_gen_umax_*
Date: Wed, 16 Sep 2026 18:27:59 -1000
Message-ID: <20260917042823.542588-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 tcg/tcg-op.c                 | 27 +++++++++------------------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index e9f7703b687..79a3e82c98f 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -186,7 +185,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
 void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 70f1fc48a26..1405dff32aa 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -59,6 +59,7 @@ DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
+DEF3(umax, TCGV, TCGV, TCGV)
 DEF3(umin, TCGV, TCGV, TCGV)
 DEF3(xor, TCGV, TCGV, TCGV)
 DEF3(xori, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index cd735bc429e..5ed6cfd8f89 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1155,6 +1155,15 @@ static void gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
     }
 }
 
+static void gen_umax(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_umax, type, 0)) {
+        gen_op_ttt(INDEX_op_umax, type, dst, src1, src2);
+    } else {
+        gen_movcond(type, TCG_COND_GTU, dst, src1, src2, src1, src2);
+    }
+}
+
 static void gen_umin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_umin, type, 0)) {
@@ -1461,15 +1470,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_umax, ret, a, b);
-    } else {
-        tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, b, a);
-    }
-}
-
 void tcg_gen_ussub_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
     TCGv_i32 t = tcg_temp_ebb_new_i32();
@@ -1974,15 +1974,6 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t2);
 }
 
-void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_umax, ret, a, b);
-    } else {
-        tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, b, a);
-    }
-}
-
 void tcg_gen_ussub_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 {
     TCGv_i64 t = tcg_temp_ebb_new_i64();
-- 
2.53.0


