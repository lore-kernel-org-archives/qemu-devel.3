Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA9CCAC5A7
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 23:47:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v07Hr-00052f-Lh; Sat, 20 Sep 2025 19:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1v07Hd-0004zU-9N
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 19:46:26 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1v07HX-0006gi-KG
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 19:46:24 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3f0ae439bc3so936210f8f.1
 for <qemu-devel@nongnu.org>; Sat, 20 Sep 2025 16:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758411978; x=1759016778; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z8rsKM5rsvNwRW7m6EX6KUjy9obAcFXVNM0RZQRPnOI=;
 b=SOOHgNbeBMF/jroN5IF2BMN5zMxjU2oZktbLZyYqB5AuMM0lqg4G1DjsJDiKD+fQnV
 QJTG0zuHB0K5M3B89bgFRS6Zq4m8GKjyJ6B5jYN4rUezS0VWpfYWDs4y/FfS4sRZR8+9
 P5ZZEk2bbWlW23mY3KlC8dKB74C/lKvrcTDRrz0gBg1GOv/LmpykMAvp6SNCSaFcwN6E
 cBvDN1wXfHIEzGszM38xCrW3TJAJ/Tllu+OQ/Fg7yDiSn0tAxLc9Y93GxVccHSgCjAEc
 uiG/uq5E+q/i6zAuLeG1/sM0oJSn3DA/ZSeB6ilrJgtOzPJAk5MFHmaND4+XxgM/W0kG
 4w2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758411978; x=1759016778;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z8rsKM5rsvNwRW7m6EX6KUjy9obAcFXVNM0RZQRPnOI=;
 b=fjf1NB914e4G0YnQK7+fbZzkm0bwLpYfFWCIJiNB6zV8DFGV7VzSpc2CY4PXe5H4T9
 3pAzqB5howjJ99E6iCRtVIhHlqI12l1bSqsEZS3RIGDQTfgro0/7eKQ8Cd/D+gEdh7By
 NQupcTZa5A7MIAEn4Ebch6J/3/3Jq7yT5H42XNZHtG/3GKsB5QHThzPQMcw+EmFmz2g0
 GE80H7GL4jn+x/rlZ4lAdXJz9FCN/6MTNMn7wrLNRUcFGZtqmA9aGsvQX/yE/wcdc06n
 X7SZ9wGo5qL4mMLf4XtLV6WbuA9gNs+kSiW4ilppRjUUTNA6MCVM/FdzMJv/vLfMc8jw
 j/jg==
X-Gm-Message-State: AOJu0Yyof1gisPHUV2Dvo9Z1eiLI5tnhHzII5RwqLqjsLBwoT04GDsaJ
 nOZVwfP8FeOQC7BCZCpQr86jBqvPDuA2ALTdAts8+N2NXojkLNI3MuZ8
X-Gm-Gg: ASbGncu0d45pVEHFV+RyOM+r5X9QtemARfPf7cbRGLoMxoGkaeEdrfSDgneuowCx0fP
 hWWscSpM1+L59KHUA2UMboOv+iy+HGez1uCvXasBma2eRuDMwB+uhvKvkyciRObII08b9E6vSsn
 0Gg8OZ4QYkSsHzvXc5FAavXHylNmLpHnNeJNjkYnholHPzS19CDJg3m3VRm0tZ9BVnCH32DTRsr
 PoHc2qNyRgliRsGzKhX3zAHlM4YNZ8uqSH2CiEfgKWS9utcvvCnYMWND7qMTlJvYP/yt5JTXnwP
 /GxChWKtW/XaT55NxXHm1Aw8QDLhIjITYkxDkuIlGKD2eJ3Lip0V1AHcwKTdo9251gp+EgAzfjZ
 v/foVAlfaOqlcPt8tcR8kq+z8n343/+0SweTjsQdZJVq6V7Ytb1mLIwsNWtUch/0=
X-Google-Smtp-Source: AGHT+IFgpL37Jk5YPv+2tXXMimJxUDheXlf01zQYRoDP8re2nwt+a5HeoUyhhiCNxdhP5eaWw08DPQ==
X-Received: by 2002:a05:6000:604:b0:3e3:dc04:7e1e with SMTP id
 ffacd0b85a97d-3ee7ccf623fmr7301661f8f.7.1758411978058; 
 Sat, 20 Sep 2025 16:46:18 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-45f3211e8c7sm105424825e9.3.2025.09.20.16.46.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Sep 2025 16:46:17 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Sun, 21 Sep 2025 01:45:40 +0200
Subject: [PATCH RFC v5 10/12] char-win-stdio: add support for terminal size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250921-console-resize-v5-10-89e3c6727060@gmail.com>
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
 Filip Hejsek <filip.hejsek@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758411962; l=1846;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=RpmrNCBfhehDN2KMtvbOsM7e+VeevQ6dar8otPhjqkc=;
 b=pIhnB+u00U1PrullOsS5NEEVLFKNPZT2VD9JWRKOQb6PO/R6GfNtx2EWB5fcZYucWwVXqp/9Z
 6UOod8SH9ZIAn6zVm+OH8f0Uqz07e8/DqTXZi7A4O21HxIA6R5+0TEA
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wr1-x429.google.com
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

Use GetConsoleScreenBufferInfo to obtain terminal size
and set ENABLE_WINDOW_INPUT to receive resize notifications.

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 chardev/char-win-stdio.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
index fb802a00b13ac4089abf3bd4f8c4198d8325764b..0d33138d0dd83b582e959d21c3d991de52f8d3e4 100644
--- a/chardev/char-win-stdio.c
+++ b/chardev/char-win-stdio.c
@@ -44,6 +44,20 @@ typedef struct WinStdioChardev WinStdioChardev;
 DECLARE_INSTANCE_CHECKER(WinStdioChardev, WIN_STDIO_CHARDEV,
                          TYPE_CHARDEV_WIN_STDIO)
 
+static void char_win_stdio_resize(Chardev *chr)
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
+            char_win_stdio_resize(chr);
+        }
     }
 }
 
@@ -202,6 +219,8 @@ static void qemu_chr_open_stdio(Chardev *chr,
         } else {
             dwMode &= ~ENABLE_PROCESSED_INPUT;
         }
+        dwMode |= ENABLE_WINDOW_INPUT;
+        char_win_stdio_resize(chr);
     }
 
     SetConsoleMode(stdio->hStdIn, dwMode);

-- 
2.51.0


