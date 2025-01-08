Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 546CEE7719D
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 21:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVdyf-0008Sv-HQ; Wed, 08 Jan 2025 16:52:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdyY-0008QS-BK
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:52:30 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVdyW-00042a-6c
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 16:52:29 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-435f8f29f8aso2366815e9.2
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 13:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736373146; x=1736977946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BjurB30feh31L4vvKnOWTjLO5NeT2JI+C6yferOyGvM=;
 b=umtpk+XLh8nRu3R0os2n2MCggzRW9i+qREl5FewbqDkVFOD8oYx3yqcvDEixqbyPBv
 tcCogVW/pe68lF2+Wu97wo5e+xPnM7KsI+cqsrilbOmY4iCzrl4EX+f7y7YyT+Bm4u/M
 SeJmOhQyQDEg30LITILgDseMFLRoBPW9GbyAKtQDIujS9qPfcub1wuUOjGzQYIBNERRt
 IUaP++kQR8C3tGCXAsXbE36mrK+9jupxfmQCJYVQIVVsr7WnUc+FI2KyDs9WlTH5o/0E
 1aAmFHFzi4L4yTQX0nqeaA5JQrEvuXHljM7RqMcyN5kMwFLzwUcM2oDMCzhpPEIw1B5v
 Dv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736373146; x=1736977946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BjurB30feh31L4vvKnOWTjLO5NeT2JI+C6yferOyGvM=;
 b=J+P71GLVvCMSpvWz4CW9TyibJ8hQFrvvhbxAIGdPPVsWp0s1nOZ7aXMsbh+NSn5Vjw
 fUNvRoux2UU1tYl9eKgBZDkevyBw3ppP64AhHSpxht3nCzeEroUSBxY7yOfUHCi1y1Tb
 PEfXTngsWodaNl9vJzRlpl0AV55fZuB+qjcm/wCI2n8p9meygUs/mHU1In1eVKr4cedi
 8V2DKds5OkSCgmupTx1hyRzk/mdouPtWhab2KXOR2NWA5jYshlISlKYyWzPlZn/dt/uj
 9gb9o19jZodmn2YuEYkGyo1VX24nWC5GaJn6/KaDUgIMbPNVU+IScqDmsFWoLYWmkRkT
 WjLg==
X-Gm-Message-State: AOJu0YzEN808JItmcOigaH+MEbdAGKGTpqypOALd59CziS4fnReGJgfU
 BH1biwcLGVdFTJLtjmeqCZ8LGV+rl+U1JGTG9mcHX0QvcPjfsGY40QRC2SZHlZLVJcK0c69jLpw
 MDFQ=
X-Gm-Gg: ASbGncvFNj1xt4ueMcb6PEMeymzwI1FpRXKMXvCeybug3ljkk8EbjSiSkMPYcb1beSi
 9pqN03SnwruPNloOXg90mVPEaLdeR5Gw7G797n3KBqpyoLS5pFnvgqso7EtJzTo5Rh7TZXBlj8X
 htC/u8pDdoes3OjoOg6SIQ6/rR/XMnGqDtAqUUEZh4sNabPM+gzHBYXbAa0q7T76mR7grY4CC+K
 Jj1YHGloa3O07jR1/zvLoM7Ozy5aIcMQLlc6AKFL8RQnln45ZE7Ecr5Rayrz5M0/09wcNHlsNOv
 Dl+RV7Ca6Ex9pk8aBD3Uh+CDTeF3r3s=
X-Google-Smtp-Source: AGHT+IFM3zuGQag9k4rwxHqBhBbd5BJNpopf3ZNNFpJuyPwHH7/QoNO1DI6s1WlCcu9rwjciIfUOIg==
X-Received: by 2002:a05:600c:3514:b0:434:a367:2bd9 with SMTP id
 5b1f17b1804b1-436e26a607fmr40625175e9.14.1736373146134; 
 Wed, 08 Jan 2025 13:52:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2ddcda3sm33842665e9.22.2025.01.08.13.52.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Jan 2025 13:52:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 06/14] tcg/loongarch64: Extract TCG_TARGET_HAS_foo defs to
 'tcg-target-has.h'
