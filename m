Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE00C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 07:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0yWy-0002K5-St; Sun, 28 Apr 2024 03:01:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yWw-0002Jp-Ry
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:00:59 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1s0yWv-0005MY-7S
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 03:00:58 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6ee12766586so2628349b3a.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 00:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1714287656; x=1714892456;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YXGkezc0Gx9lLWlJor+Pz7GYk0o8N+u+ry/JI3vI6BA=;
 b=Ui5dr750bnlfkAuhM6rugFGiR4kjY+RK9QDZpOEiSYzo1EouJdjxHH/rA6iFtRAFca
 NPWWZHHf9ThShFzoua1yaxunvGh2su0+9tHhZQJTHbSYKZROTtUA9jiF81n0DoZ0LKhc
 XdPBbl0x5sWWigG3V8Gp+KIy9CdJn7/1b4CCCqElLBWnkQMFLt7ZSPr+sde7wyEt6H1g
 eIP4zFRuHe/0RnIvH36IBMSjeUvFA4tV8diSj5cFtyXM6bsKn1KSHpdmx2BF1Cmz0ZOQ
 MEvi8b72wUAh4I4fhgty2JHqxWhaPp4/wxv/fiGmigxw02L9rDHLTMCUbFF5RBgiYvlM
 Pomg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714287656; x=1714892456;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YXGkezc0Gx9lLWlJor+Pz7GYk0o8N+u+ry/JI3vI6BA=;
 b=rkiGy1nULcdi6vIuXR/8HiZu8t48MUYdOatHcjYp69O4L9RTsAInIrfveuN2qUpqQi
 LyOHO/rZOMRnfF2M/QpDO9fxXcPh6NMgKZ08XMM24MCedYb+qZXfUwhfcLtrjDzB0oEA
 Rhkg7bZmgUg59Y08zQwl75vOhDsLbvwGDiTu5LC0Fe5mCAGqwAO/j6BVwWyq8AJwhVrA
 YiR4zrtsP51KZT8uiQxGcRYoobzMdhnKQ8k3ivfC7GA7jpfMqotO+JdD2fvQsG3Q9iQn
 xAzrbtNFdW3azfWxhpX218evR1BNlRf/k5/73eq2UofCxd8fnYPpdpwgltF0CnsZiqix
 0u7g==
X-Gm-Message-State: AOJu0YwP6c5S0LvOa/N/5IKUM23KAy2tVOQ7wJq2bcUkxQLx4dRAmtJM
 4QERADYBojKwY8VPjgE233/wpUvS56MKtbucOFJ2ATEXshGxKVH+EwlnOcBj2NwZG6MrbwsIKHQ
 ytBM=
X-Google-Smtp-Source: AGHT+IGvMeFfL86xJBIDKVCs58ULin/TWdvT8kDBxFutr9PvfKevr+1xT1LuTmoVaVqSwhqBqEkejQ==
X-Received: by 2002:a05:6a00:2e1b:b0:6ec:ef1c:4dcd with SMTP id
 fc27-20020a056a002e1b00b006ecef1c4dcdmr11213454pfb.6.1714287655754; 
 Sun, 28 Apr 2024 00:00:55 -0700 (PDT)
Received: from localhost ([157.82.202.162])
 by smtp.gmail.com with UTF8SMTPSA id
 jw37-20020a056a0092a500b006ecf0ad97bbsm17779942pfb.17.2024.04.28.00.00.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 00:00:55 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 28 Apr 2024 16:00:44 +0900
Subject: [PATCH v10 01/18] tap: Remove tap_probe_vnet_hdr_len()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240428-rss-v10-1-73cbaa91aeb6@daynix.com>
References: <20240428-rss-v10-0-73cbaa91aeb6@daynix.com>
In-Reply-To: <20240428-rss-v10-0-73cbaa91aeb6@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::433;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

It was necessary since an Linux older than 2.6.35 may implement the
virtio-net header but may not allow to change its length. Remove it
since such an old Linux is no longer supported.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 net/tap_int.h     |  1 -
 net/tap-bsd.c     |  5 -----
 net/tap-linux.c   | 20 --------------------
 net/tap-solaris.c |  5 -----
 net/tap-stub.c    |  5 -----
 net/tap.c         |  8 ++------
 6 files changed, 2 insertions(+), 42 deletions(-)

