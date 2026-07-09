Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B568C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:26:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whqda-0001hh-8n; Thu, 09 Jul 2026 11:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whqdY-0001hI-As; Thu, 09 Jul 2026 11:26:04 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whqdV-0000MP-NZ; Thu, 09 Jul 2026 11:26:03 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 993C42003DC;
 Thu,  9 Jul 2026 17:25:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783610760;
 bh=SnKnbSWCiJv4knKbQJZq1xAsiDv4kW43nmwzOiobfNc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=d1254RwLPPpGO0W9XSi6fpeY50TM5z2pGVjW1t6rhZdP5QfKPAxezMc7dLsZYKmJV
 E9S7J/ftobaIUXSb5CZUL1PtxfEqw5j05ZWHszmiIkYB6ih/y4ymBYbeYybvri77Zi
 j5baWqOedPz55wwAM4TKihAg7Oq+GZR9NKhbQQyG81luYoRUT2f5Xw6/n/7YezcvjB
 1QMEXQagqLHYXLxk2WbAsfL5DtRZqBh+5tLdz59874cgA/p1VocQBgXCqBl216MsEh
 py5hagGyaF7jCzlNAdwgWZTPaVI+pT3xIlfPDC91TPx2d+1ZLTf9h9kxU/wZBi6Y+K
 42Boaq5yO2zQQ==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:43 +0200
Subject: [PATCH 05/29] hw/gpio: pca9552: declare pca9555 device as an alias
 of pca9535 device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-catalina-upgrade-v1-5-814575bc076b@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610647; l=1669;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=SnKnbSWCiJv4knKbQJZq1xAsiDv4kW43nmwzOiobfNc=;
 b=FZ1Iq9Ru3Bq5qyFmij1Y2wqRNbViTxJJD9GAiBcihg7G1N9w20jVkqW40Ibof7jUv8wEY9qnv
 hSfU2YaT2+7BV+vQ0/taMYkdNua0Bxbt6KXAzYTVj5jZ++FUgyqQYMD
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=212.27.42.2; envelope-from=emmanuel.blot@free.fr;
 helo=smtp2-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

PCA9555 HW is mostly identical to PCA9535.
PCA9555 HW features pull-up resistors that are not available on PCA9535.

Pull-up are not handled by current PCA955x implementation and PCA9535
already initializes input as Hi-Z.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/gpio/pca9552.c         | 9 +++++++--
 include/hw/gpio/pca9552.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index ffeb438d2a..3b9b63eb17 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -523,7 +523,7 @@ static void pca9552_class_init(ObjectClass *oc, const void *data)
     pc->has_led_support = true;
 }
 
-static void pca9535_class_init(ObjectClass *oc, const void *data)
+static void pca95x5_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCA955xClass *pc = PCA955X_CLASS(oc);
@@ -553,7 +553,12 @@ static const TypeInfo pca955x_types[] = {
     {
         .name          = TYPE_PCA9535,
         .parent        = TYPE_PCA955X,
-        .class_init    = pca9535_class_init,
+        .class_init    = pca95x5_class_init,
+    },
+    {
+        .name          = TYPE_PCA9555,
+        .parent        = TYPE_PCA955X,
+        .class_init    = pca95x5_class_init,
     }
 };
 
diff --git a/include/hw/gpio/pca9552.h b/include/hw/gpio/pca9552.h
index 71479ea000..5299c13829 100644
--- a/include/hw/gpio/pca9552.h
+++ b/include/hw/gpio/pca9552.h
@@ -13,5 +13,6 @@
 #define TYPE_PCA955X "pca955x"
 #define TYPE_PCA9552 "pca9552"
 #define TYPE_PCA9535 "pca9535"
+#define TYPE_PCA9555 "pca9555"
 
 #endif

-- 
2.50.1


