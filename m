Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9988C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgs3y-0002Ln-Pc; Mon, 06 Jul 2026 18:45:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wgs3w-0002J9-OU; Mon, 06 Jul 2026 18:45:16 -0400
Received: from fhigh-b8-smtp.messagingengine.com ([202.12.124.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wgs3u-0001M6-P5; Mon, 06 Jul 2026 18:45:16 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 6D7157A01DD;
 Mon,  6 Jul 2026 18:45:13 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Mon, 06 Jul 2026 18:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1783377913; x=1783464313; bh=qL09FDFC4S8bD4BCt3Gw8FmiytCd9pm/
 PII4UutUsRA=; b=Gx4xnGXin7DThpvDfKMkak7QTn8OVN/nEV+WJe6Y7JLpoANa
 QcwVOGBR45XVVIaRWj+94h9O7SRD//vOeC7LZXCX0rUUHr8sJy0X9szs0zf34aba
 mP3nTSHeVxxv46RvOU3GoM8GK4mdn55QkHthHhDbdKczov9foyZIXIAFBdPtJ8zR
 MFBCLVYf73wA8gisSiEtC8y2/bqQ2zZBWsrpRt+HpOPv9N/VONCyuRNVLP1nMjnC
 dNQLPznWTF11ysyWo9uZIMDJ2UnnNDXVpKsJeYcMFnkzGdj2ILXWdMEJv37p2j7R
 ieO3dX8tMz/mECLXulk5GxHqAzdNhnqjR7CRGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783377913; x=
 1783464313; bh=qL09FDFC4S8bD4BCt3Gw8FmiytCd9pm/PII4UutUsRA=; b=K
 etj4/p6sJ9ECz8eXHPGaJKdueNgCvWJp14qXqkjXHVvl8YSVb0bcFk2xpz+W9LRn
 KRBhBGI0G4XD9GFVdCPiRFCSX235t7Dp0iRHN8Z9K9KuYJ+5H2ytmsT3dOSICg0M
 S/c6nxbeqHsrmZLwIOU7OzY2CF9bVSJxESIpnpozQ9GGkvyvrjjiFnMUI3Sk6gH1
 tzqrsr0l/99kFa+VVDicVoz+QXpUPUjqEK6FqPv4lUHRH/bNMR15N/zyiO0FZt3u
 p0jz0qhAmVGxBYCzqtc4aR5FNG1ieoMUVkv9j4ceESkzrBuDi9+/jOoHBi2iSZlk
 kJw+jQrh+nr/ew0ahuUSw==
X-ME-Sender: <xms:-C9MaqVtsHfdJK2lmxqutFRqwS60SlMoMygj7qYAKixVqb1eH2VjGA>
 <xme:-C9ManCjXrRlJnNXxg9qtFkCUWjoNaSjie52B1quLRc8II66Dx7zqK5347JxR84EP
 dj7oeqlgHJoYR91hwj5OVAKuuKDo_bXQ-5rydY05z1glvRAACfKKw4>
X-ME-Received: <xmr:-C9MavEyaWf-Ztd8hX1TeRktADiHIdctF7emQhq4eJAcPtjTZGgGIoQRiwVVEyCDcHBUPHiU8kAfi20-mCdKGr_TldE0R9CQ_1PDnWw0g6R2HUphF0evKG7fsw>
X-ME-Proxy-Cause: dmFkZTFB4Z9PN2gccqOQjjy99tDjdmrkGuGJ4bO0W0ziegtQyHR2uJh95CeZYSnvCtmel7
 knQ8BsVUQHaVS4ufmchfCIWK2cmGgh3P8fMGdRFBdVZLDClEBjRBqFu3E1S0x7vizfNsUg
 cx9CJKSADgLKVf3c0u5NxJEIEJTwlv4XFDNoE8t/zlA26XQUNkWpGCFvVUNUZ05goD7zpX
 9j6hGDlOBBgO77WH4VJzhogwIT3i80YnbdQWtedJentL5fTUCSf7yfysxyeIysp0Fa439n
 W/fWR9Hh4He4FbCnoboeF6+kKjmYzoGy+fFf1xgJxncBs1PYl3CXL5ZWFzimjbgJmQxBSS
 x561W7VWBtG/9/GDsY5xjI8HweAdThpr8u6cNW2iISqh0nd5Eewo8amsnIByboIRVReMJK
 BUD5R5gDkIz+yjEtDoPU3kfLDGi90EyZ7pM94gOWbVUoTH9CBxrAVx2tWKHWPij+oq1Szh
 s4K9JzClxBdbM4nxmvjLvgfnC5DXrqgvtWjyYHOsKE9uho+MnSuuaDWhUO7pim1BZ6SYdP
 Ef9jaEUXeeIqfcyACiMxNyQ5PY8X7g00Kk6K/TOB+eqyyfpFWV2i0pE+z7BagkKELn26SY
 X2NyiaC3+OghUv+RcsvypUZoSrvvu57pJkmHvSZIzCJgRNWn/4vFPUVWPGaw
X-ME-Proxy: <xmx:-C9Mao4dh_dDiA7o8IuYxaj8C48IUtW1q2oxrdS8tae4Z1gsG_vLxg>
 <xmx:-S9Mallio58QdED7DCPJ6cdABML6pAaZNlD0pIdlIu0wQyLcbp2Jyw>
 <xmx:-S9Maj7XbctHs-a4O2qJL2nBUAk8ISJR7IeWPKtFtIaSrRh19fmImg>
 <xmx:-S9MamQxbNpztLCFqfsVuu57kA9LymtlYHX-OTNI5Yz06faQ7q-FnQ>
 <xmx:-S9MavqwbTKLBcph5V-GoxLGt4AsipL3YS4c0-iwUDvr09NsCX-RhrhY>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 18:45:11 -0400 (EDT)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, mr-083 <matthieu@minio.io>,
 Matthieu <matthieu@min.io>, Stefan Hajnoczi <stefanha@redhat.com>,
 Klaus Jensen <k.jensen@samsung.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org
Subject: [PULL 11/11] hw/nvme: add namespace hotplug support
Date: Tue,  7 Jul 2026 00:44:23 +0200
Message-ID: <20260706224426.14156-12-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706224426.14156-1-its@irrelevant.dk>
References: <20260706224426.14156-1-its@irrelevant.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.159; envelope-from=its@irrelevant.dk;
 helo=fhigh-b8-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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

From: mr-083 <matthieu@minio.io>

Add hotplug support for nvme-ns devices on the NvmeBus. This enables
NVMe namespace-level hot-add and hot-remove via device_add and
device_del with proper Asynchronous Event Notification (AEN), so the
guest kernel can react to namespace topology changes.

Mark nvme-ns devices as hotpluggable and register the NvmeBus as a
hotplug handler with proper plug and unplug callbacks:

- plug: attach namespace to all started controllers and send an
  Asynchronous Event Notification (AEN) with NS_ATTR_CHANGED so
  the guest kernel rescans namespaces and adds the block device
- unplug: drain in-flight I/O, detach from all controllers, send
  AEN, then unrealize the device. The guest kernel rescans and
  removes the block device.

The plug handler skips controllers that haven't started yet
(qs_created == false) to avoid interfering with boot-time namespace
attachment in nvme_start_ctrl().

The unplug handler drains in-flight I/O via nvme_ns_drain() before
detaching the namespace from controllers, so pending requests can
complete normally without touching freed state.

For symmetry with nvme_ns_realize() which sets subsys->namespaces[nsid],
nvme_ns_unrealize() now clears that slot too making the namespace
lifecycle complete.

Both the controller bus and subsystem bus are configured as hotplug
handlers via qbus_set_bus_hotplug_handler() since nvme-ns devices
may reparent to the subsystem bus during realize.

Example hot-swap sequence using the NVMe subsystem model:

  # Boot with: -device nvme-subsys,id=subsys0
  #            -device nvme,id=ctrl0,subsys=subsys0
  #            -device nvme-ns,id=ns0,drive=drv0,bus=ctrl0,nsid=1

  device_del ns0             # guest receives AEN, removes /dev/nvme0n1
  drive_del drv0
  drive_add 0 file=disk.qcow2,format=qcow2,id=drv0,if=none
  device_add nvme-ns,id=ns0,drive=drv0,bus=ctrl0,nsid=1
                              # guest receives AEN, adds /dev/nvme0n1

Tested with Linux 6.1 guest (NVMe driver processes AEN and rescans
namespace list automatically).

Signed-off-by: Matthieu <matthieu@min.io>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c   | 87 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/nvme/ns.c     |  8 +++++
 hw/nvme/subsys.c |  2 ++
 3 files changed, 97 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 1fa3a24f7635..a67e1598891c 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -9634,6 +9634,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     }
 
     qbus_init(&n->bus, sizeof(NvmeBus), TYPE_NVME_BUS, dev, dev->id);
+    qbus_set_bus_hotplug_handler(BUS(&n->bus));
 
     if (nvme_init_subsys(n, errp)) {
         return;
@@ -10571,10 +10572,96 @@ static const TypeInfo nvme_info = {
     },
 };
 
+static void nvme_ns_hot_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                              Error **errp)
+{
+    NvmeNamespace *ns = NVME_NS(dev);
+    NvmeSubsystem *subsys = ns->subsys;
+    uint32_t nsid = ns->params.nsid;
+    int i;
+
+    /*
+     * Attach to all started controllers and notify via AEN.
+     * Skip controllers that haven't started yet (boot-time realize) —
+     * nvme_start_ctrl() will attach namespaces during controller init.
+     */
+    for (i = 0; i < NVME_MAX_CONTROLLERS; i++) {
+        NvmeCtrl *ctrl = nvme_subsys_ctrl(subsys, i);
+        if (!ctrl || !ctrl->qs_created) {
+            continue;
+        }
+
+        if (nvme_csi_supported(ctrl, ns->csi) && !ns->params.detached) {
+            nvme_attach_ns(ctrl, ns);
+            nvme_update_dsm_limits(ctrl, ns);
+
+            if (!test_and_set_bit(nsid, ctrl->changed_nsids)) {
+                nvme_enqueue_event(ctrl, NVME_AER_TYPE_NOTICE,
+                                   NVME_AER_INFO_NOTICE_NS_ATTR_CHANGED,
+                                   NVME_LOG_CHANGED_NSLIST);
+            }
+        }
+    }
+}
+
+static void nvme_ns_hot_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
+                               Error **errp)
+{
+    NvmeNamespace *ns = NVME_NS(dev);
+    NvmeSubsystem *subsys = ns->subsys;
+    uint32_t nsid = ns->params.nsid;
+    int i;
+
+    /*
+     * Drain in-flight I/O before tearing down the namespace.
+     * This must happen while the namespace is still attached to the
+     * controllers so any pending requests can complete normally.
+     */
+    nvme_ns_drain(ns);
+
+    /*
+     * Detach from all controllers and notify the guest via AEN.
+     * The guest kernel will rescan namespaces and remove the block device.
+     */
+    for (i = 0; i < NVME_MAX_CONTROLLERS; i++) {
+        NvmeCtrl *ctrl = nvme_subsys_ctrl(subsys, i);
+        if (!ctrl || !nvme_ns(ctrl, nsid)) {
+            continue;
+        }
+
+        nvme_detach_ns(ctrl, ns);
+        nvme_update_dsm_limits(ctrl, NULL);
+
+        if (!test_and_set_bit(nsid, ctrl->changed_nsids)) {
+            nvme_enqueue_event(ctrl, NVME_AER_TYPE_NOTICE,
+                               NVME_AER_INFO_NOTICE_NS_ATTR_CHANGED,
+                               NVME_LOG_CHANGED_NSLIST);
+        }
+    }
+
+    /*
+     * Unrealize: removes from subsystem (in nvme_ns_unrealize), flushes,
+     * cleans up structures, and removes from QOM.
+     */
+    qdev_unrealize(dev);
+}
+
+static void nvme_bus_class_init(ObjectClass *klass, const void *data)
+{
+    HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
+    hc->plug = nvme_ns_hot_plug;
+    hc->unplug = nvme_ns_hot_unplug;
+}
+
 static const TypeInfo nvme_bus_info = {
     .name = TYPE_NVME_BUS,
     .parent = TYPE_BUS,
     .instance_size = sizeof(NvmeBus),
+    .class_init = nvme_bus_class_init,
+    .interfaces = (const InterfaceInfo[]) {
+        { TYPE_HOTPLUG_HANDLER },
+        { }
+    },
 };
 
 static void nvme_register_types(void)
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 4caab590977f..7f0f9ac7662c 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -720,10 +720,17 @@ void nvme_ns_cleanup(NvmeNamespace *ns)
 static void nvme_ns_unrealize(DeviceState *dev)
 {
     NvmeNamespace *ns = NVME_NS(dev);
+    NvmeSubsystem *subsys = ns->subsys;
+    uint32_t nsid = ns->params.nsid;
 
     nvme_ns_drain(ns);
     nvme_ns_shutdown(ns);
     nvme_ns_cleanup(ns);
+
+    /* Symmetric with nvme_ns_realize() which sets subsys->namespaces[nsid]. */
+    if (subsys && nsid && subsys->namespaces[nsid] == ns) {
+        subsys->namespaces[nsid] = NULL;
+    }
 }
 
 void nvme_ns_atomic_configure_boundary(bool dn, uint16_t nabsn,
@@ -1100,6 +1107,7 @@ static void nvme_ns_class_init(ObjectClass *oc, const void *data)
     dc->bus_type = TYPE_NVME_BUS;
     dc->realize = nvme_ns_realize;
     dc->unrealize = nvme_ns_unrealize;
+    dc->hotpluggable = true;
     dc->vmsd = &nvme_vmstate_ns;
     device_class_set_props(dc, nvme_ns_props);
     dc->desc = "Virtual NVMe namespace";
diff --git a/hw/nvme/subsys.c b/hw/nvme/subsys.c
index 777e1c620fd0..fa35055d3c1e 100644
--- a/hw/nvme/subsys.c
+++ b/hw/nvme/subsys.c
@@ -9,6 +9,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "hw/core/qdev.h"
 
 #include "nvme.h"
 
@@ -205,6 +206,7 @@ static void nvme_subsys_realize(DeviceState *dev, Error **errp)
     NvmeSubsystem *subsys = NVME_SUBSYS(dev);
 
     qbus_init(&subsys->bus, sizeof(NvmeBus), TYPE_NVME_BUS, dev, dev->id);
+    qbus_set_bus_hotplug_handler(BUS(&subsys->bus));
 
     nvme_subsys_setup(subsys, errp);
 }
-- 
2.53.0


