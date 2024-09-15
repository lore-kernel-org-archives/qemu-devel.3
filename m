Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF82C35FE0
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Sep 2024 01:26:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spe0v-0004Yz-AB; Sat, 14 Sep 2024 21:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spe0s-0004G4-1G
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:25:18 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1spe0q-0005eM-5p
 for qemu-devel@nongnu.org; Sat, 14 Sep 2024 21:25:17 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7d916b6a73aso2007253a12.1
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2024 18:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726363514; x=1726968314;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mCu6mvOatJtGAfDwhnsDWwsDctuJ051UjuOLN4ujdpw=;
 b=mFWFcqPDgh+WOy90CwYEQlYq+JtksSvMfq+99kIz9mtVa+F8wV9x9KkEFl0yl0lb7o
 Yz6JvXnseMwhlYL8S8t8jzlEcokrf8wBB3c4/ETtXINWa9ONUA7E4llJY1tZD91XOqgN
 r6BCFQuhrRTkVx6a3rNSrje5iqJI7paYWjJerDt8LLVuF+143TuehflbLC+SvP3Otshc
 XYS2K3k1cqmotzEeYqlt/ZCJZ9Sg+KuxJf8LPUjAPNkczj5jFx0mj1X9evGZ6CMU2sQz
 Mn9IMUNwXW8zLTk+UcasiRZROp2s76+1pMTyo44TFtIO92EomGTVO9mwSUQDNVzyPqRL
 KTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726363514; x=1726968314;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mCu6mvOatJtGAfDwhnsDWwsDctuJ051UjuOLN4ujdpw=;
 b=EBDMxaQt0PnMF1SyGU4RSE7qCBVHLVyROYAJB54gEAUk/BM8/HQCmtD7f7rrafqenF
 dkSM98gXQ/h9g3aw507JM9p4HyZrq3Zt7qNihuLeXQLcx1YlmUdaGYluZF9kzbmziPaV
 gEfJbfSgQYoUbmsPpmhMgUsXgueSvAJ0cmgY6kETUmo/sRMWwmptyGfeCFTecN9aLWuN
 iLeeAREg7js/bFYtYr/5OdEJHHt9ev/JuiU4DPMJM7zYDgjeldhUi18FDKkCFRhTGLQT
 VrT4rGivkfUVzghz3O4WV+GSeZwJi7jXWZiBD57UCaShcK4cfvB4fGleoq+gb8rrRewH
 9GGA==
X-Gm-Message-State: AOJu0YyNnW/47xlHdTcU5OXVD/Xb+y7DLSvM5vjK7boP8xWcxTO/+Zlw
 MbwbAB8x+FkZxywH31Ies+3LDJZg8CO3+6V6lGu99RekkBjZzU/3lmm0llyHKV6mGpvdNzLxk16
 +Xdw=
X-Google-Smtp-Source: AGHT+IHfSNLfVM5uZbgj+f8joU/AHheFTp5H/z7qAU+HCi1JJSSFicx8EO6oW/VsKjIyJDCXlG32Hw==
X-Received: by 2002:a05:6a21:3981:b0:1d1:13de:68c6 with SMTP id
 adf61e73a8af0-1d113de68camr12429962637.29.1726363514157; 
 Sat, 14 Sep 2024 18:25:14 -0700 (PDT)
Received: from localhost ([210.160.217.68])
 by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-7db4998b773sm1760892a12.57.2024.09.14.18.25.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Sep 2024 18:25:13 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 15 Sep 2024 10:23:51 +0900
Subject: [PATCH RFC v3 10/11] tap: Report virtio-net hashing support on Linux
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240915-hash-v3-10-79cb08d28647@daynix.com>
References: <20240915-hash-v3-0-79cb08d28647@daynix.com>
In-Reply-To: <20240915-hash-v3-0-79cb08d28647@daynix.com>
To: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::52d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52d.google.com
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

This allows offloading virtio-net hashing to tap on Linux.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 net/tap-linux.h   |  1 +
 net/tap_int.h     |  1 +
 net/tap-bsd.c     |  5 +++++
 net/tap-linux.c   | 13 +++++++++++++
 net/tap-solaris.c |  5 +++++
 net/tap-stub.c    |  5 +++++
 net/tap.c         |  8 ++++++++
 7 files changed, 38 insertions(+)

