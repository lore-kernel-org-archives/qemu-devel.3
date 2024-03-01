Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4AF9C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 15:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg51j-0003up-Bt; Fri, 01 Mar 2024 10:42:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rg51f-0003np-Bw
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 10:42:20 -0500
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rg51a-0004Up-CC
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 10:42:19 -0500
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id C93A8609AA;
 Fri,  1 Mar 2024 18:42:10 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:a531::1:29])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id sfdOnf3IdSw0-1pLnzR1R; Fri, 01 Mar 2024 18:42:09 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709307729;
 bh=X5r6PofDQBc6pvuJx10KDXnsTWWDrOT2ZyAexm0eI9s=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=0wXebuSrE6GbPE+X3AfZyMFzP0UFWyhwHwIiCbqaQ20DvN7jH+qJOS9KVp3Ifhanm
 bSh7Dj5vD+sJFNiuG+8pqOUWaBHrakTwxHYp81x1gWYCls+52rLM+31Fmhy2Kqwt3d
 AWU4J6K4qK9J78QUPGPkD2nXD706hCVrq8GS9dRs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com
Cc: marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH v9 1/1] hw: add some convenient trace-events for pcie and shpc
 hotplug
Date: Fri,  1 Mar 2024 18:41:46 +0300
Message-Id: <20240301154146.761531-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240301154146.761531-1-vsementsov@yandex-team.ru>
References: <20240301154146.761531-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

Add trace-events that may help to debug problems with hotplugging.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/pci/pcie.c       | 56 +++++++++++++++++++++++++++++++++++++++++++++
 hw/pci/shpc.c       | 46 +++++++++++++++++++++++++++++++++++++
 hw/pci/trace-events |  6 +++++
 3 files changed, 108 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index 6db0cf69cd..f56079acf5 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -28,6 +28,7 @@
 #include "hw/pci/pcie_regs.h"
 #include "hw/pci/pcie_port.h"
 #include "qemu/range.h"
+#include "trace.h"
 
 //#define DEBUG_PCIE
 #ifdef DEBUG_PCIE
@@ -45,6 +46,23 @@ static bool pcie_sltctl_powered_off(uint16_t sltctl)
         && (sltctl & PCI_EXP_SLTCTL_PIC) == PCI_EXP_SLTCTL_PWR_IND_OFF;
 }
 
+static const char *pcie_led_state_to_str(uint16_t value)
+{
+    switch (value) {
+    case PCI_EXP_SLTCTL_PWR_IND_ON:
+    case PCI_EXP_SLTCTL_ATTN_IND_ON:
+        return "on";
+    case PCI_EXP_SLTCTL_PWR_IND_BLINK:
+    case PCI_EXP_SLTCTL_ATTN_IND_BLINK:
+        return "blink";
+    case PCI_EXP_SLTCTL_PWR_IND_OFF:
+    case PCI_EXP_SLTCTL_ATTN_IND_OFF:
+        return "off";
+    default:
+        return "invalid";
+    }
+}
+
 /***************************************************************************
  * pci express capability helper functions
  */
@@ -735,6 +753,28 @@ void pcie_cap_slot_get(PCIDevice *dev, uint16_t *slt_ctl, uint16_t *slt_sta)
     *slt_sta = pci_get_word(exp_cap + PCI_EXP_SLTSTA);
 }
 
+static void find_child_fn(PCIBus *bus, PCIDevice *dev, void *opaque)
+{
+    PCIDevice **child = opaque;
+
+    if (!*child) {
+        *child = dev;
+    }
+}
+
+/*
+ * Returns the plugged device or first function of multifunction plugged device
+ */
+static PCIDevice *pcie_cap_slot_find_child(PCIDevice *dev)
+{
+    PCIBus *sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(dev));
+    PCIDevice *child = NULL;
+
+    pci_for_each_device(sec_bus, pci_bus_num(sec_bus), find_child_fn, &child);
+
+    return child;
+}
+
 void pcie_cap_slot_write_config(PCIDevice *dev,
                                 uint16_t old_slt_ctl, uint16_t old_slt_sta,
                                 uint32_t addr, uint32_t val, int len)
@@ -779,6 +819,22 @@ void pcie_cap_slot_write_config(PCIDevice *dev,
                         sltsta);
     }
 
