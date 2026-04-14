Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F5FF531DE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRg6-0001Mz-FC; Mon, 13 Apr 2026 20:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRfo-0001MP-8V
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:30:37 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wCRfm-0002rE-Kn
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:30:35 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43d73352cf2so1483052f8f.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776126632; x=1776731432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0CmPVb2/ogwjAlnnYuGyR2Fi1HqXfACxK/cgdkaWWa4=;
 b=SkryPy6bNnm+oWhLGHLBPokmG11EmJi7b3jORu1nweoFMEFABVMJjmsPz5mkarQmNn
 wlkyKmIv/06MdAsSCPqppZrptCMEct/Rd7GDOt5U4H3UaDdIqc11r8bOz9xO+v9u9382
 uCEzjr7B7QIjuQasJO5a4viuKTcky27CI6b+KJYBMfW11j9WAPatW9tawZ+DEWh/ZiHr
 9I/WOZMEsoprC4ViOgcWF3ewISkWLxwzB6rNjDmwYq1rXCZ145tU8B7AC9ZiluKQMRi0
 NgEPj4rr2kg4Q+HRp/DaZTYQjpzz1AWJLQ3UPOhyAD7NH9Ioo8bCRZnkq/WvTS1KHbjE
 Hx8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776126632; x=1776731432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0CmPVb2/ogwjAlnnYuGyR2Fi1HqXfACxK/cgdkaWWa4=;
 b=IVau2M3iGW2oKTkUtVysf2l23LYCNj3xOeGhUGJW3ZN4EEHwoHl+nFAE+Mcw9CM/gb
 SMs/pvULCkfTUeSGxkCyU6G/jmI77Rim33q6Wlme2epiKvBS3qScwIV3lt0hBZc7FpmP
 EMf3cEVkiStw3pmM8rLYoprldFEdnd2W+zAQYRB+uz3s+Vku48fQd8DDT8v6waXvq/QH
 eU3ndyxDmbJBCrcIeKUaGi/PiLM5KvY4mAFzyi/M8cB0r3XpG9xQL8W/Zvb3zGP0FAAg
 UaCyhkQ/5C0nPehyIdQyjhFkvGzJrzq1dCfEAu5YHPANPFYFePPZ1y12EdS4VK+KyD9A
 IHeQ==
X-Gm-Message-State: AOJu0Yxd09d7JkOv1o+9+UFv4o/5e8Jia15qos9Av1HXBkCDuS159Plk
 JjhqHXF+0n+gTzLOw/T0p7oFjhBW6FdzZ7DOW1zBofkAAbQ3dalYZzi1pmJZKC9/1F1KeNCtxnr
 ZX8AZ+Qs=
X-Gm-Gg: AeBDievt2ZZKRs4YraXeaqPRsIcD/PA0z0h7PGx2fDBMThohzLnRWceYLRxEM+PNscm
 uv+pxuKlXrbmi7/cN4222VZvTcElwUiZZmAdFLa/dnlpBKRYpgRo8sZFgb62h+7fM1ZA8VCjN4a
 gBBhSGxegKz4RGbjJkpW6oo3nrx4btmJouNYLSw+G0MYMi5mSOEME+J8KMrhdiIEbYiov4UKinT
 U8UY3dLeQh7Zj1krtWuy5doiJUWIkUaXe9GjcKJ4x/IKFrw+PacsxNL+JLUfF0bA9oIhycxOyxn
 nCpsfzUyTdulRoUDzfh5ACRsTT0JExMKHmNfkP64kWqTrexMwa87zkNLiD3c61tGsGacut3BBG9
 yrsMQfqwguHJbMqHSE6rAuvCV03rbXUJTKAsA366avg4vt7K2cJz7Px+wfvnRE/qRk2bvfYb7uz
 Y47Sf5a5ZbZxgFywz0mhS/hQ+fXhSNB7s5rOmxWN8QG3dYKC7fqYRCYVsda1+ORWfjnVztsMQ7
X-Received: by 2002:a05:6000:605:b0:43d:7b90:fa2a with SMTP id
 ffacd0b85a97d-43d7b90fe46mr6814908f8f.3.1776126632496; 
 Mon, 13 Apr 2026 17:30:32 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e4f16bsm35133528f8f.26.2026.04.13.17.30.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Apr 2026 17:30:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org
Subject: [PATCH v3 04/27] monitor: Make 'info via' a generic command
Date: Tue, 14 Apr 2026 02:29:36 +0200
Message-ID: <20260414003001.97571-5-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414003001.97571-1-philmd@linaro.org>
References: <20260414003001.97571-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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
index eb212c31ac2..cf462793a79 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1558,7 +1558,7 @@ F: hw/ppc/mac_newworld.c
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
index cd084a19363..fa6a961ac9a 100644
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