diff --git a/net/tap-linux.h b/net/tap-linux.h
index 5fac64c24f99..c773609c799e 100644
--- a/net/tap-linux.h
+++ b/net/tap-linux.h
@@ -32,6 +32,7 @@
 #define TUNSETVNETLE _IOW('T', 220, int)
 #define TUNSETVNETBE _IOW('T', 222, int)
 #define TUNSETSTEERINGEBPF _IOR('T', 224, int)
+#define TUNGETVNETHASHCAP _IOR('T', 228, NetVnetHash)
 #define TUNSETVNETHASH _IOW('T', 229, NetVnetHash)
 
 #endif
diff --git a/net/tap_int.h b/net/tap_int.h
index e1b53e343397..84a88841b720 100644
--- a/net/tap_int.h
+++ b/net/tap_int.h
@@ -36,6 +36,7 @@ ssize_t tap_read_packet(int tapfd, uint8_t *buf, int maxlen);
 
 void tap_set_sndbuf(int fd, const NetdevTapOptions *tap, Error **errp);
 int tap_probe_vnet_hdr(int fd, Error **errp);
+bool tap_probe_vnet_hash_supported_types(int fd, uint32_t *types);
 int tap_probe_has_ufo(int fd);
 int tap_probe_has_uso(int fd);
 void tap_fd_set_offload(int fd, int csum, int tso4, int tso6, int ecn, int ufo,
diff --git a/net/tap-bsd.c b/net/tap-bsd.c
index 2eee0c0a0ec5..142e1abe0420 100644
--- a/net/tap-bsd.c
+++ b/net/tap-bsd.c
@@ -217,6 +217,11 @@ int tap_probe_has_uso(int fd)
     return 0;
 }
 
+bool tap_probe_vnet_hash_supported_types(int fd, uint32_t *types)
+{
+    return false;
+}
+
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
diff --git a/net/tap-linux.c b/net/tap-linux.c
index e96d38eec922..a601cb1ed2d9 100644
--- a/net/tap-linux.c
+++ b/net/tap-linux.c
@@ -185,6 +185,19 @@ int tap_probe_has_uso(int fd)
     return 1;
 }
 
+bool tap_probe_vnet_hash_supported_types(int fd, uint32_t *types)
+{
+    NetVnetHash hash;
+
+    if (ioctl(fd, TUNGETVNETHASHCAP, &hash)) {
+        return false;
+    }
+
+    *types = hash.types;
+
+    return true;
+}
+
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
     if (ioctl(fd, TUNSETVNETHDRSZ, &len) == -1) {
diff --git a/net/tap-solaris.c b/net/tap-solaris.c
index c65104b84e93..00d1c850680d 100644
--- a/net/tap-solaris.c
+++ b/net/tap-solaris.c
@@ -221,6 +221,11 @@ int tap_probe_has_uso(int fd)
     return 0;
 }
 
+bool tap_probe_vnet_hash_supported_types(int fd, uint32_t *types)
+{
+    return false;
+}
+
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
diff --git a/net/tap-stub.c b/net/tap-stub.c
index 5bdc76216b7f..a4718654fbeb 100644
--- a/net/tap-stub.c
+++ b/net/tap-stub.c
@@ -52,6 +52,11 @@ int tap_probe_has_uso(int fd)
     return 0;
 }
 
+bool tap_probe_vnet_hash_supported_types(int fd, uint32_t *types)
+{
+    return false;
+}
+
 void tap_fd_set_vnet_hdr_len(int fd, int len)
 {
 }
diff --git a/net/tap.c b/net/tap.c
index 8d451c745d70..e17565c2ac3c 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -248,6 +248,13 @@ static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
     s->using_vnet_hdr = true;
 }
 
+static bool tap_get_vnet_hash_supported_types(NetClientState *nc,
+                                              uint32_t *types)
+{
+    TAPState *s = DO_UPCAST(TAPState, nc, nc);
+    return tap_probe_vnet_hash_supported_types(s->fd, types);
+}
+
 static void tap_set_vnet_hash(NetClientState *nc, const NetVnetHash *hash)
 {
     TAPState *s = DO_UPCAST(TAPState, nc, nc);
@@ -350,6 +357,7 @@ static NetClientInfo net_tap_info = {
     .has_vnet_hdr_len = tap_has_vnet_hdr_len,
     .set_offload = tap_set_offload,
     .set_vnet_hdr_len = tap_set_vnet_hdr_len,
+    .get_vnet_hash_supported_types = tap_get_vnet_hash_supported_types,
     .set_vnet_hash = tap_set_vnet_hash,
     .set_vnet_le = tap_set_vnet_le,
     .set_vnet_be = tap_set_vnet_be,

-- 
2.46.0


