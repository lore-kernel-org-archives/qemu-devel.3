Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E02F6CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 13:10:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPgfc-0005PX-97; Wed, 20 May 2026 09:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wPgfN-00059M-IH; Wed, 20 May 2026 09:08:53 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1wPgfM-00015D-2V; Wed, 20 May 2026 09:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=l0dNl03bS3E1wsW+at3KYU1yqaTTF87IgSaAeL+9S1Q=; b=NIkAAUXiNtuJUAZ
 h+SugKXX1/V2X1C4xkUhy2/z2nXWjmkTQZroyno4Sl5C2l6pWRGUtvWkfyfbPXZtMc+N7jMUIM29q
 7adO5Bgj8YllR8vx529OeWXekDeIMk4quI+MFs8VmgF3mtyCsBEG9YmcYzk+p3jsrcUxWh3LyszjW
 to=;
Date: Wed, 20 May 2026 15:13:03 +0200
Subject: [PATCH v3 11/14] target/riscv: Stub out kvm functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-hw-riscv-cpu-int-v3-11-d1123ea63d9c@rev.ng>
References: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
In-Reply-To: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, philmd@linaro.org, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779282793; l=1527;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=GpfNmK0ODkxi2G+VC/KRFKwa2B0IWnVNhBfX6455AEQ=;
 b=Yyl5hCDq0Z4dMDn0e8MYvRd0GeZhCcVxdEtozgoUTOtr/J+L6mL0KE3l4iQmjiIv9FEfhC9Cs
 BTQ0HwJMGTEDin0tpSaiPSG1Knlybv8Lcdnpj+bnLGepEldVEbVSWoI
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
2.52.0


