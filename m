Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4410CC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 16:28:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTl1x-0008K3-R8; Tue, 16 Jul 2024 12:27:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl1B-0006O2-AV; Tue, 16 Jul 2024 12:27:13 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sTl19-0006TQ-3c; Tue, 16 Jul 2024 12:27:09 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70af22a9c19so4260667b3a.2; 
 Tue, 16 Jul 2024 09:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721147219; x=1721752019; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nwGrMKj4cs0jZjJ7yD0GR8qpP2HCKrG9RQwqRirqlHE=;
 b=GaYg8BfnUlDKq3PoowXHhYxxqjsmxk0DUP0YOg8QRfpUfTatRbePzrofIc8OS3QKFA
 posy5u50xPfaZQzPiMDTFEfA5BTsyyiQVMu5aUjcIn10kxlhaudUWseFkfHWKPE7tKDf
 DqgIAssMR0AWYdo4twr1yPf1HDSlHqnf+mTTU3gcSn5wwkzQFlNIL2wGc7CLdvVujzdU
 7L6/qBa6WhvXMjEltFZqoL8tKnXJNY5OMDhBU09ZH7cHqTtT/kGpFHk8rDNFtuEk/lPt
 fwf/XqxTCyWTEgFRf4HXgcXCMXp7Hf7/lXxNFGlKgssf5N5DI1mTw0CkY7X4pohbAfx1
 n/Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721147219; x=1721752019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nwGrMKj4cs0jZjJ7yD0GR8qpP2HCKrG9RQwqRirqlHE=;
 b=ptq8Lgjnr3uWju4v1h3nyrt8+g+cUOMf1lvivXB4hw12jbS5fvbEByUpy2xBFq6XhI
 a9/SxVg2B/SCYUX/WmeRJnxrkwHoS1j4iVbnPV1AkFyu9eXVcN5Sac5fnKpSHgGXJ+j+
 gXghuUl14/gRn0ZYqx4krKmWj5jtKktAOq/6WVylmAF+TgAH/9hqFCyek9hTxPu5TMGj
 dRf/JhYhRM8D0r8B7pHP2N665Q5k0GluZZ0FnMTsbGLhi+AsAqbfCtOY4jaFhvUqdmaa
 c1F+uM/bFjoe5852XX/rhOk4zq796Omm9EacJ1e2j6fCyCFFePgtRQUqZPIKB2pgAxbU
 imRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNNDnN9ccDMLGofb3MVptFkeB6PgVnoFGa/SeGNKyYnS+aIEzQ8jjnbhpAWwTgymm2wscrIoqG/1hXQdUtL41nvDKkDTg=
X-Gm-Message-State: AOJu0Yy+pwHEVfhfZIz/fC9jFJoFWCdSMh8bamUA3PN52zpha7EZy1KL
 P8yjs/NVVmPkk7M7gvBsMmM6qcHcXKgeJxccqzBj+IRRPeM/6mFPDAV3FA==
X-Google-Smtp-Source: AGHT+IFkxxBoA2u1gV74km9hiM18CYwTzj7RxM8usCgNp3pXrhazc1g3zHYkfP9kNdyREmi7aIRH5g==
X-Received: by 2002:a05:6a00:a1a:b0:705:a7a6:6d11 with SMTP id
 d2e1a72fcca58-70c2e9b4b50mr3401535b3a.24.1721147219452; 
 Tue, 16 Jul 2024 09:26:59 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eca86d6sm6722161b3a.179.2024.07.16.09.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 09:26:59 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 09/19] ppc: Add has_smt_siblings property to CPUPPCState
Date: Wed, 17 Jul 2024 02:26:05 +1000
Message-ID: <20240716162617.32161-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240716162617.32161-1-npiggin@gmail.com>
References: <20240716162617.32161-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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

The decision to branch out to a slower SMT path in instruction
emulation will become a bit more complicated with the way that
"big-core" topology that will be implemented in subsequent changes.
Hide these details from the wider CPU emulation code with a bool
has_smt_siblings flag that can be set by machine initialisation.

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h        |  3 ++-
 hw/ppc/pnv_core.c       |  3 +++
 hw/ppc/spapr_cpu_core.c | 12 +++++++++---
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 417b284318..321ed2da75 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1248,6 +1248,7 @@ struct CPUArchState {
     int access_type;
 
     /* For SMT processors */
+    bool has_smt_siblings;
     int core_index;
 
 #if !defined(CONFIG_USER_ONLY)
@@ -1514,7 +1515,7 @@ struct PowerPCCPUClass {
 
 static inline bool ppc_cpu_core_single_threaded(CPUState *cs)
 {
-    return cs->nr_threads == 1;
+    return !POWERPC_CPU(cs)->env.has_smt_siblings;
 }
 
 static inline bool ppc_cpu_lpar_single_threaded(CPUState *cs)
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 7bda29b9c7..8cfa94fbfa 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -288,6 +288,9 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
         cpu = POWERPC_CPU(obj);
 
         pc->threads[i] = POWERPC_CPU(obj);
+        if (cc->nr_threads > 1) {
+            cpu->env.has_smt_siblings = true;
+        }
 
         snprintf(name, sizeof(name), "thread[%d]", i);
         object_property_add_child(OBJECT(pc), name, obj);
diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
index 4e13e6993a..2c6eeb41a4 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -351,9 +351,15 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
     qemu_register_reset(spapr_cpu_core_reset_handler, sc);
     sc->threads = g_new0(PowerPCCPU *, cc->nr_threads);
     for (i = 0; i < cc->nr_threads; i++) {
-        sc->threads[i] = spapr_create_vcpu(sc, i, errp);
-        if (!sc->threads[i] ||
-            !spapr_realize_vcpu(sc->threads[i], spapr, sc, i, errp)) {
+        PowerPCCPU *cpu;
+
+        cpu = spapr_create_vcpu(sc, i, errp);
+        sc->threads[i] = cpu;
+        if (cpu && cc->nr_threads > 1) {
+            cpu->env.has_smt_siblings = true;
+        }
+
+        if (!cpu || !spapr_realize_vcpu(cpu, spapr, sc, i, errp)) {
             spapr_cpu_core_unrealize(dev);
             return;
         }
-- 
2.45.1


