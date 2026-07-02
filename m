Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BDF0C43327
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 18:42:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfMLP-0007bY-Df; Thu, 02 Jul 2026 14:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wfMLN-0007UU-Bp
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:41:01 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wfMLH-0005YQ-F3
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 14:41:01 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-493c19bad03so18021885e9.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 11:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783017654; x=1783622454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YxuiptMm10yF1MNT/yhAAdCmyxpf1Cn1NfFEs5L9eyI=;
 b=rwAx93SyD1TfMfhedF+uSw7olmcbAYn7MipverVAc513j/y+6xoUS9IAB9x5VNuZWe
 gQpmeKSHTLxyVSxBw3xz7IMGZDRjlmH6rvYt+7cIdzcFdkbtCRAJCboLwEts4CfU7wfC
 yZnwEaZEaj8g1jA7FBYcv3ljQ+3BbDTpM0J1h9CsKGu7iZOiVCQs/O7PzuPC4krQX6ME
 Qpz51jZH3UDYPPLeT2hLhwoxxBSNgnepf9/1i9xD+WClPlheCeZxqrRV63qhHMdLZ4tx
 hnCKQf3eZ9dZqnGFIFyYvvADeeovXDXJzs4/YB9HS8/MWjX8dWCQ21FiFo7oD54oouxa
 TdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783017654; x=1783622454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YxuiptMm10yF1MNT/yhAAdCmyxpf1Cn1NfFEs5L9eyI=;
 b=DzlatepE3S5Z+JtOiljvKpyD9Zj6sa+7T9TPJ+GzBu0yTs97PGviM6NVpsmRKOQMfI
 dOqtFcWNyTGLhfVw8VjQpVX5wwf14wkQXFuqbH3Hcs3Nr5g+gePN+8PTw0dT+37njcT9
 o81PIY86tuGuPIxiFRvIL7UQ11XsiUMIPmTqmRkFgPjbym15GksugmwH8JfH776mtQqX
 PgOs3umlZ7kLL/QDFx8ziCIWcMBU0+XPYmWVqDCBihc2P6lRLiV7BKKwZTQOm1u2XtIw
 ayEd1Ss3ZQ0klecHecNN4OVX8/FO5oG00NxEfF5QA2gB8x1HWoRQ3rNhI7QVBstlmwae
 dZdA==
X-Gm-Message-State: AOJu0YyOcKJ4Or6ohqgf1B2bJ3dVdNIYKGz2A5exTY8SpUg7NBOfyBwe
 asE6+3vewRk9SFHuWpy7SrbUYRC792zvejQHztPnm1clevIN+ldsOeZ8YCTpCg==
X-Gm-Gg: AfdE7cl4wO2hzktukBroi8WIFUSgLTJ9nqwGni3mSyW5D85oC8T2KLYKAu/NCa6TE7s
 RkrusOsUBeMxE1CuG9FPN0KKFTtCGoOowKR/1fKveo/DaBJEqJYlfV/TihSTY10mG5CaCuxAnnD
 itvoJv8p7CqofRprMsiEIrAqD/FzJ8erSuyinHF+g+/JKKmFPiuXZNjB5/xF2bp9lgEaOqYxuB/
 0O27vyBP1qleNpuh5rta6xFsrcNtc4oFULTw2Fqp2z7oAyk1tHcdn/b+MQ4VpEFaFL2wLE1N5HJ
 3BebaHibtHqWt3W/Tg8TdWMdQwhIVLKssuEaK/ZPq3m+tNf6TDuFAddAW2qA3P2DA8Sv7gYsr/w
 itSglYx/1j+sefmB4ORj1PlWW25kNVoQvwCyPZ5uL/M6dsmfIC7TgQbgliWOlveh9piAwipc+Oi
 tqrwn2W9UcuQNH1cqIX14L+TQ8jtb9j/VdnQS02b9uXjfMFIjmjE0PU5+vg+wIJZZSG0wS2CIn5
 oU/pjjhcHSPPgo1H50gQUD4xVTzu74MoRNs
X-Received: by 2002:a05:600d:c:b0:492:43d2:9e6e with SMTP id
 5b1f17b1804b1-493c2b4aa28mr80807455e9.9.1783017653737; 
 Thu, 02 Jul 2026 11:40:53 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-25c8-8a00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:25c8:8a00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef1807asm120271225e9.1.2026.07.02.11.40.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 11:40:53 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Matyas Bobek <matyas.bobek@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Jason Wang <jasowangio@gmail.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Jason Wang <jasowang@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Francisco Iglesias <francisco.iglesias@amd.com>
