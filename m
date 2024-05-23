Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306A3C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 14:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9rx-0002nM-OC; Thu, 23 May 2024 10:56:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sA9rw-0002mh-Ae
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:56:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sA9rt-00042J-Qs
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716476192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Qg0j+YK7VRBZmAY9zpmey1/lx7IRhJZZvR9stxcVsk=;
 b=fWt8z2YcMxRFV1BrAVeXMLRsm42tq1UxU19t5R5/wRfg5gaQa9kp/EK1UwPdUsfiNztRPq
 71iqFLslRx8SGwMdUsqqOwg0wq/skrTakfHqrNap9fArXgLW6u2AcE5rQQz0qAb3RXKMQn
 RztEp7R4+jqy4wUOI679LMzDvsg+fns=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-o5hEtvDgNWKAzxev31ZE9Q-1; Thu, 23 May 2024 10:56:31 -0400
X-MC-Unique: o5hEtvDgNWKAzxev31ZE9Q-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-24540b99e23so1682882fac.2
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 07:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716476189; x=1717080989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Qg0j+YK7VRBZmAY9zpmey1/lx7IRhJZZvR9stxcVsk=;
 b=FeAfdfkcjwV1ceBifnlZM4vOFDkpwAEFif9ybTUsMlYC+PB5TM8N2vDRDXfwJMr7EL
 dcBtBtblgDnJeBiGWekOsqm7j2FW4K5N4EcAHKrcewsjfEcORlyOcjd0PFPIvyWsAI+B
 MZ/tphfVP2Kk0fSZg4flcjPgIL/KcMs1yVLiWH07cG6U0yUHlyMzYFBPN0GlAnzMSwcW
 DPXmbTFPpP4+E4hjfrnOtESIROe3c3swOpp8gHRqEyzlvPQM90CPoFlf3ydQXapn2yY2
 9y76C/q8lBAeZOOjRJyahWWStEGvsA/BJqiqnaj7Hwz7ubC7BvKv0EDt2bizFlpbIRKq
 KsYQ==
X-Gm-Message-State: AOJu0Yy4tEtB/lstU0zDg9HfBHmHlJ1oxHeTq6sbhth9Z7UM0CKnekt5
 y/UtNacifaY5aw6Ost1ZGZN82AQ9T5JAjUmSHB+6ARVd4rC2UqR7L4cyVdTuPFX9vP4lka/X4rv
 I2BZ4yCe5TPXigmzb8KFrKb+CNUmM4AEXuC9GD+ZLQ3XjUsiq34anIzfPDYjCj62k4zzh4j9RZL
 9lYtZYT4uVv58axbbPp9CywIevszZgGdsQPFps
X-Received: by 2002:a05:6871:5214:b0:245:4477:e9ed with SMTP id
 586e51a60fabf-24c68aa76d1mr7798614fac.17.1716476189022; 
 Thu, 23 May 2024 07:56:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEb6trD4nmHXJcjOEZGki5/Pkw4kzLac+sW4oiUM9BobY12st8spR+5ei897Gtpqi+R2K2DYA==
X-Received: by 2002:a05:6871:5214:b0:245:4477:e9ed with SMTP id
 586e51a60fabf-24c68aa76d1mr7798483fac.17.1716476187003; 
 Thu, 23 May 2024 07:56:27 -0700 (PDT)
Received: from step1.redhat.com (host-79-53-30-109.retail.telecomitalia.it.
 [79.53.30.109]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-43e046467a4sm168864281cf.83.2024.05.23.07.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 07:56:23 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Brad Smith <brad@comstyle.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, slp@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>, stefanha@redhat.com,
 Hanna Reitz <hreitz@redhat.com>, Raphael Norwitz <raphael@enfabrica.net>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, gmaglione@redhat.com,
 Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v5 07/13] vhost-user: enable frontends on any POSIX system
Date: Thu, 23 May 2024 16:55:16 +0200
Message-ID: <20240523145522.313012-8-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240523145522.313012-1-sgarzare@redhat.com>
References: <20240523145522.313012-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 meson.build        | 1 -
 hw/net/vhost_net.c | 5 +++++
 hw/block/Kconfig   | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index a9de71d450..5a6f7a36eb 100644
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
2.45.1


