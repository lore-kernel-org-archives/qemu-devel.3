Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87473C982C7
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:02:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6VbH-0007jo-Fu; Tue, 15 Sep 2026 12:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6VbG-0007iC-05
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:38 -0400
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6VbC-0003Ol-CD
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:01:37 -0400
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c2940ef15d3so507843866b.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789488083; x=1790092883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t2kCTfMt9la3+TqyiXvTwsH4ffyBtacDVRw82Er1W/0=;
 b=X2SmBxlq84MJXfxmiH1ex4YNWwe8jmoxgRh0/DJJJAIVAxwHhwLtNNH+oKvi9WiokU
 sv1VLF2MmTmE5bwZxnmh4Z/oGCZ1nljdidjAhEr7rAlENY8lgMc/w0CfXRbRvK5nen9V
 G6fkJZDLNlpiDd1r5Fh4G+fmIUxX4G7japNiIiHtQ78G4JJIWHDeMx8pDf1BQN16L7AM
 51zugE5QOzsVu9qt9X0SqkrYnn13nA+YW4bQWH98t/p/EgwYFXGHJixLHnhwQFsCiASw
 EkUzc8BtVPM4K76p4WN0lqCFlBYeYhsAprVVnDIinDIDpys/piw1RQV4JirmRuifoODB
 gpnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789488083; x=1790092883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=t2kCTfMt9la3+TqyiXvTwsH4ffyBtacDVRw82Er1W/0=;
 b=SoHGR4nzVoMMQAc5+VeY5HGd+abMhVnSbcBLtOBChTjNHGj3rNFF7aVZ8ixcEYH00F
 jHyVTfNvTQvEdSpAe9r1XtQMIta20OGanfQ3nZ+j8jaAFrqMRWD50yshQ9N9nhUDvf+p
 OQVTMOox6IBPcRBBYTDjO77HeDWr+ZwgDzWYWsO+zsNfvxglnAdxZEtR5Dr3r63wVW7v
 bFyO21F2IaqHqwVz1OjhfIXNxN0+akwwxG48uEDhp6xve4d979zGG63URegqCggpHNX0
 G4CfqzBnbgXTJDIeO9o0C1OANdwJ7owx3yhYJG4RIFnVzPBdEAvvSvPd73q4rukwo54s
 D1LA==
X-Gm-Message-State: AFuF++m7PK7pECtWEUyTare/3/sq0RWZvOtnPUSvXe483fg5pTy6ox2H
 pvq+wbC2liIS/wkhuWpuhs8jMwbnTHnsxFIMaS1KVE439ia8hfSOGTlMzSwywQ==
X-Gm-Gg: AYBFou0FlTrKPoXVK2CqW2ROEhJ6/5JfeXWKWB/7B9QGm8ZGx3Ic/4AtqCyLjgU44pa
 Hsy41iXAL+2PWsSWM2mZfDlJahnVkfklUROfvToWFY5G2W9sG3mSaMyMd6yKUibFOV0Cd+RJHyR
 duo3LMxYq2/o529twWRKS0Iug715emZKhDGrIKx5LJbfI4B4WTg1LOwYb3xVWYCsU8TdhTckZyu
 cNxU2vj51a1he69IEnF0L5A2bSGhLvx4UJH9c+Wj1pLKi0Xx5lJmB+i3IvLYnq5NTOza1wTPxqP
 suPRv0CuC3wbnHj6/PrKR1gNvgQdVbTQh8j0qsu9K/PONz+iE1nbSF/W4JAijwIZfK+jRTxMV5f
 MQNTb1PQXxygTUXOwrDnY1rcTNrQYsWRaw+AMYGoCaHuImEaP/JrowuX+Bj9gHX4qawRaWY+Qtn
 q4XPHSUuvQcLDRzqCjK4q1JlOnZ2eHhi6F/VQ/Za2XLFTldrOuCfY+pAF6Rcau31sXK3ra1UYOg
 8YYMquKtS7DPcmflih3ynfmQCw2lB/RkZc30bCv8Qxr9g==
X-Received: by 2002:a17:907:9623:b0:c29:37d7:75c0 with SMTP id
 a640c23a62f3a-c29b839a04cmr1104060666b.1.1789488082383; 
 Tue, 15 Sep 2026 09:01:22 -0700 (PDT)
