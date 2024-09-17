Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E6AC3ABCB
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 00:23:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqM0B-0006KY-7O; Mon, 16 Sep 2024 20:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sqM09-0006EY-Mr
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 20:23:29 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sqM08-0004lE-7L
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 20:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=p1kU3EpILUn6eNlUprAr230kdxcmxsTp6jHbv+nJJUY=; b=rzzq86CFsfwV4QPp
 fLqSRDFMKDufQEBHyKrOXa7q5TmB3JaHvhiLi1fEOCWh4YXcm+CvgH4eFM+LN/qKVTQcLK2yLhfQH
 9YJVIh9mrtnwhvXCnT8Mi0OBmnECLk3Co4H6QPT5DE+95Y1IpzFpVhYrQ+Rx4bB9XfRuOrfBmWvls
 Ex6w6VIvjthMfNw65Fe/2FkyugAXT017Kdqx9Rsp99lG+3d3sTCX24GdaqhhbWjqNhDRKkNs5IEIk
 rky2tWlgP9gqOf9dpi8vX3U1C8TdGDUcfQWI4txZxkQilVUh10OmIcL8FocVPI7ZIQTyy4Zb9JeCW
 qE5xik7S353XwsKtxQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1sqM06-0062pB-20;
 Tue, 17 Sep 2024 00:23:26 +0000
From: dave@treblig.org
To: marcandre.lureau@redhat.com,
	berrange@redhat.com
Cc: qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] ui/cursor: remove cursor_get_mono_image
Date: Tue, 17 Sep 2024 01:23:18 +0100
Message-ID: <20240917002318.331010-1-dave@treblig.org>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

cursor_get_mono_image has been unused since 2018's
  0015ca5cba ("ui: remove support for SDL1.2 in favour of SDL2")

Remove it.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
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
2.46.0


