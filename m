Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAE0CD8CB2
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:19:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX1wp-00069r-Q2; Tue, 09 Jun 2026 15:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wX1wV-00062T-CU
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:16:58 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1wX1wT-0006PV-A4
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:16:54 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-490ae94a89eso50998075e9.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781032612; x=1781637412; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S6jSm4Mi9XKgjjqZh5KQVJBGlx7yAY6ZGbKU8eIlcy0=;
 b=sQReY5v3xxUK4pX8wVdA+62lE/zQJn77nEIaOcJRaW5O9dmzWnkKVDFgQ1yLMRDpn8
 feC7U0fd2mCwR90p3tQbhqgaqneMFq1Fmz89STzBoRYg4D4LHQI0o7gv25Ht35ohS/B9
 D5O0/hYuUSK+VA8ccNKqLFFen0iXpGIluBeHc4B2Id3O8DkKAT1DMKz8s9DQISrjnsA7
 jjerd10X3U63p2W4LzxQE4WIbt2gemFqSvo5DvoEpvrf7LAllJqrEcG2beg7ZPGwlNYn
 iwsM/l4a2asGjh9wQSXeXBb0iT8+qGZYk2GCIhC849+u8p1gLkEk+gW3ShWlcVIuUkDd
 Qm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032612; x=1781637412;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=S6jSm4Mi9XKgjjqZh5KQVJBGlx7yAY6ZGbKU8eIlcy0=;
 b=tLg5hjB3h5AM9VwNHO+3sbH4f0c4JlbsdC8XMcPrqYSAPeLLRYFUvrEj5G5ocMdnuH
 uZAU63TCpWMQTBhSUNMjCGKRcc49YNZudlbQEPZrbZFrKqtYtdKPff8Uk89LAN0CJ/DP
 iC7eqhEoDWIIGHEKEQj90cJs/ZdeShV+W8UDFPnuC2DVfa8A5I/VCjnr2lr1dfXWZL41
 JtLgSzLgjXe+F2yN67p2v0k6KZusvQFvNNcUfDd5MNz+rPiAbwON4iM1SvwMcbDjy6Gq
 VvymMhcmi4eOkJVgHn+bjZ6G3lukNG85NwTIgA5VOOtqTcqiKpuGyqrdES84+D4P3iGP
 kUzw==
X-Gm-Message-State: AOJu0YxpgmUk7//a0P5lf/qRPeedLE1LqMj3b7/h/E0hVWVyX1NkhucZ
 CSIaDJ+RcqJXSyHKzwQUIpDP56VNB/ciHxn30hULC1Fe6UThHrQl40MY
X-Gm-Gg: Acq92OHc+Sme2xFcIQpjVubbuAOs5yYeJZguJFUMiNAO1tX3ZB7ITWUr8idsOqxK9yf
 86hmSSxhX66UiBiskSrD0iEs5WeFKfJFw8NItJ6BwKeOLr+c3yKdtOCAEX0+6/StCCUdFs/eW5Q
 ypDff+wz68moM1I+5FnJakZd1p1vnDKYMJ/nn/be+4BIxwT9YH+ZtuoFzajA//oWYiqX5EmSFVn
 OnR4RFaTrtJ5BtLomxqlUHiWwokFBCcCWgffDKsEqu2YSwN5Up2TdMBLCg/Fj4jp/v28SL+EL/F
 HGqEGo5/h6QNr4rkiQNvGZD6XC0zTuAm5hN43LYwHKAHqSM9rngrIXoJo+TDBdwvzvcdG5mstrb
 IyZJx9DEIzpQYUlKdeMApvMVqWgey8+UWSh00utIRvvvNg5bnKbpNzEyymPh1/NtT+kMXPyOWHK
 HcJEhdhDBav11ISpBWLjfbW0OEgYtptr/aQUtmqNt/4xHuEtHT4/3iGYzEOXKi/J4=
X-Received: by 2002:a05:600c:1908:b0:490:b5d0:598f with SMTP id
 5b1f17b1804b1-490c25b5f6cmr360246245e9.13.1781032611689; 
 Tue, 09 Jun 2026 12:16:51 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f67c6sm62218751f8f.16.2026.06.09.12.16.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:16:51 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Tue, 09 Jun 2026 21:16:17 +0200
Subject: [PATCH v7 07/12] char-win-stdio: add support for terminal size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-console-resize-v7-7-0c550fdcec15@gmail.com>
References: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
In-Reply-To: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
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
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781032602; l=1838;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=Zdzf8kR2p+Yk8aUvofodNOe4lBaihFirTsXeIEwC6zo=;
 b=p0nIIgDOrrSGUiX+XVmiwnzqizlTpv5o406SXU+Fd6QxD1vPMnrW90yoAD4I8K5XLNnFhNY3j
 mXNADHrd75kB4dGJr+jkaatu+94DAnk4roRor87s6RT+J1rIAKkfgvj
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x330.google.com
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

Use GetConsoleScreenBufferInfo to obtain terminal size
and set ENABLE_WINDOW_INPUT to receive resize notifications.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 chardev/char-win-stdio.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
index bb9c195a8b..188d26502d 100644
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
2.54.0


