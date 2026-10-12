Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8AF4CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:06:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGGep-0000Yq-F2; Mon, 12 Oct 2026 10:05:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGGek-0000QU-Fr
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:05:34 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGGei-0006AV-Pa
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:05:34 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4a02718da81so14829595e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 07:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791813931; x=1792418731; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i7D8m4p5d44A3c6h9sfrKhYabzXBklBQd1u3SRQCaDA=;
 b=JHDAw38gk9ukmZmToZcFkjAz2enbKIRx/WArpvgj4jHg6SoRKr0LVNChFBCuhTujto
 jIwa1di3LUX4rXV3qrt16tYKt+1yNi9wSHjFJo7GAhUxNOuqN3prJBQbb21f1zqOjltl
 MxlBQCuKwSlUtx81c2DMgUChOJk2pVil2137PDssMKBIqjy4o9dN8F1U3bFA/0dzZtA5
 ZcgFTZr8R7+iU1GTKGkJtN/BiQNEHgc9Pd5FRYE3FBd4j8Z5bD4tPpeMS4mOxEId5eh3
 xEZ25x5mdBgOtasbx8B8VkSFN/xB0kiORp17iICgZcNVE5kv6lFXNL9VvieRmKys6NBb
 MhvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813931; x=1792418731;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i7D8m4p5d44A3c6h9sfrKhYabzXBklBQd1u3SRQCaDA=;
 b=dkkrGRG9Yg0YiOUpi2iTL2jTuhuGUYp3LuE1GHsc4FUfF+AuV4x4j8bRvt3i9ZNibX
 GUdgPnm7674ZAebRGPhi1m3Lj4txc1dTbIz/nNP8u3OcfHHBU60TH30jRjXe/vJKdvlA
 X+L9giYRxay4mp3sr1IogwOZ+ynI5tTbZLDPEaYTmvJcLkngrPV6O0RWKbpdVpqq3bwN
 n0yThUjpSZHOFel8sFi4yeQluT9UNalKy6jII+0/ZNcWRAHfEoCCuy1jGfLNLQZllnp+
 saa7P8+iRpeOESZHZD1KzPQ0CTQJFiCU2Duy5IC2AcVq8LkvNWCWpF4EJZKIQ+bjLE24
 x7/Q==
X-Gm-Message-State: AFq9FYIfdIzt+NsGmRUDd8th1oQ+3L43FcftRengJkhgfaWyusPJm/Ah
 h9aOMqhhJyxDiRpPzl3LOUdjhaeknoeagbt0M4DsHeoVSyCyRL48sPAs
X-Gm-Gg: AYBFou1f2RfOBEMew1IDL/55YZlwnc2+N88PiFKtmH5QLiCaPwdIeFHnh/FyW6PJYwh
 DpzWuSilhBM2SCeY7J550644Boos928OsMgPFQRRLPXCVvLo1jPPBuynIPXK6rlEdzWVj74NgaZ
 Gb553lO2QIuxmcVDt46hP7AuW695mRXShDe+NNri9paMMEI1uYFqLvoOpRpdeaax3V75afFKOUx
 lFTn8P558qcFuQj9zRgRvamL19pu60CPKaiwLb0kaCkG/KeoI591eWsaO4wK/4SQ9i9WuCufeqG
 bIl0c3mNU+nM1+WZYqX6zYkqCLf+zZxNUxBPoufpHB3eIdTVADJlqmn0hSRL94viKE6vpS6Wf8/
 N8s6EAstdxkn4uyU/P7HNwT0OL2f+H9haD5nmFuLxDhpzuXgzlMSmIrgDYrd7+6Dm3A/Kme174K
 uxxanwXPdbmmUnl9o0TTubWIx5A+YZhHuIVI+9lMnJjlniYjtcmW+fSe4mgbaCBh0TiMfTOIkN5
 8sgC2oARcoLKLC98BoI+uPm4A==
X-Received: by 2002:a05:600c:3146:b0:49d:1fd8:b874 with SMTP id
 5b1f17b1804b1-4a18e4af3a8mr193838655e9.19.1791813930746; 
 Mon, 12 Oct 2026 07:05:30 -0700 (PDT)
