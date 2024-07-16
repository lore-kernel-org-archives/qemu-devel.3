Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73357C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTl2W-0003zu-QN; Tue, 16 Jul 2024 12:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl19-0006Ny-UK; Tue, 16 Jul 2024 12:27:12 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl0y-0006SI-KX; Tue, 16 Jul 2024 12:27:05 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70af8062039so3930527b3a.0; 
 Tue, 16 Jul 2024 09:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721147212; x=1721752012; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sqrzDK8wkTq/L5krI5RVW4u/qudiQvRHJA8S9u6V2LU=;
 b=ThpYeH9/hFZq+GU+9ZaudGHCkyEKmkrHF/I8G1vhG2cGD+l9HJ7EnIKEM3BLaXwQtl
 GZlQxbsFCqaJ1qRG9fYawUpv1OCIoVZ0ZyHpZhK1iIkFvJ2TnPwzPdmgUJSkyE98FYeO
 +6aPaVO4ehm9OKIjFrw92kMoRDkDFVqovfc+v1N2eaqTnFfiVUTHsm1NrZpllZAR8L6A
 Y/+ggEgLm4QaBPD5Ca6OQpFjB9eapavoBYfou8tu7PcZrsRQChbg7Mi2bqYc3MKu1zmN
 fh36hjndhRp235Kh/Nm6+zAEJTWMGWvL44xQFkJ6prPXb7puWQfR/SgX7tHzWYAmCI2T
 fEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721147212; x=1721752012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sqrzDK8wkTq/L5krI5RVW4u/qudiQvRHJA8S9u6V2LU=;
 b=QbDPVb04J1RjZrKelfBiSN6AZZ0Y8ojqdWqVsOVW7KnXTeed79PCEf8JRZ7JUe8R8O
 EGJfOagjFrIRywaWxy2gToiodKXvPETYi9vD520fs2Y+lvMEf5RyVwhxAtJjWD/Ez2Dr
 gWpGhN/m+MT5lsLRApS1Kg0AzvUh0ujG0CyHtSJySmolDnDU8qzHNn72RyVxk75pUCsD
 WowpExKzSuBaNDNjsglKKDX9ei1nFr4UyWTF9RysOsek3J4GbUAB8nSevP50EKqLIiqm
 GDNfoRdvmZLoCH+67nbRZXWgBjX4IyY5XVaj5WDUIn6Ywq6hF+wIX6PXhWlL/83HrUOZ
 Bo5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWu61+HmSZIG5LT67t73Bn1R+xaapRf2KM8cee2bAnOauDPTs9cxSBhxzJqUZFHiNN7HGRk11Ett/H+v9Qkayz3JygSQHA=
X-Gm-Message-State: AOJu0YwMkuEFQNAatdLUrUvNLHrbnMiyf7Q8MkM49Fb7feHMQL6terB7
 2bvih2xA3B/EZ+4w7HtiJ8XjknSihIrp//h09x0ztbQDrGtper87PoVfqQ==
X-Google-Smtp-Source: AGHT+IG7Nki7IW/0NrKWMXHwmqbes6tmbvplh5ZZw19RVHFjBW6x12Zb7jSYUtN1Tzb+oJBt23IC5Q==
X-Received: by 2002:a05:6a00:1950:b0:705:9b04:71b with SMTP id
 d2e1a72fcca58-70c2ea27abfmr2976192b3a.31.1721147212194; 
 Tue, 16 Jul 2024 09:26:52 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eca86d6sm6722161b3a.179.2024.07.16.09.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 09:26:51 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 07/19] ppc: Add a core_index to CPUPPCState for SMT vCPUs
Date: Wed, 17 Jul 2024 02:26:03 +1000
Message-ID: <20240716162617.32161-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240716162617.32161-1-npiggin@gmail.com>
References: <20240716162617.32161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42c.google.com
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


