Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788C4D4A5EB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 03:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhfwv-00074m-C4; Sun, 18 Jan 2026 22:29:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vhfwi-00073p-61
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 22:28:53 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vhfwd-0004Bd-WB
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 22:28:51 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6505cac9879so6334046a12.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 19:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768793326; x=1769398126; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tn+OZOSXDbknR2OaFoKADd3P/YORnV8fEUKXR99UvC0=;
 b=PTmxipqdimREFbsNVzpAus7UxpaBrdS63t4mkOFQOomOxh6F2F+dJFZf7uxByfZu0s
 7l/t2CXnX4K0N9wuBtFqovMPw/FakuUwcVnc0XnYFyhZCiqKGAb/CtTL9SdKpkg7QRY7
 C9ajMUulon6/eamRXS5nTJLumldm7xOnjTYhF94pBVjSBA87VSf9Qtfosndw1RKtxB72
 NWTmd1YTzNemNOKTCaEh3urRxp+5E5brpWLMTiiegXvJ9zYEOK6CRaIFMV1/7gC0f5cF
 +KSmBE5hJpnnUg2ysMiqTiR2+F7G8ZOaj3gAd8KHeb6Yd1SI0oTswWGi3ALSU1aA7wAM
 QclA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768793326; x=1769398126;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tn+OZOSXDbknR2OaFoKADd3P/YORnV8fEUKXR99UvC0=;
 b=Hfupgkxl4pzmX4JxgjhRVuumTmlfW32Vr5FkRs1SJWYV+UfEmJYq5jmNa1UoGgpwMy
 7DpjdAnNRT5xwd4YPRIiVGHasGMjfHLiesPgLR50PVFY6ZjZF8xEw6bYaXUqjwRhekxi
 1f0oXShXNo4c8kJxVp/pG1CzTuxvJ9xwsevCw7rRGPnuWd/ykjUVV+2EAdZdfXxs6mny
 jB/Ht7Vv6dsxjFTZDnAyYsB12s1hzaywcHT0QRnVPBwonWK37Os2Zi6RiTbQr4lLcsGP
 CjNwJ1qU+vKgNotVT2uNravl59KCriQujbjDbXEmK3liarsZ6Ghi/Ly8kkb0NUsiDfcH
 NIJA==
X-Gm-Message-State: AOJu0YzADDlptx/E6JhobZpbdBFqxM1jTKnXV04CDPCr5wpWg7+TWnwB
 rQfesAIhFHpSgTkYfXm+fJSlaZAovZOhg2ga4Xv5CQQyRl/lVvkxWyBK
X-Gm-Gg: AY/fxX5F12YE3HC89UQj26zoRtiMWkfNySATX/+Y+8a0zfKJcqkE6Fe2sjBjNZ/nc+B
 gZmlyIXfrAqvlp2dt+qEDweAvOnyn0OLtid84ppYDQW6mCjnquLcKMPstt5aZ7K22rnbOl6ZrFq
 +OtSsMvYczOQnvK4jS68vQBmCKsgc/U5G7C8TbBH5m+9A1UBDavCShZ4aP6PPVBeAFKeeyMei4m
 0Vb6DAsWepPL2P0DjIYG8FSyfJgYpmhLa3GWmYx08Mzh7/LuzOrBhsjIFc8zS7YH2pOzoUpz5Uf
 sMXjSKsLODsp3iEPd7ojcSe0RAV9w1gQsp6pa5Sy2oJe2cT6x9qj+Ds13Q6McUgnHi8tPIwFirM
 VYYPiQzzGOOTAA44YRq1RVJ/aMfRC77Drtz//82nFFeWpgJ68rxCOwrUJyAYN8aGHZql5GrNogy
 Ybybg6kTdh4i5v/VCXxjJhl2/qvAfUqZ57oJZiGeiB
X-Received: by 2002:a17:907:1ca5:b0:b80:3fff:32ea with SMTP id
 a640c23a62f3a-b8792fede57mr931808966b.57.1768793325817; 
 Sun, 18 Jan 2026 19:28:45 -0800 (PST)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87d1e6dd64sm236516866b.32.2026.01.18.19.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 19:28:45 -0800 (PST)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 19 Jan 2026 04:27:51 +0100
