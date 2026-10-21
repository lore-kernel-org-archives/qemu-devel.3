Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED020606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=w9nbPZ1z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXFr-0004aI-Jp; Wed, 21 Oct 2026 10:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDM-0001YK-GW
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:49 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXD8-00029I-7U
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:35 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a1f68a9855so5015185e9.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592553; x=1793197353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ubS7N8m0lg4t+3uMFowxtfRmxm5SxbXRlrBHYZwZ/Fg=;
 b=w9nbPZ1zlYL7k8u+ikzSNzDbMGD5KKPRnQOGoPx9Ob1WwDNuPcNqqx/zww99AMcw1P
 jWr5KAFamE7vK68+K5KsL8jsldbcelA7Wd3rQv4kJHaoOKmpq0rxcUvjFe7NLEiEd+7w
 6XuUjxXdHajUaCqAB0W/eIl7nJzrZMMfzmpv6cxeAkwwqMwVJBnQEUrexYX2a8ZeKbnN
 G1MV5o9sAJSVyh8rniMLJjuedFlfsvL1Rp8DA+xT3ouUdw9PClJ04A84k+k9iSOlLeHH
 WEuNta3v6By0bGS6YqRzWsjMenWT0+zULMWmRwKf+/JTnoVgz71iijrhPNztXzfiD77z
 dapw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592553; x=1793197353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ubS7N8m0lg4t+3uMFowxtfRmxm5SxbXRlrBHYZwZ/Fg=;
 b=DHNS81caZpg2Qz/iQBVtnf+lWWZLipTtaYgCUbEqWX0RpZLOxOjQoWHW55Eu272TLl
 WNJet2IUvDmUyiUFy1NnC8p+aBn7zUzx7bpnDYyY7hKw8MbbyWL0LXC8c60OP8eIvYOj
 D3uqF0UO0zvjOM/zwboLhauShjSzkF95qTikATWPuSm18xm6tv2frUpUz+HNtntEXUPB
 /NADAqM64oZwi8R0O/mkEQBu8g0PlfEpUqCdhZnoYjxFIlXYuoOPUgBmubhB2IiHV5U0
 GD+J/P94aeA6X5hgxHJnfSPUympIjSPaKG1+gB0DUyo9T2AfhASoGxhUKI5mNPVLKsID
 x/BA==
X-Gm-Message-State: AFq9FYJNUEGw9oPmbt+ijsz3ctGtpyNLqxl3iGZLxqPkJUPnzK5W7sHn
 5zEe7UID5gwWyMP1HESSWDn0Lv8nMQ0/I9khw/fGhRcexu/LtOEUsUAxpR7zWG8RWUXWGP2yuGT
 kJ3YHw20=
X-Gm-Gg: AYBFou0ZmEP3Aanvd/OPv5okIY9etwEeiKj5jZGqqEeHuwGUtqBCsrGCIH32ivzulaE
 /9IsNTVvvdx1s+wGz89zu8pSJnsjAF6pbzTop5s+eo6tBZ/xwCYPUcZDKLbpguTayPP07pKxes4
 TZ4ULEkdL/GSyPz7VcgPGySWTWmGDDTnIW8iqVPjthZD4LfeoE8ALFIoCzGCUKPavYe9sVo8BfU
 ykwAZ8dwMlR7vGH0IGJIHO9uT0CAmjLDtyGkGOR2vdAm6Mgl1Hz36ZDZP9UWYjhWQmtlXp+kAS7
 Bf8zkDXP4muWfBrobH+d+yclrBgEJLcE0TvpELr4g0LXRIwWnYNbnoEb9L357OYbcD88Kz2m0+D
 yaLn/iurI4UjtRmHh6aEbAtvoORqn5vIv2Yj633qVxFLY1gQ6yX+YTpRe6pVJVd4tKF7M1oqxJ9
 c7Rk4RkgzvOKt05Ifu9P9J+ujvw5H/ODg/EVO8433bEBnYuuun7m+BLHBki8Pfkdy5pHX1v5CqY
 7528lIcBNhtPbkOTenm/PLi4C9uNacdI/4NpKAFUUoxpawB2CC63M/eB0KDUNApyMtgmfXgOhcj
 9bgExJIxtPDxgoAQ6YzVKmai1jQ=
X-Received: by 2002:a05:600c:3488:b0:4a1:fa33:441a with SMTP id
 5b1f17b1804b1-4a1fd8a0560mr52554765e9.2.1792592552034; 
 Wed, 21 Oct 2026 07:22:32 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 053/100] tcg: Generic expansion of tcg_gen_ctpop_*
Date: Wed, 21 Oct 2026 16:16:05 +0200
Message-ID: <20261021141652.363109-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 41 +++++++++++++++---------------------
 3 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index d68362fd02..8c1b7a1968 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,7 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_ctpop_i32(TCGv_i32 a1, TCGv_i32 a2);
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -191,7 +190,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ctpop_i64(TCGv_i64 a1, TCGv_i64 a2);
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index cf832a6dc0..66977cada1 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -10,6 +10,7 @@ DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
 DEF3(clz, TCGV, TCGV, TCGV)
 DEF3(clzi, TCGV, TCGV, TINT)
+DEF2(ctpop, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index efbbe4d8a1..bad47af1c7 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -450,6 +450,23 @@ void tcg_gen_clzi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     tcg_gen_clz(type, dst, src1, tcg_constant_internal(type, src2));
 }
 
+void tcg_gen_ctpop(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    if (tcg_op_supported(INDEX_op_ctpop, type, 0)) {
+        tcg_gen_op_tt(INDEX_op_ctpop, type, dst, src);
+    } else if (type == TCG_TYPE_I64) {
+        gen_helper_ctpop_i64(temp_tcgv_i64(dst), temp_tcgv_i64(src));
+    } else if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(TCG_TYPE_I64);
+
+        tcg_gen_extu(tmp, src);
+        tcg_gen_op_tt(INDEX_op_ctpop, TCG_TYPE_I64, tmp, tmp);
+        tcg_gen_extrl(dst, tmp);
+    } else {
+        gen_helper_ctpop_i32(temp_tcgv_i32(dst), temp_tcgv_i32(src));
+    }
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -826,21 +843,6 @@ void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_ctpop_i32(TCGv_i32 ret, TCGv_i32 arg1)
-{
-    if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I32, 0)) {
-        tcg_gen_op2_i32(INDEX_op_ctpop, ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_extu_i32_i64(t, arg1);
-        tcg_gen_ctpop_i64(t, t);
-        tcg_gen_extrl_i64_i32(ret, t);
-        tcg_temp_free_i64(t);
-    } else {
-        gen_helper_ctpop_i32(ret, arg1);
-    }
-}
-
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
@@ -1731,15 +1733,6 @@ void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_ctpop_i64(TCGv_i64 ret, TCGv_i64 arg1)
-{
-    if (tcg_op_supported(INDEX_op_ctpop, TCG_TYPE_I64, 0)) {
-        tcg_gen_op2_i64(INDEX_op_ctpop, ret, arg1);
-    } else {
-        gen_helper_ctpop_i64(ret, arg1);
-    }
-}
-
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
-- 
2.53.0


