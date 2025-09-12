Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D9ACA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 03:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwuhM-00075w-F8; Thu, 11 Sep 2025 23:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uwuh8-00072s-27
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 23:43:30 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uwugs-0007w6-7x
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 23:43:29 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45dd513f4ecso9233435e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 20:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757648588; x=1758253388; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=baYb+HxzqfFXNtYakQW3qcYyBFiNYOZzvwE6cidsEmY=;
 b=ZxBY8PbnALepLyIeiPbM7T6++qOlAdQwv0p+BM1gsplN50/ghlyPxQj3q/P8esqAIS
 IGAsc2fhJS2czPKDYn3R408jtNnIhKTueEMlYXcss3tggQ+6oV16bciyquDYb63NpSAx
 jJ7GXPe4VoujkoZv3Na4E32OUcnw1kUj3VigKHhXwUYO9t2DsfA43QFwl2qpowO5Ldka
 zDfMZOV79mbp3C8Aryk5KvoBTkKZoh80pSSTqjqyYaCS88sDhhbfa+yaZMblPxqL8EEZ
 ibbth5TCykBlzav/NIBac1qf82hhfQHjaFkPUoIqt/BlmSKK0dRwHeslUd6Yyz8uMuw2
 ipBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757648588; x=1758253388;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=baYb+HxzqfFXNtYakQW3qcYyBFiNYOZzvwE6cidsEmY=;
 b=Ky8H3Wra9oKsNuc08rfregWbDjua1/1SEicvyiolXKIs+V3bRl9fUD8u4ztDgYnlHU
 nfKKwgenD2Xi6+FsNF/095PR2J2qjdg70vSggbt2urKCHaZfsdigRmNX0v8uReI1vgAV
 c3ShAis58Ty8YYFOxCPoBDlFw3ZejgC5UmZQkIexAR0do49+hXyYL3eE4098gqg4ORi7
 MB5AZf1x0V6PFOrH1vHeLDnvuKvBFp1HNtaR9EVTqllvMUl+EOCJbB3a/0g+/9HXzj9o
 fvWRQ9cj91IgAfyCzZPRK/H2i6TpFNmL2XVHwRS0tLhvWFDJXOn17zno8jxBy7YktEqZ
 JK+A==
X-Gm-Message-State: AOJu0YyxP/su4BKLA5gkDwC8lfPMrD5wr9tcKnhmSSGXjsaZDEttOqdz
 ORa6sZqQvMdB4o6SGuh03dXMOzuNHFTz/Wgbd2GTDQbu8FBCVA/+8Um8
X-Gm-Gg: ASbGncsvKf12LeL/Z6pG6dHUVvXqpcZ4y0i6NuKhiCrsxJzz+tIPlHUNIxj05CRPAJV
 pZbxa05/dgGmmxKj/pvthgFdFplywRrwZsnjMfdQL+zMXHrdeU0u94d5H53U3JUc4hqrABKC72/
 kVuSrzDvtBE2ohTRaz+qNpqPN5K5Pb4OIB1A6RW9ggdqwDnt33FhUgqR4tVWKVq3sgwL9oLplpr
 IRRX1y9NICCMhiVFxclO4S5fc6zB2iN+I8yo1F6aJ05V0FFZtD7NFoOsNB80VvgPqtPXmxj56vg
 jRJRU+1IbJPppddPhWmkhjUJVtqlokwLZRSI7d42LNzeVMBY9eV9LpOQntYKV7FmsUdZ6GYwTKD
 H/Kkv85lmXhQQ0WFTYEXdPaVmhbUVDJmzDB3cCUYqySeeSCE+HaT0lRVsjOFL+Sg=
X-Google-Smtp-Source: AGHT+IHcPEUXw7ENRx6VBy7qfjJyiGr0Ci2H3EflbTWxaTovK4fBgiw4u5EfbnV6+H1rxoJvrNwuVQ==
X-Received: by 2002:a05:600c:138a:b0:456:19eb:2e09 with SMTP id
 5b1f17b1804b1-45f211e575dmr16702565e9.8.1757648587988; 
 Thu, 11 Sep 2025 20:43:07 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3e7607878c9sm4886166f8f.26.2025.09.11.20.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 20:43:07 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Fri, 12 Sep 2025 05:39:52 +0200
Subject: [PATCH v4 07/10] qmp: add chardev-resize command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250912-console-resize-v4-7-7925e444afc4@gmail.com>
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
In-Reply-To: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Szymon Lukasz <noh4hss@gmail.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Filip Hejsek <filip.hejsek@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757648577; l=2157;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=ygcoBaTfXtGVLn2OapvW5OlVL7lLK2XiaSj1n6yjo3Y=;
 b=9HrdVfFhAM+keDA6ZbOF/M8wNDSRZmCjMP/T7gOc8NI8HXzCOT2qpxHIqWU3ZdUa/9qdge6Ig
 pLEL8bDWaqnCyYpTzEMaRybZrv7ZK496kxHZI8aLNlWz8OQ/smZoiqu
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 chardev/char.c | 14 ++++++++++++++
 qapi/char.json | 22 ++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/chardev/char.c b/chardev/char.c
index b45d79cb9b57643827eb7479257fdda2cf6b0434..6e3ade98614c949be8041ec5905a490ff536dee9 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -1269,6 +1269,20 @@ bool qmp_add_client_char(int fd, bool has_skipauth, bool skipauth,
     return true;
 }
 
+void qmp_chardev_resize(const char *id, uint16_t cols, uint16_t rows,
+                        Error **errp)
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
index f0a53f742c8bee24c377551803a864fd36ac78cf..0a26c5eee6b71bc5de127a91b253cc69a9fe8ce6 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -874,6 +874,28 @@
 { 'command': 'chardev-send-break',
   'data': { 'id': 'str' } }
 
+##
+# @chardev-resize:
+#
+# Notifies a chardev about the current size of the terminal connected
+# to this chardev.
+#
+# @id: the chardev's ID, must exist
+# @cols: the number of columns
+# @rows: the number of rows
+#
+# Since: 10.2
+#
+# .. qmp-example::
+#
+#     -> { "execute": "chardev-resize", "arguments": { "id": "foo", "cols": 80, "rows": 24 } }
+#     <- { "return": {} }
+##
+{ 'command': 'chardev-resize',
+  'data': { 'id': 'str',
+            'cols': 'uint16',
+            'rows': 'uint16' } }
+
 ##
 # @VSERPORT_CHANGE:
 #

-- 
2.51.0


