Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26348C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjklO-0005Kp-1O; Mon, 11 Mar 2024 14:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjklM-0005HZ-Bo; Mon, 11 Mar 2024 14:52:40 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjklK-00055e-JF; Mon, 11 Mar 2024 14:52:40 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dc3b4b9b62so28310665ad.1; 
 Mon, 11 Mar 2024 11:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710183157; x=1710787957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F/yrQzhJLI/Jn8GVOzppekfGS+uQs1Mw+hwRyOvugg8=;
 b=VeBNyY5LSMz/dVPTYPJK6IHbZL9geZtI23rzmaEOwVibC/viSXPiIGw2GVwqlEW41l
 CS1/Za6sECY5vAPPvj8iy5+8vLPxHI7tw0yIk+ACvyx7VMOg5KaG+uXdpAml8yWeCiy8
 PJMFAD7Dl3OvBwLc9NtA4mNH8ILwvRTd5gkWE6wdqhoskYYrK2tzq2nH10vrZjl3K+3q
 mWG8/ExfWHUkftzBm45CTQdwXA53TmEBfoOW26BM8lPOtkr+NIEPbDqSZjAOQO/fkhkV
 n5fnjj+whiAwjD0gWzCPleU0s29hVDTy0AEeYe3f3CAYuXUqOmgjV0LNl0K5Ohczkwok
 qbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710183157; x=1710787957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F/yrQzhJLI/Jn8GVOzppekfGS+uQs1Mw+hwRyOvugg8=;
 b=hig6+wbgqyRbI0uaDJiY3HZJQ4e9p589xnwhIFLGp3ADXOQVosxw65aMCGlm5Z+5sm
 yfWyOj4UkjYF2F6gqumbBNyxhYtV0MStBSsJy31W/6aemqD702KKkgro8QmjABTkHbHl
 8fqtkomxhjr7CcM7QFSuLzeRJwU6W4EJbs3N36nk8xxoPBbiYvFojGqdj+BB+L7iTBi+
 JtQSLakuPe471+CcQaYeeym5s3swOIf4MG/v7b0CKXGrOaX7J/3TP7z7n1vGKB0Bi2NG
 7RTyPnnkRFe1i+HyHMQGXnwuEjTA9c/byOpD9pRfqqsUgRw5kDt8xWvvGpdAl04qWl5+
 h9sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8zBHZngWWBzxYKrJGyqxFGs4JFSD7G6OxUNOtkMUDVqZ7XWISstlmpTCiBzHkdW+Xc1iCIihy0DITrpliBGHm1dd6Wjo=
X-Gm-Message-State: AOJu0YxC1648R0CUPJcAz++RyqzTl6yI2/CDMDonpLbeFlTlNULwho//
 U9v0idZj611sESUeKsBYje6cajSxwA95442UzW4naSDBc3mPmgfudwkiR76ugtE=
X-Google-Smtp-Source: AGHT+IEuMP5ki5kp3PbVLO4i//6Ao7tFBZQqYcPjfsfflboTLhuycR4r+8Is4sBmMsF3kJZYCYD+Wg==
X-Received: by 2002:a17:902:f24b:b0:1dd:63db:b35f with SMTP id
 j11-20020a170902f24b00b001dd63dbb35fmr6756365plc.33.1710183156683; 
 Mon, 11 Mar 2024 11:52:36 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a170903018200b001dd7d00f7afsm4843887plg.18.2024.03.11.11.52.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 11:52:36 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH 08/13] ppc/pnv: Set POWER9, POWER10 ibm,pa-features bits
Date: Tue, 12 Mar 2024 04:51:50 +1000
Message-ID: <20240311185200.2185753-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311185200.2185753-1-npiggin@gmail.com>
References: <20240311185200.2185753-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Copy the pa-features arrays from spapr, adjusting slightly as
described in comments.

Cc: "Cédric Le Goater" <clg@kaod.org>
Cc: "Frédéric Barrat" <fbarrat@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c   | 67 ++++++++++++++++++++++++++++++++++++++++++++++++--
 hw/ppc/spapr.c |  1 +
 2 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 52d964f77a..3e30c08420 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -332,6 +332,35 @@ static void pnv_chip_power8_dt_populate(PnvChip *chip, void *fdt)
     }
 }
 
