Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A03E2CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 16:41:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBasp-0005BL-Gd; Tue, 29 Sep 2026 12:40:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xBasn-0005AQ-2t
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:40:45 -0400
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xBasl-0006OA-3k
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:40:44 -0400
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-4834977ae75so2671244f8f.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 09:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790700041; x=1791304841; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SQg3YvJqlImDT1k6/qUs5J7J77TVOjmkx65W7g5ZEVA=;
 b=GPB9kPTndBSdeuWVyBCIEVleJdplnLnxAjIABAev55FqhvLLeAsg9tQnSM3vIToIRQ
 SbBDHx1aR3avehtEYl2UuX4oR8t64HnagQd/tt39gVvz2D7PmK7ljrx89r3SQ0B5+Zkj
 6T7ua9Rh7VF+1gH5GoZvFJ0kyupqX9DqlCRRzqcwt9kaVEx8RiSVG54Wgm3OqAr0nZBN
 woIPgoCEFzgNignr8sYCEdS75I9T8YPocXIKfUqF00Rty7dJ/WQFhejQwhYfD7JxB40r
 CNFAwVTmtl5Dx9ffErrYSJhljI4/Dd0E4ESL6SgQQNfVK4sIJg+v2t1t7E2L/oyvL5Ah
 mjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790700041; x=1791304841;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SQg3YvJqlImDT1k6/qUs5J7J77TVOjmkx65W7g5ZEVA=;
 b=0Nh6y7GD4T9dF3xf2QZUfXMCtK+z0T6fsAOSLwaJuSw8FL0+TqkeaTiw4Nu4TKnHmZ
 VlTAt8zIS9/Kf2PfIEHi0Xg7Ey9zyYCztAcqPcEPyGWKoL8+naNsTKXfqTkaDtF4uUil
 MTzADl/2GUcGqYKQSPG9wLl9LM1xtfip+QwOi+yP98jPL3DPj5rwo0IDV6vIAHP2CMTl
 heEikXxiVGcaIQpAUsQAXN82xmzrNbZp23Z9emMjNOfkEr4N3XGI2Q4wYL7EkAB+jFXK
 YvrBNDF/nfg4lvLIHM5nahDSsLGotIkTSVcY7LBJnjigDS3OPSLRmO/L5iAOugTvXx9d
 bwMQ==
X-Gm-Message-State: AFq9FYIrtNIgodK79Xb9ZzXL1z9r0llLuGRGCk4ViUsjPALKgHHwYvKt
 SUm4cCNqSiufNexhIfHXK3cr/72+UA4tkLgd9aNXxHl6X1iky88xvnNU
X-Gm-Gg: AYBFou1IYoaqzeKHa2RAUdmcu97HNYco7/S58PtekRYk7FdPglaGcqyRRqIZSGKjKY4
 e4jvr2cWvXHyXDpMX+Z8j40zQ+w4DZSbI1dWkgR6US2g7htCOqMHjTeWiIxad6+NpHwdp612u5v
 b4EKvvUVXePGRgSYUteoC6u/qr3Wfz6KngyJEbWcCsqL4sUjHKdJjYUbo/uEYR7Ho5BFZH+tv3b
 krmq81bnREe0531/GrA3H/q0DYHeKMiV6uPiENYm9tsqdmQETuQZrpsYnC3/ewK+jqjvtW59r5q
 7+E6uLVTqFdJWeatCe2j3mYWrhBYALf2DWT/4an3KaQgtNOgRkF86/SN+G1+4q2Ee4EPxKWdsCV
 QkCqjQ2yOufUVEmnSOiATYJEoca67x4A3tB80xXnO+jFYkfqQTErFcHPSnhnnSdKU30cLGRTHRu
 5oU+a3juchdgZkf5J2ZkpMZWghynsWyOhlzE69Kr4nezZi0mRzyO0Jg0mYGQ4ahmjp1mkYQMMFi
 MC6yqe92nbSpt2IPqoFHQevUgk=
X-Received: by 2002:a05:6000:40e1:b0:487:27f6:a4cd with SMTP id
 ffacd0b85a97d-488716a5fb3mr31555394f8f.29.1790700041457; 
 Tue, 29 Sep 2026 09:40:41 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af5049419sm4796993f8f.14.2026.09.29.09.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:40:41 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Tue, 29 Sep 2026 18:38:40 +0200
Subject: [PATCH v8 12/12] virtio-console: notify the guest about terminal
 resizes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-console-resize-v8-12-2ff9183f8750@gmail.com>
References: <20260929-console-resize-v8-0-2ff9183f8750@gmail.com>
In-Reply-To: <20260929-console-resize-v8-0-2ff9183f8750@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790700030; l=3302;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=KgvwWaj3G2h6/LuL7FGcs//vRG1zBc7HUKfYqRtFZpc=;
 b=LhsABfn9CkvkVs0Db0tuEzgrtemTs913J0iV4eJIXo4+Hwl5DsUnewuB6bmYXn+gl6YuOslcP
 oVQQDpQJhPzAQmp/rNPu1E7O9SgNPEiZqhOvnxJIoGr4M+WdgBja4hW
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:30::10;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wr2-x10.google.com
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
2.55.0


