Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BB4C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:25:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whqci-0008Mb-9O; Thu, 09 Jul 2026 11:25:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whqcg-0008IE-3l; Thu, 09 Jul 2026 11:25:10 -0400
Received: from smtp2-g21.free.fr ([2a01:e0c:1:1599::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whqce-0008KV-3m; Thu, 09 Jul 2026 11:25:09 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id D71552003D3;
 Thu,  9 Jul 2026 17:24:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783610706;
 bh=7Z7eCg8fN9+L3Nr+gHPabU3QFP5nsLFgd58dIgxmT20=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=DkvkNLNAd1iCSDLk3nd4DqLr6Rf5TiimmwdP6oL12XTKE5nhRZ2vEPAoC/3zcDyr5
 31wQe3JQbgGnMdP8jkjOyJ/hziC6gGy2fm9HopWAtb7I0/f6xCaMXKUOBdTcmGCThN
 Ays5a2X9dSOctxUqFkBaKonxYVDEFdi6xVhodbAchnq2eYA683qrwtBLCswgkQ8zFb
 1jfpqgwZAstE4I3yMziv5qR5qKKngpPujIcKaMjtoz6qmOwQ5EAxcshXU34KebgAve
 j7y5QtrwfLWbPLFafs7i2c/pSVGEvZcTrYyKBYR8gFGplYdL/L4/WONoLudq1uzUx3
 ogSl7Anskm1sA==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:40 +0200
Subject: [PATCH 02/29] hw/gpio: pca9552: move PCA955xState definition out
 of the header
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260709-catalina-upgrade-v1-2-814575bc076b@free.fr>
References: <20260709-catalina-upgrade-v1-0-814575bc076b@free.fr>
In-Reply-To: <20260709-catalina-upgrade-v1-0-814575bc076b@free.fr>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Corey Minyard <cminyard@mvista.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610647; l=3933;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=7Z7eCg8fN9+L3Nr+gHPabU3QFP5nsLFgd58dIgxmT20=;
 b=xK4JxD/vDva0fOhv3Y/chtWQKRtOrET6oIkqb2X3g9QR+MUrMoDYk62InGw8s8ykpR2WXb2JK
 zv4rJ+vOSrGBOB9DrYX7RbbAiSNySwhwAyc5636Lq/BH9q79EO/+NGR
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=2a01:e0c:1:1599::11;
 envelope-from=emmanuel.blot@free.fr; helo=smtp2-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

Nothing outside pca9552.c uses the PCA955xState structure, its instance
checker, or the PCA955X_NR_REGS/PCA955X_PIN_COUNT_MAX defines: the board
files and qtests only rely on the TYPE_* name macros (and the register
macros in pca9552_regs.h).

Move the state structure and the size defines into pca9552.c, leaving
pca9552.h with just the type-name macros. While at it, replace the
separate DECLARE_INSTANCE_CHECKER and DECLARE_CLASS_CHECKERS declarations
with a single OBJECT_DECLARE_TYPE().

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/gpio/pca9552.c         | 29 ++++++++++++++++++++++++-----
 include/hw/gpio/pca9552.h | 30 ++++--------------------------
 2 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index 50e868a6e9a..36bc4f86edb 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -1,7 +1,10 @@
 /*
- * PCA9552 I2C LED blinker
+ * PCA955X I2C LED blinker and I/O expanders
  *
  *     https://www.nxp.com/docs/en/application-note/AN264.pdf
+ *     https://www.nxp.com/docs/en/data-sheet/PCA9552.pdf
+ *     https://www.nxp.com/docs/en/data-sheet/PCA9555.pdf
+ *     https://www.nxp.com/docs/en/data-sheet/PCA9535_PCA9535C.pdf
  *
  * Copyright (c) 2017-2018, IBM Corporation.
  * Copyright (c) 2020 Philippe Mathieu-Daudé
@@ -12,9 +15,9 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "qemu/module.h"
 #include "qemu/bitops.h"
 #include "hw/core/qdev-properties.h"
+#include "hw/i2c/i2c.h"
 #include "hw/gpio/pca9552.h"
 #include "hw/gpio/pca9552_regs.h"
 #include "hw/core/irq.h"
@@ -24,6 +27,25 @@
 #include "trace.h"
 #include "qom/object.h"
 
+#define PCA955X_NR_REGS 10
+#define PCA955X_PIN_COUNT_MAX 16
+
+OBJECT_DECLARE_TYPE(PCA955xState, PCA955xClass, PCA955X)
+
+struct PCA955xState {
+    /*< private >*/
+    I2CSlave i2c;
+    /*< public >*/
+
+    uint8_t len;
+    uint8_t pointer;
+
+    uint8_t regs[PCA955X_NR_REGS];
+    qemu_irq gpio_out[PCA955X_PIN_COUNT_MAX];
+    uint8_t ext_state[PCA955X_PIN_COUNT_MAX];
+    char *description; /* For debugging purpose only */
+};
+
 struct PCA955xClass {
     /*< private >*/
     I2CSlaveClass parent_class;
@@ -33,10 +55,7 @@ struct PCA955xClass {
     uint8_t max_reg;
     bool has_led_support;
 };
-typedef struct PCA955xClass PCA955xClass;
 
-DECLARE_CLASS_CHECKERS(PCA955xClass, PCA955X,
-                       TYPE_PCA955X)
 /*
  * Note:  The LED_ON and LED_OFF configuration values for the PCA955X
  *        chips are the reverse of the PCA953X family of chips.
diff --git a/include/hw/gpio/pca9552.h b/include/hw/gpio/pca9552.h
index 43b175235d2..71479ea0006 100644
--- a/include/hw/gpio/pca9552.h
+++ b/include/hw/gpio/pca9552.h
@@ -1,39 +1,17 @@
 /*
- * PCA9552 I2C LED blinker
+ * PCA955X I2C LED blinker and I/O expanders
  *
  * Copyright (c) 2017-2018, IBM Corporation.
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or
  * later. See the COPYING file in the top-level directory.
  */
-#ifndef PCA9552_H
-#define PCA9552_H
 
-#include "hw/i2c/i2c.h"
-#include "qom/object.h"
+#ifndef HW_GPIO_PCA9552_H
+#define HW_GPIO_PCA9552_H
 
-#define TYPE_PCA9552 "pca9552"
 #define TYPE_PCA955X "pca955x"
+#define TYPE_PCA9552 "pca9552"
 #define TYPE_PCA9535 "pca9535"
-typedef struct PCA955xState PCA955xState;
-DECLARE_INSTANCE_CHECKER(PCA955xState, PCA955X,
-                         TYPE_PCA955X)
-
-#define PCA955X_NR_REGS 10
-#define PCA955X_PIN_COUNT_MAX 16
-
-struct PCA955xState {
-    /*< private >*/
-    I2CSlave i2c;
-    /*< public >*/
-
-    uint8_t len;
-    uint8_t pointer;
-
-    uint8_t regs[PCA955X_NR_REGS];
-    qemu_irq gpio_out[PCA955X_PIN_COUNT_MAX];
-    uint8_t ext_state[PCA955X_PIN_COUNT_MAX];
-    char *description; /* For debugging purpose only */
-};
 
 #endif

-- 
2.50.1


