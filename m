Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235E4606A324
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=korins.ky header.i=@korins.ky header.a=rsa-sha256 header.s=20240125rsa header.b=Ninnj7W0;
	dkim=fail reason="signature verification failed" header.d=korins.ky header.i=@korins.ky header.a=ed25519-sha256 header.s=20240125ed25519 header.b=aHZ0T0JD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR9R7-00010K-Cq; Wed, 11 Nov 2026 09:36:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xR9Qw-0000sl-3Z
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 09:36:20 -0500
Received: from mx1.catap.net ([162.55.82.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1xR9Qt-00025i-29
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 09:36:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=PRLhkuS
 DzR558U2i8xOudmTSmL1NC2RAOqrlL3esRAA9VXQhGziDZA3vZ8tnmnDB+/e+rmc+GJ5VF
 jhUzge4Xyj96/tTUfBKU1pWi+iINthwNN+MOj3lrquoz67Uy4B+lnEDgUkaeBIA6zUDQC4
 0XmQ32C/7wCgkHzZct8C0UTYh2rbZr9cJjkCusxrTbgy85ZWvzv0EcaID21r2hzf4tOXVW
 CXWeisJQpn0vTTCUsDPRiMK5lQN5IjhKJH0oNTcu93ZET11YZlB1zIVh7JE8qRxQK6/PhU
 l7gd40lfnITw8xwcTaVGot0dFVIjvwQ0rmqiITfKthRefVwrARLlbOA==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=e
 v34zZLytbtKqPVSs4v75flamZJORHxjvGiA1k/SFdU=;
 h=references:in-reply-to:
 date:subject:cc:to:from:dkim-signature:dkim-signature; d=mx.catap.net;
 b=Y9QvwsRTK+WEiJr3iISwG46KuFTv83auDD8QtuLuMRASgGGSh/KDMMFLW+2MKxuQ6JbT
 OnrNb6rcn/BFyD8AwLsLsTbgdKAYSDZtXC+SyAGKGJLRgP0sdPMqSIUu4Ax5b9m4WZ11oC
 HIUMTrzbcY4DSffjeyiZF2CfsyIDpeLfM/INeA5zFfsxK14LVW3cGJzbr6ipwEy5OAP45W
 yutXOBZf98aE7CW1fLAsDNU4U6i8TyVni92QyzchLu+BcEH+EFRACz1eyVVTpCGEMkO2gU
 6t59Gf6vgGVhG0F2nOqPwKTtKU0KMR23LBNWRXvzut3CJWpoeKpuuPwcIW0DR7rA==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=Ninnj7W0; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=aHZ0T0JD;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=ev34zZLy
 tbtKqPVSs4v75flamZJORHxjvGiA1k/SFdU=;
 h=references:in-reply-to:date:
 subject:cc:to:from; d=korins.ky; b=Ninnj7W0teNpEhy4duS6OiSAZJCHtgFCPLH
 lJbObb3XqezjsRkL2bp/xnZgyzsMpKUDPAFoY/VhDX+o9dhF61FQvgmSsqZ1QmrStmL5iq
 1hHLhBxozp2SZaN6EAlXiwkg1sIDOQKvFHmE2vbqoV5opRWSVOghMxEXBuyqAlzMRfbiQH
 2zcxVWFtGziFhbYfQ7XJuYKvJB+st6HC8cdbVwAfWAwj7v9TM/nFClFz3cRXi617/8qo8k
 sKdxS0PUEnTdZl0uLMgpp+9G0aS3ePoK8HFKkeK3Bjtbv1q39l01rZ9RpaQ1q0LqkxgDTP
 YS9RvbBIMdUN+aS19nIH3zNqdMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=ev34zZLytbtKqPVSs4v75flamZJORHxjvGiA1k/SFdU=; h=references:
 in-reply-to:date:subject:cc:to:from; d=korins.ky; b=aHZ0T0JD+1hjtBI1Wl
 OLHaWpotv3Fkv5iyOzG8aTejli/VmyAOsTipuSIjj3LGG2OpKWpRYP46iUesP7OfRfCw==
Received: by mx1.catap.net (OpenSMTPD) id 5c77c3b9;
 Wed, 11 Nov 2026 15:36:07 +0100 (CET)
Received: from localhost (matebook.home.arpa [local])
 by matebook.home.arpa (OpenSMTPD) with ESMTPA id e6f0bb45;
 Wed, 11 Nov 2026 15:35:54 +0100 (CET)
From: Kirill A. Korinsky <kirill@korins.ky>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: "Kirill A . Korinsky" <kirill@korins.ky>
Subject: [PATCH v7 09/26] hw/mips: add empty Octeon III machine
Date: Wed, 11 Nov 2026 15:32:09 +0100
Message-ID: <20261111143533.1775-10-kirill@korins.ky>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111143533.1775-1-kirill@korins.ky>
References: <20261111143533.1775-1-kirill@korins.ky>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.55.82.72; envelope-from=kirill@korins.ky;
 helo=mx1.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: "Kirill A. Korinsky" <kirill@korins.ky>

Register an empty octeon3 machine for the Cavium/Marvell Octeon III
EBB7304 evaluation board. Define its CPU, RAM and clock defaults; later
commits add the board devices.

Early Octeon investigation used Amir Mehmood's original Octeon
host.patch as a behavioral reference; that work informed the basic
machine approach and several hardware model ideas. No code from that
patch remains in this implementation.

Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
---
 hw/mips/Kconfig           |  5 +++
 hw/mips/meson.build       |  1 +
 hw/mips/octeon.c          | 89 +++++++++++++++++++++++++++++++++++++++
 hw/mips/octeon_internal.h | 16 +++++++
 4 files changed, 111 insertions(+)
 create mode 100644 hw/mips/octeon.c
 create mode 100644 hw/mips/octeon_internal.h

diff --git a/hw/mips/Kconfig b/hw/mips/Kconfig
index b59cb2f111..2e71e6dee6 100644
--- a/hw/mips/Kconfig
+++ b/hw/mips/Kconfig
@@ -67,6 +67,11 @@ config LOONGSON3V
     select FW_CFG_MIPS
     select UNIMP
 
+config MIPS_OCTEON
+    bool
+    default y
+    depends on MIPS64 && TARGET_BIG_ENDIAN
+
 config MIPS_CPS
     bool
     select MIPS_ITU if TCG
diff --git a/hw/mips/meson.build b/hw/mips/meson.build
index 390f0fd7f9..f11dcdf794 100644
--- a/hw/mips/meson.build
+++ b/hw/mips/meson.build
@@ -10,6 +10,7 @@ if 'CONFIG_TCG' in config_all_accel
 mips_ss.add(when: 'CONFIG_JAZZ', if_true: files('jazz.c'))
 mips_ss.add(when: 'CONFIG_FULOONG', if_true: files('fuloong2e.c'))
 mips_ss.add(when: 'CONFIG_MIPS_BOSTON', if_true: files('boston.c'))
+mips_ss.add(when: 'CONFIG_MIPS_OCTEON', if_true: files('octeon.c'))
 endif
 
 hw_arch += {'mips': mips_ss}
diff --git a/hw/mips/octeon.c b/hw/mips/octeon.c
new file mode 100644
index 0000000000..2ecc464579
--- /dev/null
+++ b/hw/mips/octeon.c
@@ -0,0 +1,89 @@
+/*
+ * QEMU Cavium Octeon board model.
+ *
+ * Copyright (c) 2026 Kirill A. Korinsky
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "hw/core/boards.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/mips/octeon_internal.h"
+#include "target/mips/cpu.h"
+
+#define TYPE_OCTEON_MACHINE MACHINE_TYPE_NAME("octeon3")
+OBJECT_DECLARE_SIMPLE_TYPE(OcteonMachineState, OCTEON_MACHINE)
+
+#define OCTEON_DEFAULT_CPU_HZ       1800000000
+#define OCTEON_DEFAULT_REF_HZ       50000000
+#define OCTEON_DEFAULT_IO_HZ        1000000000
+#define OCTEON_DEFAULT_DDR_HZ       800000000
+#define OCTEON_DEFAULT_RAM_SIZE     (1 * GiB)
+
+struct OcteonMachineState {
+    MachineState parent_obj;
+    uint64_t cpu_hz;
+    uint64_t ref_hz;
+    uint64_t io_hz;
+    uint64_t ddr_hz;
+};
+
+static void mips_octeon_init(MachineState *machine)
+{
+}
+
+static void octeon_machine_instance_init(Object *obj)
+{
+    OcteonMachineState *oms = OCTEON_MACHINE(obj);
+
+    oms->cpu_hz = OCTEON_DEFAULT_CPU_HZ;
+    oms->ref_hz = OCTEON_DEFAULT_REF_HZ;
+    oms->io_hz = OCTEON_DEFAULT_IO_HZ;
+    oms->ddr_hz = OCTEON_DEFAULT_DDR_HZ;
+
+    object_property_add_uint64_ptr(obj, "cpu-clock-hz", &oms->cpu_hz,
+                                   OBJ_PROP_FLAG_READWRITE);
+    object_property_set_description(obj, "cpu-clock-hz",
+                                    "CPU clock frequency in Hz");
+
+    object_property_add_uint64_ptr(obj, "ref-clock-hz", &oms->ref_hz,
+                                   OBJ_PROP_FLAG_READWRITE);
+    object_property_set_description(obj, "ref-clock-hz",
+                                    "Reference clock frequency in Hz");
+
+    object_property_add_uint64_ptr(obj, "io-clock-hz", &oms->io_hz,
+                                   OBJ_PROP_FLAG_READWRITE);
+    object_property_set_description(obj, "io-clock-hz",
+                                    "IO clock frequency in Hz");
+
+    object_property_add_uint64_ptr(obj, "ddr-clock-hz", &oms->ddr_hz,
+                                   OBJ_PROP_FLAG_READWRITE);
+    object_property_set_description(obj, "ddr-clock-hz",
+                                    "DDR clock frequency in Hz");
+}
+
+static void octeon_machine_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "Cavium Octeon III / EBB7304 EVK";
+    mc->init = mips_octeon_init;
+    mc->default_cpu_type = MIPS_CPU_TYPE_NAME("OcteonCN73XX");
+    mc->default_ram_size = OCTEON_DEFAULT_RAM_SIZE;
+    mc->default_ram_id = "octeon.ram";
+    mc->max_cpus = OCTEON_MAX_CPUS;
+}
+
+static const TypeInfo octeon_machine_types[] = {
+    {
+        .name = TYPE_OCTEON_MACHINE,
+        .parent = TYPE_MACHINE,
+        .instance_size = sizeof(OcteonMachineState),
+        .instance_init = octeon_machine_instance_init,
+        .class_init = octeon_machine_class_init,
+    }
+};
+
+DEFINE_TYPES(octeon_machine_types)
diff --git a/hw/mips/octeon_internal.h b/hw/mips/octeon_internal.h
new file mode 100644
index 0000000000..7cab7790bd
--- /dev/null
+++ b/hw/mips/octeon_internal.h
@@ -0,0 +1,16 @@
+/*
+ * QEMU Cavium Octeon board model internal declarations.
+ *
+ * Copyright (c) 2026 Kirill A. Korinsky
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MIPS_OCTEON_INTERNAL_H
+#define HW_MIPS_OCTEON_INTERNAL_H
+
+#include "qemu/typedefs.h"
+
+#define OCTEON_MAX_CPUS             16
+
+#endif
-- 
2.56.0


