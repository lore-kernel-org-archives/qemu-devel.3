Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C7BC3DA4D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 12:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSF0a-0007lg-2w; Fri, 12 Jul 2024 08:04:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSF0P-0007Ek-8j; Fri, 12 Jul 2024 08:04:05 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sSF0I-0005lC-VX; Fri, 12 Jul 2024 08:04:04 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-706524adf91so1638025b3a.2; 
 Fri, 12 Jul 2024 05:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720785834; x=1721390634; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sqrzDK8wkTq/L5krI5RVW4u/qudiQvRHJA8S9u6V2LU=;
 b=A4P72KGkuf/O7SggZeWWCzf7wQT3KtjZJ7sc027E+kz39zbjCmdBsakTok6eY9LMmj
 e0IaB5rBGq6gNWDRrhdzVukwO0AlHmNJgl+4RDgLftZlH+RkCXL8YLURtIJ881RXVmxk
 OBLd8lVcBiFY6+K+VQJuMDdkEHlEqpj20E57LOAKTDEdAMTeMmBGTRuheT+HPfsS1A8N
 Wf1eYKmRcUFayIVWILrndzpnuF8oHhQv+cz8XjfEsPdhiWrPV8T/Af+7ZF2I2zKLq2Dj
 Vh0t1IxENuSElsUroisvLRQQEToA/Qq39q+8yQLw8k0Tga5IVEo10W7vc8psrKEThlMu
 EYBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720785834; x=1721390634;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sqrzDK8wkTq/L5krI5RVW4u/qudiQvRHJA8S9u6V2LU=;
 b=nN+sXaPa4smd6C2qKxFrHzHr5/Cuh84kZ9Sd1eLcQCh1cihL+vfPYOcdlDEfNMv4UB
 Hm3DRvWKGOeNRE1EWnBl+tKbrZzIGULj/QEUySTt9hH/xXbhp5ser1cuO/DResdcoF9C
 nO7aYyPyVV1GWVqMTyBzZd6Nf1YqwoMXqy1UFhAa/21vGXHs9TEA9NA5ytawfmc0Cz3d
 ZX6pgsjEvAyfVikj+22hoNwDb1DZ4asJ1wxJBVgsppwLopDMeX0fT5wWP3WbZE2Wyu21
 NvFmJK+D8zlWDsjdc9JPg53fQxoz9xDSH5T4ZHPIwqrQxI+KgUO7yUmY0Ydm3nzYKKT4
 uxDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU43tl+6xDI2ERPndOGLEHODg1+pz8SAKs5EF+gv5H8sEGGvimowRmQCz7JdqHdtTkAog/BrPFd1zmc8vFaNnmuA9QStYQ=
X-Gm-Message-State: AOJu0Yy89wu1S28wcFUOYQ4dIYvzYdcbZIOexyewMFGaIVHnW7WxUv/C
 1g9Z4V2TKc7i0yFr2VePLYQ2N9lk7OeeyfgEM3q8kfL1jtV/x39N3RJogA==
X-Google-Smtp-Source: AGHT+IGUb3+4YNWxw8JvuNUFHAX23Ml9NK3YwZYylQ9KoDvfRJ8OinGvAtGKWafxS8lJkG8PBmYrDQ==
X-Received: by 2002:a05:6a21:3393:b0:1be:c2af:5626 with SMTP id
 adf61e73a8af0-1c298209096mr13417390637.4.1720785834472; 
 Fri, 12 Jul 2024 05:03:54 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b438c0a1csm7308967b3a.63.2024.07.12.05.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jul 2024 05:03:54 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 07/19] ppc: Add a core_index to CPUPPCState for SMT vCPUs
Date: Fri, 12 Jul 2024 22:02:34 +1000
Message-ID: <20240712120247.477133-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240712120247.477133-1-npiggin@gmail.com>
References: <20240712120247.477133-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The way SMT thread siblings are matched is clunky, using hard-coded
logic that checks the PIR SPR.

Change that to use a new core_index variable in the CPUPPCState,
where all siblings have the same core_index. CPU realize routines have
flexibility in setting core/sibling topology.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h        | 9 +++++----
 hw/ppc/pnv_core.c       | 2 ++
 hw/ppc/spapr_cpu_core.c | 4 ++++
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 95ba9e7590..7b52a9bb18 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1247,6 +1247,9 @@ struct CPUArchState {
     /* when a memory exception occurs, the access type is stored here */
     int access_type;
 
+    /* For SMT processors */
+    int core_index;
+
 #if !defined(CONFIG_USER_ONLY)
     /* MMU context, only relevant for full system emulation */
 #if defined(TARGET_PPC64)
@@ -1402,12 +1405,10 @@ struct CPUArchState {
     uint64_t pmu_base_time;
 };
 
-#define _CORE_ID(cs)                                            \
-    (POWERPC_CPU(cs)->env.spr_cb[SPR_PIR].default_value & ~(cs->nr_threads - 1))
-
 #define THREAD_SIBLING_FOREACH(cs, cs_sibling)                  \
     CPU_FOREACH(cs_sibling)                                     \
-        if (_CORE_ID(cs) == _CORE_ID(cs_sibling))
+        if (POWERPC_CPU(cs)->env.core_index ==                  \
+            POWERPC_CPU(cs_sibling)->env.core_index)
 
 #define SET_FIT_PERIOD(a_, b_, c_, d_)          \
 do {                                            \
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 28ca61926d..7bda29b9c7 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -249,6 +249,8 @@ static void pnv_core_cpu_realize(PnvCore *pc, PowerPCCPU *cpu, Error **errp,
     pir_spr->default_value = pir;
     tir_spr->default_value = tir;
 
+    env->core_index = core_hwid;
+
     /* Set time-base frequency to 512 MHz */
     cpu_ppc_tb_init(env, PNV_TIMEBASE_FREQ);
 }
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 21920ea054..4e13e6993a 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -302,11 +302,13 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **errp)
     g_autofree char *id = NULL;
     CPUState *cs;
     PowerPCCPU *cpu;
+    CPUPPCState *env;
 
     obj = object_new(scc->cpu_type);
 
     cs = CPU(obj);
     cpu = POWERPC_CPU(obj);
+    env = &cpu->env;
     /*
      * All CPUs start halted. CPU0 is unhalted from the machine level reset code
      * and the rest are explicitly started up by the guest using an RTAS call.
@@ -317,6 +319,8 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **errp)
         return NULL;
     }
 
+    env->core_index = cc->core_id;
+
     cpu->node_id = sc->node_id;
 
     id = g_strdup_printf("thread[%d]", i);
-- 
2.45.1


