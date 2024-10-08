Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BACCED24D
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 01:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxytn-0003cR-4o; Mon, 07 Oct 2024 21:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3l4gEZwUKCvgyf0nulttlqj.htrvjrz-ij0jqstslsz.twl@flex--tavip.bounces.google.com>)
 id 1sxysr-00080y-J2
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:31 -0400
Received: from mail-pf1-x449.google.com ([2607:f8b0:4864:20::449])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3l4gEZwUKCvgyf0nulttlqj.htrvjrz-ij0jqstslsz.twl@flex--tavip.bounces.google.com>)
 id 1sxysp-0000BZ-Fj
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 21:19:28 -0400
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-71e026caf8bso2116850b3a.2
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 18:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1728350361; x=1728955161; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=PbhHf80sfK7VkwcTgOuxP6owcvc4suokU3ESxbdaOWI=;
 b=p3nmD6YyOLnCh8I7N+pee3b7RdHGVDUmDIRf502IYwADTz7FUyYvVoq/UJOrJj2xyU
 ySGGGpm6HhHDxYSFYuHHRiOvMRKPY7jzt+9DQ922dS34CmzZoomBKZ6YzaBKffw5fTMy
 AbXWdBGl3qYoQ90brls7UJeFtWvqyQ+IFY9qwa1vWTKOUMmnfDVnDpNF1QQWpaEfXjap
 /0QAdOJzi5jURBDy6lJqkFtoy+5R4x4X7ccEKBygeJ+QvTAwDJjw7Stm3WCo7/1Ve8es
 M9FFJccNxxswdxP9oCyzeci7eKPsV8PiPTgT5phcStkjIUeMveLVPB/yv6P1K73i2vWg
 IH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728350361; x=1728955161;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PbhHf80sfK7VkwcTgOuxP6owcvc4suokU3ESxbdaOWI=;
 b=n/k4SKkAUdCrKwgdhE2wucr2Ra8xTsEnnWTRXBoz545M8Tb7RsGCgOWe+1i5THf+en
 fhjaZwpQqMYhlIWHbWffkroyALKOzcKAGAJEdYLL8sVDm9bgjcTM17XYy0L2siqrhaIi
 6LolKas0F7BBTLLF+qInon1KMGWXcz09fgw2Ml5Xvhqrqe1RlzBg3rIPif56n5+7zB6X
 niIV2Zg+0WAl8u/8LLfNMKgiAOxrULCRanKvf/BJlcL5iY56PsX9A6VBuEUyYC552UaC
 8njdbo33MmCmGH4GJYLmcvF++QrmEeLesxqCa1myoc6xLI0NUcfUSlBrutrIfQwXSF89
 bdIA==
X-Gm-Message-State: AOJu0Yxj31/ADEgjt5dg9h+21ol/uMdykHkuy2W6IokIcBq7Wv/kOC76
 FTX7UVPRxcdiPVhU9nqrbzBJO8htn8+0TFQ+2EGKZcv6oy9cdwJEBmWkwNIHmOSzSpKEvnyS0MJ
 kU5zkVtTxjRH4ZWhJFldLM8ThZ5X/GYp26+stjy2XSRJ0DCtn2SnHA1wDuIm1qm9ymtiLJG1FxT
 QUrOSWiaJW/3AponEK4SOeufdnoA==
X-Google-Smtp-Source: AGHT+IGgWk8SsfLPaKZ6EeNQEn7lqPAjr3nNGIfVhoWq8dK9fBgwYbuZn6HlAwnrjRMlMn/Um+WXHuNkwA==
X-Received: from warp10.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:750])
 (user=tavip job=sendgmr) by 2002:a05:6a00:7687:b0:71d:fb06:e79b
 with SMTP id
 d2e1a72fcca58-71dfb06ea3amr14561b3a.0.1728350359669; Mon, 07 Oct 2024
 18:19:19 -0700 (PDT)
Date: Mon,  7 Oct 2024 18:18:40 -0700
In-Reply-To: <20241008011852.1439154-1-tavip@google.com>
Mime-Version: 1.0
References: <20241008011852.1439154-1-tavip@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241008011852.1439154-15-tavip@google.com>
Subject: [PATCH v2 14/25] hw/arm: add RT595-EVK board
From: Octavian Purdila <tavip@google.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, stefanst@google.com, pbonzini@redhat.com, 
 peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, 
 eduardo@habkost.net, luc@lmichel.fr, damien.hedde@dahe.fr, 
 alistair@alistair23.me, thuth@redhat.com, philmd@linaro.org, jsnow@redhat.com, 
 crosa@redhat.com, lvivier@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::449;
 envelope-from=3l4gEZwUKCvgyf0nulttlqj.htrvjrz-ij0jqstslsz.twl@flex--tavip.bounces.google.com;
 helo=mail-pf1-x449.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.024,
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
index 0000000000..4f875a0b12
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
+static void rt595_evk_reset(MachineState *ms, ResetType reason)
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
index 5bc9438945..86d704cf1b 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -636,3 +636,8 @@ config RT500
     select RT500_CLKCTL
     select FLEXSPI
     select RT500_RSTCTL
+
+config RT595_EVK
+    bool
+    default y
+    select RT500
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index a2b20617c9..48ae30acef 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -61,6 +61,7 @@ arm_ss.add(when: 'CONFIG_XEN', if_true: files(
   'xen-pvh.c',
 ))
 arm_ss.add(when: 'CONFIG_RT500', if_true: files('rt500.c'))
+arm_ss.add(when: 'CONFIG_RT595_EVK', if_true: files('rt595-evk.c'))
 
 system_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c'))
 system_ss.add(when: 'CONFIG_COLLIE', if_true: files('collie.c'))
-- 
2.47.0.rc0.187.ge670bccf7e-goog


