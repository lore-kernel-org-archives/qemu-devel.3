Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A2BC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 22:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhczA-0007CA-Ev; Tue, 05 Mar 2024 17:10:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhcz8-0007BA-HL
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 17:10:06 -0500
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhcz5-0000ks-9r
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 17:10:06 -0500
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-365337ad3e7so21022135ab.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 14:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709676602; x=1710281402; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=21zKJQxHw+9tb6jPZxlDkMDIp2DGhnFvj5Ft9MckQvg=;
 b=OE7ATzcd+cEjryfuaB67UBdRZbqdC3pxd1nA3SOPhosiNJIN0POs7tk5ftFCvf9d7n
 j2MMppeStW5OmDUjhESEkfJ+VlFhi4itsr1u9+nYyffx9M3O27Dn1OQG+BcHADI7kO/z
 N/nfUXuql+IM/BZucELtPW0P5T2+C/4iCJhbMD01gmIYOYAEA+59PK6O0I1bOYI7Ydy8
 m0CD+5z5wohD5u+dKv7zCv0ZEsWr/AM9LjWerfvBnO3EbYJmndtGAoq2seO7IA4dlBHS
 8ybErdNC8M4lLoi9/aWxjVzaZsnm7q8lCno/U8m4wMvRQM1dXHmk7DgYfSZhSv3qDCSo
 OuqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709676602; x=1710281402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=21zKJQxHw+9tb6jPZxlDkMDIp2DGhnFvj5Ft9MckQvg=;
 b=RL1G16jO6NH/PY9abA4tePCTpXq275sxFJB1PffYrHiwnsgifVmThPvjc4kY+8H6We
 GeRHbCwzjQhdUOzKeP4HalpOQ2Zq1OHy5mtxTN9vpF+doVSWP7vwG2ZZLatttQCK2SZm
 b0WFrkO0u+Ioq6oF599Vd5dD85sZvYgqS1JEUfz4xGu38aPb7OnXOIFnAQJ80SmZGT43
 avrpFRD1DYLO8/L/mKSI9vzXds39OPiccEfnm4XoP/sZuPPZ0cWZfHyAzIJoXgcI2ZqP
 bfJEiAtOnjob1fmRiZdW6tpIOde75yI4ZbRDXaT+zORqn8rv+cT9fZncR6cHgcOSfEyv
 LWdw==
X-Gm-Message-State: AOJu0YxB5GtYVTCRWnrl6JRp85loCfJ7QN1YmjagxfhjzVRGTowQkMbg
 quqO29XASfVRb4oI6lyhVnm8TljMfpfVG4zMTVlz6FcUAnAXoKt4KGOsY1ocsxmBLQCyH9yjmGp
 ah1o=
X-Google-Smtp-Source: AGHT+IG9f09X8p0k0lSKrcvRfGDebncx93ZV823RBVAytin4fHdukveCfwZEoqLQNCfT65gm8TUVeA==
X-Received: by 2002:a05:6e02:17c5:b0:365:27ef:23d3 with SMTP id
 z5-20020a056e0217c500b0036527ef23d3mr18599007ilu.20.1709676601483; 
 Tue, 05 Mar 2024 14:10:01 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.193])
 by smtp.gmail.com with ESMTPSA id
 l15-20020a056e021aaf00b0036426373792sm3267112ilv.87.2024.03.05.14.09.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Mar 2024 14:10:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v4 2/2] target: Add system emulation aiming to target any
 architecture
Date: Tue,  5 Mar 2024 23:09:38 +0100
Message-ID: <20240305220938.85410-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305220938.85410-1-philmd@linaro.org>
References: <20240305220938.85410-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-il1-x131.google.com
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

Since this is an experiment, the binary is named
'x-qemu-system-🚧', and won't be installed.

Build as:

  $ ../configure --target-list=any-softmmu \
                 --disable-hvf \
                 --disable-kvm \
                 --disable-nvmm \
                 --disable-tcg \
                 --disable-whpx \
                 --disable-xen \
                 --enable-experimental-system-binary-that-may-break-dont-do-this-distros

Test as:

  $ ./x-qemu-system-🚧 -M none,accel=qtest -monitor stdio
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
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configure                               |  6 ++++++
 configs/devices/any-softmmu/default.mak |  9 +++++++++
 configs/targets/any-softmmu.mak         |  3 +++
 meson.build                             | 15 +++++++++++----
 qapi/machine.json                       |  2 +-
 include/sysemu/arch_init.h              |  1 +
 target/any/cpu-param.h                  | 13 +++++++++++++
 target/any/cpu-qom.h                    | 12 ++++++++++++
 target/any/cpu.h                        | 24 ++++++++++++++++++++++++
 .gitlab-ci.d/buildtest.yml              | 21 +++++++++++++++++++++
 hw/any/meson.build                      |  5 +++++
 hw/meson.build                          |  1 +
 meson_options.txt                       |  3 +++
 scripts/meson-buildoptions.sh           |  5 +++++
 target/Kconfig                          |  1 +
 target/any/Kconfig                      |  4 ++++
 target/any/meson.build                  |  7 +++++++
 target/meson.build                      |  1 +
 tests/qtest/meson.build                 |  6 +++++-
 19 files changed, 133 insertions(+), 6 deletions(-)
 create mode 100644 configs/devices/any-softmmu/default.mak
 create mode 100644 configs/targets/any-softmmu.mak
 create mode 100644 target/any/cpu-param.h
 create mode 100644 target/any/cpu-qom.h
 create mode 100644 target/any/cpu.h
 create mode 100644 hw/any/meson.build
 create mode 100644 target/any/Kconfig
 create mode 100644 target/any/meson.build

