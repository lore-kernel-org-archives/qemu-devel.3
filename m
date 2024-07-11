Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EFABC3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 14:23:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRueT-000726-Rt; Thu, 11 Jul 2024 10:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRueQ-0006b0-Dc; Thu, 11 Jul 2024 10:20:02 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRueO-0005YS-95; Thu, 11 Jul 2024 10:20:01 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-70af8128081so779066b3a.1; 
 Thu, 11 Jul 2024 07:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720707598; x=1721312398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mInheJXYc07E9z2x5XuVHPcAsdtfO6FP7woHZ3/CMp8=;
 b=E3jlz8ncUgNJugRtyXsLIke0mjWqF3mX0guFT7DrFjqUOvWbl/0Wg32b11YV/ysb5A
 unFgzXVRVeCJGmG6NZAwAOCMCisGOeq+q49oiUXqdF8DvOoaryzUtxK9kYqPoWtCUPsg
 FyQhI/NyDcE1OS3FlhS6C2JPmd4w8/753wVjmyTurOw4/tZvdqtQk3xCrPfmRDwzERDg
 LyXDU1HC5cDTLwE5Lxpyf6f62ds4BOAbicM2MXWK/eCm/up3JJYJXvpRsoOuvr+sA+jU
 q0qM6oYj4wv6MJmjlcSJPMRAm1rxFQcFhwxxiyeZ218A3QH9D/k2XPWT0DVdCHv4cbvD
 QZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720707598; x=1721312398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mInheJXYc07E9z2x5XuVHPcAsdtfO6FP7woHZ3/CMp8=;
 b=V1Y3+Ufs0aVT/XucoJ/Ls8QwyyXn5woq4TeHdW5pUJiRLDN5Yi5EonIx2PLrYDFc1w
 g86lwqpPx53LPpatDOfvq5VL593OKU3Vr+OYbwU/Si7mYaIDhfwbvkM3mXRfg91GSEhJ
 89Zz4FE9irwrKl80otb7iuTCBdUflyTrEspbfqnBbUd4iTlrWsJxB4O5f00Z0wIUwSL3
 BYjuenOwm+k9650+752REh+Yy6n0i8CZPeM38ZCoI0Rq0va37O8aI8wb35fsWITbpkDf
 C8KFpB/23bHPB5LwQ4PLvy9rhVJCt2+6GKpFGoLUZILeMKCyaRm0IXOomm2HLBIhsI7D
 ENbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0Gl298mNm8XPBzM1infticYlPMR+3TNiJoAIbbKJX5Q/g5ySbmshNTiueUrJB8FqXy9KGOcPO89cUYhsutU4cyOGGgiU=
X-Gm-Message-State: AOJu0Ywe6i36AQM1F/OxcMVjR+sK2ppx3VDljZlatRVnjdYkNuwIu4az
 HnrnQRBlqYT8G2nD/2jrSVsRZ8jQ7uD5eulmJvPQ+obU/zX6G+mnZ24pnz4R
X-Google-Smtp-Source: AGHT+IFQhpMqyUl08TBByaZvJzRsvz96DxutP7BJHGr3nfd+PSJ9H56QH/NjRXWfhZrkzCOrMSjT4w==
X-Received: by 2002:a05:6a21:6d87:b0:1bd:2cea:f6ee with SMTP id
 adf61e73a8af0-1c29824d499mr9574236637.27.1720707598022; 
 Thu, 11 Jul 2024 07:19:58 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b54ec730fsm3308904b3a.173.2024.07.11.07.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 07:19:57 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 15/18] ppc/pnv: Add POWER10 ChipTOD quirk for big-core
Date: Fri, 12 Jul 2024 00:18:47 +1000
Message-ID: <20240711141851.406677-16-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240711141851.406677-1-npiggin@gmail.com>
References: <20240711141851.406677-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

POWER10 has a quirk in its ChipTOD addressing that requires the even
small-core to be selected even when programming the odd small-core.
This allows skiboot chiptod init to run in big-core mode.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv.h         | 1 +
 include/hw/ppc/pnv_core.h    | 7 +++++++
 hw/ppc/pnv.c                 | 1 +
 hw/ppc/pnv_core.c            | 3 +++
 target/ppc/timebase_helper.c | 9 +++++++++
 5 files changed, 21 insertions(+)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 283ddd50e7..c56d152889 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -77,6 +77,7 @@ struct PnvMachineClass {
     const char *compat;
     int compat_size;
     int max_smt_threads;
+    bool quirk_tb_big_core;
 
     void (*dt_power_mgt)(PnvMachineState *pnv, void *fdt);
     void (*i2c_init)(PnvMachineState *pnv);
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 50164e9e1f..c8784777a4 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -27,6 +27,13 @@
 
 /* Per-core ChipTOD / TimeBase state */
 typedef struct PnvCoreTODState {
+    /*
+     * POWER10 DD2.0 - big core TFMR drives the state machine on the even
+     * small core. Skiboot has a workaround that targets the even small core
+     * for CHIPTOD_TO_TB ops.
+     */
+    bool big_core_quirk;
+
     int tb_ready_for_tod; /* core TB ready to receive TOD from chiptod */
     int tod_sent_to_tb;   /* chiptod sent TOD to the core TB */
 
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index d7488be74c..efc9cf2cc3 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2650,6 +2650,7 @@ static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
     pmc->compat = compat;
     pmc->compat_size = sizeof(compat);
     pmc->max_smt_threads = 4;
+    pmc->quirk_tb_big_core = true;
     pmc->dt_power_mgt = pnv_dt_power_mgt;
 
     xfc->match_nvt = pnv10_xive_match_nvt;
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index a96ec4e2b9..68cc5914c6 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -280,6 +280,7 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
     PnvCore *pc = PNV_CORE(OBJECT(dev));
     PnvCoreClass *pcc = PNV_CORE_GET_CLASS(pc);
     CPUCore *cc = CPU_CORE(OBJECT(dev));
+    PnvMachineClass *pmc = PNV_MACHINE_GET_CLASS(pc->chip->pnv_machine);
     const char *typename = pnv_core_cpu_typename(pc);
     Error *local_err = NULL;
     void *obj;
@@ -288,6 +289,8 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
 
     assert(pc->chip);
 
+    pc->tod_state.big_core_quirk = pmc->quirk_tb_big_core;
+
     pc->threads = g_new(PowerPCCPU *, cc->nr_threads);
     for (i = 0; i < cc->nr_threads; i++) {
         PowerPCCPU *cpu;
diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index 44cacf065e..019b8ee41f 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -20,6 +20,7 @@
 #include "cpu.h"
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/pnv_core.h"
+#include "hw/ppc/pnv_chip.h"
 #include "exec/helper-proto.h"
 #include "exec/exec-all.h"
 #include "qemu/log.h"
@@ -297,6 +298,14 @@ static PnvCoreTODState *cpu_get_tbst(PowerPCCPU *cpu)
 {
     PnvCore *pc = pnv_cpu_state(cpu)->pnv_core;
 
+    if (pc->big_core && pc->tod_state.big_core_quirk) {
+        /* Must operate on the even small core */
+        int core_id = CPU_CORE(pc)->core_id;
+        if (core_id & 1) {
+            pc = pc->chip->cores[core_id & ~1];
+        }
+    }
+
     return &pc->tod_state;
 }
 
-- 
2.45.1