+/*
+ * Same as spapr pa_features_300 except pnv always enables CI largepages bit.
+ */
+static const uint8_t pa_features_300[] = { 66, 0,
+    /* 0: MMU|FPU|SLB|RUN|DABR|NX, 1: CILRG|fri[nzpm]|DABRX|SPRG3|SLB0|PP110 */
+    /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, 5: LE|CFAR|EB|LSQ */
+    0xf6, 0x3f, 0xc7, 0xc0, 0x00, 0xf0, /* 0 - 5 */
+    /* 6: DS207 */
+    0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
+    /* 16: Vector */
+    0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
+    /* 18: Vec. Scalar, 20: Vec. XOR, 22: HTM */
+    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 18 - 23 */
+    /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
+    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
+    /* 32: LE atomic, 34: EBB + ext EBB */
+    0x00, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
+    /* 40: Radix MMU */
+    0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 36 - 41 */
+    /* 42: PM, 44: PC RA, 46: SC vec'd */
+    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
+    /* 48: SIMD, 50: QP BFP, 52: String */
+    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
+    /* 54: DecFP, 56: DecI, 58: SHA */
+    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
+    /* 60: NM atomic, 62: RNG */
+    0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
+};
+
 static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
 {
     static const char compat[] = "ibm,power9-xscom\0ibm,xscom";
@@ -349,7 +378,7 @@ static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
         offset = pnv_dt_core(chip, pnv_core, fdt);
 
         _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
-                           pa_features_207, sizeof(pa_features_207))));
+                           pa_features_300, sizeof(pa_features_300))));
     }
 
     if (chip->ram_size) {
@@ -359,6 +388,40 @@ static void pnv_chip_power9_dt_populate(PnvChip *chip, void *fdt)
     pnv_dt_lpc(chip, fdt, 0, PNV9_LPCM_BASE(chip), PNV9_LPCM_SIZE);
 }
 
+/*
+ * Same as spapr pa_features_31 except pnv always enables CI largepages bit,
+ * always disables copy/paste.
+ */
+static const uint8_t pa_features_31[] = { 74, 0,
+    /* 0: MMU|FPU|SLB|RUN|DABR|NX, 1: CILRG|fri[nzpm]|DABRX|SPRG3|SLB0|PP110 */
+    /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, 5: LE|CFAR|EB|LSQ */
+    0xf6, 0x3f, 0xc7, 0xc0, 0x00, 0xf0, /* 0 - 5 */
+    /* 6: DS207 */
+    0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
+    /* 16: Vector */
+    0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
+    /* 18: Vec. Scalar, 20: Vec. XOR */
+    0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
+    /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
+    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
+    /* 32: LE atomic, 34: EBB + ext EBB */
+    0x00, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
+    /* 40: Radix MMU */
+    0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 36 - 41 */
+    /* 42: PM, 44: PC RA, 46: SC vec'd */
+    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
+    /* 48: SIMD, 50: QP BFP, 52: String */
+    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
+    /* 54: DecFP, 56: DecI, 58: SHA */
+    0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
+    /* 60: NM atomic, 62: RNG */
+    0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
+    /* 68: DEXCR[SBHE|IBRTPDUS|SRAPD|NPHIE|PHIE] */
+    0x00, 0x00, 0xce, 0x00, 0x00, 0x00, /* 66 - 71 */
+    /* 72: [P]HASHCHK */
+    0x80, 0x00,                         /* 72 - 73 */
+};
+
 static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
 {
     static const char compat[] = "ibm,power10-xscom\0ibm,xscom";
@@ -376,7 +439,7 @@ static void pnv_chip_power10_dt_populate(PnvChip *chip, void *fdt)
         offset = pnv_dt_core(chip, pnv_core, fdt);
 
         _FDT((fdt_setprop(fdt, offset, "ibm,pa-features",
-                           pa_features_207, sizeof(pa_features_207))));
+                           pa_features_31, sizeof(pa_features_31))));
     }
 
     if (chip->ram_size) {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 128bfe11a8..b53c13e037 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -233,6 +233,7 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
                                  PowerPCCPU *cpu,
                                  void *fdt, int offset)
 {
+    /* These should be kept in sync with pnv */
     uint8_t pa_features_206[] = { 6, 0,
         0xf6, 0x1f, 0xc7, 0x00, 0x00, 0xc0 };
     uint8_t pa_features_207[] = { 24, 0,
-- 
2.42.0