Date: Wed,  8 Jan 2025 22:51:47 +0100
Message-ID: <20250108215156.8731-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108215156.8731-1-philmd@linaro.org>
References: <20250107080112.1175095-19-richard.henderson@linaro.org>
 <20250108215156.8731-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
 tcg/loongarch64/tcg-target-has.h | 113 +++++++++++++++++++++++++++++++
 tcg/loongarch64/tcg-target.h     | 102 +---------------------------
 2 files changed, 114 insertions(+), 101 deletions(-)
 create mode 100644 tcg/loongarch64/tcg-target-has.h

diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
new file mode 100644
index 00000000000..e4333c36c65
--- /dev/null
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Define target-specific opcode support
+ * Copyright (c) 2021 WANG Xuerui <git@xen0n.name>
+ */
+
+#ifndef TCG_TARGET_HAS_H
+#define TCG_TARGET_HAS_H
+
+#include "host/cpuinfo.h"
+
+/* optional instructions */
+#define TCG_TARGET_HAS_negsetcond_i32   0
+#define TCG_TARGET_HAS_div_i32          1
+#define TCG_TARGET_HAS_rem_i32          1
+#define TCG_TARGET_HAS_div2_i32         0
+#define TCG_TARGET_HAS_rot_i32          1
+#define TCG_TARGET_HAS_deposit_i32      1
+#define TCG_TARGET_HAS_extract_i32      1
+#define TCG_TARGET_HAS_sextract_i32     0
+#define TCG_TARGET_HAS_extract2_i32     0
+#define TCG_TARGET_HAS_add2_i32         0
+#define TCG_TARGET_HAS_sub2_i32         0
+#define TCG_TARGET_HAS_mulu2_i32        0
+#define TCG_TARGET_HAS_muls2_i32        0
+#define TCG_TARGET_HAS_muluh_i32        1
+#define TCG_TARGET_HAS_mulsh_i32        1
+#define TCG_TARGET_HAS_ext8s_i32        1
+#define TCG_TARGET_HAS_ext16s_i32       1
+#define TCG_TARGET_HAS_ext8u_i32        1
+#define TCG_TARGET_HAS_ext16u_i32       1
+#define TCG_TARGET_HAS_bswap16_i32      1
+#define TCG_TARGET_HAS_bswap32_i32      1
+#define TCG_TARGET_HAS_not_i32          1
+#define TCG_TARGET_HAS_andc_i32         1
+#define TCG_TARGET_HAS_orc_i32          1
+#define TCG_TARGET_HAS_eqv_i32          0
+#define TCG_TARGET_HAS_nand_i32         0
+#define TCG_TARGET_HAS_nor_i32          1
+#define TCG_TARGET_HAS_clz_i32          1
+#define TCG_TARGET_HAS_ctz_i32          1
+#define TCG_TARGET_HAS_ctpop_i32        0
+#define TCG_TARGET_HAS_brcond2          0
+#define TCG_TARGET_HAS_setcond2         0
+#define TCG_TARGET_HAS_qemu_st8_i32     0
+
+/* 64-bit operations */
+#define TCG_TARGET_HAS_negsetcond_i64   0
+#define TCG_TARGET_HAS_div_i64          1
+#define TCG_TARGET_HAS_rem_i64          1
+#define TCG_TARGET_HAS_div2_i64         0
+#define TCG_TARGET_HAS_rot_i64          1
+#define TCG_TARGET_HAS_deposit_i64      1
+#define TCG_TARGET_HAS_extract_i64      1
+#define TCG_TARGET_HAS_sextract_i64     0
+#define TCG_TARGET_HAS_extract2_i64     0
+#define TCG_TARGET_HAS_extr_i64_i32     1
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
+#define TCG_TARGET_HAS_andc_i64         1
+#define TCG_TARGET_HAS_orc_i64          1
+#define TCG_TARGET_HAS_eqv_i64          0
+#define TCG_TARGET_HAS_nand_i64         0
+#define TCG_TARGET_HAS_nor_i64          1
+#define TCG_TARGET_HAS_clz_i64          1
+#define TCG_TARGET_HAS_ctz_i64          1
+#define TCG_TARGET_HAS_ctpop_i64        0
+#define TCG_TARGET_HAS_add2_i64         0
+#define TCG_TARGET_HAS_sub2_i64         0
+#define TCG_TARGET_HAS_mulu2_i64        0
+#define TCG_TARGET_HAS_muls2_i64        0
+#define TCG_TARGET_HAS_muluh_i64        1
+#define TCG_TARGET_HAS_mulsh_i64        1
+
+#define TCG_TARGET_HAS_qemu_ldst_i128   (cpuinfo & CPUINFO_LSX)
+
+#define TCG_TARGET_HAS_tst              0
+
+#define TCG_TARGET_HAS_v64              (cpuinfo & CPUINFO_LSX)
+#define TCG_TARGET_HAS_v128             (cpuinfo & CPUINFO_LSX)
+#define TCG_TARGET_HAS_v256             (cpuinfo & CPUINFO_LASX)
+
+#define TCG_TARGET_HAS_not_vec          1
+#define TCG_TARGET_HAS_neg_vec          1
+#define TCG_TARGET_HAS_abs_vec          0
+#define TCG_TARGET_HAS_andc_vec         1
+#define TCG_TARGET_HAS_orc_vec          1
+#define TCG_TARGET_HAS_nand_vec         0
+#define TCG_TARGET_HAS_nor_vec          1
+#define TCG_TARGET_HAS_eqv_vec          0
+#define TCG_TARGET_HAS_mul_vec          1
+#define TCG_TARGET_HAS_shi_vec          1
+#define TCG_TARGET_HAS_shs_vec          0
+#define TCG_TARGET_HAS_shv_vec          1
+#define TCG_TARGET_HAS_roti_vec         1
+#define TCG_TARGET_HAS_rots_vec         0
+#define TCG_TARGET_HAS_rotv_vec         1
+#define TCG_TARGET_HAS_sat_vec          1
+#define TCG_TARGET_HAS_minmax_vec       1
+#define TCG_TARGET_HAS_bitsel_vec       1
+#define TCG_TARGET_HAS_cmpsel_vec       0
+#define TCG_TARGET_HAS_tst_vec          0
+
+
+#endif
diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 3bc9aafaf24..a3a6130720b 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -29,8 +29,6 @@
 #ifndef LOONGARCH_TCG_TARGET_H
 #define LOONGARCH_TCG_TARGET_H
 
