Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8DBC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIR1-0004wb-Ih; Wed, 28 Feb 2024 06:49:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfIQz-0004m3-AX
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:49:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfIQx-00040K-IV
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709120950;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TLg7okLmDrwykRkhT6hlbl5ORhkxyjg/0KKKGfeq0JU=;
 b=ffSFARpZbUmm7Zja4e6+ajEzaFhDvU85f3scPhRgUc6kOkLSUF9i5re1qF7ctpAHUhPf3o
 7IoglWlDitrHD60mNkbaD03pjJ/kUWZwcVgIMZbYjytscyTjO16Dlw+Ze2gbjcqfB6mzYx
 8Knbt3z4q8Ev+A9cvH0u413pyZ/l3Ls=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-8ApzNfZYP3GFiRwONsmYnA-1; Wed, 28 Feb 2024 06:49:09 -0500
X-MC-Unique: 8ApzNfZYP3GFiRwONsmYnA-1
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-3c02a63d499so9377492b6e.3
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:49:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709120945; x=1709725745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TLg7okLmDrwykRkhT6hlbl5ORhkxyjg/0KKKGfeq0JU=;
 b=RrIBSxgl7OjuuQJXXh2neCNxGo1DEAFLAztXo3pjCku3u4Pg5Ltbs9Z4gh9+ZNDeSQ
 yMclz/1sXgxjmsxwgJu7dkSolr3DVAmo0VaiesD1HbLceaBYqRZJZaFJw370Xy3yVahz
 FwVGVE9skoozWH3o3R8h06b99waAvclFwaLsbC5n5jY34B9OiKqJAP1B3CM/B5GDS2oy
 YwbO3dlLs/oHAKHtsIE6lYJWcwfoQSu2uTeVKlI0fQRBkANhlIZINSpthY6BxqR4Jl2K
 zJAa89Aibl+xyxDO3yKca8SFr5Wwvd5ubPIkTzYZXKndgjYAnbid0qIB73MCc3aa/gwF
 v/Ng==
X-Gm-Message-State: AOJu0YwUu06y/nYp4azftHbayThK6NGmCxzkJUrasjd19jp8GLtEvBPG
 IPHMj+Zlo85FW4AHmpbo+DTuFuiPPxXb/uHsNolXBH/cDxczCDgImzuDAYjM18OxWClI5aByaij
 qhD2rN5eq/92H5EA+gTYAfy4frUCG108aYkuEluL7cqle4oTERSCHcicLAHXf3oaS/JRw1j6orc
 x3HJ6fOIwFNPfHbeTg2uHyCHrcmPH2W+4fjAGV
X-Received: by 2002:a05:6358:541a:b0:178:e2b3:98da with SMTP id
 u26-20020a056358541a00b00178e2b398damr16355713rwe.28.1709120944865; 
 Wed, 28 Feb 2024 03:49:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHKAfcJVb6B10yOsJ+Uj2GvaLy5ffB1SRAVsgtZby8PB8+cwyPAzX+9O/DuB/UIwJE+05mlA==
X-Received: by 2002:a05:6358:541a:b0:178:e2b3:98da with SMTP id
 u26-20020a056358541a00b00178e2b398damr16355684rwe.28.1709120944532; 
 Wed, 28 Feb 2024 03:49:04 -0800 (PST)
Received: from step1.redhat.com (host-82-57-51-64.retail.telecomitalia.it.
 [82.57.51.64]) by smtp.gmail.com with ESMTPSA id
 pd5-20020a056214490500b0068f9592f381sm5184581qvb.10.2024.02.28.03.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 03:49:03 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, slp@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>,
 David Hildenbrand <david@redhat.com>, stefanha@redhat.com,
 gmaglione@redhat.com, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 8/9] contrib/vhost-user-blk: enabled it on any POSIX system
Date: Wed, 28 Feb 2024 12:47:58 +0100
Message-ID: <20240228114759.44758-9-sgarzare@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228114759.44758-1-sgarzare@redhat.com>
References: <20240228114759.44758-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index af15178969..8afda86d3d 100644
--- a/meson.build
+++ b/meson.build
@@ -1954,8 +1954,6 @@ has_statx = cc.has_header_symbol('sys/stat.h', 'STATX_BASIC_STATS', prefix: gnu_
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
2.43.2


