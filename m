Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023C1C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1yA-0008Vw-3u; Tue, 12 Mar 2024 09:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1y8-0008T3-9f; Tue, 12 Mar 2024 09:15:00 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1y6-0006rW-9m; Tue, 12 Mar 2024 09:14:59 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6e6afb754fcso182400b3a.3; 
 Tue, 12 Mar 2024 06:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710249296; x=1710854096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4dPpWXeXg/R19/iGDqlhShPAEv/UYaAvvOk7gE6evps=;
 b=hNGgp6/iv0dxj6ard/vVJWa+1UcU49l4oab/oQwVvu/gLn1WHoGeqlevDTXA/PgM+r
 bmAIMO8WCWGRc9EnfO+VV1aKNmVuDDFicbYYPB6sihs3mJB3Ss1SEo5AH8EziG+XNnIJ
 vqqHC6xrZIX/WsHJUu4o+QeX7BdzrWeDmckLV9ffur5dX6LRCEJe+9k5u0QSyoCvcU7T
 IJyR2WCgBhwHYlsQsdP5eUtuk6RHgoVUC3y0MZSH6kvRrUJ31SuFGm/hms+KpctMqTsb
 ZZniawW7qObDQSE9ZThVu5M4BCzdkvXh5QXXCmljr1v7ykqtEhvOtharJ1ZNJZfmClcS
 M+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710249296; x=1710854096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4dPpWXeXg/R19/iGDqlhShPAEv/UYaAvvOk7gE6evps=;
 b=xFX3WakNRpSK7hkJP/pMN+qtrSG++mrldKHdHcyNTszlvAP0RYDScvJtAp6gLTtWRp
 7tqm1LBaey331W8d4XAoE3j14hAyMfgq11mMA8NUDapuqsxb+nqFROcxXWeNxtGr3JaZ
 ILzNEY4t1dl/s/0oYdTp53qits/xwcesOfTXP+BlB/BhE7FQZZapNYjwU6gpICW1Ia6D
 eKb/OBaRfWdsfOC9GsNPxoKIA+dS7lGQNJVNTNOCP2P4NkNSpQ49XOsi6NgV9fssqzF1
 4tOcnih3a1XswIDWGApw31IOMDfnKSD7XNFrda9HMfhWhSUG7nVgj0osbtw8WqFbQxvc
 1LRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZi1Y8U0kRDHywQ7GcroBiUfmNgMwR0yfTyCklRV7nzph/tUP+egDUcvPSg8690Csxal1i1Jnvctlwdshq7NifBCH4cJU=
X-Gm-Message-State: AOJu0Yzx3Cz93u9f9HkkDs5PCDNntATE4y48ZdksqQnxpRhis7jEWs9R
 O9cVJtyHQzoUyP8/iMyWFDYAERumRttn6rkdJPlAjBItAhlt1rTwmsa28Rxe/JA=
X-Google-Smtp-Source: AGHT+IE+h+tGLhUHcWhU9YF1QgttLqnbhyRF8xbrBSlh+1yWRGjJmtQHGgsOf39cw2VYD9VM200dzw==
X-Received: by 2002:a05:6a00:1411:b0:6e6:8c8b:a45b with SMTP id
 l17-20020a056a00141100b006e68c8ba45bmr7624791pfu.18.1710249295807; 
 Tue, 12 Mar 2024 06:14:55 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 r15-20020aa78b8f000000b006e64f75c947sm6066084pfd.46.2024.03.12.06.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 06:14:55 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v2 08/10] ppc/pnv: Set POWER9, POWER10 ibm,pa-features bits
Date: Tue, 12 Mar 2024 23:14:17 +1000
Message-ID: <20240312131419.2196845-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312131419.2196845-1-npiggin@gmail.com>
References: <20240312131419.2196845-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c   | 67 ++++++++++++++++++++++++++++++++++++++++++++++++--
 hw/ppc/spapr.c |  1 +
 2 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 52d964f77a..8a502dea90 100644
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
+    /* 72: [P]HASHST/[P]HASHCHK */
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
index a684e0d9dc..abd484023a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -243,6 +243,7 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
      * so there isn't much need for it anyway.
      */
 
+    /* These should be kept in sync with pnv */
     uint8_t pa_features_206[] = { 6, 0,
         0xf6, 0x1f, 0xc7, 0x00, 0x00, 0xc0 };
     uint8_t pa_features_207[] = { 24, 0,
-- 
2.42.0


