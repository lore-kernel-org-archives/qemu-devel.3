Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3993C3DA70
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 23:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sX8Jb-0001tG-4E; Thu, 25 Jul 2024 19:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8JR-0001Ik-5N; Thu, 25 Jul 2024 19:55:57 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sX8JO-000116-Qx; Thu, 25 Jul 2024 19:55:56 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-71871d5e087so301811a12.1; 
 Thu, 25 Jul 2024 16:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721951753; x=1722556553; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=790+zvgSmRIv7Avky6Q8FbRkbwVRDffSULN2+eVSjwM=;
 b=kDAwMqACHgqNFOd1o7BjgiYt1CxgMU9ZGzgoqQKPhC/+9crcAVcVi8xWEo/ETjlFp2
 LqmNk8IeLmEsl8VeObxTv9KddVQkSj4X9vfYugronVXyiDt02jX/X6ih9wQ7tOj1bHEg
 Sb/mjp/GxsU482drQ6JEs3qP9UFhSiCyDgTTG330AmMYWW8tsSbLzh1tKOR9z6q3dbKn
 Ji131qB3m3MRrwIXXbDDNJE7rKW/3tLQxpddLDraLXhsAZ4wtJTxvqdvQLhlJQhUAh/B
 IGiFJt8vNkRedBEubzBbVMVSNAd7w/nc1+f5QRbMs/vjSX3lpfTXxUjBvKzUNAkstRkM
 ZzQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721951753; x=1722556553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=790+zvgSmRIv7Avky6Q8FbRkbwVRDffSULN2+eVSjwM=;
 b=G76Ip48x5KL/fSzA0M39mnAeA4KjeAegWzMgRzb/aqoo9YfSiQeQdk1GjiZ7V0AMAg
 MSkUOoiE1+jJZJPHJ94fQm4yKRCR46VUHopWCKY/qNUbkr3NyoxE05H5eOcKhMUiowcA
 TuyOgkmqiFpCdfWEhEYRCShmxNt42Wa44SHyXZ193hwvOmyr1B7OFtXlvdqgplkGVexJ
 K5nxzBDx2qmUCMR/l2m4Ni+3J8cpDHSDbFawArFbgQYhVaYl+SR1VDyIq8tswfGWXc15
 JNAVNSfOrgKfU2hlTtzG7ariHFqysKeE1/ZSkZzSJJ134WObxuqSBygmlDPtC1NFGM6l
 jefw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYbfftKNT7FmvwlfN2MISBu1cpnrk1C5904t9OmPvR3rt8jP7xgmLUF3WBamZFEMzwmalK5sNgNWqYg7vVxJX4vYDt
X-Gm-Message-State: AOJu0Yyn7bbgYPH6DERMFnB2uJu0bqqfv6MqAGgFISmHSS+JZ9tHwbqV
 rGv9qCwcDQ3TfGVUoqnJgMQthxKq2fnRGQBtL3JV1nVrEB7GUfdYsoU2WQ==
X-Google-Smtp-Source: AGHT+IEcfw6p6NuPMuIF/ZfAvhnT47PfSsp8f2ZlpzRUtfcfd0Z7cHta32bAErcHBfZnmsy3xRhJ3A==
X-Received: by 2002:a05:6a21:3397:b0:1be:c2af:5626 with SMTP id
 adf61e73a8af0-1c4728035e9mr6208181637.4.1721951752848; 
 Thu, 25 Jul 2024 16:55:52 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cf28c7fef3sm2142060a91.16.2024.07.25.16.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 16:55:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 24/96] ppc: Add a core_index to CPUPPCState for SMT vCPUs
Date: Fri, 26 Jul 2024 09:52:57 +1000
Message-ID: <20240725235410.451624-25-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725235410.451624-1-npiggin@gmail.com>
References: <20240725235410.451624-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52c.google.com
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
 hw/ppc/pnv_core.c       | 2 ++
 hw/ppc/spapr_cpu_core.c | 4 ++++
 target/ppc/cpu.h        | 9 +++++----
 3 files changed, 11 insertions(+), 4 deletions(-)

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
index e7c9edd033..b228c1d498 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -300,11 +300,13 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **errp)
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
@@ -315,6 +317,8 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **errp)
         return NULL;
     }
 
+    env->core_index = cc->core_id;
+
     cpu->node_id = sc->node_id;
 
     id = g_strdup_printf("thread[%d]", i);
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
-- 
2.45.2


