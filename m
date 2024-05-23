Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB069C25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9wq-0007jV-Mo; Thu, 23 May 2024 11:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wm-0007BB-HS
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sA9wZ-0004t0-AC
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zWt+0IRO8XttG7c4iJde9YUji1pZ6Qv+Qw0Qae/rz0s=;
 b=VFKdcYA7XeZyHrX32hSAFIYQKk9cvrNKHgbuzngNZC7gI7wXv4IW+CMhUbzoZOSexAjSxl
 fQrLY64cwIX3ioqt+1sXPrDoFPrlSMkskMec88v/wDttfdmGrwKzUnd2SKlSkJ4czhsoV7
 h1tpXsEf7TngFeTMozbf/1vM5Rt10Ak=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-J_SIn7v0NDufk5WfB9qkXA-1; Thu, 23 May 2024 11:01:20 -0400
X-MC-Unique: J_SIn7v0NDufk5WfB9qkXA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a59c942611bso119371966b.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476479; x=1717081279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zWt+0IRO8XttG7c4iJde9YUji1pZ6Qv+Qw0Qae/rz0s=;
 b=PQLhumwg/nUnTctHIE/WEr33ekEeQzmGSdlL0N6rqQ/lBjms/MrISvrtNE2Py6ZWNr
 JrQYQSmYZILDHyqgEVYL+sNjV+YWgiC8Ob8ESR3BhTlUG7lga51Hhzsvp5VmoC8Ol6uC
 xRZl8G4fFJNfl9wKoPjohskUXCPDutxQbcb+FoBPKEAdaPXWXM01HTFMuFcazaSnQMuB
 ZpKgcmW0rU9YUvBwSuysY1uwFvJ/t4/CEIyizobVoT7yY4JWUxbyY8YrL4T/6LUbW9Mo
 8VLOthlEOgqZKo0o2k5BSj2SIki784v/zGfYG9GtybW1zOzQ/ONz+lB5+WLcC8myHak2
 sgpw==
X-Gm-Message-State: AOJu0Yw2meJzjs1/cMYsCSOKWXTAbQrYeJ0m2tstOjVXSXkLLvNzB+JW
 FGpzf/5+zjSPp6R3cNppUsGb8C1o/TXQqKHNuRLG9azJ5nCQCyCYi5Ps7cyJ2f5jeS8nH2Gjhvc
 /6Wz+dfsRQCWsT7A/Fh4q/37XE2iXBZZmNIFpkCm5hHLX4qj9a4kY4pTsaqazwHBH5yLXKFHZTv
 5AANMsLD2joAVyOt8lqksO3JAnd28FkctafrjJ
X-Received: by 2002:a17:906:36ce:b0:a55:8f2a:950d with SMTP id
 a640c23a62f3a-a622806bb8bmr404529066b.16.1716476478794; 
 Thu, 23 May 2024 08:01:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGB7l5ddttGfdZZFMB7ES5jLOE9IGSW7P1pwZdy0+1zazMMtF62Hn1Q98ELBTRnatIt6qDVLw==
X-Received: by 2002:a17:906:36ce:b0:a55:8f2a:950d with SMTP id
 a640c23a62f3a-a622806bb8bmr404527166b.16.1716476478458; 
 Thu, 23 May 2024 08:01:18 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781d48dsm1939441866b.5.2024.05.23.08.01.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:01:16 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhuocheng Ding <zhuocheng.ding@intel.com>, Babu Moger <babu.moger@amd.com>
Subject: [PULL 16/23] i386: Support module_id in X86CPUTopoIDs
Date: Thu, 23 May 2024 17:00:29 +0200
Message-ID: <20240523150036.1050011-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523150036.1050011-1-pbonzini@redhat.com>
References: <20240523150036.1050011-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Add module_id member in X86CPUTopoIDs.

module_id can be parsed from APIC ID, so also update APIC ID parsing
rule to support module level. With this support, the conversions with
module level between X86CPUTopoIDs, X86CPUTopoInfo and APIC ID are
completed.

module_id can be also generated from cpu topology, and before i386
supports "modules" in smp, the default "modules per die" (modules *
clusters) is only 1, thus the module_id generated in this way is 0,
so that it will not conflict with the module_id generated by APIC ID.

Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Signed-off-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Co-developed-by: Zhuocheng Ding <zhuocheng.ding@intel.com>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Message-ID: <20240424154929.1487382-16-zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/i386/topology.h | 17 +++++++++++++----
 hw/i386/x86-common.c       | 27 +++++++++++++++++----------
 hw/i386/x86.c              |  4 ++++
 3 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/include/hw/i386/topology.h b/include/hw/i386/topology.h
index ea871045779..dff49fce115 100644
--- a/include/hw/i386/topology.h
+++ b/include/hw/i386/topology.h
@@ -50,6 +50,7 @@ typedef uint32_t apic_id_t;
 typedef struct X86CPUTopoIDs {
     unsigned pkg_id;
     unsigned die_id;
+    unsigned module_id;
     unsigned core_id;
     unsigned smt_id;
 } X86CPUTopoIDs;
