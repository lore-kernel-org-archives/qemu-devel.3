Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6BDE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdyH-0008D1-Ja; Wed, 08 Jan 2025 16:52:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdyG-0008Cp-Hu
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:52:12 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdyE-00040N-8x
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:52:12 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385d7b4da2bso213316f8f.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736373128; x=1736977928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JVYjJ2mCAmRfPhk4CmbKvQbj1/8MWt6GFQu7OdWg7N4=;
 b=uDY2nr4OhYG6oErN2TttWg4YQFifjttGX/PkNdoelZ60u021i6sKeY+yoTuTnGLYbh
 S0Jnn+JrJB7hAcglF794l4+odyguV7jZdX21L5aRFpPa3rvCWdnVarbL/A7cukSoraeu
 RCI7DKJA6hBiVgPN8gWaAhPJXTI6lWo7pTGHcaHX1E3Xrd3aGQw8qIXwsvBxuzxLwnjM
 rYBvVziy/2OGIw7+q3CbZ+WEb+n1mLVucbyuX/4nYiE/dCAKsZZ11H26dPqLf4iJKi7l
 y7LfHpqBuWD3pfr98yDnUp8ypm0guheO6cuZ5xXg3eYq9jc+KWwJ4rJjabHHtawoqUVj
 mylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736373128; x=1736977928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JVYjJ2mCAmRfPhk4CmbKvQbj1/8MWt6GFQu7OdWg7N4=;
 b=jH+R2PpVqz6ygWCPy7NbsePbJQ4rBNl2t0sgZkXBAetDadS3mVwuxMKZPHxQj8DwVi
 w5N8VCZ+OYAPdsN8FhZvqhPfqaz5vbWB+RCEHxHbbWQjy2OA51xRxGvo2lJd6YQhY+I1
 cBC1EfqlrkTw6ZbcXnZQnJcUKPRQbZNmpwuOJ5VE/+WG4EXrYm6crvjNxpI/T35MTwWU
 BtneUpu4xI7CQzlfhl/sv5kmD8jgzK/j9IuKGV633dI/rIWcsJNtmhkAgY+cafrx3+rD
 e2uDbxfXDBXcXV0wjnb7/VA9jAVt0bg7SMMMIyDw0rN6c3OKP9XwgQA5CtTJ5eiEJwsB
 dHNw==
X-Gm-Message-State: AOJu0YyorwkdNlLGEa1ktBDatMZPUvWiWmFuM6X9DstRF9Mn5ysdq3C0
 KhkEChzeWspQnzPgx0pz0HETO2/Hrlhq/9cstqVVpxql1noVxBurnZUt5iRJ9fIfkquNpwIo4OJ
 QIwU=
X-Gm-Gg: ASbGncurgKdWL0f5cYHm7bpiQU9CqQ1gol3E+QTNAEMr/Gvae+wqLsAN/a75LPkUIlZ
 GgiK53gojWdCch4gd4VNP4+H/yXDNB/UgixAg3RApo/2v7r9urNOXFz+DNcPYIGPzNHKXVNnTv2
 5jqFdyeVrcKsIaBB25YKIViYnIC3wgGps87dxVbdknwhjfE2Dad5xcaRe2y4aZiREzOe6FBzSIC
 EwaVmaKktiJnVJvNRReo8nx6DqNVx9OjpO9KOpsKb/IbWrb/l5iyk4rRmUL44hjT3ySs1WKJ/+r
 0+9hovzL30uOB8VU5qtH/YG2H/mFEH8=
X-Google-Smtp-Source: AGHT+IHGgDcs+gOqCSYZtkdEI7AdePQH8EPIb7UisCIAC81MGUGSiNBzxyWyCnwk56oBFfLOLKubbg==
X-Received: by 2002:a5d:584d:0:b0:385:e9de:d521 with SMTP id
 ffacd0b85a97d-38a872fc1camr3864082f8f.8.1736373127682; 
 Wed, 08 Jan 2025 13:52:07 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e140sm55045077f8f.79.2025.01.08.13.52.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Jan 2025 13:52:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 02/14] tcg: Extract default TCG_TARGET_HAS_foo definitions
 to 'tcg-has.h'
