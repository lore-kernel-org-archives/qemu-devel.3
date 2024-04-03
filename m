Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59C1CD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 11:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rryWF-0007IC-5d; Wed, 03 Apr 2024 07:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryWE-0007HE-3o
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:11:02 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rryWC-0007Dy-7j
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 07:11:01 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e6ca2ac094so5752121b3a.0
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 04:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1712142659; x=1712747459;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YXGkezc0Gx9lLWlJor+Pz7GYk0o8N+u+ry/JI3vI6BA=;
 b=yKijjXyeE7ITXBfHW+R9UkY4PuGuYAwNKGGTxwhkgVNg2Cu0NXhXC0WMnz1+3DNWjA
 IWPhLSPZxRJl9HTeTPrqwS40/zI8THeOXKmmbY8ziHK1CNUgbNrPD6c34TZui0B68Idd
 ZdaUUqtIDfJl3YSlmbU/bPXJQxey/x6F6hnZlAkdBg7+chFW+g4kN0FhXBUcL1P8V/Eg
 t5H0JvgDO1MIwzHcEA16GWlOBJgzHC3QBlP1p1zHitNBXcDtVWzxzzo65+Dr1rrKyEis
 pRU6/pbTCei4p4dfrEPn5sMWbYgc3H9PFFwq+1mRrCmLw+SF2JKbs+8m9saAv3E1fULE
 97lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712142659; x=1712747459;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YXGkezc0Gx9lLWlJor+Pz7GYk0o8N+u+ry/JI3vI6BA=;
 b=FsgnMoXpVBrg8jYRdPM1AsFy9/cF0qJSmtsfjEe/w4QegYJs2+tcvPRZaq7S9EBUiU
 J5To5obuDeeVPba2cfBzLgpKxwjlv3VlQ/HTerlpa0vi+llUNZGuEmI/ZyGocybdvBg7
 QIpWaK4p0QaaGMHXvVRWHiNkB07bNMhsG03Jby5Zu8pxi+yjqf7tzZEwvqbXW7bsOWmJ
 KnUMUolPVPCbkUEGCbx2bDJqOkiEpE8QZOpZN8MlcBO2tE1aURzZM+8kQW38tqDJo1X+
 rg7mrMmnvJEGtYGlsEZ9Xh8SrMpAbQjCVD8ZQZ3PSZpOZ3ibKDgsxSagJAWGQ+kQEFsZ
 +ZUw==
X-Gm-Message-State: AOJu0YyOrn1YVWJeHrtXEuGhaMphkFj7OT/oXGD/I8lNkfszqrD28EYs
 gneZGfZdEfyazkJ3ron2rJBOqCcWwmzFlOC2Pzg2EqiFJsNInLviez09NL0iLrM=
X-Google-Smtp-Source: AGHT+IE/oI75EJqLc9vLcZgcYEaygXgQy3TM8ylKd8ZEXHINbBR41MPzZ/RSd+CJ4tiXVwboI/rFVA==
X-Received: by 2002:a05:6a00:c8c:b0:6ea:bdbc:614 with SMTP id
 a12-20020a056a000c8c00b006eabdbc0614mr16265414pfv.13.1712142658815; 
 Wed, 03 Apr 2024 04:10:58 -0700 (PDT)
Received: from localhost ([157.82.200.213])
 by smtp.gmail.com with UTF8SMTPSA id
 i21-20020aa787d5000000b006eaada3860dsm11454054pfo.200.2024.04.03.04.10.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Apr 2024 04:10:58 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 03 Apr 2024 20:10:49 +0900
Subject: [PATCH v9 01/20] tap: Remove tap_probe_vnet_hdr_len()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-rss-v9-1-c6d87e69d38b@daynix.com>
References: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
In-Reply-To: <20240403-rss-v9-0-c6d87e69d38b@daynix.com>
To: Jason Wang <jasowang@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Luigi Rizzo <rizzo@iet.unipi.it>, 
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, 
 Vincenzo Maffione <v.maffione@gmail.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Yuri Benditovich <yuri.benditovich@daynix.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
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


