Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A33C44516
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 17:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkPn0-0006eA-D3; Thu, 16 Jul 2026 13:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkPms-0006UF-9Q
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:22:18 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkPmq-0000Vf-Op
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 13:22:18 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-385ea3ce80dso6870611a91.2
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 10:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784222535; x=1784827335; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Led6dtm27lEqwR8zEWN3ior7m9T5nwFBmwYxnZK8iTw=;
 b=XsZMYdsaGOP+sYUHwROsbk4fXc9jhZeYuHkLt9UnKkDzLd+Nk8sEasbgMCqB8jbKu/
 2Hc/GZYh8brZSEw/rkIMNWN1dJIkzRmr7RrtW/owUBU5VCzVmCdlSdeKq1sg36MIOkxs
 CqdNu8M8JEJz8+j8S8Cgl5afJZLOrGLY1d0J7MU5XnhXR6JeuQ+1Fd7nLopdsrnFcdAP
 TSr+NVPha/z+qGgFJLVzCFxb1xO5SGj3gMipIowtb76Tw1ng9iSINjwL03qQuWpcVYWF
 qTOROnvYOJPHMMKUJO/MV8Arp9n4AP/Sm1tqU63katEcYvHGbUWPmuDlyhyHt1SFCPOD
 CVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784222535; x=1784827335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Led6dtm27lEqwR8zEWN3ior7m9T5nwFBmwYxnZK8iTw=;
 b=PGtM4NdAgCimtUA0gaOzrAyLIfdaAHDFk2hMWxUemli5vlKu4IA8eJXIfB4N89z4WN
 uuNoGrU+M/9+a8ieBtxnvB3tonhjplR7AGlrGzTwjSQtPv7q/ddgkfnSWMj/ylegdCoI
 AtX02hT+mRXoh1OlCL/t5J100fcVCZ+1GYCIvy6C2IuzdgiZzaVERpDlv/nokpLX+n1C
 OZE/Sh0a1waIceRY02zSYp7XjLzIo2hw0vsvlpX2i7JKwfub8eeGw2GPpdZLFeXqOLvq
 yzoCdOLs75TCqQrfzfXDSeb/arGA4hCSRMiWABw4phu1RcdcinlVISI8+94LDbcJVrLJ
 RKJw==
X-Gm-Message-State: AOJu0YxS1TSOdVazLGOijmHmu6jrAA0bgxV+eDkoh5IaX2bnSS1oHd7N
 pV4DoD6WwPsUWhAqt9QIO1Pr0rW97ZxHVFomA1YJgLEfFt9eaphFrfXVOLQwWlTmVSY=
X-Gm-Gg: AfdE7cmomEeeCk8Xi7S2xfqHXPvLU/eP0L283beMUcxfUTHxOB222SOgwevY/wwpy/B
 PH86Q4UosjLD2QbLiKu/83DACi7rrflGLvbNXg6vcH4PGWTTi7PzDRxWatkmqCMdA5X29BWDt1J
 p580Cg+WOVFNe0G0n+jS2lhhScqU4Prr/aap1vT/qjrmHQzr4Hi18DaAH4ycUubWL0Lqs+eskOk
 Y8pQfvVqHnriiCWKRB7VV8rNVMPcuE8y6n/yyAK1rgqiAV9MH0/bz9PNyM2EblKrWxpnTswbej+
 F/YlTKj0SlM9fZLkT+GDqHi84wOEzYZob+l4qcAXSNU/as0ww6WbmMdZkKwMqDY9A8C+0dGLaK9
 CX8gGzB1n7DN/PVq/Rqlhc4XYgnTlMXjaa2kvkE4cChwAl35U8Siu4cqcawXdzlxGMB2NBPjCy/
 93kHGK8DpicgIrUI49TmSEHq5rnNLnL9ML4/QwBvGi
X-Received: by 2002:a17:90b:388a:b0:380:9504:9780 with SMTP id
 98e67ed59e1d1-38e17e672b5mr10846252a91.29.1784222535104; 
 Thu, 16 Jul 2026 10:22:15 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([104.28.233.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e5326c0sm16800417eec.11.2026.07.16.10.22.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jul 2026 10:22:14 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [RESEND PATCH V10 11/15] vfio-user/proxy: Update tracking iothread
 users with holder name
Date: Fri, 17 Jul 2026 01:20:52 +0800
Message-ID: <20260716172108.87700-12-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260716172108.87700-1-zhangckid@gmail.com>
References: <20260716172108.87700-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x1030.google.com
X-Spam_score_int: 26
X-Spam_score: 2.6
X-Spam_bar: ++
X-Spam_report: (2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 hw/vfio-user/proxy.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 0f7d8425d6..b4f749f245 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -898,6 +898,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     QIOChannelSocket *sioc;
     QIOChannel *ioc;
     char *sockname;
+    g_autofree char *path;
 
     if (addr->type != SOCKET_ADDRESS_TYPE_UNIX) {
         error_setg(errp, "vfio_user_connect - bad address family");
@@ -917,6 +918,11 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     proxy = g_malloc0(sizeof(VFIOUserProxy));
     proxy->sockname = g_strdup_printf("unix:%s", sockname);
     proxy->ioc = ioc;
+    path = object_get_canonical_path(OBJECT(proxy->ioc));
+    IOThreadHolder io_holder = {
+        .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+        .u.qom_object.qom_path = (char *)path,
+    };
 
     /* init defaults */
     proxy->max_xfer_size = VFIO_USER_DEF_MAX_XFER;
@@ -936,7 +942,8 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
         vfio_user_iothread = iothread_create("vfio-user", errp);
     }
 
-    proxy->ctx = iothread_get_aio_context(vfio_user_iothread);
+    proxy->ctx = iothread_ref_and_get_aio_context(vfio_user_iothread,
+                                                  &io_holder);
     proxy->req_bh = qemu_bh_new(vfio_user_request, proxy);
 
     QTAILQ_INIT(&proxy->outgoing);
@@ -967,6 +974,11 @@ void vfio_user_set_handler(VFIODevice *vbasedev,
 void vfio_user_disconnect(VFIOUserProxy *proxy)
 {
     VFIOUserMsg *r1, *r2;
+    g_autofree char *path = object_get_canonical_path(OBJECT(proxy->ioc));
+    IOThreadHolder io_holder = {
+        .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+        .u.qom_object.qom_path = (char *)path,
+    };
 
     qemu_mutex_lock(&proxy->lock);
 
@@ -1021,6 +1033,8 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
     qemu_cond_destroy(&proxy->close_cv);
     qemu_mutex_destroy(&proxy->lock);
 
+    iothread_put_aio_context(vfio_user_iothread, &io_holder);
+
     QLIST_REMOVE(proxy, next);
     if (QLIST_EMPTY(&vfio_user_sockets)) {
         iothread_destroy(vfio_user_iothread);
-- 
2.49.0


