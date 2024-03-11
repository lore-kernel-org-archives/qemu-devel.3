Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A4CC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjklB-00055f-Fx; Mon, 11 Mar 2024 14:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjkl5-0004yi-MD; Mon, 11 Mar 2024 14:52:24 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rjkl3-0004yx-SG; Mon, 11 Mar 2024 14:52:23 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1dc49b00bdbso25425075ad.3; 
 Mon, 11 Mar 2024 11:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710183138; x=1710787938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m4I3uk5RgxokOhWwxSwUTZCQpUL3SWxu7Fy5Fxqrf1U=;
 b=KURUuVHQ3wh4+E/F/HZhSGZWq7338xSG85S3IbftsXBL6AxVs8Q4o2cW6a0de7tglD
 TYNd9JBZc2mtUCy3bKfVI+WiHYrUXhypNMU4tt6/3pIf3+UGGOe+LbNNcKIdioMkZ33N
 4oNE9Gvw00SG3okSXPDtea27Mp8/NEnXtUaWLsLEpncUmpcVNbpA9fEMDzK5HaJ/Vmfu
 gYtRuwblb2UYAydfjga9eGVWJ2Plu9ncXo4o3lxATNYKhGaFvNBb1D8UxSqkSvwKRtFI
 WTib8lHd2zhft9TUstl4rbq1IQpwCAx/UTcnEyCVKolEgXjmhkKUIZEDoiLuXR/U3QoH
 a1xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710183138; x=1710787938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m4I3uk5RgxokOhWwxSwUTZCQpUL3SWxu7Fy5Fxqrf1U=;
 b=vvGYlrX0L04OEFbTHRWiKYOqwc+3SLS+Hdl8UXiuX8S/nUmehhzfqV3HZpovG9MmYU
 D8rj2kH7T8xuNL2/ZwdMG8gFosTEtF7jJTvUpMxz+QDKTId9S9LBTsTavR5FJK6GC/t2
 tCK7FRLhCsYRT+JyMh9CosLM5X28ZZ/Sa1odaWRFo5+AYfyfeSYT0E+qIBBDfPSTlLle
 DrYPIFZVKS0y0Jiie4PEQNGoPVdiRApQhMnYj2jzfxGAyWOGSxLKHaLiEjVVfFKEZMNi
 1dqtpblvnyvba00sMwMKcESYrVbW9ifLEAtstM4tBbvjmFK+nVpwrNIRmmjPU3sVAkyx
 pNsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdcHYw0HD29Yu7fhKYvI9I6XHKReFS24TbP9Q0P0A7KuuvsSboAZ4608+//gxv6cj+vuykEiFRUfiD9J/JMoeSM0dKtrc=
X-Gm-Message-State: AOJu0YzGtmDbBHDMGtcQ60gJvJT3MORdWroGAihqHd5vDV1Ju8vuDjmU
 vVVg+EGboZ9E07q0H3C8J27SY/i8xObmaOD6XxH6WTAo1Ix9zRLVeIhPo9tpFEw=
X-Google-Smtp-Source: AGHT+IGBsYLDmYSnyMPdfLEAm02/vjJmNAq+OuGOyKb+L9jpXu6qb9qRrmAmQ/oMnFYaGfJDjqS1RA==
X-Received: by 2002:a17:902:ccc5:b0:1dd:9263:c3bd with SMTP id
 z5-20020a170902ccc500b001dd9263c3bdmr4110899ple.12.1710183138573; 
 Mon, 11 Mar 2024 11:52:18 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a170903018200b001dd7d00f7afsm4843887plg.18.2024.03.11.11.52.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 11:52:18 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH 03/13] ppc/spapr|pnv: Remove SAO from pa-features
Date: Tue, 12 Mar 2024 04:51:45 +1000
Message-ID: <20240311185200.2185753-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311185200.2185753-1-npiggin@gmail.com>
References: <20240311185200.2185753-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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

SAO is a page table attribute that strengthens the memory ordering of
accesses. QEMU with MTTCG does not implement this, so clear it in
ibm,pa-features. This is an obscure feature that has been removed from
POWER10 ISA v3.1, there isn't much concern with removing it.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c   |  2 +-
 hw/ppc/spapr.c | 14 ++++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 0b47b92baa..aa9786e970 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -150,7 +150,7 @@ static void pnv_dt_core(PnvChip *chip, PnvCore *pc, void *fdt)
     uint32_t page_sizes_prop[64];
     size_t page_sizes_prop_size;
     const uint8_t pa_features[] = { 24, 0,
-                                    0xf6, 0x3f, 0xc7, 0xc0, 0x80, 0xf0,
+                                    0xf6, 0x3f, 0xc7, 0xc0, 0x00, 0xf0,
                                     0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
                                     0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
                                     0x80, 0x00, 0x80, 0x00, 0x80, 0x00 };
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 55263f0815..5099f12cc6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -234,16 +234,16 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
                                  void *fdt, int offset)
 {
     uint8_t pa_features_206[] = { 6, 0,
-        0xf6, 0x1f, 0xc7, 0x00, 0x80, 0xc0 };
+        0xf6, 0x1f, 0xc7, 0x00, 0x00, 0xc0 };
     uint8_t pa_features_207[] = { 24, 0,
-        0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0,
+        0xf6, 0x1f, 0xc7, 0xc0, 0x00, 0xf0,
         0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
         0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
         0x80, 0x00, 0x80, 0x00, 0x00, 0x00 };
     uint8_t pa_features_300[] = { 66, 0,
         /* 0: MMU|FPU|SLB|RUN|DABR|NX, 1: fri[nzpm]|DABRX|SPRG3|SLB0|PP110 */
-        /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, SSO, 5: LE|CFAR|EB|LSQ */
-        0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0, /* 0 - 5 */
+        /* 2: VPM|DS205|PPR|DS202|DS206, 3: LSD|URG, 5: LE|CFAR|EB|LSQ */
+        0xf6, 0x1f, 0xc7, 0xc0, 0x00, 0xf0, /* 0 - 5 */
         /* 6: DS207 */
         0x80, 0x00, 0x00, 0x00, 0x00, 0x00, /* 6 - 11 */
         /* 16: Vector */
@@ -284,6 +284,12 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
         return;
     }
 
+    /*
+     * SSO (SAO) ordering is supported on KVM and thread=single hosts,
+     * but not MTTCG, so disable it. To advertise it, a cap would have
+     * to be added, or support implemented for MTTCG.
+     */
+
     if (ppc_hash64_has(cpu, PPC_HASH64_CI_LARGEPAGE)) {
         /*
          * Note: we keep CI large pages off by default because a 64K capable
-- 
2.42.0


