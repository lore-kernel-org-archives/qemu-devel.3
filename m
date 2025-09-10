Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF1BCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 11:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwJTl-0005ug-5X; Wed, 10 Sep 2025 07:59:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1uwJTW-0005rn-Mg
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 07:59:00 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hector.cao@canonical.com>)
 id 1uwJTQ-0001wv-36
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 07:58:58 -0400
Received: from localhost.localdomain (unknown [10.101.192.134])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 60F0F40D39
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 11:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1757505509;
 bh=QURLz3Q90l7SA0BCrdBjAfZ2Iv5nr6PTw1OPi/HIog4=;
 h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=sKKMhDyRCR7jkXfPBw8Hrx3ePcu4eDMv9JVWyp38ewphNpqaAunURS0FqdK2k1ye8
 4KkzicM4zdon67T79CIRB+z7CfC8tE43PVgzRonwGwQAwa7o6vJvZB0YtoWjZQ2P/C
 jobAtP1ptdeAqrYU0v750W0rxPpfb3xJ19BQwpZIFzxeDfd+QS4KdSnxGc7PLp5sEp
 WotwNOR9HtcgDD5U9Z0Mkxdq/jhW87g8a4GX9Ceoo1optxrHmqWgZxaIfcMaEw6S2r
 jRb9F4eQQxEA11d3GiN9MSjZcIYgXGJyE4S4bpbnTu9iF3kAUES2zLfiWI19Jdo1Es
 YI6Iarn9K2Agw==
From: Hector Cao <hector.cao@canonical.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] target/i386: add compatibility property for pdcm feature
Date: Wed, 10 Sep 2025 13:57:33 +0200
Message-ID: <20250910115733.21149-3-hector.cao@canonical.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250910115733.21149-1-hector.cao@canonical.com>
References: <CABjvBV7wgfSv-OjGf_L2t9ranXfzTQTSBdRAFODpHH-nFcLFig@mail.gmail.com>
 <20250910115733.21149-1-hector.cao@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.125.188.120;
 envelope-from=hector.cao@canonical.com;
 helo=smtp-relay-canonical-0.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The pdcm feature is supposed to be disabled when PMU is not
available. Up until v10.1, pdcm feature is enabled even when PMU
is off. This behavior has been fixed but this change breaks the
migration of VMs that are run with QEMU < 10.0 and expect the pdcm
feature to be enabled on the destination host.

This commit restores the legacy behavior for machines with version
prior to 10.1 to allow the migration from older QEMU to QEMU 10.1.

Signed-off-by: Hector Cao <hector.cao@canonical.com>
---
 hw/core/machine.c     |  1 +
 migration/migration.h | 11 +++++++++++
 migration/options.c   |  3 +++
 target/i386/cpu.c     | 17 ++++++++++++++---
 4 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 8ad5d79cb3..535184c221 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -46,6 +46,7 @@ GlobalProperty hw_compat_10_0[] = {
     { "ramfb", "use-legacy-x86-rom", "true"},
     { "vfio-pci-nohotplug", "use-legacy-x86-rom", "true" },
     { "migration", "arch-cap-always-on", "true" },
+    { "migration", "pdcm-on-even-without-pmu", "true" },
 };
 const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
 
diff --git a/migration/migration.h b/migration/migration.h
index 5124ff3636..7d5b2aa042 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -522,6 +522,17 @@ struct MigrationState {
      * to a host with QEMU 10.1 with error : missing feature arch-capabilities
      */
     bool arch_cap_always_on;
+
+    /*
+     * This variable allows to keep the backward compatibility with QEMU (<10.1)
+     * on the pdcm feature detection. The pdcm feature should be disabled when
+     * PMU is not available. Prio to 10.1, there is a bug and pdcm can still be
+     * enabled even if PMU is off. This behavior has been fixed by the commit
+     * e68ec29 (since 10.1).
+     * This new behavior breaks migration of VMs that expect, with the QEMU
+     * (since 10.1), pdcm to be disabled.
+     */
+    bool pdcm_on_even_without_pmu;
 };
 
 void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
diff --git a/migration/options.c b/migration/options.c
index 3a80dba9c5..a2a95dfcc4 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -206,6 +206,9 @@ const Property migration_properties[] = {
 
     DEFINE_PROP_BOOL("arch-cap-always-on", MigrationState,
                      arch_cap_always_on, false),
+
+    DEFINE_PROP_BOOL("pdcm-on-even-without-pmu", MigrationState,
+                     pdcm_on_even_without_pmu, false),
 };
 const size_t migration_properties_count = ARRAY_SIZE(migration_properties);
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 6d85149e6e..1f0f2c8dbf 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -51,6 +51,8 @@
 #include "disas/capstone.h"
 #include "cpu-internal.h"
 
+#include "migration/migration.h"
+
 static void x86_cpu_realizefn(DeviceState *dev, Error **errp);
 static void x86_cpu_get_supported_cpuid(uint32_t func, uint32_t index,
                                         uint32_t *eax, uint32_t *ebx,
@@ -7839,6 +7841,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     uint32_t signature[3];
     X86CPUTopoInfo *topo_info = &env->topo_info;
     uint32_t threads_per_pkg;
+    MigrationState *ms = migrate_get_current();
 
     threads_per_pkg = x86_threads_per_pkg(topo_info);
 
@@ -7894,6 +7897,11 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             /* Fixup overflow: max value for bits 23-16 is 255. */
             *ebx |= MIN(num, 255) << 16;
         }
+        if (ms->pdcm_on_even_without_pmu) {
+            if (!cpu->enable_pmu) {
+                *ecx &= ~CPUID_EXT_PDCM;
+            }
+        }
         break;
     case 2: { /* cache info: needed for Pentium Pro compatibility */
         const CPUCaches *caches;
@@ -8892,6 +8900,7 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
     FeatureWord w;
     int i;
     GList *l;
+    MigrationState *ms = migrate_get_current();
 
     for (l = plus_features; l; l = l->next) {
         const char *prop = l->data;
@@ -8944,9 +8953,11 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
         }
     }
 
-    /* PDCM is fixed1 bit for TDX */
-    if (!cpu->enable_pmu && !is_tdx_vm()) {
-        env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
+    if (!ms->pdcm_on_even_without_pmu) {
+        /* PDCM is fixed1 bit for TDX */
+        if (!cpu->enable_pmu && !is_tdx_vm()) {
+            env->features[FEAT_1_ECX] &= ~CPUID_EXT_PDCM;
+        }
     }
 
     for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
-- 
2.45.2


