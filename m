Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147AE606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B63epMw9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMkgD-0001Rc-Ca; Fri, 30 Oct 2026 07:21:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xMkg1-0001Nm-Jc
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:21:42 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xMkfz-0002mP-93
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:21:41 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-48e46e449e8so368873f8f.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 04:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793359298; x=1793964098; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pcS+Jwk9ybuv9CPMRa2h0bU6xc+TDlXMtbvBgX/ZHzE=;
 b=B63epMw90NTSeAoW3SvGIVD9/7hJZ0zbgQdlu/Z1uW2zBOp2aHXK5+L/p+4xEVFx2X
 3FUdc4VZdoCvHGJB1FwkChMFB4JlCSZD1ejKvqmv5oWK1gkIX4Q+fsnBMTXzu7qk/ZT7
 MwhcYcTzuzMuWFCWO2eFJH1r/OChE1lLDcqBCJNo3iIM/tEb1egBcgz5Fho3JX3shOqx
 7M6wFp0mVQFi2/QmmpDD98kaU/Rp6bcrVBWAJitz2pnjhy1y42ykKaWGCHIscahVpIAX
 QMhI+2wJDolsY4c9h0G/VoV3jaA0kalyFXIF9NdXoQgNuqoBIvecgQ0RdUH9XwTy0Q9R
 q+KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793359298; x=1793964098;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pcS+Jwk9ybuv9CPMRa2h0bU6xc+TDlXMtbvBgX/ZHzE=;
 b=Y979pisrKmGjckcMAZUmF9M8Pyh2xBdgVeUzFTp3sj6myxQQdw0qwhVs51jXZfI3MS
 bl01rl6Rhnv0yPoTdRiTAo7/gjncAZ5/JHETJZjpWFaylpN9RKySCQ6ktH6p0KjketFU
 TUA5+++R9KIUwJV/j/9ORgH6UtS3m96B3WlrLj7sJJ557TViY7ukf9J4tOedEAKtwkPf
 MWY/haHNAq5EBwBw/osnHkx0zps4P2A5Apoby0b3Ohs5RgmmXWXjohVzAfy+bMQ9Fq3C
 CdcCUjBJnNgEKOGLdz35zjpaelcJmaRqp71uEyjA8yl4WI1p5spGMsTAqGI9INptDUqb
 HGyA==
X-Gm-Message-State: AFq9FYK1SfkeRFmf+EevVhzClcRu30k9GVqR8ftOFrEQKsjyrao9nw8m
 jlm4e+EiKVFpNIAfzQFu5IJ/ldj2kvv3aUCp9B5/qZdxKxlMKG9PoF866G/WnpsU
X-Gm-Gg: AYBFou38+Yi6Tvwf81+PXczp5icyD5aqHsRQ5uJApmXTRppu7H4PdjF6dEf5R4Bg7W8
 kRUTw8AOZ+TkZmgBvoy7Agow2t01fJKCKI5cEW1DB0pzu9xPPm0Jgtl0w21Re20Aajaq5MpeNmn
 4pORHxbhX+WzlFpg8RSzcJZQ0rpN7Xe/M2cLcCA0/TpfioQSMoYsdxvO4KfpQH1JXjerddKVhQL
 JBE8mGOcEBojQV0odQOCED4uvd+ZqcPoeBHRLBEz8bh+1TijxCj4ZPq9DicMMZHmsisnOWvWZwp
 pI/aLEFZquAZRqZeZIbNcHXBZFC9/eyQsiRYBXI98vWug0e5ynfN+1flukSyzAE2bGbrdshR5w/
 6OtmK2Qj6wiPe3eisifCZuPFrUflJl2aVOVPfw5tv4KIa6YQTq4A/2rP9wez3QYjsfGjPILg/oC
 nSwp6UbNIdPGXehj1jGZKFGps57HBN5jnnCG9m3H8nOWXffNZp0Z4rLjZDQ6epcEDLMOm55iDPr
 SErBLEp3TP+eEX5SGKurF9q2i81EwnMEIqd2reuNRo10B+LwAf1zTVcl9A8oDDSOOiKlyVWVJZQ
 eOXpcwHba0Hk2LLaFV9gVMHGVHiBY6WKuZoIFYSX3C3hRpb7JEbdZyY194rQcFbkNvArDLmjMNV
 py5PifML/DI3olhka0CNUdc9GvhMnmnr4Vq+dP98jXsrmRgss6JYPTBBXKhzZRO3vrRayx8QCD8
 Ch3xFVpWw=
X-Received: by 2002:a05:6000:29d1:b0:48e:37dc:7ff8 with SMTP id
 ffacd0b85a97d-48e6e5008bfmr2729956f8f.22.1793359297651; 
 Fri, 30 Oct 2026 04:21:37 -0700 (PDT)
Received: from tim-m2.local
 (dynamic-2a02-3100-61d8-3600-98fd-cd98-7ae6-cb49.310.pool.telefonica.de.
 [2a02:3100:61d8:3600:98fd:cd98:7ae6:cb49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm2893608f8f.6.2026.10.30.04.21.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 04:21:37 -0700 (PDT)
From: Tim Pambor <timpambor@gmail.com>
Date: Fri, 30 Oct 2026 12:20:59 +0100
Subject: [PATCH v2 6/9] chardev/char-socket: detect peer close portably
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-vhost-user-posix-v2-6-cda7c17aad13@gmail.com>
References: <20261030-vhost-user-posix-v2-0-cda7c17aad13@gmail.com>
In-Reply-To: <20261030-vhost-user-posix-v2-0-cda7c17aad13@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-block@nongnu.org, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Brad Smith <brad@comstyle.com>, 
 vhost-user@lists.linux.dev, Tim Pambor <timpambor@gmail.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=timpambor@gmail.com; helo=mail-wr1-x436.google.com
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


