Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D9AE77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 10:08:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKafK-00053g-15; Mon, 09 Dec 2024 05:06:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tKafB-00053F-O9
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 05:06:50 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tKaf9-0005mk-QJ
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 05:06:49 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434a2033562so40160675e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 02:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733738805; x=1734343605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FrWQ8o1swak4z3KlgQSDMJgDByGxVPfHrsWQDtprItA=;
 b=XLPJQY20rk4+JMbJubYBZN/C1iilwKq8WJG1+6AES5mF0jtfKFv+Vg7WGGtlJdkHwn
 +oKMjTDZmBgcHwcugSbEcAoXAsjAmORUjsG3wf+wlA3YXxR3n740e0LXHnNgZXc/nWmD
 4U/JvxocDwB327Lo7QSLOFLf8lu7yHYw2syPWJXgA4WFZHf9xVO2le/JsZ+t1Rv/lFba
 ZiyPWgeq2chUUjZbVPj9fRL3qQY5v5/2olLelwNEUcrPW1fU20J/lnJi10QaQtE6YRr+
 tJWeyigweChBLJb3lMlNtw0jg6zz4ZVy50eHHRMdk9tnTZjw4LYNJ1j3bYCUf1dlU8WW
 vMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733738805; x=1734343605;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FrWQ8o1swak4z3KlgQSDMJgDByGxVPfHrsWQDtprItA=;
 b=oDpG4JGkXV1MRxNTJ/e8AAtqPIldvg/avYEKTB17h67RFPis+S4l/MrlFGSkfj0F44
 P9EEtiEIybCv+NAnAhH6DxhiEEiodiMvRMPaQX7+bkKozCfxs+trCn5TUWyyYxk0VMjt
 BzrsJHQIxmHDa9NsIXSCr+hrRLLwd2iCbjA6cz6lL1YKMNRkigo+XIYoUm4+fN95mGER
 H6y+MLdExAXf5mfxWldS4OGi/WbeIce8rdOQivNHHPDlrBjCXPPNVzlmY6j+JrwQwrQl
 O4toLiNk4o3UTU5W4EDopIkvZ2N9XlFn8I/5cYbD0yOXyBh7HZImlzKq+acUrk6aGPSG
 lPhg==
X-Gm-Message-State: AOJu0YwxCIsvrZkSIXaUzDIsB7RDIcnrfVOuPvLV7JDlMCyaPs1qG/bk
 boO8J9M1CJ0t4WfLsIyi+U3JKlRvzP61J7YpVYkkPneoq+9y0lTaRkrKAdWUhbs=
X-Gm-Gg: ASbGncvoOT2ddcki92+lfiGlTb561s1erYm3GJxyGt+vrAgU2aYAQl552D6/O9q54w1
 ikKQtvQFrXuRL3Im7VS0T3tWWbPj2j8w6dJOoxsXSNkDQXmkrlCeB1Oo076+83QHe+vjifBuvPO
 PtPY6RLBsIsikuv3n2tjaE44vhx77hfVPkXmiK4v0kj1VejFqgEAYk53iLC+q82B+SYfOJkmLIG
 wXdSnMTavZpvVxWnQQIKNWiJhEtsIix02BUOCFqcPLYtOhq
X-Google-Smtp-Source: AGHT+IEqFepUeptdGzHcf31LhbxyrhSw4ehMZowX+WZp5Wbc0kPK6HchoAM9KjskX4Kp44dq8yGDiw==
X-Received: by 2002:a05:600c:218b:b0:434:e8cf:6390 with SMTP id
 5b1f17b1804b1-434e8cf6549mr54432145e9.6.1733738805515; 
 Mon, 09 Dec 2024 02:06:45 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f32b8a65sm55602945e9.6.2024.12.09.02.06.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 02:06:44 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DFD945F858;
 Mon,  9 Dec 2024 10:06:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [RFC PATCH] hw/net/can: clean-up unnecessary includes
Date: Mon,  9 Dec 2024 10:06:35 +0000
Message-Id: <20241209100635.93243-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

The event_notifier, thread and socket includes look like copy and
paste of standard headers. None of the canbus devices use chardev
although some relied on chardev to bring in bitops and byte swapping
headers. In this case include them directly.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/net/can/can_kvaser_pci.c   | 4 ----
 hw/net/can/can_mioe3680_pci.c | 4 ----
 hw/net/can/can_pcm3680_pci.c  | 4 ----
 hw/net/can/can_sja1000.c      | 2 +-
 hw/net/can/ctucan_core.c      | 3 ++-
 hw/net/can/ctucan_pci.c       | 4 ----
 6 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/hw/net/can/can_kvaser_pci.c b/hw/net/can/can_kvaser_pci.c
index 38434d3a04..9e363d532f 100644
--- a/hw/net/can/can_kvaser_pci.c
+++ b/hw/net/can/can_kvaser_pci.c
@@ -30,12 +30,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/event_notifier.h"
 #include "qemu/module.h"
-#include "qemu/thread.h"
-#include "qemu/sockets.h"
 #include "qapi/error.h"
-#include "chardev/char.h"
 #include "hw/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/net/can/can_mioe3680_pci.c b/hw/net/can/can_mioe3680_pci.c
index 21659b7afb..580f099e00 100644
--- a/hw/net/can/can_mioe3680_pci.c
+++ b/hw/net/can/can_mioe3680_pci.c
@@ -26,12 +26,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/event_notifier.h"
 #include "qemu/module.h"
-#include "qemu/thread.h"
-#include "qemu/sockets.h"
 #include "qapi/error.h"
-#include "chardev/char.h"
 #include "hw/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/net/can/can_pcm3680_pci.c b/hw/net/can/can_pcm3680_pci.c
index af21dc6855..3195b79954 100644
--- a/hw/net/can/can_pcm3680_pci.c
+++ b/hw/net/can/can_pcm3680_pci.c
@@ -26,12 +26,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/event_notifier.h"
 #include "qemu/module.h"
-#include "qemu/thread.h"
-#include "qemu/sockets.h"
 #include "qapi/error.h"
-#include "chardev/char.h"
 #include "hw/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/net/can/can_sja1000.c b/hw/net/can/can_sja1000.c
index 6694d7bfd8..5b6ba9df6c 100644
--- a/hw/net/can/can_sja1000.c
+++ b/hw/net/can/can_sja1000.c
@@ -27,7 +27,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "chardev/char.h"
+#include "qemu/bitops.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "net/can_emu.h"
diff --git a/hw/net/can/ctucan_core.c b/hw/net/can/ctucan_core.c
index 812b83e93e..4402d4cb1f 100644
--- a/hw/net/can/ctucan_core.c
+++ b/hw/net/can/ctucan_core.c
@@ -28,7 +28,8 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "chardev/char.h"
+#include "qemu/bswap.h"
+#include "qemu/bitops.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "net/can_emu.h"
diff --git a/hw/net/can/ctucan_pci.c b/hw/net/can/ctucan_pci.c
index 65f1f82303..a8c77b9194 100644
--- a/hw/net/can/ctucan_pci.c
+++ b/hw/net/can/ctucan_pci.c
@@ -27,12 +27,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/event_notifier.h"
 #include "qemu/module.h"
-#include "qemu/thread.h"
-#include "qemu/sockets.h"
 #include "qapi/error.h"
-#include "chardev/char.h"
 #include "hw/irq.h"
 #include "hw/pci/pci_device.h"
 #include "hw/qdev-properties.h"
-- 
2.39.5


