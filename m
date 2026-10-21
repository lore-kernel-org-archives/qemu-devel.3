Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBA1606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nJ3LoNh/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXFT-0003c9-BG; Wed, 21 Oct 2026 10:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDX-0001nf-F9
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:23:00 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXDV-0002E9-9s
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:22:58 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so546846f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592576; x=1793197376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NULzljXP15UwXy368du4Fk13NGNOwysZX5x33gId9bc=;
 b=nJ3LoNh/NolNxpC4vnu4NR6nrlLGPC1kAzJHlDlmI0usVnOn9BaUpfOsY4n/8LKUSP
 Uko7e7vd+HRInAtHP081IAxh0qRmPJPVig+Hcg5EBrusMEgNsBkkMWey5T24CiObHYIv
 0WhttRynJLgbshF4OoGektGoYhbumUTtvFoBN81nkTL3/UrWCPwzgPyW/C+dXTIA0wxz
 fxij+bgnrJ4Z9pzPLwNQAOj/k6XdiPQhEYpEmAd5GeDFupGr/HIsNxOkT1sZ/ZDPyZPI
 luC6CosOtByWs4vXRbYT0xNLPEh8H6ZHYjyFc7c9F2f9OcJ31W/h7fNAtXnxJ9A/bbZf
 lc1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592576; x=1793197376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NULzljXP15UwXy368du4Fk13NGNOwysZX5x33gId9bc=;
 b=BPot+/LQ6X8jpSjYuAUHVXD1D3nSp2+usFivJfY2uFJHQtZaSA4HkxCg0xWEcCytdv
 BI2Xrm22iXuCGD0uusbLkPZyC3iwEktz9gu18tDQsN81k8yKxiQKfB0yn9WnsQdTdxxZ
 5TwtGXCGniNSiCJqeQ1QJAbsufgk4Dmm6kzye/sa7klbPKoq83NB42UKldGOqE/rAl19
 635s413WnNn/lp9ageC0hhG8ik3Yz+A1stXvrEVx38wzuHDwVPP5yab5+ZoE+pAXNz/5
 wxxX/5KyslN5MndfVbvqeyqralX/yIPgp6seHdEvfM5eOqFZ0sRNZi3BW159+LroWmU3
 rMSw==
X-Gm-Message-State: AFq9FYKjukEDAHz9v85On2HrMoZQBk8NJNIuqTF90QLfw/KZeDHEgyEp
 hvLFKVvZq60LqI1C6hj0c4kwa+OOnuWu7aHR19ZxvEbjHjuu/YwjaJPbUpm5DuJR9X2BYKlaxKC
 tWYN/o1U=
X-Gm-Gg: AYBFou14AL6vKAq68dRxjbhpu8XEbeMxe217wcRsnFnXeMa1LA/8IOuitgyk3dkMf78
 bxFg1WlYyxPislnjg/cj/k6zNsZgsmP/ugR0f5qT0H9PvAF5iOvJSdEv6VkzfSYybbLp/YvTlow
 ZfMRJXC5D//ns581E1irj435GKvBlX0p0v6iPQ9CiK3Udp9cOvDlw+qE1ZXS6KulxUzI7yFXsWe
 HskSZUNmO7fFTNOQhaaPlRINH4fgVxFGyV3fN5EyumojGZ7BDXYyOJQvYJZNqkay62lEPWSRE1b
 WnmUDjo+5VhjE+q7Ua10nCEuwUr2ZznsANyP9gr6hKiB8dA1zjB47RjA82/pIqiCFtkvOABOCtO
 o87w+3cqpQjHUKOeOvBTgPl+SWs7ypumRwDGrYw/EpR9dwTFVz18CZNmXGYpL/DjfoVl2R78cK8
 HjijJQOA+arZ4fvNzeKN+u2kqr8yKWcjXssA0v2H6WGhNov5AVpoAcYCG/v+SIuj9Em4Hw4v5co
 GQovBagp8FLzKgrevyqDwpYtWOCWJgZKFLodpNiBT5JV7ykwcdT6wUuZaaftnsmdQkKOjAnb9Ap
 bYQAPDCYfibnRT6wGewP46oOIUjDk3ZZ4/wI/Juht2aXDu2q
