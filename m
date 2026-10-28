Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22702606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eynWGrlJ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Bf6H3rh6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7IW-0006nY-Oa; Wed, 28 Oct 2026 13:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7HQ-0003fw-L0
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:17:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7HO-00043J-It
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P9+g4MNRH6UdmEEXDglt5NxJgiXo5esrxG9LpeZdfqU=;
 b=eynWGrlJVrkwJUUKjzHJLgjGJaKnppRNo2K5hUYy/smIQeURdCYplrq4tzSXItVUmBLlxL
 FfQawxkHYm3jCks44zMNpOOzoVlYzwCMEkQj1krlaFh+48l19mAsGDQXysjJXqsTadXReq
 EoMwvVy24K3q1W7qgpde2Rj0qK8B6nQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-510-aWNBbs9WOjqYG7EGiVYlyw-1; Wed, 28 Oct 2026 13:17:36 -0400
X-MC-Unique: aWNBbs9WOjqYG7EGiVYlyw-1
X-Mimecast-MFC-AGG-ID: aWNBbs9WOjqYG7EGiVYlyw_1793207855
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a9d51dc486so4507315e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207855; x=1793812655; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=P9+g4MNRH6UdmEEXDglt5NxJgiXo5esrxG9LpeZdfqU=;
 b=Bf6H3rh6R0F/PvHKRGERZuucUEctGW2VVQ63l+W4d9jp3fp8HgtxsSSMxx0cvTG+H0
 fHMceHdVOpC6iDKlSlHvhJMyS+5LlGoPCSzaACbF0/y6NxIqMyQWO2LqPVQtWgPg85hw
 3+3F/QZRPyVtCiFxk0aQG9MN4qn2byCN2SNCfYaoAJ7WIQcYkb/XGMomXs7NFSBJLCAW
 xgubUBiUzV3G0VJ6YrsduxHYl9/kSZBebj0aZGow+/tQTjbVDGjjQ095wDGb9rSXYtdF
 mfUkbpJ1TVXczmX6m0np6lU7swAgYZAx8B+klTiaiXuIRC9523ZUWwdRBe2Ss3fwuvVw
 xcKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207855; x=1793812655;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=P9+g4MNRH6UdmEEXDglt5NxJgiXo5esrxG9LpeZdfqU=;
 b=mZIe68FrAu4Gf5Q494Xnr5o3RqIyN1buwnoObX8/waMNjsIulR7dEFb6nF7Xzg9TFW
 fH17uwBrtL8r5hXRa6E+bS5KcLYcSv48RZw/w4SeeSHEmUggaiNQBYp0n266sjvnAv5y
 WLqSOkqeFjY6lNgq+CCCWuMqxp22J8LihvhQLHxr//02tCY634QLOKfTt8Rfo9dOZO3H
 GFgC/wGKLv7oBHLec+W82bLz08d9TQFhzq6oXwwOmkTAz0UPQd5MKNXzdla33Fx583wM
 +udDMNtoTRlZen2OJyCPvJn5UTqm9oBhU6ghmwO5rsZoKh8gd7ne8Ndk4kRe8UMpDHbA
 cwmw==
X-Gm-Message-State: AFq9FYINh5tKdT/4zD9ikS18ocllahxUtR9K2kiJu5jLzo+vRB9Yds/Q
 NuAWnaUg0bATIjm+hsl0edSvrbnIUCb1EyE92RKzhclceSxKUeU4uce2CRVVgT3sKWfWqGGbZWM
 QfCUV/V1QS98L63+c1FnM8IqORuYcsp2M9FTOuYzXAkPjCUHwgtN28fxTaJR4koeVu0HG3mxNSp
 SDjpV0wakFkLzUbZFO1vqe4rYDIAC4U8Gkgg==
X-Gm-Gg: AYBFou3049ZCtexjDoMExD9B3HTK1DDIaXZkzLGjtOeYKrtns252+O8MWAMajKK4QXO
 OILRwbV9YpiMHQkPyzpCtgy66AE2Hd5eNhp6ly+ktv05tq/uXbUKI5rO/UMEymMI0ZAZwWB6MNw
 L4+fDS9ZuP50NnVfhmuuu0BvQ3iMq1+py9CcnvfQzyU6Kn0LGYOgZEcASslzb6XqjnM4sususmJ
 Pzc1qRT7Ph2eT3mNwdfPQr5Q/VslpFTOXCQdcJFnbY6fjVLT3JjY2Jfzm81oQ1f0cuZEHLNeuON
 UAFU/QRqtlXeyDgnAXdjllhjfcy1YVJEFSXS2HifFTqcmQSxXu3rzdOHD/nUSQslzAivbLuRHIm
 ifawLMr6HVfYewThQw8AirnJVZDTHMzJ/+n/b67Zp
X-Received: by 2002:a05:600d:84ca:20b0:4a1:c6f5:2450 with SMTP id
 5b1f17b1804b1-4aa88333b11mr3801905e9.17.1793207854851; 
 Wed, 28 Oct 2026 10:17:34 -0700 (PDT)
X-Received: by 2002:a05:600d:84ca:20b0:4a1:c6f5:2450 with SMTP id
 5b1f17b1804b1-4aa88333b11mr3801365e9.17.1793207854177; 
 Wed, 28 Oct 2026 10:17:34 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa81a896fesm6260185e9.10.2026.10.28.10.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:17:33 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:17:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Nariman Sayed <narimansayed28@gmail.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: [PULL 76/78] net/tap: add tap_fd_get_mtu() to query host tap MTU
Message-ID: <c9595f36f1bd8daa40fd3e49f92b8b793223f9ec.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nariman Sayed <narimansayed28@gmail.com>

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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261007050718.926-2-narimansayed28@gmail.com>
---
 net/tap_int.h     |  1 +
 net/tap-bsd.c     |  5 +++++
 net/tap-linux.c   | 30 ++++++++++++++++++++++++++++++
 net/tap-solaris.c |  5 +++++
 net/tap-stub.c    |  5 +++++
 5 files changed, 46 insertions(+)

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
index 2c6c7af15e..f91a317a9f 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -293,6 +293,11 @@ int tap_fd_get_ifname(int fd, char *ifname)
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
-- 
MST


