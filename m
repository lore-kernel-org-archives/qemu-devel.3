Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4880FC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2D5N-0005F0-Tk; Thu, 03 Sep 2026 15:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x2D5L-0005Dc-0W
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:26:55 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x2D5J-0001YB-5L
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:26:54 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48444ec4fe2so177405f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1788463612; x=1789068412; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xTYKRztQFUG6AyCovUZ2ESge4XIrHCQrsZ8nsTsCGW8=;
 b=hXKnzHGAKTR3sBSZoR9jjRW9vt4QC0E0UR21sbXcPsrZA7KRlLGHDyZS1ciLL/hm9i
 cYjqpuqyGlVI+JB0FNR5BbR/fF27FK+zgKSoZOd4eiUo48xOgggtYN6usv7armHfT2AV
 ZKz76WCU8aUhVpOeSz0pe4ORRwcBDS18pxwrlEQtMrmMFVLFXZ6GeXkC4usVeHGkj9tR
 LfgR9gY3hx1XQHZ6lWBAQTdzemlohSH6bxR8o1h3GVwJEESbLhEr5WLnl93gswpPuxBb
 +xLPpXdGIQ7bHiaGaEGgwq1d/0cHBGYI+aSqKe6g4kksjoy7EqH27IbaOxE8h8ZV1SDc
 XsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788463612; x=1789068412;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xTYKRztQFUG6AyCovUZ2ESge4XIrHCQrsZ8nsTsCGW8=;
 b=i7T4wFsRCknPhQEzQ8sIW/iECXegGt1lzQvCFbgGhtPKlfi++S24yEYHydsmKgx6i7
 tD1BY3pf8zM7Y3pR1YrMGVD1swMEmBMUdAf7SZhM25uIY9znFenN+tFoz76LtkxwA4uQ
 bAmn6qJvVIuOR3gr/mLMn1W045eVqaOME3Gw45okFbjQ2hfrRWF9G1BLKDrb2ZFHnH71
 FbCE5bGFD1wDKxqZTvIYHYeAtRiDAqXngecreeAnIEmXx+QwfvYi02JQATWdIOTcOtuA
 ifyFrU0843QhA2vVFhOF2K5OO3ZnnTlfUe/SzA4XXw7uIjiNUhuRU0gvLoAFB9lAan1W
 1WjQ==
X-Gm-Message-State: AFuF++lZEz8HQwr9lytkbw/4fc15JUNCt26vGikgfMkGT0o3mq23E9Ko
 ZKesYbyLnL6r9E+G+EIQrgYvJDV3F8e4+U9RouKhSJhXPTedB6Mvx5GlXhp9H2teMjWYwT4tzHC
 lJqvX
X-Gm-Gg: AYBFou2hLjqSSNlvC8LpBvoiPNvyLRLkfyVE7MNJuijdc04nz9Uhds6HPfs9uFFsyXU
 6HeGFb4xvs7E3RgqMZdkhC8DB/EdueF5z9R0GUG7vHW3nF/4xGbEtvKCBfpwVofeHqXr3kRTYxp
 /Srf57tv3TvhDeo8dh6CFTduW5VeyfNeizt+IArzkfuY3k73Sn0crpXOU+m6qva+kr9lz52rEXW
 zcGt5H9AqqcSdONbauoPyccrybSAUQmMWCriS58cLx2ptLRI7pZkhAvG9JVY/edMeiIVOYTb1Vj
 qw/RQe6TjiOcePNtDASkVPtD3rGoJKCQXg9NYn/khz8PQvxJGP2JJmnOY34/Jmsau4oLf3oYJqz
 dY6YgO7bWZvgvuONtIDU5CSVt4KTe9PyFIU/KPBCrauhsv/47mLO7t/XSSnihltsIUq9yATmKZ4
 OXzWZJtOu791vIZcukswuS8sHcGc+4xyDyrvS0DavO1fEJ1xaBGoGH/NUF
