Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD10E9DE62
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2026 08:20:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAkbf-0006Lx-TB; Thu, 09 Apr 2026 04:19:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wAiSi-0005mo-Mh
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 02:01:56 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wAiSg-0006ph-Vt
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 02:01:56 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43d17bb1c65so239259f8f.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 23:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minio.io; s=minio; t=1775714513; x=1776319313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ef/IDwXK0GaH8OkKz0gZMKyBYmbEr0v7UmTk+WfXTa0=;
 b=QKEfJjZkxx9zjFv1mwhg0rTFwC4kiecz3v7DdoR7FRlUx2bPnTLNwY9zorxfVb1prg
 x+5bYjrWFMBxUx4aLvy0js33P3QFfMGzodYMqGwhiMR90c5Q/xtAWxlPWHimGW3RlaZr
 cDadRtt8bySzPlS1MNGkS58SMVFjnziHi9TQmyxaGZB/uaZqIc6ucx2M+PN1aFbzvbLv
 TyVSUNmiUk5dV445yr4LUIMdy9a84EumzI1yHm4gRH56kHwfDUlY7uatl7m3qcXZ/gRv
 A1FnHMaZI625B7hApFywl5YWaRKLmuSM238rX25Ye70agSUaH1/4qhhp0X9JJgIG/DVx
 eEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775714513; x=1776319313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ef/IDwXK0GaH8OkKz0gZMKyBYmbEr0v7UmTk+WfXTa0=;
 b=T1p/hSMxzNGHSABr7RUQorG/zrnuEXiCF6Wi/pwe9z4a0Vuqh3d5J4i0W+xNzoTQzK
 QUiHFmvsHi862OcVxtbfbQFK+au1TaioO879mQNvE8IXH9SIxlJg6RQKJT/AwT3gGpk1
 SyifkHrs06TM+rL5SnHKq5BD0ck9B5FvZ2NwK71/oPzlLh+DExVmfArj6JSqo5bA9wJz
 CkoWZbIooVptzRnmwBJ+WC/VouqopDERo/iopuZ62K3d76wTokaZNu2HJ+23gkwRCC1+
 WrsFhtjWNjoNDfMNCS68xYJzRVee7BACMsVUIY1g9ga1QTMI8bW6GI27EB6milTsyjr+
 0itQ==
X-Gm-Message-State: AOJu0YwU5USTYY6/lRi7AYads4nm7PJAo/oV9yKs/t/07URmaHpHcqY3
 Vi5GhpEhD6zl0sYfgor5+xpLSXyTJAB7dhiOjlCGdswmqWVpUhwHxfFGn438heSAvaOO7IqOLF5
 DLwdWnwbeOa4lJh/WAq+6D/FztuBrzQ5yUybEByLbkts3dXpIJN+c3ZB1L9HHrjivxphF58c1lT
 e/HbDDdgwkqUo5QJKmZfhkJsxyVRLH0QO51NQkjkg=
X-Gm-Gg: AeBDieuZvzLucpQPifSuuhRPhHGAR26GtYpc7KedrZ9AKpEjuyG4OpJK+9SNsQoAEr5
 9XR54fPLRe1bohQ0FOUSesd0PfNC3TO617c6RJrcpZi1+759y5XXqy8dTiXVaF2XrNNryezbmGK
 /VNlbSdbBC3Ek5zQv3PMB7MnvmXrYsdsp6L/leg50qAn9zEgJIv3MweGkEU2qJqNvO/IZkkbLpV
 Y30i6h8Uud465+I3TLD5f1Eyb1gJYr6tzSifDN3Mp9KsRTv7/8Lieuni95qPFqMHPoLB5ZkeOfT
 2JjqWjlGz0Cw6MlvD1BOCVmR/ZowbWxNuem29otHvQeacb1BhstAr3Q+2MQFnYfYDnht7vyL8sS
 Qk/rYQ3q2bUGbfMeeeFhSckPgpuT7aDAXncm9afZg+4g05WwHpKBD7ZXMPMJ2qhWaygx7ujXOkf
 SRsGwPeOzQCRXt/u0mxQ4MJJ/878M6Sq//MiJ40lca5sWWluBJd24iqQ4nd9OOHNBeeLE6a+1iS
 c6X4t2Pz0IOhfQ93Ye1xKudWNgKS507A0nMr1phh7mDMNNYYFhjUThdqNbi7Q==
X-Received: by 2002:a5d:5847:0:b0:43c:f8b4:e58 with SMTP id
 ffacd0b85a97d-43d292e2a9emr36065425f8f.41.1775714513163; 
 Wed, 08 Apr 2026 23:01:53 -0700 (PDT)
Received: from localhost (2a01cb00141148004df9ec80d3fa1cac.ipv6.abo.wanadoo.fr.
 [2a01:cb00:1411:4800:4df9:ec80:d3fa:1cac])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-43d1e4e5890sm62750308f8f.31.2026.04.08.23.01.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 23:01:52 -0700 (PDT)
From: mr-083 <matthieu@minio.io>
X-Google-Original-From: mr-083 <matthieu@min.io>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: its@irrelevant.dk, kbusch@kernel.org, stefanha@redhat.com,
 mr-083 <matthieu@min.io>
Subject: [PATCH 1/2] hw/nvme: add namespace hotplug support
Date: Thu,  9 Apr 2026 08:01:53 +0200
Message-ID: <20260409060155.94704-2-matthieu@min.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409060155.94704-1-matthieu@min.io>
References: <20260409060155.94704-1-matthieu@min.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=matthieu@minio.io; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HK_NAME_MR_MRS=0.998,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 09 Apr 2026 04:19:18 -0400
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
namespace-level hot-swap without removing the NVMe controller, which
is how physical NVMe drives behave when hot-swapped in the same PCIe
slot.

Mark nvme-ns devices as hotpluggable and register the NvmeBus as a
hotplug handler with proper plug and unplug callbacks:

- plug: attach namespace to all started controllers and send an
  Asynchronous Event Notification (AEN) with NS_ATTR_CHANGED so
  the guest kernel rescans namespaces
- unplug: detach from all controllers, send AEN, remove from
  subsystem, then unrealize the device

The plug handler skips controllers that haven't started yet
(qs_created == false) to avoid interfering with boot-time namespace
attachment in nvme_start_ctrl().

Both the controller bus and subsystem bus are configured as hotplug
handlers via qbus_set_bus_hotplug_handler() since nvme-ns devices
may reparent to the subsystem bus during realize.

Signed-off-by: Matthieu Receveur <matthieu@min.io>
---
 hw/nvme/ctrl.c   | 85 ++++++++++++++++++++++++++++++++++++++++++++++++
 hw/nvme/ns.c     |  1 +
 hw/nvme/subsys.c |  2 ++
 3 files changed, 88 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index be6c7028cb..5502e4ea2b 100644
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
@@ -9553,10 +9555,93 @@ static const TypeInfo nvme_info = {
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
+     * Detach from all controllers and notify the guest via AEN.
+     * Must happen before unrealize to avoid use-after-free when the
+     * guest sends I/O to a freed namespace.
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
+    /* Remove from subsystem namespace list. */
+    subsys->namespaces[nsid] = NULL;
+
+    /*
+     * Unrealize: drain I/O, flush, cleanup structures, remove from QOM.
+     * nvme_ns_unrealize() handles drain/shutdown/cleanup internally.
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
index b0106eaa5c..eb628c0734 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -937,6 +937,7 @@ static void nvme_ns_class_init(ObjectClass *oc, const void *data)
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
2.50.1 (Apple Git-155)


