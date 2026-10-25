Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07915606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nTG809VT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsaZ-0000nf-Tx; Sun, 25 Oct 2026 03:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZn-0006f7-OZ
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:34 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZk-00048J-6D
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:30 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso21061815e9.3
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913007; x=1793517807; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h1nCdqAvZzxtpbsp9tdvHWQwSEACavzy5XVwsB7uNP0=;
 b=nTG809VT7I51FslMmhzGGnjxUzpevu/+Td60/55J/2xKcQMbfdxiVTtmq1ZeLUEWne
 4Gh5jA63TNnyfbCw3nlcRoyhotd4qJxQ65FTzBJl/l6OqkFKb7YXdxmQA0gk+laU5FtB
 cFURU6JlZxF3okbJTLxuiOcikzcI7q3PWGN+9rWyO9thETWwfMYyYWe6AbxSUR268zAx
 9SpVPZxkwY8F1qXc6GI7CFjs2Da0ZNnu24jAl5mly/Lwomiuq1yRdrjhBYpae4iu/FXL
 xZN8quxL0qu1q5Ll6iVSnw582oEv5mzohFyuVzSLu1/DN7anz9Oz0iYk2eUZBclJB9jc
 fs4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913007; x=1793517807;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h1nCdqAvZzxtpbsp9tdvHWQwSEACavzy5XVwsB7uNP0=;
 b=Fiy4sH1pw0rXkmMRfWMbDPFQfsORh8bHCU0zCv4yHOS8p7WZzlAq9p7KeKQx2BD3cH
 VEeK+HUbAPYjgk31hE+byiBa8oGdXVIlcj6AUg34AbV++o5uV9X1PHl/imBLjVXSJ1PQ
 GgiVnuxl8k3OAQL2gnuLUWySMTE1mSMJWORDHcr1baK39lRAa/2pqplgGsfAo4E3Gzge
 gvL12pfdRMeI8yrzgFxv7C/VbcWqm53RmOIznprD9Eq6ZKjk7OOweU1sd2SFCW3UmH2A
 W1xfxpuLrqH0Ysac3qul+RuRSDq/Az1c1HYG9Lo1PMReoNJ/H6XmkJO4Swz28W2sOjS/
 AhpQ==
X-Gm-Message-State: AFq9FYKN578mz7K2uFNEw/QDCnHuoi/NyJbwELmUOmMVFMKQr2oL6J/j
 mygxj4FDsVNgALXbYn+RiatWa9Kma6gGt9uSsQGaelcpSyrTr10dafrfk8Fzj2blTUn312cFZas
 aeKTcsD8=
X-Gm-Gg: AYBFou2izoIjE8WGQohv6kDkMVYHMOIJiJ22DQ6zzhiMuY/f4ZL55wdKU5iMfYSGhcf
 cw1myFfghaHSXNP1Ita/pdw4LwH2XZt3CMcFt87qA10ubq7OwnBqkqFcACzvQBiLGTaStvERHs7
 rvU9pWnC3xwAVOjn8cbAvtAzSDGG0FXpW/uOaeqRhmBh4JAoTxF1c6VFK9aHctApVN7zEkfclvZ
 4vZZZHfo6dYwM6OpW0xMhIVs8LaHRacbDsMR08yB1+nQoh++252a+Dbb+jtfLF2zHPRo+m/KnUr
 DIID9jYeZt+gpjDBW6VJhlTa9qD6c5W/NkIf5YXMiTDZr+zmGMWr8QrnTxXuP7FQVqS7AZ22HLT
 VDSwoT4APBB55mqIQ4SR/1i16h8Zqibi5X0519N8yCHrhiKKYvdHcrRyeCl8S5Do6B0+X4Ns1ZZ
 BuX8RkEifmmDfB8xD8qjzlqCxRT0n3IYy1LTlBExdQ20V+gDIUf1DSyDK8jBzheFdobBvq5RsUR
 YhUzOMmL+IPDkxgp1fxlTxEZ2TH0accj2MFfiUbnaVwPPBAL5Zw/heOd9I=
X-Received: by 2002:a05:600c:8519:b0:4a1:f377:5c68 with SMTP id
 5b1f17b1804b1-4a35acebd9bmr54594095e9.34.1792913006715; 
 Sun, 25 Oct 2026 00:23:26 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 066/100] tcg: Generic expansion of tcg_gen_ext8u_*
Date: Sun, 25 Oct 2026 08:18:41 +0100
Message-ID: <20261025071915.1123867-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x335.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index f2e69a21e1..798785bc7b 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -144,7 +144,6 @@ void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_ext8u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
@@ -188,7 +187,6 @@ void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ext8u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, MemOp opc);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index a5b2bdcb43..1cdcf3aeec 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -20,6 +20,7 @@ DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
 DEF2(ext8s, TCGV, TCGV)
+DEF2(ext8u, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 3c1e1fa958..120dbe11dd 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -604,6 +604,11 @@ void tcg_gen_ext8s(TCGType type, TCGTemp *dst, TCGTemp *src)
     tcg_gen_sextract(type, dst, src, 0, 8);
 }
 
+void tcg_gen_ext8u(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    tcg_gen_extract(type, dst, src, 0, 8);
+}
+
 void tcg_gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
                      unsigned int ofs, unsigned int len)
 {
@@ -1174,11 +1179,6 @@ void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg)
     tcg_gen_sextract_i32(ret, arg, 0, 16);
 }
 
-void tcg_gen_ext8u_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    tcg_gen_extract_i32(ret, arg, 0, 8);
-}
-
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     tcg_gen_extract_i32(ret, arg, 0, 16);
@@ -1480,11 +1480,6 @@ void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg)
     tcg_gen_sextract_i64(ret, arg, 0, 32);
 }
 
-void tcg_gen_ext8u_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    tcg_gen_extract_i64(ret, arg, 0, 8);
-}
-
 void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_extract_i64(ret, arg, 0, 16);
-- 
2.53.0


