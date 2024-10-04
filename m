Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89F9CF8840
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:05:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swkn9-000235-TA; Fri, 04 Oct 2024 12:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1swkn5-00020v-TC; Fri, 04 Oct 2024 12:04:27 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1swkn4-0001bc-EA; Fri, 04 Oct 2024 12:04:27 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6D97295571;
 Fri,  4 Oct 2024 19:03:30 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id A86FD14D97F;
 Fri,  4 Oct 2024 19:03:32 +0300 (MSK)
Received: (nullmailer pid 1282539 invoked by uid 1000);
 Fri, 04 Oct 2024 16:03:32 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 12/23] ui/cursor: remove cursor_get_mono_image
Date: Fri,  4 Oct 2024 19:03:20 +0300
Message-Id: <20241004160331.1282441-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004160331.1282441-1-mjt@tls.msk.ru>
References: <20241004160331.1282441-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

cursor_get_mono_image has been unused since 2018's
  0015ca5cba ("ui: remove support for SDL1.2 in favour of SDL2")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/ui/console.h |  1 -
 ui/cursor.c          | 24 ------------------------
 2 files changed, 25 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index fa986ab97e..5832d52a8a 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -175,7 +175,6 @@ int cursor_get_mono_bpl(QEMUCursor *c);
 void cursor_set_mono(QEMUCursor *c,
                      uint32_t foreground, uint32_t background, uint8_t *image,
                      int transparent, uint8_t *mask);
-void cursor_get_mono_image(QEMUCursor *c, int foreground, uint8_t *mask);
 void cursor_get_mono_mask(QEMUCursor *c, int transparent, uint8_t *mask);
 
 typedef void *QEMUGLContext;
diff --git a/ui/cursor.c b/ui/cursor.c
index dd3853320d..6e23244fbe 100644
--- a/ui/cursor.c
+++ b/ui/cursor.c
@@ -197,30 +197,6 @@ void cursor_set_mono(QEMUCursor *c,
     }
 }
 
-void cursor_get_mono_image(QEMUCursor *c, int foreground, uint8_t *image)
-{
-    uint32_t *data = c->data;
-    uint8_t bit;
-    int x,y,bpl;
-
-    bpl = cursor_get_mono_bpl(c);
-    memset(image, 0, bpl * c->height);
-    for (y = 0; y < c->height; y++) {
-        bit = 0x80;
-        for (x = 0; x < c->width; x++, data++) {
-            if (((*data & 0xff000000) == 0xff000000) &&
-                ((*data & 0x00ffffff) == foreground)) {
-                image[x/8] |= bit;
-            }
-            bit >>= 1;
-            if (bit == 0) {
-                bit = 0x80;
-            }
-        }
-        image += bpl;
-    }
-}
-
 void cursor_get_mono_mask(QEMUCursor *c, int transparent, uint8_t *mask)
 {
     uint32_t *data = c->data;
-- 
2.39.5


