Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45407CAC598
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 08:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy4mG-0007os-Nn; Mon, 15 Sep 2025 04:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uy4m4-0007Zd-21
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 04:41:24 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uy4lo-0002PS-3Y
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 04:41:20 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2677a4d4ce3so3818615ad.0
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 01:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1757925659; x=1758530459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s8bkp/2RhmTzgkQ8Cw2+fik4TCLNZkEx0p226/BN2d8=;
 b=dM6YDXk/aKBizBjFWM0fAXxRs32rltoGeqnjSiUFVBF2nJYNB3PJfHhtmvQiMMW3/8
 0/n5BVU35meTxpbyTMe91qwqe2sm0hTHwzCQxvBzQRIzGMBhEhlgYl/3u3AiVJamDT8W
 k9/V/xwpRgd6BzOcDqhi4dZWJlXfYeoE1BZS2s4Fyv9zveSORa2my2wIuR0Ne9JGV/xc
 cD7FTpkC/e3LUC1SZIA2cVzeCdJOwcghWMHjeHIXlk2/PJ8NrvA2tkOwd3LmSRuEjbSB
 GjbGmlBLda2GL+QqJu7iAs9Z9nm7NwNylLTz23BDm8xJ45evZdBIL+eoOjCvamceGoOC
 Uqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757925659; x=1758530459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s8bkp/2RhmTzgkQ8Cw2+fik4TCLNZkEx0p226/BN2d8=;
 b=n+L9J1Y1cz6W7+Tm8C9DOcnBKKMk6eOo/z8FQ/mvBigLH6bcmJGAu1oo3WCfSwpey0
 8+ETkL1nfYsOg41SOyrFpYMNnwOeBcWbM20wN4O146+tADSkvKmXZl/LFK2U3l6M5Ejh
 aa0U7ggZA/04piZ3pTX/snX7w+UE3cgetSWIi4QEDKXTXdTJVcqQHsScRoBMEnpmb9iw
 yf045Xup89j86+l+eSXm8R82fRsRTYtHJN0UaD/ucYJi3jr3HbbSxMvEK/OF6K05Jio+
 UXOIBeMNA1cUEsmyKKa8pmNlLH0AnC+ZAClOi9nnIuJ5jw1JKj3v4toN1hA4tI4mXG7g
 TorQ==
X-Gm-Message-State: AOJu0YxETY3HYy9PwCK0aXE/ga7yrWtcXIvJ/lDKVyuYT/u7L+3XRtBA
 cruvCD+DxKTQ7v5We8CKmJBsYjJTnLRvIFeuBnxwS3xcerLd16461Ic30ZHsbhD/yPOZagGOinL
 yCUiXVuMD9mapSNZmnKjAXpElzPIc2bZFDxWjv2bhAtW997EXXI5QVTLeCRQwbwA+SD5odyCimg
 yCvZqkpGY3yrkTYUSXVe7mGTzAwCqQX8ls7hprb5kwww==
X-Gm-Gg: ASbGncviQow9pbjXSpKJ+3MR4YjIaRy12GjsCpIrhvibDGa3347ZhFgREGkAd+b3xJq
 2SjZ91YZODyaUZdeQJsGWfkC6hXd7sjHLqiLipLNGHj7M4AF/eXQtgl9CoISu7jZAQoeu3LwV6w
 tNStxJpFKanefvDPNC9PA8nmomvfRAu5/PZvdduKIluM7CAkbvgNRR09oWgDrha0vd4/b7D0fAC
 K7hLPIR/+b+IgTVzP1cNpGf8GZQnCmQ/EyABY58L5P3475omHa+CO/Ckr7oKwHNDfxnmSbvUZaV
 pj0QIWDUHfBiI3BhyVJtUx219NAG16+FeNu86qORpntVuw+RI2n0OIvdBGWLl3z0UYMip9Zz8xV
 N/Se58h97O8K9udxVmafjJ8WMR/rpGNeq2S7KiuUqTIA++mCDFYE5PH/bSTXO9apuQVJqsT58gG
 OtSJMeRfFBT1pn
