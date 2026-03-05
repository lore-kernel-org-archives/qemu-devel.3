Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56137F33A71
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:26:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy9eC-0004DW-1I; Thu, 05 Mar 2026 09:25:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vy9e9-0004Ae-2d
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:25:50 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1vy9e7-0001oU-Hh
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:25:48 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-c7382731edfso946134a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 06:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772720746; x=1773325546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XFc1PNVQTk8IE+nRshXy8adghP6nTp9F8kVgZHkj1No=;
 b=G7doT1KsG1JT/zyGwjzfMih1JgNQFImqlSgctarOJRVqZHQFWLeC2MraO4+6KChyst
 2wX4/534w4Wukg8PTjUyUBV4Yeh1l3CRugneQsHPwfcuHl1QM34KGvT3HuGrXi1QUTVz
 uQvJDDJBSw3T+chUPjZ2PBRAaEAvb9Kir3JGR2ZGQen6MHzt35g2tnR4KNd03FqmZiSa
 ZufEAC6ZGTQKxp/ntIroqWoFfYzMAuPBVogcZ16ImBgvNyyU0fdG0kC+8YwK3foWPcoI
 IZ/qK6aFcedBK9cHcGrN+n+vd7b5kC0XAcFswxH34aznzwMXs9f+bv3wosBaNxgDzwjw
 bKuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772720746; x=1773325546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XFc1PNVQTk8IE+nRshXy8adghP6nTp9F8kVgZHkj1No=;
 b=RAH3/Zwu/dIMXnae4witRV8jBSS+GRLAXxXM3Z1pJbvFRGkHULCC/MBxDyYPbLqzlG
 /O4RRflFap8vW93Rkaa7Trus+Nyer532SECnojFcv+KhVPsZ+qmxDfx4UPTXwUYxUiAu
 gVvmJgre2FU9P/TUeDK2UH+8tUG0ew5ViHhmVZdbsHJZmlRIvVtUjv+q7IzLeY6Y5fb5
 JZZkI1/5+KjQ+URe5d9+9rdgh0fHF7W0HeWgprKBIIThJmmVMA8I9E3IQD5+VT6IC9yS
 lcp7IWQvVbcuh7vUa3usptfBFqE1MO7YBwM5N1exSlEmRGw7Qn6EMTkDa8SGUURRwNp/
 2Ejw==
X-Gm-Message-State: AOJu0Yx2PnpIxDF35tGQfd467zwGAW3Z6jLHXSIjZ+ycRuQ9N9E1QZ++
 p6v+E2p26J3WEDppDyPDZerwSoJHFx+csNBSI67PD7c4g0YnqcVf45CHrMP7lfCM5SDiSQ==
X-Gm-Gg: ATEYQzxf1QJ+85nbvekC/dm+dUn6/KdQBYPnouVXjtmHSGp2T7CpBdm4Z64S/s1bNqP
 Ksvsj+SUGjnZRZwcvpy0MNO5+UcvLcSnx4x55LIq5yf3dgE9K4hmNBrV7ciLryMcqqRPRd67Lpg
 12XvDmGcVHZIBVpRB/MTn+AaDtgxtUQUxaQS4YkEPxX5mzilLNntn30CdHzLcciUFLV/HTzfEZq
 Z5k2MnNRNrpPuicbQscQd3ZnW7u/V8umQW7K890ngBPOzKcnmQ79raYpbmnbNGm7PgpBx9jvrpK
 6RZfOXec9TBlbaCsMRjTOQ01PI5tyOJoh09iDFf7MhPO9a1zemg8iyTHeoBeKy/VIkl70sCQrDR
 oUsp4Kk5HzAhsjMZgBORVmLAnaSXPr+m2b67qAN8f4oAp4eB5GF+wi7I6LvhUSw+MVjHCWpoS9l
 SndQCHBK4BsFb2694RqXGEN/EQlIr9ciWn9jDqJ2WV/K5QKFTzLbyh8LBxnW4Vqkp0deQ=
X-Received: by 2002:a17:903:1207:b0:2ae:7f24:4940 with SMTP id
 d9443c01a7336-2ae7f244ae6mr3151845ad.50.1772720745708; 
 Thu, 05 Mar 2026 06:25:45 -0800 (PST)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49:0:1:b277]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ae4650000dsm140204835ad.54.2026.03.05.06.25.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 05 Mar 2026 06:25:45 -0800 (PST)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V5 11/13] vfio-user/proxy: Update tracking iothread users with
 holder name
Date: Thu,  5 Mar 2026 22:24:57 +0800
Message-ID: <20260305142459.52559-12-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260305142459.52559-1-zhangckid@gmail.com>
References: <20260305142459.52559-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=zhangckid@gmail.com; helo=mail-pg1-x534.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add object_ref/unref calls with iothread_get/put_aio_context.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/vfio-user/proxy.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 314dfd23d8..9db17653d6 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -898,6 +898,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     QIOChannelSocket *sioc;
     QIOChannel *ioc;
     char *sockname;
+    char *path;
 
     if (addr->type != SOCKET_ADDRESS_TYPE_UNIX) {
         error_setg(errp, "vfio_user_connect - bad address family");
@@ -917,6 +918,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     proxy = g_malloc0(sizeof(VFIOUserProxy));
     proxy->sockname = g_strdup_printf("unix:%s", sockname);
     proxy->ioc = ioc;
+    path = object_get_canonical_path(OBJECT(proxy->ioc));
 
     /* init defaults */
     proxy->max_xfer_size = VFIO_USER_DEF_MAX_XFER;
@@ -936,7 +938,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
         vfio_user_iothread = iothread_create("VFIO user", errp);
     }
 
-    proxy->ctx = iothread_get_aio_context(vfio_user_iothread);
+    proxy->ctx = iothread_get_aio_context(vfio_user_iothread, path);
     proxy->req_bh = qemu_bh_new(vfio_user_request, proxy);
 
     QTAILQ_INIT(&proxy->outgoing);
@@ -944,6 +946,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     QTAILQ_INIT(&proxy->free);
     QTAILQ_INIT(&proxy->pending);
     QLIST_INSERT_HEAD(&vfio_user_sockets, proxy, next);
+    g_free(path);
 
     return proxy;
 
@@ -967,6 +970,7 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
 void vfio_user_disconnect(VFIOUserProxy *proxy)
 {
     VFIOUserMsg *r1, *r2;
+    char *path = object_get_canonical_path(OBJECT(proxy->ioc));
 
     qemu_mutex_lock(&proxy->lock);
 
@@ -1021,12 +1025,15 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
     qemu_cond_destroy(&proxy->close_cv);
     qemu_mutex_destroy(&proxy->lock);
 
+    iothread_put_aio_context(vfio_user_iothread, path);
+
     QLIST_REMOVE(proxy, next);
     if (QLIST_EMPTY(&vfio_user_sockets)) {
         iothread_destroy(vfio_user_iothread);
         vfio_user_iothread = NULL;
     }
 
+    g_free(path);
     g_free(proxy->sockname);
     g_free(proxy);
 }
-- 
2.49.0


