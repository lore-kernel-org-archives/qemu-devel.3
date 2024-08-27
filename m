Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2BEC5320E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 06:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sipyP-0004py-Gf; Tue, 27 Aug 2024 02:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3I3bNZgUKCoIzg1ovmuumrk.iuswks0-jk1krtutmt0.uxm@flex--tavip.bounces.google.com>)
 id 1sipy7-000414-9L
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:46:31 -0400
Received: from mail-pl1-x64a.google.com ([2607:f8b0:4864:20::64a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3I3bNZgUKCoIzg1ovmuumrk.iuswks0-jk1krtutmt0.uxm@flex--tavip.bounces.google.com>)
 id 1sipxn-00068l-Eb
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 02:46:14 -0400
Received: by mail-pl1-x64a.google.com with SMTP id
 d9443c01a7336-201e7b422ffso42193475ad.2
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 23:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1724741156; x=1725345956; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=efCj4SZYZQjVy7GZDlQqFsRl+pAlPbvM0jF/f1JaCII=;
 b=KnszVv0BTLPjpzQVzP2BktZxXQRMmw41CxLjyPNhp7nVI6+9MkpVXhNfteTlnPNO9s
 WEEhFTDYS2A3Ec1ALI8MNQt7QkE1kCs6BXCXeaMvsxLxp5OxmHrHXybHzL++C1l+i6Rh
 qeMSXheWtgVj9adeWmrG5WI9CCiTR4MJyYgoTNPwYmVn3/T42lurJOJv0XsJRvTYKU93
 vt7TCepw/LohvG3ddmm4IAv64bMxEimhrlmfKmlkZ9bknH+SJ0xDmm60lJh7Bs+ens3K
 lyKevADNaSDvjbHRqEB1PSkk1xbaBlOYevT3Ys5gj+rJmNYAQF6jkfSZ0BH08TPtuJTM
 aWAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724741156; x=1725345956;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=efCj4SZYZQjVy7GZDlQqFsRl+pAlPbvM0jF/f1JaCII=;
 b=Pb/CnmrEnBSCGEjLVOdKOLgo4/LX5bU3KON9H7AATXez/McckkptH4aCOZeGgKpsuV
 vuHPNXSBNX4IZUvCwtjpCC4jEvx+vf6L6aQNO8kHEZRIDAThRDB4yeJF66+RXVu/QU3v
 xa52rbzjP2jXhblw2cTpCkxbhlWiannXMcFDIdUdaWwF8jWdaPGdDUTSi3CfljXxez/w
 fex2HpL/fsCSxWJoI5LrkWbAAGP1/XwKmL6HOEb7dEfqbCEF54k7F8Km4wfm8fjZP5Y2
 hrf1htpmIVwOnyp6N6fmJi7ehDqQWNMWpKLnzzVjMrwWFoft7M7rK/9xPG2hW/Vtg/Vj
 LIag==
X-Gm-Message-State: AOJu0YyTrKB6daWoKxRSXHMILP1pBkVGyRAqRSDtq243xcBurqc6uk8K
 6GT7hXxsCNRs1Tt227+K86111Q7CVXITXUbkm+Ye6i6fny+K1keHNkH/lrd0UjYR8iapIWbvSQe
 J0IMbhqzxse9T1qjTf7TQfDLMjRs52iAW6m0QbZJ3Wz9G5rAzB2KJDmAXnd4mSTTc16iKgzjH31
 0US6WkC8/ppRzqbD0Y3PGeDXN2Hw==
X-Google-Smtp-Source: AGHT+IFghvOfCg97TPD1583ilJmlcPwlDM/JXHGtC+PC8CXxWaevbWPD64g0B4nY9juG2DCtPbuhHU24HQ==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a17:902:d50d:b0:203:616a:8673
 with SMTP id
 d9443c01a7336-2039e4d5cdfmr12236635ad.5.1724741155346; Mon, 26 Aug 2024
 23:45:55 -0700 (PDT)
Date: Mon, 26 Aug 2024 23:45:17 -0700
In-Reply-To: <20240827064529.1246786-1-tavip@google.com>
Mime-Version: 1.0
References: <20240827064529.1246786-1-tavip@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827064529.1246786-14-tavip@google.com>
Subject: [RFC PATCH v3 13/24] hw/arm: add RT595-EVK board
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::64a;
 envelope-from=3I3bNZgUKCoIzg1ovmuumrk.iuswks0-jk1krtutmt0.uxm@flex--tavip.bounces.google.com;
 helo=mail-pl1-x64a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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
2.46.0.295.g3b9ea8a38a-goog


