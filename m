Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB9C5C79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 16:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3cS1-00015i-RB; Mon, 07 Sep 2026 12:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cRz-0000yH-MK
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:44:07 -0400
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.ml@gmail.com>)
 id 1x3cRy-00033R-4N
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 12:44:07 -0400
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cd6185db7so2436555e9.1
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 09:44:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788799444; x=1789404244;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+nb48/mqPn7+bPDRAaLkgFFQLPP5yyaURUgKFTQWIgU=;
 b=KyfrfKaFo2ma0pYLeSya/FSEtJLLJniPY+Sz+TakBVS+Q/7aVU76eFlYI59wvcnpS2
 3DabTIMoKK77V9xVf/9owh5XvpFd900Hc/TIji7lbwJGjPxbTrUZxOVX/9l3QpAokD4X
 245e+8rUjPAjctrLGlo+KPowcD9hxgUS0WYgSPXhUzWBhmtkR5+WdTMIhszUxmIjGpy/
 7lSEbDYHWECNq31CVJInVuI+BnmdH8y/QDVcFZe2OUhmEDuVcbOXy/FTjNA7oSe7Cti6
 ZZs43UufThHhwGik7mCJ0cDh5Jp1TO6YSciFa4f22JhL38eAIpurBLPSd30roK6jxfEm
 w37A==
X-Gm-Message-State: AFuF++mOppiL19brNQoesvAZjBwIgf6zxFciRiQrfokrqrnm+CodlySS
 X5y27Eufh1S1MRZyjfNaYJP5hGl4ZYevYQoVrlFz/l+eozyKYbzWfCL6ZYiI6mJy
X-Gm-Gg: AYBFou1k4pC7YOTvpfMYiLkUZ9vp8YsHmV55GGuj4r9gdf5jw8agZe7/vfx39ROXcrl
 qUyjaLZPzKQnQo48R0xqiGdyvEEWNC1JidVqWo7cMybShHU+Ch0En/2Klwz/tPhFbkBem/e+CJd
 2R0mhaeThnRm/lpCewC8SP3fn09HxhdNRboBWtbCUxnD6FXmJSg+d6UU43tXEs3u79wWKeZqkk7
 Z3tkIrdupYiA6AKgJ2nmpFwkdbIaFV8IVNInojwYyRMigmoWMvUC7XuWiFvci+1rN3c2ydI/ueq
 I9/GeLKNN4qNuQityAmNGysi6DhxT7Our/59Lz5KhLyiESzQ+uL/1sLI437dMD2ZM6W+OkQywub
 K8Ry61HoE8mkFkYE+GEyrrLZ4clrgyro7kRqQFupxtwz9Xeo0VkmU0oDnNq+NqJj7I4yNmZVKVe
 mCbuUFi4MGwMJViePgUatyt3NgprNiZoW70pRqq5+IHXCt06QGnBUT5XgoD5cS0BjQVGYGKC8LP
 2sY+5Tv0QCcZWdqlGipew5WZtep3syzraw=
X-Received: by 2002:a05:600c:b8d:b0:49c:e37e:4389 with SMTP id
 5b1f17b1804b1-49d1754e950mr23261705e9.4.1788799444266; 
 Mon, 07 Sep 2026 09:44:04 -0700 (PDT)
Received: from localhost (89-93-216-19.hfc.dyn.abo.bbox.fr. [89.93.216.19])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee6024a8sm423469295e9.6.2026.09.07.09.44.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 09:44:02 -0700 (PDT)
Date: Mon, 07 Sep 2026 18:41:58 +0200
Subject: [PATCH 08/50] hw/rtc: ds1338: move TYPE_DS1338 to a public header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bmc-minerva-v1-8-0d83ad610c3b@free.fr>
References: <20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr>
In-Reply-To: <20260907-bmc-minerva-v1-0-0d83ad610c3b@free.fr>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org, 
 Patrick Leis <venture@google.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788799319; l=1555;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=rDiuDaI9O+3b6OvM3HVMevuI7PTOL9dpbkK/b/AU00Y=;
 b=TJjwhDYORc6vDrt5LIRvQ49PiDCLxbk25KlMDreMqTb/SaS2ALuZeVzGwRczc7nwjNk6xjWFO
 Xs5RyVKQbsdCjmEo9KNgOnszVkOpUgnFQj3sNDNtvSUMi8Tgqx6NHgP
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=74.125.225.140; envelope-from=eblot.ml@gmail.com;
 helo=mail-wm2-f12.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Emmanuel Blot <emmanuel.blot@free.fr>
From:  Emmanuel Blot via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Move the TYPE_DS1338 type name definition from ds1338.c into a new
include/hw/rtc/ds1338.h header so that boards instantiating the device
no longer need to redefine the type name string locally.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/rtc/ds1338.c         |  2 +-
 include/hw/rtc/ds1338.h | 20 ++++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/rtc/ds1338.c b/hw/rtc/ds1338.c
index 5f1ee2e410a..f8b3340bf0f 100644
--- a/hw/rtc/ds1338.c
+++ b/hw/rtc/ds1338.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
+#include "hw/rtc/ds1338.h"
 #include "migration/vmstate.h"
 #include "qemu/bcd.h"
 #include "qom/object.h"
@@ -29,7 +30,6 @@
 #define HOURS_PM   0x20
 #define CTRL_OSF   0x20
 
-#define TYPE_DS1338 "ds1338"
 OBJECT_DECLARE_SIMPLE_TYPE(DS1338State, DS1338)
 
 struct DS1338State {
diff --git a/include/hw/rtc/ds1338.h b/include/hw/rtc/ds1338.h
new file mode 100644
index 00000000000..f4cfe6a8e76
--- /dev/null
+++ b/include/hw/rtc/ds1338.h
@@ -0,0 +1,20 @@
+/*
+ * MAXIM DS1338 I2C RTC+NVRAM
+ *
+ * Copyright (c) 2009 CodeSourcery.
+ * Written by Paul Brook
+ *
+ * This code is licensed under the GNU GPL v2.
+ *
+ * Contributions after 2012-01-13 are licensed under the terms of the
+ * GNU GPL, version 2 or (at your option) any later version.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_RTC_DS1338_H
+#define HW_RTC_DS1338_H
+
+#define TYPE_DS1338 "ds1338"
+
+#endif

-- 
2.50.1


