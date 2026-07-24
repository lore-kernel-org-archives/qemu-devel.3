Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AACEC531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:48:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnCVr-0003Fq-04; Fri, 24 Jul 2026 05:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wnCVo-0003Ew-Pq; Fri, 24 Jul 2026 05:48:12 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wnCVn-00058y-9t; Fri, 24 Jul 2026 05:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784886463; bh=QOd08d1h55mBSGcMarer7Abhnc2GmuO+qLdLlQmp6So=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SrDhjOVKM5lCRnWClpmduI1EZnS2Ro/DIL9K3DEV4Ae8Oxu2zqHH5zaxBKEEYKZtq
 CJ+8xrEdq0M8OM6yB9+HsuPt6loI7+xs8+EO2zmJYPkOtmYDWoaJczyiGzyI4PwSJ3
 nFHawBG8tiwdYjQZHfBHf+3FePtXPZXSYaX0I+/TDdpOLA0fdoc+ReeqhLS2lEBiFT
 3Km3Eiq1kLoOXRwufUxJcXK7jF3zgKnm2Um46hER9eO1+Ex8Pu9XPChpWnKO4LSXBm
 +nPtcZcHakpa8FZv+3AWT29JFHQj3GwAfCz5nes9ZnHGgUWCLm3Uwzj+rs0ns3T2Oo
 xritTCmhhsy7Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 522331C4573;
 Fri, 24 Jul 2026 12:47:43 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4D5BB3F46B2;
 Fri, 24 Jul 2026 12:48:04 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 450E018544; Fri, 24 Jul 2026 12:47:54 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Filip Hejsek <filip.hejsek@gmail.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 2/7] char-win-stdio: fix typo in spelling of 'stdio'
Date: Fri, 24 Jul 2026 12:47:44 +0300
Message-ID: <20260724094754.1053970-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260724094754.1053970-1-mjt@tls.msk.ru>
References: <20260724094754.1053970-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Filip Hejsek <filip.hejsek@gmail.com>

Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 chardev/char-win-stdio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/chardev/char-win-stdio.c b/chardev/char-win-stdio.c
index bb9c195a8b1..0deba3bffb0 100644
--- a/chardev/char-win-stdio.c
+++ b/chardev/char-win-stdio.c
@@ -128,7 +128,7 @@ static void win_stdio_thread_wait_func(void *opaque)
     SetEvent(stdio->hInputDoneEvent);
 }
 
-static void win_stiod_chr_set_echo(Chardev *chr, bool echo)
+static void win_stdio_chr_set_echo(Chardev *chr, bool echo)
 {
     WinStdioChardev *stdio = WIN_STDIO_CHARDEV(chr);
     DWORD              dwMode = 0;
@@ -205,7 +205,7 @@ static bool win_stdio_chr_open(Chardev *chr,
 
     SetConsoleMode(stdio->hStdIn, dwMode);
 
-    win_stiod_chr_set_echo(chr, false);
+    win_stdio_chr_set_echo(chr, false);
 
     qemu_chr_be_event(chr, CHR_EVENT_OPENED);
     return true;
@@ -263,7 +263,7 @@ static void char_win_stdio_class_init(ObjectClass *oc, const void *data)
 
     cc->chr_open = win_stdio_chr_open;
     cc->chr_write = win_stdio_chr_write;
-    cc->chr_set_echo = win_stiod_chr_set_echo;
+    cc->chr_set_echo = win_stdio_chr_set_echo;
 }
 
 static const TypeInfo char_win_stdio_type_info = {
-- 
2.47.3


