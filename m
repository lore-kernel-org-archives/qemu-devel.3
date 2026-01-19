Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B758CA5FEC
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 03:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhfx6-000762-PF; Sun, 18 Jan 2026 22:29:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vhfwg-00073C-7M
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 22:28:51 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1vhfwc-0004BD-4Q
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 22:28:49 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b87677a8abeso648065866b.1
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 19:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768793324; x=1769398124; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CwdpHXJqzSVJBL7iuiAdXf2ozQwuKqDkTKYPeqcNrWI=;
 b=EeSDTrYNKJ/9MmMCx5+QbvyWG4LMppZYGA6Wct/0YtyE3komKztsw4Vg9mAqmRiOOg
 du9d3C+g7ru8HcrmwrxDSeuNBRm0EGvhMrNM/2/P4W4+cYKtCLKVhJztJp48D1HUFNKM
 F8yz/sIrhTbCscRZT5rxudcMv8spLIrMojnAFK866qIaw68NqtM1ZLJv1Agig0p+1YXI
 7WyUYmz7Qxg8E02tAX6fkbGdT0NFhGKlWrD0gcRke35Y/Kxi1v0ZeKvTucR41UVx7rea
 Nu8oc8RZyDRNdiNjqv+eElM4ym4l9Fr4kfqbQtUhwKdGa7ruKfOyPzDSegqigT+nXeho
 N51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768793324; x=1769398124;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CwdpHXJqzSVJBL7iuiAdXf2ozQwuKqDkTKYPeqcNrWI=;
 b=N7BY+knaglQ2qVRbF1ZYFsdYRygvLzg+PYf1JogIE0PeLEbNbXP7K/NBt5ph26ZQVc
 936D+85aQVN1c/HiGoZoyc/hzJi5LUlqJ7a3ic47mQsBlxjcZzACrE0uXMfYJotsKd0m
 mpS4TzC7DUwsaFuWBCilppIZ/nmcks0YyR229HrcPZjyuW3pLXLUyE+RQ6tu/B5llzB1
 NKoJpTtoaQpbFBqkKqVT4IJQ8UIidlFgyGHtPJj38De7cvLfXqeb8UppVJ3HdTpY0mR6
 SMcYUlgklt6IbyArsy/TBpHNmIh4kn4gLW9w1jnSAgeGf4BdLlKwj8Vm/1pqx/pD7fCl
 /akQ==
X-Gm-Message-State: AOJu0YwX7cSOyHEBdWkvEn9K9x13zqCkBWt+zRBXDOvm6bsplSz6z96X
 raDcpS7Cqr1uSVvfyXCJdJZ1PiolcWDoL54fgoKyQ/eop0bHSADzEvwm
X-Gm-Gg: AY/fxX4CcvdfTzsfyT+kWGlS2WWoKyJ2QXwR4yWobUxM9oX1qkme2Zd4fpQblEx7GRy
 iUq1gaK+nOMJPGwiPLT7iiGetjwM6k9GNR6k9wff+mg+s0xOIq/c0b3kzyWReBaK1ta5jKMav8g
 0dcF7L6ImQbqh1utJRtiAtOyygFrC4QKmA2efjGPuZInrfF5dBBd31Qkh3sGFkpmIxug3jX/WfV
 tykc4UTQGQWcZ8fS4NkAk0CsRTmHK7U+8yPPUnJiGVqR2VctRhpx2T/Uo/3K4p06V950QxeQWdP
 N+jyZ47dapHq/7o8wbq9GaMheQmaC2lpv95jV9hd4YNtAd/S/NL44r8SbTDoQvA1rl949I1RjRb
 a56X51U5KBw32KakSq4oSv2Agxx43tR+gy1uXM1oM06OXpJPTVarXHQUsAdgKxaDCWGGjZOD3Er
 /mqueKK9TlBr2ul6xHfTNhO907Ok8FLGnTIacb26Fk78a1bMOQibM=