Received: from thinkpad-t470s.. (83-131-196-251.adsl.net.t-com.hr.
 [83.131.196.251]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-c29ddd86344sm3235866b.0.2026.09.15.09.01.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:01:21 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 peter.maydell@linaro.org, francisco.iglesias@amd.com,
 edgar.iglesias@gmail.com, berrange@redhat.com, eugene@nuvacore.ai,
 Ruslan_Ruslichenko@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v2 06/20] hw/core: Add Remote Port object skeleton
Date: Tue, 15 Sep 2026 18:00:30 +0200
Message-ID: <20260915160044.345788-7-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915160044.345788-1-ruslichenko.r@gmail.com>
References: <20260915160044.345788-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:34::10;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej2-x10.google.com
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Introduce the QOM skeleton for the Remote Port subsystem.
This patch adds main types required for co-simulation:

- remote-port: An object that manages the lifecycle of the
co-simulation session and handles the character device
backend.

- remote-port-device: An interface that allows other QEMU
devices to be connected to the Remote Port.

This infrastructure enables QEMU to be linked with external
simulators (e.g. SystemC).

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/remote-port.c         | 151 ++++++++++++++++++++++++++++++++++
 include/hw/core/remote-port.h |  76 +++++++++++++++++
 2 files changed, 227 insertions(+)
 create mode 100644 hw/core/remote-port.c
 create mode 100644 include/hw/core/remote-port.h

