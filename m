Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AE0C79F89
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 06:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Szs-0005yI-36; Mon, 07 Sep 2026 02:38:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x3Szr-0005y2-8l
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 02:38:27 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1x3Szp-00069w-J6
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 02:38:26 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2d9520b9155so27595665ad.3
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2026 23:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788763104; x=1789367904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zNkftpkxFVpDoZUxzARQ6dpOC1MsUJSxg+vsslS00BI=;
 b=kBdAbJr3gygehGa+LkqYjU8LNjsoReEHIr5HW4kQrVVoCRze4xF3TV7uib+v/TuCGw
 Ph0WdCf91B6SRkG+fzEoAAdIu498C1dgBrINMsTmWj4ARcT6/iodnxxTfVfpzk3dX3x2
 Z9zbvVEjmuhNWuMiFyKkMA77NH4+B6Mc2KJdrQrK3xy752Xav4JlBib90XzgxQq4FC15
 enRpXH0WJb2Fp26zUWNnMRpbaGc0/6EiYsscRHo8NkEXvg/9DuBCkagVgq51ogWeMcaE
 tJ9IGn4AJEydHCr1PC0E/IB98SLm94YEQkcUZjra4MiJBLP+aMuhtNUaCOe5oH8V6xpk
 ruEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788763104; x=1789367904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zNkftpkxFVpDoZUxzARQ6dpOC1MsUJSxg+vsslS00BI=;
 b=rkgu5isVyCeDLbcZPbV8hR2LtXlcOEK9zpO3fpfIwui6jnolF+vhzeVYhJpPczablR
 Kh83+quQ5lWt69/5QnaeRvGVdna1P32vO63e35oitVmlQGxWf8k/Gv8cS/WUn0BqplQX
 6TcUj93bJX8INjR+sDHlObjQzWdANub3t3qndyCS/ERluQwxFUE0nfwOrXf+eD17KxoR
 CJyXPf5OJIIrLQeWghbWrsWjKOlh4C8C3N9vYUp8TwykbY6LufXexQcDMcmIfa8cbg3R
 oTPhZfd3oesjG25gwJf86eeBHyjsLJJK0fyAKOE9jPUEzj+aJhcJqY9lEalsRdQngP8D
 Jaqw==
X-Gm-Message-State: AFuF++n6F2mTurWkQ7QSyUT8nbfN8bHIGZx/WWnXS5gubci42loJqbWq
 kjELXWGjH+aRW0uOH4nLP+hfS0cevdQqOXpBMt3rzN33Hsl9xv54/LO7EC/CXObtOUvq5w==
X-Gm-Gg: AYBFou3r0zpWi2kgPgQEchAYkH5RWK4AlS3NM/lAtjMRr0Qe43v34KWNwE2xhsB9iW6
 i2Dz6RVu6Zgf+Xg0QxNo2HVWCeb1+2Q+iapVjMyOb9tI+SJOKqxSOe1YIaG4EC11hf85V8u+DbW
 3OwReUyaZgnCeiroS4lLFh4oCwiEtPU19OM1ZKks8KOg+Rzrvtoxfnhyfp5WN2n2IClLvbs+8XP
 6RMQCiBQLW9BQQJp1V6SG4Iosd4s/WgShKa5FSeuNokEaq5jb3w5nmk+2USJZ6tDW3IERxaGxkA
 KK6/zrUYYlofGpZNz+7ppEhg323gI7iy0qjjzF6euIFPdGxPcuuQwnlkukVzk8rfYTyeHkjbN1H
 Iy+dh9G9DRY5NHoy/IJWdQXkk377AGve4Vji3TUC67fw4U8RcWuZSfBpNOrlT4dHyK/Sxo7bNPF
 T/1HJte00voTLNW90OEG2dFj7sGnAYolc54VC4p1y1AbsKSmrQAbG2IBT1eIUnylzZG96tIs5kr
 UT3da9bE2Ylh+83
X-Received: by 2002:a17:903:3803:b0:2d7:7cb:a44a with SMTP id
 d9443c01a7336-2db127bf3damr337859395ad.11.1788763104149; 
 Sun, 06 Sep 2026 23:38:24 -0700 (PDT)
Received: from hades-NUC8i7HVK.taila0cd24.ts.net ([222.72.128.122])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db1499f06fsm38502555ad.54.2026.09.06.23.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 23:38:23 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?=27Daniel=20P=20=2E=20Berrang=C3=A9=27?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V15 10/14] vfio-user/proxy: Update tracking iothread users
 with holder name
Date: Mon,  7 Sep 2026 14:37:21 +0800
Message-ID: <20260907063725.626685-11-zhangckid@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907063725.626685-1-zhangckid@gmail.com>
References: <20260907063725.626685-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x629.google.com
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
2.43.0