X-Received: by 2002:a5d:584e:0:b0:48e:f07:160e with SMTP id
 ffacd0b85a97d-48e264f32edmr4596658f8f.38.1792592575662; 
 Wed, 21 Oct 2026 07:22:55 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm5393603f8f.26.2026.10.21.07.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:22:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v6 077/100] tcg: Generic expansion of tcg_gen_extract2_*
Date: Wed, 21 Oct 2026 16:16:29 +0200
Message-ID: <20261021141652.363109-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x433.google.com
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
 include/tcg/tcg-op-common.h  |  4 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 69 +++++++++---------------------------
 3 files changed, 18 insertions(+), 56 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 6942012787..c1c41a03f3 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,8 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
-                          unsigned int ofs);
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
@@ -164,8 +162,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
-                          unsigned int ofs);
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 82dfc90009..a237ccd0c5 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -26,6 +26,7 @@ DEF2(ext8u, TCGV, TCGV)
 DEF2(ext16s, TCGV, TCGV)
 DEF2(ext16u, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
+DEF4(extract2, TCGV, TCGV, TCGV, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index f6cc56661d..712536cfc2 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -183,20 +183,6 @@ static void DNI tcg_gen_op4_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                 tcgv_i64_arg(a3), tcgv_i64_arg(a4));
 }
 
-static void DNI tcg_gen_op4i_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                 TCGv_i32 a3, TCGArg a4)
-{
-    tcg_gen_op4(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), a4);
-}
-
-static void DNI tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                 TCGv_i64 a3, TCGArg a4)
-{
-    tcg_gen_op4(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), a4);
-}
-
 /* Generic ops.  */
 
 void gen_set_label(TCGLabel *l)
@@ -691,6 +677,23 @@ void tcg_gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
     }
 }
 
+void tcg_gen_extract2(TCGType type, TCGTemp *dst, TCGTemp *lo, TCGTemp *hi,
+                      unsigned int ofs)
+{
+    unsigned width = tcg_type_bits(type);
+
+    tcg_debug_assert(ofs <= width);
+    if (ofs == 0) {
+        tcg_gen_mov(type, dst, lo);
+    } else if (ofs == width) {
+        tcg_gen_mov(type, dst, hi);
+    } else if (lo == hi) {
+        tcg_gen_rotri(type, dst, lo, ofs);
+    } else {
+        tcg_gen_op_ttti(INDEX_op_extract2, type, dst, lo, hi, ofs);
+    }
+}
+
 void tcg_gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -1119,25 +1122,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-/*
- * Extract 32-bits from a 64-bit input, ah:al, starting from ofs.
- * Unlike tcg_gen_extract_i32 above, len is fixed at 32.
- */
-void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
-                          unsigned int ofs)
-{
-    tcg_debug_assert(ofs <= 32);
-    if (ofs == 0) {
-        tcg_gen_mov_i32(ret, al);
-    } else if (ofs == 32) {
-        tcg_gen_mov_i32(ret, ah);
-    } else if (al == ah) {
-        tcg_gen_rotri_i32(ret, al, ofs);
-    } else {
-        tcg_gen_op4i_i32(INDEX_op_extract2, ret, al, ah, ofs);
-    }
-}
-
 void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
@@ -1674,25 +1658,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-/*
- * Extract 64 bits from a 128-bit input, ah:al, starting from ofs.
- * Unlike tcg_gen_extract_i64 above, len is fixed at 64.
- */
-void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
-                          unsigned int ofs)
-{
-    tcg_debug_assert(ofs <= 64);
-    if (ofs == 0) {
-        tcg_gen_mov_i64(ret, al);
-    } else if (ofs == 64) {
-        tcg_gen_mov_i64(ret, ah);
-    } else if (al == ah) {
-        tcg_gen_rotri_i64(ret, al, ofs);
-    } else {
-        tcg_gen_op4i_i64(INDEX_op_extract2, ret, al, ah, ofs);
-    }
-}
-
 void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
 {
-- 
2.53.0


