Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D903CD1283
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps8Z-0001ni-Uq; Thu, 28 Mar 2024 11:57:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps8R-0001Wt-VC
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:57:48 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps8Q-0002pM-3j
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:57:47 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56bb22ff7baso1289250a12.3
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641464; x=1712246264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K6394pyfYpf5VBXUXIwRMOR2ZbX+o8CbfYrADQtuSgY=;
 b=jhd29j4MdfwOf113zIcv8UX2buDkfsD4w6qamHe3Z57LvS0+lYQ2reoVjpM1L6bY7x
 CNDLuowdOkZrj4PvzFecJvhHUL8tT4sSNKS9LFdBQLz7sARYfd45Y5FPuLiLEtVl2H59
 2/B9J879qAk1mvWzYMSiJlvNm22orYnWbRWhFgTrTOQblhOA0pVU4lNaBDqkAXmJMouS
 aAYZIF8k7KvPwmImynj6vTvlLDAXyEIaxl/6GbhrBdE7wrgHj1leI8HDmzbpEQGOr0CJ
 mDNxQBxbhl6P+JCTlHPPcOWAFjmFMZGQZtB/O5NFOD+yR3wRz0D5OEE5oqiCXx3XK/Qo
 6QHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641464; x=1712246264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K6394pyfYpf5VBXUXIwRMOR2ZbX+o8CbfYrADQtuSgY=;
 b=hPEL4I926jpNAMpKOGEXvA0DDuzBszvO4xp26DRxtnLBigzI9yOF7QJgk0t9xkoQZO
 Bnkt0VGmpT/z/JECSMkko6bKojHRFKq/M4L398+ASHOy4TP9Wh/bLGvmJu7RpvMLTEZ3
 ER+WMfC8PBmOCd5tMvYNxTZSdgW6PiFuFSBUptrvI/ovrAk0C22FpUZh1+HzxtQJSVyA
 dCF/sz+SZdOIhd/U6/r4VOOwv1NT+hK/7AnL7r/yNTPdo8y7nXvzc/SLUV5WdaNdOpni
 kXTtNEPtj/OcPZQBd04PL53EgNxp8AcGh2gSAmZdeSfIgxO8A1fnbXx5yhioANa9TYtU
 GzCw==
X-Gm-Message-State: AOJu0YzpfXJwPlwKZ7NcbqZ05wrPCpBGa5paLg8XQmRxua4nRfjbqdo4
 aq9uNzFKQpyRfHxlrPH5MU3CbqBqmD7llTDHBYlVgmf5uN/zk7FdUmAFBsxaaFwMQMQk5uMKS8J
 y
X-Google-Smtp-Source: AGHT+IHopSZ4mG4FmVwZwRyY4uEq7A+kY6caw0K60z5ZjV+GdO0roOAWBLEuOIrEv1csN4Rr2G6Jmg==
X-Received: by 2002:a50:d750:0:b0:565:e610:c358 with SMTP id
 i16-20020a50d750000000b00565e610c358mr2278668edj.38.1711641464364; 
 Thu, 28 Mar 2024 08:57:44 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 p12-20020a50c94c000000b005689bfe2688sm980668edh.39.2024.03.28.08.57.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 08:57:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.1 29/29] hw/i386/pc: Move ISA-only PC machine to
 pc_isa.c
Date: Thu, 28 Mar 2024 16:54:37 +0100
Message-ID: <20240328155439.58719-30-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240328155439.58719-1-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Extract the ISA-only PC machine code from pc_piix.c
to a new file, pc_isa.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS         |  1 +
 hw/i386/pc_isa.c    | 33 +++++++++++++++++++++++++++++++++
 hw/i386/pc_piix.c   | 23 -----------------------
 hw/i386/meson.build |  1 +
 4 files changed, 35 insertions(+), 23 deletions(-)
 create mode 100644 hw/i386/pc_isa.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a07af6b9d4..a68fa813b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1812,6 +1812,7 @@ M: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
 S: Supported
 F: include/hw/i386/
 F: hw/i386/
+X: hw/i386/pc_isa.c
 F: hw/pci-host/i440fx.c
 F: hw/pci-host/q35.c
 F: hw/pci-host/pam.c
diff --git a/hw/i386/pc_isa.c b/hw/i386/pc_isa.c
new file mode 100644
index 0000000000..a98c75f3ae
--- /dev/null
+++ b/hw/i386/pc_isa.c
@@ -0,0 +1,33 @@
+/*
+ * QEMU ISA PC System Emulator
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#include "qemu/osdep.h"
+#include "qom/object.h"
+#include "hw/boards.h"
+#include "hw/i386/pc.h"
+#include "hw/char/parallel-isa.h"
+#include "target/i386/cpu-qom.h"
+
+static void pc_init_isa(MachineState *machine)
+{
+    pc_piix_init(machine, NULL);
+}
+
+static void isapc_machine_options(MachineClass *m)
+{
+    m->desc = "ISA-only PC";
+    m->max_cpus = 1;
+    m->option_rom_has_mr = true;
+    m->rom_file_has_mr = false;
+    m->default_nic = "ne2k_isa";
+    m->default_cpu_type = X86_CPU_TYPE_NAME("486");
+    m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
+}
+
+DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
+                  isapc_machine_options, TYPE_PC_MACHINE);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 4a3ae72fe4..f94221ab92 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -434,13 +434,6 @@ static void pc_set_south_bridge(Object *obj, int value, Error **errp)
  * hw_compat_*, pc_compat_*, or * pc_*_machine_options().
  */
 
-#ifdef CONFIG_ISAPC
-static void pc_init_isa(MachineState *machine)
-{
-    pc_piix_init(machine, NULL);
-}
-#endif
-
 #ifdef CONFIG_XEN
 static void pc_xen_hvm_init_pci(MachineState *machine)
 {
@@ -820,22 +813,6 @@ static void pc_i440fx_2_4_machine_options(MachineClass *m)
 DEFINE_I440FX_MACHINE(v2_4, "pc-i440fx-2.4", NULL,
                       pc_i440fx_2_4_machine_options)
 
-#ifdef CONFIG_ISAPC
-static void isapc_machine_options(MachineClass *m)
-{
-    m->desc = "ISA-only PC";
-    m->max_cpus = 1;
-    m->option_rom_has_mr = true;
-    m->rom_file_has_mr = false;
-    m->default_nic = "ne2k_isa";
-    m->default_cpu_type = X86_CPU_TYPE_NAME("486");
-    m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
-}
-
-DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
-                  isapc_machine_options, TYPE_PC_MACHINE);
-#endif
-
 #ifdef CONFIG_XEN
 static void xenfv_4_2_machine_options(MachineClass *m)
 {
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index 1a6e731196..0576fc6541 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -12,6 +12,7 @@ i386_ss.add(when: 'CONFIG_X86_IOMMU', if_true: files('x86-iommu.c'),
                                       if_false: files('x86-iommu-stub.c'))
 i386_ss.add(when: 'CONFIG_AMD_IOMMU', if_true: files('amd_iommu.c'),
                                       if_false: files('amd_iommu-stub.c'))
+i386_ss.add(when: 'CONFIG_ISAPC', if_true: files('pc_isa.c'))
 i386_ss.add(when: 'CONFIG_I440FX', if_true: files('pc_piix.c'))
 i386_ss.add(when: 'CONFIG_MICROVM', if_true: files('microvm.c', 'acpi-microvm.c', 'microvm-dt.c'))
 i386_ss.add(when: 'CONFIG_Q35', if_true: files('pc_q35.c'))
-- 
2.41.0


