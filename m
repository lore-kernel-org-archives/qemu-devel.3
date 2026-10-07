Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF927CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENIZ-0007SP-Pk; Wed, 07 Oct 2026 04:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <narimansayed28@gmail.com>)
 id 1xEJsp-0001cE-GZ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:08:32 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <narimansayed28@gmail.com>)
 id 1xEJsn-0005JO-9h
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:08:03 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a172eb31f0so11859575e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 22:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791349679; x=1791954479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5Ltu2h4mQNH63wNh6b4t2KW06UJSusNDf0EeH5Va9VI=;
 b=f003dV1hu/ZNbwx1PCA2ykJGlFsrhrWSf21Lv5qVqa16slIc8VglOaNFTYzmppyaH8
 +uUhQcaN0vEeOXyWZUfPfkQAx35HuNPVXsEQLDAdBFVEiPRAeY4zw4CaBT4FHig47t9u
 XKQ9y9yp0KQ4zo3qoI6NDDNCsmjF6/rbpdAtzHjULGDxE/DxJuYLjv2RtwBFlXvxDg8r
 YFOFJmRM4FM71ve4gtzPwYyQS/1TdEVgYtuxpBxbck/zqGy+OG6ij3C/xJMtabfUhrMa
 CdCnK2b1CX92QobyYJEttdjhaErjQ7mFKDwSy5++CYSZrMTRVg0bxZaz/cMMyFt0gAVI
 3vjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791349679; x=1791954479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5Ltu2h4mQNH63wNh6b4t2KW06UJSusNDf0EeH5Va9VI=;
 b=1SXjUHgN+pehUJ/xpTdziXdMnRBO8fp8P07izZgcIj5ANYT36Mk6MMXkMqJfokzSyM
 U0hbtadKdVngOCPl+XF6y+MMhDX+5jdXvoTKbinInnifuQTkTQlGfdPgphmT8M1lNRRp
 6MQVRb7UFuLBidqAFXYPOMsvTOUhkmZrMiB8+BVoeNxgff7tkCiQBTNpw92z6j4JDDpO
 mOGZO/K2fWdK5EHhN4G8tA8EOI3J7+BqWxBOcCQIwU4TQNpugM3Vl5VTb4MSHUfFQZde
 gHkMpSx7huir7IqZEZADLOz5760xxicAbgTseXDNZlYfjcMsvM7REnkSKevqyieAHHaZ
 Js3Q==
X-Gm-Message-State: AFuF++lmYN3EWHoAO9cbelaFPsX8YfPyPJoteCp7xtdRgBtVlN47/sZr
 bEP4sYg1SmCt8dsEcE/ZQslf6Vfw9Ixa+HZ7Fm8WV8yNcKGY9I9ODPFMhWkrgaURhdE=
X-Gm-Gg: AYBFou3H7V996+sa4GrkviTv9blINWoaf8hu+D+ZjD4sgntZx5f4REaienE8TpmhRFw
 1yFcPZq1vFHkWuqCgEywpkrmXZMyM3FJ5jnjDaOS51ZPCuNl+Q+IdfwJe/esM+pS3aXTn29s4nk
 wOlUGVqrwDIGdm6E929U8b/c3mGYfuZDcy5raltB5XznzijsC7GGuTr3W5d30DRBSlwea6EZkIy
 ojve5ufo7UbGEWZW11t86Q6gSa+gOSir291mIM+0AM92SqB1Mvbxib5z86rYUv5o+c/OFPUvVNi
 t6NQrfguHERtqBr5FfqtmjxTFmUZHzHz0ibnXf8qFNPPsyhyK3q0GQQ0HG9cJJ+xTrXVSEeDUo3
 Uaz1fjXgO+ZsmGi+9Z3jH/cVnihmx7R9HVxUMwVdqjOQr3sdyhohRuO7pdVwA8DfzMS4IbGrePN
 sngtWpF1O0mR9zHBte+6QnIAZHfuqabEsOTKdH/naAN3KNTt1uM3DeFcCEvl0KtH7g4KhGyEGVe
 QH/Phc2+CLYc/ODvLT3hAcwKw==
X-Received: by 2002:a05:600c:810c:b0:49f:ff73:9971 with SMTP id
 5b1f17b1804b1-4a180420274mr12578265e9.18.1791349679023; 
 Tue, 06 Oct 2026 22:07:59 -0700 (PDT)
