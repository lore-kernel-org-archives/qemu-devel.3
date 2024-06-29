Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8A1C27C4F
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Jun 2024 06:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNRWN-0001F5-UO; Sat, 29 Jun 2024 02:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNRWL-0001EK-O2
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 02:25:13 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sNRWJ-0000Kx-SD
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 02:25:13 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f9b364faddso8789835ad.3
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 23:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719642311; x=1720247111;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MnJaU0cjPc61Uq6zYp8Z9ZfUP3zCOPt1Iu/1t/nlpCY=;
 b=2o1hy5isoZPQG/zE+M6jLEIUmiVQXdc0iyPTdW6e/W4FJQwmD4xTHP+WrRXqp+TPxs
 5vpKpL7s4AvwGncT1ltRq55xv4iAv4s6WxYrFLwCkYGRUv6v/gpXX3OtRTrj4IEY90le
 sd+IknxUOILMH0UL6DRJpezkbdhwjJLn+2zLDrFawb01vwa1bzXk+afAE2N/ifGk9nt9
 n34DbT9kgY3gIs7QAPGYgA+3XlgnbP4pi/9pzWEBn7vlpgjc7ak4NCPoqG9oPuK6T+Bj
 0XZkYSekKQlTYHemq4gZC2/QNzlCxWC9DdaLnMvHIX0NnshbpdUtzJQFs5r49UaZMVz0
 Wj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719642311; x=1720247111;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MnJaU0cjPc61Uq6zYp8Z9ZfUP3zCOPt1Iu/1t/nlpCY=;
 b=kRoZ5CUHr/++fjn2X3cYPX5xyJ+x+/U7DJkyTNTtoHIV/jDCj+QKHgQM5v1dkEWtpu
 hpZ59qEwVKGD7ZhsQ5uMb2+ivRxuh1cOw+Cu4P5NMuR9EeFCsl9CziYFEvVdmuhl+0PN
 1PK3/GnqcpNmIWZquZXDOL/ViICSUmIhUz3DGTdVwrWQavZRUc9rY4gBjgo6FIQo2BSd
 TVBluZ/QvB0msZho/wXFjnDH4FpPL0Vpt1mMJLa3fBYFQxHKMiA8JK+Do5SHdae7qDnr
 HkkvKJY5SDLLiOop31iKkPAXEQighAaGwRbKXW0TZgOJq0BnI54W7IsBQqyAikZ/pu3J
 Cilg==
X-Gm-Message-State: AOJu0YxcJFto/2MKe1pHycFRPLLwF6JWllrH0Km1AMe3DmPjPuYlOKwE
 Sh3AsQHNzRFnMrClhsRiXJVtOSAj6b7AzRWjTdarVyinVMO5Q9+qaVphkFEGYKo=
X-Google-Smtp-Source: AGHT+IGHhKo9c5AtTpQKNTjkcrFJNI2zewmyKWVlCUKLlnEWNciGV9FDNNLleEjBiTNlHslmazkOwQ==
X-Received: by 2002:a17:902:e5c1:b0:1f9:d7f9:aac4 with SMTP id
 d9443c01a7336-1fadbc748f7mr1171095ad.23.1719642310632; 
 Fri, 28 Jun 2024 23:25:10 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1fac1539438sm25967315ad.161.2024.06.28.23.25.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jun 2024 23:25:10 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 29 Jun 2024 15:24:47 +0900
Subject: [PATCH 4/4] net/vmnet: Drop ifdef for macOS versions older than 12.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240629-macos-v1-4-6e70a6b700a0@daynix.com>
References: <20240629-macos-v1-0-6e70a6b700a0@daynix.com>
In-Reply-To: <20240629-macos-v1-0-6e70a6b700a0@daynix.com>
To: Cameron Esfahani <dirty@apple.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
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

macOS versions older than 12.0 are no longer supported.

docs/about/build-platforms.rst says:
> Support for the previous major version will be dropped 2 years after
> the new major version is released or when the vendor itself drops
> support, whichever comes first.

macOS 12.0 was released 2021:
https://www.apple.com/newsroom/2021/10/macos-monterey-is-now-available/

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 net/vmnet-host.c    | 24 +-----------------------
 net/vmnet-shared.c  | 13 -------------
 net/vmnet-bridged.m | 13 +------------
 net/vmnet-common.m  |  3 ---
 4 files changed, 2 insertions(+), 51 deletions(-)

