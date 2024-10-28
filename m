Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C1F2D5B846
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 22:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5YHX-0003cW-S0; Mon, 28 Oct 2024 18:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <patrick.eads@gmail.com>)
 id 1t5Y5r-00087T-W5
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 18:20:12 -0400
Received: from mail-yb1-xb30.google.com ([2607:f8b0:4864:20::b30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <patrick.eads@gmail.com>)
 id 1t5Y5n-000358-8Y
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 18:20:11 -0400
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-e2908e8d45eso4632494276.2
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 15:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730154004; x=1730758804; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D1X1FWYW6yo2GgSCGfLqzH+MajoCLVyZGYlqDb1GwYA=;
 b=ACtI+eClD58psxDttHSppWgXB7T2aVMRfEKja6JUgwmDLLEL+3GGfmpwrBAHYd1i8G
 ftXESbu8xQSOt6gr/xKzsjRY/IwC0jIRMZ6ifQoet5DV7eIGsDgD3oXOeSh3Mt9ZrRol
 5Ckn+o6W+bPgjUWZf4dfibVZyoVpgqKFV+9Az4w/5lRCzQDdh/D2kqO5jZ4+rYNZdMV6
 z1mJg0qjNy/u0KQeB/rwiMYLtGzxn1GS8s0qYQUfGPNkCmqe4WBROzKUbwl6ZjrnU28g
 VQgX5Pyf9rRUf9EIaL2M8sYJ2WcwkH/IBr3Od3CeLRXKaU5pRqzO5IEeTkecS2H9b5Vr
 QEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730154004; x=1730758804;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D1X1FWYW6yo2GgSCGfLqzH+MajoCLVyZGYlqDb1GwYA=;
 b=KiYi4P+n72FFgNVo8zQo9xPVJAAk+oaF/vhtBQdCQayKlrcii7vDYS7PtCPT/lvOXb
 fHK2mDzvD5zZ7u9gnaClnxqKOhyubcpAqeYnMsug8IS3s+ApDxC3RRc5zvaxePWcC5dw
 0Tqcb0bYxR6QaHel72aGXQE/89WoBvIY1JMstsw7kq//H0g24gG5te/SlEaAH5F7lQl3
 l0qkyhQcya0/qJ/5V4TNfSXXRy7JF3AyUjK+KIncut0n7PTnxGlfpM0I6NRk0fvq+uRl
 88sWwVhjRPqMLXBDiiH/72bRcFrKFEGfGzoa3T5UE4v62EJdmYCcvxBmH9rGObMdLruo
 VCiw==
X-Gm-Message-State: AOJu0YxbuQoiYgg2tJpnyeKxySqYq4MCCphULdhlvFG7xPkyoVeZEvQF
 Bedv7LHnN6in3YLVNsSo91NWKtUMUbfu3tioDW9baJDMUS7iWZAn6/89VNpZ
X-Google-Smtp-Source: AGHT+IFomHPUbnH0mxy7JU4HXQ+K6Qvyvo1wc4bLUP1wdwOG9lHKKlrqMyyx6eORj8iNJXYXiH7uDw==
X-Received: by 2002:a05:6902:114a:b0:e29:296d:780e with SMTP id
 3f1490d57ef6-e3087a40862mr8670651276.12.1730154003704; 
 Mon, 28 Oct 2024 15:20:03 -0700 (PDT)
Received: from tungsten-chungus.. (c-174-169-154-147.hsd1.nh.comcast.net.
 [174.169.154.147]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d27911asm365116185a.26.2024.10.28.15.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 15:20:03 -0700 (PDT)
From: Patrick Eads <patrick.eads@gmail.com>
X-Google-Original-From: Patrick Eads <peads@users.noreply.github.com>
To: qemu-devel@nongnu.org
Cc: Patrick Eads <patrick.eads@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] Plumbed previously ununsed defaults_enabled in vl.c,
 s.t. it provides the status of the '-nodefaults' flag to created
 machines
Date: Mon, 28 Oct 2024 22:13:46 +0000
Message-ID: <20241028221814.329577-2-peads@users.noreply.github.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b30;
 envelope-from=patrick.eads@gmail.com; helo=mail-yb1-xb30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 28 Oct 2024 18:32:13 -0400
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

From: Patrick Eads <patrick.eads@gmail.com>

Signed-off-by: Patrick Eads <patrick.eads@gmail.com>
---
 .gitignore          |  2 ++
 hw/core/machine.c   | 15 +++++++++++++++
 hw/m68k/q800.c      | 15 ++++++++-------
 include/hw/boards.h |  1 +
 system/vl.c         |  2 +-
 5 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/.gitignore b/.gitignore
index 61fa39967b..306799820c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -20,3 +20,5 @@ GTAGS
 *.swp
 *.patch
 *.gcov
+.idea
+buildDir
diff --git a/hw/core/machine.c b/hw/core/machine.c
index adaba17eba..5b133cc3f2 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -475,6 +475,16 @@ static void machine_set_usb(Object *obj, bool value, Error **errp)
     ms->usb_disabled = !value;
 }
 
