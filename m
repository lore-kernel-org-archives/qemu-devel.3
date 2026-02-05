Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E52ECD99C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5Vd-0006v8-I2; Thu, 05 Feb 2026 14:59:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5VZ-0006sR-6o
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:21 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5VW-00039T-Qv
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:20 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso20143135e9.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 11:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770321555; x=1770926355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uFKD2gCbF2L2yObzjuIkLcm5lMIH03Mpqiwzu3nD9ZU=;
 b=FlvYscnu7klN4jf9BVzu8sOHXQHQ4cht6Tb9J0M/HVpl7MTN7pcwtmHeG1K53yRLvj
 jTvQ0vXIW/hwi0hKcnX8HFCEJdWmkmgAjn5LJJwYmLfr4pAL0ojXhC1yHbswEiL0Qf6N
 HJ5fZfKqKSKhZ8OULwBDIPwnjbtnpnLzWVp21MyaiZ0Mh7qqIbmlOV36yLThCgpcV2YJ
 CuNkfJ56qRzV3Zjg8KPsvaVKXwIuDxugErzP1k9zK/Xp3uuNNIhRayNYqt/mMjys29Nq
 GrBP3sE7fLQDUV9liUd/MuZRJ2mrKE2eP6t744rlfEpH0pYJDhbDPR/Ow92dXO7bO1F0
 ZaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770321555; x=1770926355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uFKD2gCbF2L2yObzjuIkLcm5lMIH03Mpqiwzu3nD9ZU=;
 b=Vdlqkrl+R3BqsKi91Jjfa7EUz0aZCLjhLWpz+qUih5W3f1nDt9FUjhnVmL/6aSwyvI
 PGOYslqEycRQwxlv6AC/V8koZmOO1fiuXoo0Lj5OzBGobnFdjnsjqdrnMHQ7iWAaRXcv
 4DBHhgkoo1GERjH6UUVhAzedUALZq4ATr7S8+M69/WsTgIa+dMBg6vHFAkTVMcjmXVnf
 4wHDUnscs92TFmQ9gPnr3YKV9w8LUmrqhYnfILkeCBYrIyWy90zo60eDowaNIVLZqm9g
 OJR3Vfqq445sVki8Jjpl3cE4Ymh9BwS1jSfEZwB2efBFoGqb0hIJBQKZ6tbrs54qeJHG
 VLQg==
X-Gm-Message-State: AOJu0YzmjPu5qI4BGB93PQooWB4eIDrwG6IxdgWwWtpM45+rHZiUA2AB
 D7Gp6bdGorx7PkbIVxFjqeSzX9tEvTNuM2+VbuaYG61Opp1Yt/PdschZhOB/vnO6XvM=
X-Gm-Gg: AZuq6aI/4r5B8UG9VU5YvxqXaAv6CjB13RmQ6F8SvQSj4yQwXIgfZ7Jir5/AEd9xbL+
 /hyPWCq/lsn/UIBpmehspPWB7jmkMHSLkAVPXUiKBFWa8KagS7UaDYYN/lJTdLkIiMrkUP0bRLg
 v+mtYtYPepfnw0NNWMfYZdBca6NsIIOcmkofbu3csHNSzIIAn/Pv5axPxbAaGiJdga8Cj+CJgAt
 Uw+bJ0Z+p6FK2nmbjN8IaJPjf63b+MUb6GUo4yqxwYpBnzLLsW+E62mPCXNuHiPxdaPa879DTjR
 7aE51GS7qhdF6xKjYhL7Nj5VfppeUWkSadvyDKQoSFMDieqlazMQbeSX+K/cDb4CSXAUUQv/I1O
 QyVQp8Wz39Td5GJRrEsPgadpqBaRaq0HW0+gIjSTvx8q5C6W5ME4fzhqgquwpKfpe+FCSMEvXeu
 gmTp7nZlQnqY5WIcHep3Q=
