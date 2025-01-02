Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6323EE77198
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 21:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTSaG-00043c-Rr; Thu, 02 Jan 2025 16:18:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTSa4-00040f-Sw
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 16:18:17 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTSa1-0001Lb-0o
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 16:18:10 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-436326dcb1cso77460205e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 13:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735852687; x=1736457487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XroMYY0R/MiabM3vxlKI8plZjULUSdM7o1GYxaZu1lI=;
 b=yQQSuWpc9y/Cr2HdsP4qqCH2wd8qRMVC0Wle2L2kZL3rJoo+x9zzUhmDRcUCtW1s96
 kZM70kKZ4cqbHAaR+qGxkmwXMcKGHeBGAs3NSh3vHk4UEER9N77hg0BHqYyRumI5Enb9
 Dgq4igHsh/QJEok9mJNXyCQ6A2g/duEJkhxEvRn8gshuSgz3XL6Pfoi5Nu/q4KrqJJct
 uNw7dBQqY6NuqBbwmTmfasklfCGrjgKnHLF74tatLeCFfM9/Etg1IMiwc4m3RKYO2Sdb
 bpIrfCR8OypB5i35Z1YugiIKjyG6+qEESoaAQYD9MIMp4Tnlxe2DbDS0qVL3d1QW31fh
 CeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735852687; x=1736457487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XroMYY0R/MiabM3vxlKI8plZjULUSdM7o1GYxaZu1lI=;
 b=xOCWU4eKai/j3bEfL4JIymGf1cBWcMZizNHqpdHxWDSKKR9OdvERBVKSlrooigFkKM
 HnIbyP041Lx+dxZHNsIyqArDmxWfqr7U+5BbfRDcrZ7TanU5jzmuHkUChflHvTHwh8Rr
 ZdTc3ancaK7/7do7H5Ohfv+ffv4ARs23Gv9PSPcHJ7bLzORkZcZzUrgMZkXi/jy1/r9d
 WPdWEBDU2wuiFME29vk0UuQcmOLkxVyROZ0Wg/HBEpzZpYvVJJeIfb0ctbyeDKsbIdNy
 0HyWo5jsnzSI3KYMqehcBE9HUk4PzPYTRjFTovviTYQgY+bbyCZ03FPUD0/4h1Uy9FDP
 mEgg==
X-Gm-Message-State: AOJu0YwQ+a9PWIrfhzoiDgF5Q3uPpylPlxW0fPkt4NXS4W1k7GRuqXrm
 GCXRTZROObSWDPXet53Gsajzi3+w0PypIVYaSGj41N12e0mYLQrqJx26Qk2WqW85oNc1tRSDaEu
 2hPOQkw==
X-Gm-Gg: ASbGncuEfALacavKzxE6d62mNeJ4INNUsyJcQ+o0qfnN/3RAr1Qsx175erucvhWlYpN
 SW3VYQEGUdYO1+vDOugSbDOLXKq7GAw2DMuQQSiLZSYOeOe2P959W7Y/wgowVy4AGppiHdSeoWE
 vnpAkJ9C2+bc4+B6R8JI+CNMwFG9g1cYMjY5DctLkHPyZZVM4zkDKXkhIWwjbc29LSfvqF7x0qa
 B1Lru2+vLmdp36I+yDJhxYY7mCiHVR/iRUoZEuGIKYFqBVSsrBbYagEeXKPXqHgSmP6XVmgz0h1
 IOihg3D4RbFItyRSuz5hJjC8B9V6x5o=
X-Google-Smtp-Source: AGHT+IGifLsGTL7JCw1PUDyVQv1IqEOxdteLjKkX3xXmP8MqBs4a82XvG4UnVb/ArsvfHA1W6tKtJQ==
X-Received: by 2002:a05:6000:471a:b0:38a:69a9:afb1 with SMTP id
 ffacd0b85a97d-38a69a9b17amr136101f8f.0.1735852687121; 
 Thu, 02 Jan 2025 13:18:07 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8acabbsm38724383f8f.93.2025.01.02.13.18.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 13:18:06 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v4 1/8] qdev: Implement qdev_create_fake_machine() for user
 emulation
Date: Thu,  2 Jan 2025 22:17:53 +0100
Message-ID: <20250102211800.79235-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102211800.79235-1-philmd@linaro.org>
References: <20250102211800.79235-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

When a QDev instance is realized, qdev_get_machine() ends up called.
In the next commit, qdev_get_machine() will require a "machine"
container to be always present. To satisfy this QOM containers design,
Implement qdev_create_fake_machine() which creates a fake "machine"
container for user emulation.

On system emulation, qemu_create_machine() is called from qemu_init().
For user emulation, since the TCG accelerator always calls
tcg_init_machine(), we use it to hook our fake machine creation.

Suggested-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/qdev-core.h | 10 ++++++++++
 accel/tcg/tcg-all.c    |  8 +++++++-
 hw/core/qdev-user.c    | 21 +++++++++++++++++++++
 hw/core/meson.build    |  1 +
 4 files changed, 39 insertions(+), 1 deletion(-)
 create mode 100644 hw/core/qdev-user.c

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index e6ef80b7fd0..b83b1439968 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -1027,6 +1027,16 @@ const char *qdev_fw_name(DeviceState *dev);
 void qdev_assert_realized_properly(void);
 Object *qdev_get_machine(void);
 
+/**
+ * qdev_create_fake_machine(): Create a fake machine container.
+ *
+ * .. note::
+ *    This function is a kludge for user emulation (USER_ONLY)
+ *    because when thread (TYPE_CPU) are realized, qdev_realize()
+ *    access a machine container.
+ */
+Object *qdev_create_fake_machine(void);
+
 /**
  * qdev_get_human_name() - Return a human-readable name for a device
  * @dev: The device. Must be a valid and non-NULL pointer.
diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index c2565758876..95adaacee82 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -35,7 +35,9 @@
 #include "qemu/atomic.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qemu/units.h"
-#if !defined(CONFIG_USER_ONLY)
+#if defined(CONFIG_USER_ONLY)
+#include "hw/qdev-core.h"
+#else
 #include "hw/boards.h"
 #endif
 #include "internal-common.h"
@@ -124,6 +126,10 @@ static int tcg_init_machine(MachineState *ms)
     tcg_prologue_init();
 #endif
 
+#ifdef CONFIG_USER_ONLY
+    qdev_create_fake_machine();
+#endif
+
     return 0;
 }
 
diff --git a/hw/core/qdev-user.c b/hw/core/qdev-user.c
new file mode 100644
index 00000000000..f816340db5a
--- /dev/null
+++ b/hw/core/qdev-user.c
@@ -0,0 +1,21 @@
+/*
+ * QDev helpers specific to user emulation.
+ *
+ * Copyright 2025 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "qemu/osdep.h"
+#include "qom/object.h"
+#include "hw/qdev-core.h"
+
+Object *qdev_create_fake_machine(void)
+{
+    Object *fake_machine_obj;
+
+    fake_machine_obj = object_property_add_new_container(object_get_root(),
+                                                         "machine");
+    object_property_add_new_container(fake_machine_obj, "unattached");
+
+    return fake_machine_obj;
+}
diff --git a/hw/core/meson.build b/hw/core/meson.build
index ce9dfa3f4bf..65a1698ed1f 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -46,3 +46,4 @@ system_ss.add(files(
   'vm-change-state-handler.c',
   'clock-vmstate.c',
 ))
+user_ss.add(files('qdev-user.c'))
-- 
2.47.1


