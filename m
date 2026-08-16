Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A6EC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 11:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvZMo-0001ig-1M; Sun, 16 Aug 2026 07:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <narimansayed28@gmail.com>)
 id 1wvSav-0000ko-I8
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 00:35:37 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <narimansayed28@gmail.com>)
 id 1wvSat-0003FT-Qg
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 00:35:37 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4954a32cf1eso11711115e9.3
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 21:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786854934; x=1787459734; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5Ltu2h4mQNH63wNh6b4t2KW06UJSusNDf0EeH5Va9VI=;
 b=aUGjGWRdMxG/cXb8oqVt6jzbf/otpKMJqjiltTL4/w2mF9AqD7qCg0cyV7fYiwkmGj
 /kWO1iehE/7tww44HokCG07HoTl9cuKliHWNP9jC9r+DclfKuq0Sqc7fOfW7tndM0hBX
 uRN/MNQJS2Z2ZcQlQ9RBEwYDPtvPWcMdlRR5FloEcnNtMcy0Y7QFfAXD4TjB5nUlqvXB
 A7Bo4Xw8re0WfKx2rls/11DIoYE9lJHVeKYwyBKfoLyHDjhSf175MZAoixiP/KS16+dz
 YKGTcpm5JjwpeXxR8lOLo+fJ5h2ABGe3vNtJgrWewQOPFmtqKcQ3Mdl9Nm9v/64Oi2FW
 j0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786854934; x=1787459734;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5Ltu2h4mQNH63wNh6b4t2KW06UJSusNDf0EeH5Va9VI=;
 b=pA/fQsqJw6zJG07EzeJbbMs5E6nQabXcGJUmiKw9u5hekG5EB7TYLY5LesBRb3GNQC
 +mj1mbIqAnfKFpDtTrn4jn79AFHLkov9iNFUttjSMTM93iGChOcfHg3/yulBYSEoV7yJ
 opcdhp1FA3NClpXTohuvT3aE4ymYfUlLpISHgoQrlmr/EF38UkCa322og25EErJoB4PT
 UDXARucCEpnFhB64TJlhvwODFYpiKat8DkgHEgbALV4j5vYxaKfANTh6vYn9KfXXZ+3N
 Bqc/HNZcFdVhKTLhKTxOfTvuZTxQkVZQa1EGgWJoUgkgcHM4Mgj4wBPSof9SQcAe3sQq
 w1cw==
X-Gm-Message-State: AOJu0YwEwZM9ZRwC/XchJ1vW60SXX81Gpls3pRNgVejUDEOy+Onx/QNT
 N0rW1NfaLja4tLmeP3NIPpAFmCeXgnz0xE+L1zzew5viDBJvcedLtTMBkcmsPgNA
X-Gm-Gg: AR+sD13MAxxflPLnufkYlpQrr+275MczYaPj1heKWEVoOFA3eeX8cq0JwFxoVWleadt
 YxYzaQJPwGq0Py5GfgYOh5ijgAwxkOMSFvZR+kl9uMF+Act5RAeh7mPzDpG5sJP3qFtF93/UzZF
 +ZChFYV+a0Gw8wT+GawCRy5NvM09Usy9XGUX706XWKe2p+Inn3gNi34FF8C4tMAQnPPQxH+oa6H
 UPVIUUBgRVF1L5X7x1Oup7w+qOuFKiAB5Fri/IIwzDb3xc/JB336TgSHPiaRfw5N5lqYGnZ30eI
 5lg1T1YX/Woz4mqybs85DTpVRMRKF1RFc+m5wk8nXR3YnlX1y9UxuomwUahqcbZfr2zUm3AqdTy
 Umy7mP586J14jk/UF1pjW0Q7fQwlqvSxv05Qt1jqnjMFsEpmYydap3DI16ZyoHa44Y7VLOBakOn
 b/eVcHnTjhvEeMmeMBirCGExmsimqQY/niHi9ltZ7ndvgQC/4S7aeqfKtnshUjP8vyysQyDe99U
 A9WkTn29ST80A==
X-Received: by 2002:adf:f791:0:b0:460:70ae:f1af with SMTP id
 ffacd0b85a97d-481607630f2mr18681836f8f.27.1786854933574; 
 Sat, 15 Aug 2026 21:35:33 -0700 (PDT)
Received: from DESKTOP-2SK3BJA.localdomain ([197.49.67.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b27bfsm22971471f8f.23.2026.08.15.21.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Aug 2026 21:35:32 -0700 (PDT)
From: Nariman Sayed <narimansayed28@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nariman Sayed <narimansayed28@gmail.com>
Subject: [PATCH 1/3] net/tap: add tap_fd_get_mtu() to query host tap MTU
Date: Sun, 16 Aug 2026 07:34:49 +0300
Message-Id: <20260816043451.2547-2-narimansayed28@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260816043451.2547-1-narimansayed28@gmail.com>
References: <20260816043451.2547-1-narimansayed28@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=narimansayed28@gmail.com; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 16 Aug 2026 07:49:20 -0400
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


