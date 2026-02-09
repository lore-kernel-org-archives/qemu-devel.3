Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E92F9EF06EE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 02:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpH09-0005iC-TD; Sun, 08 Feb 2026 21:27:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1vpH07-0005hy-Qk; Sun, 08 Feb 2026 21:27:47 -0500
Received: from mxct.zte.com.cn ([183.62.165.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liu.xuemei1@zte.com.cn>)
 id 1vpH05-0007jZ-U9; Sun, 08 Feb 2026 21:27:47 -0500
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4f8TB43SSnz4xQXL;
 Mon, 09 Feb 2026 10:27:40 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
 by mse-fl1.zte.com.cn with SMTP id 6192RZ1N094434;
 Mon, 9 Feb 2026 10:27:35 +0800 (+08)
 (envelope-from liu.xuemei1@zte.com.cn)
Received: from mapi (xaxapp05[null]) by mapi (Zmail) with MAPI id mid32;
 Mon, 9 Feb 2026 10:27:36 +0800 (CST)
X-Zmail-TransId: 2afc69894618943-92f05
X-Mailer: Zmail v1.0
Message-ID: <20260209102736221CBEZxNNsdR5VPEunLHBLz@zte.com.cn>
In-Reply-To: <20260209102128930gN_7xu7bNIZcEawnIz3c7@zte.com.cn>
References: 20260209102128930gN_7xu7bNIZcEawnIz3c7@zte.com.cn
Date: Mon, 9 Feb 2026 10:27:36 +0800 (CST)
Mime-Version: 1.0
From: <liu.xuemei1@zte.com.cn>
To: <imammedo@redhat.com>, <alistair.francis@wdc.com>,
 <dbarboza@ventanamicro.com>, <sunilvl@ventanamicro.com>,
 <anisinha@redhat.com>
Cc: <pbonzini@redhat.com>, <palmer@dabbelt.com>, <liwei1518@gmail.com>,
 <zhiwei_liu@linux.alibaba.com>, <mst@redhat.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>, <liu.xuemei1@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIHY2IDMvNF0gaHcvcmlzY3YvdmlydDogYWRkIHN5c3RlbV9wb3dlcmRvd24gaG1wIGNvbW1hbmQKCiBzdXBwb3J0?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 6192RZ1N094434
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: liu.xuemei1@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Mon, 09 Feb 2026 10:27:40 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6989461C.000/4f8TB43SSnz4xQXL
Received-SPF: pass client-ip=183.62.165.209;
 envelope-from=liu.xuemei1@zte.com.cn; helo=mxct.zte.com.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Xuemei Liu <liu.xuemei1@zte.com.cn>

For riscv virt machine, add powerdown notification callback
and send ACPI_POWER_DOWN_STATUS event by acpi ged. Also add
acpi dsdt table for ACPI_POWER_BUTTON_DEVICE device in this
patch.

Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>
---
 hw/riscv/virt-acpi-build.c |  2 ++
 hw/riscv/virt.c            | 14 ++++++++++++++
 include/hw/riscv/virt.h    |  1 +
 3 files changed, 17 insertions(+)

diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 1717b1c24f..77aea55ece 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -504,6 +504,8 @@ static void build_dsdt(GArray *table_data,
                   ACPI_GED_IRQ, AML_SYSTEM_MEMORY,
                   s->memmap[VIRT_ACPI_GED].base);

+    acpi_dsdt_add_power_button(scope);
+
     aml_append(dsdt, scope);

     /* copy AML table into ACPI tables blob and patch header there */
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 1d7011b952..01efbf82e5 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -51,6 +51,7 @@
 #include "system/kvm.h"
 #include "system/tpm.h"
 #include "system/qtest.h"
+#include "system/runstate.h"
 #include "hw/pci/pci.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/display/ramfb.h"
@@ -1446,6 +1447,16 @@ static void virt_build_smbios(RISCVVirtState *s)
     }
 }

+static void virt_powerdown_req(Notifier *notifier, void *opaque)
+{
+    RISCVVirtState *s;
+
+    s = container_of(notifier, RISCVVirtState, powerdown_notifier);
+    if (s->acpi_ged) {
+        acpi_send_event(s->acpi_ged, ACPI_POWER_DOWN_STATUS);
+    }
+}
+
 static void virt_machine_done(Notifier *notifier, void *data)
 {
     RISCVVirtState *s = container_of(notifier, RISCVVirtState,
@@ -1766,6 +1777,9 @@ static void virt_machine_init(MachineState *machine)
         sysbus_realize_and_unref(SYS_BUS_DEVICE(iommu_sys), &error_fatal);
     }

+    s->powerdown_notifier.notify = virt_powerdown_req;
+    qemu_register_powerdown_notifier(&s->powerdown_notifier);
+
     s->machine_done.notify = virt_machine_done;
     qemu_add_machine_init_done_notifier(&s->machine_done);
 }
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 9ea0b3b7b6..e631d57268 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -47,6 +47,7 @@ struct RISCVVirtState {

     /*< public >*/
     Notifier machine_done;
+    Notifier powerdown_notifier;
     DeviceState *acpi_ged;
     DeviceState *platform_bus_dev;
     RISCVHartArrayState soc[VIRT_SOCKETS_MAX];
-- 
2.27.0

