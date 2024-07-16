Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE207C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTl2T-0003E2-A3; Tue, 16 Jul 2024 12:28:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl1b-0007B0-65; Tue, 16 Jul 2024 12:27:36 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl1M-0006cu-8N; Tue, 16 Jul 2024 12:27:22 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-70b0e7f6f8bso4983722b3a.3; 
 Tue, 16 Jul 2024 09:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721147237; x=1721752037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Njtj68/O8+IW2jvRZMh3SlkL4jNiwEp56S0K4b4BOQ=;
 b=m+mCQsNAhSDlb0fGWBvqjixmjvTKb96mpzye10uhPMA4fllCipFjH85f+sOVVneORJ
 ZKP0rxae+JPYrmrV1RQRSGwFDYhMrpfPewCFT7OECvBR2bvHo9XVwfck7ylgrtaT1zse
 4+6c8dlECLGVcf8ZhriWeGhRdy1x7IDZcDQaQ4dIZdRoUdD9bBa3uCjox6X6hhso361v
 ZyN5YxEbMGSlcn856UNxsm56B0Zf3CF+NFt0oT8QMFrW+FTjqlfdommL9sBPoJTOxoLu
 oOO21GGZ3BCN/8lrHlpJOvN1LobzQae9pyUECHddPLDilNhSxO7cO5vdGmOx27EzFQNA
 9jew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721147237; x=1721752037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Njtj68/O8+IW2jvRZMh3SlkL4jNiwEp56S0K4b4BOQ=;
 b=BuUapqnUzpKr3TNpDmKAICpQDTu2mXg1jMk4YfJu8UHe3j5XdhHecR3baiW9JedIxR
 kYZ91hraJt25cxI3NgPhLSM3s+hFLA6VTXBoW8MjsP8eHsgbH+EmGTr+2FeOdCUBj6fn
 dJKCCEEv+YkSK8RWbE/vnIuGfbHsRN25VzALNKDNFNPfrQWnsxEBmFmcgb08/N51FqQ4
 qH7EAe8H1EYkTHM9rYtFz9aPuYPPkji/nZfyGo6SndoAIaSQ4f83O7czLsgfYDF9Ndvl
 dDe7ZN4pBxbiMoJPVciyAmwDhcXyC1x6EgjcRbX0OMwYxgAVqFnfMZ0VJiVQeMtGVYoC
 3Mew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDTFJc2oBn1YuI9FWEb18oJERxIvEPOCzmRoXolT3P2T4ydS+ZuPHg4fC54pdCYN+c7GyqE22U2eeccoLnLcpP9EiHSIc=
X-Gm-Message-State: AOJu0YwFH4o13dnod/SsIm6PNHe19HPUcXkxbIUiW56oVK4QILgh46XN
 OAjJRIJrneKTdrzqp5Hy1XMfeZ4U5i4OUHu6PN8JFzM8eqP5VTw8xTteQw==
X-Google-Smtp-Source: AGHT+IGUcLO+DOsEDizjEL8gRWiv+J6cmM9jlYyhz5lEjJ+96WneJ+jmT3tS05vZRFWJ3a68TsZZmg==
X-Received: by 2002:aa7:8891:0:b0:707:ffa4:de3f with SMTP id
 d2e1a72fcca58-70c1fbe3451mr3442654b3a.17.1721147237466; 
 Tue, 16 Jul 2024 09:27:17 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eca86d6sm6722161b3a.179.2024.07.16.09.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 09:27:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 14/19] ppc/pnv: Add POWER10 ChipTOD quirk for big-core
Date: Wed, 17 Jul 2024 02:26:10 +1000
Message-ID: <20240716162617.32161-15-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240716162617.32161-1-npiggin@gmail.com>
References: <20240716162617.32161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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
 hw/ppc/pnv.c                 | 7 ++++++-
 hw/ppc/pnv_core.c            | 2 ++
 target/ppc/timebase_helper.c | 9 +++++++++
 5 files changed, 25 insertions(+), 1 deletion(-)

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
index 1d08176b75..322ab9073b 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -2290,11 +2290,12 @@ static void pnv_chip_core_sanitize(PnvMachineState *pnv, PnvChip *chip,
 
 static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
 {
+    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
+    PnvMachineClass *pmc = PNV_MACHINE_GET_CLASS(pnv);
     Error *error = NULL;
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
     const char *typename = pnv_chip_core_typename(chip);
     int i, core_hwid;
-    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
 
     if (!object_class_by_name(typename)) {
         error_setg(errp, "Unable to find PowerNV CPU Core '%s'", typename);
@@ -2335,8 +2336,11 @@ static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
                                 &error_fatal);
         object_property_set_bool(OBJECT(pnv_core), "big-core", chip->big_core,
                                 &error_fatal);
+        object_property_set_bool(OBJECT(pnv_core), "quirk-tb-big-core",
+                                pmc->quirk_tb_big_core, &error_fatal);
         object_property_set_link(OBJECT(pnv_core), "chip", OBJECT(chip),
                                  &error_abort);
+
         qdev_realize(DEVICE(pnv_core), NULL, &error_fatal);
 
         /* Each core has an XSCOM MMIO region */
@@ -2650,6 +2654,7 @@ static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
     pmc->compat = compat;
     pmc->compat_size = sizeof(compat);
     pmc->max_smt_threads = 4;
+    pmc->quirk_tb_big_core = true;
     pmc->dt_power_mgt = pnv_dt_power_mgt;
 
     xfc->match_nvt = pnv10_xive_match_nvt;
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 43cfeaa2d4..1783795b23 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -364,6 +364,8 @@ static Property pnv_core_properties[] = {
     DEFINE_PROP_UINT32("hwid", PnvCore, hwid, 0),
     DEFINE_PROP_UINT64("hrmor", PnvCore, hrmor, 0),
     DEFINE_PROP_BOOL("big-core", PnvCore, big_core, false),
+    DEFINE_PROP_BOOL("quirk-tb-big-core", PnvCore, tod_state.big_core_quirk,
+                     false),
     DEFINE_PROP_LINK("chip", PnvCore, chip, TYPE_PNV_CHIP, PnvChip *),
     DEFINE_PROP_END_OF_LIST(),
 };
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


