Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE37C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr20-00046Z-1V; Fri, 17 Jan 2025 13:25:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1x-00043f-6S
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:17 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr1u-0007sF-Mx
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:16 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2164b1f05caso48360205ad.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138313; x=1737743113; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ejNe7dujNWlrHZx528aik9wp8F8L+b+G3lLjN4kTkqw=;
 b=vfRaqrpPLJAzhT5RAuuU0S+28U5/2WJYiD5+wwSW+FDg7sgAzR8YNBmTst2UEG/nnE
 WJf8N11cx+CSe8NXO0keyzXZmJWATDzE0g7HyCSyzCzIBPYs/KNJKt4fQfnKkVge21iK
 qpTe7Q3YKp6HhiNGVcpffU1URK5Y0mNFhapwVAtW2sibQV1YubrTe60kyJyL1TcBjCbd
 qAtXEJAMMhcjJQaGqXK3DG/CdNpIklXglF8kgYlj6I8ML12ohgR5n2Lt8rGn3PswK91I
 vPkHGPlklK7t+ybrUXOhf4m24Biwu2YwlGB2OoIgWsoQy6IYyJ4WpqQ+Mn7fY99AjOPl
 gtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138313; x=1737743113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ejNe7dujNWlrHZx528aik9wp8F8L+b+G3lLjN4kTkqw=;
 b=jz7izruc72wgc64O6aBMNl/d47vyP2Hmcmz0Ll/16QVW65yQY/3WIFUjOPo+SvmBzq
 U5Bq+VnZNiirZ9zgpPu7Pvb0z8KoxWde3bMu8ciyzn0JOK5FUF5+6NkNihNvLoEZHYjA
 Tf9edaGEo0vEy8dI61IjUCwIJuWRvoumzCJSrwlOuwBVJ8usWyMVJlFcS8SLL+GSCKgL
 6Z2hhRgE1OEYTNSm2BInbI2VVvW0os57FfSo9ICuKbtOz3FZo3w53IMcq6XXRPiSXzs0
 jb+qH+5IAlMD+qq2lU/ZqVX5WuwMD870dYpfGh4CP+XsIf8qyQ5AkkFnEHS/suXCv0Pn
 uy1A==
X-Gm-Message-State: AOJu0Yx0yMPz6lkzjv9e0F53dKgNoerzQNPTkRfIohsvgAKMyMYEFVtN
 f08FkHB4Ej8/R4NTYuSPvTMxzJCaZ0HrUot6rV5m1Wkx81rFgE6xpsdgOAZaedFUNECekCbAoA3
 c
X-Gm-Gg: ASbGncsE/fx5uMk204TFByXJSlRvUNyTguMVJeMQ+BI/g9r/TF+l8VeRvgD7k7YdHL4
 9Kw0Co9HNUsmHg3hkCNFJR/RXaOcqygrAi1EEn0RCq1BIG/m+NrQWn/yri13Ob6mD+Ev8bHOZUG
 bB0n0b+ibyWCTLnHGycFwIQ+JSVdgb43VdR99dbffE5nOKXLUMdjoRdNaDNPhXlz8Do36+PLCza
 jjpzls3Mr/aQEX/2i06YvqKTYWoRRIQsYxSVlp2EE0YkDSQ3tJ1n3+e5K/oaQ1s6N5tLwDT/7b5
 kONn/EYlwEcy0Mg=
X-Google-Smtp-Source: AGHT+IGCLOTRwU6q2Cw9ysfjK7U4z5PTwnRtNmzIKeO3BSlSW2cfB5pfQ9OZ314HDXqvlXf5g50HHQ==
X-Received: by 2002:a17:903:2342:b0:216:725c:a137 with SMTP id
 d9443c01a7336-21c3556b038mr53972085ad.28.1737138313139; 
 Fri, 17 Jan 2025 10:25:13 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:12 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/68] tcg/aarch64: Extract TCG_TARGET_HAS_foo defs to
 'tcg-target-has.h'
Date: Fri, 17 Jan 2025 10:24:09 -0800
Message-ID: <20250117182456.2077110-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250108215156.8731-4-philmd@linaro.org>
---
 tcg/aarch64/tcg-target-has.h | 119 +++++++++++++++++++++++++++++++++++
 tcg/aarch64/tcg-target.h     | 109 +-------------------------------
 2 files changed, 120 insertions(+), 108 deletions(-)
 create mode 100644 tcg/aarch64/tcg-target-has.h

