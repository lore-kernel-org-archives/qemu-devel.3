Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07F5C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 13:17:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1xx-00080k-2z; Tue, 12 Mar 2024 09:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1xr-0007vg-TE; Tue, 12 Mar 2024 09:14:43 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rk1xp-0006p6-74; Tue, 12 Mar 2024 09:14:43 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e6a9fafacdso319471b3a.2; 
 Tue, 12 Mar 2024 06:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710249279; x=1710854079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6B7WRsdl13z1HZyfIAIaADMcs0Ruf91d8bxZELsi1fE=;
 b=I2UwWNdMyP/NeR2vKesjthn+crNjsqealjgmcrbIMjHiK9mFKVqAtY1N2Htzt9wGJV
 2eA+4Vp3371yCj4GLOklT/8Wwh8q9LzXyFKnyOZ7rz1+Hy7dvGomL0Jz+/uYWVklJFYW
 ZDL2SOMjGSrs1XacvsdzNSQwO4FI9+9q6FE1OwB1in9MSgNB58dv0UYUZoeYRhhAeiiI
 9wK1GGEWr9z6tZtWemy2Ziat7QafUdVpXTwu7aq90kDnUBBjy892kTqgfbVZFh6P/d1I
 PqQB4revXhUtiPtnwvVTl8xQkzaRg+D8Py9yHsEu9MVx3qyvP0b0jCQ5GDDHEpOdmrxY
 FyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710249279; x=1710854079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6B7WRsdl13z1HZyfIAIaADMcs0Ruf91d8bxZELsi1fE=;
 b=TXAWhAMB1MyUx2j4RAOnl6gaT8LVYjhW1xcMk2k88oOhgopCLydpoUNXp2kTYYqq9j
 n7M0L/4frcmzeqDZ+cRX5VFh/J0Krol9P5aV9RsYSb63mNTuBZwYBi8eCbzWEbAE6LiV
 SsdteyWdlrG5mSX1nrRFW/KkWUXqiqPymuNj4kGWJDrVeDCLUimDM7NsVb97vznN8QCj
 OBCOTadVWMdQuTn/aB3DaoRefeo4HFhmvrOV+nFLTzm++AiXaHN+AxBxB5TSpeaH344n
 IlaYdIvsGfFsT+yTUoEl8e1DvA6W3eYYx77+W3W518fFY5ZNDqjccssHQx5LYxDx2DVU
 bCXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQI11dwQz3I6hnHXqMPSBp7KKFrMkyLCoMO+fpYCB3RVpQjy0gGVcAXYizOXtnc3hrqPQJzOSYumIaXLE6IDdHNGu1Cv4=
X-Gm-Message-State: AOJu0YzNY1Lg15KfXyNzvhRtwjGfciWAvqVOj8eJp2VRGKKdoPtbLPME
 vHB7YLS1Pw5RU75F3Tb8ECtXBTLhOcFVvolTmTMQjDu5T3U5mO4obd+I9JJoyFA=
X-Google-Smtp-Source: AGHT+IGE+6cpBgTHDXF4fVTWZ/G6Jz7rpOdQO30EQRe5U9k090hX6ixTbc4JnI+qcj1kkfZSYxaCYw==
X-Received: by 2002:a05:6a00:c90:b0:6e6:9fdb:7323 with SMTP id
 a16-20020a056a000c9000b006e69fdb7323mr2726613pfv.4.1710249278950; 
 Tue, 12 Mar 2024 06:14:38 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 r15-20020aa78b8f000000b006e64f75c947sm6066084pfd.46.2024.03.12.06.14.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 06:14:38 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v2 03/10] ppc/spapr|pnv: Remove SAO from pa-features
Date: Tue, 12 Mar 2024 23:14:12 +1000
Message-ID: <20240312131419.2196845-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240312131419.2196845-1-npiggin@gmail.com>
References: <20240312131419.2196845-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
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

Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
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
index 55263f0815..3108d7c532 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -233,17 +233,23 @@ static void spapr_dt_pa_features(SpaprMachineState *spapr,
                                  PowerPCCPU *cpu,
                                  void *fdt, int offset)
 {
+    /*
+     * SSO (SAO) ordering is supported on KVM and thread=single hosts,
+     * but not MTTCG, so disable it. To advertise it, a cap would have
+     * to be added, or support implemented for MTTCG.
+     */
+
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
-- 
2.42.0


