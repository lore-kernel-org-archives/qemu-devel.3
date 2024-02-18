Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C34EC5475B
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 13:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbh2l-00048q-AB; Sun, 18 Feb 2024 08:17:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rbh2j-00047r-NP
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 08:17:17 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rbh2h-0007uA-SY
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 08:17:17 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a3e4765c86eso78145366b.0
 for <qemu-devel@nongnu.org>; Sun, 18 Feb 2024 05:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708262233; x=1708867033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rNHqg32yvu2/OzdJqsuxrP3LIZ9BKLDlqJsOBukYfYk=;
 b=FeBldmd6mbM141UB3i6lpWb1rqOTjGXEZjhomThDhW0P4RQx5drUSrEDuhsK0cteH1
 mfbvt/J4wibdPoQFIL0GFwf+0YQOeIWYuSeZn43Fx7SNDhz0jJOifc7vA4vOYO4HnNF/
 ofplSbT4z1E7mdlMN8w0dogC50NiF4xLBpO5/qthTvDMysKlKSkJktjAk2L5D/LCPWau
 4XnwgPYKYAe5nO9R3PC2pVn/LWdshH5fd3FXA+zN9bhZVI1rfvqN4sHPaWciEFNXKP4d
 Bz7eSp8yY0AbBK4RERpMqmNdQB8r6CrMq4aiFH8W3FrQgN5zq4wiYwV9nPW143hiEBMb
 7pwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708262233; x=1708867033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rNHqg32yvu2/OzdJqsuxrP3LIZ9BKLDlqJsOBukYfYk=;
 b=q3oMYg4fw+O9JC4V5K8pz6cli8fv69jolLCIC3zJ/Ec43/yHJe0yCLtEh8isWNvdLm
 oIqIXTjURIKA/L20+wcEl/Wuq8xLKW6MOHmlstC9mn8OKZexh9EPk8zefC3OBfKUNygV
 YZb9OFjRNXndhU22LcqmQ/zn7n2wjQlsc94qrNY2I5DPsP6dWJpNTGXUnEVtGPEWnTvd
 bx8+cM3bbwLKjLynSbv3B9v0WqzU4Suz12LEO7VQb9G/c69mIWMvjyijaImS578ldb95
 MBKnx8rTTmgvnFuK9zFiBNpyNgiTarnFmOWs/X2Jho3sQwqExudq/LTMpCE+8UUOxm4Q
 nEbg==
X-Gm-Message-State: AOJu0Yz6zo+0vg4926wgYsZEscX6U06fEFyteGCptMDcVJ30iVOPHq72
 rUeUMa6D9Zk05sk9nJVLIYWeEGFydZmNYDFC0RKqQ46SBJvhXr+gsVOG/5tY
X-Google-Smtp-Source: AGHT+IFVOfWuJwoAVbI/6fUiDTGVaEmeNlkYhWjZM3qx4RseTjkzbvDQzRE51We7cEjxh3fYcyAlrg==
X-Received: by 2002:a17:906:ad96:b0:a3e:89b7:3acd with SMTP id
 la22-20020a170906ad9600b00a3e89b73acdmr341918ejb.77.1708262233182; 
 Sun, 18 Feb 2024 05:17:13 -0800 (PST)
Received: from archlinux.. (dynamic-078-054-149-080.78.54.pool.telefonica.de.
 [78.54.149.80]) by smtp.gmail.com with ESMTPSA id
 jw15-20020a170906e94f00b00a3e86a9c55asm255088ejb.146.2024.02.18.05.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Feb 2024 05:17:12 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 2/5] hw/i386/port92: Allow for TYPE_PORT92 to be embedded in
 devices
Date: Sun, 18 Feb 2024 14:16:58 +0100
Message-ID: <20240218131701.91132-3-shentey@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240218131701.91132-1-shentey@gmail.com>
References: <20240218131701.91132-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Port 92 is an integral part of south bridges. Allow for embedding it there.

South bridges aren't architecture-specific, so move port92.c to hw/isa which is
accessible to other architectures than x86.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/i386/pc.h      |  5 -----
 include/hw/isa/port92.h   | 30 ++++++++++++++++++++++++++++++
 hw/i386/pc.c              |  1 +
 hw/{i386 => isa}/port92.c | 14 +-------------
 hw/i386/Kconfig           |  1 +
 hw/i386/meson.build       |  3 +--
 hw/i386/trace-events      |  4 ----
 hw/isa/Kconfig            |  3 +++
 hw/isa/meson.build        |  1 +
 hw/isa/trace-events       |  4 ++++
 10 files changed, 42 insertions(+), 24 deletions(-)
 create mode 100644 include/hw/isa/port92.h
 rename hw/{i386 => isa}/port92.c (91%)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ec0e5efcb2..b2987209b1 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -188,11 +188,6 @@ void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus);
 
 void pc_i8259_create(ISABus *isa_bus, qemu_irq *i8259_irqs);
 
-/* port92.c */
-#define PORT92_A20_LINE "a20"
-
-#define TYPE_PORT92 "port92"
-
 /* pc_sysfw.c */
 void pc_system_flash_create(PCMachineState *pcms);
 void pc_system_flash_cleanup_unused(PCMachineState *pcms);
