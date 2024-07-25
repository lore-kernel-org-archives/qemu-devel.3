Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F8CC3DA70
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Jo-0004PM-Vn; Thu, 25 Jul 2024 19:56:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Jm-00043X-MT; Thu, 25 Jul 2024 19:56:18 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Jk-00015B-PJ; Thu, 25 Jul 2024 19:56:18 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-7a92098ec97so323217a12.2; 
 Thu, 25 Jul 2024 16:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951774; x=1722556574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o65ZpuREqQHuJJIrkFlt8ZtiXhnybS4cdkf3qbW4U8Q=;
 b=d63Qmw7209aCkrmR5WHiqyjvhpE+HS/9x6V8hd4LDjrho9+q5mHf96+BTI/Dp84+U1
 TLooURtV5a5f9mAL5kLk4cSX/pKPtwmU7d58O2i5GEI6fLeuhpppsfNGFh5QBqKy++on
 gzQSME+/yqVKY3tuiz+3Xape4UaO6/zDB0MhxVukMUgHZB4BbS8LyLjU17v0QJV2PUOR
 SYvFiTloIsutExozgmfNInheEf9oNHjvb7fyUh5kbKWjUxX8Q/QrwIPUah8kFVBSoOmG
 ZK1tPRVJpJAcSFbG2BvyvrtW1d73/QOS53iY1yD0+mqHvrgr7Zg9SkZpu2Z0cO4oIZJd
 mWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951775; x=1722556575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o65ZpuREqQHuJJIrkFlt8ZtiXhnybS4cdkf3qbW4U8Q=;
 b=khmxRrmGCLf9zieFz4GJGvNZT6jONLua4rtCl1V1LMnYnQyMoF5wRaiWPI/yERkxyn
 4m0vuTEELGsb9ump4O9UDzGwOS8ie+LEU+nT3k7e2klur5oGOuA4nLEuRO7wOLLj5SSG
 6K/ueIXS8mzTV9YEKlT5yF7ZRaARW4vRP8YX6gPUqURc8HGOCW+uxsozBBDrG8u/uvEE
 8OrICUlnkWda6CfAMB2nmd+jyqMX7FC5GlDKFSOxx0SnoC4DeGJOrsvgZVbiuwIFDIi1
 DcLomx0WiBCnlcI6SOYYkw1lQOoPwiHqc90ip9OH7czgibTWreTAvXJzc+upcZQZHhbM
 0NEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3l8OoCKdEZ+AnrWbHBDIFbWsguN6Z8CqM6xwyLCdwryM9NvGhXHWAtiJMsIa4xro4pPtS6QCIIN6cjUqYchp1AMLJ
X-Gm-Message-State: AOJu0YxBR8PbuJSYHLAogs9Az0b/kugylbBM5rrjaPMWsWpsqv1ksnSW
 W02yHBY+WhthiqkarQLsR52HdD9pJhg6qvv7e265AC3oSE310SdWCZl5wg==
X-Google-Smtp-Source: AGHT+IGr27iydW2CgDl3QMsmmGrdRtaDIn8jKf3UfMs4vCN5mzQwtNsifZkPfKgki9RSJh3gdN18fQ==
X-Received: by 2002:a17:90a:e650:b0:2c9:9f50:3f9d with SMTP id
 98e67ed59e1d1-2cf23786e22mr5025358a91.5.1721951774566; 
 Thu, 25 Jul 2024 16:56:14 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.56.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:56:13 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 31/96] ppc/pnv: Add POWER10 ChipTOD quirk for big-core
Date: Fri, 26 Jul 2024 09:53:04 +1000
Message-ID: <20240725235410.451624-32-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52a.google.com
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c                 | 7 ++++++-
 hw/ppc/pnv_core.c            | 2 ++
 include/hw/ppc/pnv.h         | 1 +
 include/hw/ppc/pnv_core.h    | 7 +++++++
 target/ppc/timebase_helper.c | 9 +++++++++
 5 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index a1c2cbbc3f..4605a49d28 100644
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
 
diff --git a/target/ppc/timebase_helper.c b/target/ppc/timebase_helper.c
index d86112d60a..73120323b4 100644
--- a/target/ppc/timebase_helper.c
+++ b/target/ppc/timebase_helper.c
@@ -218,6 +218,7 @@ void helper_store_booke_tsr(CPUPPCState *env, target_ulong val)
  * target/ppc/pnv_helper.c
  */
 #include "hw/ppc/pnv_core.h"
+#include "hw/ppc/pnv_chip.h"
 /*
  * POWER processor Timebase Facility
  */
@@ -302,6 +303,14 @@ static PnvCoreTODState *cpu_get_tbst(PowerPCCPU *cpu)
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
2.45.2


