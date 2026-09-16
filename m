Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F63C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 09:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6liY-0001Lu-Ph; Wed, 16 Sep 2026 05:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1x6li7-0001C3-5P; Wed, 16 Sep 2026 05:13:47 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1x6li5-00088K-Kt; Wed, 16 Sep 2026 05:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=0vAoNB/3VWSS/2euNZcCeW3I/VqyUnURpiUkZYBy9gs=; b=wbSnWq1KNaHY/sp
 qa3snS27ILUd1sXEecYxpuH7vHwE/BPYKSVFGn+43JfUTV0DvQY3UCgqtHSeLdg+U19HCAd4JAckH
 fMN7Fj2YBu9EKWhHHkF2XMEcpkWiq21k0NQ8ODeqCdCDV4FzNICeE7VxY50S3D8PZkwNMWQpVh/72
 HI=;
Date: Wed, 16 Sep 2026 11:19:00 +0200
Subject: [PATCH v4 05/12] target/riscv: Stub out kvm functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-hw-riscv-cpu-int-v4-5-babc367b60f5@rev.ng>
References: <20260916-hw-riscv-cpu-int-v4-0-babc367b60f5@rev.ng>
In-Reply-To: <20260916-hw-riscv-cpu-int-v4-0-babc367b60f5@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789550353; l=2075;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=SmQC4q0Y5o0T40JGR8Ackm0oNwRh0OgKntILAQviVXI=;
 b=C6zPo9LibXrs4d9Ekz51CZtCiiNEKVwDsO8uhstbDBV3n0qpgUq17PGDakCzp9fKesz9KPQVP
 2mHDtu30sd4Crd88oUXtSYhrR0adXg8S8Punfy69CNE6YXQG//xsiu8
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Functions used externally by hw/riscv are stubbed out for non-kvm
configurations, allowing a single compilation of hw/riscv.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/kvm/kvm-stub.c  | 23 +++++++++++++++++++++++
 target/riscv/kvm/meson.build |  1 +
 target/riscv/meson.build     |  3 +++
 3 files changed, 27 insertions(+)

diff --git a/target/riscv/kvm/kvm-stub.c b/target/riscv/kvm/kvm-stub.c
new file mode 100644
index 0000000000..64e39c96d8
--- /dev/null
+++ b/target/riscv/kvm/kvm-stub.c
@@ -0,0 +1,23 @@
+/*
+ * QEMU RISCV specific KVM stubs
+ *
+ *  Copyright (c) rev.ng Labs Srl.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "target/riscv/kvm/kvm_riscv.h"
+
+void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
+                          uint64_t aia_irq_num, uint64_t aia_msi_num,
+                          uint64_t aplic_base, uint64_t imsic_base,
+                          uint64_t guest_num)
+{
+    g_assert_not_reached();
+}
+
+uint64_t kvm_riscv_get_timebase_frequency(RISCVCPU *cpu)
+{
+    g_assert_not_reached();
+}
diff --git a/target/riscv/kvm/meson.build b/target/riscv/kvm/meson.build
index 7e92415091..75e35b2150 100644
--- a/target/riscv/kvm/meson.build
+++ b/target/riscv/kvm/meson.build
@@ -1 +1,2 @@
 riscv_ss.add(when: 'CONFIG_KVM', if_true: files('kvm-cpu.c'))
+riscv_stubs_ss.add(files('kvm-stub.c'))
diff --git a/target/riscv/meson.build b/target/riscv/meson.build
index 42d0f6d538..e1b51d2bd4 100644
--- a/target/riscv/meson.build
+++ b/target/riscv/meson.build
@@ -19,6 +19,8 @@ riscv_ss.add(files(
   'gdbstub.c',
 ))
 
+riscv_stubs_ss = ss.source_set()
+
 riscv_system_ss = ss.source_set()
 riscv_system_ss.add(files(
   'arch_dump.c',
@@ -33,3 +35,4 @@ subdir('kvm')
 
 target_arch += {'riscv': riscv_ss}
 target_system_arch += {'riscv': riscv_system_ss}
+target_stubs_arch += {'riscv': riscv_stubs_ss}

-- 
2.52.0


