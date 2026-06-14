Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45992CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqB5-0002Dg-DY; Sun, 14 Jun 2026 15:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqB1-000226-8v
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqAz-0001wQ-J9
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464041;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xKVTfr9eil4RAYxuwVtA/XauKHWMtTW+RXtJLde9A7U=;
 b=aZxYz3VAHTj2w4N3HQmZHo8GWe34MhTZxRi5lSWER/jx6IGBASNNoC6IeZoqzxSPJDa4du
 dBmPPXr4JkkgNfcfF9hbFM52aFPAaOSquFavEgobJuIWoME9YKgbz3OK+hjLsoqe2rD3gv
 2uH7w8/eH7zf6cCB0Gxau1xPEUXl9P8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-EwXwkWOkPtGUgOlTsu57Yw-1; Sun, 14 Jun 2026 15:07:19 -0400
X-MC-Unique: EwXwkWOkPtGUgOlTsu57Yw-1
X-Mimecast-MFC-AGG-ID: EwXwkWOkPtGUgOlTsu57Yw_1781464039
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-490b3f53c81so11136155e9.3
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464038; x=1782068838; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xKVTfr9eil4RAYxuwVtA/XauKHWMtTW+RXtJLde9A7U=;
 b=bPzLJY42NyIXfimHMDbWrMA6yS27OdNr6OythGGfnivg5cG6hJZumXba9hwOW6Fgjy
 wumLcp18tPETbp2Kqfnwa5n7Sxn5GV/bg6rB/pPReMDsrpK/WjMzXv+g6R2yQoHtRrlZ
 GSCLhsGcEaU+weXNACai9wxwuAGMHdjXHQkgI8/sRoWK9eyYu4CTsevyYEcX0vXkFu8j
 Zit7oVcIuE1nNAbNBPIk74h3Mu+QeDnUGqa9Kfl1nDQJ5UXm+9TVaRPNFkRS+yRJLDEC
 qO8fXLe24C9OyZARxf/zdN/bDdxLmfhiBBSjZJb1WVrUZF5BcU7ucwraSk08P5RW0oB7
 fCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464038; x=1782068838;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xKVTfr9eil4RAYxuwVtA/XauKHWMtTW+RXtJLde9A7U=;
 b=XDEb78xd7qH1hXuBQa483ZeQWW1E+EyF6F1hxykUgF0I0Nlm/g0atumGicYnI/6OCD
 HAY4Xgh6am1/j0w9biu+MmLmF6UGuJ+kN7TvLGpDOpuZixGcrkKkBdHdajLnPvzQ51A9
 GprjzvurS150U7IV01V87NmOpm1jTqH7Tvl9PERe9LD5eTdHZng9t8eJBBTWA6XkysgR
 ukGgkc2U6pNNm6zXh++Tf5yt9P9PUYOUKKr2V4uLIT0R9/P5xGLWLg/nm4169ajNtWJt
 zQF9caI2frvufftH7hLopOb/YSxHm6B3bjrcHuZZ3CEsHLuTGyblJqYA2JLJRllVwNpV
 MY2Q==
X-Gm-Message-State: AOJu0Yx2ikZ7OqXeJj6umRke7zNysmvBfPfwzsQfaZvw/zU1px5Hbuar
 y9JBkL0WkfBlEuSozemz6g4uBwcJKO2zbmlLnzKHvtcdvA6Y+2QDucXD3p7qRf1nAOdec3NYV2i
 K0RLRFGhoWXZaD0Dj3QyEPufsUG6O0dLhccBINQbSjRgzHczL6GGqfnLzWTuRxJZuEPaejw1KEP
 XVKS7dy2l0tqxjwGhjTy/UgvaMZJ3UTPxoXg==
X-Gm-Gg: Acq92OHdvSsbrmi8pJbHUlN8/F3BzdP6+fy9qDUyQu/zAd+gs2HRhxn63SC5SIO/JY2
 Lmg35IPhAMYImWRAtO+orIhlXrs662+t3M468FBESo1jkXzbOHhl9aspwNuHrZFJcppcbdP/55C
 2Y6D7ZUhPa5l8xvKAA+PDqmIVgegAHrecmW/HO8bIHCbNt7cz17QLhlfH0UV6P0yz6OjgLzEvjO
 f8zVNhq3sMlx8r7XGmGY8WZOpUd7gpvgYklmspw3yyyZho9r5cTS1RUVT9aNODhJSvaxPgmPaBP
 xaHEfdYP4YNRJzz5UC7D3DmOSEIGXVLxnxXKW9uxnaORm1JOqCaWNGsuXoUQPia1FYYTYK/KCOE
 FgQcpBVYleZmI1HZ2UT4PExoVdyZqpsKk1fQZ8D0bx8o=
