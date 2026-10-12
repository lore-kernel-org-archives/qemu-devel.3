Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10A7CA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGGem-0000Tl-4Q; Mon, 12 Oct 2026 10:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGGed-0000Ds-9T
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:05:27 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGGeb-00068v-O5
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 10:05:27 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-3a1e9f55e03so20199731fa.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 07:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791813924; x=1792418724; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NmRuOWUejwBN2bZ8VsU4Vw4eRoCxbP0++ctfIHndI3A=;
 b=Vx9fZa82GSt4SzOsO95DvhIf7tBZ/w+fIDO4n4OqXKfK+6DBJP/l/K78QXcjGVwAFm
 JzTI4j1thxywE31uJLkbYiExciKuE2S86+uslZrMJvVhMbQWiVc06StdE4T4s3IGm0bd
 R81Qp4RpWhC+N/DBYjoWU7ZeO4Ls07vvxuciRC+VZ5hOyH21GhbLC/IvYFkQ7VFIGYup
 gcQX6xFuKrZxuH8SGy+RIMd3nmdqmPizl0aG7GTxG28twFysq2F4C6/Y9Ba332arNKZn
 K6upeV2e+jKA1+A1es88R6oDZkG8vpDM1KMj8/J9R+vyJsHwADT1sKPAozcEqxr/ExMA
 p/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791813924; x=1792418724;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NmRuOWUejwBN2bZ8VsU4Vw4eRoCxbP0++ctfIHndI3A=;
 b=jcxUGUiWamjlQe/MdEvIR99vY1a/WWuaUy7yIaqxlndiIdf3eV3/sXNIcOJ17gPgRr
 D1LNqLUEJbnrK61Fn1HExzGGY8GqKCcI98BwJeWj2eaIhFiYgluOzknfcGIJJ59oMzY6
 /pklcAEIcPEoYU2MtmtKulVh3ae+KayoliNMby0BRd642GDp21nEo5kUxWG0JCb6PN6H
 hFWaV5bjYBwt7IgK8zlWxlfZFXrn/XET8Ibr+4Q0Z9As9GGHh6TtlfkD2qdKone6cDzu
 tXTHKar3Zb4V+w6l+6Lw1E1VBzZgLCAKu2n30lpz0VRK8ooOVflOb1jOVjply/RjycAo
 edWQ==
X-Gm-Message-State: AFq9FYKqqtac+x/EoLlp2lK5spts2olWvi3ikQyIwUrk5S1n6qofyEsv
 e+1V5PxEEmj9Vo90rY2K7mNVFiHJL18tM0Kr/RPEIsFjsMAWPYOeoNiV
X-Gm-Gg: AYBFou1TbszqXTRg/2muaAsOIDnb2FjwPPBcnZp52BUdrWwBiAyiL4ggBlY8OpYOzZt
 44q044Nig5ilwQmR6acxqRHHfcr6b4rCYH1iseYPRR3Mfx2fhXct6QLt33Q4zI+MSaBqp5QfCri
 sBlcnqAWPiZ91DsNYYWzSo4KIcxm3hBkWA/T5+36pPLX4FvT9thaVhykOXqq4vUjkMPxCRsFJaG
 i4W1qwM250Zc+N+FnVdcoWnM2tQDdG5uq+Sr1zb2oD3yhM4w/ssIh6n7CPG8BT0tnY2d21OD+Qb
 aVu/X6bgh2tGXsVRblkOjZ5quMFGT4kZ8CI8AzTMTdNI1UVtRC45vYfR15YLI46V02ffNRwsSVe
 82MQILxHI1Ds8/yHJzgqlMQMqQylqSXdlRcOzEKKdPmDTiO9dFnN4Z+RMYW3b8zko9imYiYw/gu
 SZEZcFoXnp8nYMWm7y2jCb6fNY33en07yYMgCGA9Ui/p5WeTd8MBmMJEx8Vvx8XLy4kuZnx4wMe
 6NOggmK/RT+1iN9Erlqw4ZEgA==
X-Received: by 2002:a2e:be91:0:b0:3a3:7682:49a1 with SMTP id
 38308e7fff4ca-3a9c53912a7mr24680421fa.22.1791813923573; 
 Mon, 12 Oct 2026 07:05:23 -0700 (PDT)
Received: from localhost (ip-78-44-39-34.bb.vodafone.cz. [78.44.39.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9ae17e9sm19984106f8f.57.2026.10.12.07.05.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 07:05:22 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 12 Oct 2026 16:05:06 +0200
Subject: [PATCH v10 07/12] char-win-stdio: add support for terminal size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261012-console-resize-v10-7-2c3b10d829b3@gmail.com>
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
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791813907; l=1838;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=AdJSDZRn2WXS30nr3zBBtDw8J4CIxuRaebRcO/zpUOU=;
 b=ByX+5uZ7XjG8VWFevx9KrN9x0SmpF8e/jQZobx6LVLOWRGzjekn0GCeoOFgWOPm7FkZO69rsf
 0aDursb+DwLB61/YEdqJ7RZjv4ydWwUmIqxkyTXtDWeYQiaNFJmSnGK
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=filip.hejsek@gmail.com; helo=mail-lj1-x22e.google.com
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

Use GetConsoleScreenBufferInfo to obtain terminal size
and set ENABLE_WINDOW_INPUT to receive resize notifications.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 chardev/char-win-stdio.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
index 0deba3bffb..2132ae9a6b 100644
--- a/chardev/char-win-stdio.c
+++ b/chardev/char-win-stdio.c
@@ -44,6 +44,20 @@ typedef struct WinStdioChardev WinStdioChardev;
 DECLARE_INSTANCE_CHECKER(WinStdioChardev, WIN_STDIO_CHARDEV,
                          TYPE_CHARDEV_WIN_STDIO)
 
+static void win_stdio_chr_resize(Chardev *chr)
+{
+    HANDLE hStdOut = GetStdHandle(STD_OUTPUT_HANDLE);
+    CONSOLE_SCREEN_BUFFER_INFO ScreenBufferInfo;
+
+    if (GetConsoleScreenBufferInfo(hStdOut, &ScreenBufferInfo)) {
+        uint16_t cols = ScreenBufferInfo.srWindow.Right + 1
+                        - ScreenBufferInfo.srWindow.Left;
+        uint16_t rows = ScreenBufferInfo.srWindow.Bottom + 1
+                        - ScreenBufferInfo.srWindow.Top;
+        qemu_chr_resize(chr, cols, rows);
+    }
+}
+
 static void win_stdio_wait_func(void *opaque)
 {
     Chardev *chr = CHARDEV(opaque);
@@ -75,6 +89,9 @@ static void win_stdio_wait_func(void *opaque)
                 }
             }
         }
+        if (buf[i].EventType == WINDOW_BUFFER_SIZE_EVENT) {
+            win_stdio_chr_resize(chr);
+        }
     }
 }
 
@@ -201,6 +218,8 @@ static bool win_stdio_chr_open(Chardev *chr,
         } else {
             dwMode &= ~ENABLE_PROCESSED_INPUT;
         }
+        dwMode |= ENABLE_WINDOW_INPUT;
+        win_stdio_chr_resize(chr);
     }
 
     SetConsoleMode(stdio->hStdIn, dwMode);

-- 
2.56.0