X-Google-Smtp-Source: AGHT+IG9ZA8OCrds9NFYCNbHrTlYlK2w+gYCSB4f58tUWNdF2izcD0YOX1ZiHxA2HH4udCjpy8zRLA==
X-Received: by 2002:a17:902:e944:b0:267:8b4f:df13 with SMTP id
 d9443c01a7336-2678b4fe221mr14173835ad.11.1757925658576; 
 Mon, 15 Sep 2025 01:40:58 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-26295996ff6sm55852045ad.64.2025.09.15.01.40.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 01:40:58 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH 3/8] target/riscv: rvv: Add new VTYPE CSR field - altfmt
Date: Mon, 15 Sep 2025 16:40:31 +0800
Message-ID: <20250915084037.1816893-4-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250915084037.1816893-1-max.chou@sifive.com>
References: <20250915084037.1816893-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=max.chou@sifive.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

According to the Zvfbfa ISA spec v0.1, the vtype CSR adds a new field:
altfmt for BF16 support.
This update changes the layout of the vtype CSR fields.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.h           |  4 ++--
 target/riscv/vector_helper.c | 29 ++++++++++++++++++++++++-----
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 738e68fa6e2..532386000af 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -190,8 +190,8 @@ FIELD(VTYPE, VLMUL, 0, 3)
 FIELD(VTYPE, VSEW, 3, 3)
 FIELD(VTYPE, VTA, 6, 1)
 FIELD(VTYPE, VMA, 7, 1)
-FIELD(VTYPE, VEDIV, 8, 2)
-FIELD(VTYPE, RESERVED, 10, sizeof(target_ulong) * 8 - 11)
+FIELD(VTYPE, ALTFMT, 8, 1)
+FIELD(VTYPE, RESERVED, 9, sizeof(target_ulong) * 8 - 10)
 
 typedef struct PMUCTRState {
     /* Current value of a counter */
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 7c67d67a13f..603d0731ae1 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -33,6 +33,22 @@
 #include "vector_internals.h"
 #include <math.h>
 
+static target_ulong vtype_reserved(CPURISCVState *env, target_ulong vtype)
+{
+    int xlen = riscv_cpu_xlen(env);
+    target_ulong reserved = 0;
+
+    if (riscv_cpu_cfg(env)->ext_zvfbfa) {
+        reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
+                                           xlen - 1 - R_VTYPE_RESERVED_SHIFT);
+    } else {
+        reserved = vtype & MAKE_64BIT_MASK(R_VTYPE_ALTFMT_SHIFT,
+                                           xlen - 1 - R_VTYPE_ALTFMT_SHIFT);
+    }
+
+    return reserved;
+}
+
 target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
                             target_ulong s2, target_ulong x0)
 {
@@ -41,12 +57,9 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
     uint64_t vlmul = FIELD_EX64(s2, VTYPE, VLMUL);
     uint8_t vsew = FIELD_EX64(s2, VTYPE, VSEW);
     uint16_t sew = 8 << vsew;
-    uint8_t ediv = FIELD_EX64(s2, VTYPE, VEDIV);
+    uint8_t altfmt = FIELD_EX64(s2, VTYPE, ALTFMT);
     int xlen = riscv_cpu_xlen(env);
     bool vill = (s2 >> (xlen - 1)) & 0x1;
-    target_ulong reserved = s2 &
-                            MAKE_64BIT_MASK(R_VTYPE_RESERVED_SHIFT,
-                                            xlen - 1 - R_VTYPE_RESERVED_SHIFT);
     uint16_t vlen = cpu->cfg.vlenb << 3;
     int8_t lmul;
 
@@ -63,7 +76,13 @@ target_ulong HELPER(vsetvl)(CPURISCVState *env, target_ulong s1,
         }
     }
 
-    if ((sew > cpu->cfg.elen) || vill || (ediv != 0) || (reserved != 0)) {
+    if (cpu->cfg.ext_zvfbfa) {
+        if (altfmt == 1 && vsew >= MO_32) {
+            vill = true;
+        }
+    }
+
+    if ((sew > cpu->cfg.elen) || vill || (vtype_reserved(env, s2) != 0)) {
         /* only set vill bit. */
         env->vill = 1;
         env->vtype = 0;
-- 
2.43.0


