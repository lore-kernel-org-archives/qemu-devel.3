Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44ACCCD1296
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 12:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsM8v-0001CH-H2; Thu, 04 Apr 2024 08:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rsM8u-00014u-7V
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:24:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rsM8e-00012H-Mk
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712233455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7su9FVCHZgY5W4CseWaTDVux0tjQnk92YCDB/2U9JF8=;
 b=I5NYa+TIor2S59R0RoXA5frmlSzn3Y7kYnHw3pBviA+jby3X91BYULss68TNp8xIMUdS9i
 hNH1XJ9VUXSWfZAj8v982JOyZx54mRt2UkC5smovZcTThiQAch1SPMCNzYtw9vWNG+xA23
 iN99YJGO7b8ZtbZYoWv3L9zzYSc2Aj0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-Qg9tHhcZMcGdIYj5uPOJsg-1; Thu, 04 Apr 2024 08:24:14 -0400
X-MC-Unique: Qg9tHhcZMcGdIYj5uPOJsg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a4943e972d1so208270566b.0
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 05:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712233452; x=1712838252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7su9FVCHZgY5W4CseWaTDVux0tjQnk92YCDB/2U9JF8=;
 b=JAokMf+q30OD7egYVTpyp7AOXChhF+djVu/GV68kv29DLXqETub0z1UI171pOEz9VK
 miDVxb4kzUfUIeE41OyG4QTmluu8k6F2Oyh76H9rBobUnv9GeENV241xFpHUfacQFQli
 qguHepkSsH7LQipM+KA/dwAYqCat1gYNuF0nhS5jdrTdRBUJAbrRO65s/XuoilO5xdGw
 tyVgkqLWnuH8YCkQqfYXuVXH/8YHONcSDouqIS5I7jpWY3QWFbYDlOmY5jlSwXnJXe2h
 HMzCIF+NDxDiErVKTZd8EsGrJRSvkvTroiunEPtMVBBw8a7sEbC1740h/jwTK3O6LK4t
 MJZw==
X-Gm-Message-State: AOJu0YwcD1CGT/IMSFniSJ8Yx6zfKdS/jvMN+nyyu2ez5tzfA9+qZATg
 jScaHHqAIcnFEpHLkNkMt4lZI1lkXMdKUBGN9F/B6I46WFFlnN4JAdVzYL9ZWDwf1b7JXKIve7M
 +XhI2VK/XALZZrOoqCGen5AOoeZiQz2RAkP2j6v8A9f9GDdybzoaCGn+w/s8qLRBy25xYdJZOVm
 ut2K6c/Mmp3XFBFLu3EZNAcHIWxhklrXe9cWp0
X-Received: by 2002:a17:906:fa0f:b0:a51:8fd0:b1db with SMTP id
 lo15-20020a170906fa0f00b00a518fd0b1dbmr929372ejb.20.1712233452501; 
 Thu, 04 Apr 2024 05:24:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgeevPlWwYI/B4IQOsKCoWqeHZ7WSl59OfcMLqKKYcoDwzXismtyQqnjB7MvNqxHsyArhORQ==
X-Received: by 2002:a17:906:fa0f:b0:a51:8fd0:b1db with SMTP id
 lo15-20020a170906fa0f00b00a518fd0b1dbmr929335ejb.20.1712233452191; 
 Thu, 04 Apr 2024 05:24:12 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
 by smtp.gmail.com with ESMTPSA id
 ce8-20020a170906b24800b00a466c66804bsm8942382ejb.49.2024.04.04.05.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 05:24:11 -0700 (PDT)
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
Subject: [PATCH for-9.1 v3 07/11] libvhost-user: enable it on any POSIX system
Date: Thu,  4 Apr 2024 14:23:26 +0200
Message-ID: <20240404122330.92710-8-sgarzare@redhat.com>
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
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

The vhost-user protocol is not really Linux-specific so let's enable
libvhost-user for any POSIX system.

Compiling it on macOS and FreeBSD some problems came up:
- avoid to include linux/vhost.h which is avaibale only on Linux
  (vhost_types.h contains many of the things we need)
- macOS doesn't provide sys/endian.h, so let's define them
  (note: libvhost-user doesn't include qemu's headers, so we can't use
   use "qemu/bswap.h")
- define eventfd_[write|read] as write/read wrapper when system doesn't
  provide those (e.g. macOS)
- copy SEAL defines from include/qemu/memfd.h to make the code works
  on FreeBSD where MFD_ALLOW_SEALING is defined
