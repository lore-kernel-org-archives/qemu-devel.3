Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97287CD4F54
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 14:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSbnk-00063n-Nx; Thu, 28 May 2026 10:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sheldon.qi@canonical.com>)
 id 1wSbkM-0004fH-Ri
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:30:06 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sheldon.qi@canonical.com>)
 id 1wSbkK-0000YQ-QU
 for qemu-devel@nongnu.org; Thu, 28 May 2026 10:30:06 -0400
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1E36A3FA54
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 14:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779978601;
 bh=4vuM9QE5ZOYJh2fuZffkiBl/XpAbZnfydLGidVOT+f0=;
 h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type;
 b=ZHFd8FX26PbqnayNdh3l31NlhAztBvxzrsypAowPrpcBgyJuvZ5Z5QzxQa+VyPXEx
 SUn+J8qjytZCSQ8hPHTtcjK+1p4sAmjCEvu5wuQfzLv3153F6wB49J0ApTgAia6dDI
 8vlYNqKHbRS5+Gc22LRiblJx/mFne1Pv6NwfHCWDbRmbm/+e0fJlvapjyjShhn6ayx
 7adf694v4vSRJQAsKJtuKyy+3HOtlFITmHBjBgQ9cgBMvbREt9kE+d/VfLWLbwzsnL
 1O7m6Mw6/f+kBr/CdRsLrIVWFC2C+6J6zzxC0XwZoCCBpiggPr3Qwemj8UY7ZGCfyd
 cDC+Si55McJXgaZPykYlGems0R4Z79ewLrc0PlZLlgeSHgShRuaDScH09B+PJLgNie
 9KsJo8GEOWAn8UzcsZKBJhUHv/psYVWfOMi6B+rm6U+VBSUKqAWCaMMpQVu8WlOlTb
 5RszmEaHSaE3ZE0FwIE/KR+CV4TvK/XC5nAnFhzb9MnWJ3RsXYn3ncpi2l0gBIMfJm
 KrKgO3MU2eS4cb33lUX7oPpjRoKIq942xZH1iKiqiQNPMLxjbAdutN0h5kZCL5Zkz+
 qI87q7wEtuQHc9/4rZbfk+B20z0V7kK0RUT1nHAejljIPM07iH3M0cte12tKsEH+Xq
 2zIMB8cb+nL/p+jJ0QCEu0/w=
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-bde08e20ce9so147918066b.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 07:30:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779978601; cv=none;
 d=google.com; s=arc-20240605;
 b=jUBdJ2nYjsfJySq8lTdx2nnI8ivDcCGVkVNMKKHJwVPjbwdA+Im3pVb+cEZWiazAdq
 ARU7JExD4y3NTiKafzZo9+R31B+Z7j17MJfy/DqD5P0DGCPquSltctW9tnJRIFLbDZWv
 m0DbHQ5/H0XG1acEoTPoaAJnoSExqHsSPv0XgjfU4JrYeirPOMWqcVZ4u5jKLZC0houl
 tfpQVLwOwPlVtFrBZhKE8U12IO3guyvpRhKBNSrjD8cog8p+aBK5f9seU4HDukmW5Uqw
 NRqlNC4iUCZn560WlcZwn2Xa0i34nV96K9wdF7ejPcTvEnyNJIGj7KVR+R9nt2YQR29K
 u78A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version;
 bh=4vuM9QE5ZOYJh2fuZffkiBl/XpAbZnfydLGidVOT+f0=;
 fh=pIJyiNsqAR4QJ2/4Ht//unTjXixvYgZ9MMlZLY+AKKI=;
 b=GfjTovssnO5z6mTKqyByF8d/oHfe33a1FcbpuxmM3d/aZkuhl5t3p7DE/6ejTgi45b
 VIRUFjcUZDRT2QkR0oCQali6DdqCBphBZ/WFh7yfcGLEfR/x0fFBntbPCmlaTBQ+8lOy
 W5/KW+lBn773DlsPNDAD99P7Pu0rnCC3DzzroiRUgDBB1a4h4oth1lNWiIfIMHgHdgWg
 2XqXSLHqrw16pwrNzDMSplUx/nFjLJbkOWV/LtLk+rWiP/7QKUCl7GJEJZwwE8AyDme5
 ZZGYk778y34onmgpvqoRFDLfxAEPKO7S/KgENsa/EoPkrbvUa4P58w274zdBCVu2I97I
 1DaA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779978600; x=1780583400;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4vuM9QE5ZOYJh2fuZffkiBl/XpAbZnfydLGidVOT+f0=;
 b=KNN76wbC40nkBWQlgU/KqlK68VcUgUh7GXuQB3Dv6PIjijHEFl8B2rhRoV/swY2/XE
 vPd/mDObbnL/pelZPooc/J8IuT0QXKZm34vK5Bu9dxYIuyHVujOLd6aJA7eXYrQCkdgy
 pPtjdgfbrEvX3kRCNVn+gS8rYjUtK7E0NskchR6hofimVLnx2ShSKwE48eyftTJiqBlZ
 UeDYqP8vTxmdaTPr6Txph3MLzt6U+pjBiAGdvJ7JsDbf6skkZSh5nAUOPkn0U8lC11IQ
 OXhKGEC2Onh+mJvVfjs4siX0LdkbzIURMRFObUBk4rEAsRt0gFDeqB/gGuRtD3ZVXxjL
 E2Vw==
