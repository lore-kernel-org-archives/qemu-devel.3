Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2761FC3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 20:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb49l-0005n4-Ft; Mon, 05 Aug 2024 16:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3ejOxZgUKCuEWDYLSJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--tavip.bounces.google.com>)
 id 1sb49g-0004wE-Iu
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:18:09 -0400
Received: from mail-pf1-x44a.google.com ([2607:f8b0:4864:20::44a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3ejOxZgUKCuEWDYLSJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--tavip.bounces.google.com>)
 id 1sb49e-0001YG-Pr
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 16:18:08 -0400
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-71065f49b10so4642372b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 13:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1722889084; x=1723493884; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=3GjBap7FxZdPpDdgQeaY7XNjHE33uQ9g7r73DwU0Kyw=;
 b=pWxmf9Aoupp/srEsQyrS2UCJIHAwT1L7Ou3GOx9mAdhznqSok6OPw1BGzskOSLfALr
 XJwzaoQ6WjKvdpC7Q5YabiT7J+kkLVc7hzc1kfL7UMhGe9UinqZMhHjW0gVQYZkVCFAi
 wtBS7Uac0vlf9IosOJN/0ZIoEa0iE6gDiTW4XsDHZjHGOmZIcWrh/65JczlR2BL0Gb6S
 njaItpeoQL7DyDtqrZgnJppnvkbj/ocJ8ABek+foXLpKQUKgeEQu+eNaPS3StwGJo1rP
 rqYXD2mLsQpTWlMC5kkj4YfY0HhBqqt9XUrNaavBk48qOqJohVDGFgQ7PyrjNjOT6Zg3
 wBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722889084; x=1723493884;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3GjBap7FxZdPpDdgQeaY7XNjHE33uQ9g7r73DwU0Kyw=;
 b=HKxdznFdD6EP0IAeh88mW3cv/KfxCq1lB9yF66GZc1IeZ7kFvQd4KbiBnS7i6TaKKW
 pxNAHBxgVVgRA+QW/QuV6oSQC2y5VsTosDw9PxQFuOgh4sMgpkvF3VF5UPnuLHSrswOd
 zsqJhvnTxcRGqm+vquYd+zM5/kAbl3Ustc4pyAYErsSHYPHZFDUL1E75Tye984xGzEh8
 zmaUVMiY2pSemdGnlYoK0V0zbMdZIDoa4RtseSjecz9/2eGJReYn5jkqX/Jpht0EWt89
 7O5jtMaBCsfQhdV+oFdr5G+xCq3212xQxsGS3F8R1NAAChs4ouEdnyautfoI5RAF/l78
 tgJQ==
X-Gm-Message-State: AOJu0YxpC6HDHkYvBmwMGK2iGfc3g6z6uRZOAvKAQi6ECeuwP1vqRnyJ
 Mq5pvXnfbc6tg84olYelupJ2b31UaBmQpGxcukE3BSBHBCDDcmfRGtcHqkFHrt4AgXhLDOR3WrN
 bZ5qMKJrwGZSqCBCGJdXnQo8O7ddNPoG/vb87yAWNvlkx0eGVg0hfDA+NQikUdqS3Op2XrZS/ze
 5V87v8vljl5IYtXzVIbUI2p4I3cw==
X-Google-Smtp-Source: AGHT+IEXkrqOE/XzNbGuVKsM0VKvpvoMdnNt3Ub2rtyWCRwYu7a+ohGR2cw4S360MRHtx60w8KRKA+NVSw==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a05:6a00:9153:b0:710:5798:44de
 with SMTP id
 d2e1a72fcca58-7106cf97a92mr55487b3a.2.1722889082012; Mon, 05 Aug 2024
 13:18:02 -0700 (PDT)
Date: Mon,  5 Aug 2024 13:17:18 -0700
In-Reply-To: <20240805201719.2345596-1-tavip@google.com>
Mime-Version: 1.0
References: <20240805201719.2345596-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240805201719.2345596-24-tavip@google.com>
Subject: [RFC PATCH 23/23] hw/arm: add RT595-EVK board
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 alex.bennee@linaro.org, thuth@redhat.com, peter.maydell@linaro.org, 
 marcandre.lureau@redhat.com, alistair@alistair23.me, berrange@redhat.com, 
 philmd@linaro.org, jsnow@redhat.com, crosa@redhat.com, bleal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::44a;
 envelope-from=3ejOxZgUKCuEWDYLSJRRJOH.FRPTHPX-GHYHOQRQJQX.RUJ@flex--tavip.bounces.google.com;
 helo=mail-pf1-x44a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=unavailable autolearn_force=no
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

Add basic support for the RT595-EVK board, enough to be able to run
the NXP's microXpresso SDK hello world example.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 hw/arm/Kconfig     |  5 ++++
 hw/arm/meson.build |  1 +
 hw/arm/rt595-evk.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)
 create mode 100644 hw/arm/rt595-evk.c

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 7ffece3dec..26ec3d391a 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -720,3 +720,8 @@ config RT500
     select RT500_CLKCTL1
     select FLEXSPI
     select RT500_RSTCTL
