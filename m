Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69E6CD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 12:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsM8r-0000xq-PY; Thu, 04 Apr 2024 08:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rsM8q-0000wF-4K
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:24:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rsM8j-00012s-HE
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712233461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hUBleTHPhrTzw3WOX5ng8C0tTB6CO+fZECbVOwKbaZ0=;
 b=DCbSSUC7Ntd1BMovhq9K1/iatDZjOYOc9lHtQfBz/0sJyyLkYpYLVjfNqvJQ6KZBajob1r
 4oRcqobDVj2n2NAQP30efwNsjSe9BJSEqU/irGYSM+i9NjbYlDE3+5J9wXmnyMrqrZ6Ow2
 YG+xrSUTZrlOArXqHXQ9x66DUzZ4Hk4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606--OpYbxlDPlGi4ytiV0y3_g-1; Thu, 04 Apr 2024 08:24:18 -0400
X-MC-Unique: -OpYbxlDPlGi4ytiV0y3_g-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a4e9636661eso63908266b.1
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 05:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712233457; x=1712838257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hUBleTHPhrTzw3WOX5ng8C0tTB6CO+fZECbVOwKbaZ0=;
 b=wYVL99VlpIy7OyVqfraCGH6cYAafyLMXSlumaAUkM/U6y6R6yTsgfk6CqttuqUKoai
 TZhCQfTX/8b6qFU7GxMLLWJEMMeQw38o2NeEGUer5/ttjDz+Vkj3DqfMRFBaOHGxsJf0
 otgYjb5gg8RxXwxdJEH9wxfvRQ9yg2F2vbbw09aSQ2Njzm09l4FULsZiXnEGdOuQoHq7
 7GFAGCM2V6CH4ULh21euAyXynCntGQMdKUZMGnIFUhyvT0cLnb100axBjW4F3IN7ZBha
 /uItFIUzdeuShqetazA82dwGnTFWzzwmEW008rVr8lK04XOX3Ygg7jeDOWv8lwU6F2tU
 nyJw==
X-Gm-Message-State: AOJu0YwO4ZM+4XeIEKsSsCo/7PZZ8ppOscEN/UGbAh7FaNFgQeFyLZ2K
 ZocF5kES9I2M4WzF7DMQ+N7lwa/7olXEjpQkereh9DBYKHEo4FSi+m+No5M1uto8FpGM2SKYAEs
 AcGQkebutc5iCvAZ1HZ7LO2KcYWu/hUJk4oXIFkehpLrPzW4nIfX7+TJkYS9P4dijubHGKl3fgg
 L46PV+pdyn2Mn5aXg+1eAGv8m1MsMQNd1Wflbc
X-Received: by 2002:a17:907:972a:b0:a4e:8ac4:3c3a with SMTP id
 jg42-20020a170907972a00b00a4e8ac43c3amr1703201ejc.48.1712233457236; 
 Thu, 04 Apr 2024 05:24:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGadvVDD/2KErjg6Wk90wALemTQ238F10UzxVetTsl3Onf2Z32+9RxoXuEzzx+cpJI0vRNYhw==
X-Received: by 2002:a17:907:972a:b0:a4e:8ac4:3c3a with SMTP id
 jg42-20020a170907972a00b00a4e8ac43c3amr1703165ejc.48.1712233456835; 
 Thu, 04 Apr 2024 05:24:16 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
 by smtp.gmail.com with ESMTPSA id
 ae12-20020a17090725cc00b00a4e238e46edsm8863356ejc.223.2024.04.04.05.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 05:24:15 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Coiby Xu <Coiby.Xu@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 slp@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, stefanha@redhat.com,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, gmaglione@redhat.com,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH for-9.1 v3 08/11] contrib/vhost-user-blk: enable it on any
 POSIX system
Date: Thu,  4 Apr 2024 14:23:27 +0200
Message-ID: <20240404122330.92710-9-sgarzare@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404122330.92710-1-sgarzare@redhat.com>
References: <20240404122330.92710-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Let's make the code more portable by using the "qemu/bswap.h" API
and adding defines from block/file-posix.c to support O_DIRECT in
other systems (e.g. macOS).

vhost-user-server.c is a dependency, let's enable it for any POSIX
system.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 meson.build                             |  2 --
 contrib/vhost-user-blk/vhost-user-blk.c | 19 +++++++++++++++++--
 util/meson.build                        |  4 +++-
 3 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index 3197a2f62e..b541e5c875 100644
--- a/meson.build
+++ b/meson.build
@@ -1956,8 +1956,6 @@ has_statx = cc.has_header_symbol('sys/stat.h', 'STATX_BASIC_STATS', prefix: gnu_
 has_statx_mnt_id = cc.has_header_symbol('sys/stat.h', 'STATX_MNT_ID', prefix: gnu_source_prefix)
 
 have_vhost_user_blk_server = get_option('vhost_user_blk_server') \
-  .require(host_os == 'linux',
-           error_message: 'vhost_user_blk_server requires linux') \
   .require(have_vhost_user,
            error_message: 'vhost_user_blk_server requires vhost-user support') \
   .disable_auto_if(not have_tools and not have_system) \
diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
index a8ab9269a2..462e584857 100644
--- a/contrib/vhost-user-blk/vhost-user-blk.c
+++ b/contrib/vhost-user-blk/vhost-user-blk.c
@@ -16,6 +16,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 #include "standard-headers/linux/virtio_blk.h"
 #include "libvhost-user-glib.h"
 
@@ -24,6 +25,20 @@
 #include <sys/ioctl.h>
 #endif
 
+/* OS X does not have O_DSYNC */
+#ifndef O_DSYNC
+#ifdef O_SYNC
+#define O_DSYNC O_SYNC
+#elif defined(O_FSYNC)
+#define O_DSYNC O_FSYNC
+#endif
+#endif
+
+/* Approximate O_DIRECT with O_DSYNC if O_DIRECT isn't available */
+#ifndef O_DIRECT
+#define O_DIRECT O_DSYNC
+#endif
+
 enum {
     VHOST_USER_BLK_MAX_QUEUES = 8,
 };
@@ -267,13 +282,13 @@ static int vub_virtio_process_req(VubDev *vdev_blk,
     req->in = (struct virtio_blk_inhdr *)elem->in_sg[in_num - 1].iov_base;
     in_num--;
 
-    type = le32toh(req->out->type);
+    type = le32_to_cpu(req->out->type);
     switch (type & ~VIRTIO_BLK_T_BARRIER) {
     case VIRTIO_BLK_T_IN:
     case VIRTIO_BLK_T_OUT: {
         ssize_t ret = 0;
         bool is_write = type & VIRTIO_BLK_T_OUT;
-        req->sector_num = le64toh(req->out->sector);
+        req->sector_num = le64_to_cpu(req->out->sector);
         if (is_write) {
             ret  = vub_writev(req, &elem->out_sg[1], out_num);
         } else {
diff --git a/util/meson.build b/util/meson.build
index 0ef9886be0..f52682ce96 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -113,10 +113,12 @@ if have_block
     util_ss.add(files('filemonitor-stub.c'))
   endif
   if host_os == 'linux'
-    util_ss.add(files('vhost-user-server.c'), vhost_user)
     util_ss.add(files('vfio-helpers.c'))
     util_ss.add(files('chardev_open.c'))
   endif
+  if host_os != 'windows'
+    util_ss.add(files('vhost-user-server.c'), vhost_user)
+  endif
 endif
 
 if cpu == 'aarch64'
-- 
2.44.0