Received: from localhost (ip-78-44-39-34.bb.vodafone.cz. [78.44.39.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2343asm540736965e9.9.2026.10.12.07.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:05:30 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 12 Oct 2026 16:05:11 +0200
Subject: [PATCH v10 12/12] virtio-console: notify the guest about terminal
 resizes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-console-resize-v10-12-2c3b10d829b3@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791813907; l=3302;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=2Jg6Y1T5V2e9cTsZrGPksLAGaFCZH0boAkiX4p5Ls9o=;
 b=Xv9KOfooAAUjJcNUvh7ohzON6uvO+8FSxLjkuNj+HQTWuiPYSBYC+soOV7enqvR+CSBZhtTBM
 aIW3/5hZUuqAcMSNSZclGvQRZBI4i2bGv4/tHZke2Jm9v7FS3Pz6CsZ
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x334.google.com
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

From: Szymon Lukasz <noh4hss@gmail.com>

If a virtio serial port is a console port, forward terminal resize
messages from the chardev backend to the guest.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
[Filip: rename things, remove logic that is now handled in virtio-serial-bus.c]
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 hw/char/virtio-console.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 36ad2ddc3f..db9d8ca797 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -107,6 +107,15 @@ static ssize_t flush_buf(VirtIOSerialPort *port,
     return ret;
 }
 
+static void virtconsole_update_size(VirtIOSerialPort *port)
+{
+    uint16_t cols, rows;
+    VirtConsole *vcon = VIRTIO_CONSOLE(port);
+
+    qemu_chr_fe_get_winsize(&vcon->chr, &cols, &rows);
+    virtio_serial_resize_console(port, cols, rows);
+}
+
 /* Callback function that's called when the guest opens/closes the port */
 static void set_guest_connected(VirtIOSerialPort *port, int guest_connected)
 {
@@ -171,6 +180,23 @@ static void chr_event(void *opaque, QEMUChrEvent event)
     }
 }
 
+static void chr_event_console(void *opaque, QEMUChrEvent event)
+{
+    VirtConsole *vcon = opaque;
+    VirtIOSerialPort *port = VIRTIO_SERIAL_PORT(vcon);
+
+    trace_virtio_console_chr_event(port->id, event);
+    switch (event) {
+    case CHR_EVENT_OPENED:
+    case CHR_EVENT_MUX_IN:
+    case CHR_EVENT_RESIZE:
+        virtconsole_update_size(port);
+        break;
+    default:
+        break;
+    }
+}
+
 static int chr_be_change(void *opaque)
 {
     VirtConsole *vcon = opaque;
@@ -179,7 +205,9 @@ static int chr_be_change(void *opaque)
 
     if (k->is_console) {
         qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
-                                 NULL, chr_be_change, vcon, NULL, true);
+                                 chr_event_console, chr_be_change,
+                                 vcon, NULL, true);
+        virtconsole_update_size(port);
     } else {
         qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
                                  chr_event, chr_be_change, vcon, NULL, false);
@@ -207,7 +235,7 @@ static void virtconsole_enable_backend(VirtIOSerialPort *port, bool enable)
         VirtIOSerialPortClass *k = VIRTIO_SERIAL_PORT_GET_CLASS(port);
 
         qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
-                                 k->is_console ? NULL : chr_event,
+                                 k->is_console ? chr_event_console : chr_event,
                                  chr_be_change, vcon, NULL, false);
     } else {
         qemu_chr_fe_set_handlers(&vcon->chr, NULL, NULL, NULL,
@@ -239,7 +267,7 @@ static void virtconsole_realize(DeviceState *dev, Error **errp)
          */
         if (k->is_console) {
             qemu_chr_fe_set_handlers(&vcon->chr, chr_can_read, chr_read,
-                                     NULL, chr_be_change,
+                                     chr_event_console, chr_be_change,
                                      vcon, NULL, true);
             virtio_serial_open(port);
         } else {

-- 
2.56.0