X-Received: by 2002:a05:6000:2999:10b0:482:ea08:8c97 with SMTP id
 ffacd0b85a97d-48587046b35mr2012099f8f.2.1788463611709; 
 Thu, 03 Sep 2026 12:26:51 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:83cc:ab98:cda9:7dc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885c5bbdsm663164f8f.36.2026.09.03.12.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 12:26:51 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 2/2] ui/cursor: make the cursor refcount atomic
Date: Thu,  3 Sep 2026 21:26:47 +0200
Message-ID: <20260903192647.2677279-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903192647.2677279-1-den@openvz.org>
References: <20260903192647.2677279-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=den@openvz.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Denis V. Lunev <den@openvz.org>

A QEMUCursor outlives the call that publishes it and is shared between
threads, but its refcount was a plain int with no single lock covering
every user. qemu_console_set_cursor() takes and drops references from
the main loop under the BQL alone, hw/display/qxl-render.c does so from
the SPICE display worker thread, and ui/spice-display.c does so under
SimpleSpiceDisplay::lock. ui/cocoa.m and ui/dbus-listener.c add two more
threads.

The pair that collides is qemu_spice_cursor_refresh_bh(), which drops
ssd->lock before calling qemu_console_set_cursor(), and the worker
refcounting the same cursor under that lock. A lost increment frees the
cursor while the console still points at it, so the console's next unref
decrements memory the allocator has already handed out again. Locking
ssd.cursor is not enough on its own: with that done, this is the race
that remains.

Assert on the value the decrement observed while here. Dropping a
reference that was never taken used to be silent, because the decrement
lands in the allocator metadata of the freed chunk: nothing is logged,
the object is not freed twice, and the process runs on until some later
allocation walks the damaged free list and faults, arbitrarily far from
the code that caused it.

Fixes: 0b2824e5e48a ("spice: use bottom half instead of refresh timer for cursor updates")
Cc: qemu-stable@nongnu.org
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 include/ui/console.h |  9 +++++++++
 ui/cursor.c          | 17 +++++++++++------
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 29bf722888..3634956949 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -126,6 +126,15 @@ typedef struct QEMUCursor {
 } QEMUCursor;
 
 QEMUCursor *cursor_alloc(uint16_t width, uint16_t height);
+
+/*
+ * A cursor may be shared between the main loop, a vCPU thread and a
+ * display backend's own thread, so the refcount is atomic and these two
+ * may be called from any of them.  The object itself is not otherwise
+ * thread-safe: take a reference before publishing the pointer anywhere
+ * another thread can reach it, and never dereference a cursor you do
+ * not hold a reference to.
+ */
 QEMUCursor *cursor_ref(QEMUCursor *c);
 void cursor_unref(QEMUCursor *c);
 QEMUCursor *cursor_builtin_hidden(void);
diff --git a/ui/cursor.c b/ui/cursor.c
index 6e23244fbe..69d27d49a1 100644
--- a/ui/cursor.c
+++ b/ui/cursor.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include "qemu/atomic.h"
 #include "ui/console.h"
 
 #include "cursor_hidden.xpm"
@@ -103,24 +104,28 @@ QEMUCursor *cursor_alloc(uint16_t width, uint16_t height)
     c = g_malloc0(sizeof(QEMUCursor) + datasize);
     c->width  = width;
     c->height = height;
-    c->refcount = 1;
+    qatomic_set(&c->refcount, 1);
     return c;
 }
 
 QEMUCursor *cursor_ref(QEMUCursor *c)
 {
-    c->refcount++;
+    qatomic_inc(&c->refcount);
     return c;
 }
 
 void cursor_unref(QEMUCursor *c)
 {
+    int refcount;
+
     if (c == NULL)
         return;
-    c->refcount--;
-    if (c->refcount)
-        return;
-    g_free(c);
+
+    refcount = qatomic_fetch_dec(&c->refcount);
+    assert(refcount > 0);
+    if (refcount == 1) {
+        g_free(c);
+    }
 }
 
 int cursor_get_mono_bpl(QEMUCursor *c)
-- 
2.53.0


