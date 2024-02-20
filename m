Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A06EAC5478B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 09:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcMAP-0000gQ-2O; Tue, 20 Feb 2024 04:11:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rcMAM-0000ex-HF; Tue, 20 Feb 2024 04:11:54 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@linux.intel.com>)
 id 1rcMAK-0003Km-NL; Tue, 20 Feb 2024 04:11:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1708420313; x=1739956313;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=f72SFWwq+PohiF2H5sIw0CnPQG3e0SkCa+ntNndt4BU=;
 b=CYFkUtdvqtkF2iTN5WRcDRgTEmqz7XZYy/SWLfZRQjqA8ppNbSJlWd1v
 Dj2tkOopIy92IftTwS1XW4crgriEmS2ZGancmZHFiE42GFLB5mAXHCSUU
 kVip0229cjiCAdv0bSz87roOz4NgOK0oG8DC4NtJ33C+H3UJXYNcFm61Y
 0WmIVxuh2wgeJg/Us2hzP9405z1CmAyJG/+XlAUs3s1Ac8B4voBDIH8Nn
 o4la0iWk+xcbSLZwyDWQA5sh6xTkOarv9ravPiLQ2wAc6BJ1a0D5MC0Fp
 L7oZmQXOESMiOSEez08dksSt/SExsbPi1d6JjF4W2yraF0hiu/wU2rWHE w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="2374958"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="2374958"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2024 01:11:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="5012851"
Received: from liuzhao-optiplex-7080.sh.intel.com ([10.239.160.36])
 by orviesa007.jf.intel.com with ESMTP; 20 Feb 2024 01:11:45 -0800
From: Zhao Liu <zhao1.liu@linux.intel.com>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Zhenyu Wang <zhenyu.z.wang@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC 1/8] hw/core: Rename CpuTopology to CPUTopology
Date: Tue, 20 Feb 2024 17:24:57 +0800
Message-Id: <20240220092504.726064-2-zhao1.liu@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220092504.726064-1-zhao1.liu@linux.intel.com>
References: <20240220092504.726064-1-zhao1.liu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=192.198.163.17;
 envelope-from=zhao1.liu@linux.intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Use CPUTopology to honor the generic style of CPU capitalization
