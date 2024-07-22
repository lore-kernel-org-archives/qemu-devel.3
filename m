Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A16AC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 06:47:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVmoi-0001MO-Ms; Mon, 22 Jul 2024 02:46:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sVmoY-00016Z-Ei; Mon, 22 Jul 2024 02:46:31 -0400
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sVmoV-0003f9-3h; Mon, 22 Jul 2024 02:46:30 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id DD580CE0A1B;
 Mon, 22 Jul 2024 06:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E95C116B1;
 Mon, 22 Jul 2024 06:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1721630776;
 bh=XsNqpMUJB0O6cj3yT/NeTaj5tNxcpWbVl6wxYyGWgio=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UEdxjxKvHvqJG9nY5yYMVZS5k1A8R0r0CgsbhkqHHaLTaGUD8V/UFTeKmWf2O9lYD
 Fu7CVBD2UTQYKgihYIBTBVHLTf4lvDxZpmxzq0RS2imdQg8uXlvSq7zpaOiTJPp97l
 KL1koWTU+jiJK2Pt26yofkCSA+7Xp4dxIVmz9IME8/pbhNwkxx77JxNBSz+8oBshXW
 q4HfyqDFBHIVM/qvk5ah6kRn9uE/i3z8Elyo2jBjtD/Ze+wZrBvLkUNyCJzIRi216U
 GrI2iR2qZkViHRE1X8ifOU2F3AHSzsbtQ8/OCrVOe48yqruK4gataRLwh+krS3Ui1u
 dNSnIHSCbghwA==
Received: from mchehab by mail.kernel.org with local (Exim 4.97.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1sVmoI-00000000WQi-0oQV; Mon, 22 Jul 2024 08:46:14 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v3 1/7] arm/virt: place power button pin number on a define
Date: Mon, 22 Jul 2024 08:45:53 +0200
Message-ID: <bf8367bddfdc95e378b5725c732533c3ba20d388.1721630625.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1721630625.git.mchehab+huawei@kernel.org>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=145.40.73.55;
 envelope-from=mchehab+huawei@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Having magic numbers inside the code is not a good idea, as it
is error-prone. So, instead, create a macro with the number
definition.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/arm/virt-acpi-build.c | 6 +++---
 hw/arm/virt.c            | 7 ++++---
 include/hw/arm/virt.h    | 3 +++
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index e10cad86dd73..f76fb117adff 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -154,10 +154,10 @@ static void acpi_dsdt_add_gpio(Aml *scope, const MemMapEntry *gpio_memmap,
     aml_append(dev, aml_name_decl("_CRS", crs));
 
     Aml *aei = aml_resource_template();
-    /* Pin 3 for power button */
-    const uint32_t pin_list[1] = {3};
+
+    const uint32_t pin = GPIO_PIN_POWER_BUTTON;
     aml_append(aei, aml_gpio_int(AML_CONSUMER, AML_EDGE, AML_ACTIVE_HIGH,
-                                 AML_EXCLUSIVE, AML_PULL_UP, 0, pin_list, 1,
+                                 AML_EXCLUSIVE, AML_PULL_UP, 0, &pin, 1,
                                  "GPO0", NULL, 0));
     aml_append(dev, aml_name_decl("_AEI", aei));
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b0c68d66a345..c99c8b1713c6 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1004,7 +1004,7 @@ static void virt_powerdown_req(Notifier *n, void *opaque)
     if (s->acpi_dev) {
         acpi_send_event(s->acpi_dev, ACPI_POWER_DOWN_STATUS);
     } else {
-        /* use gpio Pin 3 for power button event */
+        /* use gpio Pin for power button event */
         qemu_set_irq(qdev_get_gpio_in(gpio_key_dev, 0), 1);
     }
 }
@@ -1013,7 +1013,8 @@ static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
                              uint32_t phandle)
 {
     gpio_key_dev = sysbus_create_simple("gpio-key", -1,
-                                        qdev_get_gpio_in(pl061_dev, 3));
+                                        qdev_get_gpio_in(pl061_dev,
+                                                         GPIO_PIN_POWER_BUTTON));
 
     qemu_fdt_add_subnode(fdt, "/gpio-keys");
     qemu_fdt_setprop_string(fdt, "/gpio-keys", "compatible", "gpio-keys");
@@ -1024,7 +1025,7 @@ static void create_gpio_keys(char *fdt, DeviceState *pl061_dev,
     qemu_fdt_setprop_cell(fdt, "/gpio-keys/poweroff", "linux,code",
                           KEY_POWER);
     qemu_fdt_setprop_cells(fdt, "/gpio-keys/poweroff",
-                           "gpios", phandle, 3, 0);
+                           "gpios", phandle, GPIO_PIN_POWER_BUTTON, 0);
 }
 
 #define SECURE_GPIO_POWEROFF 0
diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index ab961bb6a9b8..a4d937ed45ac 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -47,6 +47,9 @@
 /* See Linux kernel arch/arm64/include/asm/pvclock-abi.h */
 #define PVTIME_SIZE_PER_CPU 64
 
+/* GPIO pins */
+#define GPIO_PIN_POWER_BUTTON  3
+
 enum {
     VIRT_FLASH,
     VIRT_MEM,
-- 
2.45.2


