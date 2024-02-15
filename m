Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20925C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 13:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rabcm-0007FH-SV; Thu, 15 Feb 2024 08:18:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rabck-0007F3-8t
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 08:17:58 -0500
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rabch-0002PW-KF
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 08:17:58 -0500
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2d0d7985dfdso11899951fa.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 05:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708003073; x=1708607873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=l9IGUtttahCdCLW0OwvIeBm4dO9N/LkoWFpO/XJc4zE=;
 b=peE9zYuFbdyL8sZXMtaVsHcxlCo+iBfGsmigN3VXc5RMBFtAjb65mwGjWxY9sQxFhO
 kh8EiavzilEKl2qJT0lDuOyh/KeuKAaTW/kDLg9bJr7Xb2sRr2zeunwtJqgC8+srF2Bj
 Kmzc234sLpPV8GC9AvVBC8IftX5Ru03liJidl9hAm4LMDVQVFMnisvbSDh812n1HJbhy
 PIDApDoUC79q20EdXuDCL+/TqOf+Gr+EU6Pvi1HnU10/mAMEdCe3ayVcAGptXnJxNt0+
 PNal7FiwLEGmnJJo+/aOPcVyd8qBXRSfThEuKEf8Pwox01tXKEipxJsHpectJjQXs2Xd
 8ZsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708003073; x=1708607873;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l9IGUtttahCdCLW0OwvIeBm4dO9N/LkoWFpO/XJc4zE=;
 b=ZVfQF/XXJFDWMX1YPX9gxYECXrO9ATZyvqD+srmMeYTm46pPbzPqbifDkwet56Tehs
 wY0rkWRj9xXczt2ULNb4jvHPltHD1OLhEdNLmmKqwO350pjmkCbHnghWCokwRu7034r6
 kRvBUPYVgWU48FQeZGt511jrnAFtxKdL8UAvxzFFNOrT/DgrJAtwS9On5w4IQ3ymlDAm
 3YNueBhuhJJU2q0SEwlJNfFvYEzEZ2tiyHt6bPsYzdu0n/yhLLLpMzN7cz1JAWlv7HVO
 V60l2uSfSQv+Rv8jF/5mjTZ5P2J/ftK9I76go1QcdELFPOa9cFo17+dAb/M/ILxowA0q
 KlHg==
X-Gm-Message-State: AOJu0YwAb/3AxDWDQQmVdRd6UeOvQjI4+7xJW+7bRH25V8MeWb+6iZgZ
 QYBDMIuOiEl31MKEvHEHyU+zX0y0LCrEQRN8C4AT5CuuFXe65QKP2aYfp5c1DOtTB4h50v1c4Kk
 xqP0=
X-Google-Smtp-Source: AGHT+IEih5QmUqA1i/Kdwi6ov1344kSYEX7TIt2R3hFEcLNeUknz/8F23vKFoiOIyXLs49HQYJCzQQ==
X-Received: by 2002:a2e:9187:0:b0:2d0:aa28:6f77 with SMTP id
 f7-20020a2e9187000000b002d0aa286f77mr1394876ljg.45.1708003072773; 
 Thu, 15 Feb 2024 05:17:52 -0800 (PST)
Received: from meli.delivery (adsl-125.37.6.3.tellas.gr. [37.6.3.125])
 by smtp.gmail.com with ESMTPSA id
 g6-20020aa7c586000000b005619eea3d52sm522325edq.8.2024.02.15.05.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 05:17:52 -0800 (PST)
Date: Thu, 15 Feb 2024 15:02:46 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Damien Hedde <dhedde@kalrayinc.com>, Zhao Liu <zhao1.liu@linux.intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 C=?UTF-8?B?w6k=?= dric Le Goater <clg@kaod.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Amir Gonnen <amir.gonnen@neuroblade.ai>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Luc Michel <luc.michel@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Eric Blake <eblake@redhat.com>,
 "Daniel P. Berrang=?UTF-8?B?w6k=?= " <berrange@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<f4bug@amsat.org>
Subject: Re: [PATCH v3 1/1] target: Add system emulation aiming to target any
 architecture
User-Agent: meli 0.8.5-rc.3
References: <20240215084654.56297-1-philmd@linaro.org>
 <20240215084654.56297-2-philmd@linaro.org>