-#include "host/cpuinfo.h"
-
 #define TCG_TARGET_INSN_UNIT_SIZE 4
 #define TCG_TARGET_NB_REGS 64
 
@@ -87,105 +85,7 @@ typedef enum {
     TCG_VEC_TMP0 = TCG_REG_V23,
 } TCGReg;
 
-/* optional instructions */
-#define TCG_TARGET_HAS_negsetcond_i32   0
-#define TCG_TARGET_HAS_div_i32          1
-#define TCG_TARGET_HAS_rem_i32          1
-#define TCG_TARGET_HAS_div2_i32         0
-#define TCG_TARGET_HAS_rot_i32          1
-#define TCG_TARGET_HAS_deposit_i32      1
-#define TCG_TARGET_HAS_extract_i32      1
-#define TCG_TARGET_HAS_sextract_i32     0
-#define TCG_TARGET_HAS_extract2_i32     0
-#define TCG_TARGET_HAS_add2_i32         0
-#define TCG_TARGET_HAS_sub2_i32         0
-#define TCG_TARGET_HAS_mulu2_i32        0
-#define TCG_TARGET_HAS_muls2_i32        0
-#define TCG_TARGET_HAS_muluh_i32        1
-#define TCG_TARGET_HAS_mulsh_i32        1
-#define TCG_TARGET_HAS_ext8s_i32        1
-#define TCG_TARGET_HAS_ext16s_i32       1
-#define TCG_TARGET_HAS_ext8u_i32        1
-#define TCG_TARGET_HAS_ext16u_i32       1
-#define TCG_TARGET_HAS_bswap16_i32      1
-#define TCG_TARGET_HAS_bswap32_i32      1
-#define TCG_TARGET_HAS_not_i32          1
-#define TCG_TARGET_HAS_andc_i32         1
-#define TCG_TARGET_HAS_orc_i32          1
-#define TCG_TARGET_HAS_eqv_i32          0
-#define TCG_TARGET_HAS_nand_i32         0
-#define TCG_TARGET_HAS_nor_i32          1
-#define TCG_TARGET_HAS_clz_i32          1
-#define TCG_TARGET_HAS_ctz_i32          1
-#define TCG_TARGET_HAS_ctpop_i32        0
-#define TCG_TARGET_HAS_brcond2          0
-#define TCG_TARGET_HAS_setcond2         0
-#define TCG_TARGET_HAS_qemu_st8_i32     0
-
-/* 64-bit operations */
-#define TCG_TARGET_HAS_negsetcond_i64   0
-#define TCG_TARGET_HAS_div_i64          1
-#define TCG_TARGET_HAS_rem_i64          1
-#define TCG_TARGET_HAS_div2_i64         0
-#define TCG_TARGET_HAS_rot_i64          1
-#define TCG_TARGET_HAS_deposit_i64      1
-#define TCG_TARGET_HAS_extract_i64      1
-#define TCG_TARGET_HAS_sextract_i64     0
-#define TCG_TARGET_HAS_extract2_i64     0
-#define TCG_TARGET_HAS_extr_i64_i32     1
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
-#define TCG_TARGET_HAS_andc_i64         1
-#define TCG_TARGET_HAS_orc_i64          1
-#define TCG_TARGET_HAS_eqv_i64          0
-#define TCG_TARGET_HAS_nand_i64         0
-#define TCG_TARGET_HAS_nor_i64          1
-#define TCG_TARGET_HAS_clz_i64          1
-#define TCG_TARGET_HAS_ctz_i64          1
-#define TCG_TARGET_HAS_ctpop_i64        0
-#define TCG_TARGET_HAS_add2_i64         0
-#define TCG_TARGET_HAS_sub2_i64         0
-#define TCG_TARGET_HAS_mulu2_i64        0
-#define TCG_TARGET_HAS_muls2_i64        0
-#define TCG_TARGET_HAS_muluh_i64        1
-#define TCG_TARGET_HAS_mulsh_i64        1
-
-#define TCG_TARGET_HAS_qemu_ldst_i128   (cpuinfo & CPUINFO_LSX)
-
-#define TCG_TARGET_HAS_tst              0
-
-#define TCG_TARGET_HAS_v64              (cpuinfo & CPUINFO_LSX)
-#define TCG_TARGET_HAS_v128             (cpuinfo & CPUINFO_LSX)
-#define TCG_TARGET_HAS_v256             (cpuinfo & CPUINFO_LASX)
-
-#define TCG_TARGET_HAS_not_vec          1
-#define TCG_TARGET_HAS_neg_vec          1
-#define TCG_TARGET_HAS_abs_vec          0
-#define TCG_TARGET_HAS_andc_vec         1
-#define TCG_TARGET_HAS_orc_vec          1
-#define TCG_TARGET_HAS_nand_vec         0
-#define TCG_TARGET_HAS_nor_vec          1
-#define TCG_TARGET_HAS_eqv_vec          0
-#define TCG_TARGET_HAS_mul_vec          1
-#define TCG_TARGET_HAS_shi_vec          1
-#define TCG_TARGET_HAS_shs_vec          0
-#define TCG_TARGET_HAS_shv_vec          1
-#define TCG_TARGET_HAS_roti_vec         1
-#define TCG_TARGET_HAS_rots_vec         0
-#define TCG_TARGET_HAS_rotv_vec         1
-#define TCG_TARGET_HAS_sat_vec          1
-#define TCG_TARGET_HAS_minmax_vec       1
-#define TCG_TARGET_HAS_bitsel_vec       1
-#define TCG_TARGET_HAS_cmpsel_vec       0
-#define TCG_TARGET_HAS_tst_vec          0
+#include "tcg-target-has.h"
 
 #define TCG_TARGET_DEFAULT_MO (0)
 
-- 
2.47.1