X-Received: by 2002:a05:600c:58d5:b0:490:c2a2:e91e with SMTP id
 5b1f17b1804b1-490ec523a8amr103766905e9.34.1781464038472; 
 Sun, 14 Jun 2026 12:07:18 -0700 (PDT)
X-Received: by 2002:a05:600c:58d5:b0:490:c2a2:e91e with SMTP id
 5b1f17b1804b1-490ec523a8amr103766685e9.34.1781464037873; 
 Sun, 14 Jun 2026 12:07:17 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49220310a58sm210512375e9.4.2026.06.14.12.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:07:16 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:07:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Raphael Norwitz <raphael.s.norwitz@gmail.com>,
 Daniil Tatianin <d-tatianin@yandex-team.ru>, Lei Yang <leiyang@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PULL 035/106] vhost-user: keep QIOChannelSocket for backend channel
Message-ID: <a00d6e75179fba5b6b4ad296ccdc251b02a1b535.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Keep QIOChannelSocket pointer instead of more generic
QIOChannel. No real difference for now, but it would
be simpler to migrate socket fd in further commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260420200339.708640-10-vsementsov@yandex-team.ru>
---
 hw/virtio/vhost-user.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 68dd89cd8f..31eaf65430 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -239,7 +239,7 @@ struct vhost_user {
     struct vhost_dev *dev;
     /* Shared between vhost devs of the same virtio device */
     VhostUserState *user;
-    QIOChannel *backend_ioc;
+    QIOChannelSocket *backend_sioc;
     GSource *backend_src;
     NotifierWithReturn postcopy_notifier;
     struct PostCopyFD  postcopy_fd;
@@ -1796,8 +1796,8 @@ static void close_backend_channel(struct vhost_user *u)
     g_source_destroy(u->backend_src);
     g_source_unref(u->backend_src);
     u->backend_src = NULL;
-    object_unref(OBJECT(u->backend_ioc));
-    u->backend_ioc = NULL;
+    object_unref(OBJECT(u->backend_sioc));
+    u->backend_sioc = NULL;
 }
 
 static gboolean backend_read(QIOChannel *ioc, GIOCondition condition,
@@ -1909,7 +1909,6 @@ static int vhost_setup_backend_channel(struct vhost_dev *dev)
     bool reply_supported =
         vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK);
     Error *local_err = NULL;
-    QIOChannel *ioc;
 
     if (!vhost_user_has_protocol_feature(
             dev, VHOST_USER_PROTOCOL_F_BACKEND_REQ)) {
@@ -1922,15 +1921,15 @@ static int vhost_setup_backend_channel(struct vhost_dev *dev)
         return -saved_errno;
     }
 
-    ioc = QIO_CHANNEL(qio_channel_socket_new_fd(sv[0], &local_err));
-    if (!ioc) {
+    u->backend_sioc = qio_channel_socket_new_fd(sv[0], &local_err);
+    if (!u->backend_sioc) {
         error_report_err(local_err);
         return -ECONNREFUSED;
     }
-    u->backend_ioc = ioc;
-    u->backend_src = qio_channel_add_watch_source(u->backend_ioc,
-                                                G_IO_IN | G_IO_HUP,
-                                                backend_read, dev, NULL, NULL);
+    u->backend_src = qio_channel_add_watch_source(QIO_CHANNEL(u->backend_sioc),
+                                                  G_IO_IN | G_IO_HUP,
+                                                  backend_read, dev,
+                                                  NULL, NULL);
 
     if (reply_supported) {
         msg.hdr.flags |= VHOST_USER_NEED_REPLY_MASK;
@@ -2350,7 +2349,7 @@ static int vhost_user_backend_cleanup(struct vhost_dev *dev)
         close(u->postcopy_fd.fd);
         u->postcopy_fd.handler = NULL;
     }
-    if (u->backend_ioc) {
+    if (u->backend_sioc) {
         close_backend_channel(u);
     }
     g_free(u->region_rb);
-- 
MST