Received: from DESKTOP-2SK3BJA.localdomain ([197.49.190.197])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f795f29sm33359315e9.11.2026.10.06.22.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 22:07:58 -0700 (PDT)
From: Nariman Sayed <narimansayed28@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Nariman Sayed <narimansayed28@gmail.com>
Subject: [PATCH v2 1/3] net/tap: add tap_fd_get_mtu() to query host tap MTU
Date: Wed,  7 Oct 2026 08:07:16 +0300
Message-Id: <20261007050718.926-2-narimansayed28@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261007050718.926-1-narimansayed28@gmail.com>
References: <20260816043451.2547-1-narimansayed28@gmail.com>
 <20261007050718.926-1-narimansayed28@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=narimansayed28@gmail.com; helo=mail-wm1-x330.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Add a helper function to read the host tap device's configured
MTU via SIOCGIFMTU. Since this ioctl requires a socket rather than
the tap character device fd itself, a separate control socket is
opened to perform the query, following the same pattern used by
net/can/can_socketcan.c.

This is implemented for Linux only, with stub implementations
returning -1 for BSD, Solaris, and the tap-stub backend, matching
the existing pattern used by tap_fd_get_ifname() and
tap_fd_set_steering_ebpf() in those files.

This is a preparatory patch; the function is not yet called from
anywhere.

Signed-off-by: Nariman Sayed <narimansayed28@gmail.com>
---
 net/tap-bsd.c     |  5 +++++
 net/tap-linux.c   | 30 ++++++++++++++++++++++++++++++
 net/tap-solaris.c |  5 +++++
 net/tap-stub.c    |  5 +++++
 net/tap_int.h     |  1 +
 5 files changed, 46 insertions(+)

diff --git a/net/tap-bsd.c b/net/tap-bsd.c
index c39daf9385..17cedccf9e 100644
--- a/net/tap-bsd.c
+++ b/net/tap-bsd.c
@@ -264,6 +264,11 @@ int tap_fd_get_ifname(int fd, char *ifname)
     return -1;
 }
 
+int tap_fd_get_mtu(int fd)
+{
+    return -1;
+}
+
 int tap_fd_set_steering_ebpf(int fd, int prog_fd)
 {
     return -1;
diff --git a/net/tap-linux.c b/net/tap-linux.c
index 3cd7d26710..23a10151c1 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -34,6 +34,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
+#include "qemu/sockets.h"
 
 #define PATH_NET_TUN "/dev/net/tun"
 
@@ -346,6 +347,35 @@ int tap_fd_get_ifname(int fd, char *ifname)
     return 0;
 }
 
+int tap_fd_get_mtu(int fd)
+{
+    struct ifreq ifr;
+    int s, ret, mtu;
+
+    memset(&ifr, 0, sizeof(ifr));
+    if (tap_fd_get_ifname(fd, ifr.ifr_name) != 0) {
+        return -1;
+    }
+
+    s = qemu_socket(AF_INET, SOCK_DGRAM, 0);
+    if (s < 0) {
+        error_report("could not create control socket: %s",
+                      strerror(errno));
+        return -1;
+    }
+
+    ret = ioctl(s, SIOCGIFMTU, &ifr);
+    if (ret != 0) {
+        error_report("SIOCGIFMTU ioctl() failed: %s", strerror(errno));
+        close(s);
+        return -1;
+    }
+
+    mtu = ifr.ifr_mtu;
+    close(s);
+    return mtu;
+}
+
 int tap_fd_set_steering_ebpf(int fd, int prog_fd)
 {
     if (ioctl(fd, TUNSETSTEERINGEBPF, (void *) &prog_fd) != 0) {
diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index 8704b1084b..d3bd6e6b48 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -266,6 +266,11 @@ int tap_fd_get_ifname(int fd, char *ifname)
     return -1;
 }
 
+int tap_fd_get_mtu(int fd)
+{
+    return -1;
+}
+
 int tap_fd_set_steering_ebpf(int fd, int prog_fd)
 {
     return -1;
diff --git a/net/tap-stub.c b/net/tap-stub.c
index 6aa60d96ad..756ce882a7 100644
--- a/net/tap-stub.c
+++ b/net/tap-stub.c
@@ -91,6 +91,11 @@ int tap_fd_get_ifname(int fd, char *ifname)
     return -1;
 }
 
+int tap_fd_get_mtu(int fd)
+{
+    return -1;
+}
+
 int tap_fd_set_steering_ebpf(int fd, int prog_fd)
 {
     return -1;
diff --git a/net/tap_int.h b/net/tap_int.h
index dc4f484006..360d61c889 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -45,6 +45,7 @@ int tap_fd_set_vnet_be(int fd, int vnet_is_be);
 int tap_fd_enable(int fd);
 int tap_fd_disable(int fd);
 int tap_fd_get_ifname(int fd, char *ifname);
+int tap_fd_get_mtu(int fd);
 int tap_fd_set_steering_ebpf(int fd, int prog_fd);
 
 #endif /* NET_TAP_INT_H */
-- 
2.34.1


