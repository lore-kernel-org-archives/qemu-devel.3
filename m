Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0691E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 15:15:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTMt5-0007aF-9R; Thu, 02 Jan 2025 10:13:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTMsy-0007YS-MU
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:13:20 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTMsw-0006Yp-Vc
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:13:20 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38789e5b6a7so5786103f8f.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 07:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735830797; x=1736435597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wb9ty/L7SGv5mOgc2yJsX8rO7EAR0vJUf8L2DSwFBvo=;
 b=shQx5dL1DN0FYhvhk+JgiVBaOfKzKnHC2pwAE2ybf3MctUdOcrWEXn1//qOuz3YJ45
 7g/glhxJgCZRLDHJ6iqxXc7/6lwpjvobD5Ke5hUgyDsyWDLHr7JHo8Zb7L0bDxuYnwT/
 3Ks2BpE2K9ui4EGJzslORuqZsRqj+3TTA1L8O1cBV7LiwPAid0xHo/edskxGS4geSPhl
 6429JZOqj7HQl3fnuRJ4DCqkN6Z1BQnTzEpUIYsIqSVNtUtGsIRLaS7MVB0jleZcXltM
 SwpC1qoN9p4080O5GjO3FH5jR0ZbU5DdtVaFxe3zXwHx1fblI1yw4HgH9pj57edH1Xyt
 FB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735830797; x=1736435597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wb9ty/L7SGv5mOgc2yJsX8rO7EAR0vJUf8L2DSwFBvo=;
 b=pnegA0/pSnZnPCTnWNJzyP6QnQEp2fitm6dOws09Nj94rVEindwmEfYj9217DR7Nsy
 FgBHtm5lMiGurf7ziNvLu8Q31JqJbF7bzH1wLgFXBjLEVnlmRi9pQykHJJcghYjlFQix
 mF7SUoKh8w6BRoHetx7I4OKvtcyTmicnCPRcmF6x6zOsfe8Vb5I2JuYzofdooPqUHyi/
 0GDMrcdyLfZyNXRDhGxofaAD22yYZ8lNO+fFOQdET93hMoifBn5oF4IixIaMXLUyKsUd
 VfNJ39A88yMHt2ePRWhVWlPzv8s3WTsWO5Kc4TdCpR/fou4wA7wn3ZBy9SjoBN1ddAbr
 sSRA==
X-Gm-Message-State: AOJu0YwbK/q/qXmR2djXGgf2TIXGbQGBJTZOPATQY6Pygb5wta2ho4Zd
 CiDtaV2vldY1k3GOXVE1pIAdvhV4nuovYR6kWaIOm25G03udoM6Hv1jCIOPWmLDqmp6o9IpVgnk
 HI+/xFw==
X-Gm-Gg: ASbGncsH9ILq6UyJLJfXfAowfOb6m/EQFikUv4c12RHN6mb9ZVd84ygVtGeaWyNEGrb
 OGgbApOz+xmHhTKMP/SLq2lbpZu0Np7N0EmLb3P1fcwtHn8ex4k6WnJC8KNPqjXYrqzn7TM/kSx
 HnHXlKI8YcKSnj0eF7BBUx7BPuu9slTtpZKW5FpwDWrslF0ldQatz9+L+NE5RXdaIOAf0ix61ev
 KoGCGzu0/E3D0kOwsYRxw05frs89RB77CriZBxSxqEW5CYRdQGp83iUeCODby6E5JCfGdHdA1Zx
 E5VuHqUPXUbL89hu0VhykLFaf21X2Z0=
X-Google-Smtp-Source: AGHT+IFN0CvMaQUpuugfjNdtFSWX6942AsEu4HqagGu2hhuynCygg9bM5XEiibQ1pAAYIRi+5hPJew==
X-Received: by 2002:a5d:598e:0:b0:38a:5557:7685 with SMTP id
 ffacd0b85a97d-38a55577991mr12688507f8f.5.1735830797221; 
 Thu, 02 Jan 2025 07:13:17 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e1a1sm37911207f8f.69.2025.01.02.07.13.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 07:13:16 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 06/10] qdev: Use machine_get_container()
Date: Thu,  2 Jan 2025 16:12:40 +0100
Message-ID: <20250102151244.59357-7-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102151244.59357-1-philmd@linaro.org>
References: <20250102151244.59357-1-philmd@linaro.org>
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

From: Peter Xu <peterx@redhat.com>

Use machine_get_container() whenever applicable across the tree.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241121192202.4155849-11-peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/gpio.c        | 3 +--
 hw/core/qdev.c        | 3 +--
 hw/core/sysbus.c      | 4 ++--
 hw/i386/pc.c          | 4 ++--
 system/ioport.c       | 2 +-
 system/memory.c       | 2 +-
 system/qdev-monitor.c | 6 +++---
 system/vl.c           | 3 +--
 8 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/hw/core/gpio.c b/hw/core/gpio.c
