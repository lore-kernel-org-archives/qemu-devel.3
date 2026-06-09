Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3F7CD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX1xN-0006Qp-Dd; Tue, 09 Jun 2026 15:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wX1wb-00065y-BC
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:17:01 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wX1wY-0006SF-Vf
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:17:01 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490b7866869so66344755e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781032618; x=1781637418; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GE2kR1xeXVrOYrQ1L5yk3M3rSjJjGyLlFBLdmYC2OsI=;
 b=IwaCDbXkOmxe0iKq7Q/LUv7YCfTMApLAZVP0v99gQTSzsqXg5/5+1bfQ277uoVdpr6
 c70oPlp6RvwPnkSVfsAEYKf1KAER86HHcNrUhVmpst3Z3rgeseKnpJSRMKxJIlspgwCL
 lPwGP36iyrFMAyYtjOiYNfhHSxNqYjZJq+6IL1t11v4VTVOksdXo81Hvu2VMYnkA8WJI
 aUQ+nW86QFN5+V2rol4vb4nA/hXaScA9EaMcKhaazCt5uGGbuuRhmQQ+p3FP3cPNuFf+
 9nag5sF8+NTxuIDqnzhulIm9t8SNog3cyg/n0RI0Bf7umT4poWEGwaeQhKNc5VVZenZQ
 GBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032618; x=1781637418;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GE2kR1xeXVrOYrQ1L5yk3M3rSjJjGyLlFBLdmYC2OsI=;
 b=otkptKa1bE2P2oRgcclDCZN3sBlsXUJkw7ROZZ8DaOmhxG4EzeVLgQWxgKSKV/bvgX
 dRjmckOwoAK5DBs8OPRBswSJoRPmkzAPMD7SjP2bw1+WYuFoGcmSRypGNsae7RpjKEX2
 N1DPwdbqVIGTLivkg4/5NnfKQKZ3T39WmeHWrjdvysXontgR7+gz2f6vx63vr/ORf0+f
 vM69dspJ5q3ggq3KpcP0+VOoSu2xZpwjqCm+SRLK2RBrnDTTAH6ly4cSMm012NtBURzt
 iXNhgqlspnpNnQoPFC5taHsVZAxSiesFIa7wZ7kSV+hz40wGqd2ZVD2NhrS0Lbxg+02R
 vUPw==
X-Gm-Message-State: AOJu0YxYKnLPHXf6aRU8ZvnEABYWNvCm+HHmrYXJuOYhJkWPW2a31vbe
 A2wBxYqode2zkt7eygi2YpMJF0WSMwgGErF+zjTYWv+eST0W1910NYjE
X-Gm-Gg: Acq92OFcRfSvgq/e6npBL3lYNeTC2S4xfJFiG9G0sT2LiVUCBPPNhoH5v+o4xbDjoFm
 WnbP5DQkBCNYWV60OUPVubwpV2B9nrgiFNj/p7kA8xqlJFfURxhzLTMQ7ye1/5Nyud166OFdnVI
 scaf8M8FitOxHjD7ll3QAIsP56XAhs2vK0HNkWwsBdnC5owbA9hFWA90qyjj8+6q+mG3KDN7G9H
 55+9f41gWA+PpCGD6GeB/GcY1bBaiEyle2eZCUGjljDEq+vEKNjn9Qc39FEFRHofb1ai+xAyO3/
 725CvOdBFQbOq31lmBXFkvpEglApyl3MI9wZi42o0xpHheT/8nAQWtTDdtPJRdz2DXdBvsNUaCa
 wX/HyRLMj1UpeQ59YF2ov8coHsyHBxFbe6Q5gW34ZWuQIeYBt+LDpUJ8gk99In6twNghVjSGLHJ
 GNnRZxVCOCQcop3DOBoVCHwVFw1reNSI+MPDIgRST4LrSDkx1MIpYljwx6RyIn+xs=
X-Received: by 2002:a05:600c:3107:b0:490:9588:bdb6 with SMTP id
 5b1f17b1804b1-490c264cc2emr364171355e9.33.1781032617606; 
 Tue, 09 Jun 2026 12:16:57 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f67c6sm62219375f8f.16.2026.06.09.12.16.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:16:57 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Tue, 09 Jun 2026 21:16:22 +0200
Subject: [PATCH v7 12/12] virtio-console: notify the guest about terminal
 resizes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-console-resize-v7-12-0c550fdcec15@gmail.com>
References: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
In-Reply-To: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
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
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Szymon Lukasz <noh4hss@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781032602; l=3302;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=S52O78eqfhcrqS9wQGdogkWPgjv5YHOanEgZT+Knbnk=;
 b=fGTEd/QoCbP4Oy1Sajn9ql36kt6eTL7rTTRbhn/3zRyOUvLBhZC19QDBjQYK3aHlwSyR4hONQ
 wzHzWfBr4elBE5aeCqEOdFRgvs1/E6x8jt0ifsBZO4+5RfrhPbHI3xR
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
2.54.0