diff --git a/tcg/aarch64/tcg-target-has.h b/tcg/aarch64/tcg-target-has.h
new file mode 100644
index 0000000000..0e79e01266
--- /dev/null
+++ b/tcg/aarch64/tcg-target-has.h
@@ -0,0 +1,119 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Define target-specific opcode support
+ * Copyright (c) 2013 Huawei Technologies Duesseldorf GmbH
+ */
+
+#ifndef TCG_TARGET_HAS_H
+#define TCG_TARGET_HAS_H
+
+#include "host/cpuinfo.h"
+
+#define have_lse    (cpuinfo & CPUINFO_LSE)
+#define have_lse2   (cpuinfo & CPUINFO_LSE2)
+
+/* optional instructions */
+#define TCG_TARGET_HAS_div_i32          1
+#define TCG_TARGET_HAS_rem_i32          1
+#define TCG_TARGET_HAS_ext8s_i32        1
+#define TCG_TARGET_HAS_ext16s_i32       1
+#define TCG_TARGET_HAS_ext8u_i32        1
+#define TCG_TARGET_HAS_ext16u_i32       1
+#define TCG_TARGET_HAS_bswap16_i32      1
+#define TCG_TARGET_HAS_bswap32_i32      1
+#define TCG_TARGET_HAS_not_i32          1
+#define TCG_TARGET_HAS_rot_i32          1
+#define TCG_TARGET_HAS_andc_i32         1
+#define TCG_TARGET_HAS_orc_i32          1
+#define TCG_TARGET_HAS_eqv_i32          1
+#define TCG_TARGET_HAS_nand_i32         0
+#define TCG_TARGET_HAS_nor_i32          0
+#define TCG_TARGET_HAS_clz_i32          1
+#define TCG_TARGET_HAS_ctz_i32          1
+#define TCG_TARGET_HAS_ctpop_i32        0
+#define TCG_TARGET_HAS_deposit_i32      1
+#define TCG_TARGET_HAS_extract_i32      1
+#define TCG_TARGET_HAS_sextract_i32     1
+#define TCG_TARGET_HAS_extract2_i32     1
+#define TCG_TARGET_HAS_negsetcond_i32   1
+#define TCG_TARGET_HAS_add2_i32         1
+#define TCG_TARGET_HAS_sub2_i32         1
+#define TCG_TARGET_HAS_mulu2_i32        0
+#define TCG_TARGET_HAS_muls2_i32        0
+#define TCG_TARGET_HAS_muluh_i32        0
+#define TCG_TARGET_HAS_mulsh_i32        0
+#define TCG_TARGET_HAS_extr_i64_i32     0
+#define TCG_TARGET_HAS_qemu_st8_i32     0
+
+#define TCG_TARGET_HAS_div_i64          1
+#define TCG_TARGET_HAS_rem_i64          1
+#define TCG_TARGET_HAS_ext8s_i64        1
+#define TCG_TARGET_HAS_ext16s_i64       1
+#define TCG_TARGET_HAS_ext32s_i64       1
+#define TCG_TARGET_HAS_ext8u_i64        1
+#define TCG_TARGET_HAS_ext16u_i64       1
+#define TCG_TARGET_HAS_ext32u_i64       1
+#define TCG_TARGET_HAS_bswap16_i64      1
+#define TCG_TARGET_HAS_bswap32_i64      1
+#define TCG_TARGET_HAS_bswap64_i64      1
+#define TCG_TARGET_HAS_not_i64          1
+#define TCG_TARGET_HAS_rot_i64          1
+#define TCG_TARGET_HAS_andc_i64         1
+#define TCG_TARGET_HAS_orc_i64          1
+#define TCG_TARGET_HAS_eqv_i64          1
+#define TCG_TARGET_HAS_nand_i64         0
+#define TCG_TARGET_HAS_nor_i64          0
+#define TCG_TARGET_HAS_clz_i64          1
+#define TCG_TARGET_HAS_ctz_i64          1
+#define TCG_TARGET_HAS_ctpop_i64        0
+#define TCG_TARGET_HAS_deposit_i64      1
+#define TCG_TARGET_HAS_extract_i64      1
+#define TCG_TARGET_HAS_sextract_i64     1
+#define TCG_TARGET_HAS_extract2_i64     1
+#define TCG_TARGET_HAS_negsetcond_i64   1
+#define TCG_TARGET_HAS_add2_i64         1
+#define TCG_TARGET_HAS_sub2_i64         1
+#define TCG_TARGET_HAS_mulu2_i64        0
+#define TCG_TARGET_HAS_muls2_i64        0
+#define TCG_TARGET_HAS_muluh_i64        1
+#define TCG_TARGET_HAS_mulsh_i64        1
+
+/*
+ * Without FEAT_LSE2, we must use LDXP+STXP to implement atomic 128-bit load,
+ * which requires writable pages.  We must defer to the helper for user-only,
+ * but in system mode all ram is writable for the host.
+ */
+#ifdef CONFIG_USER_ONLY
+#define TCG_TARGET_HAS_qemu_ldst_i128   have_lse2
+#else
+#define TCG_TARGET_HAS_qemu_ldst_i128   1
+#endif
+
+#define TCG_TARGET_HAS_tst              1
+
+#define TCG_TARGET_HAS_v64              1
+#define TCG_TARGET_HAS_v128             1
+#define TCG_TARGET_HAS_v256             0
+
+#define TCG_TARGET_HAS_andc_vec         1
+#define TCG_TARGET_HAS_orc_vec          1
+#define TCG_TARGET_HAS_nand_vec         0
+#define TCG_TARGET_HAS_nor_vec          0
+#define TCG_TARGET_HAS_eqv_vec          0
+#define TCG_TARGET_HAS_not_vec          1
+#define TCG_TARGET_HAS_neg_vec          1
+#define TCG_TARGET_HAS_abs_vec          1
+#define TCG_TARGET_HAS_roti_vec         0
+#define TCG_TARGET_HAS_rots_vec         0
+#define TCG_TARGET_HAS_rotv_vec         0
+#define TCG_TARGET_HAS_shi_vec          1
+#define TCG_TARGET_HAS_shs_vec          0
+#define TCG_TARGET_HAS_shv_vec          1
+#define TCG_TARGET_HAS_mul_vec          1
+#define TCG_TARGET_HAS_sat_vec          1
+#define TCG_TARGET_HAS_minmax_vec       1
+#define TCG_TARGET_HAS_bitsel_vec       1
+#define TCG_TARGET_HAS_cmpsel_vec       0
+#define TCG_TARGET_HAS_tst_vec          1
+
+#endif
diff --git a/tcg/aarch64/tcg-target.h b/tcg/aarch64/tcg-target.h
index d8ca52d32d..9a682e51a4 100644
--- a/tcg/aarch64/tcg-target.h
+++ b/tcg/aarch64/tcg-target.h
@@ -13,8 +13,6 @@
 #ifndef AARCH64_TCG_TARGET_H
 #define AARCH64_TCG_TARGET_H
 
