Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D66C52D7D
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2024 10:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sfGeT-0000Vn-So; Sat, 17 Aug 2024 06:27:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <363rAZgUKCiAP6RELCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--tavip.bounces.google.com>)
 id 1sfGeF-0007iS-FM
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:27:03 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <363rAZgUKCiAP6RELCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--tavip.bounces.google.com>)
 id 1sfGeA-0003Nl-K8
 for qemu-devel@nongnu.org; Sat, 17 Aug 2024 06:27:02 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-71274faa89aso1819569b3a.2
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2024 03:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1723890413; x=1724495213; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=KtjXebZCukHMKlUFxpvcXxmLOzDPD6D4WbOdIn8vIcU=;
 b=L9Q09kf/bBhLkPCOk2HHXyiKH1etFP+PCKJ3SsW4AVsjOWztwiIfOw3jkrvpazxA8P
 oO7Z+N9OvZbtODgTgGYQIF9wDQ7Vb89D0eoBcklE2XLybSm07J2ACsUwk585YMQOtA1f
 bOCByKWV13Yqz2MZTycQRGkq6z29bknBrTqy/JlVrweq4lFCaGJWGfTpJmIyecxvdbe7
 IdN+5VboQijLHV++L23vWVKxMHYUO7ju2P6SjhwOAKPk4m1crg+pWkPqsvr68uEhnN58
 CVghk+54G0tTx+6us7l/2jVx2GB/ysxz8dBwt4c4+pRAy1/HVObxXziW/5OSKYqnxgy/
 1Rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723890413; x=1724495213;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KtjXebZCukHMKlUFxpvcXxmLOzDPD6D4WbOdIn8vIcU=;
 b=Relo7J6ERCRr8yTBARq2OrxguDnIOznM/QGQdRj+rrD4i0sx2JAH8CPq239JaKpDco
 xVwfrt8clU5T7yIkkb4jUBsO0wOnY3L//56EcNd0cUxo80H1Jn/gkz2J+qdEcmJsOve/
 fvL+oPUZzItogr1P/Z42itzV6gx6GYMIQf6jn07aP8EifJ6NysB0MkbluLBosfiJP7Dn
 jjbB337aq8rmah+u496/FPrZhThMM/TwylDGw1+p6JgxIW/NRSu0HJ34R/0dYluobJWS
 L6zTvhywOWLzQsWGL5lU0C9FizGR9YgQ8O6p7AWMgkIGMinTjKjCTGHoOlKUkvKnt9O9
 j2Dw==
X-Gm-Message-State: AOJu0YwGknN2bIID61afHuo+pJmwjypFsaSNn8fqfCpQAn2CMJeKG10j
 +lExVoqcpKP1m28ZJxWIMewgGOzh6LZuOnItRbl9M7vsHzeLHZwEGbZzfz91BHAXCSoQhD4G4br
 0qx6J5+R0JywnkgKIboqmDPoNQRFxsvZmjUWHGWOireRG4qo0o02ygpKpIHXVzhEjSzaLTIE+zk
 pu0vqexX6Hs+fedSZ+w8QN6W3d8A==
X-Google-Smtp-Source: AGHT+IH0koPNi1lAcwUEmx89CyzCXwfvDKyxdw3T5eFWGO3oU0/xB/NyX6HasPZTGOEo1ZLX83jRG7ReaA==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:aa7:8145:0:b0:710:4d4d:5ef1 with
 SMTP id
 d2e1a72fcca58-713c525b48bmr22432b3a.4.1723890411263; Sat, 17 Aug 2024
 03:26:51 -0700 (PDT)
Date: Sat, 17 Aug 2024 03:26:06 -0700
In-Reply-To: <20240817102606.3996242-1-tavip@google.com>
Mime-Version: 1.0
References: <20240817102606.3996242-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.184.g6999bdac58-goog
Message-ID: <20240817102606.3996242-24-tavip@google.com>
Subject: [RFC PATCH v2 23/23] hw/arm: add RT595-EVK board
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 thuth@redhat.com, peter.maydell@linaro.org, marcandre.lureau@redhat.com, 
 alistair@alistair23.me, berrange@redhat.com, philmd@linaro.org, 
 jsnow@redhat.com, crosa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=363rAZgUKCiAP6RELCKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--tavip.bounces.google.com;
 helo=mail-pf1-x449.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
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
-- 
2.46.0.184.g6999bdac58-goog


