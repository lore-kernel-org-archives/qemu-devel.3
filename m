Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B4DC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 00:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Je-0002b9-IG; Thu, 25 Jul 2024 19:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8Ja-00029G-BD; Thu, 25 Jul 2024 19:56:06 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8JY-00012f-3v; Thu, 25 Jul 2024 19:56:06 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-6bce380eb96so257336a12.0; 
 Thu, 25 Jul 2024 16:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951762; x=1722556562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4FYyO3F1Gvzq5sKTYWxP5RaNcLWFNN+o8CHZFzYArmA=;
 b=MIGPRigCdYiZLhdGYP6//mJHlJwVTfekJEShF3YHq3LmuUtAl24lSIKPW8iRSyAZvn
 nWo1/+SHE9IbzYxxgW+SVL5VwKgFhtz4NwRUS4N165VPQWz3hPKwUUrrq7htGwjz6rOQ
 869uKJsEuVERL8H8FUyqrA8TbfnOMR2+PXnFwk0Rz47BZX/91JYBViD2Ov1x6pm3+JPV
 p8EjIWwo3utQYTvaCKzRYVpG38hnebX4vVc4koXmNEa2rEX0CMh61l08I5JkkAKAu84V
 lb5fki310THgrLiBitXe4AqYL1/8sbLv88p3rofqOclgA+9+PsbFQuJ1mFBUkYxKVrwz
 ilDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951762; x=1722556562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4FYyO3F1Gvzq5sKTYWxP5RaNcLWFNN+o8CHZFzYArmA=;
 b=Ajt93xfTEAvkk7WOm/j1TmVx82k4yhSh6nZ4nGakmpXLLakRzZ1Y4GoEaHV2NTQpsf
 99F8OHo/ZD381wbB0z0DXFaadxgrGg7RhROIQ+l8AcbE8lXUaQE+FQT2wsuYePMteTXb
 M2wI66M6Ux6s8Vl8BBibMDQybTXv4jWdf8O6lyshJgM6B7tsjbNRgKp2mzF/J68P2NiE
 SA5cravNsUlOALfTMVwoNaNhdC/HhFl2GvrMY7NH+3YIo0yK9DN6FfRjeqUYvFL/q1/F
 E2GMcGfuZq81Q6Vq7JwkJ2OWvPmdfXe8DwzvvE0Py0oNEMCBpEm5yyFiQ2Wu1d4RIoco
 F8Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTzrQvYMB9p/8AamJB7KDNUHO8V4v9h8fbA61aT2D6nMW+7CpT7jkZY4sJLSoLV6QZQj0SeltREUycgisawUS2qlsd
X-Gm-Message-State: AOJu0YxyWlO1fhjPlMsaRRFmdxBH0XGljomPd6AwfKT3l549ZHOCbmi1
 VeXeJTNkrTQMzVtXiF1oVhI60QFk2a89cdARN1+4umIwXDsq4UIRGym91A==
X-Google-Smtp-Source: AGHT+IGWIlCmFWc1vKVK3jmxsUOq5wB5R6t5GsvCMhsB8wppam2SREEbgz//Kcn4M9tUtFGAyC9Ikg==
X-Received: by 2002:a05:6a20:4d98:b0:1c0:e42e:8508 with SMTP id
 adf61e73a8af0-1c47b203863mr3058807637.23.1721951761954; 
 Thu, 25 Jul 2024 16:56:01 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:56:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 27/96] ppc/pnv: Add a big-core mode that joins two regular cores
Date: Fri, 26 Jul 2024 09:53:00 +1000
Message-ID: <20240725235410.451624-28-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x530.google.com
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

