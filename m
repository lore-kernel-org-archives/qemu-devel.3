Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FEA606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=XwR24MtA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJXHw-0007CO-Sq; Wed, 21 Oct 2026 10:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGa-0006Js-TT
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:09 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xJXGZ-0002XY-4W
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 10:26:08 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c247f6687dcso121084566b.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 07:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792592765; x=1793197565; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RM3eBoqE0m9deKU0SsB2FvLoCOn7K80Zk8hpexdfP2A=;
 b=XwR24MtAHmPhP1pun8kR8wVRS+nYuIgLC/oypecmdmae3ZCAiqnE5QX/fJPBw6pytg
 TH2ZWytv/FJSPkrxAeqikrHA6kRGhQ8wY+nRPWScRK5IaxHMSxufxLklAM5VxfelTZE4
 qgOuxFt4D4zvufogR/lhO1oFIF0Bcu5+DmxXwu7o21jqfhgoP8PVF0F7PsJBros7Pykv
 csddKApYS7yf77ugRMqn4dOLn7qqKRTWbVyIC73U3UBDGnYXbFApES4vDF+jG2GBMfNC
 KyuIGp74snD2Ddls/scILrtiTP+TKTIUMQc+sN4Ollg2jmATZ6mH2ZGV640GEAyZ764H
 64tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792592765; x=1793197565;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RM3eBoqE0m9deKU0SsB2FvLoCOn7K80Zk8hpexdfP2A=;
 b=FkxoVz5ab5pMcAdyLk1wvT10d44XXYhfIQsGGUJ9QhtczXBu2W1KCvFxtCOrcrFoeK
 DSElIGqQ2ZifSHXOq6C5+VPXfNCBn/zzEBLWQTQLKBOaMWP/AEuGoFvynnzF9+K9hNLz
 NWbtIPMVsJX2aeO61TUGH8VVzjbiwj0SwSJZOsd6vNf/Cy97kpfVTCkn1oWuSWWUOC9+
 2PxYvvVu5RhN0HUjFIUZUMRFygyU0pUNDUr30qi4XxJuAVssMRR8UbVbQYCGlOzZoaXC
 DnZih+uwIODJtrgGtJPRZbSi75wd+lzQk/fAfj2JUChjha3TwArKdjvnnujxkUdOaDED
 /j8w==
X-Gm-Message-State: AFq9FYJlWRfPvB1Z/1etIJJANv6NRjR9VsdX9UMjiWInJMAbLkLZmyti
 S5cLe0EJWRD/FHDA2FZCV1zHPe8Kz5cicwC0HBmIEPMbWqMbdrfYsCVrpOuKSkMQdVFaL/f4kvs
 CH6w84+M=
X-Gm-Gg: AYBFou3asoxLs645c5g/sPw1mp8E2CXO/34OsLW9snkf3OkE3Xgk7TI10HDgrKKoA9u
 j/7T1+OS9RfeHA20vAVq/GkbyySxwuxGohCK0TThh45jl2TFpnQ4wLnoEdeNdIBy3Qa5PcQIBmw
 kxgF1ojS3pu494P1AhmZQQBjIGHaM2CU+7PkIbcWqRd0b59fCFmbzVsQle8MZLeCDzrl1s0tU+T
 MV0rqECoHkg8kEavFh5Dv+XX03xAUssuuDimpePdJg9hgWZVSc8NwyU5NA17NX8Z4peXO5fwWKB
 lyoHqISDvuIGjYB8ram5LbFTsBJY+3fhb0PnWJz68o1T3JypqnqRcFolLGtjNomJM1XCz7K8tNF
 h0tthLTSXdejsb5Css6daBqhKrBJ4iik6Y/+rQQ+SuZOPqd1QXGqCS/7d4OcenKTU63nItD9RYa
 8pRm+KHWS66ZQHrYRcIDDkoWYQmrSGzIzN271Z2Dj02sU5qkcBnJ+VD3y33wel5PNvK+w8Xi9GF
 zZlmFeqHaJjogi0xAlhgWr0v6fVFNrf/+P+4spyNziet0X7GS/L4MowXE8YZow8hzd+2pwxpmm1
 kPgqDl9KmoFbs5yFZ6vp5NM5pY04dtssg6j3sTJq4YdRuoGH
