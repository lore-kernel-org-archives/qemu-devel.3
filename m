Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4006C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 20:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOjy8-0007We-7q; Tue, 02 Jul 2024 16:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjxk-0005O1-PF
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:18:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOjxg-0000xu-AX
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 16:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719951526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2AGZP+nspE3HlB5tjeGIUHiwMrs8aGiCZ0Y1FdNl3gU=;
 b=Eqz88XhDzL8hGCjzje2QwqAGb7cEcQwas82k5KO11atcv7OoWWm3MzZIxamKbX/yiFjYbJ
 0PTAlMZmv60rJAP7LmMM8c4q2Uv1QMfKkAHWdJmQTrLhMV/g8wQ6l6x8n3tjiRVoc6uvuf
 5EMWVR1qs9j8Eulod5xmw4aOmvsc7lY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-59ssbCAWM4uPWf9HAMm7GA-1; Tue, 02 Jul 2024 16:18:45 -0400
X-MC-Unique: 59ssbCAWM4uPWf9HAMm7GA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-364b75a8194so2826247f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 13:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719951524; x=1720556324;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2AGZP+nspE3HlB5tjeGIUHiwMrs8aGiCZ0Y1FdNl3gU=;
 b=vpkg/G+kgcRA7brQk661/XI0Mchq8TDoWnYDzkDfM9K5EzmIqNBXwp52fcrlQbsKhn
 w5NGKX5T8xAcjBUlCsYsuvRgWLAh0sn2oPMpeEiuMW/GYkBYcJQhO7r+M8+zCVMjBd55
 nlyhjIvuWlpIEhp6yVGwIovWlSAtDQ+l+zn621aBrgGPn5i/kM2snWY8n6haKp6k2uAw
 nNwXZPquSjYBVxxubQIunKshi+pQO95tlocrGEKN9RP8jI4IU1KUQIseJpXhhDrI8ZZ6
 yn58RNj7hPpXvnQWQjR/m/BhD7lourWsFtLoSvNHT3mnMEpmvE3PXuQcsNkskuLU9kay
 sp4Q==
X-Gm-Message-State: AOJu0Yw4hAlY038CHlxqkzfhCe3G4MR1qkFbU0yG3EkQgmuE026wGRj4
 ijgkjBPecO4phtBK+mKA2RK+fslmbLwMmMOksv+HuxrX/udMnCmpGilEUNwhegrzgv4YZhDSuvw
 u/qvfJsSBlxI1dzkd5RDPcXkQ0ZGb+JrNDScLEEKakYfyo3c94J1hb/w/mnuERZ09UQ04xL/QAj
 Mw8AiQuMz7iOsbYgnk7eij8hgRpnOEQg==
X-Received: by 2002:adf:f8d1:0:b0:367:2945:4093 with SMTP id
 ffacd0b85a97d-367756c78bfmr6092210f8f.40.1719951523966; 
 Tue, 02 Jul 2024 13:18:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHukgJDuPwp4wMumpwSv4FvW4uwl/PTn3JQzxdfVrzaHsV3IUtylXTEM/h8/Z8KPmDCgZnNyw==
X-Received: by 2002:adf:f8d1:0:b0:367:2945:4093 with SMTP id
 ffacd0b85a97d-367756c78bfmr6092186f8f.40.1719951523408; 
 Tue, 02 Jul 2024 13:18:43 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0d9b12sm14104428f8f.44.2024.07.02.13.18.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 13:18:42 -0700 (PDT)
Date: Tue, 2 Jul 2024 16:18:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
Subject: [PULL v2 53/88] vhost-user: enable frontends on any POSIX system
Message-ID: <00b78962ab2976bca9e2211fb5c42b5fc924cef5.1719951168.git.mst@redhat.com>
References: <cover.1719951168.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719951168.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Stefano Garzarella <sgarzare@redhat.com>

The vhost-user protocol is not really Linux-specific so let's enable
vhost-user frontends for any POSIX system.

In vhost_net.c we use VHOST_FILE_UNBIND which is defined in a Linux
specific header, let's define it for other systems as well.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20240618100455.145733-1-sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/vhost_net.c | 5 +++++
 hw/block/Kconfig   | 2 +-
 meson.build        | 1 -
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 18898afe81..d25b1bc839 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -34,8 +34,13 @@
 #include "standard-headers/linux/virtio_ring.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/virtio-bus.h"
+#if defined(__linux__)
 #include "linux-headers/linux/vhost.h"
+#endif
 
+#ifndef VHOST_FILE_UNBIND
+#define VHOST_FILE_UNBIND -1
+#endif
 
 /* Features supported by host kernel. */
 static const int kernel_feature_bits[] = {
diff --git a/hw/block/Kconfig b/hw/block/Kconfig
index 9e8f28f982..29ee09e434 100644
--- a/hw/block/Kconfig
+++ b/hw/block/Kconfig
@@ -40,7 +40,7 @@ config VHOST_USER_BLK
     bool
     # Only PCI devices are provided for now
     default y if VIRTIO_PCI
-    depends on VIRTIO && VHOST_USER && LINUX
+    depends on VIRTIO && VHOST_USER
 
 config SWIM
     bool
diff --git a/meson.build b/meson.build
index 54e6b09f4f..98db5ea322 100644
--- a/meson.build
+++ b/meson.build
@@ -151,7 +151,6 @@ have_tpm = get_option('tpm') \
 
 # vhost
 have_vhost_user = get_option('vhost_user') \
-  .disable_auto_if(host_os != 'linux') \
   .require(host_os != 'windows',
            error_message: 'vhost-user is not available on Windows').allowed()
 have_vhost_vdpa = get_option('vhost_vdpa') \
-- 
MST


