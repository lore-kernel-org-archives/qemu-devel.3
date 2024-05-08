Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D355C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 07:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4bzz-0003w1-Fv; Wed, 08 May 2024 03:45:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s4bzq-0003br-BS
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1s4bzl-0000zs-Pm
 for qemu-devel@nongnu.org; Wed, 08 May 2024 03:45:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715154345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UTRHyTyXKiahujrFXbpPQFmYDHPg3542Nh2vIJCWy60=;
 b=NVxtrKhoQxISIxjLMNCMB8JJRiwSDIU6cDdyMvRi21TtyKZs5kEH3bcUCsWoeDaRxtAFXW
 SDjsd56AH9Az9uUH9zik4Wc6rQaEftfhlBcokAO1V+Q7tTrasebjN/Gfo30F4Yiy2pd5DJ
 ntvEGsKKdcOP/G1Rgz/tFwHU8RoQvrY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-GfflmaO8N5uDBU-nkb6cQw-1; Wed, 08 May 2024 03:45:43 -0400
X-MC-Unique: GfflmaO8N5uDBU-nkb6cQw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a59ad2436f8so314275866b.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 00:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715154338; x=1715759138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UTRHyTyXKiahujrFXbpPQFmYDHPg3542Nh2vIJCWy60=;
 b=Vwhv9qlh1Ckc/lGE/0Bw+ZydpC5bgvZ4awvPVg01z9W19R99XQGKLDnAVvNV9xc3J9
 2U9F9/KPU2qSRsPc7GDUJTqF/5guDBdRlnvp65tvsFa8Nq0rrzJvtWTMy8QYxZK3zQzh
 40gfyKr1aoWWxTw1yQlZVr7F3cx6Ugr1ad+H6qB5o8rupMfawwnz5yAeQUnTfODCLluh
 Nx6PV19Bv6GmfWgsJFiabzGNMRWIRzKydHJZZmaHmpq+qxr22OUoYxMzNmnmjeXU2jve
 KWeIaYGSrsFxHAO/HEm7qQrTBhlDeu3V5MUsXBL9wBzkbRwm0LhAX/oYV8x5zJcncoKN
 XP7Q==
X-Gm-Message-State: AOJu0YyfCb56FKXZjsYorftUG27CVkWnN0NmXM9kNAZewEg7zuMtBjcN
 Kvtrj2vKyRIfNWjaDo/gaykVYJ6Fdq4E9fcBoy40XhVRA5EiJIBsmdTzpBQsfvq4JqIgkUJQX6h
 bJ3p6KpJQ2faXLwvqmHUpvvngvbl35Mg8sZEP3AKlCKknPuXRtkRq1KoTnRafOvZ/c5cSM+qePJ
 nEX+PPRO5vgMbhS+mK21KEO8SxXjaq+Z6sn3F5
X-Received: by 2002:a17:906:f919:b0:a51:8d60:215a with SMTP id
 a640c23a62f3a-a59fb95a4e8mr100174866b.27.1715154337886; 
 Wed, 08 May 2024 00:45:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCJloW+tlX1rdN71yJ2zslkMrWJlodATZZ5ms7JnKp+2p1sbtuQcShHuTFTLI9XSpoHaSE5Q==
X-Received: by 2002:a17:906:f919:b0:a51:8d60:215a with SMTP id
 a640c23a62f3a-a59fb95a4e8mr100171466b.27.1715154337526; 
 Wed, 08 May 2024 00:45:37 -0700 (PDT)
Received: from localhost.localdomain
 (host-87-12-25-56.business.telecomitalia.it. [87.12.25.56])
 by smtp.gmail.com with ESMTPSA id
 kf6-20020a17090776c600b00a599a97a66fsm6032444ejc.55.2024.05.08.00.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 00:45:36 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, Eduardo Habkost <eduardo@habkost.net>,
 Thomas Huth <thuth@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, gmaglione@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, stefanha@redhat.com,
 David Hildenbrand <david@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 07/12] vhost-user: enable frontends on any POSIX system
Date: Wed,  8 May 2024 09:44:51 +0200
Message-ID: <20240508074457.12367-8-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240508074457.12367-1-sgarzare@redhat.com>
References: <20240508074457.12367-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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
index 43da492372..955921dcb8 100644
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
2.45.0


