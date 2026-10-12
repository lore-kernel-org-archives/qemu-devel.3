Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 952C5CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:05:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGGeo-0000YU-L7; Mon, 12 Oct 2026 10:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGGej-0000Op-MT
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:05:33 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGGeh-0006AA-Aw
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:05:33 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a171b677d2so11426015e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 07:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791813930; x=1792418730; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sOmnL6SVS6NfCpYrYfO2rS+oo3gMVqcjlaO3QERQMfg=;
 b=H97ybdadFx7PT5tFbuzl0XzB4Hs1N2qJAm+JdL+jdACfKzutOn8+YtmL7hxUQpkC7p
 LkJUXD8UF5ZYxTqAavVGPocawGm2QblPS7m6Wdf32jtTjt2ZhnA/wOfZHWElvDTNcKDu
 OPL4ET3Lxn9mFSxh3oy0bzZnKcvgG6FqiroxK+3yMIgHHuJazSSQpur76XlRr1R+DQjb
 wSJshfdNf7ULsjMtRNbwAGf1t9Fy7Ah64P7jeqwq75/EgCPIuZH6UWndZZyXNoH24fSo
 GEmcpqsUdcacpNRn4lRQ/u92mlAvBkkeTMYzGsRLZU3LCS762WOEQa5Y+VVyTEarkoKU
 tEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813930; x=1792418730;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sOmnL6SVS6NfCpYrYfO2rS+oo3gMVqcjlaO3QERQMfg=;
 b=S59gVrSVsKkAjkICgsttHLu9cr6pda5AGFCgVe5v5tlrWZTDJb8B6cgvmEut1p4MDf
 Lge2rvClR1sPBlZpdsFjkudlNJKzve55aNxOR2ERbPfU4S8s2sylxAP33VcaXOI899Ga
 abqvNIO0V1rMQzcKnIBz8Qskjc2cekOwgzif7iDd5YqazvB/i7C0eViNXzexTdAxD0cU
 7V0pW86kFbnnbeUN/M1rLmTb7JZaVE6gZJIOMcICdBzcmp+0diFrUe1p4FGHuMbt8Ki2
 nT2PM1ZgkkXsnb92rl6byuAAt1OF8k5BVU+8Ork8gZvSfSp+vA7Yhu/hh/ofm/AMXPV5
 0bqQ==
X-Gm-Message-State: AFq9FYInsi+fZnzsfzcyIFebKfqwFkWjY3envI3NKIxXczD+FDC6jkGK
 cIcv5vt8jI/2JUvvmFRt05SHN773dyGr0tcabJl9WsQC5TRpUI29rX6e
X-Gm-Gg: AYBFou0ItG8ByyU8zAFbsKe8I9AThxECQLCEDFgM6hBCHcJsojxOH4vTkHxPcoaG5mO
 nvFtQGlfQhQWgNEF9W4A5wdIkFr6xpwf5EkbVG2cqocc1enknTuzxQ7o6Ltps3Kw8mp/skaHg3r
 GyTZX5jbnRInqXgGa+3hJ4vMKQe0Q9KG8AXltIjLrhSEMm6Yo8xT+mT7LdbUl7XC7i6AoLt0lJc
 hGZ7pnhtIwz4DUgX7T7KRumepk3k8mQkkDb7TduJcgaGaDGquVJpWoDD2HwhgvRbUKyGEWRukjZ
 zN+a7daWwPl7Odi5VxrVEFbfWRWLBQff1ckfXb0XWZVEE7fX3tzaJ9mme5ag1ZxW/gXYU0wdvuO
 +WlT+RSAvAVnMKi10S/KLCpI8D4Bn6HDXPyDnOt7KZU2b3QXOLcfXoLZs+RwfyhsMC08t2G/3vO
 4zTuonVZA3uIEh6FCxFw37k9+Bco7Zs2yZ+dMuWhqswvh5OvyMKzIl7vE0zj4ZjlnfjCORytVy9
 VjQl966ObMqsJ/4hI5gOTxsi5w=
X-Received: by 2002:a05:600c:6388:b0:4a1:6f78:8419 with SMTP id
 5b1f17b1804b1-4a18e3ee8f9mr180525875e9.0.1791813929636; 
 Mon, 12 Oct 2026 07:05:29 -0700 (PDT)
