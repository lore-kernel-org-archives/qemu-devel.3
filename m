Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C382CC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 18:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLo8K-0002an-I3; Mon, 24 Jun 2024 14:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLo8G-0002aP-9f
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 14:09:37 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sLo8E-0005Vs-Ln
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 14:09:36 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-70667943931so1495787b3a.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 11:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719252573; x=1719857373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PeBqa9wCvLcPCNESG68oA900Bm6fWP80a5dR02zC61U=;
 b=L+5E4Yil/kqaKoDKacCVsSdOEyvG05MCBi8JYKPNBBB602a2Qto+tBJeEV9ZYxFKTL
 D4IWKIpMXADBQCHilzp0C/T4jbXNM10GnBeoKucp9OrnrnI+aVTcseT2aS4fz+/+9uDk
 Eo1xKrYAxZY9uM2H2yE3RNexv6nHmEaTrlf8+u+n52oFuhCDaPZfLkK9+gY0Vf0Au2Nk
 8iWcD/fgRvIf/B2gisPA7N1nwhnP3RdeFvv3eh+Wd+rd7mH9EdFmaval8xm27t/6dENW
 tiHCuu/ejRFR/K10L92BIL6Akf0V9El/nAixQE6GCM3l3QEoYGaz0yTtUnoyScT2wDWx
 7Uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719252573; x=1719857373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PeBqa9wCvLcPCNESG68oA900Bm6fWP80a5dR02zC61U=;
 b=ffmskbdqX68lTpie5fDtcjASsPcr7e7sfqnwyCLSt+uGS4+iUiMILf5VXhxXMFOGVh
 rjOf7steYms3gWKEOkZjr5wBUuER+5jZa7JHrIER6Rolyqbhb8pP407b1+kCZJmOPyDp
 /5vMNALYDwJ7Nj2pesIBQ5PPtU6j/06tVzp2a4mdc+m6WBmEU8W09MlYGtnZg7ChbWPV
 cSmQ1L0i3E+JBPkPR/Aba+QD2wHg7MBi/jOGNdqotNpitV0pyQ+jVLsPR0Wn2ptTwpCF
 1OfgzHmv8y246ne+qLVNkaoXE/FalkhFNFSv6k1/X1TbCnfn7/5OGTYTvb1/JF2gSo1I
 5y3A==
X-Gm-Message-State: AOJu0Yz0IAQ26Y8IC+msqMKl+I8gI1nhVbtH5TOgHU5lsCid7oIkETiJ
 i7lFd9SjEk4YJqhv8pHMnpGQcpxmMqv2EhSy/rnJxbk35NMlqZx9UFroscHgLj8r0IjBCDTdw2i
 P
X-Google-Smtp-Source: AGHT+IGCGK6Cj2pLM9Jpmdvm8YTLKDOpTxyuMvdj+n6VjFYHrGFx3jqSKfzzzINB0QOW/PYDCAmc2w==
X-Received: by 2002:aa7:8517:0:b0:706:6f18:839d with SMTP id
 d2e1a72fcca58-706745be097mr5080272b3a.14.1719252572972; 
 Mon, 24 Jun 2024 11:09:32 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:1758:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706666e9708sm4974942b3a.121.2024.06.24.11.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 11:09:32 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org
Cc: philmd@linaro.org,
	alex.bennee@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v3 2/3] target/arm: Move initialization of debug ID registers
Date: Mon, 24 Jun 2024 18:09:14 +0000
Message-Id: <20240624180915.4528-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240624180915.4528-1-gustavo.romero@linaro.org>
References: <20240624180915.4528-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42e.google.com
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

Move the initialization of the debug ID registers to aa32_max_features,
which is used to set the 32-bit ID registers. This ensures that the
debug ID registers are consistently set for the max CPU in a single
place.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h       |  2 ++
 target/arm/tcg/cpu32.c | 31 ++++++++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 3841359d0f..d8eb986a04 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2299,6 +2299,8 @@ FIELD(DBGDEVID, DOUBLELOCK, 20, 4)
 FIELD(DBGDEVID, AUXREGS, 24, 4)
 FIELD(DBGDEVID, CIDMASK, 28, 4)
 
+FIELD(DBGDEVID1, PCSROFFSET, 0, 4)
+
 FIELD(MVFR0, SIMDREG, 0, 4)
 FIELD(MVFR0, FPSP, 4, 4)
 FIELD(MVFR0, FPDP, 8, 4)
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index bdd82d912a..28a5c033bb 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -87,6 +87,34 @@ void aa32_max_features(ARMCPU *cpu)
     t = FIELD_DP32(t, ID_DFR0, PERFMON, 6);       /* FEAT_PMUv3p5 */
     cpu->isar.id_dfr0 = t;
 
+    /* Debug ID registers. */
+
+    /* Bit[15] is RES1, Bit[13] and Bits[11:0] are RES0. */
+    t = 0x00008000;
+    t = FIELD_DP32(t, DBGDIDR, SE_IMP, 1);
+    t = FIELD_DP32(t, DBGDIDR, NSUHD_IMP, 1);
+    t = FIELD_DP32(t, DBGDIDR, VERSION, 6);       /* Armv8 debug */
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
     t = cpu->isar.id_dfr1;
     t = FIELD_DP32(t, ID_DFR1, HPMN0, 1);         /* FEAT_HPMN0 */
     cpu->isar.id_dfr1 = t;
@@ -955,9 +983,6 @@ static void arm_max_initfn(Object *obj)
     cpu->isar.id_isar4 = 0x00011142;
     cpu->isar.id_isar5 = 0x00011121;
     cpu->isar.id_isar6 = 0;
-    cpu->isar.dbgdidr = 0x3516d000;
-    cpu->isar.dbgdevid = 0x00110f13;
-    cpu->isar.dbgdevid1 = 0x2;
     cpu->isar.reset_pmcr_el0 = 0x41013000;
     cpu->clidr = 0x0a200023;
     cpu->ccsidr[0] = 0x701fe00a; /* 32KB L1 dcache */
-- 
2.34.1