In-Reply-To: <20240215084654.56297-2-philmd@linaro.org>
Message-ID: <8wflq.yweql5v2v6bo@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x22e.google.com
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

On Thu, 15 Feb 2024 10:46, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>From: Philippe Mathieu-Daudé <f4bug@amsat.org>
>
>Add the 'any'-architecture target.
>
>- Only consider 64-bit targets
>- Do not use any hardware accelerator (except qtest)
>- For architecture constants, use:
>  . max of supported targets phys/virt address space
>  . max of supported targets MMU modes
>  . min of supported targets variable page bits
>
>Build as:
>
>  $ ../configure --target-list=any-softmmu \
>                 --disable-hvf \
>                 --disable-kvm \
>                 --disable-nvmm \
>                 --disable-tcg \
>                 --disable-whpx \
>                 --disable-xen
>
>Test as:
>
>  $ qemu-system-any -M none,accel=qtest -monitor stdio
>  QEMU 6.2.50 monitor - type 'help' for more information

6.2.50? :)

>  (qemu) info mtree
>  address-space: I/O
>    0000000000000000-000000000000ffff (prio 0, i/o): io
>
>  address-space: memory
>    0000000000000000-ffffffffffffffff (prio 0, i/o): system
>
>  (qemu) info qom-tree
>  /machine (none-machine)
>    /peripheral (container)
>    /peripheral-anon (container)
>    /unattached (container)
>      /io[0] (memory-region)
>      /sysbus (System)
>      /system[0] (memory-region)
>  (qemu) info qtree
>  bus: main-system-bus
>    type System
>  (qemu) info cpus
>  (qemu)
>
>Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>---
> configs/devices/any-softmmu/default.mak |  9 +++++++++
> configs/targets/any-softmmu.mak         |  3 +++
> meson.build                             |  6 ++++--
> qapi/machine.json                       |  2 +-
> include/sysemu/arch_init.h              |  1 +
> target/any/cpu-param.h                  | 13 +++++++++++++
> target/any/cpu-qom.h                    | 12 ++++++++++++
> target/any/cpu.h                        | 24 ++++++++++++++++++++++++
> .gitlab-ci.d/buildtest.yml              | 20 ++++++++++++++++++++
> hw/any/meson.build                      |  5 +++++
> hw/meson.build                          |  1 +
> target/Kconfig                          |  1 +
> target/any/Kconfig                      |  4 ++++
> target/any/meson.build                  |  7 +++++++
> target/meson.build                      |  1 +
> 15 files changed, 106 insertions(+), 3 deletions(-)
> create mode 100644 configs/devices/any-softmmu/default.mak
> create mode 100644 configs/targets/any-softmmu.mak
> create mode 100644 target/any/cpu-param.h
> create mode 100644 target/any/cpu-qom.h
> create mode 100644 target/any/cpu.h
> create mode 100644 hw/any/meson.build
> create mode 100644 target/any/Kconfig
> create mode 100644 target/any/meson.build
>
>diff --git a/configs/devices/any-softmmu/default.mak b/configs/devices/any-softmmu/default.mak
>new file mode 100644
>index 0000000000..dab0ce770e
>--- /dev/null
>+++ b/configs/devices/any-softmmu/default.mak
>@@ -0,0 +1,9 @@
>+# SPDX-License-Identifier: GPL-2.0-or-later
>+
>+CONFIG_ISA_BUS=y
>+CONFIG_PCI=y
>+CONFIG_PCI_DEVICES=y
>+CONFIG_I2C=y
>+CONFIG_TPM=y
>+CONFIG_NUBUS=y
>+CONFIG_VIRTIO=y
>diff --git a/configs/targets/any-softmmu.mak b/configs/targets/any-softmmu.mak
>new file mode 100644
>index 0000000000..2c6cf1edd4
>--- /dev/null
>+++ b/configs/targets/any-softmmu.mak
>@@ -0,0 +1,3 @@
>+# SPDX-License-Identifier: GPL-2.0-or-later
>+
>+TARGET_ARCH=any
>diff --git a/meson.build b/meson.build
>index c1dc83e4c0..f6aee8218b 100644
>--- a/meson.build
>+++ b/meson.build
>@@ -46,7 +46,7 @@ qapi_trace_events = []
> bsd_oses = ['gnu/kfreebsd', 'freebsd', 'netbsd', 'openbsd', 'dragonfly', 'darwin']
> supported_oses = ['windows', 'freebsd', 'netbsd', 'openbsd', 'darwin', 'sunos', 'linux']
> supported_cpus = ['ppc', 'ppc64', 's390x', 'riscv32', 'riscv64', 'x86', 'x86_64',
>-  'arm', 'aarch64', 'loongarch64', 'mips', 'mips64', 'sparc64']
>+  'arm', 'aarch64', 'loongarch64', 'mips', 'mips64', 'sparc64', 'any']
> 
> cpu = host_machine.cpu_family()
> 
>@@ -3043,7 +3043,9 @@ foreach target : target_dirs
>     if default_targets
>       continue
>     endif
>-    error('No accelerator available for target @0@'.format(target))
>+    if 'any-softmmu' not in target_dirs
>+      error('No accelerator available for target @0@'.format(target))
>+    endif
>   endif
> 
>   actual_target_dirs += target
>diff --git a/qapi/machine.json b/qapi/machine.json
>index d816c5c02e..8d3dcd5fb4 100644
>--- a/qapi/machine.json
>+++ b/qapi/machine.json
>@@ -36,7 +36,7 @@
>              'mips64el', 'mipsel', 'nios2', 'or1k', 'ppc',
>              'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
>              'sh4eb', 'sparc', 'sparc64', 'tricore',
>-             'x86_64', 'xtensa', 'xtensaeb' ] }
>+             'x86_64', 'xtensa', 'xtensaeb', 'any' ] }

