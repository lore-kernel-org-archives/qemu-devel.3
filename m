Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECD1C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:28:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTl2P-0002J7-B0; Tue, 16 Jul 2024 12:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl1F-0006V5-KH; Tue, 16 Jul 2024 12:27:17 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl1A-0006WV-1f; Tue, 16 Jul 2024 12:27:10 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-70af8128081so3885119b3a.1; 
 Tue, 16 Jul 2024 09:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721147223; x=1721752023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z2WZMohObGeDSAqehCGzt7eT5JqWsK9VYJvFmu0NkFE=;
 b=MDM0WPhxDLS63STlovLvVrFHaM6LgMXnFUib7sPDYdZDnqTOiiDaJx7y8Dv5HQbfEY
 67SKDctHMvr755IFo+0cr8a8X9Y0/YQekc3/eYJCewSfFgCm6F2rW60onyj6Wt1HH9gY
 ZQ8bJ2oZKecn+av0Py0zvbUhWxJSJHWv25PuTyv0I+v+BWmkVtE+Fd3ldvms1EKFUCxJ
 iu4OMYUWaJFtDG4rBUsakGd0FhXrltpb03n+JsK33Zt7BKsNpH1B9ubhEBQZ7Qn8RIea
 m3vYYhwD5ThYfA0ZMaQn+QznTPp3wMunfA6LL766OR9kHcSrwxiP1eSbQQCmUM86Xstt
 xZnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721147223; x=1721752023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z2WZMohObGeDSAqehCGzt7eT5JqWsK9VYJvFmu0NkFE=;
 b=NxrnMZgx54lFgIb2qP25PUN9QDo6ITmSVFwg04ZZQP4JIk6k6YysN2mFaKfabkm5KU
 9lQqFw34es4MVIOF1vm7s++41eR/cj8m6kpxtV0zq619smhTzSerl1Hpd+RAKlsz++Xe
 phGtgAc4VagQu75PBeO1/bdKM8QDTtvZ/3Iy+w78GEVUl953InQ3/D9VA0Vvrc5CW0dY
 FyBE0TO/bf3YngPN7C/Csmt3dwwHkSg+8YddhknpnM2Pb6tw5QfkdRD2hG9o7m+WPBmC
 qORmWToalFECaqRNE6zO3S68MxHinoohaQNoCbkQnkNk6SqQ6f12ltdPMldYTCP8BUtZ
 Uv7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvdnzqjdu3pLyydkNXhYw4XKVJfpr0PTfhcvGZUapGiCAs8gvQ5SGjUPs8sViKHdXxKFnPtqrVpSnhlE0gPuT3QXO9R9c=
X-Gm-Message-State: AOJu0YzUpgbC7b7p72vmJ+Jcncu1SM1noNUN6PL9xbT84cbpiUJfnaO+
 pfqGQXRf640jzT7r3C0YaOQSklgkMumITodbid/WbWUNVUbijZ+8SKeDQg==
X-Google-Smtp-Source: AGHT+IH6RRHSntN7spo7FOEur483LC6RDgdAPvfD/gWl92jx0FjY58XHXHERBXhq7m9lDhp2b+FCFw==
X-Received: by 2002:a05:6a21:3213:b0:1c0:bf35:ef4c with SMTP id
 adf61e73a8af0-1c3f11f1618mr3025033637.11.1721147223054; 
 Tue, 16 Jul 2024 09:27:03 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eca86d6sm6722161b3a.179.2024.07.16.09.26.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 09:27:02 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH v3 10/19] ppc/pnv: Add a big-core mode that joins two regular
 cores
Date: Wed, 17 Jul 2024 02:26:06 +1000
Message-ID: <20240716162617.32161-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240716162617.32161-1-npiggin@gmail.com>
References: <20240716162617.32161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
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
 include/hw/ppc/pnv.h      |  2 +
 include/hw/ppc/pnv_chip.h |  1 +
 include/hw/ppc/pnv_core.h |  1 +
 hw/ppc/pnv.c              | 80 ++++++++++++++++++++++++++++++++-------
 hw/ppc/pnv_core.c         |  8 +++-
 5 files changed, 78 insertions(+), 14 deletions(-)

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
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index eee34ca926..d902860ecd 100644
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
-- 
2.45.1


