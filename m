Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E304DCA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGGel-0000Sk-O5; Mon, 12 Oct 2026 10:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGGeh-0000Ic-Ki
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:05:31 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGGef-00069o-Su
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:05:31 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4a018dc1f98so15346465e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 07:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791813928; x=1792418728; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QXl9Yl5Xju6RUUl/m80Z0Pv0GGgyouWP8vKZWY0fpzk=;
 b=Y0DaD6zQ3Ti/typVGshsXg0OxrCUjYFMy4lG2F+EPnkNHHRM5KAvDj7BtqPFOMWMU0
 q4tHn8TLvUjQd19r+MDrdGIVpvdZ84T581oym5rEtAzmAnSLYYFYSwy7VWbP1KL1E5yE
 YZB3VK+9cHICdGQt7cQV4NuJgp+GX3hzZSrszIOfpnr+wsxBpQKNNJinuX4VANNoflT5
 Y6aNzTJrHpCxXO3BK3CwTCL/9OjqnDPNOK61U85hxv6hsCKk9bfe/pOcn7TydZQbhrEP
 kU9pjDN2Vxson8u0Tu7oHHwdXGf6e9Ldms5arTMq3gb1l/vyCbjiNIreany/EY4dXmwd
 k1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813928; x=1792418728;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QXl9Yl5Xju6RUUl/m80Z0Pv0GGgyouWP8vKZWY0fpzk=;
 b=eFf+OHf9TDKMLhhBzGrT0dyADHYHqa+xrh9J9NNa55wYU8+l/lGGOPFK0HMVSMrpIB
 H35P4oltzI8vRApmGVjIZXt1AfLSDyvksWx568hagDl4SYSO3UBr/lZfBNnJkWUJXyOo
 TyTKzJi6Cfl6QWN5qESp29b4VVH3vj0IQOdtgt/2+R3MntgEdJIS60sJLq3EV6A0IWkv
 NuC7arwR9j9u4ctrK603ndUOK5quP9ehGarK6R3+8dz49kw89ggG/dPB9r9vRYceCBh7
 TLBK7ljC16QR2MmOHsTizTKMGz/Tgs9OPlf0Ymg2vrJsGjp5I7+KXxLl6WqWfPLcb3+m
 8DQw==
X-Gm-Message-State: AFq9FYI4Zn+H8SxXPAgvzXfiAl6ed49GlFXyMVD318nwOUT1/+d9lKyy
 wC+Kn+dfKWx8ZXYQ0oMOgDIzUtd5fLeVjm1b/Ej/Or2x6qzGh/4Gt4/w
X-Gm-Gg: AYBFou2ukKOpQKIyKNi3LS4Fq0ukl46jpuiu/R8Kaw2OvENUBX393gNXsCU/KY3Bye0
 YKotJqjshxS1qendMnwRAvhScJbud+k6ADrm8yEWB9R1GcwiqkdTR60GzpBgi3j0PLVVXQg8KfL
 nkSPxvr7kW+FN0rgOTwh0g/hXvLtJVA693ryOxAh7UcdGEj/odK7UpcvOddWL6R3ePgnXeE2nGx
 h0Wvo4z1vYRrT7itmWj+FGWfIZIW9A5TN7gDs4+apdJEzLrUyFFygrtEBuwRebnHqLbgPGRwM31
 SRMWJdVn/qNK/cBlUWWzNNy32j4xoL0M7qfh0EHfd8zDBjD4DZytsOq9oEFwoNY5xSGE6YMuK7B
 QzkEdbzX0opLDGLC+TBkD3XLDrZkTvcG0XQoHHOwcxCsvFqtkTw4crnNF9ERFL/ljNlZD8gi3PC
 FktYMay7boL1x26jUfdmGY6wqS9/n8gSTsgRCVou4vg2rp3zXU2H0H/tnZhR9LVcuSs0snM+XQO
 /ZABAYYhWvBXQxbdNTdF2D5DA==
X-Received: by 2002:a05:600c:3488:b0:49f:e941:d6e with SMTP id
 5b1f17b1804b1-4a18e4c05d9mr182482345e9.21.1791813928351; 
 Mon, 12 Oct 2026 07:05:28 -0700 (PDT)
Received: from localhost (ip-78-44-39-34.bb.vodafone.cz. [78.44.39.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9ac94c6sm19537061f8f.42.2026.10.12.07.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:05:27 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 12 Oct 2026 16:05:09 +0200
Subject: [PATCH v10 10/12] qmp: add chardev-window-size-changed command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261012-console-resize-v10-10-2c3b10d829b3@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791813907; l=2665;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=EUZgLrU765xvEyiNI7klksTLZW/Pwy/vd1jodSNW3XQ=;
 b=jt+4jIsb2UNXt7YhB4LCKLGcGKwqBws8mvQ0aCLqwgjxZ/uYmJHEt/01ASPi/XaBDAaY0ZcdC
 12GkHdlD97TC/a19zI8h14pFLF6bacn45jpLmDbH3XI2wMgJ61sqBix
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x336.google.com
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

The management software can use this command to notify QEMU about the
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