diff --git a/net/vmnet-host.c b/net/vmnet-host.c
index 1f95f7343a12..49fb25c224e4 100644
--- a/net/vmnet-host.c
+++ b/net/vmnet-host.c
@@ -21,31 +21,13 @@
 static bool validate_options(const Netdev *netdev, Error **errp)
 {
     const NetdevVmnetHostOptions *options = &(netdev->u.vmnet_host);
-
-#if defined(MAC_OS_VERSION_11_0) && \
-    MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_11_0
-
     QemuUUID net_uuid;
+
     if (options->net_uuid &&
         qemu_uuid_parse(options->net_uuid, &net_uuid) < 0) {
         error_setg(errp, "Invalid UUID provided in 'net-uuid'");
         return false;
     }
-#else
-    if (options->has_isolated) {
-        error_setg(errp,
-                   "vmnet-host.isolated feature is "
-                   "unavailable: outdated vmnet.framework API");
-        return false;
-    }
-
-    if (options->net_uuid) {
-        error_setg(errp,
-                   "vmnet-host.net-uuid feature is "
-                   "unavailable: outdated vmnet.framework API");
-        return false;
-    }
-#endif
 
     if ((options->start_address ||
          options->end_address ||
@@ -71,9 +53,6 @@ static xpc_object_t build_if_desc(const Netdev *netdev)
                               vmnet_operation_mode_key,
                               VMNET_HOST_MODE);
 
-#if defined(MAC_OS_VERSION_11_0) && \
-    MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_11_0
-
     xpc_dictionary_set_bool(if_desc,
                             vmnet_enable_isolation_key,
                             options->isolated);
@@ -85,7 +64,6 @@ static xpc_object_t build_if_desc(const Netdev *netdev)
                                 vmnet_network_identifier_key,
                                 net_uuid.data);
     }
-#endif
 
     if (options->start_address) {
         xpc_dictionary_set_string(if_desc,
diff --git a/net/vmnet-shared.c b/net/vmnet-shared.c
index 40c7306a758a..4726b072536f 100644
--- a/net/vmnet-shared.c
+++ b/net/vmnet-shared.c
@@ -21,16 +21,6 @@ static bool validate_options(const Netdev *netdev, Error **errp)
 {
     const NetdevVmnetSharedOptions *options = &(netdev->u.vmnet_shared);
 
-#if !defined(MAC_OS_VERSION_11_0) || \
-    MAC_OS_X_VERSION_MIN_REQUIRED < MAC_OS_VERSION_11_0
-    if (options->has_isolated) {
-        error_setg(errp,
-                   "vmnet-shared.isolated feature is "
-                   "unavailable: outdated vmnet.framework API");
-        return false;
-    }
-#endif
-
     if ((options->start_address ||
          options->end_address ||
          options->subnet_mask) &&
@@ -76,14 +66,11 @@ static xpc_object_t build_if_desc(const Netdev *netdev)
                                   options->subnet_mask);
     }
 
-#if defined(MAC_OS_VERSION_11_0) && \
-    MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_11_0
     xpc_dictionary_set_bool(
         if_desc,
         vmnet_enable_isolation_key,
         options->isolated
     );
-#endif
 
     return if_desc;
 }
diff --git a/net/vmnet-bridged.m b/net/vmnet-bridged.m
index 76a28abe793c..a04a14fa11e4 100644
--- a/net/vmnet-bridged.m
+++ b/net/vmnet-bridged.m
@@ -88,15 +88,6 @@ static bool validate_options(const Netdev *netdev, Error **errp)
         return false;
     }
 
-#if !defined(MAC_OS_VERSION_11_0) || \
-    MAC_OS_X_VERSION_MIN_REQUIRED < MAC_OS_VERSION_11_0
-    if (options->has_isolated) {
-        error_setg(errp,
-                   "vmnet-bridged.isolated feature is "
-                   "unavailable: outdated vmnet.framework API");
-        return false;
-    }
-#endif
     return true;
 }
 
@@ -115,12 +106,10 @@ static xpc_object_t build_if_desc(const Netdev *netdev)
                               vmnet_shared_interface_name_key,
                               options->ifname);
 
-#if defined(MAC_OS_VERSION_11_0) && \
-    MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_11_0
     xpc_dictionary_set_bool(if_desc,
                             vmnet_enable_isolation_key,
                             options->isolated);
-#endif
+
     return if_desc;
 }
 
diff --git a/net/vmnet-common.m b/net/vmnet-common.m
index 295828348501..30c4e53c1368 100644
--- a/net/vmnet-common.m
+++ b/net/vmnet-common.m
@@ -47,11 +47,8 @@
         return "buffers exhausted in kernel";
     case VMNET_TOO_MANY_PACKETS:
         return "packet count exceeds limit";
-#if defined(MAC_OS_VERSION_11_0) && \
-    MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_11_0
     case VMNET_SHARING_SERVICE_BUSY:
         return "conflict, sharing service is in use";
-#endif
     default:
         return "unknown vmnet error";
     }

-- 
2.45.2


