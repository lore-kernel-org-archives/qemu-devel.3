Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075ECCD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 12:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsM8f-0000pm-Cp; Thu, 04 Apr 2024 08:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rsM8b-0000pB-Nc
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:24:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rsM8Z-00011r-J3
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 08:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712233450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kzYc+J54vOGcpzVPbA08PRAO84CKwMnNUHeaTVFrt3k=;
 b=UvJyu64mjfqqnJ8CAraTqm0LC+QrsoyAA5b2cF/aU6H7XGvJRGlaEspEYk1ZauFzluBJnI
 6wZN9MhwEdBGbcg4Qzd/DhemE5HL9HA4HfLj3MXl0iLj98n3ubvuK7/L6zoGMnSTi1Yhvu
 X5EVE4zDJP4UTxlbgP4HJxlZ9IaXEno=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-TCQ1EZpnO_indoT5oAYsJg-1; Thu, 04 Apr 2024 08:24:09 -0400
X-MC-Unique: TCQ1EZpnO_indoT5oAYsJg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a46852c2239so60998966b.1
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 05:24:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712233447; x=1712838247;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kzYc+J54vOGcpzVPbA08PRAO84CKwMnNUHeaTVFrt3k=;
 b=M/MxXjryxY3p5c74CpOGw4QYYQ3ZSCh/24FWp8BCUeBgnkpL7FR3Kyxc4JDYifenYv
 wmpcJjRAssyZXktWUe0wp9AUdQ846vYFen8p8UJErKA/ujj9Kt9p7yc6PoLG2pDjnsz+
 I/CruF/84KyQCdTswjr2dwHcBONNeqyuWjc1YLl0+yCV4knq6acK7K3zoDiFJfNrgwKF
 ZsqbE9IKrgEo1CFYBVVFcCnLo5QGcys6cQkanf3fVsg3d0JN9LIsso2d2bA3cGCkJxcw
 APltttj5c/jV/vA66HZnRyf+sgg5og8tJhC6HvlbwPoFjowX+ti1cwFNaT8onzhOnnbO
 S+3Q==
X-Gm-Message-State: AOJu0YwqoxNP74lVBT0w6a0AoKaDR+BprksD9ySYqdS0uNYGpAdXCoLj
 LEN++mAQtJoIyoJgK1Pu4ZeVpKRU/DTY17xPxV29NE11QqhTKQorOBj3LQGlxgmtHo8PI9BJPan
 O6DvUwRkoq6OP+Z967lCEjeoBzQm0gZtIyz/FxqzB8RHnpDxhVVRwZTi+m5uOmgIDvFJRXFPbGu
 yUP1tIPpcVlbu1XQOMSiK3XL5U6US7d+coprNB
X-Received: by 2002:a17:906:94e:b0:a4e:4e8c:bedc with SMTP id
 j14-20020a170906094e00b00a4e4e8cbedcmr1437237ejd.53.1712233447566; 
 Thu, 04 Apr 2024 05:24:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA0DRjWjymIeLJkewZMdnq50nfbl8le8bp+v6WOjYoCk+nvvjtEE8qK6+sYbGLj04IY8W+AA==
X-Received: by 2002:a17:906:94e:b0:a4e:4e8c:bedc with SMTP id
 j14-20020a170906094e00b00a4e4e8cbedcmr1437206ejd.53.1712233447297; 
 Thu, 04 Apr 2024 05:24:07 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
 by smtp.gmail.com with ESMTPSA id
 r17-20020a170906705100b00a42f6d17123sm8943953ejj.46.2024.04.04.05.24.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 05:24:06 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Coiby Xu <Coiby.Xu@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 slp@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, stefanha@redhat.com,
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, David Hildenbrand <david@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, gmaglione@redhat.com,
 Jason Wang <jasowang@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH for-9.1 v3 06/11] vhost-user: enable frontends on any POSIX
 system
Date: Thu,  4 Apr 2024 14:23:25 +0200
Message-ID: <20240404122330.92710-7-sgarzare@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404122330.92710-1-sgarzare@redhat.com>
References: <20240404122330.92710-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The vhost-user protocol is not really Linux-specific so let's enable
vhost-user frontends for any POSIX system.

In vhost_net.c we use VHOST_FILE_UNBIND which is defined in a Linux
specific header, let's define it for other systems as well.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 meson.build        | 1 -
 hw/net/vhost_net.c | 5 +++++
 hw/block/Kconfig   | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index c9c3217ba4..c19d51501a 100644
--- a/meson.build
+++ b/meson.build
@@ -151,7 +151,6 @@ have_tpm = get_option('tpm') \
 
 # vhost
 have_vhost_user = get_option('vhost_user') \
-  .disable_auto_if(host_os != 'linux') \
   .require(host_os != 'windows',
            error_message: 'vhost-user is not available on Windows').allowed()
 have_vhost_vdpa = get_option('vhost_vdpa') \
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index fd1a93701a..fced429813 100644
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
-- 
2.44.0