X-Gm-Message-State: AOJu0YyTVJ1UKSqyZkeyC32jVl+7QYDwlwUJj+Q2D9AyqLPheSsPab3a
 plJ7Lln9z4RxfAZox3o4RWh44ayT1ChuKWqCm7jjjq3rzeGsE0+o6ft6mlrSmcTlZqwilZMlzVn
 d8EdOFvpk46cvfrAE8RgzJO+Ic8SjrfNqCisnXHUo1ar6A2kmAMup3pnT/3uQKkzJ/tb+ptc0sa
 d5l/kO2qWBsXNoLwIaesnLVxQHhzJzWQAumA3fQs6DkD0kNKX+HMEHpvQWDw==
X-Gm-Gg: Acq92OHEb85TNfbNTm+Z71RLN8lqMbg/5sWmVYxOdzwpw2PUrKZs5BuBAmYLkUgnbmn
 pUQmW2jIkapNRBet6V6PqckR8JylZ1CjYNPljx/y/B0csnP5IHKDZF6+0a6odv1b7vKtKzIOgtp
 k2MeiSLBB9lhGOAnAmBviCmHGtCJ5mTn3v7TFc3E3RZxUmy7irZBqunpKVDnIkxLAApMJYnm3B7
 JvPGdq8KaN2aHJdiR8=
X-Received: by 2002:a17:907:3ccb:b0:be3:dfa6:3117 with SMTP id
 a640c23a62f3a-be86d71c29cmr108716966b.3.1779978600677; 
 Thu, 28 May 2026 07:30:00 -0700 (PDT)
X-Received: by 2002:a17:907:3ccb:b0:be3:dfa6:3117 with SMTP id
 a640c23a62f3a-be86d71c29cmr108715366b.3.1779978600209; Thu, 28 May 2026
 07:30:00 -0700 (PDT)
MIME-Version: 1.0
From: Sheldon Qi <sheldon.qi@canonical.com>
Date: Thu, 28 May 2026 22:29:42 +0800
X-Gm-Features: AVHnY4IsJvgd7e7sSI_ghYgft0wwKzHxYnqFdc77M8xs8hNPgtDaUk04Li4FDp8
Message-ID: <CAN3A0YpG0571=uNMsbKNs+Xf+i4WxVKnCTQQKCuyP7t3Zk4dgA@mail.gmail.com>
Subject: [PATCH] block/curl: fix Win32 socket handling in curl_sock_cb
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, hreitz@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=185.125.188.122;
 envelope-from=sheldon.qi@canonical.com;
 helo=smtp-relay-internal-0.canonical.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 28 May 2026 10:33:35 -0400
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

From 5cf4935ab0770d2d45d32ae5bb3531c0c9a5848e Mon Sep 17 00:00:00 2001
From: Sheldon Qi <sheldon.qi@canonical.com>
Date: Thu, 28 May 2026 21:28:06 +0800
Subject: [PATCH] block/curl: fix Win32 socket handling in curl_sock_cb

On Windows libcurl passes raw SOCKET values (UINT_PTR, 64-bit on x64)
that don't fit in int, so GINT_TO_POINTER() truncates the upper bits.
Wrap them in CRT fds via _open_osfhandle / _get_osfhandle so that
aio_set_fd_handler and curl_multi_socket_action receive valid CRT fds.
This matches the pattern already used by io/channel-watch.c,
ui/spice-core.c, monitor/fds.c, and util/aio-win32.c.