diff --git a/include/hw/isa/port92.h b/include/hw/isa/port92.h
new file mode 100644
index 0000000000..214783d071
--- /dev/null
+++ b/include/hw/isa/port92.h
@@ -0,0 +1,30 @@
+/*
+ * QEMU I/O port 0x92 (System Control Port A, to handle Fast Gate A20)
+ *
+ * Copyright (c) 2003-2004 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: MIT
+ */
+
+#ifndef HW_PORT92_H
+#define HW_PORT92_H
+
+#include "exec/memory.h"
+#include "hw/irq.h"
+#include "hw/isa/isa.h"
+#include "qom/object.h"
+
+#define TYPE_PORT92 "port92"
+OBJECT_DECLARE_SIMPLE_TYPE(Port92State, PORT92)
+
+struct Port92State {
+    ISADevice parent_obj;
+
+    MemoryRegion io;
+    uint8_t outport;
+    qemu_irq a20_out;
+};
+
+#define PORT92_A20_LINE "a20"
+
+#endif /* HW_PORT92_H */
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 196827531a..0b11d4576e 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -32,6 +32,7 @@
 #include "hw/i386/vmport.h"
 #include "sysemu/cpus.h"
 #include "hw/ide/internal.h"
+#include "hw/isa/port92.h"
 #include "hw/timer/hpet.h"
 #include "hw/loader.h"
 #include "hw/rtc/mc146818rtc.h"
diff --git a/hw/i386/port92.c b/hw/isa/port92.c
similarity index 91%
rename from hw/i386/port92.c
rename to hw/isa/port92.c
index 1070bfbf36..06df06b088 100644
--- a/hw/i386/port92.c
+++ b/hw/isa/port92.c
@@ -9,20 +9,8 @@
 #include "qemu/osdep.h"
 #include "sysemu/runstate.h"
 #include "migration/vmstate.h"
-#include "hw/irq.h"
-#include "hw/i386/pc.h"
+#include "hw/isa/port92.h"
 #include "trace.h"
-#include "qom/object.h"
-
-OBJECT_DECLARE_SIMPLE_TYPE(Port92State, PORT92)
-
-struct Port92State {
-    ISADevice parent_obj;
-
-    MemoryRegion io;
-    uint8_t outport;
-    qemu_irq a20_out;
-};
 
 static void port92_write(void *opaque, hwaddr addr, uint64_t val,
                          unsigned size)
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index a1846be6f7..ccf6de4a00 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -37,6 +37,7 @@ config PC
     select I8254
     select PCKBD
     select PCSPK
+    select PORT92
     select I8257
     select MC146818RTC
     # For ACPI builder:
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
index b9c1ca39cb..94d558edd6 100644
--- a/hw/i386/meson.build
+++ b/hw/i386/meson.build
@@ -24,8 +24,7 @@ i386_ss.add(when: 'CONFIG_ACPI', if_true: files('acpi-common.c'))
 i386_ss.add(when: 'CONFIG_PC', if_true: files(
   'pc.c',
   'pc_sysfw.c',
-  'acpi-build.c',
-  'port92.c'))
+  'acpi-build.c'))
 i386_ss.add(when: 'CONFIG_X86_FW_OVMF', if_true: files('pc_sysfw_ovmf.c'),
                                         if_false: files('pc_sysfw_ovmf-stubs.c'))
 
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 53c02d7ac8..b730589394 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -118,10 +118,6 @@ vmport_command(unsigned char command) "command: 0x%02x"
 x86_gsi_interrupt(int irqn, int level) "GSI interrupt #%d level:%d"
 x86_pic_interrupt(int irqn, int level) "PIC interrupt #%d level:%d"
 
-# port92.c
-port92_read(uint8_t val) "port92: read 0x%02x"
-port92_write(uint8_t val) "port92: write 0x%02x"
-
 # vmmouse.c
 vmmouse_get_status(void) ""
 vmmouse_mouse_event(int x, int y, int dz, int buttons_state) "event: x=%d y=%d dz=%d state=%d"
diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index 73c6470805..efdf43e92c 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -49,6 +49,9 @@ config PIIX
     select MC146818RTC
     select USB_UHCI
 
+config PORT92
+    bool
+
 config VT82C686
     bool
     select ISA_BUS
diff --git a/hw/isa/meson.build b/hw/isa/meson.build
index 3219282217..fb7cd44984 100644
--- a/hw/isa/meson.build
+++ b/hw/isa/meson.build
@@ -5,6 +5,7 @@ system_ss.add(when: 'CONFIG_ISA_BUS', if_true: files('isa-bus.c'))
 system_ss.add(when: 'CONFIG_ISA_SUPERIO', if_true: files('isa-superio.c'))
 system_ss.add(when: 'CONFIG_PC87312', if_true: files('pc87312.c'))
 system_ss.add(when: 'CONFIG_PIIX', if_true: files('piix.c'))
+system_ss.add(when: 'CONFIG_PORT92', if_true: files('port92.c'))
 system_ss.add(when: 'CONFIG_SMC37C669', if_true: files('smc37c669-superio.c'))
 system_ss.add(when: 'CONFIG_VT82C686', if_true: files('vt82c686.c'))
 
diff --git a/hw/isa/trace-events b/hw/isa/trace-events
index 1816e8307a..bb5d9f1078 100644
--- a/hw/isa/trace-events
+++ b/hw/isa/trace-events
@@ -10,6 +10,10 @@ superio_create_ide(int id, uint16_t base, unsigned int irq) "id=%d, base 0x%03x,
 pc87312_io_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
 pc87312_io_write(uint32_t addr, uint32_t val) "write addr=0x%x val=0x%x"
 
+# port92.c
+port92_read(uint8_t val) "port92: read 0x%02x"
+port92_write(uint8_t val) "port92: write 0x%02x"
+
 # apm.c
 apm_io_read(uint8_t addr, uint8_t val) "read addr=0x%x val=0x%02x"
 apm_io_write(uint8_t addr, uint8_t val) "write addr=0x%x val=0x%02x"
-- 
2.43.2


