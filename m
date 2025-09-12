Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDD5CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 03:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwuhP-00076Z-DG; Thu, 11 Sep 2025 23:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uwuh4-00071c-VK
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 23:43:28 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1uwugr-0007vl-Rq
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 23:43:26 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3e7636aa65fso849631f8f.1
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 20:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757648587; x=1758253387; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d77nWuC47XfRFHI4ruZnmhk2E1Ts/1RIwnXpyxIetgw=;
 b=IHpAFw+unVWm61dj/llnSN1UrdWmM6rAIh4dYySCaVmiLdq/Ww9JK6Q/iJ8dSjukm2
 t9RyCQYHK8raXT2puaXWxboxK90gysKvYBHBK8Bs3ZsM8MV/QsgCsRoMScCRxf9J3qZP
 aIM6AxOGgHiPl1BkSIMMhbVc0fqvm0nNUnqKRkJ3dFP7YsnPrCgC89v2/0kEVqT/QcPc
 J3OrlVBUY6C7ciUWQi9DFluT8f8aSN26eCm6w4izMmo5ulQl9mbOaaXvJ+RCIbKb46f4
 ZkSSka3zxD9z5oj68i0VtokqjwOVyEWpWNDBc8/ITUVGciKU/LQiZnr/QvsQkD1eM/F6
 x1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757648587; x=1758253387;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d77nWuC47XfRFHI4ruZnmhk2E1Ts/1RIwnXpyxIetgw=;
 b=MoobFlSACmwpxG/7yn8h9tsMXUQQyXnN7tbHX/iSXuugXP7cXmbXv8XcDl0AELN17z
 tK2qbORuWcv+brQ3SlGPFvBLwwYQt26U9S7oScSFaF3kiZYDQlXX8o9yOXMUOdiu4wzV
 mPpWVF6v5oR3ZtSKh0AzHdFDYmG/tO2P83lFHBPIG0tItA6Sn/SeZb8Agw83ofZmLgxh
 9FObLVxLrg6cccfp7FuKbWVhHHfNviRGA/ZuCcnGTpNHIDLpJa3kFhEjBkK1nlP1+nlx
 xU6fLgKq0xXCZVnemQuQOJELAcrtkKyx42DG/TcOlzvlyzs7SSFdfgkOsIL/zcF3szbH
 wRJA==
X-Gm-Message-State: AOJu0YxyVhchUYiUPBton8aCjmJfCSILSN9Gnboe4s5unwsegKFqXNHf
 g8FBLfyLKd8hc9pDecgEuTuSumhjC3j1j9SWjhKnRi5RmJamMV+Hq8NB
X-Gm-Gg: ASbGncu45to3f2giL4KakCrJ/tOb8wxMDpnVdxuTEPQm2Qe+1BEZRexUAJ/hNb0NzxX
 Sq68Sksj7wUBH2rdNXCiiK53UrdGgxRXOZvLvatmVSNabagJWQz3NG++g0wgtg90BlHPH92CDSU
 iDubodWaeTu34ukLXGAbGbC8tMpHYLUtTBn4fYbgm6U5JJHxZgyqPf/LVYjDQv+sMBlY9zL1HLI
 Az7tNAhyPf0GXxGKF7Hr+COhqovGVLZ1ToAHeBLPv0/BU2+HXbGZAVG+AoFbFe4Cn2yvyEzT30g
 aaWXfYrQecz9GA4MpsuG0ZjfcBfZIXth6PWkHAt4vEax4ao8S2NXLAjEbSgjUlEQQl4n3E5dGds
 hng9hJHhVpWUYBvabDH2ARjimeVX343c2E9EpHipVIm0U6XQ6GoJwBUMaskFZDrY=
X-Google-Smtp-Source: AGHT+IHi9fBq25/cck8R/Z45AHN7Hdy4VuXy7Au7YGZWL/5aItRt4hcuTEAPEvPi64pBp49ujwwkww==
X-Received: by 2002:a05:6000:24c4:b0:3d7:94bb:cb9d with SMTP id
 ffacd0b85a97d-3e7658bc9admr1093720f8f.3.1757648587024; 
 Thu, 11 Sep 2025 20:43:07 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3e7607cd9fasm4777495f8f.35.2025.09.11.20.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 20:43:06 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Fri, 12 Sep 2025 05:39:51 +0200
Subject: [PATCH v4 06/10] char-stdio: add support for the terminal size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-console-resize-v4-6-7925e444afc4@gmail.com>
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
 Szymon Lukasz <noh4hss@gmail.com>, Filip Hejsek <filip.hejsek@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757648577; l=2523;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=fO8C30Ob+gQY1M6bMPNNeQaVfv14CUk8QR9kMY9JTd4=;
 b=cs7y+LSxL6p/eJw114HERl5AC8+eq88ULb0ZhmzOK//WGkgMx9UdiHomfdu/eITO/BrOpG/fm
 nQ6zRZabiNSDV8uVh4uhPDXb+gbMWkM3taVHlAygNWaqr64xsrV56gj
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wr1-x42a.google.com
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

Update the terminal size upon SIGWINCH delivery.

Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 chardev/char-stdio.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index 48db8d2f30fcf0b481c79ea69aab720454596a05..b3475391f088f1e570b74cc40e30f679dbe9b574 100644
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
 
@@ -121,6 +146,10 @@ static void qemu_chr_open_stdio(Chardev *chr,
 
     stdio_allow_signal = !opts->has_signal || opts->signal;
     qemu_chr_set_echo_stdio(chr, false);
+
+    qemu_chr_resize_stdio(chr);
+    s->resize_notifier.notify = term_resize_notify;
+    sigwinch_add_notifier(&s->resize_notifier);
 }
 #endif
 
@@ -160,6 +189,7 @@ static const TypeInfo char_stdio_type_info = {
     .parent = TYPE_CHARDEV_WIN_STDIO,
 #else
     .parent = TYPE_CHARDEV_FD,
+    .instance_size = sizeof(StdioChardev),
 #endif
     .instance_finalize = char_stdio_finalize,
     .class_init = char_stdio_class_init,

-- 
2.51.0


