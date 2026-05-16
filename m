Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42C77CD4F21
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 17:17:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOIdV-0004NG-E1; Sat, 16 May 2026 13:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOIdO-0003ue-Ns
 for qemu-devel@nongnu.org; Sat, 16 May 2026 13:17:10 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOIdM-0008FK-Go
 for qemu-devel@nongnu.org; Sat, 16 May 2026 13:17:06 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so12715295e9.2
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 10:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778951822; x=1779556622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SDXabr5XNvsuIZqtdyV2diy9S67LIoK2rFOl6OVzvXw=;
 b=VtKemxTHy/zstbZkbQs6SFtVQ1Ln6e9RQRtu/VruCj16452nSfPXEFuL+Dx+LEcgLC
 DMg0Z6/HgcdgTIgYZAkdsKF3oxMlOfSidM2J+4E1Q+L+cmPciYHfDAPoKBDUfAmp862h
 yvTzTH8pJBdqxNEJaB1T3dDyHM6fjPdPMkoazPaij4ziCvfH+V9+u5qT6/q3Fzn9fS4X
 UDEdpmrnPoVGX7gipKZr+N/eKHpzl1FVwgIJcMRpGierUwkXUpWjfAXoItzWGJjCGBI7
 ISNuFqph+kBoCkpThaIVX0RbyHlCLknmnu/iAIZoqtAp/nwThrM6raZmQUWabFyV2/6x
 Lelw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778951822; x=1779556622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SDXabr5XNvsuIZqtdyV2diy9S67LIoK2rFOl6OVzvXw=;
 b=TC8o8QFNu+yu3MQtZndbfriYJQsDsWHIYhNCHwmYb+hoPMe7EIXRfN4/st5zSOTrXD
 wch4gt43ENuwYRR2IUlWFOgdo3qXE493Qx7bcHyzkaR3FTuaDNSXNZDtFDP1Jz0BLAf7
 GP4IYVmkEbAvEhxIhht9dM3ACjgYQlayWTIDGDyGgDFhDNEGnwgdyqQT6p/SwdQCJoIu
 cnzyx5/0C1PFfQdzy2aF1Y8Pjn6k0JHa16AIIk6MVNp4zSTe/c+lSuprQ9AwhClQoOMC
 q1EEE5q/d/Aki5C1/ESMF3QyxtNkr/MP/anQY7ecckAkMW0nIRSYAec7vX5MPkp+P3H5
 3D9g==
X-Gm-Message-State: AOJu0YxpaYjYK3kYeVg7xSEhKP+Ez/Y9ihfb1aePeQDsScXdA+FuPR4K
 jxV5fMRk4etCjSC46LD23XYNWRv7vv/Dry/ka497gxvOlV3omx9AXBGPe0YA+Ly2nKk7gpS6vT6
 fFt4h7E0=
X-Gm-Gg: Acq92OEiHqQ+GMyjcZ8TEpiMIIzQXVePAgxs1BOhmDnnAm+5z+vjRk6BNKta+b/6vyV
 X7/uqbsJrcy2GUv/jBF5p7g1vheT2ZykV5eN2KT6iQnnWhXbQaY4LeAvlWzSxbULqUuNvkUvjRC
 XPsRIfgMUI/r6jWSCKDpzYjkAZtQUjHrhD8p1NNJVFV1LvRoNRvKMdjXLBAzQgwQVloRnv/5Lt9
 B8L/jW7XapxZT51DGmjizex6ONpVp02zxNW6I6wxRXjgdIWy62SsOKMh8P+sY/DF1V9zZtH9w2M
 lWdduVN+G4amd9ESYnuaXqJX9MHBHvMraaYK5G1B+/FZ1Azl1qRC1NVUerjxV1GAg5TJw3HylZv
 cEfMPw5LNQhBTK/WjGZCB6wXi/lUL2dZqy8qOfU5Tgv2wRrc8W656LNqvz/spAPRPtqgrC5OM0S
 +CbelafPmUUjw4voleoN4btrFLJLhmB32ef03Y/h3IsoByA0irkfi5c5l6ihcxqC5XElkb+O+A
X-Received: by 2002:a05:600c:46ce:b0:48f:d2b5:d7 with SMTP id
 5b1f17b1804b1-48fe60edd2dmr119506495e9.12.1778951822353; 
 Sat, 16 May 2026 10:17:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe0fecsm21690570f8f.26.2026.05.16.10.17.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 16 May 2026 10:17:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Joel Stanley <joel@jms.id.au>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Troy Lee <leetroy@gmail.com>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v7 13/21] target/arm: Extract common code related to 'max' CPU
Date: Sat, 16 May 2026 19:15:15 +0200
Message-ID: <20260516171524.19184-14-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516171524.19184-1-philmd@linaro.org>
References: <20260516171524.19184-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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


