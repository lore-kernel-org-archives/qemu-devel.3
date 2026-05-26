Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC94CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 20:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRyYZ-0002EE-O7; Tue, 26 May 2026 16:39:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyY2-0001IG-6K
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:38:55 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRyXm-0007R2-MC
 for qemu-devel@nongnu.org; Tue, 26 May 2026 16:38:38 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-44a14580111so8191523f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 13:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779827909; x=1780432709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fySK/xScTn2CZ3lKGQIypYJIa/hnhOcCOUTh8N5ka8Q=;
 b=uZlN985dAhl+zaoT+NXTclljGc4EcRddJzZP/ZPXUdplRomMPnXRab0FIUzPmjY87z
 L1pTipltgOsuv7/FZ0D29x5tTY0g3tJPkGK3sXhmxTz43GDu4MSur8vWaNe/y9h1lfGA
 DWNlklMy3KIuX9sZpGzRB1JGdKcU0gYZqCRLV7l7QK/2voxB2G9UREbaiTqTa5HxsuNc
 Ef5EjJobHWLlH4T1Au7PcbjzOB8TjKJJQ9FHIc0WqY2ta8KQURLcgKc0acQe8AA1r6Wl
 R5sUvO3F9RznMY2DEHueSMZo2BcqRqmGl4c/G3x+jQaMSblRyVF0eHjl8pYbSkZPUUaI
 4jyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779827909; x=1780432709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fySK/xScTn2CZ3lKGQIypYJIa/hnhOcCOUTh8N5ka8Q=;
 b=CoSxm3sQS5DUTNj8oyRnb249vGGuXC1kWfP8Tkj2d6gkotlC4idvF9LRZ1Ys1z+7+z
 18m03OEED1AG50U4f1lhEbYht9ehEd3dnXQ9KcFiMTxqSpEkyhFTmEhMbRkE4nbv/PaQ
 nDwRjeUuffkXsKzxTbTmvzStAWYQ/ScXyq07hL7sc2qQZiwJA9Wzx8x5Mn61XAC8XROc
 NoXHoTV9+O6m/ZeqphdkTnEksbLwYUY5JGryyg95Cc3z0xGkPfh2jRHvhBnHqhasvH9P
 RnVLhx+xCSotDCHGafP/u8EIJ+zNI4BPZ1J9zCU2HoJAkvkV6lOQYiRpA49qwXCMQGoc
 gr1Q==
X-Gm-Message-State: AOJu0YyxssQjGzwhbe1fzR1sXAQCLTvIO0bK8LK/EVH74xWKkIYJ6RlX
 cLbC83r+j8c+8N5tuyPbY0VZqfOHG4vkPkgs80JFBjbFoFsraoX1/tdNpcwb8ZaaXI60POScADW
 H+MDcItWSeA==
X-Gm-Gg: Acq92OG82k0WjR4wzQNLx8sjG5DIVSoFIpFc98U+IQ6GkS5Sfv3eo4QlUDF2w6wTyvg
 BhUvexX7yxhXY9auc5NoVPotp/tklJKLfAyRLKZC+iXNd88SfpplY+kGV4pKaRqzvKiTb/rR+uB
 wblLfaCsh9aZqFbDglBoPAjg1Tw9CC+qRkMi69W5vkQQ+VvpW9SiLDlaLCzUiUqZ7W7YSB9Q2Az
 ROTdNxHRWKhu1pUZGkbYxTYo/ef+JVgfvwCYu/5YL7oRlY1mGp9O6j2NYo200cFx3QSnlns2eDz
 yPfy2i5lDwn55zrTihaj9wVf2Ld1k6uZm1SJlJE7a4n257Z9TgSasMN0Qaac9qXNQKhEW/QODHY
 A4CgAi3s045evUetoMfP7E1elgKzY4C+LMtnEZBqrA6uUuJg9pYE9PQwZsmnS1TXmk2U4DUy+sn
 Dgy9D9CMGYpj/clMm3y/PSKDBN9o6mMqfOC+AMbNkbG6MI2dWpDnkKMiU=
