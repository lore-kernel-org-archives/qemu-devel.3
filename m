Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BE6606A322
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Zic7U7Je
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJt9x-0001eh-B4; Thu, 22 Oct 2026 09:48:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xJt9W-0000Uo-Il
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:48:20 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xJt9R-000585-Cp
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:48:16 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48e0d885929so1458301f8f.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 06:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792676890; x=1793281690; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=x+vatmk2dmI/yp1zURhstHKX4MTHvDuE/7/Wa73Bcu0=;
 b=Zic7U7JeUOJ+OpG7XIyZXh2a2ppznVFme5wLEATyXfUOxU76thipg0DhwRwXSNZ6Fv
 DzdD8QKqB6wNxwKzADG217DUEPRMGcWjldvuMH4WjVwec0S+9niwpnYEnSlaODiReCAd
 tcS32fXbNoRPUnQb/34Zl87MovS5gtT1EHfMR6EPeJLHC7HYcQOSvnDii4sTaWmbzSLQ
 xk14CrKeLxIX2n9NMmXNBbiOlDl6fRuTtqvGgfaaMKL87DXIZ2+db6VUU5nwoVIlV0Y6
 rA5ozUnNBgku36V81BGd92x5ZUdK6pu+OvA3pFHd5uZW1phN1HUia8vgFKgtSIh4k7uN
 VZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792676890; x=1793281690;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x+vatmk2dmI/yp1zURhstHKX4MTHvDuE/7/Wa73Bcu0=;
 b=vuiBfb2vR4yMuTjOpqxcLNUfcnNTAU8kZz51/w24D6OvtCISLmttWt7VNc5+6KdLfw
 68Dr1HgSvS+/9FDrzP1Z/bNx96WOCpQCD91Mg5YFXLBmam76CBetNnr45pNYJk/9H2G9
 /QwX6TQBaSHmlV36C4ZTbUeyM8Cc0xQB4lRrzViqZ3dZpDgkhG3PE1D/GF1aupZrJWPC
 Wh5we4SPMfQltyoGxLaVU8ON1/z+/hKTWzgYh8lEU1d0PoRFlcvPoOXLUzT4IQXlUshK
 4XJg//nRAhoeeDd97RaCouXII0pyhRL5GLo8S5pOmERxZO/kHrZiWRLEnQb680bX6oBF
 gLNA==
X-Gm-Message-State: AFq9FYLGXBdhCJwWqFaY7NwEdOYrRdrRWutO0JCtcLlbfibk3qNIOltB
 OJ3JxqNvAi0gvttosCkQpNTR3zKxgC7ImN4/VWCtg3KERB5mGUvmz4wA25j4DMku
X-Gm-Gg: AYBFou1XV8WO2xoAZxKnfFObgvyhgLI0FwEktrDXEZiFZ3Yp+HyKLb9F9VMkcWOXQBn
 Nj8YNLtBr4KsqyJ/I8q+ttknaHyGu+5c+0GKL8TjU+xGziBNcnl9TqD+QQR+0+QUZP54PzJAaAE
 xwDeBXFvVhNmTjoktUJy18t+tL3S9rfTixXE6uS5eUjYfbULxYLXiUgDQHeHSIldJ7+2+9C8fz6
 peHodsVpmy6eRjrPbbt2qihNq9qEwqanbKDIeVtAfm55iHpm+gy3ZvS9yWY5zhZx0d6Pq58EV3k
 8CGOeagaLdVohhykw9chLP4B+ENlkShdcOn5FCtEWkXDStgiJJdJ1zXx9YCDpZThcL7fxZiWVJP
 2HK/+KHEAZUH4YvTAqCi1ULinx1v4sPGL9FIsUSvIG4KOS8KNh0ETQJibQ/+iP+4PSrcwapRrwm
 KbaTY0b0UEv53SMrnfEG8KU4YBrr7Z2f/tNnK+kKRTl1lIJ+qydptJuOm5tMVwdJmBHtnSkFn/w
 VNupAatr0YoIwqdREiXLzCqxSm+00eZLUeRKlLO7lz7QLjWD+9PZzvsbbw+nEWVvbnulrYLzA4v
 5t7ZifmHtylmksl7X7GdwEnpTJc257fYPkYdLGdkPQSTz6tb4QV9ydF5mVkqI2UphmrZoRaEw8F
 5+v+1nqfwuA==
X-Received: by 2002:a05:6000:98a:b0:48d:f014:63ee with SMTP id
 ffacd0b85a97d-48e264a1d2dmr9864123f8f.20.1792676888346; 
 Thu, 22 Oct 2026 06:48:08 -0700 (PDT)
Received: from tim-m2.local
 (dynamic-2a02-3100-5a78-7100-00df-217a-667a-8b0a.310.pool.telefonica.de.
 [2a02:3100:5a78:7100:df:217a:667a:8b0a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254ef1bfsm13120414f8f.6.2026.10.22.06.48.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 06:48:07 -0700 (PDT)
From: Tim Pambor <timpambor@gmail.com>
Date: Thu, 22 Oct 2026 15:47:27 +0200
Subject: [PATCH 6/8] libvhost-user: enable it on any POSIX system
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-vhost-user-posix-v1-6-0bd4d450d23c@gmail.com>
References: <20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com>
In-Reply-To: <20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-block@nongnu.org, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Brad Smith <brad@comstyle.com>, 
 Tim Pambor <timpambor@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=timpambor@gmail.com; helo=mail-wr1-x433.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Stefano Garzarella <sgarzare@redhat.com>

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
Signed-off-by: Tim Pambor <timpambor@gmail.com>
---
 meson.build                               |  2 +-
 subprojects/libvhost-user/libvhost-user.c | 59 +++++++++++++++++++++++++++++--
 subprojects/libvhost-user/libvhost-user.h |  2 +-
 3 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index eb296346a8..4f4068e7a7 100644
--- a/meson.build
+++ b/meson.build
@@ -3468,7 +3468,7 @@ if have_system and vfio_user_server_allowed
 endif
 
 vhost_user = not_found
-if host_os == 'linux' and have_vhost_user
+if have_vhost_user
   libvhost_user = subproject('libvhost-user')
   vhost_user = libvhost_user.get_variable('vhost_user_dep')
 endif
diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index e323e32cab..7ce73fba19 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -29,9 +29,7 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <sys/socket.h>
-#include <sys/eventfd.h>
 #include <sys/mman.h>
-#include <endian.h>
 
 /* Necessary to provide VIRTIO_F_VERSION_1 on system
  * with older linux headers. Must appear before
@@ -40,6 +38,7 @@
 #include "standard-headers/linux/virtio_config.h"
 
 #if defined(__linux__)
+#include <endian.h>
 #include <sys/syscall.h>
 #include <sys/ioctl.h>
 #include <linux/vhost.h>
@@ -52,6 +51,62 @@
 
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
diff --git a/subprojects/libvhost-user/libvhost-user.h b/subprojects/libvhost-user/libvhost-user.h
index ddd5cbb90e..f21ba77580 100644
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

-- 
2.55.0


