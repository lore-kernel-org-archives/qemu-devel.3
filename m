Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E669BC38150
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 09:30:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQ1js-00004x-Jg; Sat, 06 Jul 2024 05:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQ1jo-0008UU-LU
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 05:29:48 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sQ1jk-0006pO-F2
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 05:29:48 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fb53bfb6easo7530875ad.2
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2024 02:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1720258183; x=1720862983;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cNH7pzH7pWMk7GwZKAjOZkKaKNTxy8Q2306a5wKd+pg=;
 b=G80Atig8nQvnT/uXJWF5ojZX1GkZMzWLUKpMXW/WJcepGgAj0bsbE1t/vZOC82YK05
 nuu2HFKh/jc4WGYkAPjdUA1Ei+oGp+43qw+ZLBYbdQiirW/l49dTOs+olzjOC8RzMMOH
 UGfMRulpXbh4wejr+HFalZP3/OlgciZAM5+Hl6e+IPl1N2ci++z/cur0+p3jkta0hxn8
 tvF0pc4vnpaTJ6OnjUYuKQE5eiXpmMIb5t9LTQgD3Pn+ID5cX9aRnxm0VZH6m0CLNssW
 mqz1IgkJESq0v9GFOk6BSqYIC6ZMUQMjs38RCbuspv0Y6vOGP98uZ8rfzB5MaM4C90SU
 XPng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720258183; x=1720862983;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cNH7pzH7pWMk7GwZKAjOZkKaKNTxy8Q2306a5wKd+pg=;
 b=sDbgtfLwMSuRLU5+/RJp7p4jbVP69a7/FE2shY8XeWAPsF9eCbOWfXeoxBil4VuK8W
 KtumDlgS/Qea4wiqwCXzZEr+LKfHYOWtAEtRMlsb7UBRrM5FonMsvHOhoCwQSVoDdZzd
 y1A60NJ261ROwP7uQynO6T238jdzBeh6InwlO9GEaYDN1/Q99SJgOwwdGj5jRst03X2+
 UiZiTut2q17MzyFaSkewebM6KjlRwDP73DuWHTob1GJ34tDbKtmYLTcy9eDAhNjKf1Ui
 aBbPfXVpW4+VPCiOLYzWfu1M1FsYBZkr/Wux8H6prYWGlYF45/QG105WKHkwIgO/hWfi
 3TNQ==
X-Gm-Message-State: AOJu0Yx87xpVek6KmpFfJkqAMl8mdWh+8pn42fYwCC4hx4RDs9hOEz1u
 HRANcywsCg6RHIFo3oKUuxnlKPWW+WMsj3Gmce2qJNrMnhkZzQ7s+y4rNEqxhcCCEQsvl53dBgF
 EXAE=
X-Google-Smtp-Source: AGHT+IHItZjQKnoAlyczYw0QW75LmzzI1WxhhW2f5TD8YzaQmwbMeZgHUdws+9LZQ1eVG36Nrj9AyQ==
X-Received: by 2002:a17:902:d48d:b0:1fb:284b:b3ad with SMTP id
 d9443c01a7336-1fb33e5b27dmr59727295ad.28.1720258182965; 
 Sat, 06 Jul 2024 02:29:42 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fb13059efasm65202525ad.41.2024.07.06.02.29.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Jul 2024 02:29:42 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 06 Jul 2024 18:29:23 +0900
Subject: [PATCH 3/4] hw/pci: Convert rom_bar into OnOffAuto
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240706-rombar-v1-3-802daef2aec1@daynix.com>
References: <20240706-rombar-v1-0-802daef2aec1@daynix.com>
In-Reply-To: <20240706-rombar-v1-0-802daef2aec1@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

rom_bar is tristate but was defined as uint32_t so convert it into
OnOffAuto to clarify that. For compatibility, a uint32 value set via
QOM will be converted into OnOffAuto.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/igd-assign.txt               |  2 +-
 include/hw/pci/pci_device.h       |  2 +-
 hw/pci/pci.c                      | 57 +++++++++++++++++++++++++++++++++++++--
 hw/vfio/pci-quirks.c              |  2 +-
 hw/vfio/pci.c                     | 11 ++++----
 hw/xen/xen_pt_load_rom.c          |  4 +--
 tests/qtest/virtio-net-failover.c | 32 +++++++++++-----------
 7 files changed, 81 insertions(+), 29 deletions(-)

