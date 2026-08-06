Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92081C5AC67
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 20:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws4gi-0004W4-H9; Thu, 06 Aug 2026 16:27:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ws4gP-0004HQ-90
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:27:17 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1ws4gH-00052w-PP
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:27:12 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-38125cebfdaso3272218a91.1
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 13:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786048028; x=1786652828; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EPzzHTwezjyg9C2LHZLrU5axZC+fE/LKwUjgro3vN0o=;
 b=EnXoblr/2PkeYldxWF9GhLt3jXZJ0KjeHH+BJF/rJdUrggehHCvOfGnY1Bva0DhHYy
 77Lfh7dk90tmyin65Y6IxhdW5S+48HiEEeTaFV60ycKWizl9gBcyEBEEGT22fVFJ31jm
 lH0HR9mT5XdxMpEVmv+RjhVlPxEf5IDexExxSEXxd36QRkeHHL7nPhtIq1mMFB36YJYk
 asRna/NRjQPeTNUbLXgPYXZVsoJ8DhZpsmSYIHbwGc9+f/DUttl/Jdi5az50OppGfpBP
 ruJWJw61foaIGBcCAY5wE5CZ7Phz9Lx7wX5Fs2howbddgBZIVN1dKl6ROOau/TN7Lq0x
 xzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786048028; x=1786652828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EPzzHTwezjyg9C2LHZLrU5axZC+fE/LKwUjgro3vN0o=;
 b=lGAeZzhPe/aG47Gx3QOj7g/wTwjd1Qk43rM6zHfZPTnVQAkWPe4PjQVHLqaDP1g9kF
 Ofu2Rr5wr9a+jWouxzfw+iLQVA6WKPGmxgUm+20T1WyxqfZPUz8HnTMp/G3MGcCfnWuG
 JaOFaRDoGMTVX0dsAu2dcKwVOhJecwktXkUeXXXtjGsxbnOTfx4iLxA8lebXWIT0Xle5
 RT8H/eQ3afVE2u58xCVurk18vRftEJCXa9O/8XrL6wZR5nCUVm80KFcEGD+fa6OvrwuX
 /CKiD+/++n2j47PtUK41QpaNKr3sk4kVKewv4VyVy+/Ge8pxMbKuHMGJcSm+cF+Ee30b
 o6UQ==
X-Gm-Message-State: AOJu0YzPXFHt8sO9dV1CQZv67sr0p3J3RsYhjsgOY1gPz07pgBivtk3Y
 yNbEbm0VOw4yFzQv/qO8SeUBK9tOdWM6n7v64hCTMsCG0bvoYA6TJ492LNPBv7xGg0hJs/Qr
X-Gm-Gg: AR+sD11b1RBRoc9mMA4J0ztgX3F1L24UIWhiMpnwDYZ0LoR72JBIIwce5LBOvHDjGZX
 UHWf8791Iu8ihh5O/ibS3iRcr97qHY93BvJ5P6omappoxoTmiHhUXC8gQC1P34YgjhUjmaej5jd
 ZDqgyMjljbUAtjh6fuvhUyR6c3F4oBP65Ee0BI+et0+5NU3hUk0+4QbOOlcu2i/fyTyEQcEqIyN
 DXPK0vBnnAPwpLk1JkOklao6LMEQpMMJXmEQJNVgyTVQ7wrIzSFsexIBuZTthTsZhKvIVERYK4P
 BpjX29RI05HuTTAyyF7BLeYLUgrHGJw2gIuEMlEjDso4rZqfK7qEOTQiqzL1BnbNMW/nRVyHCco
 cD1sB+x//AAQGcLJ8wARYl0mmWCRKSjtvwuaMBzAee1TYytyO6AHmSNDXV+Nuu38QvZRLXtN9xX
 WgK5uwf9e5V2Jyfgy0jYKzYcPTwrGG7c04DyoJWEXuUpCJP7ERl2iqfp9dnx50eMa9BKHZDYZ9g
 0ON7XjhufJlJMnp
X-Received: by 2002:a17:90b:5111:b0:38e:64b0:8bce with SMTP id
 98e67ed59e1d1-3903c633720mr19454281a91.20.1786048027596; 
 Thu, 06 Aug 2026 13:27:07 -0700 (PDT)
Received: from t-kidd-X299-AORUS-Gaming-3-Pro.lan ([104.28.201.73])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863fd2b3sm33140471eec.7.2026.08.06.13.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 13:27:07 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V11 11/15] vfio-user/proxy: Update tracking iothread users
 with holder name
Date: Fri,  7 Aug 2026 04:25:20 +0800
Message-ID: <20260806202531.243806-12-zhangckid@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806202531.243806-1-zhangckid@gmail.com>
References: <20260806202531.243806-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=zhangckid@gmail.com; helo=mail-pj1-x102d.google.com
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
index 197aee07bf..5ef1547357 100644
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
2.53.0


