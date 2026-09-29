Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F470CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 16:42:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBasn-0005Ap-Rp; Tue, 29 Sep 2026 12:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xBasm-00059W-55
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:40:44 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xBasj-0006Ni-Dn
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:40:43 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912d391aso33648745e9.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 09:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790700040; x=1791304840; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BRWZ8HCyzchwEj+CIpCDAnn0kEs7Hf+pcna4vvLZ+Kw=;
 b=iI5AJ8q+dz5XIUup0Utu4B6sWy3ZuOdpf91epHF8RONiqX71wq6QoEpOlGFBIyD62n
 Mi6NjRtoCbaenlsFK5/inZ6GNYLoIYFTkdJ/meucbgZHTeDZ4D8tVqjh8SMO94czRJ0t
 FceWuenE8wz1a32jossUZLXCZiCc5u2g2/FLV25AbCPyoF3htTthHQVqz2IXPqhth+Nq
 5SpWUBZIDb9ezWYrGG5SVtXrEbWRS4MDHlwx4qG5E33KZZyFEpE17sFBLAyc3jCJxDpv
 QN2tTbUhHNKsqO2QJx6LP+lTbsM/ay3wxacB/9IvVtYsVIHMPioANEqMIhzhbc9z7Oq7
 EaYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790700040; x=1791304840;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BRWZ8HCyzchwEj+CIpCDAnn0kEs7Hf+pcna4vvLZ+Kw=;
 b=H7rCd8urpXCeT/WDWlsUq38o4KATaqXTlbuY3zBvJvZyhqz6JEFlJOUOURExrwFs/T
 2sD5v2dOvc94T73iEgEhTOWWYdxOXwvMaIqLmeG3w1cwBXu4umTVQojtK2Ra9VPmbX2Q
 61elzGMSMo5H/Sf1ussdMGeSppdRI8ndEUSI3v2RGG5+BIlHSRpc9GxcpbCIByJvtN1B
 gMDO6tdOfXEwRPgJBdRsBZ9KR3wx4LoUakQyN7SJu+F6pArWhFJFemP5nXEXW/oX/4U4
 oKAOjbvtKyiE/H+h7wn0H+hCk6f03ujY0MNPvXCGxuyWo1C/ROuD5K7wVODaOU30FIQY
 CT6g==
X-Gm-Message-State: AFuF++llT+OVyaDCZt4R4rQOp87EcgqDaSJJbS9OXoNtgPYtB2EwxFsy
 zb5M9MVe/ZqZrwOYu8WUk50VFl8ZaGgYltdDwECAy2IjFrzA2fF+0rkM
X-Gm-Gg: AYBFou00pK8Y4ZLAHf1MboQx2hEJq6NJCHH23jrzQEumy1lXcaiMOrbFACFTojDo3oE
 Qunpt8JMJu1TX1wxdYNACsywdUkRar1XEjshwEQyu5a8U0C7Nkc3CtAxC2Wv7uQn6wqO6Zx2Omw
 a/VeaB2frwg54pd6GTpYRasp8myFXCgbEPPG9F8dSGMJsom9rVoPK1qNezNqYboZuruKMtQN8Ds
 Qso0uh2n3pGau6oNUuzodOxDGkR2aAl9T6jU1kVVXL6+BUERSRZUFau7aJUmboywWzrxyeI58zB
 G4oQNpflnYBgjXwQJtbib6LWG091wNCiC1Wm9CiS/swFQn+WAFtVj8xvcsn50S6hrWMXNDrt5vq
 dPJkm7AlpjuWumYVyPV5J+1VJv5d50FHsTQFc8MKrimh5LC+pnpxRpVCYqruBRtTsSO6s3cJdxJ
 xU3MGUl2GUjmfqo7ggj8eNyHajAUMKjkmLiWmwc+MVI4kY2YKx31IwbYsFqRWcHesKkoeQIj1RT
 pJrgtw2RWBrzym5siJA6rNVfrY=
X-Received: by 2002:a05:600c:1c25:b0:4a0:561:d0fa with SMTP id
 5b1f17b1804b1-4a00561d337mr114395965e9.18.1790700039858; 
 Tue, 29 Sep 2026 09:40:39 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cf9b72fsm120638245e9.9.2026.09.29.09.40.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:40:39 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Tue, 29 Sep 2026 18:38:38 +0200
Subject: [PATCH v8 10/12] qmp: add chardev-window-size-changed command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260929-console-resize-v8-10-2ff9183f8750@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790700030; l=2599;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=n+2RAmgYfsWC58gOfmXRctq/+bs33bLCHtrrMkZ235M=;
 b=Ra8Vyjgvh9aYqSWCE5/YxfWv8W126ez2XWVsuEfE6Z3UTDimgPzsoPel51nHwRGBlVBxReJG/
 cOph8xqXoW+AeBTY0rM1JAOJHvSJCIErVfyhZEfhowwwFZ3jIRuhsjz
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm2-x10.google.com
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
index abaccefa97..2037836172 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -891,6 +891,37 @@
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
 #

-- 
2.55.0