Close the CRT fd wrapper in curl_drop_socket and on CURL_POLL_REMOVE
so libcurl retains ownership of the underlying SOCKET.

Signed-off-by: Sheldon Qi <sheldon.qi@canonical.com>
---
 block/curl.c | 44 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/block/curl.c b/block/curl.c
index 684c677ef7..0884d96fe6 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -110,7 +110,8 @@ typedef struct BDRVCURLState {
     QEMUTimer timer;
     uint64_t len;
     CURLState states[CURL_NUM_STATES];
-    GHashTable *sockets; /* GINT_TO_POINTER(fd) -> socket */
+    /* GSIZE_TO_POINTER(raw_sock) on Win32, GINT_TO_POINTER(fd) elsewhere. */
+    GHashTable *sockets;
     char *url;
     size_t readahead_size;
     bool sslverify;
@@ -136,6 +137,10 @@ static gboolean curl_drop_socket(void *key, void
*value, void *opaque)

     aio_set_fd_handler(s->aio_context, socket->fd,
                        NULL, NULL, NULL, NULL, NULL);
+#ifdef _WIN32
+    /* Close CRT fd wrapper; libcurl owns the underlying SOCKET.  */
+    qemu_close_socket_osfhandle(socket->fd);
+#endif
     return true;
 }

@@ -167,13 +172,29 @@ static int curl_sock_cb(CURL *curl,
curl_socket_t fd, int action,
     BDRVCURLState *s = userp;
     CURLSocket *socket;

+#ifdef _WIN32
+    /*
+     * libcurl passes raw SOCKET (UINT_PTR, 64-bit on x64) which doesn't
+     * fit in GINT_TO_POINTER; wrap in a CRT fd and use GSIZE_TO_POINTER
+     * for the hash key.
+     */
+    socket = g_hash_table_lookup(s->sockets, GSIZE_TO_POINTER((gsize)fd));
+#else
     socket = g_hash_table_lookup(s->sockets, GINT_TO_POINTER(fd));
+#endif
     if (!socket) {
         socket = g_new0(CURLSocket, 1);
-        socket->fd = fd;
         socket->s = s;
+#ifdef _WIN32
+        socket->fd = _open_osfhandle(fd, _O_BINARY);
+        g_hash_table_insert(s->sockets, GSIZE_TO_POINTER((gsize)fd), socket);
+#else
+        socket->fd = fd;
         g_hash_table_insert(s->sockets, GINT_TO_POINTER(fd), socket);
+#endif
     }
+    /* Switch to the CRT fd so the rest of the function stays unchanged. */
+    fd = (curl_socket_t)(intptr_t)socket->fd;

     trace_curl_sock_cb(action, (int)fd);
     switch (action) {
@@ -197,7 +218,17 @@ static int curl_sock_cb(CURL *curl, curl_socket_t
fd, int action,
     }

     if (action == CURL_POLL_REMOVE) {
+#ifdef _WIN32
+        {
+            /* _get_osfhandle recovers the raw SOCKET for the hash key. */
+            curl_socket_t raw_sock = _get_osfhandle(socket->fd);
+            qemu_close_socket_osfhandle(socket->fd);
+            g_hash_table_remove(s->sockets,
+                                GSIZE_TO_POINTER((gsize)raw_sock));
+        }
+#else
         g_hash_table_remove(s->sockets, GINT_TO_POINTER(fd));
+#endif
     }

     return 0;
@@ -409,13 +440,20 @@ static void curl_multi_do_locked(CURLSocket *socket)
     BDRVCURLState *s = socket->s;
     int running;
     int r;
+    curl_socket_t sockfd;
+#ifdef _WIN32
+    /* socket->fd is a CRT fd; _get_osfhandle gets the raw SOCKET.  */
+    sockfd = _get_osfhandle(socket->fd);
+#else
+    sockfd = socket->fd;
+#endif

     if (!s->multi) {
         return;
     }

     do {
-        r = curl_multi_socket_action(s->multi, socket->fd, 0, &running);
+        r = curl_multi_socket_action(s->multi, sockfd, 0, &running);
     } while (r == CURLM_CALL_MULTI_PERFORM);
 }

-- 
2.47.3

