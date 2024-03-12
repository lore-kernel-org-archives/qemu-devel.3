Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75EDCC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 17:02:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk5U4-0005GK-Vz; Tue, 12 Mar 2024 13:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5TW-0004nS-1J; Tue, 12 Mar 2024 12:59:40 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk5TU-0007zM-Hy; Tue, 12 Mar 2024 12:59:37 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e6b3dc3564so99991b3a.2; 
 Tue, 12 Mar 2024 09:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710262774; x=1710867574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tdyNcmPgux9//jKV7mWfb1o9E6QFQPrGkdX2/VZm364=;
 b=T7mWu47/jmsrIAvtFPjuUAXtbj3jlrC2o9HUBTgsW7EdjvpdpON4EBDi2ja5uxqcIr
 mXay+j9xpQzw6E054rgxPvY6MWG40OsugBEVRepv7zyBw1Uzb2MmexTeEdjl2Qk8WQNk
 ABV3h/+nB2UWsdKluy5cYHRSxZVo53MLEzaMjbgF9S2HXAe1PrpOn7t+iY2Cb7K6J2pE
 wrPl2pAmmXpy+WJ2yKhMBjyQABsYdbFhS1kKOIccTFWCUHvCJ4Wif8UBC+9ZHxaCypUh
 3L523/ITJoBNWBmX76jUPB7lDfOykdnxKCZiL+6BekpWgTOCD37fK2xKWXn9Lv959Llh
 rLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710262774; x=1710867574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tdyNcmPgux9//jKV7mWfb1o9E6QFQPrGkdX2/VZm364=;
 b=BDBiaEsH/WdKexk1tNcfV1slAYHxHHCSq2in+ey79itG2egvh1jBu5aL6LhgtUmXzN
 OPPr02IQEF30teq2VNe2OR7c4nImFUxlReJ6UwcnyevRefCSlUH0NATprB+qVN0PQD70
 0yL5Nu1VRrg9Pe9L6ntFM8iv5b2h/+DE3ysGAyQDmc29Dh8zaD3IbjjFRDnqfZJfomf2
 4eq6EaX1zaEMEd+Dr+gtXJe4C0AFodTZXaFpV2/W62xvtM5ulkJ2sgEdTer0vQIpGtK1
 Wyd8ASHluoILS5vEyYDHCphAvim1m6TMasyITNbKQP1rWEqoi5gRobAwAgHqNv0rfzYu
 oeKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAIfjohgWggHvWQPSVuV05oj+mZ9tgGm0s9iLsgoGTNiq9XIhfgB3dhgdtcktRRsznFZEAdJidronrDV8anXmkZgZB
X-Gm-Message-State: AOJu0YyqG8k5Z/kfjbf5oFO0odZvHGH/Gw+9Vg0aH61+P1Tto4hoMyqx
 pPZl52gf7iN7/kDIRZlIdkaQDf2IbcJJ0Husy2RVzZGhmnDNg2PDptGVx8VkZ9k=
X-Google-Smtp-Source: AGHT+IEFOILjHhBN5alYEBU7o9V6xVJvwgF5xc0Lam/p6hDTuLFL7i+IrwggShQO2yGffL5KEQB3aQ==
X-Received: by 2002:a05:6a21:6d85:b0:1a1:5000:225d with SMTP id
 wl5-20020a056a216d8500b001a15000225dmr1203987pzb.11.1710262774546; 
 Tue, 12 Mar 2024 09:59:34 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 t34-20020a056a0013a200b006e6a684a6ddsm1362330pfg.220.2024.03.12.09.59.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 09:59:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Benjamin Gray <bgray@linux.ibm.com>
Subject: [PULL 09/38] ppc/spapr: Add pa-features for POWER10 machines
Date: Wed, 13 Mar 2024 02:58:20 +1000
Message-ID: <20240312165851.2240242-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312165851.2240242-1-npiggin@gmail.com>
References: <20240312165851.2240242-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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

From: Benjamin Gray <bgray@linux.ibm.com>

Add POWER10 pa-features entry.

Notably DEXCR and [P]HASHST/[P]HASHCHK instruction support is
advertised. Each DEXCR aspect is allocated a bit in the device tree,
using the 68--71 byte range (inclusive). The functionality of the
[P]HASHST/[P]HASHCHK instructions is separately declared in byte 72,
bit 0 (BE).

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
[npiggin: reword title and changelog, adjust a few bits]
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 5bbd0d7a04..a684e0d9dc 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -275,6 +275,36 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
         /* 60: NM atomic, 62: RNG */
         0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
     };
+    /* 3.1 removes SAO, HTM support */
+    uint8_t pa_features_31[] = { 74, 0,
+        /* 0: MMU|FPU|SLB|RUN|DABR|NX, 1: fri[nzpm]|DABRX|SPRG3|SLB0|PP110 */
+        /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, 5: LE|CFAR|EB|LSQ */
+        0xf6, 0x1f, 0xc7, 0xc0, 0x00, 0xf0, /* 0 - 5 */
+        /* 6: DS207 */
+        0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
+        /* 16: Vector */
+        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 12 - 17 */
+        /* 18: Vec. Scalar, 20: Vec. XOR */
+        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 18 - 23 */
+        /* 24: Ext. Dec, 26: 64 bit ftrs, 28: PM ftrs */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 24 - 29 */
+        /* 32: LE atomic, 34: EBB + ext EBB */
+        0x00, 0x00, 0x80, 0x00, 0xC0, 0x00, /* 30 - 35 */
+        /* 40: Radix MMU */
+        0x00, 0x00, 0x00, 0x00, 0x80, 0x00, /* 36 - 41 */
+        /* 42: PM, 44: PC RA, 46: SC vec'd */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 42 - 47 */
+        /* 48: SIMD, 50: QP BFP, 52: String */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 48 - 53 */
+        /* 54: DecFP, 56: DecI, 58: SHA */
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00, /* 54 - 59 */
+        /* 60: NM atomic, 62: RNG */
+        0x80, 0x00, 0x80, 0x00, 0x00, 0x00, /* 60 - 65 */
+        /* 68: DEXCR[SBHE|IBRTPDUS|SRAPD|NPHIE|PHIE] */
+        0x00, 0x00, 0xce, 0x00, 0x00, 0x00, /* 66 - 71 */
+        /* 72: [P]HASHST/[P]HASHCHK */
+        0x80, 0x00,                         /* 72 - 73 */
+    };
     uint8_t *pa_features = NULL;
     size_t pa_size;
 
@@ -290,6 +320,10 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
         pa_features = pa_features_300;
         pa_size = sizeof(pa_features_300);
     }
+    if (ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_10, 0, cpu->compat_pvr)) {
+        pa_features = pa_features_31;
+        pa_size = sizeof(pa_features_31);
+    }
     if (!pa_features) {
         return;
     }
-- 
2.42.0