X-Received: by 2002:a05:6000:200e:b0:435:932e:f924 with SMTP id
 ffacd0b85a97d-43629034d76mr777534f8f.2.1770321555303; 
 Thu, 05 Feb 2026 11:59:15 -0800 (PST)
Received: from thinkpad-t470s.. ([93.140.16.93])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-436297450b4sm514079f8f.34.2026.02.05.11.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 11:59:14 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH 21/29] hw/core: Add Remote Port Stream device
Date: Thu,  5 Feb 2026 20:58:16 +0100
Message-ID: <20260205195824.2610192-22-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Introduce the 'remote-port-stream' device to bridge QEMU StreamSink
interfaces with the Remote Port protocol.

The patch implements the logic to translate local stream push
operations into Remote Port bus-access packets and vice-versa.
This enables bi-directional data streaming between QEMU and
external simulators.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/remote-port-stream.c | 239 +++++++++++++++++++++++++++++++++++
 hw/core/trace-events         |   4 +
 2 files changed, 243 insertions(+)
 create mode 100644 hw/core/remote-port-stream.c

diff --git a/hw/core/remote-port-stream.c b/hw/core/remote-port-stream.c
new file mode 100644
index 0000000000..6baaf68f08
--- /dev/null
+++ b/hw/core/remote-port-stream.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2013 Xilinx Inc
+ * Copyright (c) 2013 Peter Crosthwaite <peter.crosthwaite@xilinx.com>
+ * Copyright (c) 2013 Edgar E. Iglesias <edgar.iglesias@xilinx.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/sysbus.h"
+#include "qemu/log.h"
+
+#include "qemu/bitops.h"
+#include "qapi/qmp/qerror.h"
+#include "hw/core/stream.h"
+#include "qapi/error.h"
+#include "migration/vmstate.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/remote-port.h"
+#include "trace.h"
+
+#ifndef REMOTE_PORT_STREAM_ERR_DEBUG
+#define REMOTE_PORT_STREAM_ERR_DEBUG 0
+#endif
+
+#define TYPE_REMOTE_PORT_STREAM "remote-port-stream"
+
+#define REMOTE_PORT_STREAM(obj) \
+     OBJECT_CHECK(RemotePortStream, (obj), TYPE_REMOTE_PORT_STREAM)
+
+typedef struct RemotePortStream RemotePortStream;
+
+struct RemotePortStream {
+    DeviceState parent_obj;
+
+    RemotePort *rp;
+    uint32_t rp_dev;
+    uint16_t stream_width;
+
+    StreamSink *tx_dev;
+
+    StreamCanPushNotifyFn notify;
+    void *notify_opaque;
+
+    uint8_t *buf;
+    struct rp_pkt pkt;
+
+    bool rsp_pending;
+    uint32_t current_id;
+};
+
+static void rp_stream_notify(void *opaque)
+{
+    RemotePortStream *s = REMOTE_PORT_STREAM(opaque);
+
+    /* FIXME: This is completely bogus.  */
+    if (s->buf && stream_can_push(s->tx_dev, rp_stream_notify, s)) {
+        RemotePortDynPkt rsp;
+        struct rp_encode_busaccess_in in = {0};
+        size_t pktlen = sizeof(struct rp_pkt_busaccess_ext_base);
+        size_t enclen;
+        int64_t delay = 0; /* FIXME - Implement */
+
+        size_t ret = stream_push(s->tx_dev, s->buf, 4, 0);
+        assert(ret == 4);
+        s->buf = NULL;
+
+        memset(&rsp, 0, sizeof(rsp));
+        rp_dpkt_alloc(&rsp, pktlen);
+        rp_encode_busaccess_in_rsp_init(&in, &s->pkt);
+        in.clk = s->pkt.busaccess.timestamp + delay;
+        enclen = rp_encode_busaccess(rp_get_peer(s->rp),
+                                     &rsp.pkt->busaccess_ext_base,
+                                     &in);
+        assert(enclen <= pktlen);
+        trace_remote_port_stream_tx_busaccess(rp_cmd_to_string(in.cmd),
+            in.id, in.flags, in.dev, in.addr, in.size, in.attr);
+
+        rp_write(s->rp, (void *)rsp.pkt, pktlen);
+    }
+}
+
+static void rp_stream_write(RemotePortDevice *obj, struct rp_pkt *pkt)
+{
+    RemotePortStream *s = REMOTE_PORT_STREAM(obj);
+
+    trace_remote_port_stream_rx_busaccess(rp_cmd_to_string(pkt->hdr.cmd),
+        pkt->hdr.id, pkt->hdr.flags, pkt->hdr.dev, pkt->busaccess.addr,
+        pkt->busaccess.len, pkt->busaccess.attributes);
+
+    assert(pkt->busaccess.width == 0);
+    assert(pkt->busaccess.stream_width == pkt->busaccess.len);
+    assert(pkt->busaccess.addr == 0);
+
+    if (pkt->hdr.flags & RP_PKT_FLAGS_response) {
+        /* FXIME - probably need to do syncs and stuff */
+        assert(s->rsp_pending);
+        s->rsp_pending = false;
+        if (s->notify) {
+            StreamCanPushNotifyFn notify = s->notify;
+            s->notify = NULL;
+            notify(s->notify_opaque);
+        }
+    } else {
+        assert(!s->buf);
+        s->buf = g_memdup2(pkt + 1, 4);
+        s->pkt = *pkt;
+        rp_stream_notify(s);
+    }
+}
+
+static bool rp_stream_stream_can_push(StreamSink *obj,
+                                            StreamCanPushNotifyFn notify,
+                                            void *notify_opaque)
+{
+    RemotePortStream *s = REMOTE_PORT_STREAM(obj);
+
+    if (s->rsp_pending) {
+        s->notify = notify;
+        s->notify_opaque = notify_opaque;
+        return false;
+    }
+    return true;
+}
+
+static size_t rp_stream_stream_push(StreamSink *obj, uint8_t *buf,
+                                    size_t len, bool eop)
+{
+    RemotePortStream *s = REMOTE_PORT_STREAM(obj);
+    RemotePortDynPkt rsp;
+    struct rp_pkt_busaccess_ext_base pkt;
+    struct rp_encode_busaccess_in in = {0};
+    uint64_t rp_attr = eop ? RP_BUS_ATTR_EOP : 0;
+    int64_t clk;
+    int enclen;
+
+    clk = rp_normalized_vmclk(s->rp);
+
+    in.cmd = RP_CMD_write;
+    in.id = rp_new_id(s->rp);
+    in.dev = s->rp_dev;
+    in.clk = clk;
+    in.attr = rp_attr;
+    in.size = len;
+    in.stream_width = s->stream_width;
+    enclen = rp_encode_busaccess(rp_get_peer(s->rp), &pkt, &in);
+
+    trace_remote_port_stream_tx_busaccess(rp_cmd_to_string(in.cmd),
+        in.id, in.flags, in.dev, in.addr, in.size, in.attr);
+
+    rp_rsp_mutex_lock(s->rp);
+    rp_write(s->rp, (void *) &pkt, enclen);
+    rp_write(s->rp, buf, len);
+    rsp = rp_wait_resp(s->rp);
+    assert(rsp.pkt->hdr.id == be32_to_cpu(pkt.hdr.id));
+
+    trace_remote_port_stream_rx_busaccess(
+        rp_cmd_to_string(rsp.pkt->hdr.cmd), rsp.pkt->hdr.id,
+        rsp.pkt->hdr.flags, rsp.pkt->hdr.dev, rsp.pkt->busaccess.addr,
+        rsp.pkt->busaccess.len, rsp.pkt->busaccess.attributes);
+
+    rp_dpkt_invalidate(&rsp);
+    rp_rsp_mutex_unlock(s->rp);
+    rp_restart_sync_timer(s->rp);
+    return len;
+}
+
+static void rp_prop_allow_set_link(const Object *obj, const char *name,
+                                   Object *val, Error **errp)
+{
+}
+
+static void rp_stream_init(Object *obj)
+{
+    RemotePortStream *s = REMOTE_PORT_STREAM(obj);
+
+    object_property_add_link(obj, "axistream-connected", TYPE_STREAM_SINK,
+                             (Object **)&s->tx_dev,
+                             qdev_prop_allow_set_link_before_realize,
+                             OBJ_PROP_LINK_STRONG);
+    object_property_add_link(obj, "rp-adaptor0", "remote-port",
+                             (Object **)&s->rp,
+                             rp_prop_allow_set_link,
+                             OBJ_PROP_LINK_STRONG);
+}
+
+static Property rp_properties[] = {
+    DEFINE_PROP_UINT32("rp-chan0", RemotePortStream, rp_dev, 0),
+    DEFINE_PROP_UINT16("stream-width", RemotePortStream, stream_width, 4),
+};
+
+static void rp_stream_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    StreamSinkClass *ssc = STREAM_SINK_CLASS(oc);
+    RemotePortDeviceClass *rpdc = REMOTE_PORT_DEVICE_CLASS(oc);
+
+    ssc->push = rp_stream_stream_push;
+    ssc->can_push = rp_stream_stream_can_push;
+    device_class_set_props_n(dc, rp_properties, ARRAY_SIZE(rp_properties));
+    rpdc->ops[RP_CMD_write] = rp_stream_write;
+}
+
+static const TypeInfo rp_stream_info = {
+    .name          = TYPE_REMOTE_PORT_STREAM,
+    .parent        = TYPE_DEVICE,
+    .instance_size = sizeof(RemotePortStream),
+    .class_init    = rp_stream_class_init,
+    .instance_init = rp_stream_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_STREAM_SINK },
+        { TYPE_REMOTE_PORT_DEVICE },
+        { },
+    }
+};
+
+static void rp_stream_register_types(void)
+{
+    type_register_static(&rp_stream_info);
+}
+
+type_init(rp_stream_register_types)
diff --git a/hw/core/trace-events b/hw/core/trace-events
index fb3125b0eb..5b4e5029fe 100644
--- a/hw/core/trace-events
+++ b/hw/core/trace-events
@@ -44,3 +44,7 @@ remote_port_memory_slave_rx_busaccess(const char *cmd, uint32_t id, uint32_t fla
 # remote-port-memory-gpio.c
 remote_port_gpio_tx_interrupt(uint32_t id, uint32_t flags, uint32_t dev, uint64_t vector, uint32_t irq, uint32_t val) "id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", vector=0x%"PRIx64", irq=0x%"PRIx32", level=0x%"PRIx32
 remote_port_gpio_rx_interrupt(uint32_t id, uint32_t flags, uint32_t dev, uint64_t vector, uint32_t irq, uint32_t val) "id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", vector=0x%"PRIx64", irq=0x%"PRIx32", level=0x%"PRIx32
+
+# remote-port-stream.c
+remote_port_stream_tx_busaccess(const char *cmd, uint32_t id, uint32_t flags, uint32_t dev, uint64_t addr, uint32_t len,  uint64_t attr) "cmd=%s, id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", addr=0x%"PRIx64", len=0x%"PRIx32", attr=0x%"PRIx64
+remote_port_stream_rx_busaccess(const char *cmd, uint32_t id, uint32_t flags, uint32_t dev, uint64_t addr, uint32_t len,  uint64_t attr) "cmd=%s, id=0x%"PRIx32", flags=0x%"PRIx32", dev=0x%"PRIx32", addr=0x%"PRIx64", len=0x%"PRIx32", attr=0x%"PRIx64
-- 
2.43.0