This array looks alphabetically sorted (before the `any`), might that be 
on purpose?

> 
> ##
> # @CpuS390State:
>diff --git a/include/sysemu/arch_init.h b/include/sysemu/arch_init.h
>index 8850cb1a14..49bee75610 100644
>--- a/include/sysemu/arch_init.h
>+++ b/include/sysemu/arch_init.h
>@@ -4,6 +4,7 @@
> 
> enum {
>     QEMU_ARCH_ALL = -1,
>+    QEMU_ARCH_ANY = -1,
>     QEMU_ARCH_ALPHA = (1 << 0),
>     QEMU_ARCH_ARM = (1 << 1),
>     QEMU_ARCH_CRIS = (1 << 2),
>diff --git a/target/any/cpu-param.h b/target/any/cpu-param.h
>new file mode 100644
>index 0000000000..42e38ae991
>--- /dev/null
>+++ b/target/any/cpu-param.h
>@@ -0,0 +1,13 @@
>+/* SPDX-License-Identifier: GPL-2.0-or-later */
>+#ifndef ANY_CPU_PARAM_H
>+#define ANY_CPU_PARAM_H
>+
>+#define TARGET_LONG_BITS 64
>+
>+#define TARGET_PHYS_ADDR_SPACE_BITS 64 /* MAX(targets) */
>+#define TARGET_VIRT_ADDR_SPACE_BITS 64 /* MAX(targets) */
>+
>+#define TARGET_PAGE_BITS_VARY
>+#define TARGET_PAGE_BITS_MIN  10 /* MIN(targets)=ARMv5/ARMv6, ignoring AVR */
>+
>+#endif

Nit:

-#endif
+#endif /* ANY_CPU_PARAM_H */

(And for the other #endifs following)

>diff --git a/target/any/cpu-qom.h b/target/any/cpu-qom.h
>new file mode 100644
>index 0000000000..18d6a85de9
>--- /dev/null
>+++ b/target/any/cpu-qom.h
>@@ -0,0 +1,12 @@
>+/* SPDX-License-Identifier: GPL-2.0-or-later */
>+#ifndef QEMU_DUMMY_CPU_QOM_H
>+#define QEMU_DUMMY_CPU_QOM_H
>+
>+#include "hw/core/cpu.h"
>+#include "qom/object.h"
>+
>+#define TYPE_DUMMY_CPU "dummy-cpu"
>+
>+OBJECT_DECLARE_CPU_TYPE(DUMMYCPU, CPUClass, DUMMY_CPU)
>+
>+#endif
>diff --git a/target/any/cpu.h b/target/any/cpu.h
>new file mode 100644
>index 0000000000..e8abb8891f
>--- /dev/null
>+++ b/target/any/cpu.h
>@@ -0,0 +1,24 @@
>+/* SPDX-License-Identifier: GPL-2.0-or-later */
>+#ifndef TARGET_ANY_CPU_H
>+#define TARGET_ANY_CPU_H
>+
>+#include "cpu-qom.h"
>+#include "exec/cpu-defs.h"
>+
>+#define DUMMY_CPU_TYPE_SUFFIX "-" TYPE_DUMMY_CPU
>+#define DUMMY_CPU_TYPE_NAME(name) (name DUMMY_CPU_TYPE_SUFFIX)
>+#define CPU_RESOLVING_TYPE TYPE_DUMMY_CPU
>+
>+struct CPUArchState {
>+    /* nothing here */
>+};
>+
>+struct ArchCPU {
>+    CPUState parent_obj;
>+

+    /* Properties */

?


>+    CPUArchState env;
>+};
>+
>+#include "exec/cpu-all.h" /* FIXME remove once exec/ headers cleaned */
>+
>+#endif
>diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
>index f56df59c94..208625d4d5 100644
>--- a/.gitlab-ci.d/buildtest.yml
>+++ b/.gitlab-ci.d/buildtest.yml
>@@ -729,3 +729,23 @@ pages:
>       - public
>   variables:
>     QEMU_JOB_PUBLISH: 1
>+
>+build-system-any:
>+  extends:
>+    - .native_build_job_template
>+  needs:
>+    - job: amd64-alpine-container
>+  variables:
>+    IMAGE: alpine
>+    TARGETS: any-softmmu
>+    MAKE_CHECK_ARGS: check-qtest
>+    CONFIGURE_ARGS:
>+      --disable-tools
>+      --disable-hvf
>+      --disable-kvm
>+      --disable-nvmm
>+      --disable-tcg
>+      --disable-whpx
>+      --disable-xen
>+      --with-default-devices
>+      --enable-qom-cast-debug
>diff --git a/hw/any/meson.build b/hw/any/meson.build
>new file mode 100644
>index 0000000000..60e1567e53
>--- /dev/null
>+++ b/hw/any/meson.build
>@@ -0,0 +1,5 @@
>+# SPDX-License-Identifier: GPL-2.0-or-later
>+
>+any_ss = ss.source_set()
>+
>+hw_arch += {'any': any_ss}
>diff --git a/hw/meson.build b/hw/meson.build
>index 463d702683..644eeee938 100644
>--- a/hw/meson.build
>+++ b/hw/meson.build
>@@ -47,6 +47,7 @@ subdir('xenpv')
> subdir('fsi')
> 
> subdir('alpha')
>+subdir('any')
> subdir('arm')
> subdir('avr')
> subdir('cris')
>diff --git a/target/Kconfig b/target/Kconfig
>index 83da0bd293..09109c4884 100644
>--- a/target/Kconfig
>+++ b/target/Kconfig
>@@ -1,4 +1,5 @@
> source alpha/Kconfig
>+source any/Kconfig
> source arm/Kconfig
> source avr/Kconfig
> source cris/Kconfig
>diff --git a/target/any/Kconfig b/target/any/Kconfig
>new file mode 100644
>index 0000000000..8840d70e55
>--- /dev/null
>+++ b/target/any/Kconfig
>@@ -0,0 +1,4 @@
>+# SPDX-License-Identifier: GPL-2.0-or-later
>+
>+config ANY
>+    bool
>diff --git a/target/any/meson.build b/target/any/meson.build
>new file mode 100644
>index 0000000000..4f5422d3a3
>--- /dev/null
>+++ b/target/any/meson.build
>@@ -0,0 +1,7 @@
>+# SPDX-License-Identifier: GPL-2.0-or-later
>+
>+any_ss = ss.source_set()
>+any_system_ss = ss.source_set()
>+
>+target_arch += {'any': any_ss}
>+target_system_arch += {'any': any_system_ss}
>diff --git a/target/meson.build b/target/meson.build
>index dee2ac47e0..c75b91e1b9 100644
>--- a/target/meson.build
>+++ b/target/meson.build
>@@ -1,4 +1,5 @@
> subdir('alpha')
>+subdir('any')
> subdir('arm')
> subdir('avr')
> subdir('cris')
>-- 
>2.41.0
>
>


LGTM in general overall. In case this wasn't discussed already, would it 
be a good idea to name the target x-any if it ends up in a stable 
release?

Regardless of my inlined style comments:

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

