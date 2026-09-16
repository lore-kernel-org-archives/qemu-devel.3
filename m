Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A823C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pQq-0007ZE-NA; Wed, 16 Sep 2026 09:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pQk-0006vE-Gq
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:12:06 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pQi-00020H-K5
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:12:06 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccafb752so828139a91.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564323; x=1790169123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JeFPsFC0IJyY3nMCY5fPTu3OYcqzkGjCs3HXhg4edko=;
 b=EHIcWMDtVDIPEvxt6NOO6QGB2UL3Ch6BS8Kg9lLQl2KJ7EkYaE1/lOqmHnUOMxwgmj
 SV3bYCf0OFvqudHO6P7OF8kQucIQoHfnVy68g2YUPpeltYWI3/qnH982S0qmROVs3BCb
 0SCw1Kiikh90qNebCU+OL65P5rFOpt9xePxmbFZ2o+yxH23/MWLP+1uQI+MaM1CqHNF1
 Y0POaE2zJeeJprM97x1lGS6j2z8Jh5TfMFpTsXGFDGP/oZckX4kDoKKBtcy27EPDmkkl
 G8JAb7vHYdWq7Jd4qx6vT34wMrA9hb3O5aET24Nj25nSt/zssCMyq8cZ+7XlbVVqELLP
 la3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564323; x=1790169123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JeFPsFC0IJyY3nMCY5fPTu3OYcqzkGjCs3HXhg4edko=;
 b=ZGOKE4YDPmKpZGF+/zPF8n0wu0PnBOXLTo+HBAF6LcSDH9RQ1R8SG5Vln5Yz43ngwp
 YKddbccmXvX86rwwpwsJQ+6MHMhrcoiUH/JA/9CCpKN0o+COBfgdeSp9gL1/XSWJr30F
 Y2XD50jrLIX7Qht0MOciuaYhBnXAzmS1FcQeD8KOE1vpFI6NIiSSqxqJMjkGP90xp1lT
 fPzmvfbiMoCviswuBAc9Yun2FRI4+zTvxhRYyfZIL28e2ZA1pLT0o9h3CRH9c/Z2/mgx
 fcJvffJtueGGnCYzFrgvgoHNJN8fVV+SuhxAFL4HexqqU1587Wvk2ka3MULJumJe/Nk8
 stQw==
X-Gm-Message-State: AFuF++mxDfov84r3UqmG738zGqxxYIbSf7ZEYMIndWFIlgpoXjzACcd5
 m0NA7tlyh5JbPz2bMKK2wF1KIcUHY9Ng4Ufpnt7TyFhKXvd32J4C0CJ0eN1Sxs+Ehn7nkjYTU7D
 N5YkD
X-Gm-Gg: AYBFou3HPFZL8AD6MrsJ6TfURnPJWiKe2XjCvPFTrx73idI3RQ+dQMKU8tc0gX2DLtw
 oT2nz9Wod6L9XMa1IvWKDv2v2iOTEs4H6yugaoe26vwCGr78OQaSjitwyNoMbvvn+URFHoDpy3G
 RE5F7MFUFQsF3+PKPfzPDknGId5/INAy+EI1Bmyk7HCkcIYB28rH81nHiMD7o12kvAHul0jAzbG
 kwiHW5UCFHA3VW61eWrK8T67G+k69B7Qc3nXnoDSKIcC5rDu5RUFY/12tQkNCGNtCktAZIURbTT
 vdfc6usGc6kG6ygHMRZ7TwTcr9pPPHoynL3WXBZek0woQuDX+9EdavdW0YEzAObPJGkqzmO/B04
 AIF7qyf15AF/XkswUDUhZbDrykPx+gWthYzoscOrDYj6gNLAqO3yTO4ygQ5s5C49Ze3GFKerhmc
 cUog3cb6FPxP8gJh2gWSuZCrHcrLdZlfv9v1z3mBF+WRpRlXPLFnMp3N212WmVRcWleEN4iB0iX
 juZioHWjhhfbe6MSQ==
X-Received: by 2002:a17:90b:1811:b0:39d:e54c:8658 with SMTP id
 98e67ed59e1d1-39e1e250230mr6331535a91.5.1789564322876; 
 Wed, 16 Sep 2026 06:12:02 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5b22b74sm7873110eec.30.2026.09.16.06.12.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:12:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 87/92] tcg: Split out gen_bitswap
Date: Wed, 16 Sep 2026 03:04:02 -1000
Message-ID: <20260916130409.3382710-88-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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

We'll need this for other generic expansions.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 61 ++++++++++++++++++++++++----------------------------
 1 file changed, 28 insertions(+), 33 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 45e158973d7..c77d25cfa75 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -382,6 +382,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo)
 #undef DEF5
 #undef DEF6
 
+static void gen_bitswap(TCGType, TCGTemp *dst, TCGTemp *src, uint64_t mask);
 static void gen_extrh_i64_i32(TCGTemp *dst, TCGTemp *src);
 static void gen_extrl_i64_i32(TCGTemp *dst, TCGTemp *src);
 static void gen_ext_i32_i64(TCGTemp *dst, TCGTemp *src);
@@ -513,6 +514,29 @@ static void gen_andc(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+/*
+ * Internal helper for bit and byte reversal.
+ * Given a repeating matched block of 1's and 0's, swap the bits within
+ * those two blocks.  E.g.  mask=00ff00ff, shift the input bits left and
+ * right 8 bits.
+ */
+static void gen_bitswap(TCGType type, TCGTemp *dst, TCGTemp *src, uint64_t mask)
+{
+    TCGTemp *t0 = tcg_temp_new_internal(type, TEMP_EBB);
+    TCGTemp *t1 = tcg_temp_new_internal(type, TEMP_EBB);
+    TCGTemp *tmask = tcg_constant_internal(type, mask);
+    TCGTemp *tshift = tcg_constant_internal(type, cto64(mask));
+
+    gen_and(type, t0, src, tmask);
+    gen_shr(type, t1, src, tshift);
+    gen_shl(type, t0, t0, tshift);
+    gen_and(type, t1, t1, tmask);
+    gen_or(type, dst, t0, t1);
+
+    tcg_temp_free_internal(t0);
+    tcg_temp_free_internal(t1);
+}
+
 static void gen_brcond(TCGType type, TCGCond cond, TCGTemp *src1,
                        TCGTemp *src2, TCGLabel *l)
 {
@@ -1450,43 +1474,14 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
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
+    gen_bitswap(TCG_TYPE_I32, tcgv_i32_temp(dst), tcgv_i32_temp(src), mask);
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
+    gen_bitswap(TCG_TYPE_I64, tcgv_i64_temp(dst), tcgv_i64_temp(src), mask);
 }
 
 /*
-- 
2.53.0


