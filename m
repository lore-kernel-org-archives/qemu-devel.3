Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398F6C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 14:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRueE-0005O0-9r; Thu, 11 Jul 2024 10:19:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRueB-0005Ct-NY; Thu, 11 Jul 2024 10:19:47 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRue9-0005WM-Ru; Thu, 11 Jul 2024 10:19:47 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70af5fbf0d5so667897b3a.1; 
 Thu, 11 Jul 2024 07:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720707584; x=1721312384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvkgUoe55ZrWbdSf3vk0rD7Fyim0e+VPTeNFk/b/LZk=;
 b=kZ/j0BgFHeccUo1OaVxmXXjXcRPRXvxY6P6s+7truPG9I0xcYX4DCtCwfb0p0Fy91N
 nUD1WS+zc3/Lw9NO7FaQw5LM+LzNyjTxQcj8Umud8wqril67TQ6KKYIICmRS/tz9d11A
 xxk9eGP773/WFLQQhqeLePZYjLaanev9syCjm4Ku8uzh5EYWc5MieuKhYpXSeG96Rv6h
 DS8tNjrs+/W4dY+fF7nrHmn+nznDYe836BbrDSKXBWkzofNTWZ/5KWYEYhaBOgBiJAZ9
 RMf6GfzZg+tNaMKLxoqCvT4YSoXfwnbZirwsFicS9gW9eqW4StibqgYYlFLF6qmUOMED
 vXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720707584; x=1721312384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HvkgUoe55ZrWbdSf3vk0rD7Fyim0e+VPTeNFk/b/LZk=;
 b=UncRgrUf5lN0ZLpHT8qH0dhskv6eXdUByvk1CBDqUee4rM/lLHM1RalYUjwoq+e9vo
 AjKarc0cueuhaXqyQZH9gf8d7HI9ycBnUmhdSli7g9wb7bYsHBmJypoMyw2U/qEsrEfM
 K3SF7HtKBB/AIvep7cQTXHK2bRAWpYigb2jIirBcoNL43NbSjh6p/fZ3t1oAnh93fQ7d
 ZE3PR3qLTaZt8KTbT8U3mVrop81gt8KKE7LppAbBvMMDdh6QfAAKculMorOR0DD5chLa
 HL4SCKytFw+U9TIDhgpbzycbYXBHxIfopc7EfCqIYP/P4WwLOJP5cWYtr3RRZm9a4S7X
 jUVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFFebjfK5saQCj50E4Q1xA/YjYZIare6Kh+gVzJnZ2JpTgcmO5PBDWT9ic1wForeJgdnY1NQvajbY6JuNDI/QKQSp6C8U=
X-Gm-Message-State: AOJu0YxOWK4DTUQQcImf09lbk7QBZC+9jG5RKbLAbI/KoBiNBcmJ38vX
 /3r5yoWGKzRFEf9SOpOOOPz8zLtS84FI3KQf4oyEMQRQObrJfhO5SGwpAgzl
X-Google-Smtp-Source: AGHT+IHGxOyey2MidNkxnErralrZ7WpXZKPN5faA2/LuHP4UbzVFnTXZ6IsQHvJ7/lASQkqfd89MCQ==
X-Received: by 2002:a05:6a00:194e:b0:6f6:76c8:122c with SMTP id
 d2e1a72fcca58-70b61dcb17emr2209223b3a.16.1720707583649; 
 Thu, 11 Jul 2024 07:19:43 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b54ec730fsm3308904b3a.173.2024.07.11.07.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 07:19:43 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 11/18] ppc/pnv: Add a big-core mode that joins two regular
 cores
Date: Fri, 12 Jul 2024 00:18:43 +1000
Message-ID: <20240711141851.406677-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240711141851.406677-1-npiggin@gmail.com>
References: <20240711141851.406677-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
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
 include/hw/ppc/pnv_core.h |  1 +
 hw/ppc/pnv.c              | 79 ++++++++++++++++++++++++++++++++-------
 hw/ppc/pnv_core.c         |  7 +++-
 4 files changed, 75 insertions(+), 14 deletions(-)

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
index b593a41f7c..d2ddc49142 100644
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
@@ -1175,11 +1200,19 @@ static void pnv_get_pir_tir_p9(PnvChip *chip,
                                 uint32_t core_id, uint32_t thread_id,
                                 uint32_t *pir, uint32_t *tir)
 {
-    if (pir) {
-        if (chip->nr_threads == 8) {
-            *pir = (chip->chip_id << 8) | ((thread_id & 1) << 2) |
-                   (core_id << 3) | (thread_id >> 1);
-        } else {
+    PnvMachineState *pnv = PNV_MACHINE(chip->pnv_machine);
+
+    if (pnv->big_core) {
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
@@ -1203,11 +1236,19 @@ static void pnv_get_pir_tir_p10(PnvChip *chip,
                                 uint32_t core_id, uint32_t thread_id,
                                 uint32_t *pir, uint32_t *tir)
 {
-    if (pir) {
-        if (chip->nr_threads == 8) {
-            *pir = (chip->chip_id << 8) | ((core_id / 4) << 4) |
-                    ((core_id % 2) << 3) | thread_id;
-        } else {
+    PnvMachineState *pnv = PNV_MACHINE(chip->pnv_machine);
+
+    if (pnv->big_core) {
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
@@ -2180,7 +2221,8 @@ static void pnv_chip_power10_class_init(ObjectClass *klass, void *data)
                                     &k->parent_realize);
 }
 
-static void pnv_chip_core_sanitize(PnvChip *chip, Error **errp)
+static void pnv_chip_core_sanitize(PnvMachineState *pnv, PnvChip *chip,
+                                   Error **errp)
 {
     PnvChipClass *pcc = PNV_CHIP_GET_CLASS(chip);
     int cores_max;
@@ -2201,6 +2243,17 @@ static void pnv_chip_core_sanitize(PnvChip *chip, Error **errp)
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
@@ -2224,7 +2277,7 @@ static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
     }
 
     /* Cores */
-    pnv_chip_core_sanitize(chip, &error);
+    pnv_chip_core_sanitize(pnv, chip, &error);
     if (error) {
         error_propagate(errp, error);
         return;
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 8cfa94fbfa..16d40392db 100644
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
-- 
2.45.1


