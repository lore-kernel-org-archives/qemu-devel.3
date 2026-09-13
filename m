Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3DDCC88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aEZ-0001OB-Dv; Sat, 12 Sep 2026 22:46:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aEQ-00014I-FL
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:46:14 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aEO-0002o8-Ll
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:46:14 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 d9443c01a7336-2d747eb79fbso5369065ad.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267571; x=1789872371; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=f536FhSaiAJO84pwnmXXXBKHZ0a9dcosugr/BSLxdIY=;
 b=HfujwryIvKnk7cW01vDbLpxMW84eoLs4aH534RCtei87heY/j51JgeU+glOda4Mx7O
 ggzLP3hw7UjVnoBatCbkI6LiEkoWyDbd4T4Br5vjOkYeY3vINQQAQMwJ06W4cVVIZMqe
 2EfecG++uwJu04F1jNcvnKfseJBewvq4k1Xch0dJEPEIggQb1f34eXM/aiFfgUsHCbFT
 5U6SN160c27xPKCuf3V7j4JgBvHgeglLCo+quVv8RDnLAmf7qwuGh05eHKUKIPz8MIZ8
 4g2UB79mmGA6m7SnUr1t192zxw/kjcNDX+M7tIiS3mC74V7+HGxkIAS7FFn6WGygs3Mb
 aBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267571; x=1789872371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=f536FhSaiAJO84pwnmXXXBKHZ0a9dcosugr/BSLxdIY=;
 b=KHlkvLXGUEhERnXMLPVq9CHffvx82UK6VVhfBYi/7dvS4fwFAOyakw+F2prfP57vef
 21KGb73gR4QocmlHajIpkqs2/be2VmTD5Mk2cs9Rax0qMBl/o79k8pwCd60d7uNr+rRi
 dQhCqMD5UX4r7AqqGl96BmUNTqWYINnXbasCmcW0QDpcfYJ6D+pVYz/JGrD63t5+KWiI
 9ypE+8mOYe0TthPtNZFL9rP5KUQ+qe2chrUPIo8vuXpp+irQOcybamo3dcs86b5rY40G
 sZWr9XD/fHR7MUJSamr9iSjwgydFAArn5AAb++Fnuv7jlJpWwVaCqCukZRkIS/Eqp+BC
 bMpw==
X-Gm-Message-State: AFuF++n2pw8FbIV2q0dMvhwRXWk5dF9Q2qCzNUqVUTma/6E8AzJiFhXM
 NkVQ5nXoChu+/xvj5BQCVsLNayDNa6aK46g7CgUBm+5Ej2r/RdpZuSdiU3V7DCtSsPc98wQr/rP
 kt8SVCEI=
X-Gm-Gg: AYBFou0PFGEUF/P9Okhtfv/Hy/K6Td0fyALwnwXoYLLnf9XyVSbAZ4AQ71pilddRCzd
 LLEHUbI3tZiBj1I3iWDT77ees1SoyvYPygoZ3Hxl+KNh1i0Win1/+ZwP8CkHKgH73NW7YKf3lGy
 ijH84VO4AcSFo860IPpYwKmr7MV2hd3q4EEpK5HpfBhz3/bfv1Ut+yon43HrLePLPDpA5HAALLa
 Nc8aWfvt0u+39RfHdYOaxe9duZP+jQ/nb49DCn45JxVabwom5OdpkBy1Lxw1dS1Bv5Ehr7t14bG
 apTnGFcQv+H34rluvSiVDIq1qf22+UnwtASj93y4k6o34ugcO9/g+ewxQRRVBqFdPeiY27b8DyO
 e7ybg0Su10ZVORdDkC1xqXyIGoH5/xDjRAdrSw4RlDlXpngqaBh/ai6O+QRL45If0r1b8SRLg2C
 TaoMUdH3KSP/VQEKz1Git6yGuqxc6XwMtWJrd8hM9lHT90rDrxRi7REwPjnAXf41gSQ/hyooSR2
 4Jn4wPpo5rL1zKUvg==
X-Received: by 2002:a17:902:f60e:b0:2d9:33d4:a910 with SMTP id
 d9443c01a7336-2dd2a1d526amr228889085ad.4.1789267571222; 
 Sat, 12 Sep 2026 19:46:11 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba7a9bb56sm17811679eec.31.2026.09.12.19.46.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:46:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 84/86] tcg: Split out gen_bitswap
Date: Sat, 12 Sep 2026 16:38:35 -1000
Message-ID: <20260913023837.741866-85-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
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
index c1b696c8193..1882c0b5f3c 100644
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


