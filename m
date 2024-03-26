Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4638ECD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:40:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp72N-0007fi-2B; Tue, 26 Mar 2024 09:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rp72I-0007a2-WB
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:40:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rp72F-0005BF-9V
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711460414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZLHU20NRBQ76xezXp9bkU7y0kQWcZN7heXquiWWVeRM=;
 b=NhBVH5LOrSdU32m/T4fTKJLIMi8+++RM1y7Fj2FAD0Ts2yUBrwuHyWgCNFfFZ0b+gdVHS/
 sDyBmGN8JzC3n7uBR6JdF0SiwAKgjnTYWWcmbeJVAeWqwCbfVbr7ARmynbK3dtfQrXvgvh
 DbqxWdxH/+2cGezIiWQTf2TZtRbRh9c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-qEiSwiSRMAurawsKK9DbKg-1; Tue, 26 Mar 2024 09:40:12 -0400
X-MC-Unique: qEiSwiSRMAurawsKK9DbKg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4147e733d20so16595045e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 06:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711460410; x=1712065210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZLHU20NRBQ76xezXp9bkU7y0kQWcZN7heXquiWWVeRM=;
 b=GeepkuXlKhQOFWKcPRKjo/hUcLq/Od7SUKYDlkVxLP37xmwVH8M6isXkeS0kJ4YHwZ
 MUnuKjo52FXz2SwCqfcyXv/n77DPAzGduTSchLZANQGzsPfxzBkVHe1L+7t0KnVBDK2g
 NlOfs+WkvwXU0idnacPMGV1tSxQjXBAgFBMHd5mhGOMr8VMmB3OiGfXNmMfkio/w5B8b
 MJ8bwMOKDqOA9RIGROcSOJnT974uYf8ts+q9TY7VPj88+4TmB9jgUBy+iJHCFrInRTq5
 H/tmM+IfjHmGaNmqhTX1VeUvPYFXuyV0C75l3Yy+P1H85JJ+IOReNttYhLt1mNBio0jU
 deig==
X-Gm-Message-State: AOJu0YyPqevpufPWzl1Le9phBrjCjrysxlGtLNWImFx7euhB8IaWvGCH
 AtBQHVIxkjxcyCr6H+v+Z4JBoBfKJpkeCIfizBcpVSv4OlaygcSjpl+ihCG7gUvjKoFyO3lP+eP
 oirlP6Xb3IhthskjeAp1KxSU/d3j/V6X6JyoMvkiAyqXlntyTt65HbI85C2xgDghbttudNrMO9Q
 n4Mw3JZoUh5AIX8v8WpZRGSdP8TgDQLuCBZ4za
X-Received: by 2002:a05:600c:1f84:b0:414:80c0:d352 with SMTP id
 je4-20020a05600c1f8400b0041480c0d352mr7884414wmb.23.1711460410522; 
 Tue, 26 Mar 2024 06:40:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvK8Z+IcoZI8+ejYdJnPU9jAHSxe72Y/bKpOGH6fRPBbYkySktCd2ZmilnC6fQc8G6bgJS7w==
X-Received: by 2002:a05:600c:1f84:b0:414:80c0:d352 with SMTP id
 je4-20020a05600c1f8400b0041480c0d352mr7884374wmb.23.1711460410212; 
 Tue, 26 Mar 2024 06:40:10 -0700 (PDT)
Received: from step1.redhat.com (host-87-12-25-33.business.telecomitalia.it.
 [87.12.25.33]) by smtp.gmail.com with ESMTPSA id
 b22-20020a05600c4e1600b004148ff6ef54sm1318659wmq.29.2024.03.26.06.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 06:40:09 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, gmaglione@redhat.com,
 Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Hanna Reitz <hreitz@redhat.com>, stefanha@redhat.com,
 Coiby Xu <Coiby.Xu@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, slp@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Brad Smith <brad@comstyle.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH for-9.1 v2 06/11] vhost-user: enable frontends on any POSIX
 system
Date: Tue, 26 Mar 2024 14:39:31 +0100
Message-ID: <20240326133936.125332-7-sgarzare@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326133936.125332-1-sgarzare@redhat.com>
References: <20240326133936.125332-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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
index e8e1661646..b8a59b9e90 100644
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