abbreviations.

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/s390x/cpu-topology.c         |  6 +++---
 include/hw/boards.h             |  8 ++++----
 include/hw/s390x/cpu-topology.h |  6 +++---
 tests/unit/test-smp-parse.c     | 14 +++++++-------
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/hw/s390x/cpu-topology.c b/hw/s390x/cpu-topology.c
index f16bdf65faa0..016f6c1c15ac 100644
--- a/hw/s390x/cpu-topology.c
+++ b/hw/s390x/cpu-topology.c
@@ -86,7 +86,7 @@ bool s390_has_topology(void)
  */
 static void s390_topology_init(MachineState *ms)
 {
-    CpuTopology *smp = &ms->smp;
+    CPUTopology *smp = &ms->smp;
 
     s390_topology.cores_per_socket = g_new0(uint8_t, smp->sockets *
                                             smp->books * smp->drawers);
@@ -181,7 +181,7 @@ void s390_topology_reset(void)
  */
 static bool s390_topology_cpu_default(S390CPU *cpu, Error **errp)
 {
-    CpuTopology *smp = &current_machine->smp;
+    CPUTopology *smp = &current_machine->smp;
     CPUS390XState *env = &cpu->env;
 
     /* All geometry topology attributes must be set or all unset */
@@ -234,7 +234,7 @@ static bool s390_topology_check(uint16_t socket_id, uint16_t book_id,
                                 uint16_t drawer_id, uint16_t entitlement,
                                 bool dedicated, Error **errp)
 {
-    CpuTopology *smp = &current_machine->smp;
+    CPUTopology *smp = &current_machine->smp;
 
     if (socket_id >= smp->sockets) {
         error_setg(errp, "Unavailable socket: %d", socket_id);
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 78dea50054a1..e63dec919da2 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -333,7 +333,7 @@ typedef struct DeviceMemoryState {
 } DeviceMemoryState;
 
 /**
- * CpuTopology:
+ * CPUTopology:
  * @cpus: the number of present logical processors on the machine
  * @drawers: the number of drawers on the machine
  * @books: the number of books in one drawer
@@ -345,7 +345,7 @@ typedef struct DeviceMemoryState {
  * @threads: the number of threads in one core
  * @max_cpus: the maximum number of logical processors on the machine
  */
-typedef struct CpuTopology {
+typedef struct CPUTopology {
     unsigned int cpus;
     unsigned int drawers;
     unsigned int books;
@@ -356,7 +356,7 @@ typedef struct CpuTopology {
     unsigned int cores;
     unsigned int threads;
     unsigned int max_cpus;
-} CpuTopology;
+} CPUTopology;
 
 /**
  * MachineState:
@@ -407,7 +407,7 @@ struct MachineState {
     const char *cpu_type;
     AccelState *accelerator;
     CPUArchIdList *possible_cpus;
-    CpuTopology smp;
+    CPUTopology smp;
     struct NVDIMMState *nvdimms_state;
     struct NumaState *numa_state;
 };
diff --git a/include/hw/s390x/cpu-topology.h b/include/hw/s390x/cpu-topology.h
index c064f427e948..ff09c57a4428 100644
--- a/include/hw/s390x/cpu-topology.h
+++ b/include/hw/s390x/cpu-topology.h
@@ -63,17 +63,17 @@ static inline void s390_topology_reset(void)
 
 extern S390Topology s390_topology;
 
-static inline int s390_std_socket(int n, CpuTopology *smp)
+static inline int s390_std_socket(int n, CPUTopology *smp)
 {
     return (n / smp->cores) % smp->sockets;
 }
 
-static inline int s390_std_book(int n, CpuTopology *smp)
+static inline int s390_std_book(int n, CPUTopology *smp)
 {
     return (n / (smp->cores * smp->sockets)) % smp->books;
 }
 
-static inline int s390_std_drawer(int n, CpuTopology *smp)
+static inline int s390_std_drawer(int n, CPUTopology *smp)
 {
     return (n / (smp->cores * smp->sockets * smp->books)) % smp->drawers;
 }
diff --git a/tests/unit/test-smp-parse.c b/tests/unit/test-smp-parse.c
index 24972666a74d..f660d6b0df45 100644
--- a/tests/unit/test-smp-parse.c
+++ b/tests/unit/test-smp-parse.c
@@ -86,8 +86,8 @@
  */
 typedef struct SMPTestData {
     SMPConfiguration config;
-    CpuTopology expect_prefer_sockets;
-    CpuTopology expect_prefer_cores;
+    CPUTopology expect_prefer_sockets;
+    CPUTopology expect_prefer_cores;
     const char *expect_error;
 } SMPTestData;
 
@@ -395,7 +395,7 @@ static char *smp_config_to_string(const SMPConfiguration *config)
 }
 
 /* Use the different calculation than machine_topo_get_threads_per_socket(). */
-static unsigned int cpu_topology_get_threads_per_socket(const CpuTopology *topo)
+static unsigned int cpu_topology_get_threads_per_socket(const CPUTopology *topo)
 {
     /* Check the divisor to avoid invalid topology examples causing SIGFPE. */
     if (!topo->sockets) {
@@ -406,7 +406,7 @@ static unsigned int cpu_topology_get_threads_per_socket(const CpuTopology *topo)
 }
 
 /* Use the different calculation than machine_topo_get_cores_per_socket(). */
-static unsigned int cpu_topology_get_cores_per_socket(const CpuTopology *topo)
+static unsigned int cpu_topology_get_cores_per_socket(const CPUTopology *topo)
 {
     /* Check the divisor to avoid invalid topology examples causing SIGFPE. */
     if (!topo->threads) {
@@ -416,12 +416,12 @@ static unsigned int cpu_topology_get_cores_per_socket(const CpuTopology *topo)
     }
 }
 
-static char *cpu_topology_to_string(const CpuTopology *topo,
+static char *cpu_topology_to_string(const CPUTopology *topo,
                                     unsigned int threads_per_socket,
                                     unsigned int cores_per_socket)
 {
     return g_strdup_printf(
-        "(CpuTopology) {\n"
+        "(CPUTopology) {\n"
         "    .cpus               = %u,\n"
         "    .sockets            = %u,\n"
         "    .dies               = %u,\n"
@@ -438,7 +438,7 @@ static char *cpu_topology_to_string(const CpuTopology *topo,
 }
 
 static void check_parse(MachineState *ms, const SMPConfiguration *config,
-                        const CpuTopology *expect_topo, const char *expect_err,
+                        const CPUTopology *expect_topo, const char *expect_err,
                         bool is_valid)
 {
     g_autofree char *config_str = smp_config_to_string(config);
-- 
2.34.1