Received: from localhost (ip-78-44-39-34.bb.vodafone.cz. [78.44.39.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18c1e33d2sm400314925e9.0.2026.10.12.07.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:05:29 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 12 Oct 2026 16:05:10 +0200
Subject: [PATCH v10 11/12] virtio-serial-bus: add terminal resize messages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-console-resize-v10-11-2c3b10d829b3@gmail.com>
References: <20261012-console-resize-v10-0-2c3b10d829b3@gmail.com>
In-Reply-To: <20261012-console-resize-v10-0-2c3b10d829b3@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 Dominique Martinet <asmadeus@codewreck.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791813907; l=7998;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=DCeeNDEpPIwrO0QpkSIOccbZbWp9F5E4NywqG+YkJm4=;
 b=lwxP7npgr0mCH6Pq8OkERFy8SBMZ+PZXTp68U54BHBRcSSAX4aIA0A1nr7dfxHHwPGxOZKFto
 rsmtfAy2yj8BjTz3a03OMSQo5/KihzLjNyiKrOaBjXOZOvVoX9Z31F4
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x330.google.com
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

Implement the part of the virtio spec that allows to notify the virtio
driver about terminal resizes. Gate the new resize support behind the
console-size property, which defaults to off. To implement the property,
restore VirtIOSerial::host_features (previously removed by commit
d0660e5b7fc7e97926232d13d2500a16df32b310).

The virtio spec contains two methods to inform the guest about console
size:

For legacy drivers, we have only one port and we put the terminal size
in the config space and inject the config changed interrupt.

For multiport devices, we use the control virtqueue to send a
packet containing the terminal size. Unfortunately, old versions
of the Linux kernel used an incorrect order for the fields (rows
then cols instead of cols then rows), until it was fixed by commit
5326ab737a47278dbd16ed3ee7380b26c7056ddd. As a result, when running an
old guest kernel, the number of rows and columns will be swapped.

Based on a patch originally written by Szymon Lukasz <noh4hss@gmail.com>,
but partially rewritten to fix various corner cases.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 hw/char/trace-events              |  1 +
 hw/char/virtio-serial-bus.c       | 81 ++++++++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-serial.h |  7 ++++
 3 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/hw/char/trace-events b/hw/char/trace-events
index a3fcc77287..e387c8853f 100644
--- a/hw/char/trace-events
+++ b/hw/char/trace-events
@@ -11,6 +11,7 @@ serial_update_parameters(uint64_t baudrate, char parity, int data_bits, int stop
 
 # virtio-serial-bus.c
 virtio_serial_send_control_event(unsigned int port, uint16_t event, uint16_t value) "port %u, event %u, value %u"
+virtio_serial_send_console_resize(unsigned int port, uint16_t cols, uint16_t rows) "port %u, cols %u, rows %u"
 virtio_serial_throttle_port(unsigned int port, bool throttle) "port %u, throttle %d"
 virtio_serial_handle_control_message(uint16_t event, uint16_t value) "event %u, value %u"
 virtio_serial_handle_control_message_port(unsigned int port) "port %u"
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index c36e18a4cf..882765ac88 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -261,6 +261,68 @@ static size_t send_control_event(VirtIOSerial *vser, uint32_t port_id,
     return send_control_msg(vser, &cpkt, sizeof(cpkt));
 }
 
+/*
+ * This struct should be added to the Linux kernel uapi headers
+ * and later imported to standard-headers/linux/virtio_console.h
+ */
+struct virtio_console_resize {
+    __virtio16 cols;
+    __virtio16 rows;
+};
+
+static void send_console_resize(VirtIOSerialPort *port)
+{
+    VirtIOSerial *vser = port->vser;
+    VirtIODevice *vdev = VIRTIO_DEVICE(vser);
+
+    if (!virtio_has_feature(vser->host_features, VIRTIO_CONSOLE_F_SIZE)) {
+        return;
+    }
+
+    trace_virtio_serial_send_console_resize(port->id, port->cols, port->rows);
+
+    if (use_multiport(vser)) {
+        struct {
+            struct virtio_console_control control;
+            struct virtio_console_resize resize;
+        } buffer = {};
+
+        virtio_stl_p(vdev, &buffer.control.id, port->id);
+        virtio_stw_p(vdev, &buffer.control.event, VIRTIO_CONSOLE_RESIZE);
+        virtio_stw_p(vdev, &buffer.resize.cols, port->cols);
+        virtio_stw_p(vdev, &buffer.resize.rows, port->rows);
+
+        send_control_msg(vser, &buffer, sizeof(buffer));
+    }
+}
+
+void virtio_serial_resize_console(VirtIOSerialPort *port,
+                                  uint16_t cols, uint16_t rows)
+{
+    VirtIOSerial *vser = port->vser;
+    VirtIODevice *vdev = VIRTIO_DEVICE(vser);
+
+    if (port->cols == cols && port->rows == rows) {
+        return;
+    }
+
+    port->cols = cols;
+    port->rows = rows;
+
+    if (port->id == 0 && !use_multiport(vser) &&
+        virtio_vdev_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE)) {
+        virtio_notify_config(vdev);
+    }
+
+    /*
+     * We will send these messages even before we told the guest that
+     * it is a console port (by sending VIRTIO_CONSOLE_CONSOLE_PORT
+     * message), but that should be fine as the guest will likely
+     * ignore them.
+     */
+    send_console_resize(port);
+}
+
 /* Functions for use inside qemu to open and read from/write to ports */
 int virtio_serial_open(VirtIOSerialPort *port)
 {
@@ -403,6 +465,7 @@ static void handle_control_message(VirtIOSerial *vser,
          */
         if (vsc->is_console) {
             send_control_event(vser, port->id, VIRTIO_CONSOLE_CONSOLE_PORT, 1);
+            send_console_resize(port);
         }
 
         if (port->name) {
@@ -538,6 +601,7 @@ static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
 
     vser = VIRTIO_SERIAL(vdev);
 
+    features |= vser->host_features;
     features |= BIT_ULL(VIRTIO_CONSOLE_F_EMERG_WRITE);
     if (vser->bus.max_nr_ports > 1) {
         virtio_add_feature(&features, VIRTIO_CONSOLE_F_MULTIPORT);
@@ -549,11 +613,18 @@ static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
 static void get_config(VirtIODevice *vdev, uint8_t *config_data)
 {
     VirtIOSerial *vser = VIRTIO_SERIAL(vdev);
+    VirtIOSerialPort *port;
     struct virtio_console_config *config =
         (struct virtio_console_config *)config_data;
 
-    config->cols = 0;
-    config->rows = 0;
+    port = find_port_by_id(vser, 0);
+    if (port) {
+        config->cols = virtio_tswap16(vdev, port->cols);
+        config->rows = virtio_tswap16(vdev, port->rows);
+    } else {
+        config->cols = 0;
+        config->rows = 0;
+    }
     config->max_nr_ports = virtio_tswap32(vdev,
                                           vser->serial.max_virtserial_ports);
 }
@@ -716,6 +787,10 @@ static void virtio_serial_post_load_timer_cb(void *opaque)
                                port->host_connected);
         }
         vsc = VIRTIO_SERIAL_PORT_GET_CLASS(port);
+        /*
+         * TODO: let the guest know about new console size if it has changed
+         * (this will require sending old size in the migration stream)
+         */
         if (vsc->set_guest_connected) {
             vsc->set_guest_connected(port, port->guest_connected);
         }
@@ -1142,6 +1217,8 @@ static const VMStateDescription vmstate_virtio_console = {
 static const Property virtio_serial_properties[] = {
     DEFINE_PROP_UINT32("max_ports", VirtIOSerial, serial.max_virtserial_ports,
                                                   31),
+    DEFINE_PROP_BIT64("console-size", VirtIOSerial, host_features,
+                      VIRTIO_CONSOLE_F_SIZE, false),
 };
 
 static void virtio_serial_class_init(ObjectClass *klass, const void *data)
diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/virtio/virtio-serial.h
index da0c91e1a4..bda6d5312a 100644
--- a/include/hw/virtio/virtio-serial.h
+++ b/include/hw/virtio/virtio-serial.h
@@ -145,6 +145,9 @@ struct VirtIOSerialPort {
     bool host_connected;
     /* Do apps not want to receive data? */
     bool throttled;
+
+    /* Terminal size reported to the guest.  Only used for consoles. */
+    uint16_t cols, rows;
 };
 
 /* The virtio-serial bus on top of which the ports will ride as devices */
@@ -186,6 +189,8 @@ struct VirtIOSerial {
     struct VirtIOSerialPostLoad *post_load;
 
     virtio_serial_conf serial;
+
+    uint64_t host_features;
 };
 
 /* Interface to the virtio-serial bus */
@@ -220,5 +225,7 @@ size_t virtio_serial_guest_ready(VirtIOSerialPort *port);
  */
 void virtio_serial_throttle_port(VirtIOSerialPort *port, bool throttle);
 
+void virtio_serial_resize_console(VirtIOSerialPort *port,
+                                  uint16_t cols, uint16_t rows);
 
 #endif

-- 
2.56.0