diff --git a/docs/igd-assign.txt b/docs/igd-assign.txt
index e17bb50789ad..35c6c8e28493 100644
--- a/docs/igd-assign.txt
+++ b/docs/igd-assign.txt
@@ -35,7 +35,7 @@ IGD has two different modes for assignment using vfio-pci:
       ISA/LPC bridge device (vfio-pci-igd-lpc-bridge) on the root bus at
       PCI address 1f.0.
     * The IGD device must have a VGA ROM, either provided via the romfile
-      option or loaded automatically through vfio (standard).  rombar=0
+      option or loaded automatically through vfio (standard).  rombar=off
       will disable legacy mode support.
     * Hotplug of the IGD device is not supported.
     * The IGD device must be a SandyBridge or newer model device.
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index ca151325085d..49b341ce2e27 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -147,7 +147,7 @@ struct PCIDevice {
     uint32_t romsize;
     bool has_rom;
     MemoryRegion rom;
-    uint32_t rom_bar;
+    OnOffAuto rom_bar;
 
     /* INTx routing notifier */
     PCIINTxRoutingNotifier intx_routing_notifier;
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 4c7be5295110..ca8fb5383765 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -67,11 +67,64 @@ static char *pcibus_get_fw_dev_path(DeviceState *dev);
 static void pcibus_reset_hold(Object *obj, ResetType type);
 static bool pcie_has_upstream_port(PCIDevice *dev);
 
+static void rom_bar_get(Object *obj, Visitor *v, const char *name, void *opaque,
+                        Error **errp)
+{
+    Property *prop = opaque;
+    int *ptr = object_field_prop_ptr(obj, prop);
+
+    visit_type_enum(v, name, ptr, prop->info->enum_table, errp);
+}
+
+static void rom_bar_set(Object *obj, Visitor *v, const char *name, void *opaque,
+                        Error **errp)
+{
+    Property *prop = opaque;
+    Error *local_err = NULL;
+    int *ptr = object_field_prop_ptr(obj, prop);
+    uint32_t value;
+
+    visit_type_enum(v, name, ptr, prop->info->enum_table, &local_err);
+    if (!local_err) {
+        return;
+    }
+
+    if (visit_type_uint32(v, name, &value, NULL)) {
+        if (value) {
+            *ptr = ON_OFF_AUTO_ON;
+            warn_report("Specifying a number for rombar is deprecated; replace a non-zero value with 'on'");
+        } else {
+            *ptr = ON_OFF_AUTO_OFF;
+            warn_report("Specifying a number for rombar is deprecated; replace 0 with 'off'");
+        }
+
+        return;
+    }
+
+    error_propagate(errp, local_err);
+}
+
+static void rom_bar_set_default_value(ObjectProperty *op, const Property *prop)
+{
+    object_property_set_default_str(op,
+        qapi_enum_lookup(prop->info->enum_table, prop->defval.i));
+}
+
+static const PropertyInfo qdev_prop_rom_bar = {
+    .name = "OnOffAuto",
+    .description = "on/off/auto",
+    .enum_table = &OnOffAuto_lookup,
+    .get = rom_bar_get,
+    .set = rom_bar_set,
+    .set_default_value = rom_bar_set_default_value,
+};
+
 static Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
     DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
     DEFINE_PROP_UINT32("romsize", PCIDevice, romsize, UINT32_MAX),
-    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, 1),
+    DEFINE_PROP_SIGNED("rombar",  PCIDevice, rom_bar, ON_OFF_AUTO_AUTO,
+                       qdev_prop_rom_bar, OnOffAuto),
     DEFINE_PROP_BIT("multifunction", PCIDevice, cap_present,
                     QEMU_PCI_CAP_MULTIFUNCTION_BITNR, false),
     DEFINE_PROP_BIT("x-pcie-lnksta-dllla", PCIDevice, cap_present,
@@ -2334,7 +2387,7 @@ static void pci_add_option_rom(PCIDevice *pdev, bool is_default_rom,
         return;
     }
 
-    if (!pdev->rom_bar) {
+    if (pdev->rom_bar == ON_OFF_AUTO_OFF) {
         /*
          * Load rom via fw_cfg instead of creating a rom bar,
          * for 0.11 compatibility.
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 39dae72497e0..0e920ed0691a 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -33,7 +33,7 @@
  * execution as noticed with the BCM 57810 card for lack of a
  * more better way to handle such issues.
  * The  user can still override by specifying a romfile or
- * rombar=1.
+ * rombar=on.
  * Please see https://bugs.launchpad.net/qemu/+bug/1284874
  * for an analysis of the 57810 card hang. When adding
  * a new vendor id/device id combination below, please also add
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index e03d9f3ba546..502ee2ed0489 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -902,7 +902,7 @@ static void vfio_pci_load_rom(VFIOPCIDevice *vdev)
         error_report("vfio-pci: Cannot read device rom at "
                     "%s", vdev->vbasedev.name);
         error_printf("Device option ROM contents are probably invalid "
-                    "(check dmesg).\nSkip option ROM probe with rombar=0, "
+                    "(check dmesg).\nSkip option ROM probe with rombar=off, "
                     "or load from file with romfile=\n");
         return;
     }
@@ -1012,11 +1012,10 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
 {
     uint32_t orig, size = cpu_to_le32((uint32_t)PCI_ROM_ADDRESS_MASK);
     off_t offset = vdev->config_offset + PCI_ROM_ADDRESS;
-    DeviceState *dev = DEVICE(vdev);
     char *name;
     int fd = vdev->vbasedev.fd;
 
-    if (vdev->pdev.romfile || !vdev->pdev.rom_bar) {
+    if (vdev->pdev.romfile || vdev->pdev.rom_bar == ON_OFF_AUTO_OFF) {
         /* Since pci handles romfile, just print a message and return */
         if (vfio_opt_rom_in_denylist(vdev) && vdev->pdev.romfile) {
             warn_report("Device at %s is known to cause system instability"
@@ -1046,17 +1045,17 @@ static void vfio_pci_size_rom(VFIOPCIDevice *vdev)
     }
 
     if (vfio_opt_rom_in_denylist(vdev)) {
-        if (dev->opts && qdict_haskey(dev->opts, "rombar")) {
+        if (vdev->pdev.rom_bar == ON_OFF_AUTO_ON) {
             warn_report("Device at %s is known to cause system instability"
                         " issues during option rom execution",
                         vdev->vbasedev.name);
             error_printf("Proceeding anyway since user specified"
-                         " non zero value for rombar\n");
+                         " on for rombar\n");
         } else {
             warn_report("Rom loading for device at %s has been disabled"
                         " due to system instability issues",
                         vdev->vbasedev.name);
-            error_printf("Specify rombar=1 or romfile to force\n");
+            error_printf("Specify rombar=on or romfile to force\n");
             return;
         }
     }
diff --git a/hw/xen/xen_pt_load_rom.c b/hw/xen/xen_pt_load_rom.c
index 6bc64acd3352..025a6b25a916 100644
--- a/hw/xen/xen_pt_load_rom.c
+++ b/hw/xen/xen_pt_load_rom.c
@@ -26,7 +26,7 @@ void *pci_assign_dev_load_option_rom(PCIDevice *dev,
     Object *owner = OBJECT(dev);
 
     /* If loading ROM from file, pci handles it */
-    if (dev->romfile || !dev->rom_bar) {
+    if (dev->romfile || dev->rom_bar == ON_OFF_AUTO_OFF) {
         return NULL;
     }
 
@@ -71,7 +71,7 @@ void *pci_assign_dev_load_option_rom(PCIDevice *dev,
     if (!fread(ptr, 1, st.st_size, fp)) {
         error_report("pci-assign: Cannot read from host %s", rom_file);
         error_printf("Device option ROM contents are probably invalid "
-                     "(check dmesg).\nSkip option ROM probe with rombar=0, "
+                     "(check dmesg).\nSkip option ROM probe with rombar=off, "
                      "or load from file with romfile=\n");
         goto close_rom;
     }
diff --git a/tests/qtest/virtio-net-failover.c b/tests/qtest/virtio-net-failover.c
index 73dfabc2728b..f65b97683fb6 100644
--- a/tests/qtest/virtio-net-failover.c
+++ b/tests/qtest/virtio-net-failover.c
@@ -568,7 +568,7 @@ static void test_hotplug_2_reverse(void)
                          "{'bus': 'root0',"
                          "'failover': true,"
                          "'netdev': 'hs0',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_STANDBY0"'}");
 
@@ -655,7 +655,7 @@ static void test_migrate_out(gconstpointer opaque)
                          "{'bus': 'root1',"
                          "'failover_pair_id': 'standby0',"
                          "'netdev': 'hs1',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY0"'}");
 
@@ -765,7 +765,7 @@ static void test_migrate_in(gconstpointer opaque)
                          "{'bus': 'root1',"
                          "'failover_pair_id': 'standby0',"
                          "'netdev': 'hs1',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY0"'}");
 
@@ -819,7 +819,7 @@ static void test_off_migrate_out(gconstpointer opaque)
                          "{'bus': 'root1',"
                          "'failover_pair_id': 'standby0',"
                          "'netdev': 'hs1',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY0"'}");
 
@@ -887,7 +887,7 @@ static void test_off_migrate_in(gconstpointer opaque)
                          "{'bus': 'root1',"
                          "'failover_pair_id': 'standby0',"
                          "'netdev': 'hs1',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY0"'}");
 
@@ -938,7 +938,7 @@ static void test_guest_off_migrate_out(gconstpointer opaque)
                          "{'bus': 'root1',"
                          "'failover_pair_id': 'standby0',"
                          "'netdev': 'hs1',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY0"'}");
 
@@ -1014,7 +1014,7 @@ static void test_guest_off_migrate_in(gconstpointer opaque)
                          "{'bus': 'root1',"
                          "'failover_pair_id': 'standby0',"
                          "'netdev': 'hs1',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY0"'}");
 
@@ -1065,7 +1065,7 @@ static void test_migrate_guest_off_abort(gconstpointer opaque)
                          "{'bus': 'root1',"
                          "'failover_pair_id': 'standby0',"
                          "'netdev': 'hs1',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY0"'}");
 
@@ -1170,7 +1170,7 @@ static void test_migrate_abort_wait_unplug(gconstpointer opaque)
                          "{'bus': 'root1',"
                          "'failover_pair_id': 'standby0',"
                          "'netdev': 'hs1',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY0"'}");
 
@@ -1259,7 +1259,7 @@ static void test_migrate_abort_active(gconstpointer opaque)
                          "{'bus': 'root1',"
                          "'failover_pair_id': 'standby0',"
                          "'netdev': 'hs1',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY0"'}");
 
@@ -1358,7 +1358,7 @@ static void test_migrate_off_abort(gconstpointer opaque)
                          "{'bus': 'root1',"
                          "'failover_pair_id': 'standby0',"
                          "'netdev': 'hs1',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY0"'}");
 
@@ -1450,7 +1450,7 @@ static void test_migrate_abort_timeout(gconstpointer opaque)
                          "{'bus': 'root1',"
                          "'failover_pair_id': 'standby0',"
                          "'netdev': 'hs1',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY0"'}");
 
@@ -1543,7 +1543,7 @@ static void test_multi_out(gconstpointer opaque)
                          "{'bus': 'root1',"
                          "'failover_pair_id': 'standby0',"
                          "'netdev': 'hs1',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY0"'}");
 
@@ -1574,7 +1574,7 @@ static void test_multi_out(gconstpointer opaque)
                          "{'bus': 'root3',"
                          "'failover_pair_id': 'standby1',"
                          "'netdev': 'hs3',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY1"'}");
 
@@ -1713,7 +1713,7 @@ static void test_multi_in(gconstpointer opaque)
                          "{'bus': 'root1',"
                          "'failover_pair_id': 'standby0',"
                          "'netdev': 'hs1',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY0"'}");
 
@@ -1737,7 +1737,7 @@ static void test_multi_in(gconstpointer opaque)
                          "{'bus': 'root3',"
                          "'failover_pair_id': 'standby1',"
                          "'netdev': 'hs3',"
-                         "'rombar': 0,"
+                         "'rombar': 'off',"
                          "'romfile': '',"
                          "'mac': '"MAC_PRIMARY1"'}");
 

-- 
2.45.2