Subject: [PATCH v6 08/12] virtio-serial-bus: add terminal resize messages
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-console-resize-v6-8-33a7b0330a7a@gmail.com>
References: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
In-Reply-To: <20260119-console-resize-v6-0-33a7b0330a7a@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768793314; l=7237;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=iA4bzXkkPsS0eGd8S0fKQQSaARDJLTGpF3c43PCxCTg=;
 b=wsO/GtjNynmS9ZF6de16+ezf6aZHn7ouWvpYw6UmCffe7e3rCaVYCBjFKnWXavrdm02s7/jQk
 N390GJZZuiFDaVMtCg0zMGiTQ4WjpSDmN2oTnXWKbIbzhLYhF83MoKR
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=filip.hejsek@gmail.com; helo=mail-ed1-x536.google.com
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
driver about terminal resizes. The virtio spec contains two methods to
achieve that:

For legacy drivers, we have only one port and we put the terminal size
in the config space and inject the config changed interrupt.

For multiport devices, we use the control virtqueue to send a packet
containing the terminal size. Note that old versions of the Linux kernel
used an incorrect order for the fields (rows then cols instead of cols
then rows), until it was fixed by commit 5326ab737a47278dbd16ed3ee7380b26c7056ddd.

As a result, when using a Linux kernel older than 6.15, the number of rows
and columns will be swapped.

Based on a patch originally written by Szymon Lukasz <noh4hss@gmail.com>,
but partially rewritten to fix various corner cases.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 hw/char/trace-events              |  1 +
 hw/char/virtio-serial-bus.c       | 76 +++++++++++++++++++++++++++++++++++++--
 hw/core/machine.c                 |  4 ++-
 include/hw/virtio/virtio-serial.h |  5 +++
 4 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/hw/char/trace-events b/hw/char/trace-events
index 9e74be2c14..2416d4d04e 100644
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
index 5ec5f5313b..6348eef3a2 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -260,6 +260,68 @@ static size_t send_control_event(VirtIOSerial *vser, uint32_t port_id,
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
+        } buffer;
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
@@ -408,6 +470,7 @@ static void handle_control_message(VirtIOSerial *vser, void *buf, size_t len)
          */
         if (vsc->is_console) {
             send_control_event(vser, port->id, VIRTIO_CONSOLE_CONSOLE_PORT, 1);
+            send_console_resize(port);
         }
 
         if (port->name) {
@@ -568,11 +631,18 @@ static uint64_t get_features(VirtIODevice *vdev, uint64_t features,
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
@@ -1158,6 +1228,8 @@ static const Property virtio_serial_properties[] = {
                                                   31),
     DEFINE_PROP_BIT64("emergency-write", VirtIOSerial, host_features,
                       VIRTIO_CONSOLE_F_EMERG_WRITE, true),
+    DEFINE_PROP_BIT64("console-size", VirtIOSerial, host_features,
+                      VIRTIO_CONSOLE_F_SIZE, true),
 };
 
 static void virtio_serial_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 6411e68856..50554b8900 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -38,7 +38,9 @@
 #include "hw/acpi/generic_event_device.h"
 #include "qemu/audio.h"
 
-GlobalProperty hw_compat_10_2[] = {};
+GlobalProperty hw_compat_10_2[] = {
+    { "virtio-serial-device", "console-size", "off" },
+};
 const size_t hw_compat_10_2_len = G_N_ELEMENTS(hw_compat_10_2);
 
 GlobalProperty hw_compat_10_1[] = {
diff --git a/include/hw/virtio/virtio-serial.h b/include/hw/virtio/virtio-serial.h
index 60641860bf..bda6d5312a 100644
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
@@ -222,5 +225,7 @@ size_t virtio_serial_guest_ready(VirtIOSerialPort *port);
  */
 void virtio_serial_throttle_port(VirtIOSerialPort *port, bool throttle);
 
+void virtio_serial_resize_console(VirtIOSerialPort *port,
+                                  uint16_t cols, uint16_t rows);
 
 #endif

-- 
2.52.0


