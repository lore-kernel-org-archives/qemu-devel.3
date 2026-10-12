Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BD5CA9ED2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 23:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGPLQ-0000gg-5R; Mon, 12 Oct 2026 19:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGPL9-0000f8-Jp
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:21:56 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <filip.hejsek@gmail.com>)
 id 1xGPL7-0001oT-Vl
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 19:21:55 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso1351918f8f.1
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 16:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791847312; x=1792452112; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lszQQRbmRHo25iF2ERss6Ir2zjji8Xw0PJLVSACPXCI=;
 b=erSe92Z94mqgXlYveQAuCb90yjabNsEPyhpjod6pP34CbudRGrRY0lTWtJsMyphu2k
 5rVGdJvSdhOok3GcjWHSAW78r6oOVam4vmnlWKbjDvZ0QxLIvEGJq9PI+T3umWszZ57c
 JRQd+7AA/vkF8zNfRRMGN2RQLRdWRutUfEPDgVPfTdfO6KOInfLWYQJST2WfBURfKODu
 0lgGRcmc+dUwSMfaCxVYk0wo2nVjVFtIldCl4EpAG3eGs55Z4EGJbtxD3sJy8AYfnBl1
 0FDKEczVv0d61rsNt9Oes+YRgJcLQ4xVnnH4qUeRXKDrNny0qxA1GRKNnDR8m/0W6sYP
 kBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791847312; x=1792452112;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lszQQRbmRHo25iF2ERss6Ir2zjji8Xw0PJLVSACPXCI=;
 b=H6vqXJKalDTltu1G7cuceNIvucXkhhGckS05HA1ivPquzFhbT1YnA8vVvEAtVJ7U8U
 KrkPMpdyIBu0ZH0ixnBCyUrBO/W/ewsWiwPTE1ntEEJG+OGGjIBQ/C94D0m4TLr9O96o
 iUypBqIsrsBH4JfEIJ70sK6VJPu7Tz7FmC1tWRRAIOCVoZXtwLFVRC5qhoa3jWb+IclW
 LEq3luzgvej5vXV58lekF34rRVtl0Y+I7xAH8+T33xbEokTghs46WUm8Z8RB1lTUWcwP
 sklRXeuCRpIZXqXOJHYk5W1zP+656SXoILWWoDmFzRsiCRVgSD5rxo+2mHW+qQEGkxTK
 owRg==
X-Gm-Message-State: AFq9FYKT7gEl6yQIUhPffjZZ3PHc3ZIfa3iCsbWTPr1WPrhkBYwZdzw1
 9rHeXmrUM5IiEFIWTiJAMoAtdjoxUb3U2oVvqj+hiVXrdm06P/Pv6lEq
X-Gm-Gg: AYBFou2xUk3A3bFeL1Qy6G+q59C8ROL5GWjkHF3Ouhd8em3/sJGXaq/84XjQPq9Xn7A
 gPQEDkBOc08/YKGvTEQ9QwPxV5xGusegkTB2yszKVmH8qVHlUuhRToe4hhGPC6xaQNIZ9rVsrWS
 bl5Qnv2Ws4lJw8COq3Eno4uAPMwssDewdnVF48jHCNSpm+os7sj5grZ0b27/G3/br7lnR5YLZfm
 SarNdnS0clRA2oY3OiW3iHPp+RnIvzDbUu11hyhs7ik3Hm74XR4bmRQJUEvkYQAnOqqPUUZSGpF
 JrCxAD0mKQcTdnk+QFi272J271S5uhW241a7GtNc7y7HHRPhZCNkTDQTH9tdg5XrDMacQfgdLsX
 RClVXXLVQP4KhKXt/l6Pu++MA88l1T+DSqeY99dEm8xrznmFTWr2uMBm/V5jlCPBcFAbUD+BXmN
 Mw9l5whPDDF3ON4rlh+3XDjO0UlY20B/B6M75pLyG609HLksHwpUXhZ77iw8ZRWC+XFtIiNv96a
 nvnG2hD6Ezpzyopca3JjKs5wckt87qjGtpn2A==
X-Received: by 2002:adf:e64c:0:b0:485:8ee5:5ffa with SMTP id
 ffacd0b85a97d-48dba9de8f4mr16547766f8f.38.1791847312425; 
 Mon, 12 Oct 2026 16:21:52 -0700 (PDT)
Received: from localhost (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0967acasm1496207f8f.2.2026.10.12.16.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 16:21:51 -0700 (PDT)
From: Filip Hejsek <filip.hejsek@gmail.com>
Date: Tue, 13 Oct 2026 01:21:37 +0200
Subject: [PATCH 1/2] char-stdio: avoid closing stdio fds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-fix-stdio-close-v1-1-4ecfa416c7bc@gmail.com>
References: <20261013-fix-stdio-close-v1-0-4ecfa416c7bc@gmail.com>
In-Reply-To: <20261013-fix-stdio-close-v1-0-4ecfa416c7bc@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791847309; l=981;
 i=filip.hejsek@gmail.com; s=20250912; h=from:subject:message-id;
 bh=GDHMz26hmNQqBmHb11y/9R7vXOTqz0QZMprRo1ad1/U=;
 b=L8qD+DzIenKKzEebCrJYsyb2s3t2CehQ3RI4n6bKzyIbjltCmbFZLXO3lXXLwjbkLRUycI6lN
 fqrANQfdFdID7+CuNZOGYR2cjMXve6QbetREQFEbQA/xz8gcmzVqxj+
X-Developer-Key: i=filip.hejsek@gmail.com; a=ed25519;
 pk=nakB8gEK3oi+Q/5dBTMCy/LgZL47NP60z1jeDR6O/WU=
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=filip.hejsek@gmail.com; helo=mail-wr1-x434.google.com
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

Use a duplicate of stdin and stdout fds to avoid closing the standard
descriptors when the stdio chardev is destroyed.

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
---
 chardev/char-stdio.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/chardev/char-stdio.c b/chardev/char-stdio.c
index fe1cbb2d88..79092c4a75 100644
--- a/chardev/char-stdio.c
+++ b/chardev/char-stdio.c
@@ -108,7 +108,18 @@ static bool stdio_chr_open(Chardev *chr, ChardevBackend *backend, Error **errp)
         return false;
     }
 
-    if (!qemu_chr_open_fd(chr, 0, 1, errp)) {
+    int fd_in = qemu_dup(0);
+    if (fd_in < 0) {
+        return false;
+    }
+    int fd_out = qemu_dup(1);
+    if (fd_out < 0) {
+        qemu_close(fd_in);
+        return false;
+    }
+    if (!qemu_chr_open_fd(chr, fd_in, fd_out, errp)) {
+        qemu_close(fd_in);
+        qemu_close(fd_out);
         return false;
     }
 

-- 
2.56.0


