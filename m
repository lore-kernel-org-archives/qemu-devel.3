Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4AECE8D40
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 15:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJviH-0003bS-IY; Fri, 14 Nov 2025 10:27:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJvc3-0006Mj-5W
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:21:23 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vJvc1-0003uu-EW
 for qemu-devel@nongnu.org; Fri, 14 Nov 2025 10:21:22 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47778b23f64so15955405e9.0
 for <qemu-devel@nongnu.org>; Fri, 14 Nov 2025 07:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763133680; x=1763738480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vZLyAjLvqFouYpPenT0wnqjYD3XlJJ/usbuJ8Xut+bw=;
 b=uafmdpAUu50xTMya6OxHp9myDw+zMWXK47xa+skuqsqjNZ14QKZp4uALK7xXWk+XyG
 6Gh/iyiE33dyiDDhLvMFeNOAvKNDc55knqmAeL29E0X0rt+yg7U0MzZXlfHYPsDZdujm
 rBSQoOLTA60LFTT0V3JFp91PXH/Y/cb6YMpN/1f4EgrIooCppJhw8y9m/UkKkJGV3G+T
 GiB/MmxQwaMjcRYwGBPafgYv+qc7gDSycji6hR1p3gkS7aio/22lDRslyuGLr2tujyJP
 u9EWC//qjR+Q4Q9LqyBlSYOzgY7Ru5emGf/5jXtbU113uIy2ZjkMaWNrf2xwcEbnMJlz
 TYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763133680; x=1763738480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vZLyAjLvqFouYpPenT0wnqjYD3XlJJ/usbuJ8Xut+bw=;
 b=uRoSe88wwPlQxWA26jH/cj1q6amBR6AGa1ZFEqx7D5OdA3DR0mY+MirM/DLnSm+pnl
 EnuAieOrsBaDqzoVgMH1oxpGE8p/07yr3uVF58PJzqofzXayYBuam6eZN+FvSvqP35O1
 yIyaA/2b7Hw4iQcDRpJ9Ht3JY9OyfveU6A6l2B2aq5ZhKIbcZgZJCoWJdi3CykHUtQSF
 Rx3zzFzpvogGkF/pde1HEeae5ONJ0v271CDe/quktri6g6htoDKnUTEYrdFztarcOLiw
 bceZM/2W63vEh6xwfOa/yLunI+oGYUH3AI4KxV4UiWnxss9NeYOjycWKsMg2UmVafmot
 8oqQ==
X-Gm-Message-State: AOJu0YwSQHsdQ8mPuUu4tWPD8VkQB1QbUjhSt9e2y2Z/TwSZud0oJobW
 60Yb9JWdcCJ7BG2dYutk9HOgMdbxKpKImnnM2CFcOm0ZT5JE5t8UGNoNu5lVhyF3fxeAmO5ap82
 gxwgF
X-Gm-Gg: ASbGncvJVtr72zTvlTjbfWZPcfD6zSHnaviCJuvfTBclTdV9KrpSIqmiK9rohyWHWHm
 sooSM1fZS/0INMpIaBuQ7lhihUXO5U4q7h/Ob+SxhVlAUQP0YpCGizoi9eLn7UH6aq4eicIXkOq
 EI8euLGJuzafkvx10zTFDorMQ7mCcpf9Y2uCvoHd61q+5vCRMEx6WEVT0dFJ8XhZ/Bv9BY9HdaT
 rMxtbtoX/2c5eVophZVO9MJAxJJPu15wFzZk8mVTWpjbUtLpphTbh1NdeZ2jRFmgV0ngcbOzBO2
 jagz/yA5t1Ye00a8NmaxQjUm1LhTsLcgBBEIDnQdqrXqukN655GlG28Mb+VMIftUV+ZUHAxvhUz
 GU94Bn3eS5+XY9G1NKHEK3an8w9dISW6SOb7JuxUPNcEVdBESh2yaMZLkDkD0h+LOPFE2DdSBj6
 Th8ODiScIi/EJCWhRQ
X-Google-Smtp-Source: AGHT+IGV3xAX5+4RDhWpMrEhOZvH6KYOTpZAWQ+eCIneXAGdmaYE+GJvKuJCh/E89xDeQRZ48Q8fog==
X-Received: by 2002:a05:600c:350d:b0:471:7a:791a with SMTP id
 5b1f17b1804b1-4778fe50bf0mr31175465e9.7.1763133679739; 
 Fri, 14 Nov 2025 07:21:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e8e798sm146772835e9.10.2025.11.14.07.21.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 07:21:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/10] vfio: Clean up includes
