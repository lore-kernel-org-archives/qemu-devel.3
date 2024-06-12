Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C5EC27C7B
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNde-000737-AG; Wed, 12 Jun 2024 09:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sHNdc-00072d-PB
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:03:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sHNda-0008H8-Sb
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718197418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GInn3FUattzKGx0ezQM5ug8ksWvzzKsxpJo2YJfBDjs=;
 b=O54Z620+v9HzkkNDBKbBc7enMPBsiPsxTM3SwhErRN6ExVBQF8Xrhzy3r1mMXrQr4+CYQj
 C7I98lMixnl1dAu+IZFoJJBmai7tapNzdM6C4oQcxc/wq71WkkZISaBwY5ysAe9/uEHXlw
 4LRNrxdda+qOjFRHJIbmdzyxplVNb1M=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-uxiaq-bGOXaSQsMDlCOR9g-1; Wed, 12 Jun 2024 09:03:36 -0400
X-MC-Unique: uxiaq-bGOXaSQsMDlCOR9g-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7955ab105d5so369312785a.3
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 06:03:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718197416; x=1718802216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GInn3FUattzKGx0ezQM5ug8ksWvzzKsxpJo2YJfBDjs=;
 b=vJ07ofrngXPeLYdTQspVAKmk0YsXYdGF1GkiEc47GisSUEehw5uqVaRJXqvQ4jQwik
 WWAVBOPlnmeNzgntViWjzF6BSJPczPQ59d6ALdYJzNSgM3Dwj/YhzjHqdH9nS62/jD5M
 +pS5WfLPBwY7M7zm6/vzH46v6z+tLTbHg+wIqMYnAy002fPoBIYIdUhGaqKS5ZTM0Bet
 FItbMGtFSiwb0/XE/FozKqJdCuADp9gYeFDsgIfjAVz8hj+K62T+WomP2xOv/O2oI1Rm
 ONvuTsMq/bUWun1g56awazZCtYrijvUmqqkZ9ArHNTxgWYmFMwfopUSCWf3WprAsL1no
 fvag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUD2qaz4zLPVhT3y7U8jkP/X4QW3G425mm++3SNQLYJi3BB3BhkTVtzs/PqwkbSOn5+VHHZ2v0WHOs+n3QDno9IQpXqEo0=
X-Gm-Message-State: AOJu0YyeoCA+9ge7wl+wWruS6eLY86677PcDZcYfKm8JC/nORnrnywD6
 VtK+l0ZtVVtNAaHsvFOR2DN0d9jyt9WFWxerNVbtnkByZwTbkPQmdptfSFghnr8J09IPvvGseiM
 o148lLx4YvF461mAaNioFtmW0I5MIIG2ik0MbHVykGT4eVXl37/2+
X-Received: by 2002:a05:620a:2684:b0:795:6016:bdb6 with SMTP id
 af79cd13be357-797f60367cfmr188863385a.46.1718197415973; 
 Wed, 12 Jun 2024 06:03:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfBZZdO8+Nlk5qDjFRrbiIc3gscoF9YHIeHjgrHsN4jO6aj0OHzOFGiQY2bLb9aGogfkUa3Q==
X-Received: by 2002:a05:620a:2684:b0:795:6016:bdb6 with SMTP id
 af79cd13be357-797f60367cfmr188851885a.46.1718197414859; 
 Wed, 12 Jun 2024 06:03:34 -0700 (PDT)
Received: from step1.redhat.com ([193.207.132.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7955b9b88acsm347034285a.1.2024.06.12.06.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 06:03:31 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, gmaglione@redhat.com,
 stefanha@redhat.com, Coiby Xu <Coiby.Xu@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com,
 Igor Mammedov <imammedo@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH RESEND v7 08/12] libvhost-user: enable it on any POSIX system
Date: Wed, 12 Jun 2024 15:01:36 +0200
Message-ID: <20240612130140.63004-9-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612130140.63004-1-sgarzare@redhat.com>
References: <20240612130140.63004-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
- avoid to include linux/vhost.h which is available only on Linux
  (vhost_types.h contains many of the things we need)
- macOS doesn't provide sys/endian.h, so let's define them
  (note: libvhost-user doesn't include QEMU's headers, so we can't use
   use "qemu/bswap.h")
- define eventfd_[write|read] as write/read wrapper when system doesn't
  provide those (e.g. macOS)
- copy SEAL defines from include/qemu/memfd.h to make the code works
  on FreeBSD where MFD_ALLOW_SEALING is defined
- define MAP_NORESERVE if it's not defined (e.g. on FreeBSD)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v5:
- fixed typos in the commit description [Phil]
---
 meson.build                               |  2 +-
 subprojects/libvhost-user/libvhost-user.h |  2 +-
 subprojects/libvhost-user/libvhost-user.c | 60 +++++++++++++++++++++--
 3 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/meson.build b/meson.build
index 239044070f..6413e858ea 100644
--- a/meson.build
+++ b/meson.build
@@ -3172,7 +3172,7 @@ if have_system and vfio_user_server_allowed
 endif
 
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
index 2c20cdc16e..57e58d4adb 100644
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
2.45.2


