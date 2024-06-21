Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842C4C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 14:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKfQV-0006pm-Ht; Fri, 21 Jun 2024 10:39:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sKfQT-0006pD-8v
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:39:41 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sKfQR-0007xu-Eb
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:39:40 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7041053c0fdso1510558b3a.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 07:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718980778; x=1719585578; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pbW4VmHlRcXOaBBuGCKxn/sE/2fViPqLSFr+O68nhEo=;
 b=WxNOYfvvAXintAio7+uvQcUpcQQpzCP+z7OnQrjbpwohxsCZOlf2JE4yuD9g+PtXCV
 AyhqDB73M1bcOaAYbpjSbL8Ht9AhoCxZ3lbbxj66qFDyBQYj1jb4OOTr7Shhuy51JjqQ
 KL/pn4hvyGk4RYE/yKZmdADcp4rN2nervkBLmSs4A4CJObw+2N08lagBIil/TRmScJQs
 HZ9hc26E/CDZdf+cC4lILxVeTTYi3IyR7516hSB6FQME8EvmsSClHKYWpHigY09k6Axc
 H6kJkXyfl8f12xLUmvS7bhLjPeh1TIJ7ZJHBmdqVvo3O4Iclv5V1Ii7xoA6xW2KBBDh6
 p+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718980778; x=1719585578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pbW4VmHlRcXOaBBuGCKxn/sE/2fViPqLSFr+O68nhEo=;
 b=OXwogNAXZinoTe1LzfqnuhBMFi2m143nI0QcHa6wpNa2rGflMt9oKGR0+cFWXaMAkw
 RJKQ2sPB/YyOUyyELZeHJrzPVgJrUzsKEIq8Bkm8tRTok+or2PvUs2k7c+GPDrLaaVKJ
 ad5/+9zkLEB7fjWvHXgr/FFkROL/JIUMOE0hh95QCYZRzbwljbsgJbLSxiERXDd19/Zk
 TvXyGXztxKuLql9cEhI7coAkRgtjsrnwAox1la/zRATyIsVPMhcst1Du5XqfLAYZZodd
 4z5rZmzhc1C6iji7QmwdNUsj1QcypOPmdzy6hLY/282kb6hf8buvCNYRIdXDVCCc51uG
 KnZQ==
X-Gm-Message-State: AOJu0YwbggK/AG1ldj965OglExGX8lmktYUJxoEPbIgirRbZOM/dUadD
 Y5mY4glxWKVA4Q7yn17nDLF2vI+V7PPHc5xAJ+GzIbG3I/R7XKxC/c7xWSMSs/Hw+JnF6ayyxlb
 pp/A=
X-Google-Smtp-Source: AGHT+IGDzPLTZJ+ZyBvyT59inRM7G/nSyZkGJRS7o5jFWQYArBuKTJLtJ9TMVYI+S8oUHqoTcidnYQ==
X-Received: by 2002:a05:6a20:891f:b0:1b4:1560:f80f with SMTP id
 adf61e73a8af0-1bcbb697107mr8106408637.56.1718980777558; 
 Fri, 21 Jun 2024 07:39:37 -0700 (PDT)
Received: from amd.. ([2804:7f0:b401:1654:3e7c:3fff:fe7a:e83b])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7065130e8e2sm1466513b3a.215.2024.06.21.07.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 07:39:37 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org, alex.bennee@linaro.org, richard.henderson@linaro.org
Cc: philmd@linaro.org,
	peter.maydell@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v2 1/2] target/arm: Move initialization of debug ID registers
Date: Fri, 21 Jun 2024 14:39:02 +0000
Message-Id: <20240621143903.3598230-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621143903.3598230-1-gustavo.romero@linaro.org>
References: <20240621143903.3598230-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42d.google.com
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
---
 target/arm/cpu.h       |  2 ++
 target/arm/tcg/cpu32.c | 30 +++++++++++++++++++++++++++---
 target/arm/tcg/cpu64.c |  2 +-
 3 files changed, 30 insertions(+), 4 deletions(-)

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
index bdd82d912a..b155a0136f 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -87,6 +87,33 @@ void aa32_max_features(ARMCPU *cpu)
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
@@ -955,9 +982,6 @@ static void arm_max_initfn(Object *obj)
     cpu->isar.id_isar4 = 0x00011142;
     cpu->isar.id_isar5 = 0x00011121;
     cpu->isar.id_isar6 = 0;
-    cpu->isar.dbgdidr = 0x3516d000;
-    cpu->isar.dbgdevid = 0x00110f13;
-    cpu->isar.dbgdevid1 = 0x2;
     cpu->isar.reset_pmcr_el0 = 0x41013000;
     cpu->clidr = 0x0a200023;
     cpu->ccsidr[0] = 0x701fe00a; /* 32KB L1 dcache */
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 0899251eef..71e1bfcd4e 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1167,7 +1167,7 @@ void aarch64_max_tcg_initfn(Object *obj)
 
     t = cpu->isar.id_aa64isar2;
     t = FIELD_DP64(t, ID_AA64ISAR2, MOPS, 1);     /* FEAT_MOPS */
-    t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);      /* FEAT_HBC */
+    t = FIELD_DP64(t, ID_AA64ISAR2, BC, 1);       /* FEAT_HBC */
     t = FIELD_DP64(t, ID_AA64ISAR2, WFXT, 2);     /* FEAT_WFxT */
     cpu->isar.id_aa64isar2 = t;
 
-- 
2.34.1


