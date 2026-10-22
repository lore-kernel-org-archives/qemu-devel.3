Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751DF606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=iAHHsqFR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJt9x-0001gf-Kb; Thu, 22 Oct 2026 09:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xJt9R-0000SS-Ki
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:48:18 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xJt9N-00057B-HA
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:48:11 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso16270145e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 06:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792676885; x=1793281685; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pcS+Jwk9ybuv9CPMRa2h0bU6xc+TDlXMtbvBgX/ZHzE=;
 b=iAHHsqFRRnNSgGglTjb8GX44RYgDN07Q97NIbOrE2gWDCZlFI5pRYE+LDYvhVGhEL3
 7GW8/+FtBAZtw3Bm0P+dkOafM091rRprFyyGidV2HC6B+7z/tR9ipJtNEeFe/SfABB4z
 PvaV3zekPOI7W8PxA+BPAiXe6RxgiWz7kpIkf1E6N6aWMOzdyAh4nFMSm0EeM+4QsU7j
 1j3/As9BqgO3kZ51RB85ay8H4BG8F60OQoi6Z3pdNLo2lOAEV6mGHeO7SjZf17uk9ZnZ
 xElDZsIu9TSHqsdwDJuSRfVIW1MS/DTW1ITMWvEDxKpy1aftr4WVLcQmYf8DUW4bnd1f
 Q5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792676885; x=1793281685;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pcS+Jwk9ybuv9CPMRa2h0bU6xc+TDlXMtbvBgX/ZHzE=;
 b=WT4xQahwesz1/bNiLYazhrAW2sjzhx+AUHSyc7VCrovRsSh32kYHl2RJIZpG+klcZ8
 m4hX7boF5BG+oFM9KZ5OpPrRAxdqtpsvdAF10lhHWKfXtERe3AXMwTc86g2Owvm6E2Pc
 7uwEVoSOIhojyY6JgOLUXaSGYXDnmPHhXmLSVH1MHiRHuHc/dU1mdmW9bzR8fTISdO9C
 yWOjU7nzTqbHG+HUE9YjIZrICAoJA72dWIuocTb6u2JzG+zQIbMV9crFh/ERKx3bPhhF
 U/jidTi4pmUI9lMxMRrjt4Nhvn2ke6rDx5ZyVH+wF8+LTsYu0rzD55cv4m/mjNxE0vTD
 nxcw==
X-Gm-Message-State: AFq9FYLulCWcthD9Fm7OJ1erPrkL7T4k0b4nlmYFuxcltTDLzVBxXv/J
 HAWyV+iIQegnrEtgs2gKSgzl03/5MrFqp2rBCBc6AVbSOvcIcMJB90Ae
X-Gm-Gg: AYBFou1U/d8kugTiklUZklwQY6a0scNY784qMWJ5BepLj7LXJxp17bdLU34LWO10CBe
 e+1dutLSOXqcKzdnvRrc71lUMlPOCnkH4o5gRMEYhJrJOMpx5q6uXp4o/IrkLDLgqsP06akCz2N
 EqsSHHIdLA413wqs6lsLGi/nZo9YX5zxWPyJ9eanweDu5embhu/atv+mHzhfvqhFtlmrP1mP3UQ
 4jCWwPHq0pdB2AlK3dCtCn85XjxrZInoIsVxbcxXXyCZlrpz9X7kAmLScMmqohNOQK7/aXSiK3w
 s2v4VT1k6gEqO4uCMpMzkZl//xFvc8IoDLIAWBtp72nH+aQWhOYtpYT4RGl/B+ww7Jj5vzOUMvF
 Mc9ZRNFZix9u9FISpidyMGNS6tYjAAN2Kw6495gLUFHXcDLC+r857GHd/cf29jXy1TTK1Pu/fyh
 T7uNSKqbRGH6cvxckPCiI4a1fqKEyRkSGKQ+6taTCdbcbqJ0FjcpkDvOMvteqIzjeftKJoHprt9
 OItGa9bW3hFpLQsBwAh5KTyUE6k5Dx3R9DngcnGeirtPRyC+MvFm3UYAwRRjEMBo9SL3F3Ts7UL
 S1NK1u+Oz6k7CJ5PDowyzc3m6dQ6ao1tXa7hKBxBaH9+CqDqgJKO3Q7kdLwHF3Xcu1eOKmuLuyK
 nPuWKUME/dw==
X-Received: by 2002:a05:600c:b86:b0:4a1:83f0:7c8a with SMTP id
 5b1f17b1804b1-4a1fd8a68b1mr106221355e9.1.1792676884676; 
 Thu, 22 Oct 2026 06:48:04 -0700 (PDT)