X-Received: by 2002:a05:6000:41f9:b0:43d:7946:baee with SMTP id
 ffacd0b85a97d-45eb38af423mr30700185f8f.23.1779827908587; 
 Tue, 26 May 2026 13:38:28 -0700 (PDT)
Received: from m17.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb54a3c3sm804946f8f.8.2026.05.26.13.38.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 May 2026 13:38:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 09/17] target/arm: Extract common code related to 'max' CPU
Date: Tue, 26 May 2026 22:37:14 +0200
Message-ID: <20260526203722.79463-10-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526203722.79463-1-philmd@linaro.org>
References: <20260526203722.79463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Extract common code related to 'max' CPU. This commit only
move code used by the 32-bit 'max' CPU, but we will soon add
the 64-bit counterpart, so name it generically as "cpu-max.c".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu-max.c   | 106 +++++++++++++++++++++++++++++++++++++++++
 target/arm/tcg/cpu32.c |  96 -------------------------------------
 target/arm/meson.build |   1 +
 3 files changed, 107 insertions(+), 96 deletions(-)
 create mode 100644 target/arm/cpu-max.c

diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
new file mode 100644
index 00000000000..9fd48ce46e2
--- /dev/null
+++ b/target/arm/cpu-max.c
@@ -0,0 +1,106 @@
+/*
+ * QEMU ARM 'max' CPU
+ *
+ * Copyright (c) 2018 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "target/arm/internals.h"
+
+/* Share AArch32 -cpu max features with AArch64. */
+void aa32_max_features(ARMCPU *cpu)
+{
+    uint32_t t;
+    ARMISARegisters *isar = &cpu->isar;
+
+    /* Add additional features supported by QEMU */
+    t = GET_IDREG(isar, ID_ISAR5);
+    t = FIELD_DP32(t, ID_ISAR5, AES, 2);          /* FEAT_PMULL */
+    t = FIELD_DP32(t, ID_ISAR5, SHA1, 1);         /* FEAT_SHA1 */
+    t = FIELD_DP32(t, ID_ISAR5, SHA2, 1);         /* FEAT_SHA256 */
+    t = FIELD_DP32(t, ID_ISAR5, CRC32, 1);
+    t = FIELD_DP32(t, ID_ISAR5, RDM, 1);          /* FEAT_RDM */
+    t = FIELD_DP32(t, ID_ISAR5, VCMA, 1);         /* FEAT_FCMA */
+    SET_IDREG(isar, ID_ISAR5, t);
+
+    t = GET_IDREG(isar, ID_ISAR6);
+    t = FIELD_DP32(t, ID_ISAR6, JSCVT, 1);        /* FEAT_JSCVT */
+    t = FIELD_DP32(t, ID_ISAR6, DP, 1);           /* Feat_DotProd */
+    t = FIELD_DP32(t, ID_ISAR6, FHM, 1);          /* FEAT_FHM */
+    t = FIELD_DP32(t, ID_ISAR6, SB, 1);           /* FEAT_SB */
+    t = FIELD_DP32(t, ID_ISAR6, SPECRES, 1);      /* FEAT_SPECRES */
+    t = FIELD_DP32(t, ID_ISAR6, BF16, 1);         /* FEAT_AA32BF16 */
+    t = FIELD_DP32(t, ID_ISAR6, I8MM, 1);         /* FEAT_AA32I8MM */
+    SET_IDREG(isar, ID_ISAR6, t);
+
+    t = cpu->isar.mvfr1;
+    t = FIELD_DP32(t, MVFR1, FPHP, 3);            /* FEAT_FP16 */
+    t = FIELD_DP32(t, MVFR1, SIMDHP, 2);          /* FEAT_FP16 */
+    cpu->isar.mvfr1 = t;
+
+    t = cpu->isar.mvfr2;
+    t = FIELD_DP32(t, MVFR2, SIMDMISC, 3);        /* SIMD MaxNum */
+    t = FIELD_DP32(t, MVFR2, FPMISC, 4);          /* FP MaxNum */
+    cpu->isar.mvfr2 = t;
+
+    FIELD_DP32_IDREG(isar, ID_MMFR3, PAN, 2);          /* FEAT_PAN2 */
+
+    t = GET_IDREG(isar, ID_MMFR4);
+    t = FIELD_DP32(t, ID_MMFR4, HPDS, 2);         /* FEAT_HPDS2 */
+    t = FIELD_DP32(t, ID_MMFR4, AC2, 1);          /* ACTLR2, HACTLR2 */
+    t = FIELD_DP32(t, ID_MMFR4, CNP, 1);          /* FEAT_TTCNP */
+    t = FIELD_DP32(t, ID_MMFR4, XNX, 1);          /* FEAT_XNX */
+    t = FIELD_DP32(t, ID_MMFR4, EVT, 2);          /* FEAT_EVT */
+    SET_IDREG(isar, ID_MMFR4, t);
+
+    FIELD_DP32_IDREG(isar, ID_MMFR5, ETS, 2);          /* FEAT_ETS2 */
+
+    t = GET_IDREG(isar, ID_PFR0);
+    t = FIELD_DP32(t, ID_PFR0, CSV2, 2);          /* FEAT_CSV2 */
+    t = FIELD_DP32(t, ID_PFR0, DIT, 1);           /* FEAT_DIT */
+    t = FIELD_DP32(t, ID_PFR0, RAS, 1);           /* FEAT_RAS */
+    SET_IDREG(isar, ID_PFR0, t);
+
+    t = GET_IDREG(isar, ID_PFR2);
+    t = FIELD_DP32(t, ID_PFR2, CSV3, 1);          /* FEAT_CSV3 */
+    t = FIELD_DP32(t, ID_PFR2, SSBS, 1);          /* FEAT_SSBS */
+    SET_IDREG(isar, ID_PFR2, t);
+
+    t = GET_IDREG(isar, ID_DFR0);
+    t = FIELD_DP32(t, ID_DFR0, COPDBG, 10);       /* FEAT_Debugv8p8 */
+    t = FIELD_DP32(t, ID_DFR0, COPSDBG, 10);      /* FEAT_Debugv8p8 */
+    t = FIELD_DP32(t, ID_DFR0, PERFMON, 6);       /* FEAT_PMUv3p5 */
+    SET_IDREG(isar, ID_DFR0, t);
+
+    /* Debug ID registers. */
+
+    /* Bit[15] is RES1, Bit[13] and Bits[11:0] are RES0. */
+    t = 0x00008000;
+    t = FIELD_DP32(t, DBGDIDR, SE_IMP, 1);
+    t = FIELD_DP32(t, DBGDIDR, NSUHD_IMP, 1);
+    t = FIELD_DP32(t, DBGDIDR, VERSION, 10);      /* FEAT_Debugv8p8 */
+    t = FIELD_DP32(t, DBGDIDR, CTX_CMPS, 1);
+    t = FIELD_DP32(t, DBGDIDR, BRPS, 5);
+    t = FIELD_DP32(t, DBGDIDR, WRPS, 3);
+    cpu->isar.dbgdidr = t;
+
+    t = 0;
+    t = FIELD_DP32(t, DBGDEVID, PCSAMPLE, 3);
+    t = FIELD_DP32(t, DBGDEVID, WPADDRMASK, 1);
+    t = FIELD_DP32(t, DBGDEVID, BPADDRMASK, 15);
+    t = FIELD_DP32(t, DBGDEVID, VECTORCATCH, 0);
+    t = FIELD_DP32(t, DBGDEVID, VIRTEXTNS, 1);
+    t = FIELD_DP32(t, DBGDEVID, DOUBLELOCK, 1);
+    t = FIELD_DP32(t, DBGDEVID, AUXREGS, 0);
+    t = FIELD_DP32(t, DBGDEVID, CIDMASK, 0);
+    cpu->isar.dbgdevid = t;
+
+    /* Bits[31:4] are RES0. */
+    t = 0;
+    t = FIELD_DP32(t, DBGDEVID1, PCSROFFSET, 2);
+    cpu->isar.dbgdevid1 = t;
+
+    FIELD_DP32_IDREG(isar, ID_DFR1, HPMN0, 1);         /* FEAT_HPMN0 */
+}
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 73d21c6cf7d..919ed8a6cf8 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -18,102 +18,6 @@
 #include "cpregs.h"
 
 