diff --git a/configure b/configure
index 3cd736b139..57f6c7038b 100755
--- a/configure
+++ b/configure
@@ -194,6 +194,7 @@ EXTRA_LDFLAGS=""
 # Distributions want to ensure that several features are compiled in, and it
 # is impossible without a --enable-foo that exits if a feature is not found.
 default_feature=""
+target_system_any=""
 
 for opt do
   optarg=$(expr "x$opt" : 'x[^=]*=\(.*\)')
@@ -693,6 +694,8 @@ for opt do
   ;;
   --without-default-features) # processed above
   ;;
+  --enable-experimental-system-binary-that-may-break-dont-do-this-distros) target_system_any="yes"
+  ;;
   --static) static="yes"
   ;;
   --host=*|--build=*|\
@@ -834,6 +837,9 @@ fi
 
 for config in $mak_wilds; do
     target="$(basename "$config" .mak)"
+    if [ "$target" = any-softmmu ] && [ "$target_system_any" != yes ]; then
+        continue
+    fi
     if echo "$target_list_exclude" | grep -vq "$target"; then
         default_target_list="${default_target_list} $target"
     fi
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
index 51b995f4c7..a4fe9f23d0 100644
--- a/meson.build
+++ b/meson.build
@@ -3051,7 +3051,9 @@ foreach target : target_dirs
     if default_targets
       continue
     endif
-    error('No accelerator available for target @0@'.format(target))
+    if 'any-softmmu' not in target_dirs
+      error('No accelerator available for target @0@'.format(target))
+    endif
   endif
 
   actual_target_dirs += target
@@ -3909,16 +3911,21 @@ foreach target : target_dirs
                  name_suffix: 'fa')
 
   if target.endswith('-softmmu')
+    if target_name == 'any'
+      qemu_system_name = 'x-qemu-system-🚧'
+    else
+      qemu_system_name = 'qemu-system-' + target_name
+    endif
     execs = [{
-      'name': 'qemu-system-' + target_name,
+      'name': qemu_system_name,
       'win_subsystem': 'console',
       'sources': files('system/main.c'),
       'dependencies': [],
-      'install': true
+      'install': target_name != 'any'
     }]
     if host_os == 'windows' and (sdl.found() or gtk.found())
       execs += [{
-        'name': 'qemu-system-' + target_name + 'w',
+        'name': qemu_system_name + 'w',
         'win_subsystem': 'windows',
         'sources': files('system/main.c'),
         'dependencies': [],
diff --git a/qapi/machine.json b/qapi/machine.json
index bb5a178909..970aac2364 100644
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
index a1c030337b..493a868bfc 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -729,3 +729,24 @@ pages:
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
+    MAKE_CHECK_ARGS: check-qtest
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
+      --enable-experimental-system-binary-that-may-break-dont-do-this-distros
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
diff --git a/meson_options.txt b/meson_options.txt
index 0a99a059ec..afae66ad1c 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -368,3 +368,6 @@ option('qemu_ga_version', type: 'string', value: '',
 
 option('hexagon_idef_parser', type : 'boolean', value : true,
        description: 'use idef-parser to automatically generate TCG code for the Hexagon frontend')
+
+option('experimental-system-binary-that-may-break-dont-do-this-distros', type : 'boolean', value : false,
+       description: 'build experimental qemu-system-any binary with no particular target architecture')
diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
index 680fa3f581..85f5aec267 100644
--- a/scripts/meson-buildoptions.sh
+++ b/scripts/meson-buildoptions.sh
@@ -32,6 +32,9 @@ meson_options_help() {
   printf "%s\n" '  --enable-debug-stack-usage'
   printf "%s\n" '                           measure coroutine stack usage'
   printf "%s\n" '  --enable-debug-tcg       TCG debugging'
+  printf "%s\n" '  --enable-experimental-system-binary-that-may-break-dont-do-this-distros'
+  printf "%s\n" '                           build experimental qemu-system-any binary with no'
+  printf "%s\n" '                           particular target architecture'
   printf "%s\n" '  --enable-fdt[=CHOICE]    Whether and how to find the libfdt library'
   printf "%s\n" '                           (choices: auto/disabled/enabled/internal/system)'
   printf "%s\n" '  --enable-fuzzing         build fuzzing targets'
@@ -306,6 +309,8 @@ _meson_option_parse() {
     --disable-docs) printf "%s" -Ddocs=disabled ;;
     --enable-dsound) printf "%s" -Ddsound=enabled ;;
     --disable-dsound) printf "%s" -Ddsound=disabled ;;
+    --enable-experimental-system-binary-that-may-break-dont-do-this-distros) printf "%s" -Dexperimental-system-binary-that-may-break-dont-do-this-distros=true ;;
+    --disable-experimental-system-binary-that-may-break-dont-do-this-distros) printf "%s" -Dexperimental-system-binary-that-may-break-dont-do-this-distros=false ;;
     --enable-fdt) printf "%s" -Dfdt=enabled ;;
     --disable-fdt) printf "%s" -Dfdt=disabled ;;
     --enable-fdt=*) quote_sh "-Dfdt=$2" ;;
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
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 6ea77893f5..e302d4153e 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -355,7 +355,11 @@ foreach dir : target_dirs
   endif
 
   target_base = dir.split('-')[0]
-  qtest_emulator = emulators['qemu-system-' + target_base]
+  if target_base == 'any'
+    qtest_emulator = emulators['x-qemu-system-🚧']
+  else
+    qtest_emulator = emulators['qemu-system-' + target_base]
+  endif
   target_qtests = get_variable('qtests_' + target_base, []) + qtests_generic
 
   test_deps = roms
-- 
2.41.0