+
+config RT595_EVK
+    bool
+    default y
+    select RT500
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 7d827d512c..9792c93142 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -60,6 +60,7 @@ arm_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-e
 arm_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
 arm_ss.add(when: 'CONFIG_XEN', if_true: files('xen_arm.c'))
 arm_ss.add(when: 'CONFIG_RT500', if_true: files('rt500.c'))
+arm_ss.add(when: 'CONFIG_RT595_EVK', if_true: files('rt595-evk.c'))
 
 system_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
 system_ss.add(when: 'CONFIG_CHEETAH', if_true: files('palm.c'))
diff --git a/hw/arm/rt595-evk.c b/hw/arm/rt595-evk.c
new file mode 100644
index 0000000000..fff3004195
--- /dev/null
+++ b/hw/arm/rt595-evk.c
@@ -0,0 +1,64 @@
+/*
+ * i.MX RT595 EVK
+ *
+ * Copyright (c) 2024 Google LLC
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "elf.h"
+#include "exec/address-spaces.h"
+#include "hw/loader.h"
+#include "hw/sysbus.h"
+#include "hw/boards.h"
+#include "qemu/log.h"
+#include "hw/arm/armv7m.h"
+#include "hw/misc/unimp.h"
+#include "hw/arm/rt500.h"
+#include "hw/qdev-clock.h"
+#include "sysemu/reset.h"
+
+static void rt595_evk_reset(MachineState *ms, ShutdownCause reason)
+{
+    /*
+     * CPU reset is not done by default, we need to do it manually when the
+     * machine is reset.
+     */
+    cpu_reset(first_cpu);
+
+    qemu_devices_reset(reason);
+}
+
+static void rt595_evk_init(MachineState *ms)
+{
+    RT500State *s;
+    Clock *sysclk;
+
+    sysclk = clock_new(OBJECT(ms), "SYSCLK");
+    clock_set_hz(sysclk, 200000000);
+
+    s = RT500(object_new(TYPE_RT500));
+    qdev_connect_clock_in(DEVICE(s), "sysclk", sysclk);
+    object_property_add_child(OBJECT(ms), "soc", OBJECT(s));
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
+
+    if (ms->kernel_filename) {
+        armv7m_load_kernel(ARM_CPU(first_cpu), ms->kernel_filename, 0, 0);
+    }
+}
+
+static void rt595_evk_machine_init(MachineClass *mc)
+{
+    mc->desc  = "RT595 EVK Machine (ARM Cortex-M33)";
+    mc->init  = rt595_evk_init;
+    mc->reset = rt595_evk_reset;
+
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m33");
+    mc->ignore_memory_transaction_failures = true;
+}
+
+DEFINE_MACHINE("rt595-evk", rt595_evk_machine_init);
-- 
2.46.0.rc2.264.g509ed76dc8-goog