- define MAP_NORESERVE if it's not defined (e.g. on FreeBSD)

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 meson.build                               |  2 +-
 subprojects/libvhost-user/libvhost-user.h |  2 +-
 subprojects/libvhost-user/libvhost-user.c | 60 +++++++++++++++++++++--
 3 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index c19d51501a..3197a2f62e 100644
--- a/meson.build
+++ b/meson.build
@@ -3194,7 +3194,7 @@ endif
 config_host_data.set('CONFIG_FDT', fdt.found())
 
 vhost_user = not_found
-if host_os == 'linux' and have_vhost_user
+if have_vhost_user
   libvhost_user = subproject('libvhost-user')
   vhost_user = libvhost_user.get_variable('vhost_user_dep')
 endif
diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
index deb40e77b3..e13e1d3931 100644
--- a/subprojects/libvhost-user/libvhost-user.h
+++ b/subprojects/libvhost-user/libvhost-user.h
@@ -18,9 +18,9 @@
 #include <stdbool.h>
 #include <stddef.h>
 #include <poll.h>
-#include <linux/vhost.h>
 #include <pthread.h>
 #include "standard-headers/linux/virtio_ring.h"
+#include "standard-headers/linux/vhost_types.h"
 
 /* Based on qemu/hw/virtio/vhost-user.c */
 #define VHOST_USER_F_PROTOCOL_FEATURES 30
diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 1c361ffd51..03edb4bf64 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -28,9 +28,7 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <sys/socket.h>
-#include <sys/eventfd.h>
 #include <sys/mman.h>
-#include <endian.h>
 
 /* Necessary to provide VIRTIO_F_VERSION_1 on system
  * with older linux headers. Must appear before
@@ -39,8 +37,8 @@
 #include "standard-headers/linux/virtio_config.h"
 
 #if defined(__linux__)
+#include <endian.h>
 #include <sys/syscall.h>
-#include <fcntl.h>
 #include <sys/ioctl.h>
 #include <linux/vhost.h>
 #include <sys/vfs.h>
@@ -52,6 +50,62 @@
 
 #endif
 
+#if defined(__APPLE__) && (__MACH__)
+#include <libkern/OSByteOrder.h>
+#define htobe16(x) OSSwapHostToBigInt16(x)
+#define htole16(x) OSSwapHostToLittleInt16(x)
+#define be16toh(x) OSSwapBigToHostInt16(x)
+#define le16toh(x) OSSwapLittleToHostInt16(x)
+
+#define htobe32(x) OSSwapHostToBigInt32(x)
+#define htole32(x) OSSwapHostToLittleInt32(x)
+#define be32toh(x) OSSwapBigToHostInt32(x)
+#define le32toh(x) OSSwapLittleToHostInt32(x)
+
+#define htobe64(x) OSSwapHostToBigInt64(x)
+#define htole64(x) OSSwapHostToLittleInt64(x)
+#define be64toh(x) OSSwapBigToHostInt64(x)
+#define le64toh(x) OSSwapLittleToHostInt64(x)
+#endif
+
+#ifdef CONFIG_EVENTFD
+#include <sys/eventfd.h>
+#else
+#define eventfd_t uint64_t
+
+int eventfd_write(int fd, eventfd_t value)
+{
+    return (write(fd, &value, sizeof(value)) == sizeof(value)) ? 0 : -1;
+}
+
+int eventfd_read(int fd, eventfd_t *value)
+{
+    return (read(fd, value, sizeof(*value)) == sizeof(*value)) ? 0 : -1;
+}
+#endif
+
+#ifdef MFD_ALLOW_SEALING
+#include <fcntl.h>
+
+#ifndef F_LINUX_SPECIFIC_BASE
+#define F_LINUX_SPECIFIC_BASE 1024
+#endif
+
+#ifndef F_ADD_SEALS
+#define F_ADD_SEALS (F_LINUX_SPECIFIC_BASE + 9)
+#define F_GET_SEALS (F_LINUX_SPECIFIC_BASE + 10)
+
+#define F_SEAL_SEAL     0x0001  /* prevent further seals from being set */
+#define F_SEAL_SHRINK   0x0002  /* prevent file from shrinking */
+#define F_SEAL_GROW     0x0004  /* prevent file from growing */
+#define F_SEAL_WRITE    0x0008  /* prevent writes */
+#endif
+#endif
+
+#ifndef MAP_NORESERVE
+#define MAP_NORESERVE 0
+#endif
+
 #include "include/atomic.h"
 
 #include "libvhost-user.h"
-- 
2.44.0