Date: Fri, 14 Nov 2025 15:21:07 +0000
Message-ID: <20251114152110.2547285-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251114152110.2547285-1-peter.maydell@linaro.org>
References: <20251114152110.2547285-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

This commit was created with scripts/clean-includes:
 ./scripts/clean-includes --git vfio hw/vfio hw/vfio-user

All .c should include qemu/osdep.h first.  The script performs three
related cleanups:

* Ensure .c files include qemu/osdep.h first.
* Including it in a .h is redundant, since the .c  already includes
  it.  Drop such inclusions.
* Likewise, including headers qemu/osdep.h includes is redundant.
  Drop these, too.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20251104160943.751997-9-peter.maydell@linaro.org
---
 hw/vfio-user/container.h | 1 -
 hw/vfio-user/device.h    | 1 -
 hw/vfio/pci-quirks.h     | 1 -
 hw/vfio-user/container.c | 2 +-
 hw/vfio-user/pci.c       | 2 +-
 hw/vfio/ap.c             | 1 -
 hw/vfio/container.c      | 2 +-
 hw/vfio/cpr-legacy.c     | 2 +-
 8 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/vfio-user/container.h b/hw/vfio-user/container.h
index a2b42e3169d..c952e090631 100644
--- a/hw/vfio-user/container.h
+++ b/hw/vfio-user/container.h
@@ -7,7 +7,6 @@
 #ifndef HW_VFIO_USER_CONTAINER_H
 #define HW_VFIO_USER_CONTAINER_H
 
-#include "qemu/osdep.h"
 
 #include "hw/vfio/vfio-container.h"
 #include "hw/vfio-user/proxy.h"
diff --git a/hw/vfio-user/device.h b/hw/vfio-user/device.h
index d183a3950e2..49c05848f1a 100644
--- a/hw/vfio-user/device.h
+++ b/hw/vfio-user/device.h
@@ -9,7 +9,6 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#include "qemu/osdep.h"
 #include "linux/vfio.h"
 
 #include "hw/vfio-user/proxy.h"
diff --git a/hw/vfio/pci-quirks.h b/hw/vfio/pci-quirks.h
index d1532e379b1..a6282e063a1 100644
--- a/hw/vfio/pci-quirks.h
+++ b/hw/vfio/pci-quirks.h
@@ -12,7 +12,6 @@
 #ifndef HW_VFIO_VFIO_PCI_QUIRKS_H
 #define HW_VFIO_VFIO_PCI_QUIRKS_H
 
-#include "qemu/osdep.h"
 #include "exec/memop.h"
 
 /*
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index e45192fef65..dab7a23224c 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -6,9 +6,9 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
+#include "qemu/osdep.h"
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
-#include "qemu/osdep.h"
 
 #include "hw/vfio-user/container.h"
 #include "hw/vfio-user/device.h"
diff --git a/hw/vfio-user/pci.c b/hw/vfio-user/pci.c
index b53ed3b456f..353d07e7819 100644
--- a/hw/vfio-user/pci.c
+++ b/hw/vfio-user/pci.c
@@ -6,8 +6,8 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#include <sys/ioctl.h>
 #include "qemu/osdep.h"
+#include <sys/ioctl.h>
 #include "qapi-visit-sockets.h"
 #include "qemu/error-report.h"
 
diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
index 7719f245797..3368ac89150 100644
--- a/hw/vfio/ap.c
+++ b/hw/vfio/ap.c
@@ -10,7 +10,6 @@
  * directory.
  */
 
-#include <stdbool.h>
 #include "qemu/osdep.h"
 #include CONFIG_DEVICES /* CONFIG_IOMMUFD */
 #include <linux/vfio.h>
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 9ddec300e35..013a691bc5a 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -10,10 +10,10 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
+#include "qemu/osdep.h"
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
 
-#include "qemu/osdep.h"
 #include "system/tcg.h"
 #include "system/ram_addr.h"
 #include "qapi/error.h"
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 86c943158e2..7c03ddb9610 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -4,9 +4,9 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
+#include "qemu/osdep.h"
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
-#include "qemu/osdep.h"
 #include "hw/vfio/vfio-container-legacy.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/vfio-listener.h"
-- 
2.43.0


