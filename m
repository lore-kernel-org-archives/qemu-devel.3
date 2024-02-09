Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8491C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 15:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYSpL-000877-NJ; Fri, 09 Feb 2024 10:30:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYSpG-00083z-Rj
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 10:30:03 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYSpE-0007Kh-7F
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 10:30:02 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-410489e1a63so9080415e9.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 07:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707492596; x=1708097396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q3SNaR8MCIy3Cp6ShxN0kBG/XYz4BZ/jXo+xp52VEZc=;
 b=uLD3WTO0Kgc3JgutD5WUQoz4PgOV3PXzAjcu/BSt4mMy+Nz+NuxRmOFcVRD/0dFV80
 N4546u3G7mzgd83QM9S7MLnsvWwYknZW1gU3CRCV1lbtbqajrpVidnj+LfEQmZZil/1c
 NMsPek2+Nh9Pzka2TcAB3C8QlQTtNRHE1Q4OjWUSZfozOp9ddgn/CTI67Jrx3qUhZgr0
 nvAIrmlj6n14SsvYvDHlBIkMp8svydf4GiwxC93Mr0wAWu3rY2qVqzhbNAX2jw88F2C6
 MvUqfmnjZrmmLTVwpLYD8489HbDmoN+By/rdCY30f6PEL23HkKSvFhCuKkRYXa6f3ShF
 UeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707492596; x=1708097396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q3SNaR8MCIy3Cp6ShxN0kBG/XYz4BZ/jXo+xp52VEZc=;
 b=pMb7EdGoLTn7Zi2iaxjYufUyMSqaAEVgdXruTJAlDHkSLPzTfVz42oHajNMWnM6DIa
 PR3fC8xbKO7b3i8SZB1iHqdxtv3B/BweWCy738frqiDfQbOqfjIWeiBZpb18u/K850DW
 4Ajh+OFo29gfCjprf8c6I5dikTFLl2YhQLe8FQGEC9G4UmV21qplyFTsPAlFYgS7y/WX
 cLw/dxlvkmVii6KH3yF9PyCckYCOKFvIDVAzoc87WmaRdJyVzy+ZPPjejghuKPVJ0LtB
 JWhNJ/1rmuSavz66rS7KeadfLvsZ16liz8N8Q8xCdqII1vd4Wb5yczfw39oG4/0Q2t/D
 Wkiw==
X-Gm-Message-State: AOJu0YydSk8jbEBqMj9pi4QEsDwgZvwMuImy3950gG1yRra/BOvkNSCZ
 T/s6AYr2UwfMbwrAsS1E25J5gIQ55cxouuWyPPxQTcHPneemfWR3s4i0b91tfNXBl9/u8ZvuR1i
 N
X-Google-Smtp-Source: AGHT+IHq403L4iNFmnt/phpxluVUapk9bhmZKYWsb2SQ1Fw0rVU4B768ISKc0rSara9y5Ec7iIFtKg==
X-Received: by 2002:a05:600c:4f15:b0:40f:d25c:41d0 with SMTP id
 l21-20020a05600c4f1500b0040fd25c41d0mr1616758wmq.29.1707492595955; 
 Fri, 09 Feb 2024 07:29:55 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVB7lRcD/5JR3/hVLS/p7ESzfXsrUmDCSXzEKbk41lnuoW2ic+EHdsDZyMyMjKHS10m2SrhukNFL+ktv5/pvVnY94yuseXvIDLeIGSRIL9E6abpJVTwy90gwbTbxUBlLL9X4M/U+4KgvOIx/41yXAkpitBV24XYk8dPoI8KAsKDPg3inJenK+HIfJLiu5WwXxTL5r50HyUnDoW322tTkqgWSvKAaDMAOQ6pe/Dz34qNGvJHgXlbbaX/6mKtnu8l1i182taNw2X66IQblEcTBkJvKFzz5g9aME24GZMEYCAyP32lIut2eoO16g8/Ew0E5IWDTjx/3kUI/pmGS9jliqfdGvPqJ0Uh1N66tICFKtp0wdIKMTwnMG+W4RbqUeGUHFt0FjFbfc72Bblvu87SvOJLU5WHqQIXRM7yXv3TX15uHeq4cZ+aCLrzXK6A0TCggRK9KIDW8xXJWcIxoARwQ3QkvRQZbYc35ZVGVbGj1W3Finm3VXj982EjOQw83u+HE+9z0CequG42U3wRJBxmkDUSunyMN5iRl7UGztBsfH1+A9RvVmqGWOv83V9ka0pUE8nYN8nVYKYm4nFcxhrZrmRnIneD9rYH84AIToheqOnw1qYrSr2foYDgnf7+N0gD9W2EiUAhRQWPHuh5b47dp87qe3Nf/43KWSxwuaW9X2/s6jx+VowdzCl4sglG5eFJwnGf1EWShW7o76CpAvOM9KGcdTyl8/in9mQoIIvek1dwXW+CTv4Ejtqf
