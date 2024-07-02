Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A894C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeCs-0002YX-Rh; Tue, 02 Jul 2024 10:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCh-0001fR-4d
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeCY-0008R8-Ng
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2AGZP+nspE3HlB5tjeGIUHiwMrs8aGiCZ0Y1FdNl3gU=;
 b=cuDWcMhvu5qgMs2FhYSkJDYNWVxWMm3GUQFHd11jCwmgUSK0X21DekS7zY4w2ROg0y92jr
 RrtYx6U5UHuqwrithWFeteDGdXUh2odwEHnPiW1xrQ+YL5JX2AFyfTBkF+MJonCU/eHk5b
 FL9dojMZziMDsmQIuHbkxHzR+1V0drA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-FqzP7xG2NgWL7HdHs4tyEg-1; Tue, 02 Jul 2024 10:09:43 -0400
X-MC-Unique: FqzP7xG2NgWL7HdHs4tyEg-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ee4a63e95cso42568101fa.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929381; x=1720534181;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2AGZP+nspE3HlB5tjeGIUHiwMrs8aGiCZ0Y1FdNl3gU=;
 b=J+4vgGiom+PZ4gZgBzz4wVrVPbrNM1JJKVrtZ9CkjfeI9Vb47fJ3UP/9JC6VrGbWut
 /b4h4jRWm9KOvU8k9cMQligGC+MfAFnuXTpIuAbDqKmvWQa/jgCVyrNJ4AQWTUj5hPJM
 bgvYVfKYfybmWjNA1Fo2M8Xo2DhGQCzXTSACIlJsyDbXUL4mLG6dgh6AOVrKJvtQuB8e
 hreZPDLIlSV6+ZfBIjHl8onYnBdcF9T6ISA6Lpz+qZDi/fcGkLUFhSNBss8q09TBFnAH
 08vAz5MtzPOL+WNj1PLkCybp+nEmEbATpbzLytx0Ee2pOYFM4MMvGp03KPWPmLqHEID9
 q4ig==
X-Gm-Message-State: AOJu0Yxb7Z87Hui02lJDpEVTPbz3lHxefsF11SogDabHdaF8ZCHkEkO0
 kzfA+9EnrRL4JXlYsTHmFxV4X3w7rxf4QpkMcpbtNJaxbDFBX4latSSkG0idQAAohUYLoLfxZ8J
 e+DswLbIh1L4lCBuJsrMzZShmqDxZ5fRkFdYYReok74qlz4nJQQfoWee5HsW+Kr01VCZE4Njddm
 F6DWvV8NPKrHjJT77x3SWUvXxjisTEHA==
X-Received: by 2002:a2e:a910:0:b0:2ee:7b88:7f3 with SMTP id
 38308e7fff4ca-2ee7b880869mr253701fa.12.1719929381695; 
 Tue, 02 Jul 2024 07:09:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh5T6tlzwkVF81E+h4m6CYc6nyeXRZ3lFkO2Q0xNdE+EoVmKRQcH68EtN3LkWAR4NKoSxqNQ==
X-Received: by 2002:a2e:a910:0:b0:2ee:7b88:7f3 with SMTP id
 38308e7fff4ca-2ee7b880869mr253331fa.12.1719929381084; 
 Tue, 02 Jul 2024 07:09:41 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4258014f8b7sm105297925e9.41.2024.07.02.07.09.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:09:40 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:09:37 -0400
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
Subject: [PULL 53/91] vhost-user: enable frontends on any POSIX system
Message-ID: <7f2a913552148d1f553a67a6f9f92585d150b21c.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
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


