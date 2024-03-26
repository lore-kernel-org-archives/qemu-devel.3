Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1ADC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp72W-0008Bp-P7; Tue, 26 Mar 2024 09:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rp72Q-0007qE-RE
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:40:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rp72O-0005CP-Gm
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711460423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hUBleTHPhrTzw3WOX5ng8C0tTB6CO+fZECbVOwKbaZ0=;
 b=VaOV40AOh0pZ9wTldhwKRjm6FlZbi0/FgDNGzxQGz3H8B1wnPMHJMdAQ+l/yaf+WOB7Mq2
 /rDkORyiyJZ6/HYEGmzdpwmUlTJLitj7emBdJRZAq/g91vVTz0Dx+pamg9RPXvMEY0rhC+
 sXZNjmAoL4rq5QbsPTcq0NSV4Ypi7Gw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-1Aldew32OyiTOx_q3Zm5zw-1; Tue, 26 Mar 2024 09:40:22 -0400
X-MC-Unique: 1Aldew32OyiTOx_q3Zm5zw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4147faf154cso15296575e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 06:40:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711460420; x=1712065220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hUBleTHPhrTzw3WOX5ng8C0tTB6CO+fZECbVOwKbaZ0=;
 b=t3UtzpgjTQKgXEhuq4BN1IOd2B4apLVB1aYXYkmFflb5B44BFcT+cgD253qNkLV2vL
 vcwsfvnZUmX9pvxJpIlQ94hAdsibeF5K+nEPT9gvLGhayrThQFkdAxiT/Ti2LBY5k5vW
 WJiNixoMlyQ7rG7+2psus7TKIhybXfzj4fPhUdCHnVVWrUCXvvxjYtNxbdr8qZwf5C3W
 0EVkg4LPJvxhMSEdxr3nAMM8gASOOhWK+fT0ebKGEea3YOEWMHGxtbTJsVv5QlYtaNBe
 AA2WC6b/AE8Nydo0xg0rMoSuO1oXm7LhG6LZzi6E/bKWe7FJ8MezDECqGx9Bhj2CHLfj
 Qf0g==
X-Gm-Message-State: AOJu0Yzkaaqe+fGxK40ivhZsJaxlIfFFuzK2Iuf7gxXZsBFPfGpQT7LO
 mZueP3fH8Y24lweeOg08ixk3ldDOvlGNyw/2H3hh1N/T3Rlvm8D511M72Vdt6l7Zi7eqaH7s3XP
 uKFZ2AuPCDGFOvjqOU4LTXu8xVQFO08EiqUWp9iYUDswy0j31qC03Y/NxYRM1H5o/p3QQor2uXc
 RE3Z7FOe+M/pQPEpI4lGc77FdW3Jmv8s5pzDWm
X-Received: by 2002:a05:600c:20d4:b0:413:f75f:98b6 with SMTP id
 y20-20020a05600c20d400b00413f75f98b6mr8041019wmm.26.1711460420417; 
 Tue, 26 Mar 2024 06:40:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENBCYEnyolENDPrD0XLGY8+imkwQqrI2doLTdNAeye59lPXhPiOafM2isJnWFNkIdtw2KQMA==
X-Received: by 2002:a05:600c:20d4:b0:413:f75f:98b6 with SMTP id
 y20-20020a05600c20d400b00413f75f98b6mr8040976wmm.26.1711460420068; 
 Tue, 26 Mar 2024 06:40:20 -0700 (PDT)
Received: from step1.redhat.com (host-87-12-25-33.business.telecomitalia.it.
 [87.12.25.33]) by smtp.gmail.com with ESMTPSA id
 n31-20020a05600c501f00b004148bfe1b37sm4125385wmr.23.2024.03.26.06.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 06:40:19 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, gmaglione@redhat.com,
 Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Hanna Reitz <hreitz@redhat.com>, stefanha@redhat.com,
 Coiby Xu <Coiby.Xu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, slp@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Brad Smith <brad@comstyle.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH for-9.1 v2 08/11] contrib/vhost-user-blk: enable it on any
 POSIX system
Date: Tue, 26 Mar 2024 14:39:33 +0100
Message-ID: <20240326133936.125332-9-sgarzare@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326133936.125332-1-sgarzare@redhat.com>
References: <20240326133936.125332-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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