Received: from m1x-phil.lan ([176.187.218.105])
 by smtp.gmail.com with ESMTPSA id
 k15-20020a05600c1c8f00b0040fd18f231fsm1029868wms.3.2024.02.09.07.29.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 09 Feb 2024 07:29:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Amir Gonnen <amir.gonnen@neuroblade.ai>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Damien Hedde <dhedde@kalrayinc.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Eric Blake <eblake@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Beraldo Leal <bleal@redhat.com>,
 Zhao Liu <zhao1.liu@linux.intel.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v2 1/1] target: Add system emulation aiming to target any
 architecture
Date: Fri,  9 Feb 2024 16:29:45 +0100
Message-ID: <20240209152945.25727-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240209152945.25727-1-philmd@linaro.org>
References: <20240209152945.25727-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Add the 'any'-architecture target.

- Only consider 64-bit targets
- Do not use any hardware accelerator (except qtest)
- For architecture constants, use:
  . max of supported targets phys/virt address space
  . max of supported targets MMU modes
  . min of supported targets variable page bits

Build as:

  $ ../configure --target-list=any-softmmu \
                 --disable-hvf \
                 --disable-kvm \
                 --disable-nvmm \
                 --disable-tcg \
                 --disable-whpx \
                 --disable-xen

Test as:

  $ qemu-system-any -M none,accel=qtest -monitor stdio
  QEMU 6.2.50 monitor - type 'help' for more information
  (qemu) info mtree
  address-space: I/O
    0000000000000000-000000000000ffff (prio 0, i/o): io

  address-space: memory
    0000000000000000-ffffffffffffffff (prio 0, i/o): system

  (qemu) info qom-tree
  /machine (none-machine)
    /peripheral (container)
    /peripheral-anon (container)
    /unattached (container)
      /io[0] (memory-region)
      /sysbus (System)
      /system[0] (memory-region)
  (qemu) info qtree
  bus: main-system-bus
    type System
  (qemu) info cpus
  (qemu)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 configs/devices/any-softmmu/default.mak |  9 +++++++++
 configs/targets/any-softmmu.mak         |  3 +++
 meson.build                             |  6 ++++--
 qapi/machine.json                       |  2 +-
 include/sysemu/arch_init.h              |  1 +
 target/any/cpu-param.h                  | 13 +++++++++++++
 target/any/cpu-qom.h                    | 12 ++++++++++++
 target/any/cpu.h                        | 24 ++++++++++++++++++++++++
 .gitlab-ci.d/buildtest.yml              | 20 ++++++++++++++++++++
 hw/any/meson.build                      |  5 +++++
 hw/meson.build                          |  1 +
 target/Kconfig                          |  1 +
 target/any/Kconfig                      |  4 ++++
 target/any/meson.build                  |  7 +++++++
 target/meson.build                      |  1 +
 15 files changed, 106 insertions(+), 3 deletions(-)
 create mode 100644 configs/devices/any-softmmu/default.mak
 create mode 100644 configs/targets/any-softmmu.mak
 create mode 100644 target/any/cpu-param.h
 create mode 100644 target/any/cpu-qom.h
 create mode 100644 target/any/cpu.h
 create mode 100644 hw/any/meson.build
 create mode 100644 target/any/Kconfig
 create mode 100644 target/any/meson.build