Subject: [PATCH v2 4/5] hw/arm/imx8mp-evk: Introduce FslImx8mpEvkState
Date: Thu,  2 Jul 2026 20:40:37 +0200
Message-ID: <20260702184038.178196-5-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702184038.178196-1-shentey@gmail.com>
References: <20260702184038.178196-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Introduce class FslImx8mpEvkState which will be needed for holding
CanBusState attributes and associated properties.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/imx8mp-evk.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index 4a0c9df76b..ca0ee2d3f2 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -19,6 +19,17 @@
 #include "qapi/error.h"
 #include <libfdt.h>
 
+#define TYPE_IMX8MPEVK_MACHINE MACHINE_TYPE_NAME("imx8mp-evk")
+OBJECT_DECLARE_SIMPLE_TYPE(FslImx8mpEvkState, IMX8MPEVK_MACHINE)
+
+struct FslImx8mpEvkState {
+    MachineState parent_obj;
+
+    FslImx8mpState soc;
+
+    struct arm_boot_info boot_info;
+};
+
 static void imx8mp_evk_modify_dtb(const struct arm_boot_info *info, void *fdt)
 {
     int i, offset;
@@ -57,8 +68,7 @@ static void imx8mp_evk_modify_dtb(const struct arm_boot_info *info, void *fdt)
 
 static void imx8mp_evk_init(MachineState *machine)
 {
-    static struct arm_boot_info boot_info;
-    FslImx8mpState *s;
+    FslImx8mpEvkState *s = IMX8MPEVK_MACHINE(machine);
 
     if (machine->ram_size > FSL_IMX8MP_RAM_SIZE_MAX) {
         error_report("RAM size " RAM_ADDR_FMT " above max supported (%08" PRIx64 ")",
@@ -66,7 +76,7 @@ static void imx8mp_evk_init(MachineState *machine)
         exit(1);
     }
 
-    boot_info = (struct arm_boot_info) {
+    s->boot_info = (struct arm_boot_info) {
         .loader_start = FSL_IMX8MP_RAM_START,
         .board_id = -1,
         .ram_size = machine->ram_size,
@@ -74,10 +84,9 @@ static void imx8mp_evk_init(MachineState *machine)
         .modify_dtb = imx8mp_evk_modify_dtb,
     };
 
-    s = FSL_IMX8MP(object_new(TYPE_FSL_IMX8MP));
-    object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
-    object_property_set_uint(OBJECT(s), "fec1-phy-num", 1, &error_fatal);
-    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
+    object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_FSL_IMX8MP);
+    object_property_set_uint(OBJECT(&s->soc), "fec1-phy-num", 1, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX8MP_RAM_START,
                                 machine->ram);
@@ -93,14 +102,14 @@ static void imx8mp_evk_init(MachineState *machine)
         }
 
         blk = blk_by_legacy_dinfo(di);
-        bus = qdev_get_child_bus(DEVICE(&s->usdhc[i]), "sd-bus");
+        bus = qdev_get_child_bus(DEVICE(&s->soc.usdhc[i]), "sd-bus");
         carddev = qdev_new(TYPE_SD_CARD);
         qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
         qdev_realize_and_unref(carddev, bus, &error_fatal);
     }
 
     if (!qtest_enabled()) {
-        arm_load_kernel(&s->cpu[0], machine, &boot_info);
+        arm_load_kernel(&s->soc.cpu[0], machine, &s->boot_info);
     }
 }
 
@@ -128,9 +137,10 @@ static void imx8mp_evk_machine_class_init(ObjectClass *oc, const void *data)
 
 static const TypeInfo imx8mp_evk_machine_types[] = {
     {
-        .name = MACHINE_TYPE_NAME("imx8mp-evk"),
+        .name = TYPE_IMX8MPEVK_MACHINE,
         .parent = TYPE_MACHINE,
         .class_init = imx8mp_evk_machine_class_init,
+        .instance_size = sizeof(FslImx8mpEvkState),
         .interfaces = aarch64_machine_interfaces,
     },
 };
-- 
2.55.0


