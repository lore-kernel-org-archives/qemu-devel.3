Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4CEC3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 14:21:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRueC-0005GP-KY; Thu, 11 Jul 2024 10:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRue9-00055P-VB; Thu, 11 Jul 2024 10:19:45 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sRue6-0005W0-Dn; Thu, 11 Jul 2024 10:19:45 -0400
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-8076ef91d8eso32562239f.1; 
 Thu, 11 Jul 2024 07:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720707580; x=1721312380; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eMWYF7RruolDDN7w8ZRjDbzY0WoBV0w417XKF0FNT/A=;
 b=DnC2ONPOx/shVbFvuhn5eT0Pv6waJVEyYgZBRUoQDEzmWrx/iSfeDmnjhDkv6SJiMy
 hFJY3d6Ou3f5InUin94cww3u0CTJvISYw8y16Euio81A/3yuh6n4sKOn0GCFATXk4BWV
 XcG22OP47JnxQ7IikmzQiXhKVj0JKFhGUklyNsowjWSfd9XUEQqScgDQxNUCo7kt2+j4
 mx2I9SdWe57cKSdeXzXABcvxW5YZ9BDOMd/DpmzuMLySF3QHT/vWZmaOoraFRQzF/zRu
 6TaZyBVId66gogmyHGqEX+VQHOxEHT87LolTlGCC8PVC6ifv/4RWojlOaKDBzcNnu+gk
 ifGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720707580; x=1721312380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eMWYF7RruolDDN7w8ZRjDbzY0WoBV0w417XKF0FNT/A=;
 b=mO1wuqiwvXD1nNFEuJ5pXM9Tu4RAS8x3HD+ZLdU4kFb+W1x5OOX3obhdWtT/sssU1F
 J4l4nuWlJ9XwvqT4fakxXetztfOiB1dLarrqi4xFlZfzUBOweqFx/BRfEuw6ZD4nYoWD
 JF9EDu6xIfhyFG13gVro4l4IPF13LQqbAvBjBdpAbwfYxcip036V2ebZJ8BWTv+H3a8q
 WM40WE4R4RNGo4f48HqTW/1nmuxJ5jczcgmzmnnyBJPOg4gcln0TfTT9sglei3bJL1TW
 7taZt7FzlKGTkabwE05pTU+GVT/hB15A7W8SfpaKUkbJar5wzT9RsyuRUPFRZ5snS74U
 yg5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxxkFm35gpFmwMO8Z5uCV0YhAu0wGmrhElbDS2h2ifQcrlEHieBtyKgeBq5lVGhAc1uKrHjV7Y3umn+IrkLzUD18e4ir8=
X-Gm-Message-State: AOJu0Yz8P7NbOTu42y8QheZOG656z1Usjy8G7H9gS5+5teuRvofb+J7E
 RhZnDD5BAe5KKEH13UK7yRd/e/4fjgLAI3JdQax4NBi2JkHB4QoaJvEVPuR1
X-Google-Smtp-Source: AGHT+IESAXZTt677gB144RNQl1ClKjpHLLs97r/Fp/cOWe4bmQZMau0atfHTTTrXd4LW8gR6FnPz8Q==
X-Received: by 2002:a5e:9706:0:b0:7f6:82b2:909e with SMTP id
 ca18e2360f4ac-8000000c52bmr882845839f.2.1720707580121; 
 Thu, 11 Jul 2024 07:19:40 -0700 (PDT)
Received: from wheely.local0.net ([203.220.44.216])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b54ec730fsm3308904b3a.173.2024.07.11.07.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 07:19:39 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
Subject: [PATCH 10/18] ppc: Add has_smt_siblings property to CPUPPCState
Date: Fri, 12 Jul 2024 00:18:42 +1000
Message-ID: <20240711141851.406677-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240711141851.406677-1-npiggin@gmail.com>
References: <20240711141851.406677-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d36;
 envelope-from=npiggin@gmail.com; helo=mail-io1-xd36.google.com
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/cpu.h        |  3 ++-
 hw/ppc/pnv_core.c       |  3 +++
 hw/ppc/spapr_cpu_core.c | 15 +++++++++++----
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index a74b753c99..35a1cb65cb 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1248,6 +1248,7 @@ struct CPUArchState {
     int access_type;
 
     /* For SMT processors */
+    bool has_smt_siblings;
     int core_index;
 
 #if !defined(CONFIG_USER_ONLY)
@@ -1516,7 +1517,7 @@ struct PowerPCCPUClass {
 
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
index d9116c8409..2c6eeb41a4 100644
--- a/hw/ppc/spapr_cpu_core.c
+++ b/hw/ppc/spapr_cpu_core.c
@@ -314,12 +314,13 @@ static PowerPCCPU *spapr_create_vcpu(SpaprCpuCore *sc, int i, Error **errp)
      * and the rest are explicitly started up by the guest using an RTAS call.
      */
     qdev_prop_set_bit(DEVICE(obj), "start-powered-off", true);
-    env->core_index = cc->core_id;
     cs->cpu_index = cc->core_id + i;
     if (!spapr_set_vcpu_id(cpu, cs->cpu_index, errp)) {
         return NULL;
     }
 
+    env->core_index = cc->core_id;
+
     cpu->node_id = sc->node_id;
 
     id = g_strdup_printf("thread[%d]", i);
@@ -350,9 +351,15 @@ static void spapr_cpu_core_realize(DeviceState *dev, Error **errp)
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


