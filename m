Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B464C5DF97
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2026 21:35:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxtMZ-0003xp-UC; Sat, 22 Aug 2026 17:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtMV-0003rn-8A
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:34:47 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wxtMS-0000lA-Uo
 for qemu-devel@nongnu.org; Sat, 22 Aug 2026 17:34:46 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2cc61541f8cso34952435ad.0
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2026 14:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787434483; x=1788039283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qiABzT9brkBXTSb3Fx2nSHH2TcbG/h2o76wYEP9lGD4=;
 b=qmw6cKPnIGV+wAOirKt0Dw69EYq1I+tk0cyYPw/svYQcsiPukh2T91GnyVvu8+uwr+
 muBMXTxCT87wPVKueK3SlQJ6uA6rVgGYUNYLb3EcPU6qRThA9fpxdI/IW9N4Hp6LfJsG
 9VIOxErvX9W6z61IixZrrFDVsm56XYqiMT7gQyoB/IQOKecV+5L6ELM0Gq7cq72bU0du
 vPQGmKuO2mYy4lc/lTpuH6jJuZARXiLUJiGKzgh6JZkXumbbpr2rMrarJVf3UA4iV4Zt
 pDzYtJ5KJsPK/1cuf1opLdRX1Q0IGxXPbn6oslPxElY/ZNmkNnF/rL+vD26b6gaG/Otc
 v7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787434483; x=1788039283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qiABzT9brkBXTSb3Fx2nSHH2TcbG/h2o76wYEP9lGD4=;
 b=LNUUfXziXYGXiPBSBVh9gTWUye3dASPcPxV6+EsxPO1dyssK2pyXPcG06xlUJ3JdnR
 rK0Fqnlt5DTkkVt2Mmbj7+Pmo4ev+ARbpO35cY4bV8YOSXZyTzFwUD8eYFH6as1Oe6Ij
 O9waTA0F89/KHGKQwwvv5v5xVFCt98b4zrFYs54GYg77jDLmWYnvvmSlhJM0TcN2czw3
 FM9vXsmCdp83lw6SPMV+fk7o4zkcK0Bhi3I0/yuVyLnLqUxEKPdFQFhPSxvYka5HP3AG
 LcUkyKMV/jsmb7YiBKokjpT4Rb7MSIl0V0ERJSD5VtrIei1JUMdixYZTxBCpdSQTHSoV
 3IBQ==
X-Gm-Message-State: AFuF++lqnoGcyEdtlCNiy+q2xMkaflvnFqYDjSgVaJn+Sf1TjXvqb6oB
 VjAka35O2Biqp85iWVvGnYtobodhcOKjYhTIhPxpwamz/OkO4ASVv/YBUmH3wwLk7bo1DrSt
X-Gm-Gg: AR+sD132jGf6bETGCBJSvKb89+3YD09VrGSKpL+m+CUr4ryKcP2moAHFqLFC1jQ90Mm
 G/V4Dqm3i6zhIS12skV0miM6U8qnHdYD9M4C9N6RBfoJEh1UBOvDBC77XXC+RY3MO6T6guMLqvU
 sJNoZsEDtyJj8Qv94TJ0nLaZNLSjwChIpO7WVvk2rtPpaDR+TeoFuEdWhuHpNZH78zzRd1FLMHV
 PqtbRi0GdkWA55QdqvzmzIcOd6JvEnauAFISHlL5b7sYbI137tZsJOO8KSXoEasWomgtatGLw0f
 inSnTniO+N1uggaJLOzPsplccBl3rk0U70YdDVUzOix355voWFYlYD9+cebfD6jX4vw9XLOCaRi
 fJYP/+pVyfLPAQ/+7MpSGP9cjlLpmpgTJyOmf+rLdggNOpvaIeAzqYut1OVgXMtC7qmglLr9gk+
 OwT+BaxbqSnRcvvnlvs8An8/bqnHLE7m2CKD1X4R8u/5rvlCxviIz4H9Thc1nX8UE+e1FJazc+v
 x1Ih/ei
X-Received: by 2002:a17:902:ef47:b0:2d0:401c:2edc with SMTP id
 d9443c01a7336-2d61a032207mr289465385ad.1.1787434483380; 
 Sat, 22 Aug 2026 14:34:43 -0700 (PDT)
Received: from catgo-fnos.taila0cd24.ts.net ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f909c6c9sm11633181eec.6.2026.08.22.14.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 14:34:42 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V13 11/15] vfio-user/proxy: Update tracking iothread users
 with holder name
Date: Sun, 23 Aug 2026 05:33:34 +0800
Message-ID: <20260822213343.661939-12-zhangckid@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822213343.661939-1-zhangckid@gmail.com>
References: <20260822213343.661939-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x634.google.com
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

Add object_ref/unref calls with
iothread_ref_and_get/unref_and_put_aio_context.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/vfio-user/proxy.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 197aee07bf..e642fb0ad3 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -898,6 +898,7 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     QIOChannelSocket *sioc;
     QIOChannel *ioc;
     char *sockname;
+    g_autofree char *path = NULL;
 
     if (addr->type != SOCKET_ADDRESS_TYPE_UNIX) {
         error_setg(errp, "vfio_user_connect - bad address family");
@@ -917,6 +918,11 @@ VFIOUserProxy *vfio_user_connect_dev(SocketAddress *addr, Error **errp)
     proxy = g_malloc0(sizeof(VFIOUserProxy));
     proxy->sockname = g_strdup_printf("unix:%s", sockname);
     proxy->ioc = ioc;
+    path = object_get_canonical_path(OBJECT(proxy->ioc));
+    const IOThreadHolder io_holder = {
+        .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+        .u.qom_object.qom_path = path,
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
+    const IOThreadHolder io_holder = {
+        .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
+        .u.qom_object.qom_path = path,
+    };
 
     qemu_mutex_lock(&proxy->lock);
 
@@ -1021,6 +1033,8 @@ void vfio_user_disconnect(VFIOUserProxy *proxy)
     qemu_cond_destroy(&proxy->close_cv);
     qemu_mutex_destroy(&proxy->lock);
 
+    iothread_unref_and_put_aio_context(vfio_user_iothread, &io_holder);
+
     QLIST_REMOVE(proxy, next);
     if (QLIST_EMPTY(&vfio_user_sockets)) {
         iothread_destroy(vfio_user_iothread);
-- 
2.55.0