POWER9 and POWER10 machines come in two variants, big-core and
small-core. Big-core machines are SMT8 from software's point of view,
but the low level platform topology ("xscom registers and pervasive
addressing"), these look more like a pair of small cores ganged
together.

Presently the way this is modelled is to create one SMT8 PnvCore and add
special cases to xscom and pervasive for big-core mode that tries to
split this into two small cores, but this is becoming too complicated to
manage.

A better approach is to create 2 core structures and ganging them
together to look like an SMT8 core in TCG. Then the xscom and pervasive
models mostly do not need to differentiate big and small core modes.

This change adds initial mode bits and QEMU topology handling to
split SMT8 cores into 2xSMT4 cores.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv.c              | 80 ++++++++++++++++++++++++++++++++-------
 hw/ppc/pnv_core.c         |  8 +++-
 include/hw/ppc/pnv.h      |  2 +
 include/hw/ppc/pnv_chip.h |  1 +
 include/hw/ppc/pnv_core.h |  1 +
 5 files changed, 78 insertions(+), 14 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 8827f729b1..07a29411a6 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1002,14 +1002,39 @@ static void pnv_init(MachineState *machine)
     pnv->num_chips =
         machine->smp.max_cpus / (machine->smp.cores * machine->smp.threads);
 
+    if (pnv->big_core) {
+        if (machine->smp.threads % 2 == 1) {
+            error_report("Cannot support %d threads with big-core option "
+                         "because it must be an even number",
+                         machine->smp.threads);
+            exit(1);
+        }
+        max_smt_threads *= 2;
+    }
+
     if (machine->smp.threads > max_smt_threads) {
         error_report("Cannot support more than %d threads/core "
                      "on %s machine", max_smt_threads, mc->desc);
+        if (pmc->max_smt_threads == 4) {
+            error_report("(use big-core=on for 8 threads per core)");
+        }
         exit(1);
     }
 
+    if (pnv->big_core) {
+        /*
+         * powernv models PnvCore as a SMT4 core. Big-core requires 2xPnvCore
+         * per core, so adjust topology here. pnv_dt_core() processor
+         * device-tree and TCG SMT code make the 2 cores appear as one big core
+         * from software point of view. pnv pervasive models and xscoms tend to
+         * see the big core as 2 small core halves.
+         */
+        machine->smp.cores *= 2;
+        machine->smp.threads /= 2;
+    }
+
     if (!is_power_of_2(machine->smp.threads)) {
-        error_report("Cannot support %d threads/core on a powernv"
+        error_report("Cannot support %d threads/core on a powernv "
                      "machine because it must be a power of 2",
                      machine->smp.threads);
         exit(1);
@@ -1048,6 +1073,8 @@ static void pnv_init(MachineState *machine)
                                 &error_fatal);
         object_property_set_int(chip, "nr-threads", machine->smp.threads,
                                 &error_fatal);
+        object_property_set_bool(chip, "big-core", pnv->big_core,
+                                &error_fatal);
         /*
          * The POWER8 machine use the XICS interrupt interface.
          * Propagate the XICS fabric to the chip and its controllers.
@@ -1175,11 +1202,17 @@ static void pnv_get_pir_tir_p9(PnvChip *chip,
                                 uint32_t core_id, uint32_t thread_id,
                                 uint32_t *pir, uint32_t *tir)
 {
-    if (pir) {
-        if (chip->nr_threads == 8) {
-            *pir = (chip->chip_id << 8) | ((thread_id & 1) << 2) |
-                   (core_id << 3) | (thread_id >> 1);
-        } else {
+    if (chip->big_core) {
+        /* Big-core interleaves thread ID between small-cores */
+        thread_id <<= 1;
+        thread_id |= core_id & 1;
+        core_id >>= 1;
+
+        if (pir) {
+            *pir = (chip->chip_id << 8) | (core_id << 3) | thread_id;
+        }
+    } else {
+        if (pir) {
             *pir = (chip->chip_id << 8) | (core_id << 2) | thread_id;
         }
     }
@@ -1203,11 +1236,17 @@ static void pnv_get_pir_tir_p10(PnvChip *chip,
                                 uint32_t core_id, uint32_t thread_id,
                                 uint32_t *pir, uint32_t *tir)
 {
-    if (pir) {
-        if (chip->nr_threads == 8) {
-            *pir = (chip->chip_id << 8) | ((core_id / 4) << 4) |
-                    ((core_id % 2) << 3) | thread_id;
-        } else {
+    if (chip->big_core) {
+        /* Big-core interleaves thread ID between small-cores */
+        thread_id <<= 1;
+        thread_id |= core_id & 1;
+        core_id >>= 1;
+
+        if (pir) {
+            *pir = (chip->chip_id << 8) | (core_id << 3) | thread_id;
+        }
+    } else {
+        if (pir) {
             *pir = (chip->chip_id << 8) | (core_id << 2) | thread_id;
         }
     }
@@ -2180,7 +2219,8 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
                                     &k->parent_realize);
 }
 
-static void pnv_chip_core_sanitize(PnvChip *chip, Error **errp)
+static void pnv_chip_core_sanitize(PnvMachineState *pnv, PnvChip *chip,
+                                   Error **errp)
 {
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
     int cores_max;
@@ -2201,6 +2241,17 @@ static void pnv_chip_core_sanitize(PnvChip *chip, Error **errp)
     }
     chip->cores_mask &= pcc->cores_mask;
 
+    /* Ensure small-cores a paired up in big-core mode */
+    if (pnv->big_core) {
+        uint64_t even_cores = chip->cores_mask & 0x5555555555555555ULL;
+        uint64_t odd_cores = chip->cores_mask & 0xaaaaaaaaaaaaaaaaULL;
+
+        if (even_cores ^ (odd_cores >> 1)) {
+            error_setg(errp, "warning: unpaired cores in big-core mode !");
+            return;
+        }
+    }
+
     /* now that we have a sane layout, let check the number of cores */
     cores_max = ctpop64(chip->cores_mask);
     if (chip->nr_cores > cores_max) {
@@ -2224,7 +2275,7 @@ static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
     }
 
     /* Cores */
-    pnv_chip_core_sanitize(chip, &error);
+    pnv_chip_core_sanitize(pnv, chip, &error);
     if (error) {
         error_propagate(errp, error);
         return;
@@ -2255,6 +2306,8 @@ static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
                                 &error_fatal);
         object_property_set_int(OBJECT(pnv_core), "hrmor", pnv->fw_load_addr,
                                 &error_fatal);
+        object_property_set_bool(OBJECT(pnv_core), "big-core", chip->big_core,
+                                &error_fatal);
         object_property_set_link(OBJECT(pnv_core), "chip", OBJECT(chip),
                                  &error_abort);
         qdev_realize(DEVICE(pnv_core), NULL, &error_fatal);
@@ -2288,6 +2341,7 @@ static Property pnv_chip_properties[] = {
     DEFINE_PROP_UINT32("nr-cores", PnvChip, nr_cores, 1),
     DEFINE_PROP_UINT64("cores-mask", PnvChip, cores_mask, 0x0),
     DEFINE_PROP_UINT32("nr-threads", PnvChip, nr_threads, 1),
+    DEFINE_PROP_BOOL("big-core", PnvChip, big_core, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 8cfa94fbfa..6dc05534d7 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -249,7 +249,12 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
     pir_spr->default_value = pir;
     tir_spr->default_value = tir;
 
-    env->core_index = core_hwid;
+    if (pc->big_core) {
+        /* 2 "small cores" get the same core index for SMT operations */
+        env->core_index = core_hwid >> 1;
+    } else {
+        env->core_index = core_hwid;
+    }
 
     /* Set time-base frequency to 512 MHz */
     cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
@@ -354,6 +359,7 @@ static void pnv_core_unrealize(DeviceState *dev)
 static Property pnv_core_properties[] = {
     DEFINE_PROP_UINT32("hwid", PnvCore, hwid, 0),
     DEFINE_PROP_UINT64("hrmor", PnvCore, hrmor, 0),
+    DEFINE_PROP_BOOL("big-core", PnvCore, big_core, false),
     DEFINE_PROP_LINK("chip", PnvCore, chip, TYPE_PNV_CHIP, PnvChip *),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 1993dededf..283ddd50e7 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -101,6 +101,8 @@ struct PnvMachineState {
     PnvPnor      *pnor;
 
     hwaddr       fw_load_addr;
+
+    bool         big_core;
 };
 
 PnvChip *pnv_get_chip(PnvMachineState *pnv, uint32_t chip_id);
diff --git a/include/hw/ppc/pnv_chip.h b/include/hw/ppc/pnv_chip.h
index 7d5d08bcdc..69d8273efe 100644
--- a/include/hw/ppc/pnv_chip.h
+++ b/include/hw/ppc/pnv_chip.h
@@ -27,6 +27,7 @@ struct PnvChip {
     uint64_t     ram_start;
     uint64_t     ram_size;
 
+    bool         big_core;
     uint32_t     nr_cores;
     uint32_t     nr_threads;
     uint64_t     cores_mask;
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 693acb189b..50164e9e1f 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -49,6 +49,7 @@ struct PnvCore {
 
     /*< public >*/
     PowerPCCPU **threads;
+    bool big_core;
     uint32_t pir;
     uint32_t hwid;
     uint64_t hrmor;
-- 
2.45.2