Date: Wed,  8 Jan 2025 22:51:43 +0100
Message-ID: <20250108215156.8731-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108215156.8731-1-philmd@linaro.org>
References: <20250107080112.1175095-19-richard.henderson@linaro.org>
 <20250108215156.8731-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/tcg/tcg.h | 105 +-----------------------------------------
 tcg/tcg-has.h     | 115 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+), 104 deletions(-)
 create mode 100644 tcg/tcg-has.h

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 57f5fda109f..3897c2d6b28 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -64,110 +64,7 @@ typedef uint64_t TCGRegSet;
 #error unsupported
 #endif
 
-#if TCG_TARGET_REG_BITS == 32
-/* Turn some undef macros into false macros.  */
-#define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_div_i64          0
-#define TCG_TARGET_HAS_rem_i64          0
-#define TCG_TARGET_HAS_div2_i64         0
-#define TCG_TARGET_HAS_rot_i64          0
-#define TCG_TARGET_HAS_ext8s_i64        0
-#define TCG_TARGET_HAS_ext16s_i64       0
-#define TCG_TARGET_HAS_ext32s_i64       0
-#define TCG_TARGET_HAS_ext8u_i64        0
-#define TCG_TARGET_HAS_ext16u_i64       0
-#define TCG_TARGET_HAS_ext32u_i64       0
-#define TCG_TARGET_HAS_bswap16_i64      0
-#define TCG_TARGET_HAS_bswap32_i64      0
-#define TCG_TARGET_HAS_bswap64_i64      0
-#define TCG_TARGET_HAS_not_i64          0
-#define TCG_TARGET_HAS_andc_i64         0
-#define TCG_TARGET_HAS_orc_i64          0
-#define TCG_TARGET_HAS_eqv_i64          0
-#define TCG_TARGET_HAS_nand_i64         0
-#define TCG_TARGET_HAS_nor_i64          0
-#define TCG_TARGET_HAS_clz_i64          0
-#define TCG_TARGET_HAS_ctz_i64          0
-#define TCG_TARGET_HAS_ctpop_i64        0
-#define TCG_TARGET_HAS_deposit_i64      0
-#define TCG_TARGET_HAS_extract_i64      0
-#define TCG_TARGET_HAS_sextract_i64     0
-#define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_negsetcond_i64   0
-#define TCG_TARGET_HAS_add2_i64         0
-#define TCG_TARGET_HAS_sub2_i64         0
-#define TCG_TARGET_HAS_mulu2_i64        0
-#define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_muluh_i64        0
-#define TCG_TARGET_HAS_mulsh_i64        0
-/* Turn some undef macros into true macros.  */
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
-#endif
-
-#ifndef TCG_TARGET_deposit_i32_valid
-#define TCG_TARGET_deposit_i32_valid(ofs, len) 1
-#endif
-#ifndef TCG_TARGET_deposit_i64_valid
-#define TCG_TARGET_deposit_i64_valid(ofs, len) 1
-#endif
-#ifndef TCG_TARGET_extract_i32_valid
-#define TCG_TARGET_extract_i32_valid(ofs, len) 1
-#endif
-#ifndef TCG_TARGET_extract_i64_valid
-#define TCG_TARGET_extract_i64_valid(ofs, len) 1
-#endif
-
-/* Only one of DIV or DIV2 should be defined.  */
-#if defined(TCG_TARGET_HAS_div_i32)
-#define TCG_TARGET_HAS_div2_i32         0
-#elif defined(TCG_TARGET_HAS_div2_i32)
-#define TCG_TARGET_HAS_div_i32          0
-#define TCG_TARGET_HAS_rem_i32          0
-#endif
-#if defined(TCG_TARGET_HAS_div_i64)
-#define TCG_TARGET_HAS_div2_i64         0
-#elif defined(TCG_TARGET_HAS_div2_i64)
-#define TCG_TARGET_HAS_div_i64          0
-#define TCG_TARGET_HAS_rem_i64          0
-#endif
-
-#if !defined(TCG_TARGET_HAS_v64) \
-    && !defined(TCG_TARGET_HAS_v128) \
-    && !defined(TCG_TARGET_HAS_v256)
-#define TCG_TARGET_MAYBE_vec            0
-#define TCG_TARGET_HAS_abs_vec          0
-#define TCG_TARGET_HAS_neg_vec          0
-#define TCG_TARGET_HAS_not_vec          0
-#define TCG_TARGET_HAS_andc_vec         0
-#define TCG_TARGET_HAS_orc_vec          0
-#define TCG_TARGET_HAS_nand_vec         0
-#define TCG_TARGET_HAS_nor_vec          0
-#define TCG_TARGET_HAS_eqv_vec          0
-#define TCG_TARGET_HAS_roti_vec         0
-#define TCG_TARGET_HAS_rots_vec         0
-#define TCG_TARGET_HAS_rotv_vec         0
-#define TCG_TARGET_HAS_shi_vec          0
-#define TCG_TARGET_HAS_shs_vec          0
-#define TCG_TARGET_HAS_shv_vec          0
-#define TCG_TARGET_HAS_mul_vec          0
-#define TCG_TARGET_HAS_sat_vec          0
-#define TCG_TARGET_HAS_minmax_vec       0
-#define TCG_TARGET_HAS_bitsel_vec       0
-#define TCG_TARGET_HAS_cmpsel_vec       0
-#define TCG_TARGET_HAS_tst_vec          0
-#else
-#define TCG_TARGET_MAYBE_vec            1
-#endif
-#ifndef TCG_TARGET_HAS_v64
-#define TCG_TARGET_HAS_v64              0
-#endif
-#ifndef TCG_TARGET_HAS_v128
-#define TCG_TARGET_HAS_v128             0
-#endif
-#ifndef TCG_TARGET_HAS_v256
-#define TCG_TARGET_HAS_v256             0
-#endif
+#include "tcg/tcg-has.h"
 
 typedef enum TCGOpcode {
 #define DEF(name, oargs, iargs, cargs, flags) INDEX_op_ ## name,
diff --git a/tcg/tcg-has.h b/tcg/tcg-has.h
new file mode 100644
index 00000000000..c09ce13389e
--- /dev/null
+++ b/tcg/tcg-has.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific opcode support
+ * Copyright (c) 2024 Linaro, Ltd.
+ */
+
+#ifndef TCG_HAS_H
+#define TCG_HAS_H
+
+#if TCG_TARGET_REG_BITS == 32
+/* Turn some undef macros into false macros.  */
+#define TCG_TARGET_HAS_extr_i64_i32     0
+#define TCG_TARGET_HAS_div_i64          0
+#define TCG_TARGET_HAS_rem_i64          0
+#define TCG_TARGET_HAS_div2_i64         0
+#define TCG_TARGET_HAS_rot_i64          0
+#define TCG_TARGET_HAS_ext8s_i64        0
+#define TCG_TARGET_HAS_ext16s_i64       0
+#define TCG_TARGET_HAS_ext32s_i64       0
+#define TCG_TARGET_HAS_ext8u_i64        0
+#define TCG_TARGET_HAS_ext16u_i64       0
+#define TCG_TARGET_HAS_ext32u_i64       0
+#define TCG_TARGET_HAS_bswap16_i64      0
+#define TCG_TARGET_HAS_bswap32_i64      0
+#define TCG_TARGET_HAS_bswap64_i64      0
+#define TCG_TARGET_HAS_not_i64          0
+#define TCG_TARGET_HAS_andc_i64         0
+#define TCG_TARGET_HAS_orc_i64          0
+#define TCG_TARGET_HAS_eqv_i64          0
+#define TCG_TARGET_HAS_nand_i64         0
+#define TCG_TARGET_HAS_nor_i64          0
+#define TCG_TARGET_HAS_clz_i64          0
+#define TCG_TARGET_HAS_ctz_i64          0
+#define TCG_TARGET_HAS_ctpop_i64        0
+#define TCG_TARGET_HAS_deposit_i64      0
+#define TCG_TARGET_HAS_extract_i64      0
+#define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_extract2_i64     0
+#define TCG_TARGET_HAS_negsetcond_i64   0
+#define TCG_TARGET_HAS_add2_i64         0
+#define TCG_TARGET_HAS_sub2_i64         0
+#define TCG_TARGET_HAS_mulu2_i64        0
+#define TCG_TARGET_HAS_muls2_i64        0
+#define TCG_TARGET_HAS_muluh_i64        0
+#define TCG_TARGET_HAS_mulsh_i64        0
+/* Turn some undef macros into true macros.  */
+#define TCG_TARGET_HAS_add2_i32         1
+#define TCG_TARGET_HAS_sub2_i32         1
+#endif
+
+#ifndef TCG_TARGET_deposit_i32_valid
+#define TCG_TARGET_deposit_i32_valid(ofs, len) 1
+#endif
+#ifndef TCG_TARGET_deposit_i64_valid
+#define TCG_TARGET_deposit_i64_valid(ofs, len) 1
+#endif
+#ifndef TCG_TARGET_extract_i32_valid
+#define TCG_TARGET_extract_i32_valid(ofs, len) 1
+#endif
+#ifndef TCG_TARGET_extract_i64_valid
+#define TCG_TARGET_extract_i64_valid(ofs, len) 1
+#endif
+
+/* Only one of DIV or DIV2 should be defined.  */
+#if defined(TCG_TARGET_HAS_div_i32)
+#define TCG_TARGET_HAS_div2_i32         0
+#elif defined(TCG_TARGET_HAS_div2_i32)
+#define TCG_TARGET_HAS_div_i32          0
+#define TCG_TARGET_HAS_rem_i32          0
+#endif
+#if defined(TCG_TARGET_HAS_div_i64)
+#define TCG_TARGET_HAS_div2_i64         0
+#elif defined(TCG_TARGET_HAS_div2_i64)
+#define TCG_TARGET_HAS_div_i64          0
+#define TCG_TARGET_HAS_rem_i64          0
+#endif
+
+#if !defined(TCG_TARGET_HAS_v64) \
+    && !defined(TCG_TARGET_HAS_v128) \
+    && !defined(TCG_TARGET_HAS_v256)
+#define TCG_TARGET_MAYBE_vec            0
+#define TCG_TARGET_HAS_abs_vec          0
+#define TCG_TARGET_HAS_neg_vec          0
+#define TCG_TARGET_HAS_not_vec          0
+#define TCG_TARGET_HAS_andc_vec         0
+#define TCG_TARGET_HAS_orc_vec          0
+#define TCG_TARGET_HAS_nand_vec         0
+#define TCG_TARGET_HAS_nor_vec          0
+#define TCG_TARGET_HAS_eqv_vec          0
+#define TCG_TARGET_HAS_roti_vec         0
+#define TCG_TARGET_HAS_rots_vec         0
+#define TCG_TARGET_HAS_rotv_vec         0
+#define TCG_TARGET_HAS_shi_vec          0
+#define TCG_TARGET_HAS_shs_vec          0
+#define TCG_TARGET_HAS_shv_vec          0
+#define TCG_TARGET_HAS_mul_vec          0
+#define TCG_TARGET_HAS_sat_vec          0
+#define TCG_TARGET_HAS_minmax_vec       0
+#define TCG_TARGET_HAS_bitsel_vec       0
+#define TCG_TARGET_HAS_cmpsel_vec       0
+#define TCG_TARGET_HAS_tst_vec          0
+#else
+#define TCG_TARGET_MAYBE_vec            1
+#endif
+#ifndef TCG_TARGET_HAS_v64
+#define TCG_TARGET_HAS_v64              0
+#endif
+#ifndef TCG_TARGET_HAS_v128
+#define TCG_TARGET_HAS_v128             0
+#endif
+#ifndef TCG_TARGET_HAS_v256
+#define TCG_TARGET_HAS_v256             0
+#endif
+
+#endif
-- 
2.47.1


