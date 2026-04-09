Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF2AF36B97
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 00:36:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAzqT-0005QF-Ou; Thu, 09 Apr 2026 20:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wAx1Y-00015p-9a
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 17:34:52 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wAx1W-0000pw-Aa
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 17:34:51 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so19742495e9.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 14:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minio.io; s=minio; t=1775770489; x=1776375289; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KvcC0OHWydsrQ65Aj+iaZfcTmw/zkBxH7csPVJaQ8y0=;
 b=QatAF1RC3P7XbbCf/17g5ry7yzICj0+hfLui0ZGiMp6PNDGQ7XqdVfu6Kqq0IJ40e1
 sbkd0DzOa1x3GCtbvTHiJeCqClrkgyi+i03yLmrC0bugnp7tco9hsc3v9WeglvPFOzFs
 2SsAfv98W9jnlD5J1vudhaipOg1/I+L+sDZ++RtbSZQcEcmU80kQ13cEaAufqAitpvbi
 wHSJtfkoypxT30MjdH1qgQ6SHUTr5fXNbMq0D6NmDTvJhDqabkJcUGsZYPGv+nmJ2s1M
 Qjme/mkxG9GaAKAOqOx2mRRp8FaTn9cka5kdqnCf2eadkE4TuGMu7b5dOHNBAqXOdQ0n
 jNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775770489; x=1776375289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KvcC0OHWydsrQ65Aj+iaZfcTmw/zkBxH7csPVJaQ8y0=;
 b=R0/o0iEgou6Yk8NoV8ehGsXAr09s/i1a1uLXRG2HiSl3omiSL10mtWVhL4E1iJ2wQq
 NW28wkPAigjPuJHjP7tD9Qfe4aj7ONAovBq+z19TVinLkb6J4XrN8d56KDTKLdFEkYJf
 mwd4xmLUP0IB4LpzEBXb2JR+0h89wk4NOQNGNGNpWMAhS3rCtMDktSrioYr/psAr+Xxs
 6FusbhOKbgwZgy4Kyq2YFfqI9us2LNlDEJJNHasGD5//S7MeVL/gLl5CdhkWObRthf6z
 9yrgbhla6Ry+02mk+DP3FTVK0kxDvMF0ZplKkTUkzE5ocQd0xe+KJu2JE2jA/YIzhRS0
 o0vA==
X-Gm-Message-State: AOJu0YzvjaIL26ISBkzESiXfn0OBbVAW5Gh4cZ2ouFHsxOau9mX7qr6f
 tMMjPbthFFNtvI/KXJYTm6cjaWdPJYXEBtahTEjTTDMF3y6RT4Dn37BTxZbmtYYyg8xQICyF64Q
 wd3q+8yDX5X4j0ZIb5chLOcbgQHRBnZKYSzkD8TADN3Jlj8SQKgf/+CajNGCZ809imnmA9xdIx2
 CGCfIHoNsU9FpU25ai1rWJq3yzEc8tEIp3gpLElCg=
X-Gm-Gg: AeBDievjomhkWnR6IGWh1KDBsWGPQqIlkfvHtb2qJQnPihDUe+3a+ncWfsyyeORaHlN
 cUNXkBPw5D7PAPFVIJz9MJlTHFln8ap3ztPA7kukK6+owtfG1uRHjZzslqCYW6i79D7qWAtWSMY
 cqMBBK5kPumg+sktUyq8cGesZoP+wcy2zZTRyFJeyvikegQwz7wt052R6QV/quEIjJlWSgpybL3
 SQafror70rDsN65eV41wkSF5nKI7mjup+Xz+ZifMCJhn3gmNO43CNdKGQsqBNOEQ3iDZYnChRo+
 Ho2afiDbQU89ZNla81Jhq+/sUzz4JpUrgiWpOaH5e4jEX7J91nA/J4wIwFGMrtPsmTACc7DzXJ1
 +EZXeqOIwmokznDZRxgHEE9BmLNJ4ohUaA6HovpJDIALWlJYcSnJXBHfcdiudqdII964l4L0TWT
 0hSylTxfeduknQFudIb5hmEUCLfaHF8HsCaEI6g4X4Me3BoEvpdZCOkhG8puXpYsZVP1SeSn5wR
 ncjBnzxEmEviFLrogfsl0tDyzevelko0ITujZogCmpaj9ZxEz1W17j0VgB2aw==
X-Received: by 2002:a05:600c:8b30:b0:488:b14f:b8ed with SMTP id
 5b1f17b1804b1-488d6657928mr5875225e9.0.1775770488168; 
 Thu, 09 Apr 2026 14:34:48 -0700 (PDT)
Received: from localhost (2a01cb001411480071f5d8bdb591a8f9.ipv6.abo.wanadoo.fr.
 [2a01:cb00:1411:4800:71f5:d8bd:b591:a8f9])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-488d5888acbsm25725115e9.1.2026.04.09.14.34.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 14:34:47 -0700 (PDT)
From: mr-083 <matthieu@minio.io>
X-Google-Original-From: mr-083 <matthieu@min.io>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: its@irrelevant.dk, kbusch@kernel.org, stefanha@redhat.com,
 mr-083 <matthieu@min.io>
Subject: [PATCH v2] hw/nvme: add namespace hotplug support
Date: Thu,  9 Apr 2026 23:34:51 +0200
Message-ID: <20260409213454.5186-1-matthieu@min.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260409060155.94704-1-matthieu@min.io>
References: <20260409060155.94704-1-matthieu@min.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=matthieu@minio.io; helo=mail-wm1-x334.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HK_NAME_MR_MRS=0.998,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 09 Apr 2026 20:35:35 -0400
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
namespace-level hot-swap without removing the NVMe controller, matching
the behavior of physical NVMe drives hot-swapped in the same PCIe slot.

Mark nvme-ns devices as hotpluggable and register the NvmeBus as a
hotplug handler with proper plug and unplug callbacks:

- plug: attach namespace to all started controllers and send an
  Asynchronous Event Notification (AEN) with NS_ATTR_CHANGED so
  the guest kernel rescans namespaces and adds the block device
- unplug: detach from all controllers, send AEN, remove from
  subsystem, then unrealize the device. The guest kernel rescans
  and removes the block device.

The plug handler skips controllers that haven't started yet
(qs_created == false) to avoid interfering with boot-time namespace
attachment in nvme_start_ctrl().

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
2.53.0