+    if (trace_event_get_state_backends(TRACE_PCIE_CAP_SLOT_WRITE_CONFIG)) {
+        DeviceState *parent = DEVICE(dev);
+        DeviceState *child = DEVICE(pcie_cap_slot_find_child(dev));
+
+        trace_pcie_cap_slot_write_config(
+            parent->canonical_path,
+            child ? child->canonical_path : "no-child",
+            (sltsta & PCI_EXP_SLTSTA_PDS) ? "present" : "not present",
+            pcie_led_state_to_str(old_slt_ctl & PCI_EXP_SLTCTL_PIC),
+            pcie_led_state_to_str(val & PCI_EXP_SLTCTL_PIC),
+            pcie_led_state_to_str(old_slt_ctl & PCI_EXP_SLTCTL_AIC),
+            pcie_led_state_to_str(val & PCI_EXP_SLTCTL_AIC),
+            (old_slt_ctl & PCI_EXP_SLTCTL_PWR_OFF) ? "off" : "on",
+            (val & PCI_EXP_SLTCTL_PWR_OFF) ? "off" : "on");
+    }
+
     /*
      * If the slot is populated, power indicator is off and power
      * controller is off, it is safe to detach the devices.
diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index d2a5eea69e..aac6f2d034 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -8,6 +8,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/msi.h"
+#include "trace.h"
 
 /* TODO: model power only and disabled slot states. */
 /* TODO: handle SERR and wakeups */
@@ -123,6 +124,34 @@
 #define SHPC_PCI_TO_IDX(pci_slot) ((pci_slot) - 1)
 #define SHPC_IDX_TO_PHYSICAL(slot) ((slot) + 1)
 
+static const char *shpc_led_state_to_str(uint8_t value)
+{
+    switch (value) {
+    case SHPC_LED_ON:
+        return "on";
+    case SHPC_LED_BLINK:
+        return "blink";
+    case SHPC_LED_OFF:
+        return "off";
+    default:
+        return "invalid";
+    }
+}
+
+static const char *shpc_slot_state_to_str(uint8_t value)
+{
+    switch (value) {
+    case SHPC_STATE_PWRONLY:
+        return "power-only";
+    case SHPC_STATE_ENABLED:
+        return "enabled";
+    case SHPC_STATE_DISABLED:
+        return "disabled";
+    default:
+        return "invalid";
+    }
+}
+
 static uint8_t shpc_get_status(SHPCDevice *shpc, int slot, uint16_t msk)
 {
     uint8_t *status = shpc->config + SHPC_SLOT_STATUS(slot);
@@ -302,6 +331,23 @@ static void shpc_slot_command(PCIDevice *d, uint8_t target,
         shpc_set_status(shpc, slot, state, SHPC_SLOT_STATE_MASK);
     }
 
+    if (trace_event_get_state_backends(TRACE_SHPC_SLOT_COMMAND)) {
+        DeviceState *parent = DEVICE(d);
+        int pci_slot = SHPC_IDX_TO_PCI(slot);
+        DeviceState *child =
+            DEVICE(shpc->sec_bus->devices[PCI_DEVFN(pci_slot, 0)]);
+
+        trace_shpc_slot_command(
+            parent->canonical_path, pci_slot,
+            child ? child->canonical_path : "no-child",
+            shpc_led_state_to_str(old_power),
+            shpc_led_state_to_str(power),
+            shpc_led_state_to_str(old_attn),
+            shpc_led_state_to_str(attn),
+            shpc_slot_state_to_str(old_state),
+            shpc_slot_state_to_str(state));
+    }
+
     if (!shpc_slot_is_off(old_state, old_power, old_attn) &&
         shpc_slot_is_off(state, power, attn))
     {
diff --git a/hw/pci/trace-events b/hw/pci/trace-events
index 42430869ce..19643aa8c6 100644
--- a/hw/pci/trace-events
+++ b/hw/pci/trace-events
@@ -16,3 +16,9 @@ msix_write_config(char *name, bool enabled, bool masked) "dev %s enabled %d mask
 sriov_register_vfs(const char *name, int slot, int function, int num_vfs) "%s %02x:%x: creating %d vf devs"
 sriov_unregister_vfs(const char *name, int slot, int function, int num_vfs) "%s %02x:%x: Unregistering %d vf devs"
 sriov_config_write(const char *name, int slot, int fun, uint32_t offset, uint32_t val, uint32_t len) "%s %02x:%x: sriov offset 0x%x val 0x%x len %d"
+
+# pcie.c
+pcie_cap_slot_write_config(const char *parent, const char *child, const char *pds, const char *old_pic, const char *new_pic, const char *old_aic, const char *new_aic, const char *old_power, const char *new_power) "%s > %s: pds: %s, pic: %s->%s, aic: %s->%s, power: %s->%s"
+
+# shpc.c
+shpc_slot_command(const char *parent, int pci_slot, const char *child, const char *old_pic, const char *new_pic, const char *old_aic, const char *new_aic, const char *old_state, const char *new_state) "%s[%d] > %s: pic: %s->%s, aic: %s->%s, state: %s->%s"
-- 
2.34.1


