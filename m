Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBA4CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 11:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGEeT-0003co-0j; Mon, 12 Oct 2026 07:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGEe4-0003Vh-1I
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:56:45 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGEe2-0002Nr-8j
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 07:56:43 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4a1698ea378so14710615e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791806201; x=1792411001; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NmRuOWUejwBN2bZ8VsU4Vw4eRoCxbP0++ctfIHndI3A=;
 b=bh0yxX/mKLUTC4Y9UFWzCB95VmS5PKDC9V9sMnIob6BuuUPnaKCEngnCIZH9zWkQ5t
 LwlwWE7Uhqw1JtDtu83Ky+4slA14B6VxShhcYa298/2Wxm5+QGiJO/pOCCvSCLwNAWrt
 NH7lEr+eLx/TMeVyPETPfImKeF1IC440A+JAg1tweQRCuguqU06mPnjXuoB1ypclG976
 Zx9YI8i879af9EqH6j1sBjKHuxktd5/F34dAQ42rqzgnf4LhLxzo58A/crZsCvagGGaI
 ksl35+ageUoRXLe0nuM+5wNEDTQl9Sl3CWJO2wzq4jZtdqALWCL9zPHqGODW0dDVBJ9O
 jrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791806201; x=1792411001;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NmRuOWUejwBN2bZ8VsU4Vw4eRoCxbP0++ctfIHndI3A=;
 b=XBF9DbaaPEp+gYKNxrN3twRsHOLAioJkbG4laGIe3Kh3SPnuKY0iaNEEHGy7uK/RAM
 thTlX41yAES3z+ikCJbQiBXlru3MY81dDv3yMUfT9A2fKFtFcvGT+rIjhuz5fCVmeZul
 2n6xvWtldEXsN7IKXEoW4j2heN8U4Pek/oRST1ouGX7YJF0hvRdW/1gb0PkkmCk9Bhyd
 dBRRUurjYaGGyqWCVQXCTqstZGkOKLyERbs8HXGhXqwocmCVlbizm4B1R8P2/K9xJG/X
 Otf3IbAw5ZGJT4SarJi/uyzZJXfNsUeOavN7UuT5YowXE36dNb5Rr7KbPvXMMWBKhMgv
 p5tA==
X-Gm-Message-State: AFq9FYLuhOqUy14NOriNPIREp27ix7YkH+ZmOLHBt2jzdacYIKDxIAZW
 gObIpG+ys15DbxEm2KMNbRh6taMCnsKko8anpuv/kR6ZjcxjRVsMpess
X-Gm-Gg: AYBFou3k8kArZ8liTOY2p4DliQ3ymlpEsYoYe6S4QI32hyqsoQcw7u7fn3KPa2W+emq
 zR0vfxybEpjnS9SfvXn+dsg2ckdUBlvy8479I/sPh8eIxM82kB2YrO7dvy2m+3mIXu8pCdhp8Uq
 7USysOvhRnUtvt+wSmAa973UP5LxPsPVtlq7lAnclFKgBIDhCxTSDWDDgQ0CPStbRkYeP2VUdtf
 awFEjBW02lHwYAgVU8q8/31WwDpjkgPDivY6iqEZE5mdPzDXQaKHN+h5CxziDoDfrNJYlf4dMiy
 LlQCUiMybHyXXdZU06iet4A2dKjOj2ddscpH60VFczp859sBzPTaNWnrC4Y9VmooAMm03lv6vJe
 OSSWBiDiYVAH1NMo3iTIDIRhR9NPSOV7tZH23ad6Kv+aVDQRr7I77RGcyomqp71NbQoxwg3k4L5
 3Eb2hP5bOtvGX7YxrVEWo7KUPrAYgzMCDFGO4J39M92QTCclgvpqLSq4bMJsROnMXmnekqTgegN
 d1ka/joaq/Kts0PGWC50svWiIk=
X-Received: by 2002:a05:600c:310b:b0:4a1:7659:9b94 with SMTP id
 5b1f17b1804b1-4a18e4a9774mr204140865e9.13.1791806200712; 
 Mon, 12 Oct 2026 04:56:40 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a19471edd5sm342631155e9.11.2026.10.12.04.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 04:56:40 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Mon, 12 Oct 2026 13:55:58 +0200
Subject: [PATCH v9 07/12] char-win-stdio: add support for terminal size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261012-console-resize-v9-7-8db78320ba81@gmail.com>
References: <20261012-console-resize-v9-0-8db78320ba81@gmail.com>
In-Reply-To: <20261012-console-resize-v9-0-8db78320ba81@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791806189; l=1838;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=AdJSDZRn2WXS30nr3zBBtDw8J4CIxuRaebRcO/zpUOU=;
 b=XXpHZUEB/gQyuZRNAk6Vt2XGthe+5xmkFr8PpPNDvmrAgW163hYW7GlXFM0Z9u0a/9EiCRzDw
 QrC8jJjdqzhBK9e36oekeMKSxsskYftGMx4BtgjTCv3C1c7u3TEAD50
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wm1-x32b.google.com
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