diff --git a/hw/core/remote-port.c b/hw/core/remote-port.c
new file mode 100644
index 0000000000..6b40dca52d
--- /dev/null
+++ b/hw/core/remote-port.c
@@ -0,0 +1,151 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * QEMU remote attach
+ *
+ * Copyright (c) 2013 Xilinx Inc
+ * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
+ *
+ * This code is licensed under the GNU GPL.
+ */
+
+#include "qemu/osdep.h"
+#include "system/system.h"
+#include "chardev/char.h"
+#include "system/cpus.h"
+#include "system/cpu-timers.h"
+#include "system/reset.h"
+#include "hw/core/sysbus.h"
+#include "hw/core/hw-error.h"
+#include "qemu/thread.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+#include "qemu/error-report.h"
+#include "migration/vmstate.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-properties-system.h"
+#include "qemu/cutils.h"
+
+#include "hw/core/remote-port-proto.h"
+#include "hw/core/remote-port.h"
+
+#define REMOTE_PORT_CLASS(klass)    \
+     OBJECT_CLASS_CHECK(RemotePortClass, (klass), TYPE_REMOTE_PORT)
+
+static void rp_reset(DeviceState *dev)
+{
+    RemotePort *s = REMOTE_PORT(dev);
+
+    if (s->reset_done) {
+        return;
+    }
+
+    s->reset_done = true;
+}
+
+static void rp_realize(DeviceState *dev, Error **errp)
+{
+    RemotePort *s = REMOTE_PORT(dev);
+    Chardev *chr = NULL;
+
+    s->prefix = object_get_canonical_path(OBJECT(dev));
+
+    if (s->chrdev_id) {
+        chr = qemu_chr_find(s->chrdev_id);
+    }
+
+    if (!chr) {
+        error_setg(errp, "Unable to connect to remote-port channel");
+        return;
+    }
+
+    if (!qemu_chr_fe_init(&s->chr, chr, errp)) {
+        return;
+    }
+
+    s->chrdev = chr;
+
+
+}
+
+static void rp_unrealize(DeviceState *dev)
+{
+    RemotePort *s = REMOTE_PORT(dev);
+
+    s->finalizing = true;
+
+    info_report("%s: Wait for remote-port to disconnect", s->prefix);
+    qemu_chr_fe_disconnect(&s->chr);
+    qemu_chr_fe_deinit(&s->chr, false);
+
+    object_unparent(OBJECT(s->chrdev));
+}
+
+static const VMStateDescription vmstate_rp = {
+    .name = TYPE_REMOTE_PORT,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
+static Property rp_properties[] = {
+    DEFINE_PROP_STRING("chrdev-id", RemotePort, chrdev_id),
+};
+
+static void rp_prop_allow_set_link(const Object *obj, const char *name,
+                                   Object *val, Error **errp)
+{
+}
+
+static void rp_init(Object *obj)
+{
+    RemotePort *s = REMOTE_PORT(obj);
+    int i;
+
+    for (i = 0; i < REMOTE_PORT_MAX_DEVS; ++i) {
+        char *name = g_strdup_printf("remote-port-dev%d", i);
+        object_property_add_link(obj, name, TYPE_REMOTE_PORT_DEVICE,
+                             (Object **)&s->devs[i],
+                             rp_prop_allow_set_link,
+                             OBJ_PROP_LINK_STRONG);
+        g_free(name);
+    }
+}
+
+static void rp_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->legacy_reset = rp_reset;
+    dc->realize = rp_realize;
+    dc->unrealize = rp_unrealize;
+    dc->vmsd = &vmstate_rp;
+    device_class_set_props_n(dc, rp_properties, ARRAY_SIZE(rp_properties));
+}
+
+static const TypeInfo rp_info = {
+    .name          = TYPE_REMOTE_PORT,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(RemotePort),
+    .instance_init = rp_init,
+    .class_init    = rp_class_init,
+    .interfaces    = (InterfaceInfo[]) {
+        { },
+    },
+};
+
+static const TypeInfo rp_device_info = {
+    .name          = TYPE_REMOTE_PORT_DEVICE,
+    .parent        = TYPE_INTERFACE,
+    .class_size    = sizeof(RemotePortDeviceClass),
+};
+
+static void rp_register_types(void)
+{
+    type_register_static(&rp_info);
+    type_register_static(&rp_device_info);
+}
+
+type_init(rp_register_types)
diff --git a/include/hw/core/remote-port.h b/include/hw/core/remote-port.h
new file mode 100644
index 0000000000..dde54a40d9
--- /dev/null
+++ b/include/hw/core/remote-port.h
@@ -0,0 +1,76 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * QEMU remote port.
+ *
+ * Copyright (c) 2013 Xilinx Inc
+ * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
+ *
+ * This code is licensed under the GNU GPL.
+ */
+#ifndef REMOTE_PORT_H__
+#define REMOTE_PORT_H__
+
+#include <stdbool.h>
+#include "hw/core/remote-port-proto.h"
+#include "chardev/char.h"
+#include "chardev/char-fe.h"
+#include "qobject/qdict.h"
+
+#define TYPE_REMOTE_PORT_DEVICE "remote-port-device"
+
+#define REMOTE_PORT_DEVICE_CLASS(klass) \
+     OBJECT_CLASS_CHECK(RemotePortDeviceClass, (klass), TYPE_REMOTE_PORT_DEVICE)
+#define REMOTE_PORT_DEVICE_GET_CLASS(obj) \
+    OBJECT_GET_CLASS(RemotePortDeviceClass, (obj), TYPE_REMOTE_PORT_DEVICE)
+#define REMOTE_PORT_DEVICE(obj) \
+     INTERFACE_CHECK(RemotePortDevice, (obj), TYPE_REMOTE_PORT_DEVICE)
+
+typedef struct RemotePort RemotePort;
+
+typedef struct RemotePortDevice {
+    /*< private >*/
+    Object parent_obj;
+} RemotePortDevice;
+
+typedef struct RemotePortDeviceClass {
+    /*< private >*/
+    InterfaceClass parent_class;
+
+    /*< public >*/
+    /**
+     * ops - operations to perform when remote port packets are recieved for
+     * this device. Function N will be called for a remote port packet with
+     * cmd == N in the header.
+     *
+     * @obj - Remote port device to recieve packet
+     * @pkt - remote port packets
+     */
+
+    void (*ops[RP_CMD_max + 1])(RemotePortDevice *obj, struct rp_pkt *pkt);
+
+} RemotePortDeviceClass;
+
+#define TYPE_REMOTE_PORT "remote-port"
+#define REMOTE_PORT(obj) OBJECT_CHECK(RemotePort, (obj), TYPE_REMOTE_PORT)
+
+struct RemotePort {
+    DeviceState parent;
+
+    Chardev *chrdev;
+    CharFrontend chr;
+    bool finalizing;
+
+    char *chrdev_id;
+
+    const char *prefix;
+    const char *remote_prefix;
+
+    uint32_t current_id;
+    bool reset_done;
+
+#define REMOTE_PORT_MAX_DEVS 1024
+    RemotePortDevice *devs[REMOTE_PORT_MAX_DEVS];
+};
+
+#endif
-- 
2.43.0


