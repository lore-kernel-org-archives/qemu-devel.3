Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DF9C98315
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 03:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhfx8-00076F-Qw; Sun, 18 Jan 2026 22:29:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vhfwg-00073A-6r
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 22:28:51 -0500
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vhfwc-0004BJ-84
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 22:28:49 -0500
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b876c0d5318so521172666b.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 19:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768793325; x=1769398125; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QjYYTAGZ0dsLKrWo60hSXmC/6EhVgSqPUKptBg48els=;
 b=VX2eb0VY0dZ3Y2K/M1+3MuZTp9/J6C983nkGWS4jSh1XrggAa68Fx1vb6mF0pd9gxC
 Camf6bhu7+n3Um2F3SZY7FgKsiXCx1kVHdWLE+jKwQCOF3IjvNjR8LbN0nyghfKDOPWs
 q7Yo0wmUPwzzQyRaElv+qAY+2cRKnaNR9xvkeowRYHueSbEMbTtK2kyXbZzfZoIbpNQx
 WURc0gYTyuGwexC8FO+qYJ2/M1sAQBFfluaL+b+S190jV6omuq7+Iu91rzeodSGkmRIe
 cEtv7i4JPremP/LVrT0ahQyLACViloxHfFXRC684XFb74PjuViW4bFUx+gtdCDOp0UeM
 VH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768793325; x=1769398125;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QjYYTAGZ0dsLKrWo60hSXmC/6EhVgSqPUKptBg48els=;
 b=IgQ6GCEPCYfgxcl2MVKqdVxTt2+/wWpTU8SWEd9FXntm67ySQY47FljCdTFhCkDzvC
 yL2YQjY0uCTDcYAyhBwKbfD5UHJPwu8DCZtrZqzGFa9AcNFZBPFR3C0OEKajwJ4ht8Oc
 PydrvLfwaF+LcDyWw1ikPAw+rnKaygwm/L3jQwDSPevDy6WKP2uymwjclpZoiLKyshki
 TQ4UYrvBa2ClQ5vI9X0s28HhHk3mpaFRLIeIrCrZUGHP04kQvfLSJech34/lcnQzF5De
 eGqCah1z/a2Y/XoExk2g/01Q4Al4FzMoXuivdBE8fnCGvb24cyHFrcngVMxjas160sqr
 O5mg==
X-Gm-Message-State: AOJu0Yz7XyaUK7V2dHaNpP/sQQIOJq1mVVIsDrsC5HGRtTR76KZOIBnH
 DFBZQvEreANyzFEQ3Ejjj+luVHY/HJjQrTzY9A08gyh5FituYp0+Hqti
X-Gm-Gg: AY/fxX42vyWmGD+hBi/2gSL6lB9iDJKwoGYHEAUIjYJCjMiFG+zd2JZeStcicuMagyF
 gHeyxipC+sHWnWOaIPpeJP4U1vA9t++6ByfLL/pPgmD7/hFcwEVJ/J+79cUpe85b/KMrvQo3npA
 bCjUAW4s3fqTT/LzhM5phdApQ4fGsVoVfJMa64wAxbbWLeyoLEr6VfqJatMUSisWz5yySbBuBNE
 AnTTY0P6aVoQc0oCxi6ZzfCFcwedofbbnysMYfzVpZ4mv0+lPX8koPcG6vcf0jBh9CdiDpqGkXP
 Od2pH251vLP/76wdf/WDOLTIwFo/atTy2PJ4r+y3XUBnZRFXM9/7koGp6QxIoY0fpMrfNNT/PEQ
 UjKFNAaHVfxKzuxDjAuU9EvSRDJrPx+GJQmdJOpHGDw9wuO8G2B14VLkionAWzIfb8UxXsxQsAI
 Id0+0MdSSV0ahXgmA3PVHcm6rzn9dVRc0N+tKka7AuaF+0PqJFrsM04iLhuvMYHw==
X-Received: by 2002:a17:907:1c02:b0:b80:a31:eb08 with SMTP id
 a640c23a62f3a-b879302426amr833208166b.55.1768793324687; 
 Sun, 18 Jan 2026 19:28:44 -0800 (PST)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87a43c7348sm842497666b.8.2026.01.18.19.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 19:28:44 -0800 (PST)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 19 Jan 2026 04:27:50 +0100
Subject: [PATCH v6 07/12] qmp: add chardev-window-size-changed command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260119-console-resize-v6-7-33a7b0330a7a@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768793314; l=2611;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=hKtxDSFGj3QJHK5lJS0qxk5mxai2n8cCxcT71FLDhQI=;
 b=7fvbnYXc9BYStkd0100kCSbzdXCk5SI/XeIthvy/deZNtNrmCW8ILcmrA1ljCMtoSbTgtpRkg
 FkbALhWHnLwDiOjK/g1Zq8nqAYLG8QGTBDJ59+eZ/nIWM/PUwR/H3SW
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=filip.hejsek@gmail.com; helo=mail-ej1-x633.google.com
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
index f3c6a12c99..458059a9e0 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -1266,6 +1266,20 @@ bool qmp_add_client_char(int fd, bool has_skipauth, bool skipauth,
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
index 140614f82c..bc08f0161a 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -861,6 +861,37 @@
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
+# @id: the chardev's ID, must exist
+#
+# @cols: the number of columns
+#
+# @rows: the number of rows
+#
+# Since: 11.0
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
 #

-- 
2.52.0


