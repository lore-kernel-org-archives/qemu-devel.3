Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2683DC25B7F
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2024 12:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBCxz-0006S2-Lq; Sun, 26 May 2024 08:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBCxs-0006QA-Is; Sun, 26 May 2024 08:27:04 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sBCxp-0001RA-Jl; Sun, 26 May 2024 08:27:03 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f8eba8dcfcso2015379b3a.3; 
 Sun, 26 May 2024 05:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716726420; x=1717331220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OCbkg9lZkZXR/mXkM6iz+uTsoSDA5X46SqNa8sbU4og=;
 b=lC3zYzHK0KlYmBY75myl2L1EfW10RYj47XZgC7cnC/vV7b6aj0jZtzX+Wgz3RWPesq
 /AazIQQAuB2lPiuaX8Itcenzs+9jHtUyj6moKzxKDdyTmfc70euRwObVXSA73NDHiDy3
 JMfQnFe0cm0HW/pNItGS16R/JBXbmrtJxC5ho5hjPqH2pPEiJdrj2iEwKku2Je2xQigY
 6PcPbNMSjKyI4IGIgqVsB6mx7SmI/7i/0H4TlVBqUHQATzUvXUKMIWnhRmhGF6Tuj0pX
 FL3vX9LRKTx0XfK9dL/HUMOEOz8b7I5dBoGr4qQTetdGyAF36LXPHLwpxWmvSxjhrckk
 nijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716726420; x=1717331220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OCbkg9lZkZXR/mXkM6iz+uTsoSDA5X46SqNa8sbU4og=;
 b=jvdU1mpXuMCSjLe4asUR4sDlnzF9HGD+LPQ2PL4BXiCDWGbc4dtcLY8T3LLSiUVPdW
 o3jfuUZXu1XcQFm20+xlwo8DYX8tmqHNU9uA+MPhzGu11PiKSEewWkpLe65zHOOYHZZX
 kLZMCRr8G68jY8x9NfRWt9/e7PxE7XIVCSyCsQVKpcgwUYiTj7jSfcBxbSLTXH1/poDE
 LYHgSRnSrSLLZdZNeDiqcRYCp+pq3kAC8CvnOmkzUoySAYaQyl0ZexyyDg4+zm3vGuw8
 zYGYPxIb46f9DdSI0/FmH016YJVVIiLWWb1EfAEykL7uha7zqxcNwwdgoW1B7Gm7dW+t
 OKDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXn7yCoW+XYv6jPsEkmYxi2TUK39czkHHvedCBdI+yKk4MRBGY0it0KVSh3FcEPVA2hNZme1qDoZSt2v9m2f7bxr2qxW3c=
X-Gm-Message-State: AOJu0YwYXXu/ZIjNCTKWDnrUcMimi7XGQ//okVk3/34S3QS+Sqtlh/kn
 4i70TPF0aRuGzFIZ5Ng720UYRZzYjQfscW7rJ2kFcJolqs/97afgprzvqA==
X-Google-Smtp-Source: AGHT+IFJSR3pUIKM5ObBlg1ANFvKPQ7KM9BV4D5fnrRbcyFy/np4CIIiqEz7oi7wCe3FFnDqjrSvjw==
X-Received: by 2002:a05:6a21:7795:b0:1ad:92c1:9f23 with SMTP id
 adf61e73a8af0-1b212e72569mr7519095637.61.1716726419680; 
 Sun, 26 May 2024 05:26:59 -0700 (PDT)
