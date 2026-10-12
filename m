Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7756CA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 11:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGEf7-00048e-Mw; Mon, 12 Oct 2026 07:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGEe8-0003Wx-Ci
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:56:48 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGEe6-0002Os-SF
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:56:48 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a0e1b0681bso12808555e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791806205; x=1792411005; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5abru1t+vazWM9nKbwfMNV+88Moa82g0st8C9nL0o4c=;
 b=S4RlZv1iTd42+uR0rrU4ZkaJrLD4m8LhTOSirnV8E3OVnrN/I30Kx/nbA+C74gooqa
 Q4saBapZ9YkVa/S+C6qid+EJDEBgoAFoGeLkBH9YCWctA8MnToNWf0byo5JuMOPEWVxY
 VCVztE1GxY95cFwrw4cxp4XuDZWd897oq8lD5As3aXrRMCCpx29KeLalW8a1WmqyuGy0
 PdAajzu1WMTer9mU0WIorwcVrNQJxUJycboMAy9amHMbbswyuT+WukEY/w7ef6ITIFNv
 DxYAufaX1fchQNmcpqIkbr3k/L7arYIA63fvWZ7BEbKCxungUcquFwDn2HI4+DofTeoh
 U/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791806205; x=1792411005;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5abru1t+vazWM9nKbwfMNV+88Moa82g0st8C9nL0o4c=;
 b=wFrj0XKSBO0X9QeKm+8wOdupjyd+oyPS69WC/bgM3ofbHgbNAdPT0dvrTLCWbQMlZX
 VK2/kB6k3URZNPm8DYIr1zW5QVpnixl0AHgcvYGit1LSibotmZDjll1EQAo+Z4X/kl9O
 AZmjFOmZeW7DteTEinZt6S73YKTU84UlWKMWs88yXXb+tJbJviIN8TBm2Q4oxXBFTxKv
 UGWwWFaUv+MoVp6+e9qQPDmH9dkmXCMvhzuvBCBSZgAbsOgGUPozf0nvH+yTRQaW47kC
 D1AXD1ynp08wj7D3jmUo6cwfr05kLOMUYOaRzyxnhULqpPGw5RtHic+GzX/riXWEbXAu
 JerQ==
X-Gm-Message-State: AFq9FYLBDdLYgPfOitqMMbaRGNunyVSOJu9QSit1jANh9Ly8hfq5Nzot
 16rr+nvyNqRJthtrQo9BS2oT7ygQu/Wc2UbAeJsshR3q4ru0jr8N8Bc7
X-Gm-Gg: AYBFou3Df12GNycDE+t80+IrrSd4lRn0SczuKnEnApmbx2Tszc+oAbW9in05AfSt9EG
 oJRTPmz7uSf4QWOnGHkicQdDhwQ2sfp1Qkvjf8HJ4lbpDEGOMODq9KYI8ilhH+buXgfXD64wav+
 u2b46jgDhjh2OsaOBy9BGB1wKkgqVBygYUyZ5uDb7RfxqIKGrP1cWMblTXmNz3MR7Gg47TQbVKg
 bI7131brE7ho8GIEoHq6X8cV7gWSpk+hurVarQsaOzayuSUuFpsHXM4Q+WoMPWJiOB6QvbcGAaL
 XolWTORyGF37b7vkN/T9EVQJGLGu0o1e3iHK5/QjA4hfnx0juJpEQDixkQ+bYVGIa94/vSEd/Lj
 p/boGxrr5kc5UmJ5j7xaxA/eXoKB5/o5pG0LayBCUKqG+CXRMJQ8kfUw0g7SfI0sMYX+GBzrED5
 fcBz9ZiCjPomayMqtL1f2IQnizhZZvDmpS6VKpLYLq5ywJPmAMDsO2UibdzPOhoXR8WBsELBH4e
 AxorcAgMauSxF40rCbn72sE9Ok=
X-Received: by 2002:a05:600c:8105:b0:49f:fdca:c361 with SMTP id
 5b1f17b1804b1-4a18e483818mr177230995e9.12.1791806205442; 
 Mon, 12 Oct 2026 04:56:45 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9ac02cfsm18145130f8f.39.2026.10.12.04.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 04:56:44 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 12 Oct 2026 13:56:01 +0200
Subject: [PATCH v9 10/12] qmp: add chardev-window-size-changed command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261012-console-resize-v9-10-8db78320ba81@gmail.com>
References: <20261012-console-resize-v9-0-8db78320ba81@gmail.com>
In-Reply-To: <20261012-console-resize-v9-0-8db78320ba81@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791806189; l=2664;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=dkeeOHTveAXdNI/kP6dedj3UwMWp2MfG7Z9cA4CDGA0=;
 b=uYfseG+NkFrN578qMixlkIC9iFS8qIm1p7bMSUcfmTY1uJCNSU7Dh0igjQ3z0gZTeGo6SkqJP
 266eY4GuxXEAyDOTsamObwjkt8mq1rUiQaXDRAKbER5etr/Ii3Fuibr
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x332.google.com
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

The managment software can use this command to notify QEMU about the
size of the terminal connected to a chardev, QEMU can then forward this
information to the guest if the chardev is connected to a virtio console
device.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
[Filip: rename command, change documentation]
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 chardev/char.c | 14 ++++++++++++++
 qapi/char.json | 31 +++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index 8c8386e5b5..fe513ae962 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -1347,6 +1347,20 @@ bool qmp_add_client_char(int fd, bool has_skipauth, bool skipauth,
     return true;
 }
 
+void qmp_chardev_window_size_changed(const char *id, uint16_t cols,
+                                     uint16_t rows, Error **errp)
+{
+    Chardev *chr;
+
+    chr = qemu_chr_find(id);
+    if (chr == NULL) {
+        error_setg(errp, "Chardev '%s' not found", id);
+        return;
+    }
+
+    qemu_chr_resize(chr, cols, rows);
+}
+
 /*
  * Add a timeout callback for the chardev (in milliseconds), return
  * the GSource object created. Please use this to add timeout hook for
diff --git a/qapi/char.json b/qapi/char.json
index 7ae67eedff..842e003194 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -862,6 +862,37 @@
 { 'command': 'chardev-send-break',
   'data': { 'id': 'str' } }
 
+##
+# @chardev-window-size-changed:
+#
+# Notifies a chardev about the current size of the terminal connected
+# to this chardev.  The information will be forwarded to the guest if
+# the chardev is connected to a virtio console device.
+#
+# The initial size is 0x0, which should be interpreted as an unknown
+# size.
+#
+# Some backends detect the terminal size automatically, in which case
+# the size may unpredictably revert to the detected one at any time.
+#
+# @id: the chardev's ID
+#
+# @cols: the number of columns
+#
+# @rows: the number of rows
+#
+# Since: 11.2
+#
+# .. qmp-example::
+#
+#     -> { "execute": "chardev-window-size-changed", "arguments": { "id": "foo", "cols": 80, "rows": 24 } }
+#     <- { "return": {} }
+##
+{ 'command': 'chardev-window-size-changed',
+  'data': { 'id': 'str',
+            'cols': 'uint16',
+            'rows': 'uint16' } }
+
 ##
 # @VSERPORT_CHANGE:
 #     Emitted when the guest opens or closes a virtio-serial port.

-- 
2.56.0


