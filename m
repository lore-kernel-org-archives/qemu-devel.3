Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8781E606A325
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zURiqgz3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMkgG-0001Up-RT; Fri, 30 Oct 2026 07:21:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xMkg3-0001OM-SU
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:21:43 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xMkg1-0002mw-Q6
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:21:43 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso315541f8f.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 04:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793359300; x=1793964100; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NQyHj/7isbZq1anOngku43wTHeR8eA80fkM1Z6NDWCo=;
 b=zURiqgz3n6a+0WA9DLO/Wu0m2LYKWtGr99O/WjKDYKtFAkY1W9ukEK4GD8H/LR6Sau
 DBYoIZq7dhPr3OjI/7e3dZIGL7TZV3iNd8IMlNHJyzQgfiyTAnratFnmIdmUf8ZFw9Qf
 BCfwW86WiFlLcdlo0rewmLBYmnP29UgIhEUH2/N86UgZxmya/8tr+RKiWuRo0dqlKnFI
 HK8F4TCFbbOFClMMp4qrS21U4cwDEQmlIDcKKJLD6IvWK7RsOcb9n6GDVLxJRaj0XSmn
 ge9ARApeplouQE8JnfuporPtaF1XK/WqAWQbQR9m8ko9T+hxrlikGEXlVl+Z3p/sTbX0
 AKIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793359300; x=1793964100;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NQyHj/7isbZq1anOngku43wTHeR8eA80fkM1Z6NDWCo=;
 b=itr3Wx3Wam0aXXM1X5UfPgzry43cGkadM2ODgnOxeX7jDaT4IUWNdLD1YR/bQQCUKG
 ir1CvJngBXhOht8B+7hsp0jbWWFfkCpwPBHmw2A0mz2QJegVsfLROW+ekRB+QV7FyqXg
 cJ9l64nTi6AO+ll3cwPbYeaLGPUj+/WAZ8gidrU+YrhmX4vrmYzq/s2e1h7z4sjNeIp/
 Tj5NOzsEkNbH2QVMZi+ZUVgfp9oBELlf5gdwswtYAlZqU65pz4FQCBPVeJ3aUSdAdzm0
 I1U+xNfNxuAAqlI1rMYAp0aNf5t8dc5+NR3q4+NbWekMpF1MfOyRm9VLxHr7EIRzD7Mq
 2gBQ==
X-Gm-Message-State: AFq9FYKOe4HfnnttNUiCmUen17NL5X55dpGmqZZVoJyO+xesAhGrwO4T
 VOsI4V82pUH6uL54G++QV017ygZysN+5xwPhT11mawFYJBSvD2J8+rO7
X-Gm-Gg: AYBFou3zkLV37hb828l9GBNb/KIAQgRyAq4XS/tPSqnSY0Q5lfwzbryX1Ynfq+QU6Db
 q5yEwA+VCBz14lgtQjdHydiktp+jC/IRpNelABTa0pSS0DsHd7Aq/cP/QD7AVtGdAXtltTR12Lg
 mznVvlTKY/KRbeKgvo1EOT020lsSCgvtZY5GNH/oE3t+RajsLyjWj/6ETe3knQy/IoGKLncorTp
 dC6riXZTg6yTj7L4bP44ueeJvzNZ2hHAsPpDmZB8OlEyS0DuQvXF9BrbvFkkQTdei319Iplgmy0
 hGjpL4blZPS22GyRUpLJrRcXmbiWWJsSDqPcT8mt6BR0PEPKAtIhOUtQ3WMCDcr4I5hHiS0X8hM
 Q6JhcsIprzAau4VrsEhiBUbn6V7f2F3lWamIsuCmTfJbON9RniTfCJFFZBTv4i2Wd1gYMep23Ep
 LjX8UCHKTmsBoYYA7xvtEyR6wLAXyyf0tFqSxW+GB65Ot7YjuhVN4V9oXkYI2sE02PpVLUu3C3J
 k1915y/+spWi4Rontrl6eti/RKgrM3GJVBD5SbHCJvkgrrGJkIssnneQKcZH35B8C35oQU8LQk/
 FRS6D+99U1NlTtKdGodXfmfpEdtKDIGyLtivIT33rzQ8HptHi6Wto8Dx05ef1Wxw5p2+IB62BU/
 Je7Bn1ct6ijAEV2PNoHChy6v+10b1IBTh/K4b8n9yjmkbSahvnxBWJySFnq1aWnRZz5gguWNIk4
 DFsc+vnpA=
X-Received: by 2002:a05:6000:40ca:b0:48c:5304:5e50 with SMTP id
 ffacd0b85a97d-48e6e2620d8mr5235192f8f.0.1793359300014; 
 Fri, 30 Oct 2026 04:21:40 -0700 (PDT)
Received: from tim-m2.local
 (dynamic-2a02-3100-61d8-3600-98fd-cd98-7ae6-cb49.310.pool.telefonica.de.
 [2a02:3100:61d8:3600:98fd:cd98:7ae6:cb49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm2893608f8f.6.2026.10.30.04.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 04:21:39 -0700 (PDT)
From: Tim Pambor <timpambor@gmail.com>
Date: Fri, 30 Oct 2026 12:21:01 +0100
Subject: [PATCH v2 8/9] libvhost-user: enable it on any POSIX system
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261030-vhost-user-posix-v2-8-cda7c17aad13@gmail.com>
References: <20261030-vhost-user-posix-v2-0-cda7c17aad13@gmail.com>
In-Reply-To: <20261030-vhost-user-posix-v2-0-cda7c17aad13@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-block@nongnu.org, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Brad Smith <brad@comstyle.com>, 
 vhost-user@lists.linux.dev, Tim Pambor <timpambor@gmail.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=timpambor@gmail.com; helo=mail-wr1-x42c.google.com
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
 subprojects/libvhost-user/libvhost-user.c | 42 ++++++++++++++++++++++++++++++-
 subprojects/libvhost-user/libvhost-user.h |  2 +-
 3 files changed, 43 insertions(+), 3 deletions(-)

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
index 5f649a3d52..7c5b89dc0b 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -29,7 +29,6 @@
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <sys/mman.h>
-#include <endian.h>
 
 /* Necessary to provide VIRTIO_F_VERSION_1 on system
  * with older linux headers. Must appear before
@@ -38,6 +37,7 @@
 #include "standard-headers/linux/virtio_config.h"
 
 #if defined(__linux__)
+#include <endian.h>
 #include <sys/syscall.h>
 #include <fcntl.h>
 #include <sys/ioctl.h>
@@ -51,6 +51,24 @@
 
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
 #ifdef CONFIG_EVENTFD
 #include <sys/eventfd.h>
 #else
@@ -67,6 +85,28 @@ int eventfd_read(int fd, eventfd_t *value)
 }
 #endif
 
+#ifdef CONFIG_MEMFD
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
index aedb1da96d..a2f0add832 100644
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