index 80d07a6ec99..6e32a8eec61 100644
--- a/hw/core/gpio.c
+++ b/hw/core/gpio.c
@@ -121,8 +121,7 @@ void qdev_connect_gpio_out_named(DeviceState *dev, const char *name, int n,
                                      name ? name : "unnamed-gpio-out", n);
     if (input_pin && !OBJECT(input_pin)->parent) {
         /* We need a name for object_property_set_link to work */
-        object_property_add_child(container_get(qdev_get_machine(),
-                                                "/unattached"),
+        object_property_add_child(machine_get_container("unattached"),
                                   "non-qdev-gpio[*]", OBJECT(input_pin));
     }
     object_property_set_link(OBJECT(dev), propname,
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 9973e029ffa..cfdb7beca24 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -476,8 +476,7 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
         if (!obj->parent) {
             gchar *name = g_strdup_printf("device[%d]", unattached_count++);
 
-            object_property_add_child(container_get(qdev_get_machine(),
-                                                    "/unattached"),
+            object_property_add_child(machine_get_container("unattached"),
                                       name, obj);
             unattached_parent = true;
             g_free(name);
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index e64d99c8edf..9355849ff0a 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -65,9 +65,9 @@ void foreach_dynamic_sysbus_device(FindSysbusDeviceFunc *func, void *opaque)
     };
 
     /* Loop through all sysbus devices that were spawned outside the machine */
-    container = container_get(qdev_get_machine(), "/peripheral");
+    container = machine_get_container("peripheral");
     find_sysbus_device(container, &find);
-    container = container_get(qdev_get_machine(), "/peripheral-anon");
+    container = machine_get_container("peripheral-anon");
     find_sysbus_device(container, &find);
 }
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 71118765884..9334b033f65 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -463,7 +463,7 @@ static int check_fdc(Object *obj, void *opaque)
 }
 
 static const char * const fdc_container_path[] = {
-    "/unattached", "/peripheral", "/peripheral-anon"
+    "unattached", "peripheral", "peripheral-anon"
 };
 
 /*
@@ -477,7 +477,7 @@ static ISADevice *pc_find_fdc0(void)
     CheckFdcState state = { 0 };
 
     for (i = 0; i < ARRAY_SIZE(fdc_container_path); i++) {
-        container = container_get(qdev_get_machine(), fdc_container_path[i]);
+        container = machine_get_container(fdc_container_path[i]);
         object_child_foreach(container, check_fdc, &state);
     }
 
diff --git a/system/ioport.c b/system/ioport.c
index fd551d0375e..55c2a752396 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -258,7 +258,7 @@ static void portio_list_add_1(PortioList *piolist,
     object_ref(&mrpio->mr);
     object_unparent(OBJECT(&mrpio->mr));
     if (!piolist->owner) {
-        owner = container_get(qdev_get_machine(), "/unattached");
+        owner = machine_get_container("unattached");
     } else {
         owner = piolist->owner;
     }
diff --git a/system/memory.c b/system/memory.c
index 78e17e0efa8..b17b5538ffa 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1238,7 +1238,7 @@ static void memory_region_do_init(MemoryRegion *mr,
         char *name_array = g_strdup_printf("%s[*]", escaped_name);
 
         if (!owner) {
-            owner = container_get(qdev_get_machine(), "/unattached");
+            owner = machine_get_container("unattached");
         }
 
         object_property_add_child(owner, name_array, OBJECT(mr));
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index c844f538025..7f4a1f5083b 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -348,7 +348,7 @@ static Object *qdev_get_peripheral(void)
     static Object *dev;
 
     if (dev == NULL) {
-        dev = container_get(qdev_get_machine(), "/peripheral");
+        dev = machine_get_container("peripheral");
     }
 
     return dev;
@@ -359,7 +359,7 @@ static Object *qdev_get_peripheral_anon(void)
     static Object *dev;
 
     if (dev == NULL) {
-        dev = container_get(qdev_get_machine(), "/peripheral-anon");
+        dev = machine_get_container("peripheral-anon");
     }
 
     return dev;
@@ -1098,7 +1098,7 @@ static GSList *qdev_build_hotpluggable_device_list(Object *peripheral)
 static void peripheral_device_del_completion(ReadLineState *rs,
                                              const char *str)
 {
-    Object *peripheral = container_get(qdev_get_machine(), "/peripheral");
+    Object *peripheral = machine_get_container("peripheral");
     GSList *list, *item;
 
     list = qdev_build_hotpluggable_device_list(peripheral);
diff --git a/system/vl.c b/system/vl.c
index 33fbb9f32f3..933ad83a935 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2138,8 +2138,7 @@ void qemu_create_machine(QDict *qdict)
     object_property_add_child(object_get_root(), "machine",
                               OBJECT(current_machine));
     qemu_create_machine_containers(OBJECT(current_machine));
-    object_property_add_child(container_get(OBJECT(current_machine),
-                                            "/unattached"),
+    object_property_add_child(machine_get_container("unattached"),
                               "sysbus", OBJECT(sysbus_get_default()));
 
     if (machine_class->minimum_page_bits) {
-- 
2.47.1