X-Received: by 2002:a17:906:100b:20b0:c46:8063:220c with SMTP id
 a640c23a62f3a-c4680632a9emr102929666b.11.1792592765405; 
 Wed, 21 Oct 2026 07:26:05 -0700 (PDT)
Received: from stoup.fritz.box (pd95f64ec.dip0.t-ipconnect.de.
 [217.95.100.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828cd1sm5710878f8f.22.2026.10.21.07.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 07:26:04 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v6 085/100] tcg: Split out gen_bitswap
Date: Wed, 21 Oct 2026 16:16:37 +0200
Message-ID: <20261021141652.363109-86-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021141652.363109-1-richard.henderson@linaro.org>
References: <20261021141652.363109-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62d.google.com
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

We'll need this for other generic expansions.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 58 ++++++++++++++++++++++------------------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index f1a79dc921..2d24e21f3c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -290,6 +290,27 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF5
 #undef DEF6
 
+/*
+ * Internal helper for bit and byte reversal.
+ * Given a repeating matched block of 1's and 0's, swap the bits within
+ * those two blocks.  E.g.  mask=00ff00ff, shift the input bits left and
+ * right 8 bits.
+ */
+static void tcg_gen_bitswap(TCGType type, TCGTemp *dst,
+                            TCGTemp *src, uint64_t mask)
+{
+    g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
+    g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+    TCGTemp *tmask = tcg_constant_internal(type, mask);
+    TCGTemp *tshift = tcg_constant_internal(type, cto64(mask));
+
+    tcg_gen_and(type, t0, src, tmask);
+    tcg_gen_shr(type, t1, src, tshift);
+    tcg_gen_shl(type, t0, t0, tshift);
+    tcg_gen_and(type, t1, t1, tmask);
+    tcg_gen_or(type, dst, t0, t1);
+}
+
 /*
  * Generic expansions for templated operations.
  * We have used compiler type checks to ensure all TCGTemp
@@ -1289,43 +1310,14 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
     tcg_temp_free_i64(t1);
 }
 
-/*
- * Internal helper for bit and byte reversal.
- * Given a repeating matched block of 1's and 0's, swap the bits within
- * those two blocks.  E.g.  mask=00ff00ff, shift the input bits left and
- * right 8 bits.
- */
-static void gen_bitswap_i32(TCGv_i32 ret, TCGv_i32 arg, uint32_t mask)
+static void gen_bitswap_i32(TCGv_i32 dst, TCGv_i32 src, uint32_t mask)
 {
-    TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-    TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-    int sh = cto32(mask);
-
-    tcg_gen_andi_i32(t0, arg, mask);
-    tcg_gen_shri_i32(t1, arg, sh);
-    tcg_gen_shli_i32(t0, t0, sh);
-    tcg_gen_andi_i32(t1, t1, mask);
-    tcg_gen_or_i32(ret, t0, t1);
-
-    tcg_temp_free_i32(t0);
-    tcg_temp_free_i32(t1);
+    tcg_gen_bitswap(TCG_TYPE_I32, tcgv_i32_temp(dst), tcgv_i32_temp(src), mask);
 }
 
-/* Similarly for 64-bit operands. */
-static void gen_bitswap_i64(TCGv_i64 ret, TCGv_i64 arg, uint64_t mask)
+static void gen_bitswap_i64(TCGv_i64 dst, TCGv_i64 src, uint64_t mask)
 {
-    TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-    TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-    int sh = cto64(mask);
-
-    tcg_gen_andi_i64(t0, arg, mask);
-    tcg_gen_shri_i64(t1, arg, sh);
-    tcg_gen_shli_i64(t0, t0, sh);
-    tcg_gen_andi_i64(t1, t1, mask);
-    tcg_gen_or_i64(ret, t0, t1);
-
-    tcg_temp_free_i64(t0);
-    tcg_temp_free_i64(t1);
+    tcg_gen_bitswap(TCG_TYPE_I64, tcgv_i64_temp(dst), tcgv_i64_temp(src), mask);
 }
 
 /*
-- 
2.53.0


