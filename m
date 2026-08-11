Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626FBC5AD55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 04:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wteX7-0005In-T6; Tue, 11 Aug 2026 00:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteX6-0005EJ-G1
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:12 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteX4-0002lN-3U
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:12 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38dcbade417so439873a91.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786424169; x=1787028969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JzplQ/jVoAHM6PcwzuSiwQMkItOK3gLR9Bt+l10w+sc=;
 b=v6gROtqtwNj5vImGiVLdlbDfEegY0rJ47rDG80H7sC91D7/D/imu4YQ5tW0taeojar
 08YFoRmcZx3j4shY/0tqYZNkkt1Vcaq1dZ5N7PczguDr7DP7LyDoZEI7MTzOcx44dW8j
 XG7c+hC89zabKLlLYbeQAgdnH8NvjgwBLd2vtexJq7HU8MO4ZeQErN1VB1z+okX10sWS
 u+VRMmzSEARVgqqeqHfeeAC6bkxAC7VIgn+xXVsc914N7WhiQhKRH9nDu7x5ygRL5ZRE
 2AUgXZl0Bn9GE/qU9illRJ99zbyrOi8JStkyZCBhZ2ESMuNrJxbRNYExu3kMrg/JUSgL
 MtFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786424169; x=1787028969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JzplQ/jVoAHM6PcwzuSiwQMkItOK3gLR9Bt+l10w+sc=;
 b=aMeWipiOSp9aDUoW3fzir/1FtM59+ZiyONq8tvMyR71VUOXVktNqSP35colgeNRe0I
 j9jJhj5Jt1PcjOBJGN7mcikP1mHz25s6l/Y41IxMOzX2M/JcR43cBii1fA6ff6etR+ZJ
 5iDGAjN3D9yf1Hl66qA7HlRzw55R7j2LztW6AGb18PENcyoqBjDn4Vx7oz6sGn8DqQCw
 XuJ0wfNEI4+32W1I+YKDc0BRS0G5O92WQMK8kuxIPuqo/oh7/P9DCB0izpz77kSaYI5t
 VxuDq/c2K2I1FxXxoYlcXajFBvxC8frOkVnv3g39YBLsHo/S9wHq/x5aIdp6rhmh6wVT
 W7SQ==
X-Gm-Message-State: AOJu0YwDGoboDB0LtVJIwWrayBKpCXXnE0iIVzy5hauA1QxHZIv7xo6+
 gwtVzuh5Iufoe/rDaldaEojN5DpsUi424hqgCtw8+g+EXpHZ6GhmgwFfByUV6Zy6rx+QinqL3U4
 67yQP
X-Gm-Gg: AR+sD10drsW0Q6cb9x2WPjDvBTy5pE76LqSFsXvzG0x8gycZR4rpxnASL3ZsvGlWnbW
 pb6NW6tzfBsZBLGDaG69SAxGUh0ldVqW3zrG+slnAlPjusOWmZJNv99lnmGyGCWfUQMCWYPBTWZ
 kImX8AEm4/dvr3xIRNTjZTWJ1aG1MIinuvTKAmlFXvV54kgiotaTCH+D8/NvSo8tdm5DsgA7Dts
 zt1Jeo6gA9p6lCT7AIKcZ9S1YsF4xbZRROy0Uoc9TAWNB3k0fs5T/OnZ7h1XuVTl79KYgrq06Ok
 UEqK/V32E4awCY671+1dtbuzZ+045xmyaSgEoTiL4Jq/5tsqIJC3qRyNL3IORxVs988YZAw07Io
 igmTaFE4YZOlpTUXlNPx/maKsnGvXe74EtQzxZ8EJKXY3IGOjMCkRmhvrcMnogoKWO33ZLr5xIP
 3khfMKdMyyN0m2HCcm6W77M/HJWl3o1w4+KdpNHuZ91FdZLy8g0X3CmrCLqEWS1AwLVv5UxroMW
 0GlolGh+EPuAHbbeA4U
X-Received: by 2002:a17:90b:1c03:b0:37c:6910:5758 with SMTP id
 98e67ed59e1d1-392ec3958bemr697594a91.1.1786424168621; 
 Mon, 10 Aug 2026 21:56:08 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392ee3084d0sm156818a91.8.2026.08.10.21.56.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 21:56:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 02/16] tcg: Add tcg_gen_revbit{8,32,64}
Date: Mon, 10 Aug 2026 21:55:51 -0700
Message-ID: <20260811045605.1246543-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811045605.1246543-1-richard.henderson@linaro.org>
References: <20260811045605.1246543-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Add generic expanders for reversing bits within a word.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op-common.h |  5 +++
 include/tcg/tcg-op.h        |  7 ++++
 tcg/tcg-op.c                | 76 +++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 1fe342db0d..f7b6aadb50 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -164,6 +164,8 @@ void tcg_gen_smax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
+void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
+void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
@@ -275,6 +277,9 @@ void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
+void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
+void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
+void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
 
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in);
diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 96a5af1a29..568b78fe81 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -115,6 +115,10 @@ typedef TCGv_i64 TCGv;
 #define tcg_gen_bswap_tl tcg_gen_bswap64_i64
 #define tcg_gen_hswap_tl tcg_gen_hswap_i64
 #define tcg_gen_wswap_tl tcg_gen_wswap_i64
