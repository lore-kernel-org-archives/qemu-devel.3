Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E32F459EB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 15:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBDMs-00041K-9q; Fri, 10 Apr 2026 11:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wBCrt-0002Wi-FY
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 10:29:57 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wBCrr-0008Gq-F2
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 10:29:57 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43d02a71526so1301823f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 07:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minio.io; s=minio; t=1775831393; x=1776436193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ruMXow8DpCxyiShGLxBR3aEG16JIAkSYkotS72n+iGc=;
 b=M+ZuNuub6nBdX/KPhJz8dHy+xpMFZ9Iz2Iq4LjPTIUaAqdBYYEjVDf3SeqmKt+O2kk
 xTYabPIE2THct3wEKJ2BZZLCp6z6TaJuZHn0I5kgHinXCTdPLUir+nuxZLxzmCRGfzce
 3l8LzgwKesve1lHiaBpNp9RzKMFqGgl+hPyI4k/fm9i+lzb6oxzsKXGynnAjPd/i+Sev
 5fOcgJ9wVLylh7WBjtBTIiAcc3a3SMX0IVmiA0gWuWOkONunRT6piA8RcSClBY7mbv7v
 C6O4R3ejOr03P9fahBmy6H4vyQ4M7n+0qvc5N4PsXV9oytyoLRJ0+Q1tGzev4eJaPG13
 dKSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775831393; x=1776436193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ruMXow8DpCxyiShGLxBR3aEG16JIAkSYkotS72n+iGc=;
 b=iLsPJcJXeZHZz89e659pwQgJD94mzanSA0zPZF/L+Cmj+UdST9KowomHpZKNiDvUtd
 JDkJUeebOZqvb3nIavwx7wwQjXo2R6GEg0ZP3/ZTnDUqU+VwH2yV3bgVa93cBpuYaYyL
 ZezAgwGlvhZ6ISFSTUyYAqqH9UPF87SHUUX92IM2YYsrPTSn+A5X9Kqi8EjIoRJ/t8SB
 Ls1I+I3lLSN7u58lQgEQ+uN9h9MuE1dB4P3socyx5HNiKBdtkGdx0ESewhgI5rKE+e1B
 yI9naVLz9gK9A1IBaEDLWS0Wj/Fk+F1MaCO9QPWw3ApDGRFtgrThID/gGjFYFa7Ef8pL
 qazg==
X-Gm-Message-State: AOJu0YxZH41fJnva720F1aIUkQ85g3oF65JHWsfpUTF5qZRd9F+YDYKM
 Q0/OSAzlW1dsRI56FHHgZkEzxIcuKFGy3kS1KR0iEluoPxT4KaM5fuPlqIhtlR/Z/8XTFAN0w7Y
 r2I7NJt1y39iYF/3qv5OXp3gNH3+azRZcUh2BaDx/AdURBH3dplp7jlhQULKSAiIWYh/TceFqZk
 qXcbig8OGbbl8PUP8e1D5FIt1t4nwMsJzndKn5hLU=
X-Gm-Gg: AeBDieukLdm7wWGmth+pEu2g5rHdV6xdavUJAtwCxyYEofOAE0El5iXquQisMLPQZZr
 Kj5fRIwT5RkPclqwOxuM0iQqUrgBSGo009M90O+sjZisBpJflXlC1PXumWv1jcVUCcoS/iS16+x
 fWM8bwnrCkyOBOLCgNMtSLYiiU2QiCAc9P/Q7jeSfEqA3Wipq8eBAZPnT8XnePmQoQMn+gn+tnz
 LTQ3Eg+/r3wGcUWQs8D1nDtI3GsUXMABFXhHZDHHgVCKzTP1YmRnu6YC0f1f2tJLCiSwnBtqc9s
 wNAFcefVT4Bri8+t0zER9KHKMqgknhW2IfHytQJj5LQMXmLZYanJjYH+/oyKiP0DPsJr8GeIepE
 M39cpuJg1lxdOIhp4GS+XKBEL2qg6GOXCQjyRy+gw659yFA1rxTs06y35AAwFeg2u7c5B5quIPS
 c+F5Yk0ShdsZzfBwHAwqxM7b9a50RxnHIpJTeH6NJ4IK7oLRmbizbQpyvYguIasqgRzQ4ldMjb2
 Wp+2PqB4O6S8dQUDoXipE7VEcPbFPV5EQok6wVJBW76IHM+MRP243/fSwk60MJF+DIRoeRJ
X-Received: by 2002:a05:6000:2082:b0:439:c799:dbfa with SMTP id
 ffacd0b85a97d-43d6423cff9mr5186798f8f.9.1775831392747; 
 Fri, 10 Apr 2026 07:29:52 -0700 (PDT)
Received: from localhost (2a01cb001411480071f5d8bdb591a8f9.ipv6.abo.wanadoo.fr.
 [2a01:cb00:1411:4800:71f5:d8bd:b591:a8f9])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-43d63de2a74sm8382197f8f.3.2026.04.10.07.29.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2026 07:29:52 -0700 (PDT)
From: mr-083 <matthieu@minio.io>
X-Google-Original-From: mr-083 <matthieu@min.io>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: its@irrelevant.dk, kbusch@kernel.org, stefanha@redhat.com,
 mr-083 <matthieu@min.io>
Subject: [PATCH v3] hw/nvme: add namespace hotplug support
Date: Fri, 10 Apr 2026 16:30:00 +0200
Message-ID: <20260410143000.86708-1-matthieu@min.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409060155.94704-1-matthieu@min.io>
References: <20260409060155.94704-1-matthieu@min.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=matthieu@minio.io; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HK_NAME_MR_MRS=0.998,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Apr 2026 11:01:56 -0400
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
nvme_ns_unrealize() now clears that slot too — making the namespace
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
---
 hw/nvme/ctrl.c   | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/nvme/ns.c     |  8 +++++
 hw/nvme/subsys.c |  2 ++
 3 files changed, 98 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index be6c7028cb..2024b0ff75 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -206,6 +206,7 @@
 #include "system/hostmem.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pcie_sriov.h"
+#include "hw/core/qdev.h"
 #include "system/spdm-socket.h"
 #include "migration/vmstate.h"
 
@@ -9293,6 +9294,7 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     }
 
     qbus_init(&n->bus, sizeof(NvmeBus), TYPE_NVME_BUS, dev, dev->id);
+    qbus_set_bus_hotplug_handler(BUS(&n->bus));
 
     if (nvme_init_subsys(n, errp)) {
         return;
@@ -9553,10 +9555,96 @@ static const TypeInfo nvme_info = {
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
index b0106eaa5c..f4f755c6fc 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -719,10 +719,17 @@ void nvme_ns_cleanup(NvmeNamespace *ns)
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
@@ -937,6 +944,7 @@ static void nvme_ns_class_init(ObjectClass *oc, const void *data)
     dc->bus_type = TYPE_NVME_BUS;
     dc->realize = nvme_ns_realize;
     dc->unrealize = nvme_ns_unrealize;
+    dc->hotpluggable = true;
     device_class_set_props(dc, nvme_ns_props);
     dc->desc = "Virtual NVMe namespace";
 }
diff --git a/hw/nvme/subsys.c b/hw/nvme/subsys.c
index 777e1c620f..fa35055d3c 100644
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


