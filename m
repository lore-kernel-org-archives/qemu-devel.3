Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8052C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:00:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5UF-0005ku-Fd; Tue, 12 Mar 2024 13:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5Td-0004pl-Ve; Tue, 12 Mar 2024 12:59:46 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5Tc-0007zw-9S; Tue, 12 Mar 2024 12:59:45 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6e6aaa2f02cso603385b3a.2; 
 Tue, 12 Mar 2024 09:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262782; x=1710867582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7T1ZChcLzusNnwL87W8EEDPWZnsiSOzBtB10TW+wJ0=;
 b=nUcTL0JPSPz1hLDnPb9f9naJl/1bc949HROf0Okp6uD0nNrqaH71t0UeZFnceS6lAn
 ZGwyfhDq1iV4So1mSloU/6fpKhJZuZG/pQI5Tgg1i9sYDuvsFqdzhIWNp2iERrj7qmG2
 Gnn1J8U+0tBUBkR6OLn+DZXOgKpP9iO/zfYwzz0D9y+IA8BXJRkb6G39fbQjunujAJVK
 aUr68u/SX5QYFsUd6H92BAV3aMxZEtWMexYg1kzgPjOT+lntoGyA7LKEnzedupKv6f7L
 VFfUVP2sz0BgvNnr+PgREKoFn2PP6b4WRY8o3NImhKUsmBUZLerMOndTelrry4XzS/pw
 0e9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262782; x=1710867582;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F7T1ZChcLzusNnwL87W8EEDPWZnsiSOzBtB10TW+wJ0=;
 b=w8R/yEDp4CYLJ7n4mcHdxfvOv1FlKwvZQesRfKPNBXAlpI3/0VuGX1BZgyHuyR3A3e
 wLxTko5tWFIcQll+FNpc/uu1NCvA7/QxF97g6FVoaRKRhCWDTL5BZRy1aGBAuQJ49WBO
 Mo7B21cmz1Wl/LKgndSb5ErRNMnD6HZd09/Q2EGnjzpQJ8hVWACKs1SngvB3J0/sShEr
 WaSMcgfdfRy1E8fwCnNmAd0lIyKvIDhBetpqNbZE1qE0I+Ub1ZTms0Ir44aGFSkuyKWD
 Z5nugpoBYReNrUkl3w5XXeBr+46p3sAx9nc6kQn8fKgOX3NlvHWIb0M1b9qvdILEXlLd
 Qqsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbx5EF84WL06jC4/qKM1T9G+J7pf/lr1ErbHCpWi7ny0eUn4H4SAc8jjmcBoaDRg+bH7TnIB5vTNNQ28hScJBUwSWb
X-Gm-Message-State: AOJu0YygTnT0OncxwgyAEUJ8lqHzopMCKt/OnH4z6ewMLDTWOY2JMc4K
 BXxr0P9j8SuYCsx2G8wNSdbq7QrPg/bvmPURai+X9oLq1iGN5X5RVH/EUUbYlwM=
X-Google-Smtp-Source: AGHT+IGRUdDRF5763BIkw9ejxeMNGYPEvp221iHsHjGETcaS1PduF0lHogn0rhh/1h26Gc75yXFcUQ==
X-Received: by 2002:a05:6a00:2306:b0:6e6:77a4:258e with SMTP id
 h6-20020a056a00230600b006e677a4258emr36371pfh.10.1710262782277; 
 Tue, 12 Mar 2024 09:59:42 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.09.59.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 09:59:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PULL 11/38] ppc/pnv: Set POWER9, POWER10 ibm,pa-features bits
Date: Wed, 13 Mar 2024 02:58:22 +1000
Message-ID: <20240312165851.2240242-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x432.google.com
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

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
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