+#define tcg_gen_revbit8_tl tcg_gen_revbit8_i64
+#define tcg_gen_revbit32_tl tcg_gen_revbit32_i64
+#define tcg_gen_revbit64_tl tcg_gen_revbit64_i64
+#define tcg_gen_revbit_tl tcg_gen_revbit64_i64
 #define tcg_gen_concat_tl_i64 tcg_gen_concat32_i64
 #define tcg_gen_extr_i64_tl tcg_gen_extr32_i64
 #define tcg_gen_andc_tl tcg_gen_andc_i64
@@ -234,6 +238,9 @@ typedef TCGv_i64 TCGv;
 #define tcg_gen_bswap32_tl(D, S, F) tcg_gen_bswap32_i32(D, S)
 #define tcg_gen_bswap_tl tcg_gen_bswap32_i32
 #define tcg_gen_hswap_tl tcg_gen_hswap_i32
+#define tcg_gen_revbit8_tl tcg_gen_revbit8_i32
+#define tcg_gen_revbit32_tl(D, S, F) tcg_gen_revbit32_i32(D, S)
+#define tcg_gen_revbit_tl tcg_gen_revbit32_i32
 #define tcg_gen_concat_tl_i64 tcg_gen_concat_i32_i64
 #define tcg_gen_extr_i64_tl tcg_gen_extr_i64_i32
 #define tcg_gen_andc_tl tcg_gen_andc_i32
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index bbcb510c76..3d28280785 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1160,6 +1160,45 @@ void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg)
     tcg_gen_extract_i32(ret, arg, 0, 16);
 }
 
+/*
+ * Internal helper for bit and byte reversal.
+ * Given a repeating matched block of 1's and 0's, swap the bits within
+ * those two blocks.  E.g.  mask=00ff00ff, shift the input bits left and
+ * right 8 bits.
+ */
+static void gen_bitswap_i32(TCGv_i32 ret, TCGv_i32 arg, uint32_t mask)
+{
+    TCGv_i32 t0 = tcg_temp_ebb_new_i32();
+    TCGv_i32 t1 = tcg_temp_ebb_new_i32();
+    int sh = cto32(mask);
+
+    tcg_gen_andi_i32(t0, arg, mask);
+    tcg_gen_shri_i32(t1, arg, sh);
+    tcg_gen_shli_i32(t0, t0, sh);
+    tcg_gen_andi_i32(t1, t1, mask);
+    tcg_gen_or_i32(ret, t0, t1);
+
+    tcg_temp_free_i32(t0);
+    tcg_temp_free_i32(t1);
+}
+
+/* Similarly for 64-bit operands. */
+static void gen_bitswap_i64(TCGv_i64 ret, TCGv_i64 arg, uint64_t mask)
+{
+    TCGv_i64 t0 = tcg_temp_ebb_new_i64();
+    TCGv_i64 t1 = tcg_temp_ebb_new_i64();
+    int sh = cto64(mask);
+
+    tcg_gen_andi_i64(t0, arg, mask);
+    tcg_gen_shri_i64(t1, arg, sh);
+    tcg_gen_shli_i64(t0, t0, sh);
+    tcg_gen_andi_i64(t1, t1, mask);
+    tcg_gen_or_i64(ret, t0, t1);
+
+    tcg_temp_free_i64(t0);
+    tcg_temp_free_i64(t1);
+}
+
 /*
  * bswap16_i32: 16-bit byte swap on the low bits of a 32-bit value.
  *
@@ -1244,6 +1283,19 @@ void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg)
     tcg_gen_rotli_i32(ret, arg, 16);
 }
 
+void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg)
+{
+    gen_bitswap_i32(ret, arg, 0x55555555u);
+    gen_bitswap_i32(ret, ret, 0x33333333u);
+    gen_bitswap_i32(ret, ret, 0x0f0f0f0fu);
+}
+
+void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
+{
+    tcg_gen_revbit8_i32(ret, arg);
+    tcg_gen_bswap32_i32(ret, ret);
+}
+
 void tcg_gen_smin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
     tcg_gen_movcond_i32(TCG_COND_LT, ret, a, b, a, b);
@@ -1869,6 +1921,30 @@ void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg)
     tcg_gen_rotli_i64(ret, arg, 32);
 }
 
+void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
+{
+    /* Only one extension flag may be present. */
+    tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
+
+    gen_bitswap_i64(ret, arg, 0x55555555ull);
+    gen_bitswap_i64(ret, ret, 0x33333333ull);
+    gen_bitswap_i64(ret, ret, 0x0f0f0f0full);
+    tcg_gen_bswap32_i64(ret, ret, flags | TCG_BSWAP_IZ);
+}
+
+void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg)
+{
+    gen_bitswap_i64(ret, arg, 0x5555555555555555ull);
+    gen_bitswap_i64(ret, ret, 0x3333333333333333ull);
+    gen_bitswap_i64(ret, ret, 0x0f0f0f0f0f0f0f0full);
+}
+
+void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
+{
+    tcg_gen_revbit8_i64(ret, arg);
+    tcg_gen_bswap64_i64(ret, ret);
+}
+
 void tcg_gen_not_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     if (tcg_op_supported(INDEX_op_not, TCG_TYPE_I64, 0)) {
-- 
2.43.0


