Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE7CCAC5A7
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 23:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v07Hf-0004zx-Cl; Sat, 20 Sep 2025 19:46:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1v07HW-0004e6-Uj
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 19:46:19 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1v07HT-0006fn-EB
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 19:46:17 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3fa528f127fso110153f8f.1
 for <qemu-devel@nongnu.org>; Sat, 20 Sep 2025 16:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758411974; x=1759016774; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HYx7pMoLMlA55eAoyUpvv6FTZmSkAyUPk75Kdc+JD+M=;
 b=ipltAab5kBo4VDABpIUVJEutnIVIiRSb1Bo0ippQGb8e2ODryUlAa+6FMSlwV3+H34
 6uVb/LPfGv101PptELFiwqmDGz05katpjL27DF9pDc0/7/Z2eQqQ0RBVm6VDDPE9RrWQ
 LR8ZHaDcly2+ZW0S8sEEyVu/ErjD4Mgbn5EVPjcOVMNkKwqdRSDZAm3DjtI7c/zC3+ww
 lX3WlsIoVkxMZFMhLpGjF3kDBD9AeqsGbEXaUZvmexzfC7iMII/xp/CkMgTlCnrl33Um
 6C3vAgjdZ58himeJ5T7NAOPdQkc7S0+OgUlKq7ATgnvL4o6m3Yt8pN0pa9bN7blSE7xW
 mxXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758411974; x=1759016774;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HYx7pMoLMlA55eAoyUpvv6FTZmSkAyUPk75Kdc+JD+M=;
 b=PoPvwiVmT76nqAjCRFnRaGnViI81GN9L8+B2r8SrNjLUOzfhD0T9S5+cvV8h1mlLUE
 8Ebgg+0j/s0SrGVmsrr9emFZRFi1+8/YCwzMmjCrvfxtP1DZvSCFUxMFY3uRCiizpt/J
 RidsThHRB6l2QRRLV7OjmfETlNHXs13qzRhw9fPjTq/2YoZkbiEDGdbnvBnEXP5y49+d
 U1owu8sZgQv/2lFDMLfW9kSCDqvRiNETJQHGQqsRfBRvDynqLKqviIJ2px71AmLQsxPC
 d0CnucTEW4eF+A5nJauEfvmhrfY9i8Miffnnjom7k6PhmKkkLVRdR00fKOvTx8JQ55RR
 D4cg==
X-Gm-Message-State: AOJu0YyVT4kBGJckopwLEHq52hiX4gvdWNZgNlKGCVSG96EQMCN+BEqQ
 XR5949ZWyh6brs4q3EUxEg20D5FdrFTJpjEmpiJvCaX1NFsv1aU7kajQ
X-Gm-Gg: ASbGncuYIx7TFtdkU6JCjYKMnxSRmV74tPEB7DByKVAqO/GYKX6uRcoathJHPQs9Zqk
 aBhSbktxdBQoknTlla+RBduB68SP82MWvdM9OaWd/hdsEVk13cpOtd1d6xtVIdeLQ57kzzJQugb
 Bp/UXV18/EOW86BbbbaGNeFXt/h5ywydqR1iPsGRgHrSjnxKByjOxa/varNwDEgoeDy+BWKypnO
 isf1XMQQwrEITK0c/BvmnuqtNjX+v2LiwsTnd792Ty2Wa9ro5mdzwgXjxtIPC4gEFUrw7LuI/tZ
 sbJoxqzVY6SdbqmVhLmis8yNZ+jLJ1EYokI3HwuYy8To2MANMfXhGfufEXDMNep6PTuDjDvmpRt
 jXAKwpw1X0jyiUoHZ0xaBX28Ybna2sGtacgiH7KrVxfG3Z0EnOXrP
X-Google-Smtp-Source: AGHT+IGPN4r096oi637NfyZhf47t4mGi0x+7iHiXoyRm6ajNwJPkPpCEkGY7RArCZJqr5zUqE+jJZg==
X-Received: by 2002:a05:6000:420d:b0:3e9:d9bd:504f with SMTP id
 ffacd0b85a97d-3ee1acd872cmr9166383f8f.21.1758411973716; 
 Sat, 20 Sep 2025 16:46:13 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-3f0e28c83d6sm7956363f8f.56.2025.09.20.16.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 16:46:13 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Sun, 21 Sep 2025 01:45:36 +0200
Subject: [PATCH RFC v5 06/12] char-stdio: add support for the terminal size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-console-resize-v5-6-89e3c6727060@gmail.com>
References: <20250921-console-resize-v5-0-89e3c6727060@gmail.com>
In-Reply-To: <20250921-console-resize-v5-0-89e3c6727060@gmail.com>
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
 Szymon Lukasz <noh4hss@gmail.com>, Filip Hejsek <filip.hejsek@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758411962; l=2562;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=V63fftPmCKW7OIY7EbGz9LcdIQD/m0AHLknnEXYwd4g=;
 b=eSEs/mTzvYQHHmv7A6IM68Xu+N/P5wwB7eAsjpJXFkUmdteOu+Om8kOWKKOi2dgnfeO2XKDC/
 n+qZgHSBnxYAbNWJKCFTbnwXdkg52cJ/zJlhUYI6wn1a+WqXJ8XKTao
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wr1-x435.google.com
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
[Filip: use DECLARE_INSTANCE_CHECKER]
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


