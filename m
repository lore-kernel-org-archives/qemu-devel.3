Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B43C606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=vi370DGH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsem-0003Uq-RG; Sun, 25 Oct 2026 03:28:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKscy-0008OE-Na
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:26:54 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKscx-0004am-6O
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:26:48 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so14075245e9.2
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913206; x=1793518006; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=J2OOytdLxjcBr2KE2PVj8H+OEqtzVt09d96YCgCDvHo=;
 b=vi370DGHUDhZVwiB/VxNP5znWU/bze6pLwVHW9/Vzk0CvOu5oLHACv1S/jwTJFrGnD
 QlPvEZNebNiWh39sGyDwqT+U/GvAfJ8CnDTwJmr1GhNmC+uRE1Q+mhrMtFWkgI8OBmOx
 ewv/DWKzBzV58qurQfX6AYgUYdg74EvPw521mDJqkrxfNM0jF2kRoJM+WQ182I8AeXPq
 4uhGulfly2NC5I34evvkae18w/sPsSIZqrSnGvefFN32Fbzz6Zvtp7UBrWWV63RZFyLA
 iHt33imLjJNsHJzqzemaIXYKDdf9YuUb1sjgZgXkuYxsUt873FNu7ED3pzQxaQt4rzoh
 D27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913206; x=1793518006;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=J2OOytdLxjcBr2KE2PVj8H+OEqtzVt09d96YCgCDvHo=;
 b=lVRlZDKdNdMWqaaOF5xit2Z+FV13F2S4ZGeDjagvMXGX1R3JHAXpNaXahKlq/Sxn9p
 OW1yBsXlKYvPo+F+ePvHTazuTNcgr7p+RRbzpH1Sl4uRzkhU0ewy++BBL7cFGV89lpuD
 O9qjLNG+EScvWt2XnmKpjhfWXO6GjdO1o3m8o/cfhnMjZSjMrrrzA/XyNk62GBJxNRzn
 Yad0RWvN8Z7i8Ez/BGFmlbCshzER+8Q1pZtBakPYB4vOf9SpOfPYdzsk/JUaRe7IT1P4
 Z08rUjcA+bUivHsLUwFfXUxYNqVwpkYzB4vOlSFTZaODuwDvrPsFrm0gVuK76Zs6cBKV
 aHxg==
X-Gm-Message-State: AFq9FYJVIcK96SAn62xYD+b7bgOGtg7KxMWrQkA2fBznZ3f7j1bui47V
 P7FBigl+t0VVHA1zQUPir8G+YBaIWBlHxrmmIImFZ3zd10GmBlOdVYqY7yt7lUt7Y74VRndsQDh
 PLFBcC6s=
X-Gm-Gg: AYBFou04KCqmViorG3f/yD4hSFk+JAnsULwiIKusw2QghgpugxbdA+KF6/3+CtwRy7x
 PMosq33/W3LSvd7rEnWI3jGBNYJg0isuZYqHlmOOkD6wHygAe53AwAAvyo+fxN4bmtqJRFV5CeS
 deT899ZnUVbso0+UzMfUqG7cf8/PR1cloCpFp/qHWWdNPGFSSaieLVAwgE32OXCJeFjxZrJison
 I7zL+nE3kL1AAb3ZrrYJahJV6DFa53VJ78rq3Ux/1Etieyw3RgHoXa+ml0X8Zo2Buq/rfqgd0Se
 9Ni5ksxTrSlMGKiM+bBeXX1nKfPUfubUiOjO7U9pK7ywoBcQqAACHlwEpwRfyM7A78ZYAl2kGDE
 pgU03SCZEO+7OYdQSi3mfRGsiiU7h86CShBLhl6/43WjH5P0bpyhGrr1wwiz8ONFp1Qo+J2bblt
 Vin6xZhJf8IvFIchJHz3HVWX0DWkL9cu1dQ0sgiwmvkGpeUHZNT3sf2uGp3cjGsMbdQCHf6qiXS
 8xr7FuV4eHigRPDnBH4gNSqHFjBGyr69Er2IcjE9Xsf3cL/IDt0ewKvWUQ=
X-Received: by 2002:a05:600c:6098:b0:4a2:fe11:9a8a with SMTP id
 5b1f17b1804b1-4a35aae5dccmr60784165e9.0.1792913205629; 
 Sun, 25 Oct 2026 00:26:45 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fc1207sm82923745e9.1.2026.10.25.00.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:26:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 085/100] tcg: Split out tcg_gen_bitswap
Date: Sun, 25 Oct 2026 08:19:00 +0100
Message-ID: <20261025071915.1123867-86-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
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

Reviewed-by: Matt Turner <mattst88@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 58 ++++++++++++++++++++++------------------------------
 1 file changed, 25 insertions(+), 33 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b0be44d499..0d33313517 100644
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
@@ -1290,43 +1311,14 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
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


