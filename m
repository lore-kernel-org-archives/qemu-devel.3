Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC209C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 10:05:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJViJ-0004EZ-0K; Tue, 18 Jun 2024 06:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJViE-0003wp-D3
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:05:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJViC-0001QT-FV
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718705111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jgaOjflpOpBuAI2lV6r/qh89MXpXI4bCCUZiaqoxz58=;
 b=KOksklpPeDcKnEa7/TTkCLB2dumvALy4ivr8JgzoV6zyiROBC9gC681V2u5FVCxejfyw7f
 PvGjlmmHWLm5fJ/ObOEeQVCjZ3ftyj6d9nzasmarRW8dNl3lhWIGR1htP6Togn1Pdj4/Uh
 yJUe+v8bs4MjRYRliS499Kq4jycX5rA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-rh1jE8RIPXin7h6W1e74OQ-1; Tue, 18 Jun 2024 06:05:10 -0400
X-MC-Unique: rh1jE8RIPXin7h6W1e74OQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-421eed70e30so39490625e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 03:05:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718705109; x=1719309909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jgaOjflpOpBuAI2lV6r/qh89MXpXI4bCCUZiaqoxz58=;
 b=OlI99KiEiVG3QaiL97rVlfLQFObnvPtIhdhq/604RpuWxsrzt/3Myu0tMM/O+Dow7Z
 4mZEv24544OclJgHxqwlWa0V9kQrvvhkqvY2wO4t6uyNZkdePMrDR6imk1ScG6Ze8gnP
 02APl8MZNksGl5QTxgTu7tSyJykeUVwJw7oZcze3L2P7WTPZI5uXp0cL9nv/Y/GQEOOW
 Y0ke6/PHt9ovcSYRrT1q2L0acP4Y7c+dmXr/3nFo50qxhrFTA9MVZfXH4FqNpeeNz7Eo
 mEmJQ0dIxcAvE+SDqO8ggcKN83FWQ2cBKDZFkiam4YleqpOdZzZfKdCK96vVxg2TIcE8
 /gIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv3RGVQAmGFtXk9obsvpBQNvfHVeaWO+P5ieJH9z3gM914fZoym2466K3dJFeR3waOd3BoXUqtr3D16nEdGXtJs6s96Rk=
X-Gm-Message-State: AOJu0Yx/RiTp5skVoy+8y4F1xpWZjb+kPggPmH0OADSM05Go2IVakhzm
 ApPMxma1+JWE4XgnHgmQR2/8JHiJp57kbsA3mhwmQTHAErkHolZ7hyKL7iyv5yAXr9DkmrzkrDO
 rDjJkZwslRTM01eHm+5mRoxipRkThUZC8mMiFBMNOPW2F5KD13e53
X-Received: by 2002:a05:600c:4444:b0:421:2df2:2850 with SMTP id
 5b1f17b1804b1-4230484d098mr102880805e9.31.1718705109201; 
 Tue, 18 Jun 2024 03:05:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKPfNRwSQ07kyXWR6CCxKPHeLXT8NdJ9G5M7igfFGflsxfDywbpaHKsTRhpIyf3bl0HEaWUw==
X-Received: by 2002:a05:600c:4444:b0:421:2df2:2850 with SMTP id
 5b1f17b1804b1-4230484d098mr102880585e9.31.1718705108860; 
 Tue, 18 Jun 2024 03:05:08 -0700 (PDT)
Received: from step1.redhat.com ([193.207.160.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f6320c2csm183925985e9.36.2024.06.18.03.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 03:05:06 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Brad Smith <brad@comstyle.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Laurent Vivier <lvivier@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, slp@redhat.com, gmaglione@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, stefanha@redhat.com,
 Raphael Norwitz <raphael@enfabrica.net>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v8 09/13] libvhost-user: enable it on any POSIX system
Date: Tue, 18 Jun 2024 12:05:03 +0200
Message-ID: <20240618100503.145768-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618100043.144657-1-sgarzare@redhat.com>
References: <20240618100043.144657-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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
index 2ba95a8c35..487153a431 100644
--- a/meson.build
+++ b/meson.build
@@ -3190,7 +3190,7 @@ if have_system and vfio_user_server_allowed
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