Received: from wheely.local0.net (110-175-65-7.tpgi.com.au. [110.175.65.7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-6f8fcfe648bsm3457182b3a.168.2024.05.26.05.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 May 2024 05:26:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Subject: [RFC PATCH 10/10] ppc/pnv: Add an LPAR per core machine option
Date: Sun, 26 May 2024 22:26:11 +1000
Message-ID: <20240526122612.473476-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526122612.473476-1-npiggin@gmail.com>
References: <20240526122612.473476-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

Recent POWER CPUs can operate in "LPAR per core" or "LPAR per thread"
modes. In per-core mode, some SPRs and IPI doorbells are shared between
threads in a core. In per-thread mode, supervisor and user state is
not shared between threads.

OpenPOWER systems use LPAR per thread mode as it is required for KVM.
Enterprise systems use LPAR per core mode, as they partition the
machine by core.

Implement a lpar-per-core machine option for powernv machines. This
is supported on POWER9 and POWER10.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 include/hw/ppc/pnv.h      |  1 +
 include/hw/ppc/pnv_core.h |  1 +
 hw/ppc/pnv.c              | 29 +++++++++++++++++++++++++++++
 hw/ppc/pnv_core.c         |  8 ++++++++
 target/ppc/cpu_init.c     |  3 ++-
 5 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index bec603f1a8..8f75c715d8 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -103,6 +103,7 @@ struct PnvMachineState {
 
     bool         big_core;
     bool         big_core_tbst_quirk;
+    bool         lpar_per_core;
 };
 
 PnvChip *pnv_get_chip(PnvMachineState *pnv, uint32_t chip_id);
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index 9599da15ea..e41b6347ea 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -57,6 +57,7 @@ struct PnvCore {
     /*< public >*/
     PowerPCCPU **threads;
     bool big_core;
+    bool lpar_per_core;
     uint32_t pir;
     uint32_t hwid;
     uint64_t hrmor;
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 765142965f..0d830ad731 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1108,12 +1108,17 @@ static void pnv_init(MachineState *machine)
 
 static void pnv_power8_init(MachineState *machine)
 {
+    PnvMachineState *pnv = PNV_MACHINE(machine);
+
     if (machine->smp.threads > 8) {
         error_report("Cannot support more than 8 threads/core "
                      "on a powernv POWER8 machine");
         exit(1);
     }
 
+    /* POWER8 is always lpar-per-core. */
+    pnv->lpar_per_core = true;
+
     pnv_init(machine);
 }
 
@@ -2541,6 +2546,18 @@ static void pnv_machine_set_big_core(Object *obj, bool value, Error **errp)
     pnv->big_core = value;
 }
 
+static bool pnv_machine_get_1lpar(Object *obj, Error **errp)
+{
+    PnvMachineState *pnv = PNV_MACHINE(obj);
+    return pnv->lpar_per_core;
+}
+
+static void pnv_machine_set_1lpar(Object *obj, bool value, Error **errp)
+{
+    PnvMachineState *pnv = PNV_MACHINE(obj);
+    pnv->lpar_per_core = value;
+}
+
 static bool pnv_machine_get_hb(Object *obj, Error **errp)
 {
     PnvMachineState *pnv = PNV_MACHINE(obj);
@@ -2614,6 +2631,12 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
                                    pnv_machine_set_big_core);
     object_class_property_set_description(oc, "big-core",
                               "Use big-core (aka fused-core) mode");
+
+    object_class_property_add_bool(oc, "lpar-per-core",
+                                   pnv_machine_get_1lpar,
+                                   pnv_machine_set_1lpar);
+    object_class_property_set_description(oc, "lpar-per-core",
+                              "Use 1 LPAR per core mode");
 }
 
 static void pnv_machine_p10_common_class_init(ObjectClass *oc, void *data)
@@ -2660,6 +2683,12 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
                                    pnv_machine_set_big_core);
     object_class_property_set_description(oc, "big-core",
                               "Use big-core (aka fused-core) mode");
+
+    object_class_property_add_bool(oc, "lpar-per-core",
+                                   pnv_machine_get_1lpar,
+                                   pnv_machine_set_1lpar);
+    object_class_property_set_description(oc, "lpar-per-core",
+                              "Use 1 LPAR per core mode");
 }
 
 static void pnv_machine_p10_rainier_class_init(ObjectClass *oc, void *data)
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 835c35d90b..e510909db1 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -207,6 +207,9 @@ static uint64_t pnv_core_power10_xscom_read(void *opaque, hwaddr addr,
                 val |= PPC_BIT(56 + i);
             }
         }
+        if (pc->lpar_per_core) {
+            val |= PPC_BIT(62);
+        }
         break;
     case PNV10_XSCOM_EC_CORE_THREAD_INFO:
         break;
@@ -322,6 +325,11 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
         env->core_index = core_hwid;
     }
 
+    if (pnv->lpar_per_core) {
+        pc->lpar_per_core = true;
+        cpu_ppc_set_1lpar(cpu);
+    }
+
     /* Set time-base frequency to 512 MHz */
     cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
 }
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index e71ee008ed..f0065c2e37 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -6785,7 +6785,8 @@ void cpu_ppc_set_1lpar(PowerPCCPU *cpu)
 
     /*
      * pseries SMT means "LPAR per core" mode, e.g., msgsndp is usable
-     * between threads.
+     * between threads. powernv be in either mode, and it mostly affects
+     * supervisor visible registers and instructions.
      */
     if (env->flags & POWERPC_FLAG_SMT) {
         env->flags |= POWERPC_FLAG_SMT_1LPAR;
-- 
2.43.0


