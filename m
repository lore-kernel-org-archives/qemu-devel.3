Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C931CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 16:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBasl-000590-LK; Tue, 29 Sep 2026 12:40:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xBasj-00057l-6c
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:40:41 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xBasg-0006My-Uj
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 12:40:40 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ffbd83a92so25951825e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 09:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790700037; x=1791304837; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NmesPj5lqe1vOZQeIah2oHq6vnwIyh0er//hx3RTff8=;
 b=W3GwcTro20t4P73oYEXitJS2ChAUY160UfXWZB8HW4ffbFSIPAUzj60yeKfn2AZeBU
 InQPX0vw+TEG+zFPNlNHqS+KBdRJArfWHPCeHmyBTTx+lIVeDthtyf0/nmpQ4rZ6Jvz6
 li5XcE6tSBju3kaEl6mdvj4++rZV/Io1aXvfTCbk/FxIY8KXO5d9e1SItrNHBcS2CBSj
 4HgTIDnKKME/42Sv8Lz4zlmw3Qsj7qpjWRjSxGoIn4N6iZP84fcsgYAYzBdzG8/Q+rZW
 lxzCm5hpt180XHHx4WvW0q23OrpDachSDbJNzQStE6IERey0/DxKsM2Z4COXvXIEEu7D
 pQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790700037; x=1791304837;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NmesPj5lqe1vOZQeIah2oHq6vnwIyh0er//hx3RTff8=;
 b=fDcMmc4UesjscNzogFdwRamulW76Y28SlFYAfdMZKpPWTMvVM1SKrwdqZcMtjZh4mm
 S0hm5v1k6d6L3gNuv9BwIvNQnxPigWc4U07dT0UF+UMMQlFX6j0LtlqnxyXhxvE69ZrE
 u7tykw3un8RETB4wH9oSApit8cXf9sf5VR4DT84/+0BNsS/ijXzng3Ywd3yIEv7ud1uO
 m5s8JpXf+Nt7/AjIZlkzHUEzefOzEAMVliKzcQSH7V0YOOUrtc7I+qDHDUtRC502wbc8
 74A67bQPvzC3CiyalaQy3Mvrlj5APpTfi6f+MMAo3dAfD3ArSprVSgN9BqfeAFL/+zz9
 DrNQ==
X-Gm-Message-State: AFuF++lCVVh2csAtAnYDdt79GEQA5yS9JJHpIHKnEd2YEf2OA4kl9YbW
 cO7oIwim47eYfJYILFHWyW3z5/KU+S+O911sPLIvXL2MGtlhlKHyaGeP
X-Gm-Gg: AYBFou3WziSCqHIwBkpB6RtNaSvdZknN6bZ3r1AC94zVwKRT+zEZ/BgyfA6z3yXuHcH
 DqRwIuDnScmDNs0ZoJlUfiViR+CO48Cr6QFwT42Ii8Shulq1HAsILk6RemQm2Oc8K4dLGifk1Kb
 ApTqZ/jrEjIfWGLRk28f/C7IdB3iriQmQaBVb9dx3vZf1KJqwMyULF4zNQKCWqktP1oqrC3yV36
 ZGl74WtsHm4pXjVPcS7uw9egKoiLzv9svOZ8t7Uvw8KKLH3L6lmGGPnoezMtZ02C1lbRCRWQgti
 haLIWxKPxd4rRED8TkfK34gJmrK7JOzYp/lEpp2F9IurOyI3anx7AANhv5lXeZhuATUdC3maQBi
 5VwJ8si+KXYRiaR212XnT7Rmxd7qSzoF8eGRDUB9VJxX0Z3Us1H4ee88svhjOppMGfipkL1C2a0
 eKXP+TTn8ap3z7zRplriGE5XSn66eTmXSV0K4MioolnXQCt2lO3PaVAkqdAvZyj9tQWx8APWokq
 eikqWd5ifHdwqDBxDMFBKuCb8a1rfBSBSbyuQ==
X-Received: by 2002:a05:600c:198f:b0:49f:bd3c:bc23 with SMTP id
 5b1f17b1804b1-49fe6707f90mr303885325e9.30.1790700037368; 
 Tue, 29 Sep 2026 09:40:37 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cfec703sm84798375e9.6.2026.09.29.09.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:40:37 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Tue, 29 Sep 2026 18:38:35 +0200
Subject: [PATCH v8 07/12] char-win-stdio: add support for terminal size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260929-console-resize-v8-7-2ff9183f8750@gmail.com>
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
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790700030; l=1838;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=AlK9dpw0pK3QXBcL0KO8rXDaSPzAjmGSoh0r1UYfc3w=;
 b=+G2UFULzvCdVHS8J5wf48uFs/99rUR3SRh1CMeCX6h1hGc4FT+o8UsAfp8YYDaJxkaUdXBCRr
 uQh61VfYyv9CRbEnesNTk9Os5m7iSy/Hqp6z23lkZhkNOZau0kVZu78
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
2.55.0