-/* Share AArch32 -cpu max features with AArch64. */
-void aa32_max_features(ARMCPU *cpu)
-{
-    uint32_t t;
-    ARMISARegisters *isar = &cpu->isar;
-
-    /* Add additional features supported by QEMU */
-    t = GET_IDREG(isar, ID_ISAR5);
-    t = FIELD_DP32(t, ID_ISAR5, AES, 2);          /* FEAT_PMULL */
-    t = FIELD_DP32(t, ID_ISAR5, SHA1, 1);         /* FEAT_SHA1 */
-    t = FIELD_DP32(t, ID_ISAR5, SHA2, 1);         /* FEAT_SHA256 */
-    t = FIELD_DP32(t, ID_ISAR5, CRC32, 1);
-    t = FIELD_DP32(t, ID_ISAR5, RDM, 1);          /* FEAT_RDM */
-    t = FIELD_DP32(t, ID_ISAR5, VCMA, 1);         /* FEAT_FCMA */
-    SET_IDREG(isar, ID_ISAR5, t);
-
-    t = GET_IDREG(isar, ID_ISAR6);
-    t = FIELD_DP32(t, ID_ISAR6, JSCVT, 1);        /* FEAT_JSCVT */
-    t = FIELD_DP32(t, ID_ISAR6, DP, 1);           /* Feat_DotProd */
-    t = FIELD_DP32(t, ID_ISAR6, FHM, 1);          /* FEAT_FHM */
-    t = FIELD_DP32(t, ID_ISAR6, SB, 1);           /* FEAT_SB */
-    t = FIELD_DP32(t, ID_ISAR6, SPECRES, 1);      /* FEAT_SPECRES */
-    t = FIELD_DP32(t, ID_ISAR6, BF16, 1);         /* FEAT_AA32BF16 */
-    t = FIELD_DP32(t, ID_ISAR6, I8MM, 1);         /* FEAT_AA32I8MM */
-    SET_IDREG(isar, ID_ISAR6, t);
-
-    t = cpu->isar.mvfr1;
-    t = FIELD_DP32(t, MVFR1, FPHP, 3);            /* FEAT_FP16 */
-    t = FIELD_DP32(t, MVFR1, SIMDHP, 2);          /* FEAT_FP16 */
-    cpu->isar.mvfr1 = t;
-
-    t = cpu->isar.mvfr2;
-    t = FIELD_DP32(t, MVFR2, SIMDMISC, 3);        /* SIMD MaxNum */
-    t = FIELD_DP32(t, MVFR2, FPMISC, 4);          /* FP MaxNum */
-    cpu->isar.mvfr2 = t;
-
-    FIELD_DP32_IDREG(isar, ID_MMFR3, PAN, 2);          /* FEAT_PAN2 */
-
-    t = GET_IDREG(isar, ID_MMFR4);
-    t = FIELD_DP32(t, ID_MMFR4, HPDS, 2);         /* FEAT_HPDS2 */
-    t = FIELD_DP32(t, ID_MMFR4, AC2, 1);          /* ACTLR2, HACTLR2 */
-    t = FIELD_DP32(t, ID_MMFR4, CNP, 1);          /* FEAT_TTCNP */
-    t = FIELD_DP32(t, ID_MMFR4, XNX, 1);          /* FEAT_XNX */
-    t = FIELD_DP32(t, ID_MMFR4, EVT, 2);          /* FEAT_EVT */
-    SET_IDREG(isar, ID_MMFR4, t);
-
-    FIELD_DP32_IDREG(isar, ID_MMFR5, ETS, 2);          /* FEAT_ETS2 */
-
-    t = GET_IDREG(isar, ID_PFR0);
-    t = FIELD_DP32(t, ID_PFR0, CSV2, 2);          /* FEAT_CSV2 */
-    t = FIELD_DP32(t, ID_PFR0, DIT, 1);           /* FEAT_DIT */
-    t = FIELD_DP32(t, ID_PFR0, RAS, 1);           /* FEAT_RAS */
-    SET_IDREG(isar, ID_PFR0, t);
-
-    t = GET_IDREG(isar, ID_PFR2);
-    t = FIELD_DP32(t, ID_PFR2, CSV3, 1);          /* FEAT_CSV3 */
-    t = FIELD_DP32(t, ID_PFR2, SSBS, 1);          /* FEAT_SSBS */
-    SET_IDREG(isar, ID_PFR2, t);
-
-    t = GET_IDREG(isar, ID_DFR0);
-    t = FIELD_DP32(t, ID_DFR0, COPDBG, 10);       /* FEAT_Debugv8p8 */
-    t = FIELD_DP32(t, ID_DFR0, COPSDBG, 10);      /* FEAT_Debugv8p8 */
-    t = FIELD_DP32(t, ID_DFR0, PERFMON, 6);       /* FEAT_PMUv3p5 */
-    SET_IDREG(isar, ID_DFR0, t);
-
-    /* Debug ID registers. */
-
-    /* Bit[15] is RES1, Bit[13] and Bits[11:0] are RES0. */
-    t = 0x00008000;
-    t = FIELD_DP32(t, DBGDIDR, SE_IMP, 1);
-    t = FIELD_DP32(t, DBGDIDR, NSUHD_IMP, 1);
-    t = FIELD_DP32(t, DBGDIDR, VERSION, 10);      /* FEAT_Debugv8p8 */
-    t = FIELD_DP32(t, DBGDIDR, CTX_CMPS, 1);
-    t = FIELD_DP32(t, DBGDIDR, BRPS, 5);
-    t = FIELD_DP32(t, DBGDIDR, WRPS, 3);
-    cpu->isar.dbgdidr = t;
-
-    t = 0;
-    t = FIELD_DP32(t, DBGDEVID, PCSAMPLE, 3);
-    t = FIELD_DP32(t, DBGDEVID, WPADDRMASK, 1);
-    t = FIELD_DP32(t, DBGDEVID, BPADDRMASK, 15);
-    t = FIELD_DP32(t, DBGDEVID, VECTORCATCH, 0);
-    t = FIELD_DP32(t, DBGDEVID, VIRTEXTNS, 1);
-    t = FIELD_DP32(t, DBGDEVID, DOUBLELOCK, 1);
-    t = FIELD_DP32(t, DBGDEVID, AUXREGS, 0);
-    t = FIELD_DP32(t, DBGDEVID, CIDMASK, 0);
-    cpu->isar.dbgdevid = t;
-
-    /* Bits[31:4] are RES0. */
-    t = 0;
-    t = FIELD_DP32(t, DBGDEVID1, PCSROFFSET, 2);
-    cpu->isar.dbgdevid1 = t;
-
-    FIELD_DP32_IDREG(isar, ID_DFR1, HPMN0, 1);         /* FEAT_HPMN0 */
-}
-
 /* CPU models. These are not needed for the AArch64 linux-user build. */
 #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
 
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 5376be2e3bc..3e02941d0d5 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -9,6 +9,7 @@ arm_user_ss = ss.source_set()
 arm_common_system_ss.add(files('gdbstub.c'))
 arm_user_ss.add(files('gdbstub.c'))
 
+arm_ss.add(files('cpu-max.c'))
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'cpu64.c',
 ))
-- 
2.53.0


