Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F09FF8862
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 08:10:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHH1X-00019Z-BM; Mon, 27 Apr 2026 04:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH1F-0000pC-Ei
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:08:42 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHH1C-0001dh-7j
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 04:08:39 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-441209fb77eso4253526f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 01:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777277317; x=1777882117; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dBz5nfiIUSdPkWdXYRedfkJmFQeJEAnz3d+04j8ybgc=;
 b=NfpmGvst4vdHG45MmsmpCiWdJLXfXxdDtrPWVq90gMWXfqkt7hakltDs21aRjH7nL+
 PTk0Bo5OtJjy+BTpZ6DPHSmWZ9khkJFfhFVMgclSXOvtKp6+wor3xbGoVUS19trumlVU
 fL/0p6etZa5oOEwN57fmWD6yaV0nudarDSqr4eAxQ518Gda3QxlUTCbVpaBfQLUZLEuW
 pxpn71QXLnz4qfYFm6+PsJh1JCtULwWXDhcaEKg3ettFMk8F7tn0F27Pcd75lwZBtjsc
 DvenwiuIm3C5WBKcFLJ2guPdeZjh7rrojb6zxFX/4mFhLiqAe/HP8gvj2sqjTP/E0ZDg
 YrZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777277317; x=1777882117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dBz5nfiIUSdPkWdXYRedfkJmFQeJEAnz3d+04j8ybgc=;
 b=M4nD1RfeQ6HAi3/fNTM+0Xe9nrVCmgl/SLqNd/oV0Pi/fmUUYqnjmVqY8v5ofNMyh4
 vTwee+ph3rl0H+TcwPUGG+Ljfx9dkAebUHhqLGjWaQJuCH9jiEwE/MSDNQUMx00P56MJ
 IL3my/rSzkjhiDfK3SrM8b9+aYb/dT061vCt4SrnpTQUMJXhczECwOJ4EtxsTal1v0Dq
 nAvNw22sWEjgVgx/B/tPS11DI95v4E1xK/TaqwCosqjDQOFBXKObPeBZlJ0x75dODkg/
 2m94aB1yJq3JLdMTWj5MsH4BuJ7M/pMDtutv7UYEfVhdUVO1jaxni5tWmv8KdY9L+5MU
 08GQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+OMfDw7M23xeXCAgPdi7HWpiASi0+hQ7y2CGOAn7pI9Bs5UwgFBt+cLr/hUPBESxm3pOA3Bpb1bBfy@nongnu.org
X-Gm-Message-State: AOJu0Yz4AFo4QTGI/fIOAcunG09HzolZ2rLtKNjrit4Ef5PBqpHlbeCl
 enxsH/+0o3D4IlFeaVv+/wTjVIiRGnmPmy1aat12FCejLU7ol9YqbxSQfjSexykoz1HLOM8S23d
 rtYzpoEU=
X-Gm-Gg: AeBDieuHIU6fRxshATt5dxIo66zbstJFOuHxfWHzvZVCqNCOHu3KMta9wq0nmG6kvrl
 pf8XJizqJwvCbfy3bhFrRAxNXqnqJBfK5qKHZebMBgUhs7VIBuaKxJPyIiBQ/RCmxW5fIrFufwm
 VUzvtYTgdg09vyuxEk4soLiZmBWM/tUq16yL3OYu5QYz71kRDuAmRFZN/gBpaY2/TlRp50cMbRj
 j+3YsYA+D0yuT+GUJ6slNQ3tgxMg4UuhPhaouEGMAtx15waUrwIgIQkeYJ+9HALGs0x4hx0xmmV
 S9En1yoOic4+nOipIbl0k2+cJ/IPnHH4IjACEu3jSfUyLOe0zGwxT4TxLzcPjkoOdyOXRI8j2mX
 l/Ff/kwslbxbnmlhWAZpxbQ7sUDqlRq+SyXNvmkug1vwQb9tzoNq311I7ZjoWc1bls3UQgyfxFH
 RKBmNt7PqybCRonzuSwZojuJ4/bT9JFs1Cj1GWAvIXTWWiK1uFsshPFKkGf+GdLUw+lKzOCl0Tb
 Rj3X1i6kvY=
X-Received: by 2002:a05:6000:41e5:b0:43f:dd8e:869a with SMTP id
 ffacd0b85a97d-43fe4032b3cmr56617295f8f.3.1777277316410; 
 Mon, 27 Apr 2026 01:08:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb1365sm83719523f8f.7.2026.04.27.01.08.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 27 Apr 2026 01:08:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 08/32] monitor: Make 'info via' a generic command
Date: Mon, 27 Apr 2026 10:07:14 +0200
Message-ID: <20260427080738.77138-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427080738.77138-1-philmd@linaro.org>
References: <20260427080738.77138-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In order to build hmp-commands-info.hx once we need to stop
using device target-specific check. Use the generic pattern
to make the command available on all targets, providing a
stub with kind error message when the device is not available.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 MAINTAINERS            |  2 +-
 hw/misc/mos6522-stub.c | 16 ++++++++++++++++
 hmp-commands-info.hx   |  2 --
 hw/misc/meson.build    |  1 +
 4 files changed, 18 insertions(+), 3 deletions(-)
 create mode 100644 hw/misc/mos6522-stub.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 02628ca20cb..8ed6648d094 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1554,7 +1554,7 @@ F: hw/ppc/mac_newworld.c
 F: hw/pci-host/uninorth.c
 F: hw/pci-bridge/dec.[hc]
 F: hw/misc/macio/
-F: hw/misc/mos6522.c
+F: hw/misc/mos6522*.c
 F: hw/nvram/mac_nvram.c
 F: hw/ppc/fw_cfg.c
 F: hw/input/adb*
diff --git a/hw/misc/mos6522-stub.c b/hw/misc/mos6522-stub.c
new file mode 100644
index 00000000000..85eb0ee36ee
--- /dev/null
+++ b/hw/misc/mos6522-stub.c
@@ -0,0 +1,16 @@
+/*
+ * QEMU MOS6522 VIA stubs
+ *
+ * Copyright (c) Linaro
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "monitor/monitor.h"
+#include "monitor/hmp.h"
+
+void hmp_info_via(Monitor *mon, const QDict *qdict)
+{
+    monitor_printf(mon, "MOS6522 VIA is not available in this QEMU\n");
+}
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 74c741f80e2..463038c302a 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -885,7 +885,6 @@ SRST
     Show intel SGX information.
 ERST
 
-#if defined(CONFIG_MOS6522)
     {
         .name         = "via",
         .args_type    = "",
@@ -893,7 +892,6 @@ ERST
         .help         = "show guest mos6522 VIA devices",
         .cmd          = hmp_info_via,
     },
-#endif
 
 SRST
   ``info via``
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 245ab9b98cc..d7e97a4a32f 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -20,6 +20,7 @@ system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m_ras.c'))
 
 # Mac devices
 system_ss.add(when: 'CONFIG_MOS6522', if_true: files('mos6522.c'))
+stub_ss.add(files('mos6522-stub.c'))
 system_ss.add(when: 'CONFIG_DJMEMC', if_true: files('djmemc.c'))
 system_ss.add(when: 'CONFIG_IOSB', if_true: files('iosb.c'))
 
-- 
2.53.0