diff --git a/configs/devices/any-softmmu/default.mak b/configs/devices/any-softmmu/default.mak
new file mode 100644
index 0000000000..dab0ce770e
--- /dev/null
+++ b/configs/devices/any-softmmu/default.mak
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+CONFIG_ISA_BUS=y
+CONFIG_PCI=y
+CONFIG_PCI_DEVICES=y
+CONFIG_I2C=y
+CONFIG_TPM=y
+CONFIG_NUBUS=y
+CONFIG_VIRTIO=y
diff --git a/configs/targets/any-softmmu.mak b/configs/targets/any-softmmu.mak
new file mode 100644
index 0000000000..2c6cf1edd4
--- /dev/null
+++ b/configs/targets/any-softmmu.mak
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+TARGET_ARCH=any
diff --git a/meson.build b/meson.build
index e5d6f2d057..8a50193fa2 100644
--- a/meson.build
+++ b/meson.build
@@ -46,7 +46,7 @@ qapi_trace_events = []
 bsd_oses = ['gnu/kfreebsd', 'freebsd', 'netbsd', 'openbsd', 'dragonfly', 'darwin']
 supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux']
 supported_cpus = ['ppc', 'ppc64', 's390x', 'riscv32', 'riscv64', 'x86', 'x86_64',
-  'arm', 'aarch64', 'loongarch64', 'mips', 'mips64', 'sparc64']
+  'arm', 'aarch64', 'loongarch64', 'mips', 'mips64', 'sparc64', 'any']
 
 cpu = host_machine.cpu_family()
 
@@ -3016,7 +3016,9 @@ foreach target : target_dirs
     if default_targets
       continue
     endif
-    error('No accelerator available for target @0@'.format(target))
+    if 'any-softmmu' not in target_dirs
+      error('No accelerator available for target @0@'.format(target))
+    endif
   endif
 
   actual_target_dirs += target
diff --git a/qapi/machine.json b/qapi/machine.json
index aa99fa333f..ac300669bb 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -36,7 +36,7 @@
              'mips64el', 'mipsel', 'nios2', 'or1k', 'ppc',
              'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
              'sh4eb', 'sparc', 'sparc64', 'tricore',
-             'x86_64', 'xtensa', 'xtensaeb' ] }
+             'x86_64', 'xtensa', 'xtensaeb', 'any' ] }
 
 ##
 # @CpuS390State:
diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
index 8850cb1a14..49bee75610 100644
--- a/include/sysemu/arch_init.h
+++ b/include/sysemu/arch_init.h
@@ -4,6 +4,7 @@
 
 enum {
     QEMU_ARCH_ALL = -1,
+    QEMU_ARCH_ANY = -1,
     QEMU_ARCH_ALPHA = (1 << 0),
     QEMU_ARCH_ARM = (1 << 1),
     QEMU_ARCH_CRIS = (1 << 2),
diff --git a/target/any/cpu-param.h b/target/any/cpu-param.h
new file mode 100644
index 0000000000..42e38ae991
--- /dev/null
+++ b/target/any/cpu-param.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef ANY_CPU_PARAM_H
+#define ANY_CPU_PARAM_H
+
+#define TARGET_LONG_BITS 64
+
+#define TARGET_PHYS_ADDR_SPACE_BITS 64 /* MAX(targets) */
+#define TARGET_VIRT_ADDR_SPACE_BITS 64 /* MAX(targets) */
+
+#define TARGET_PAGE_BITS_VARY
+#define TARGET_PAGE_BITS_MIN  10 /* MIN(targets)=ARMv5/ARMv6, ignoring AVR */
+
+#endif
diff --git a/target/any/cpu-qom.h b/target/any/cpu-qom.h
new file mode 100644
index 0000000000..18d6a85de9
--- /dev/null
+++ b/target/any/cpu-qom.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef QEMU_DUMMY_CPU_QOM_H
+#define QEMU_DUMMY_CPU_QOM_H
+
+#include "hw/core/cpu.h"
+#include "qom/object.h"
+
+#define TYPE_DUMMY_CPU "dummy-cpu"
+
+OBJECT_DECLARE_CPU_TYPE(DUMMYCPU, CPUClass, DUMMY_CPU)
+
+#endif
diff --git a/target/any/cpu.h b/target/any/cpu.h
new file mode 100644
index 0000000000..e8abb8891f
--- /dev/null
+++ b/target/any/cpu.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef TARGET_ANY_CPU_H
+#define TARGET_ANY_CPU_H
+
+#include "cpu-qom.h"
+#include "exec/cpu-defs.h"
+
+#define DUMMY_CPU_TYPE_SUFFIX "-" TYPE_DUMMY_CPU
+#define DUMMY_CPU_TYPE_NAME(name) (name DUMMY_CPU_TYPE_SUFFIX)
+#define CPU_RESOLVING_TYPE TYPE_DUMMY_CPU
+
+struct CPUArchState {
+    /* nothing here */
+};
+
+struct ArchCPU {
+    CPUState parent_obj;
+
+    CPUArchState env;
+};
+
+#include "exec/cpu-all.h" /* FIXME remove once exec/ headers cleaned */
+
+#endif
diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 79bbc8585b..f66ef21acf 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -726,3 +726,23 @@ pages:
       - public
   variables:
     QEMU_JOB_PUBLISH: 1
+
+build-system-any:
+  extends:
+    - .native_build_job_template
+  needs:
+    - job: amd64-alpine-container
+  variables:
+    IMAGE: alpine
+    TARGETS: any-softmmu
+    MAKE_CHECK_ARGS: check-unit
+    CONFIGURE_ARGS:
+      --disable-tools
+      --disable-hvf
+      --disable-kvm
+      --disable-nvmm
+      --disable-tcg
+      --disable-whpx
+      --disable-xen
+      --with-default-devices
+      --enable-qom-cast-debug
diff --git a/hw/any/meson.build b/hw/any/meson.build
new file mode 100644
index 0000000000..60e1567e53
--- /dev/null
+++ b/hw/any/meson.build
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+any_ss = ss.source_set()
+
+hw_arch += {'any': any_ss}
diff --git a/hw/meson.build b/hw/meson.build
index 463d702683..644eeee938 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -47,6 +47,7 @@ subdir('xenpv')
 subdir('fsi')
 
 subdir('alpha')
+subdir('any')
 subdir('arm')
 subdir('avr')
 subdir('cris')
diff --git a/target/Kconfig b/target/Kconfig
index 83da0bd293..09109c4884 100644
--- a/target/Kconfig
+++ b/target/Kconfig
@@ -1,4 +1,5 @@
 source alpha/Kconfig
+source any/Kconfig
 source arm/Kconfig
 source avr/Kconfig
 source cris/Kconfig
diff --git a/target/any/Kconfig b/target/any/Kconfig
new file mode 100644
index 0000000000..8840d70e55
--- /dev/null
+++ b/target/any/Kconfig
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+config ANY
+    bool
diff --git a/target/any/meson.build b/target/any/meson.build
new file mode 100644
index 0000000000..4f5422d3a3
--- /dev/null
+++ b/target/any/meson.build
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+any_ss = ss.source_set()
+any_system_ss = ss.source_set()
+
+target_arch += {'any': any_ss}
+target_system_arch += {'any': any_system_ss}
diff --git a/target/meson.build b/target/meson.build
index dee2ac47e0..c75b91e1b9 100644
--- a/target/meson.build
+++ b/target/meson.build
@@ -1,4 +1,5 @@
 subdir('alpha')
+subdir('any')
 subdir('arm')
 subdir('avr')
 subdir('cris')
-- 
2.41.0


