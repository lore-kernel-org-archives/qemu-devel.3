Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E33C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1y3-0008CU-6w; Tue, 12 Mar 2024 09:14:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1y1-00084X-FD; Tue, 12 Mar 2024 09:14:53 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1xz-0006qm-SX; Tue, 12 Mar 2024 09:14:53 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6e617b39877so4013047b3a.3; 
 Tue, 12 Mar 2024 06:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710249289; x=1710854089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tdyNcmPgux9//jKV7mWfb1o9E6QFQPrGkdX2/VZm364=;
 b=RCiaijaBFaV0dV+DOvMFsNhlCfgLrRjyg5tvxC8bNLO2whTs1SPQ9p1vdBgQ9RFrAI
 kXdh5/DFOzHWdEtABi2UdOJab9q28SXbHsjtnF3fm1ViPPDnBA9Gw1YuYPB19gS/EpAX
 QLJsHdCLWGsTeg1o8XrKTHDM2kInWsavXUvwH5ED9OQ1ve5W8tpqqgEII99d8aBJxOqU
 //kwrVxrjum4/AS7LIDF2DL8x87/4vd/07V7fmmDGcywOfJW8ZqbepJ5BpMiJRhYZpWg
 HQU7FDo025bc/8dOY/LZv8X+0UDcgOOszTd+UA5C9QJSmA/A6baYJATJWRqwbaWAg8p3
 MDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710249289; x=1710854089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tdyNcmPgux9//jKV7mWfb1o9E6QFQPrGkdX2/VZm364=;
 b=NPzlWCM2tnAdVTqre7wHhKocxBrnWe2+08pZPQYFJ6lHSqa7sLH2vnSrHiXr5I2Wx/
 sm4vENe2SWLLUqnJX3EHT0QPj6nekrU7Q6z3+Z17wAkjunS7l+KjhYfZDhK5k0y0a3gK
 SWAOq5+QxkJ0MNPszx0935qQujj2IivUM3569+czy6BGaMJQ3YsLoUg/BbJMRD6tkG15
 cKzQXKZU0HEsO3GIoJM9pFt5SFjnLcs7wRyVq3Boh35b6Oczdc/IpvgQGWK8/WLsCx13
 ZGaQvibXveB5WA/05zl367Tt+wY2rWdcEKUrMaFk+F74k960nazQfJTTZwUYf+z0OaNQ
 p7eQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRMA5VeUtptSf9JJPxHgLnAbTVhSEey+AnGX8pc6b99k3cjr5aM9eHebtq07Gj59jUSw2WKTzzRuqnst0mwMtyhk09lzo=
X-Gm-Message-State: AOJu0YyVRDcOe5X/1QCTUliTueq7akKwUmVwm1ZuuzqHeawAYReAy1G9
 RvGSpa8YVbevwNcM6sD+4Q3Q4YdCbvvDxtAp3MuZMeZKLSZUV+HNRDzJPmlny9M=
X-Google-Smtp-Source: AGHT+IEEP1B9GBRQHd0WfdS/0J2GAPcmiCROsOY+V7CNlkVar8cAnptlnJBcqC7FbYmQoHj48kI/Iw==
X-Received: by 2002:a05:6a00:4b54:b0:6e6:9a11:ccd8 with SMTP id
 kr20-20020a056a004b5400b006e69a11ccd8mr4989449pfb.14.1710249289065; 
 Tue, 12 Mar 2024 06:14:49 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 r15-20020aa78b8f000000b006e64f75c947sm6066084pfd.46.2024.03.12.06.14.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 06:14:48 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Benjamin Gray <bgray@linux.ibm.com>
Subject: [PATCH v2 06/10] ppc/spapr: Add pa-features for POWER10 machines
Date: Tue, 12 Mar 2024 23:14:15 +1000
Message-ID: <20240312131419.2196845-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312131419.2196845-1-npiggin@gmail.com>
References: <20240312131419.2196845-1-npiggin@gmail.com>
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


