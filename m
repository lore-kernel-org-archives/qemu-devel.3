Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B9BC4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 14:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkNJa-0007OU-AF; Thu, 16 Jul 2026 10:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkNIH-0006Uz-57
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:42:41 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wkNI8-0007V5-Tv
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 10:42:31 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2caced6038eso9179815ad.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 07:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784212939; x=1784817739; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Led6dtm27lEqwR8zEWN3ior7m9T5nwFBmwYxnZK8iTw=;
 b=ptIZSLFXYB6b7Qdrvv2Jm53I89BgVQNM/wmgjhdDyoVPDTUt+LUb7MQ7utN5RadDqN
 SkIz9B7tY5Dfq/U8EfOV12SZUpbjuBaurHDxW+X/rkqDozr74UaWPGnDQDE3hEvBpj01
 jvYZrqG+XoaOpCY5yoEL6GLxKGmp6AsPxdENr//PLipQpeH0WHhtU41Z5QbceoWE7nY5
 NfXTroHOeImjVVqi2RllqPg+6DH4mHh1t3jU2ISiGRWOuMYzPf4GE39MxAfLqFHWv1R1
 JCTMn0ChTeoBDCLo6j7v2Q6sRBEvBzrRUG7knKI7VSs/AEIWXkwB1TfMB3A+WzAmo0lx
 HBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784212939; x=1784817739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Led6dtm27lEqwR8zEWN3ior7m9T5nwFBmwYxnZK8iTw=;
 b=JSMuBM/2uZmuirze4q5Uw1hpUITn5B80PEl0V/aPh+a0N2GhzU43VshYLGjSwqoZfR
 Q8x0GSrwxZwY86qq7pUzQc0ojkmhWR1U/KK19YW/JHI6+mSihJ8pgAt2E9JxQQiXNSZI
 5pA1Nkl3SksyRrzn2BTi6wr3J8mgxGESCJVfgRTR1hUTs7zHEXNpidYPBilTcoAgNj7n
 SJRC3uV40E2zXBvr6y1vaDd131oASfLWGQEyDJlNyjwdfs2KXXXEg6mH+Rjv9gRstZTp
 Nwg+RINUBUcgCSpgnQevCNnDlgn0kGhv3PQJDdMjoPNd6QKXh0YM0BbtIzdmn3OSJXeU
 4k3g==
X-Gm-Message-State: AOJu0YyfHBnRBHrlhGQkJP9Q2/OELVAVik42xhIIa4CoI90Fv84Mi3le
 Rxg0bkkqii+oRBX96jKr352T9ddNasWSrzq34j7nIsbzEbUC5MkC+TY8FyNIAT7Kg08=
X-Gm-Gg: AfdE7cnTDUNp3CWPg552cV35+s7pdfMXs+voi5hw63eW/YvV6QTas8gpb+7N8B9ffBp
 dqoHutSOQv8y4gVY5B2GxKLU7xCemDE0gAplrLJJbNB4Z4Cg6uMme5DiDoCGFqBhVoMXQGAFol9
 zMBwvg+Nm0UNOI8YUwSvdLWZ9ppIMqSjrSePqU0XkyLjzL3ZEaedn7ftRUY43EDLfGtdRUCB/X6
 VQ1QWSGBgNWLcLn/Oh1L5dFvK6Xpk60P2m1h923AnzPKYOp5EHUitDNjZbm3VqiJZaAji7KaWm+
 LxdVBKeSC/T0bPFdW4gRxnViGmEWXTnlAZrLuflkmgHeF+waRfgrDR6fNPuR7TmLRGLfE7HzXuF
 wqtLvPoDJYFS/FVuD+clQaGHHqyi9tI8JG4wFyyzoPhlI5ArpYDWLhDULF5MiLJMR7Z3o7ylpkM
 COTlXm6BTqrqdXNtsR1I4qe8F7up/8L9yP7LTxXT0A
X-Received: by 2002:a17:903:1a0c:b0:2c9:ece2:822b with SMTP id
 d9443c01a7336-2cf1f280732mr27567615ad.3.1784212938802; 
 Thu, 16 Jul 2026 07:42:18 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net
 ([2408:80e0:41fc:0:fe49::677]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf100e42a1sm20991165ad.15.2026.07.16.07.42.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Jul 2026 07:42:18 -0700 (PDT)
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
Subject: [PATCH V10 11/15] vfio-user/proxy: Update tracking iothread users
 with holder name
Date: Thu, 16 Jul 2026 22:40:36 +0800
Message-ID: <20260716144043.76414-12-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260716144043.76414-1-zhangckid@gmail.com>
References: <20260716144043.76414-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x636.google.com
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


