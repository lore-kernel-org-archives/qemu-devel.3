Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E190AF459ED
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 15:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBDQi-0007g3-JE; Fri, 10 Apr 2026 11:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQg-0007ZZ-RQ
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:05:54 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wBDQf-0002ZS-7C
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:05:54 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-35d9f68d011so1484460a91.2
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 08:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775833551; x=1776438351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NsI6Qqs4AUchAJ89hl2uKc8SPPduRq1NaW8uY3dlWFc=;
 b=NAx1VusIavEVYH71AKS53+0NttJoaN4wraqCp1sWHQhVeRgqi2IgyqZUKKvdwwkmQz
 U2ainIB3UuPA5Y2LGUbUieEcFVfJ2qpqnBcwjjQJo383rox7LdV40zZa2vxU/OVF0gXE
 ldX36jFTo4IFeqpMLzPICq60BHVVoj/HVHeSK4vbAG2xKXiYV9n3VC3bapSoWxHBzpu0
 +jj0bQWrkeX7zURUyPimeZg5L/dvZGegkPNdCnlKKoRa/gxpuRFOTo5UiYeTNOOK5Yy7
 PDp5Q1iSKu+Ohn5LfH/HFvYxyBnfTiMl2MP7K5xylP4x9JERygdmeqaXcE5ynYXkvCHt
 tQ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775833551; x=1776438351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NsI6Qqs4AUchAJ89hl2uKc8SPPduRq1NaW8uY3dlWFc=;
 b=SXd7FGZi+dqHol84mKsc0kpP6vCWCjlRuX+w5OQnAhutZpekv/nwp61gJQMIn1zN2/
 cuZO311YO2uZLM2RYW1eIoxkFQ0cfGvKiTsXS+CdfC9V9CvptPKjBo88fVrkczv0ZeAD
 Sui8Gl5vRgppgPAYsPRddvKZPvLQiURo6/ondgiP/pEpZHXGPOHPTr1t0KKmnoS0Cqsb
 xuZ8QuRsUnp0WNG4GUoYEOxpqZX2t0wIOqoW5GMJiiuY4qYmxnMjj1Av83YJgbUvSJS8
 OEVeeL3x0r9V+It1KZjvblJ0oGWAbOYejexr1W6k8SRkFTNC7lWuw1ExnTRZCsfpcRhU
 j08Q==
X-Gm-Message-State: AOJu0YxktFmpEb5+5pZw8HR+pizxJLfzaMOG97Gq541BBqGIacsWJZdr
 xEJMvns7QOfHg9dmisicB30H1Y2fFVaFdYuX8z8SQiB6hsKGi4LgssOJrnCuCp8Z
X-Gm-Gg: AeBDieuQthZSEpeUsKrjvFNG082CCv+EW6n/M4ndH1yWwkIM1d0i1SY3Dxm8qmr+E4+
 teP8addlAgBgLQ5R6ZPznuS936wisH72wHWd6dcAiYBIkrkeSY/FwsWxNuWzNA+4+GFxcQ8ie2u
 jBE0b+NLRjdVBHkjFVFiu/VkwDVML33+agZo5j819r2tRCdHkYDoECHMlTz6AoXy0Fa5Snaords
 CMFtHvULKHLOe4y+cMA/KauCiWK0hVwFuQUuGC2ivPW+kgklAD0FGetrWuJzqcUZjh6+4cQPTAx
 7O9WolfuS9H9asby+RcTNIL8uIzSTfzXlDx0XxMxONAe8ivWxa+iljVG6Jxapzkth9i/rnhSKY0
 EoSqdI3mm0FVNJvSj+s+b6ITwKf+CHaW5xZQ2PuVBwtUoEM+o0adALe6IISILoEAqBeI5c2HGGL
 TpiJOFFQFNGrgiHcLzVdi6Q5aPRb2URrsl+oKA3a+k3H7xjYFeGQaP
X-Received: by 2002:a17:90b:17c9:b0:35d:a87b:ef69 with SMTP id
 98e67ed59e1d1-35e4283ddd4mr3769800a91.28.1775833551167; 
 Fri, 10 Apr 2026 08:05:51 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.168.88.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e4131cfacsm3565785a91.10.2026.04.10.08.05.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Apr 2026 08:05:50 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V6 11/14] vfio-user/proxy: Update tracking iothread users with
 holder name
Date: Fri, 10 Apr 2026 23:04:54 +0800
Message-ID: <20260410150457.85190-12-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260410150457.85190-1-zhangckid@gmail.com>
References: <20260410150457.85190-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x102a.google.com
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
 hw/vfio-user/proxy.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 314dfd23d8..eebe202c4a 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -898,6 +898,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     QIOChannelSocket *sioc;
     QIOChannel *ioc;
     char *sockname;
+    g_autofree char *path;
 
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
+    proxy->ctx = iothread_ref_and_get_aio_context(vfio_user_iothread, path);
     proxy->req_bh = qemu_bh_new(vfio_user_request, proxy);
 
     QTAILQ_INIT(&proxy->outgoing);
@@ -967,6 +969,7 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
 void vfio_user_disconnect(VFIOUserProxy *proxy)
 {
     VFIOUserMsg *r1, *r2;
+    g_autofree char *path = object_get_canonical_path(OBJECT(proxy->ioc));
 
     qemu_mutex_lock(&proxy->lock);
 
@@ -1021,6 +1024,8 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
     qemu_cond_destroy(&proxy->close_cv);
     qemu_mutex_destroy(&proxy->lock);
 
+    iothread_put_aio_context(vfio_user_iothread, path);
+
     QLIST_REMOVE(proxy, next);
     if (QLIST_EMPTY(&vfio_user_sockets)) {
         iothread_destroy(vfio_user_iothread);
-- 
2.49.0