+static bool machine_get_defaults(Object *obj, __attribute__((unused)) Error **errp) {
+    MachineState *ms = MACHINE(obj);
+    return ms->has_defaults;
+}
+
+static void machine_set_defaults(Object *obj, bool val, __attribute__((unused)) Error **errp) {
+    MachineState *ms = MACHINE(obj);
+    ms->has_defaults = val;
+}
+
 static bool machine_get_graphics(Object *obj, Error **errp)
 {
     MachineState *ms = MACHINE(obj);
@@ -1083,6 +1093,11 @@ static void machine_class_init(ObjectClass *oc, void *data)
     object_class_property_set_description(oc, "usb",
         "Set on/off to enable/disable usb");
 
+    object_class_property_add_bool(oc, "defaults",
+                                          machine_get_defaults, machine_set_defaults);
+    object_class_property_set_description(oc, "defaults",
+                                          "Set on/off to enable/disable hardware defaults");
+
     object_class_property_add_bool(oc, "graphics",
         machine_get_graphics, machine_set_graphics);
     object_class_property_set_description(oc, "graphics",
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 556604e1dc..63782315fe 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -262,13 +262,13 @@ static void q800_machine_init(MachineState *machine)
     const char *initrd_filename = machine->initrd_filename;
     const char *kernel_cmdline = machine->kernel_cmdline;
     const char *bios_name = machine->firmware ?: MACROM_FILENAME;
+    const bool has_defaults = m->parent_obj.has_defaults;
     hwaddr parameters_base;
     CPUState *cs;
     DeviceState *dev;
     SysBusESPState *sysbus_esp;
     ESPState *esp;
     SysBusDevice *sysbus;
-    BusState *adb_bus;
     NubusBus *nubus;
     DriveInfo *dinfo;
     NICInfo *nd;
@@ -354,12 +354,13 @@ static void q800_machine_init(MachineState *machine)
     qdev_connect_gpio_out(DEVICE(&m->via1), 0,
                           qdev_get_gpio_in_named(DEVICE(&m->glue),
                                                  "auxmode", 0));
-
-    adb_bus = qdev_get_child_bus(DEVICE(&m->via1), "adb.0");
-    dev = qdev_new(TYPE_ADB_KEYBOARD);
-    qdev_realize_and_unref(dev, adb_bus, &error_fatal);
-    dev = qdev_new(TYPE_ADB_MOUSE);
-    qdev_realize_and_unref(dev, adb_bus, &error_fatal);
+    if (has_defaults) {
+        BusState *adb_bus = qdev_get_child_bus(DEVICE(&m->via1), "adb.0");
+        dev = qdev_new(TYPE_ADB_KEYBOARD);
+        qdev_realize_and_unref(dev, adb_bus, &error_fatal);
+        dev = qdev_new(TYPE_ADB_MOUSE);
+        qdev_realize_and_unref(dev, adb_bus, &error_fatal);
+    }
 
     /* VIA 2 */
     object_initialize_child(OBJECT(machine), "via2", &m->via2,
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 5966069baa..6d0e22e73a 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -387,6 +387,7 @@ struct MachineState {
     bool mem_merge;
     bool usb;
     bool usb_disabled;
+    bool has_defaults;
     char *firmware;
     bool iommu;
     bool suppress_vmdesc;
diff --git a/system/vl.c b/system/vl.c
index e83b3b2608..e4f330f49b 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2122,7 +2122,7 @@ static void qemu_create_machine(QDict *qdict)
     object_property_add_child(container_get(OBJECT(current_machine),
                                             "/unattached"),
                               "sysbus", OBJECT(sysbus_get_default()));
-
+    current_machine->has_defaults = defaults_enabled();
     if (machine_class->minimum_page_bits) {
         if (!set_preferred_target_page_bits(machine_class->minimum_page_bits)) {
             /* This would be a board error: specifying a minimum smaller than
-- 
2.45.2