X-Received: by 2002:a17:907:9405:b0:b79:f8ae:a893 with SMTP id
 a640c23a62f3a-b879327f09amr851085366b.49.1768793323683; 
 Sun, 18 Jan 2026 19:28:43 -0800 (PST)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87d1e6dd64sm236511066b.32.2026.01.18.19.28.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 19:28:43 -0800 (PST)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 19 Jan 2026 04:27:49 +0100
Subject: [PATCH v6 06/12] char-stdio: add support for the terminal size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260119-console-resize-v6-6-33a7b0330a7a@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768793314; l=2558;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=Y2PdlDn9BtibdmNVATyYsNZJjK+AQSI47PNbPt4RVGU=;
 b=nK49SIEzS7uNwEXaruzPmJbjxZ7KZG+Pjv0qJOfAbGSi9+QPU+1QQy6o+T9rcrLUZ8w1SFf4H
 rRbBGI5P9urCfPqkxsFzwLvRGHn1yRwK42GJ5/NpDKSTl6Sg5OJ+oU7
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=filip.hejsek@gmail.com; helo=mail-ej1-x635.google.com
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

Update the terminal size upon SIGWINCH delivery.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
[Filip: use DECLARE_INSTANCE_CHECKER]
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 chardev/char-stdio.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index 2568164a10..f55a7be24b 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -34,7 +34,9 @@
 #include "chardev/char-win-stdio.h"
 #else
 #include <termios.h>
+#include <sys/ioctl.h>
 #include "chardev/char-fd.h"
+#include "qemu/main-loop.h"
 #endif
 
 #ifndef _WIN32
@@ -46,6 +48,14 @@ static bool stdio_in_use;
 static bool stdio_allow_signal;
 static bool stdio_echo_state;
 
+typedef struct {
+    FDChardev parent;
+    Notifier resize_notifier;
+} StdioChardev;
+
+DECLARE_INSTANCE_CHECKER(StdioChardev, STDIO_CHARDEV,
+                         TYPE_CHARDEV_STDIO)
+
 static void term_exit(void)
 {
     if (stdio_in_use) {
@@ -85,11 +95,26 @@ static void term_stdio_handler(int sig)
     qemu_chr_set_echo_stdio(NULL, stdio_echo_state);
 }
 
+static void qemu_chr_resize_stdio(Chardev *chr)
+{
+    struct winsize ws;
+    if (ioctl(1, TIOCGWINSZ, &ws) != -1) {
+        qemu_chr_resize(chr, ws.ws_col, ws.ws_row);
+    }
+}
+
+static void term_resize_notify(Notifier *n, void *data)
+{
+    StdioChardev *s = container_of(n, StdioChardev, resize_notifier);
+    qemu_chr_resize_stdio(CHARDEV(s));
+}
+
 static void qemu_chr_open_stdio(Chardev *chr,
                                 ChardevBackend *backend,
                                 bool *be_opened,
                                 Error **errp)
 {
+    StdioChardev *s = STDIO_CHARDEV(chr);
     ChardevStdio *opts = backend->u.stdio.data;
     struct sigaction act;
 
@@ -123,6 +148,10 @@ static void qemu_chr_open_stdio(Chardev *chr,
 
     stdio_allow_signal = !opts->has_signal || opts->signal;
     qemu_chr_set_echo_stdio(chr, false);
+
+    qemu_chr_resize_stdio(chr);
+    s->resize_notifier.notify = term_resize_notify;
+    sigwinch_add_notifier(&s->resize_notifier);
 }
 #endif
 
@@ -162,6 +191,7 @@ static const TypeInfo char_stdio_type_info = {
     .parent = TYPE_CHARDEV_WIN_STDIO,
 #else
     .parent = TYPE_CHARDEV_FD,
+    .instance_size = sizeof(StdioChardev),
 #endif
     .instance_finalize = char_stdio_finalize,
     .class_init = char_stdio_class_init,

-- 
2.52.0


