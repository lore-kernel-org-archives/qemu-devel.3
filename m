Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38AFCA9ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGGei-0000Id-An; Mon, 12 Oct 2026 10:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGGeb-00008c-5i
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:05:27 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGGeZ-00068a-FA
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:05:24 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-486e70f2457so837834f8f.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 07:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791813922; x=1792418722; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ovp9mreBHCQ/mLVkPzCXV5rXY3EL6//8R2a8gco0LLk=;
 b=FPafJizthMkYmb92iQjEHkaVZJKhkhzTxDLsL47McGmCMOlswmpersJF6KruiDhWSM
 VNVQpYGUmkR6dgA0dgHeRkh4im4O5MybgC5FOcGKuRvh/YTFyzq6wsLAppqeFU30YStE
 dGJMAyp+iRcHpGdI+PcdZ2u5jAkz55Ifj6Cox4KBBxqlq90EGczZIf9C7zpxWWP6DUou
 06bU+LR6RUVE6QR9gxxoQYFe/78kJyUmrFUItv8f1d4PcF7Nk1vcdVJ20rDRt2HESsiB
 p7GibjJHR3Fo4vFrqKQav8NFcBOtEw6jjuq1+GBnMxBcvyA+QGh0U8hK5o99V9FrsmHg
 YsNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813922; x=1792418722;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ovp9mreBHCQ/mLVkPzCXV5rXY3EL6//8R2a8gco0LLk=;
 b=gr81G/Pi+xjgx2avRTCA0jynunl9Vl/PRL8Z+B4/LR7oOA/nah5vQG9PgQeL4AVb/U
 AkE/VyBR8H1m055ulkwTwbcW8NS1kpm2r2nFByjI7AJWgh7Mdk2kyYHBuPw0tejYHvuF
 5NEasoc+tkGbgOZWEkbUaaUSok8oNyE3jWA4p3p5Z+CwmxXSJUOB3Ev4lWFLJ0HC/Pzs
 L2C9YCKxL8AeIJO40t2HjiV+NFt0+uzVtxZ8+hHm8Sjvj41kQK5kTqA/0nhRCwCmM7mL
 Zuhtyd2jrnKTvNS01uo5deL9XgmegbtmFgpfp4iBtXhl07NsctvEx5tQJtV1iyJiXG+S
 Lz9g==
X-Gm-Message-State: AFq9FYJAXlc3RcW2NN5+dIjE3RVzNtyKFEM2Msq7YE9h1n6Rzc2k+ttX
 NdAF06t8zCKRSqwOchQKAJDtqdGDgqLBiwqC+LAhL3mhT9b0EvyNJk7K
X-Gm-Gg: AYBFou1DV11BJZicUo+aLYZ/rfN+7XKwC/8U+N08kHnasP9p59sCvySX8nQBWF9tqKo
 2QLuums2rTYLYnqVYF7mIHWoBJRjDAN9JGcPw4V8PUPtrlfz+L0UeSqtZNeMlactmljSfpHdmxd
 p2ye66F4fOjBvw/2kG527l2cUcrxQbXKFSmOwefZ/yiRrX2YNgCDmJz775J6oMJMV1kgn8rH9al
 r0DNjHTGd7tslnFWYff4XGCbsFTl8vKrcZpUp3f62mrnFFbNrh46OIee1BC0QacK7SPufCW+t/Z
 IpmpG8v1wxTyrsrprCgzT5zsHpv2uxBeTOPD7DtDXFtLfz64+2dcP7X1HcFnTy9eD34p3Gs1aW5
 P75B+3o0nG7r2IcPDNOEWygEOzbgir4TOnryQIo2x+PfUknIlNSz4MCiImzc/9b2DO+sw3OSAOs
 ykkW/gytp+JeOjDTlcJujXGRQ2eLI8Jfsw9MslLVurpjk8W3KgxOx5cncl346QmbTIIuHq7SGI+
 LdZcsBXmsCDYQFDv9jm878PCg==
X-Received: by 2002:adf:fc8a:0:b0:488:77bc:a741 with SMTP id
 ffacd0b85a97d-48dbaaec9d3mr15245914f8f.51.1791813921946; 
 Mon, 12 Oct 2026 07:05:21 -0700 (PDT)
Received: from localhost (ip-78-44-39-34.bb.vodafone.cz. [78.44.39.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9463499sm18798793f8f.3.2026.10.12.07.05.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:05:21 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 12 Oct 2026 16:05:05 +0200
Subject: [PATCH v10 06/12] char-stdio: add support for the terminal size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-console-resize-v10-6-2c3b10d829b3@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791813907; l=2835;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=Qp0MMY88z/ilQBZzBdIx5Zozet6nrd7RSwO8+sYnBxE=;
 b=XZl6fC4vNXpcSM2l48mykYcU0BKZ431Syb9vkZYeS+uK9t1JGAZrTM5qTRQqww7V7WFHAgLrT
 +/RChrOASI4D+iVIJg4gouvzyKDqX90H/ggUHxuvJwTzFRWwhUQZbJv
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
[Filip: use DECLARE_INSTANCE_CHECKER,
        qemu_chr_resize_stdio -> stdio_chr_resize,
        remove notifier in char_stdio_finalize]
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 chardev/char-stdio.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index fe1cbb2d88..f63bf413c7 100644
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
@@ -85,8 +95,23 @@ static void term_stdio_handler(int sig)
     stdio_chr_set_echo(NULL, stdio_echo_state);
 }
 
+static void stdio_chr_resize(Chardev *chr)
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
+    stdio_chr_resize(CHARDEV(s));
+}
+
 static bool stdio_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
 {
+    StdioChardev *s = STDIO_CHARDEV(chr);
     ChardevStdio *opts = backend->u.stdio.data;
     struct sigaction act;
 
@@ -121,6 +146,10 @@ static bool stdio_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
     stdio_allow_signal = !opts->has_signal || opts->signal;
     stdio_chr_set_echo(chr, false);
 
+    s->resize_notifier.notify = term_resize_notify;
+    sigwinch_add_notifier(&s->resize_notifier);
+    stdio_chr_resize(chr);
+
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
     return true;
 }
@@ -152,6 +181,9 @@ static void char_stdio_class_init(ObjectClass *oc, const void *data)
 static void char_stdio_finalize(Object *obj)
 {
 #ifndef _WIN32
+    StdioChardev *s = STDIO_CHARDEV(obj);
+
+    sigwinch_remove_notifier(&s->resize_notifier);
     term_exit();
 #endif
 }
@@ -162,6 +194,7 @@ static const TypeInfo char_stdio_type_info = {
     .parent = TYPE_CHARDEV_WIN_STDIO,
 #else
     .parent = TYPE_CHARDEV_FD,
+    .instance_size = sizeof(StdioChardev),
 #endif
     .instance_finalize = char_stdio_finalize,
     .class_init = char_stdio_class_init,

-- 
2.56.0