Received: from tim-m2.local
 (dynamic-2a02-3100-5a78-7100-00df-217a-667a-8b0a.310.pool.telefonica.de.
 [2a02:3100:5a78:7100:df:217a:667a:8b0a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254ef1bfsm13120414f8f.6.2026.10.22.06.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 06:48:04 -0700 (PDT)
From: Tim Pambor <timpambor@gmail.com>
Date: Thu, 22 Oct 2026 15:47:25 +0200
Subject: [PATCH 4/8] chardev/char-socket: detect peer close portably
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-vhost-user-posix-v1-4-0bd4d450d23c@gmail.com>
References: <20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com>
In-Reply-To: <20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-block@nongnu.org, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Brad Smith <brad@comstyle.com>, 
 Tim Pambor <timpambor@gmail.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=timpambor@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A hang-up watch for G_IO_HUP alone is not a portable disconnect
detector.  Linux wakes such a poll() when the peer closes, but FreeBSD
registers a wakeup only for read/write interest and macOS drops its
one-shot read filter on any non-EOF event, so as long as nobody polls
the socket for readability the hang-up is not noticed until something
unrelated wakes the main loop.  Frontends that never read from the
chardev, such as vhost-user, are the ones without a G_IO_IN watch, and
that is what makes the vhost-user/reconnect qtest fail under load on
FreeBSD with "wait_for_fds: assertion failed: (s->fds_num)".

While the frontend has no read handler at all, also ask for G_IO_IN on
the hang-up watch and treat EOF as a hang-up.

Signed-off-by: Tim Pambor <timpambor@gmail.com>
---
 chardev/char-socket.c | 78 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 59 insertions(+), 19 deletions(-)

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 81bac42a15..62e8871c51 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -36,11 +36,14 @@
 #include "trace.h"
 
 #include "chardev/char-io.h"
+#include "chardev/char-fe.h"
 #include "chardev/char-socket.h"
 
 static gboolean socket_reconnect_timeout(gpointer opaque);
 static void tcp_chr_telnet_init(Chardev *chr);
 static char *qemu_chr_compute_filename(SocketChardev *s);
+static gboolean tcp_chr_hup(QIOChannel *channel, GIOCondition cond,
+                            void *opaque);
 
 static void tcp_chr_change_state(SocketChardev *s, TCPChardevState state)
 {
@@ -345,6 +348,33 @@ static void remove_hup_source(SocketChardev *s)
     }
 }
 
+static void add_hup_source(SocketChardev *s, GIOCondition cond)
+{
+    Chardev *chr = CHARDEV(s);
+
+    remove_hup_source(s);
+    s->hup_source = qio_channel_create_watch(s->ioc, cond);
+    /*
+     * poll() is liable to return POLLHUP even when there is
+     * still incoming data available to read on the FD. If
+     * we have the hup_source at the same priority as the
+     * main io_add_watch_poll GSource, then we might end up
+     * processing the POLLHUP event first, closing the FD,
+     * and as a result silently discard data we should have
+     * read.
+     *
+     * By setting the hup_source to G_PRIORITY_DEFAULT + 1,
+     * we ensure that io_add_watch_poll GSource will always
+     * be dispatched first, thus guaranteeing we will be
+     * able to process all incoming data before closing the
+     * FD
+     */
+    g_source_set_priority(s->hup_source, G_PRIORITY_DEFAULT + 1);
+    g_source_set_callback(s->hup_source, (GSourceFunc)tcp_chr_hup,
+                          chr, NULL);
+    g_source_attach(s->hup_source, chr->gcontext);
+}
+
 static void char_socket_yank_iochannel(void *opaque)
 {
     QIOChannel *ioc = QIO_CHANNEL(opaque);
@@ -520,6 +550,30 @@ static gboolean tcp_chr_hup(QIOChannel *channel,
                                void *opaque)
 {
     Chardev *chr = CHARDEV(opaque);
+    SocketChardev *s = SOCKET_CHARDEV(opaque);
+
+    if (!(cond & G_IO_HUP)) {
+        /* Readable while nobody reads: only EOF counts as a hang-up. */
+        int flags = MSG_PEEK;
+        ssize_t n;
+        char c;
+
+#ifdef MSG_DONTWAIT
+        flags |= MSG_DONTWAIT;
+#endif
+
+        n = recv(s->sioc->fd, &c, 1, flags);
+
+        if (n < 0 && (errno == EAGAIN || errno == EINTR)) {
+            return G_SOURCE_CONTINUE;
+        }
+
+        if (n > 0) {
+            /* Data nobody will read: stop watching for it, or we spin. */
+            add_hup_source(s, G_IO_HUP);
+            return G_SOURCE_REMOVE;
+        }
+    }
     trace_chr_socket_hangup(chr, chr->label);
     tcp_chr_disconnect(chr);
     return G_SOURCE_REMOVE;
@@ -611,27 +665,13 @@ static void update_ioc_handlers(SocketChardev *s)
                                      tcp_chr_read, chr,
                                      chr->gcontext);
 
-    remove_hup_source(s);
-    s->hup_source = qio_channel_create_watch(s->ioc, G_IO_HUP);
     /*
-     * poll() is liable to return POLLHUP even when there is
-     * still incoming data available to read on the FD. If
-     * we have the hup_source at the same priority as the
-     * main io_add_watch_poll GSource, then we might end up
-     * processing the POLLHUP event first, closing the FD,
-     * and as a result silently discard data we should have
-     * read.
-     *
-     * By setting the hup_source to G_PRIORITY_DEFAULT + 1,
-     * we ensure that io_add_watch_poll GSource will always
-     * be dispatched first, thus guaranteeing we will be
-     * able to process all incoming data before closing the
-     * FD
+     * A G_IO_HUP-only poll() is not woken by a peer close on FreeBSD
+     * nor reliably on macOS.  Therefore, while nobody reads, ask for
+     * G_IO_IN too and let tcp_chr_hup tell EOF from data.
      */
-    g_source_set_priority(s->hup_source, G_PRIORITY_DEFAULT + 1);
-    g_source_set_callback(s->hup_source, (GSourceFunc)tcp_chr_hup,
-                          chr, NULL);
-    g_source_attach(s->hup_source, chr->gcontext);
+    add_hup_source(s, G_IO_HUP |
+                   (chr->fe && chr->fe->chr_can_read ? 0 : G_IO_IN));
 }
 
 static void tcp_chr_connect(void *opaque)

-- 
2.55.0


