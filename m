Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC827CDD552
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 19:27:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sr0Gx-0005Rv-1X; Wed, 18 Sep 2024 15:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3qSjrZgUKCuQZGbOVMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--tavip.bounces.google.com>)
 id 1sr0Gs-00056e-3k
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:26 -0400
Received: from mail-yb1-xb49.google.com ([2607:f8b0:4864:20::b49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3qSjrZgUKCuQZGbOVMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--tavip.bounces.google.com>)
 id 1sr0Gq-0007Ml-Dj
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 15:23:25 -0400
Received: by mail-yb1-xb49.google.com with SMTP id
 3f1490d57ef6-e1ce98dcafaso156242276.0
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2024 12:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1726687403; x=1727292203; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=QCo9xmek7WzVKGlXYZp97A3tCGxyI9d8cl8h6DAFK9k=;
 b=iinyZjCQTuejRDUbt0T16qB9Ta6lh6Vb+mYMdiCdo2PYSbPGL94h//1s5eeuoDhUge
 Z+d3uh2ieZnrgAaCgxxiqB1V7YLd5DHf2RVS6MopyC4z9WsfpfEDH5wKI4DdXsYZO4tD
 Gg39FKliYDLoJLE9vkFOjA+53x5vA1KJTuJuv6flhlar5vWU3P5Sdfo+q+f0hGx/JLup
 ANdPc1QMdJ1Kcj4uRnkdPaaBggy1O740HjkVsfd3TRe+kxiMH+Tkxir4T5RBLEIqXTSH
 ELRfCNSFXD4Yznr7w2Au7dl+sqnENV7jmU8OQRwP1ZYNQ4auJL07uGTvuqZBBS14xWWk
 tZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726687403; x=1727292203;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QCo9xmek7WzVKGlXYZp97A3tCGxyI9d8cl8h6DAFK9k=;
 b=QVdbes2o8IZ/EcCJzedm8M2dU7dGXIFFQFmdZvjHnoHoCQvVX42MI1jz5sWQxCBB55
 1J+mppKWedQY60siva4I2dex+rpTFsobIIgKj5KBSE5nJm2EgPn2NzB4J0uHryeb2Gp/
 CBPuGVyRNUmfuxaQi2KeL5OQE5Arn6FzSUzAtOUaMBVkDDpfZM9pm8auK8n1Lkwn7EpR
 N9R9+KsuyhYTNcZsRFK+P1HPuBVeQCPONpXys7ny/bH28yF6QA/SadwMoPXXb4KPhhLY
 x4pkkbF+6Sg1mTaZWZ0KFBdvfq2e/sKSQMu8KQh4YanP01CGJCd2MIk6ol6SX9hdl1kj
 ZmUA==
X-Gm-Message-State: AOJu0YxBYC0+AEX163p4iMMsUAEn6qC+Ksn6eZimUNvq9Gx+gFWK3nLF
 zKCNQ+WdOf4QlnSsMdkHC/M+JpEUuSpFKLUdM0PdPnnUexezicVkzZNTKzxvRYlgmA7zaVDz2yU
 B5QBrx7XToAfP3p8O8X+eB6qtvTS8jzdhkTuOGTMk+JSYzIed+DaGvHrXdXyF8v9tjV0a+evVOE
 6OcoNeJ+5V3loBT2QaUUJYsuFxtg==
X-Google-Smtp-Source: AGHT+IE/K1DBINNp25PoxaoZXcwpsBX5JQnt0JkDAysIV9W73EIYqJ8j4R2tK5FysQbYttZzbNSjur+0ng==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a25:aa01:0:b0:e05:6532:166 with
 SMTP id
 3f1490d57ef6-e1daff60717mr45920276.1.1726687401837; Wed, 18 Sep 2024 12:23:21
 -0700 (PDT)
Date: Wed, 18 Sep 2024 12:22:42 -0700
In-Reply-To: <20240918192254.3136903-1-tavip@google.com>
Mime-Version: 1.0
References: <20240918192254.3136903-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240918192254.3136903-15-tavip@google.com>
Subject: [PATCH 14/25] hw/arm: add RT595-EVK board
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b49;
 envelope-from=3qSjrZgUKCuQZGbOVMUUMRK.IUSWKSa-JKbKRTUTMTa.UXM@flex--tavip.bounces.google.com;
 helo=mail-yb1-xb49.google.com
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
 hw/arm/rt595-evk.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/arm/Kconfig     |  5 ++++
 hw/arm/meson.build |  1 +
 3 files changed, 70 insertions(+)
 create mode 100644 hw/arm/rt595-evk.c

diff --git a/hw/arm/rt595-evk.c b/hw/arm/rt595-evk.c
new file mode 100644
index 0000000000..e5daecc8b8
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
+#include "hw/arm/boot.h"
+#include "qapi/error.h"
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
+    mc->ignore_memory_transaction_failures = true;
+}
+
+DEFINE_MACHINE("rt595-evk", rt595_evk_machine_init);
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index d1443e8f89..6720a41f65 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -719,3 +719,8 @@ config RT500
     select RT500_CLKCTL
     select FLEXSPI
     select RT500_RSTCTL
+
+config RT595_EVK
+    bool
+    default y
+    select RT500
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index d0be157092..f8c227c633 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -64,6 +64,7 @@ arm_ss.add(when: 'CONFIG_XEN', if_true: files(
   'xen-pvh.c',
 ))
 arm_ss.add(when: 'CONFIG_RT500', if_true: files('rt500.c'))
+arm_ss.add(when: 'CONFIG_RT595_EVK', if_true: files('rt595-evk.c'))
 
 system_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
 system_ss.add(when: 'CONFIG_CHEETAH', if_true: files('palm.c'))
-- 
2.46.0.662.g92d0881bb0-goog


