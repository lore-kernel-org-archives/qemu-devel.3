Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404A5606A32C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D8tGR2hL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMkg3-0001Nk-TG; Fri, 30 Oct 2026 07:21:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xMkfw-0001L6-FZ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:21:37 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xMkft-0002kt-W3
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 07:21:35 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so3175875e9.3
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 04:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793359292; x=1793964092; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9BuA42MLQr/5PMMpsTyjKbeHEHVM7JPHne/HEN7zZQU=;
 b=D8tGR2hLygnC+aCZ4nCfpjZzmT6KMMSDUugreiVeJcfrBdgIXBJ5aVlOglrQ6l2rl0
 yg2F86M48d0OFxouD1Cp0nIp8JFLuyrUN6uEDNUvlHtSbMXuBesJuCzW7i953W821ezS
 02oBImwKwZtWGz9RK6Z8a7qYRGzvkfz1HhzOSCy1dCWItNlw07oQuSwNPiNm+elJ126x
 EKB3VVUKy/g1y2xsF0jAOq5b74+lzV8YJz/xgyOEPlXiLVmzQggPyhS1/egkNpFR5n+I
 LRpTTzQkMT+x8nLoYDX35G7Qd4Ctc1a16eFrFn6/rdyn7qZdq0gFRlvPUz8tNwPdwO+R
 UUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793359292; x=1793964092;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9BuA42MLQr/5PMMpsTyjKbeHEHVM7JPHne/HEN7zZQU=;
 b=Shyi9cF0+PnHLOLxfXfPhUQJHQb/tr7N38VrnIU5NO1sEvZXkr6msx1KIEXfFI6Bzj
 LmjvAHB28E+Dwc4L5poh+X8Y2Vb3/1nmL2OaRkjLxdqxAK+6alVa3YiReYklcwXk2+Eo
 A/vPl8Alm3yzceI9xo8EwIxbs1h/2g4UF0nb3t3TSR9iPp45+ouAnmbt61UFwPT0fgw7
 TKftKK+ejbdJfnM7nvOoRfcySj3oUfXCaPJkQb62FE7hIyevaVGMMc3tSFSVLVhlP+Ip
 CEnylew7N0sKSKnuin/F6s6pD8PtOwIlHqeZ5CXlR2ICQLBeuB/D0t6TEX/tZlAsrJoh
 vEcQ==
X-Gm-Message-State: AFq9FYK6HizlPdKF68GcafJpvIQWj/d3gVXJ9LzE2qSLz+Zs/tFgSoET
 6IPbJIaRRUFsQlwmMtj35OGLG9CSqsf/F+3lj0s291sDylQ3V/iw6jre
X-Gm-Gg: AYBFou1e7jUUSwDanEJsS5H8PDrZPiYYY7WVzNUVioAu1bvCHbejguPZODQXMGUupug
 SBySTxYM6y+mvVwQVmiUO04SOV03pbT3Lbor6iyEu8rUPQI2ODqwZk/rBGsoE/2Z3l2WzVz0ftC
 J3VNcjB9e2in9lALBNSBQydbXrzmn+qNI2y1wDFPKsmWkH2pUutZM0q2YCXpFSTUwUFEZ07f6Pj
 hNmKAholI+fG9NVb5K1iid6vlCU/Ln6EGxCd0mWWNFzCkoWOn8L4xFsKfQ+6plt9TBnltuDFWjo
 JoYuzE/172cfhjrYhsaqqa4HAka42c4rbKAo8dBDA246KWw68+QxD6Ex6ct/woEtP3fhVAgAy3n
 +NXF46MER3BN10FCGAsOu6GRmDyLuhIk0sas2C2AsMUb5WPKHkj8FsRvp5ZkgF831PkAWpOCd7k
 OyKtmF+iYPkD6ygDMRXjrYZDEat9mwgrhnzslK+jNvkLd2EQrJfsZR702Otse1T0lHlNAv8Hcm9
 xgoUQQI95w1iZgExw6XrX6E0qd9/fg6r9U90Q6nVLmIlST8Y+0/2hDbbM7skUyQbbALdIHwNKJG
 FCzDEYLkmQXtcHWKs4gtTNBAelUHhWg7xW3JUQBHFgoAWe+LdikFU/neFO/4vegyxeKvhG6PHsB
 XKupC2x8olBFKtbjch/94+TmvGyXXrj/gqx9Oe/bF+ooo7kqqniBTJpLg4Bz5vw==
X-Received: by 2002:a05:600c:138c:b0:4a1:f90d:6f4c with SMTP id
 5b1f17b1804b1-4ac17ffaff2mr39360115e9.7.1793359292398; 
 Fri, 30 Oct 2026 04:21:32 -0700 (PDT)
Received: from tim-m2.local
 (dynamic-2a02-3100-61d8-3600-98fd-cd98-7ae6-cb49.310.pool.telefonica.de.
 [2a02:3100:61d8:3600:98fd:cd98:7ae6:cb49])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d3e9sm2893608f8f.6.2026.10.30.04.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 04:21:31 -0700 (PDT)
From: Tim Pambor <timpambor@gmail.com>
Date: Fri, 30 Oct 2026 12:20:55 +0100
Subject: [PATCH v2 2/9] libvhost-user: detect eventfd support with a link test
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-vhost-user-posix-v2-2-cda7c17aad13@gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=timpambor@gmail.com; helo=mail-wm1-x32d.google.com
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

libvhost-user includes <sys/eventfd.h> unconditionally and uses
eventfd_read() and eventfd_write(). The header is not available on every
POSIX system, e.g. macOS, so the build fails there:

  libvhost-user.c:31:10: fatal error: 'sys/eventfd.h' file not found

Probe for eventfd() in the subproject's meson.build, using the same test
QEMU's top-level meson.build uses for CONFIG_EVENTFD, and only include
the header when CONFIG_EVENTFD is set.

Without eventfd the front-end falls back to pipes, so provide
eventfd_read() and eventfd_write() replacements with plain read() and
write().

Signed-off-by: Tim Pambor <timpambor@gmail.com>
---
 subprojects/libvhost-user/libvhost-user.c | 17 ++++++++++++++++-
 subprojects/libvhost-user/meson.build     |  6 ++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index adda700630..ece2bfcdd7 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -28,7 +28,6 @@
 #include <inttypes.h>
 #include <sys/types.h>
 #include <sys/socket.h>
-#include <sys/eventfd.h>
 #include <sys/mman.h>
 #include <endian.h>
 
@@ -52,6 +51,22 @@
 
 #endif
 
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
 #include "include/atomic.h"
 
 #include "libvhost-user.h"
diff --git a/subprojects/libvhost-user/meson.build b/subprojects/libvhost-user/meson.build
index aa5894a642..2f9aedb208 100644
--- a/subprojects/libvhost-user/meson.build
+++ b/subprojects/libvhost-user/meson.build
@@ -20,6 +20,12 @@ if cc.links('''
   vhost_user_flags += '-DCONFIG_MEMFD'
 endif
 
+if cc.links('''
+    #include <sys/eventfd.h>
+    int main(void) { return eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC); }''')
+  vhost_user_flags += '-DCONFIG_EVENTFD'
+endif
+
 vhost_user = static_library('vhost-user',
                             files('libvhost-user.c'),
                             dependencies: threads,

-- 
2.55.0