@@ -143,6 +144,7 @@ static inline apic_id_t x86_apicid_from_topo_ids(X86CPUTopoInfo *topo_info,
 {
     return (topo_ids->pkg_id  << apicid_pkg_offset(topo_info)) |
            (topo_ids->die_id  << apicid_die_offset(topo_info)) |
+           (topo_ids->module_id << apicid_module_offset(topo_info)) |
            (topo_ids->core_id << apicid_core_offset(topo_info)) |
            topo_ids->smt_id;
 }
@@ -156,12 +158,16 @@ static inline void x86_topo_ids_from_idx(X86CPUTopoInfo *topo_info,
                                          X86CPUTopoIDs *topo_ids)
 {
     unsigned nr_dies = topo_info->dies_per_pkg;
-    unsigned nr_cores = topo_info->cores_per_module *
-                        topo_info->modules_per_die;
+    unsigned nr_modules = topo_info->modules_per_die;
+    unsigned nr_cores = topo_info->cores_per_module;
     unsigned nr_threads = topo_info->threads_per_core;
 
-    topo_ids->pkg_id = cpu_index / (nr_dies * nr_cores * nr_threads);
-    topo_ids->die_id = cpu_index / (nr_cores * nr_threads) % nr_dies;
+    topo_ids->pkg_id = cpu_index / (nr_dies * nr_modules *
+                       nr_cores * nr_threads);
+    topo_ids->die_id = cpu_index / (nr_modules * nr_cores *
+                       nr_threads) % nr_dies;
+    topo_ids->module_id = cpu_index / (nr_cores * nr_threads) %
+                          nr_modules;
     topo_ids->core_id = cpu_index / nr_threads % nr_cores;
     topo_ids->smt_id = cpu_index % nr_threads;
 }
@@ -179,6 +185,9 @@ static inline void x86_topo_ids_from_apicid(apic_id_t apicid,
     topo_ids->core_id =
             (apicid >> apicid_core_offset(topo_info)) &
             ~(0xFFFFFFFFUL << apicid_core_width(topo_info));
+    topo_ids->module_id =
+            (apicid >> apicid_module_offset(topo_info)) &
+            ~(0xFFFFFFFFUL << apicid_module_width(topo_info));
     topo_ids->die_id =
             (apicid >> apicid_die_offset(topo_info)) &
             ~(0xFFFFFFFFUL << apicid_die_width(topo_info));
diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 34dfa894879..4d27279901c 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -283,12 +283,9 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
 
     /*
      * If APIC ID is not set,
-     * set it based on socket/die/core/thread properties.
+     * set it based on socket/die/module/core/thread properties.
      */
     if (cpu->apic_id == UNASSIGNED_APIC_ID) {
-        int max_socket = (ms->smp.max_cpus - 1) /
-                                smp_threads / smp_cores / ms->smp.dies;
-
         /*
          * die-id was optional in QEMU 4.0 and older, so keep it optional
          * if there's only one die per socket.
@@ -300,9 +297,9 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
         if (cpu->socket_id < 0) {
             error_setg(errp, "CPU socket-id is not set");
             return;
-        } else if (cpu->socket_id > max_socket) {
+        } else if (cpu->socket_id > ms->smp.sockets - 1) {
             error_setg(errp, "Invalid CPU socket-id: %u must be in range 0:%u",
-                       cpu->socket_id, max_socket);
+                       cpu->socket_id, ms->smp.sockets - 1);
             return;
         }
         if (cpu->die_id < 0) {
@@ -334,17 +331,27 @@ void x86_cpu_pre_plug(HotplugHandler *hotplug_dev,
         topo_ids.die_id = cpu->die_id;
         topo_ids.core_id = cpu->core_id;
         topo_ids.smt_id = cpu->thread_id;
+
+        /*
+         * TODO: This is the temporary initialization for topo_ids.module_id to
+         * avoid "maybe-uninitialized" compilation errors. Will remove when
+         * X86CPU supports module_id.
+         */
+        topo_ids.module_id = 0;
+
         cpu->apic_id = x86_apicid_from_topo_ids(&topo_info, &topo_ids);
     }
 
     cpu_slot = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, &idx);
     if (!cpu_slot) {
         x86_topo_ids_from_apicid(cpu->apic_id, &topo_info, &topo_ids);
+
         error_setg(errp,
-            "Invalid CPU [socket: %u, die: %u, core: %u, thread: %u] with"
-            " APIC ID %" PRIu32 ", valid index range 0:%d",
-            topo_ids.pkg_id, topo_ids.die_id, topo_ids.core_id, topo_ids.smt_id,
-            cpu->apic_id, ms->possible_cpus->len - 1);
+            "Invalid CPU [socket: %u, die: %u, module: %u, core: %u, thread: %u]"
+            " with APIC ID %" PRIu32 ", valid index range 0:%d",
+            topo_ids.pkg_id, topo_ids.die_id, topo_ids.module_id,
+            topo_ids.core_id, topo_ids.smt_id, cpu->apic_id,
+            ms->possible_cpus->len - 1);
         return;
     }
 
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index d5d668e814d..a4aa8e08109 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -135,6 +135,10 @@ static const CPUArchIdList *x86_possible_cpu_arch_ids(MachineState *ms)
             ms->possible_cpus->cpus[i].props.has_die_id = true;
             ms->possible_cpus->cpus[i].props.die_id = topo_ids.die_id;
         }
+        if (ms->smp.modules > 1) {
+            ms->possible_cpus->cpus[i].props.has_module_id = true;
+            ms->possible_cpus->cpus[i].props.module_id = topo_ids.module_id;
+        }
         ms->possible_cpus->cpus[i].props.has_core_id = true;
         ms->possible_cpus->cpus[i].props.core_id = topo_ids.core_id;
         ms->possible_cpus->cpus[i].props.has_thread_id = true;
-- 
2.45.1


