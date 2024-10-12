Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6B0D1A431
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2024 03:40:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szSyK-0002fj-Sj; Fri, 11 Oct 2024 23:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1szSyI-0002fF-Le
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 23:39:14 -0400
Received: from speedy.comstyle.com ([2607:f938:3000:8::2]
 helo=mail.comstyle.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <brad@comstyle.com>) id 1szSyG-00030L-Vq
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 23:39:14 -0400
Received: from mail.comstyle.com (localhost [127.0.0.1])
 by mail.comstyle.com (Postfix) with ESMTP id 4XQTk92d5pz8PbP;
 Fri, 11 Oct 2024 23:38:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=comstyle.com; h=date
 :from:to:cc:subject:message-id:mime-version:content-type; s=
 default; bh=cQb2Usm/gjzkJx/SRPq8rr0TltwAK0wfRcI+OkYfmFo=; b=fBtk
 8LugS0nF5jVFV0WNnytbDS0Wv4yB8V6xGqmTX/e57IChjCuGOP4V0q5UmXKUXy/h
 8X1gTyeXMrwUZ2WYiLKSbkkKj81SfI/KArYzIj9BuJVJ6BqbDo54znysd564TY4m
 Wsdo3U6fCNT2YR56NOKQd5SLp+940CIS1UK0IxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=comstyle.com; h=date:from:to
 :cc:subject:message-id:mime-version:content-type; q=dns; s=
 default; b=qRkZ0+hFtKHaVSjut+ly4fClaG7mrE+21u7GZlBGOL53apqhaOtsj
 rClLoS5IZIJs2ZoOxfWY/X7cG4iSBrN13nVdnOEPxd4b0yylTOc/bf8fdBQPXyvZ
 hXpC0+TiK0SvlMyT57fQUVdFVd73KPBhIsO3iTvLJ/S+WR+JAeMdpg=
Received: from humpty.home.comstyle.com (unknown
 [IPv6:2001:470:b050:3:bb6c:4c6b:152d:3d85])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested) (Authenticated sender: brad)
 by mail.comstyle.com (Postfix) with ESMTPSA id 4XQTk90Y7Wz8PbN;
 Fri, 11 Oct 2024 23:38:57 -0400 (EDT)
Date: Fri, 11 Oct 2024 23:38:55 -0400
From: Brad Smith <brad@comstyle.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Marc-Andr_ Lureau <marcandre.lureau@redhat.com>,
 "Daniel P. Berrang_" <berrange@redhat.com>,
 Philippe Mathieu-Daud_ <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] meson.build: Remove ncurses workaround for OpenBSD
Message-ID: <ZwnvT4srOStQopOr@humpty.home.comstyle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2607:f938:3000:8::2;
 envelope-from=brad@comstyle.com; helo=mail.comstyle.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

meson.build: Remove ncurses workaround for OpenBSD

OpenBSD 7.5 has upgraded to ncurses 6.4.

Signed-off-by: Brad Smith <brad@comstyle.com>
---
 meson.build | 2 +-
 ui/curses.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 4ea1984fc5..22e7629d81 100644
--- a/meson.build
+++ b/meson.build
@@ -1374,7 +1374,7 @@ iconv = not_found
 curses = not_found
 if have_system and get_option('curses').allowed()
   curses_test = '''
-    #if defined(__APPLE__) || defined(__OpenBSD__)
+    #ifdef __APPLE__
     #define _XOPEN_SOURCE_EXTENDED 1
     #endif
     #include <locale.h>
diff --git a/ui/curses.c b/ui/curses.c
index ec61615f7c..4d0be9b37d 100644
--- a/ui/curses.c
+++ b/ui/curses.c
@@ -38,7 +38,7 @@
 #include "ui/input.h"
 #include "sysemu/sysemu.h"
 
-#if defined(__APPLE__) || defined(__OpenBSD__)
+#ifdef __APPLE__
 #define _XOPEN_SOURCE_EXTENDED 1
 #endif
 
-- 
2.46.1


