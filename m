Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B2FC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 15:25:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whqcQ-0007vN-4V; Thu, 09 Jul 2026 11:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whqcO-0007u5-As; Thu, 09 Jul 2026 11:24:52 -0400
Received: from smtp2-g21.free.fr ([2a01:e0c:1:1599::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1whqcM-00085Y-RQ; Thu, 09 Jul 2026 11:24:52 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 0636B20039E;
 Thu,  9 Jul 2026 17:24:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783610688;
 bh=9lF6pkIIzE8I6ZmjQvePO4zXW8tA64q8RI6suNruPbA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=CIjy/GlRSaQ59RyYmAFxFz2K3LY1mhYjvtQwkEcWU+edzirPsA60nLfKafe78CzVo
 zcG+tXRh60bigdUmmGednIzhOiDhYHXKo6ZrBtlHEpLj/a7czV3vt8KicJ143o0SQ7
 Pc9kCkSrfnxkf8wxIWnWgot/FUpps9F0mlrlcylsxn8CW0qlh3ZRRYnhONUw0qnfFf
 xzKuj4r879IGUDLN7tj6indJq4SJVF8kOs1ub6kAW6QVRFJZd6NWFLowRep2y930S6
 G3XUSI0k1k2+QcxlKzyIDpKFvojcIP5798lVPQhssWQ2zw1OfiPKHl6M6mAq8Tw9Qt
 OtFU4an9WJS3A==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:39 +0200
Subject: [PATCH 01/29] hw/gpio: pca9552: register types with DEFINE_TYPES()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-catalina-upgrade-v1-1-814575bc076b@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610646; l=2548;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=9lF6pkIIzE8I6ZmjQvePO4zXW8tA64q8RI6suNruPbA=;
 b=VKMzvtoM9qIBUXrZp2g/svKxToB76uW0rPC4HlYonkH1/Du6wNEeL2v39qe165s+j7Ps05r+D
 2GKYwddmtquC+vS/X36G2iax01sN9xncUnz7UJaAKoyO+CKrUYBJz6B
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

Replace the separate TypeInfo definitions and pca955x_register_types()
registration function with a single type array registered through the
DEFINE_TYPES() macro, to prepare addition of new PCA955x-derived devices.

No functional change.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/gpio/pca9552.c | 49 +++++++++++++++++++++----------------------------
 1 file changed, 21 insertions(+), 28 deletions(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index b13ac9fd9c..50e868a6e9 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -492,16 +492,6 @@ static void pca955x_class_init(ObjectClass *klass, const void *data)
     device_class_set_props(dc, pca955x_properties);
 }
 
-static const TypeInfo pca955x_info = {
-    .name          = TYPE_PCA955X,
-    .parent        = TYPE_I2C_SLAVE,
-    .instance_init = pca955x_initfn,
-    .instance_size = sizeof(PCA955xState),
-    .class_init    = pca955x_class_init,
-    .class_size    = sizeof(PCA955xClass),
-    .abstract      = true,
-};
-
 static void pca9552_class_init(ObjectClass *oc, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -526,23 +516,26 @@ static void pca9535_class_init(ObjectClass *oc, const void *data)
     pc->has_led_support = false;
 }
 
-static const TypeInfo pca9552_info = {
-    .name          = TYPE_PCA9552,
-    .parent        = TYPE_PCA955X,
-    .class_init    = pca9552_class_init,
+static const TypeInfo pca955x_types[] = {
+    {
+        .name          = TYPE_PCA955X,
+        .parent        = TYPE_I2C_SLAVE,
+        .instance_init = pca955x_initfn,
+        .instance_size = sizeof(PCA955xState),
+        .class_init    = pca955x_class_init,
+        .class_size    = sizeof(PCA955xClass),
+        .abstract      = true,
+    },
+    {
+        .name          = TYPE_PCA9552,
+        .parent        = TYPE_PCA955X,
+        .class_init    = pca9552_class_init,
+    },
+    {
+        .name          = TYPE_PCA9535,
+        .parent        = TYPE_PCA955X,
+        .class_init    = pca9535_class_init,
+    }
 };
 
-static const TypeInfo pca9535_info = {
-    .name          = TYPE_PCA9535,
-    .parent        = TYPE_PCA955X,
-    .class_init    = pca9535_class_init,
-};
-
-static void pca955x_register_types(void)
-{
-    type_register_static(&pca955x_info);
-    type_register_static(&pca9552_info);
-    type_register_static(&pca9535_info);
-}
-
-type_init(pca955x_register_types)
+DEFINE_TYPES(pca955x_types)

-- 
2.50.1


