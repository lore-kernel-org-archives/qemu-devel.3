Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55691606A31A
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Oct 2026 07:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=QbuVDbMP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKsad-0001Gg-GO; Sun, 25 Oct 2026 03:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZp-0006ff-8W
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:37 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xKsZn-00048V-G9
 for qemu-devel@nongnu.org; Sun, 25 Oct 2026 03:23:33 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso12998075e9.1
 for <qemu-devel@nongnu.org>; Sun, 25 Oct 2026 00:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792913008; x=1793517808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mbLFcC6reoI1hoMaOCjQPp+ADnMMLtUzvmiitAvfwPo=;
 b=QbuVDbMPQK1CTrGNSWXxwqMoFTw3EKo1/crs6ef2gXSBdAip5Li6UCFtY7MowG87ET
 lwoA9kxAMshXYKPl76aD0vfDIHPT/YaoyW9vUfVEYo4K8zYgNXfZw2tnoDWi/7ckDABG
 7+XU6ZmU5LEp04cL4t9RFA54bRTgLURk47prVf+0J5kZgR9cUS8GiMch2FEM1VqjwrVg
 WLUV3DASklp43Z3pqU10L33RDGqjD6UkdYnnQ4gUVZYiv8zCuQDp8Qk+uczuAemgNaZ+
 joo8feu0iaL5Zvw695mUDPjFXo6ub/2XKt9Uhk2OwaUaC5vq5ujqKBFFsG12vRFU7iAQ
 LP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792913008; x=1793517808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mbLFcC6reoI1hoMaOCjQPp+ADnMMLtUzvmiitAvfwPo=;
 b=XLVkl3AH8s4SZQ0d1KfefJ6dmwFvx5o1UZmf1GlQkIHarXGlItDJDNFauiDlqKjs0B
 L1FFDk/dZ3xbXGaZ+01U+ZJL7Xsk0OCoPFQbqVSAoPTmO9uua4YJJm9W109fcRCQnt6n
 ELe39CFM2d/Krv2GUiJa0ftMhg97aV+N/eafw7hoxbpVfslwuvW1vWa/N91/vC2QpB1/
 PCpnctyOkRDNEENyJIKL7sRH+VGA4eE8aSWa++db5O53acovYtBqb1TfJIFpNdH6kaPJ
 fZjDJupTdiRQt3GYvGjMHM9tQ4e50W2gl69V9fYglF9pkdohfPZVSas3UxPP05GdE4Jg
 MXhg==
X-Gm-Message-State: AFq9FYLNAZ0pmkcY0NmJcZbe4RiMNIc31hU+YV4elN0azYuVVKLxSfmr
 Amn96ND5E0ZKr/BXs3GsK31p7WjQ4CUEUigLjK010Ls/LUi+bDVvwLkE5aVKrfAM2jtB1aeIZbW
 Jl6GWoEE=
X-Gm-Gg: AYBFou2B7Txx4xCPp9r4Hour7j/xXXn1mULxaOGI1Bc89AUf/HVzpb6ocXkVO2JmL+T
 I2iQjjoR1yI6dZRoz8Oy91iyZqKwlIpxsRjexZW3I9JWOJQnTQAqiUEqiYqNZwSgwOPyOBSAQFv
 zLf1+lMeSv2A9kJ+upzrb23mWoCZX7KiiJk2dhMzAHlSkzTYn+Dk78vFGDdR5oLqnj5tFwtNACz
 oq+Tkk8kzlgEVHnWCsliFBjh4aaGynzuh6q3aCXiq8ug8709tK7U5JmLaF8COpAxA+7OTW+ykRj
 /SeSApyaN4ZxydajUVgMETsAfR9dOeR9+pbLBNvtprSwf8qoOXeAfCfLOFjxnt7DEExuk3+EEkT
 GMA0I49pIMVrW9wGBfcccn0Q3Gaun0b+C1JI7LD8926d5d8fUVAvzqcVSRRHVHPMBLIAxdgLFgQ
 3fghMkRcB3p9vRHKmuRb6/ZxzIs2Ad43wp9m8XKPGe6nprQflgrx+/NTU6kjAQMrD2TDd2rdW5U
 GATEO5/OQmLcZPE3ONphYJ8McyXcJ3ntRq5EVgrH+exSNqYqassu5lWvPY=
X-Received: by 2002:a05:600c:3b11:b0:4a1:faa1:3813 with SMTP id
 5b1f17b1804b1-4a35acbeeb3mr63021815e9.27.1792913008373; 
 Sun, 25 Oct 2026 00:23:28 -0700 (PDT)
Received: from stoup ([176.95.65.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a09434esm103085895e9.0.2026.10.25.00.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 00:23:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matt Turner <mattst88@gmail.com>
Subject: [PULL 068/100] tcg: Generic expansion of tcg_gen_ext16u_*
Date: Sun, 25 Oct 2026 08:18:43 +0100
Message-ID: <20261025071915.1123867-69-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025071915.1123867-1-richard.henderson@linaro.org>
References: <20261025071915.1123867-1-richard.henderson@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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
index cbeae67794..3af56710cb 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -143,7 +143,6 @@ void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -185,7 +184,6 @@ void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, MemOp opc);
 void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 4c1fc9633c..6208a51f53 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -22,6 +22,7 @@ DEF3(divu, TCGV, TCGV, TCGV)
 DEF2(ext8s, TCGV, TCGV)
 DEF2(ext8u, TCGV, TCGV)
 DEF2(ext16s, TCGV, TCGV)
+DEF2(ext16u, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 55bd8ccf8f..3c34f503e7 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -614,6 +614,11 @@ void tcg_gen_ext16s(TCGType type, TCGTemp *dst, TCGTemp *src)
     tcg_gen_sextract(type, dst, src, 0, 16);
 }
 
+void tcg_gen_ext16u(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    tcg_gen_extract(type, dst, src, 0, 16);
+}
+
 void tcg_gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
                      unsigned int ofs, unsigned int len)
 {
@@ -1179,11 +1184,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
     tcg_temp_free_i64(t1);
 }
 
-void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    tcg_gen_extract_i32(ret, arg, 0, 16);
-}
-
 /*
  * Internal helper for bit and byte reversal.
  * Given a repeating matched block of 1's and 0's, swap the bits within
@@ -1475,11 +1475,6 @@ void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg)
     tcg_gen_sextract_i64(ret, arg, 0, 32);
 }
 
-void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    tcg_gen_extract_i64(ret, arg, 0, 16);
-}
-
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_extract_i64(ret, arg, 0, 32);
-- 
2.53.0