diff --git a/net/tap_int.h b/net/tap_int.h
index 9a2175655bb0..8857ff299d22 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -35,7 +35,6 @@ ssize_t tap_read_packet(int tapfd, uint8_t *buf, int maxlen);
 
 void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp);
 int tap_probe_vnet_hdr(int fd, Error **errp);
-int tap_probe_vnet_hdr_len(int fd, int len);
 int tap_probe_has_ufo(int fd);
 int tap_probe_has_uso(int fd);
 void tap_fd_set_offload(int fd, int csum, int tso4, int tso6, int ecn, int ufo,
diff --git a/net/tap-bsd.c b/net/tap-bsd.c
index 274ea7bd2c3c..b4c84441ba8b 100644
--- a/net/tap-bsd.c
+++ b/net/tap-bsd.c
@@ -217,11 +217,6 @@ int tap_probe_has_uso(int fd)
     return 0;
 }
 
-int tap_probe_vnet_hdr_len(int fd, int len)
-{
-    return 0;
-}
-
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
diff --git a/net/tap-linux.c b/net/tap-linux.c
index c7e514ecb04b..1226d5fda2d9 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -185,26 +185,6 @@ int tap_probe_has_uso(int fd)
     return 1;
 }
 
-/* Verify that we can assign given length */
-int tap_probe_vnet_hdr_len(int fd, int len)
-{
-    int orig;
-    if (ioctl(fd, TUNGETVNETHDRSZ, &orig) == -1) {
-        return 0;
-    }
-    if (ioctl(fd, TUNSETVNETHDRSZ, &len) == -1) {
-        return 0;
-    }
-    /* Restore original length: we can't handle failure. */
-    if (ioctl(fd, TUNSETVNETHDRSZ, &orig) == -1) {
-        fprintf(stderr, "TUNGETVNETHDRSZ ioctl() failed: %s. Exiting.\n",
-                strerror(errno));
-        abort();
-        return -errno;
-    }
-    return 1;
-}
-
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
     if (ioctl(fd, TUNSETVNETHDRSZ, &len) == -1) {
diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index 08b13af51257..51b7830bef1d 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -221,11 +221,6 @@ int tap_probe_has_uso(int fd)
     return 0;
 }
 
-int tap_probe_vnet_hdr_len(int fd, int len)
-{
-    return 0;
-}
-
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
diff --git a/net/tap-stub.c b/net/tap-stub.c
index 4b24f61e3a6c..38673434cbd6 100644
--- a/net/tap-stub.c
+++ b/net/tap-stub.c
@@ -52,11 +52,6 @@ int tap_probe_has_uso(int fd)
     return 0;
 }
 
-int tap_probe_vnet_hdr_len(int fd, int len)
-{
-    return 0;
-}
-
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
diff --git a/net/tap.c b/net/tap.c
index baaa2f7a9ac7..72ae95894ff1 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -259,11 +259,7 @@ static bool tap_has_vnet_hdr(NetClientState *nc)
 
 static bool tap_has_vnet_hdr_len(NetClientState *nc, int len)
 {
-    TAPState *s = DO_UPCAST(TAPState, nc, nc);
-
-    assert(nc->info->type == NET_CLIENT_DRIVER_TAP);
-
-    return !!tap_probe_vnet_hdr_len(s->fd, len);
+    return tap_has_vnet_hdr(nc);
 }
 
 static int tap_get_vnet_hdr_len(NetClientState *nc)
@@ -432,7 +428,7 @@ static TAPState *net_tap_fd_init(NetClientState *peer,
      * Make sure host header length is set correctly in tap:
      * it might have been modified by another instance of qemu.
      */
-    if (tap_probe_vnet_hdr_len(s->fd, s->host_vnet_hdr_len)) {
+    if (vnet_hdr) {
         tap_fd_set_vnet_hdr_len(s->fd, s->host_vnet_hdr_len);
     }
     tap_read_poll(s, true);

-- 
2.44.0


