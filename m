Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA47DE66886
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 14:22:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXKJv-0004ib-Fr; Sun, 21 Dec 2025 09:22:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vXKJU-0003fD-P1
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:21:36 -0500
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>) id 1vXKJQ-0000jN-7e
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 09:21:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=5Peh03QySBNfkwz8iiPWltK4cB9vV/x1+Lk9JHpw06A=; b=i5PqFbK+BygYrXQ
 SS5zhV4WUENTIu+Yinds4NbmnSzChx0BmoOtzUHOjgmfoHn57WsnZVPNwcVu7+Uz/N714Lv21HQym
 ZcioAqQpi4j0+Q7ccQsCj/PDmEBB0b6Tl+j5NyZ3Gx9cRFbWEglEQ+x38YODFFCcDOG1G0xx26nTl
 cI=;
Date: Sun, 21 Dec 2025 15:23:16 +0100
Subject: [PATCH v2 12/14] target/riscv: Stub out kvm functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251221-hw-riscv-cpu-int-v2-12-eb49d72c5b2f@rev.ng>
References: <20251221-hw-riscv-cpu-int-v2-0-eb49d72c5b2f@rev.ng>
In-Reply-To: <20251221-hw-riscv-cpu-int-v2-0-eb49d72c5b2f@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, philmd@linaro.org, 
 pierrick.bouvier@linaro.org, palmer@dabbelt.com, alistair.francis@wdc.com
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Functions used externally by hw/riscv are stubbed out for non-kvm
configurations, allowing a single compilation of hw/riscv.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/kvm/kvm-stub.c  | 23 +++++++++++++++++++++++
 target/riscv/kvm/meson.build |  1 +
 2 files changed, 24 insertions(+)

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
index 7e92415091..d3f395f431 100644
--- a/target/riscv/kvm/meson.build
+++ b/target/riscv/kvm/meson.build
@@ -1 +1,2 @@
+riscv_ss.add(when: 'CONFIG_KVM', if_false: files('kvm-stub.c'))
 riscv_ss.add(when: 'CONFIG_KVM', if_true: files('kvm-cpu.c'))

-- 
2.51.0