-#include "host/cpuinfo.h"
-
 #define TCG_TARGET_INSN_UNIT_SIZE  4
 #define MAX_CODE_GEN_BUFFER_SIZE  ((size_t)-1)
 
@@ -49,112 +47,7 @@ typedef enum {
 
 #define TCG_TARGET_NB_REGS 64
 
-#define have_lse    (cpuinfo & CPUINFO_LSE)
-#define have_lse2   (cpuinfo & CPUINFO_LSE2)
-
-/* optional instructions */
-#define TCG_TARGET_HAS_div_i32          1
-#define TCG_TARGET_HAS_rem_i32          1
-#define TCG_TARGET_HAS_ext8s_i32        1
-#define TCG_TARGET_HAS_ext16s_i32       1
-#define TCG_TARGET_HAS_ext8u_i32        1
-#define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_bswap16_i32      1
-#define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_rot_i32          1
-#define TCG_TARGET_HAS_andc_i32         1
-#define TCG_TARGET_HAS_orc_i32          1
-#define TCG_TARGET_HAS_eqv_i32          1
-#define TCG_TARGET_HAS_nand_i32         0
-#define TCG_TARGET_HAS_nor_i32          0
-#define TCG_TARGET_HAS_clz_i32          1
-#define TCG_TARGET_HAS_ctz_i32          1
-#define TCG_TARGET_HAS_ctpop_i32        0
-#define TCG_TARGET_HAS_deposit_i32      1
-#define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     1
-#define TCG_TARGET_HAS_extract2_i32     1
-#define TCG_TARGET_HAS_negsetcond_i32   1
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
-#define TCG_TARGET_HAS_mulu2_i32        0
-#define TCG_TARGET_HAS_muls2_i32        0
-#define TCG_TARGET_HAS_muluh_i32        0
-#define TCG_TARGET_HAS_mulsh_i32        0
-#define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_qemu_st8_i32     0
-
-#define TCG_TARGET_HAS_div_i64          1
-#define TCG_TARGET_HAS_rem_i64          1
-#define TCG_TARGET_HAS_ext8s_i64        1
-#define TCG_TARGET_HAS_ext16s_i64       1
-#define TCG_TARGET_HAS_ext32s_i64       1
-#define TCG_TARGET_HAS_ext8u_i64        1
-#define TCG_TARGET_HAS_ext16u_i64       1
-#define TCG_TARGET_HAS_ext32u_i64       1
-#define TCG_TARGET_HAS_bswap16_i64      1
-#define TCG_TARGET_HAS_bswap32_i64      1
-#define TCG_TARGET_HAS_bswap64_i64      1
-#define TCG_TARGET_HAS_not_i64          1
-#define TCG_TARGET_HAS_rot_i64          1
-#define TCG_TARGET_HAS_andc_i64         1
-#define TCG_TARGET_HAS_orc_i64          1
-#define TCG_TARGET_HAS_eqv_i64          1
-#define TCG_TARGET_HAS_nand_i64         0
-#define TCG_TARGET_HAS_nor_i64          0
-#define TCG_TARGET_HAS_clz_i64          1
-#define TCG_TARGET_HAS_ctz_i64          1
-#define TCG_TARGET_HAS_ctpop_i64        0
-#define TCG_TARGET_HAS_deposit_i64      1
-#define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     1
-#define TCG_TARGET_HAS_extract2_i64     1
-#define TCG_TARGET_HAS_negsetcond_i64   1
-#define TCG_TARGET_HAS_add2_i64         1
-#define TCG_TARGET_HAS_sub2_i64         1
-#define TCG_TARGET_HAS_mulu2_i64        0
-#define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_muluh_i64        1
-#define TCG_TARGET_HAS_mulsh_i64        1
-
-/*
- * Without FEAT_LSE2, we must use LDXP+STXP to implement atomic 128-bit load,
- * which requires writable pages.  We must defer to the helper for user-only,
- * but in system mode all ram is writable for the host.
- */
-#ifdef CONFIG_USER_ONLY
-#define TCG_TARGET_HAS_qemu_ldst_i128   have_lse2
-#else
-#define TCG_TARGET_HAS_qemu_ldst_i128   1
-#endif
-
-#define TCG_TARGET_HAS_tst              1
-
-#define TCG_TARGET_HAS_v64              1
-#define TCG_TARGET_HAS_v128             1
-#define TCG_TARGET_HAS_v256             0
-
-#define TCG_TARGET_HAS_andc_vec         1
-#define TCG_TARGET_HAS_orc_vec          1
-#define TCG_TARGET_HAS_nand_vec         0
-#define TCG_TARGET_HAS_nor_vec          0
-#define TCG_TARGET_HAS_eqv_vec          0
-#define TCG_TARGET_HAS_not_vec          1
-#define TCG_TARGET_HAS_neg_vec          1
-#define TCG_TARGET_HAS_abs_vec          1
-#define TCG_TARGET_HAS_roti_vec         0
-#define TCG_TARGET_HAS_rots_vec         0
-#define TCG_TARGET_HAS_rotv_vec         0
-#define TCG_TARGET_HAS_shi_vec          1
-#define TCG_TARGET_HAS_shs_vec          0
-#define TCG_TARGET_HAS_shv_vec          1
-#define TCG_TARGET_HAS_mul_vec          1
-#define TCG_TARGET_HAS_sat_vec          1
-#define TCG_TARGET_HAS_minmax_vec       1
-#define TCG_TARGET_HAS_bitsel_vec       1
-#define TCG_TARGET_HAS_cmpsel_vec       0
-#define TCG_TARGET_HAS_tst_vec          1
+#include "tcg-target-has.h"
 
 #define TCG_TARGET_DEFAULT_MO (0)
 
-- 
2.43.0


