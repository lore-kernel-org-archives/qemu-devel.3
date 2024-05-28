Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA434C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 10:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBuBz-0004Tn-PD; Tue, 28 May 2024 06:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sBuBy-0004TD-EK
 for qemu-devel@nongnu.org; Tue, 28 May 2024 06:36:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sBuBw-0008Hu-Ht
 for qemu-devel@nongnu.org; Tue, 28 May 2024 06:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716892588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QWgDH/gDQAxyHJPRHaKd8r5IWyJMqj8jhSH9L5DHuSs=;
 b=PX8LnCiErlTqinScRaUxJbUH3BlwYdpHEsJ7pQYk+JdFq/v3195ijaQtkpvCVppLsKE15F
 AcABhGGKc72BDoCTfFu4npfhKoghUpY6JHZkGl90fUuSE6Z6aPo8yK9Gkpe+j3RYIFHHe5
 OP+y66aTnn5DTYBg8jxP4ZavGESLbM4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-zntWtRH7OmG4nZm3nBuyjQ-1; Tue, 28 May 2024 06:36:26 -0400
X-MC-Unique: zntWtRH7OmG4nZm3nBuyjQ-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5236c5cec7dso585586e87.2
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 03:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716892581; x=1717497381;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QWgDH/gDQAxyHJPRHaKd8r5IWyJMqj8jhSH9L5DHuSs=;
 b=Ti5dJFUZ2WPTZyvPL7wKr5Qg9OqZLSrFtdze4gMNUa6De0THuI4EWCTrIIdurThpoF
 56FWZ6x+we4r39+91LAOKvODLhkV4wY7f4M9tRvNf06wag+s4U8Tfjonjr+++wPhWLb9
 483SxBgfDl6xxVtaYDP6wifP3MQVgsGG9T9vkH1VB1v4SN3UdrM13bzs+lCO31xWPjiQ
 KkAiKu65b260QoSg5CtAHsYTpNmE3Vn/nKOkeSVj/I2DVCC84RizIOjiWvDYknz842e1
 uZWm+NXHXaRomY5IP19bQ1qn+eABdzKcuos5A6gq7c+9Jfzhsf2fD5YCD2L1Vf2bYXOa
 INCg==
X-Gm-Message-State: AOJu0Yz8z40rLyFrQJvBKUVGlDDDYpsYsFQJEQ8NLmMuCs2MpCvLhePs
 G8ebj4ybu6MG6pbpfEShQyYq4LEgLgyJiW5l05+vPWnmDIb2TF54AQHw61k9P6AKejI+baAvJmS
 uiaTplmod+sC+0ubLA0Sl45jYKN4JN9FB7VI2QQ5+0TLG9FDbRHwsQCSWso5rNFJT6s2ZP9mVPG
 EivGM8wUlSOey/GLpRwoyEIP+mg20F05O+w3u1
X-Received: by 2002:a05:6512:110a:b0:529:a6f6:1b03 with SMTP id
 2adb3069b0e04-529a6f61b4dmr8420657e87.14.1716892581512; 
 Tue, 28 May 2024 03:36:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkqFaQhWkWgum4f5hE8KsQlq89AehXAbjYzuR81wRF8t6iD1TeW8UNVZ+xnGtVO04DVyStDQ==
X-Received: by 2002:a05:6512:110a:b0:529:a6f6:1b03 with SMTP id
 2adb3069b0e04-529a6f61b4dmr8420621e87.14.1716892580988; 
 Tue, 28 May 2024 03:36:20 -0700 (PDT)
Received: from step1.redhat.com (host-79-53-30-109.retail.telecomitalia.it.
 [79.53.30.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42108966ce0sm137940055e9.8.2024.05.28.03.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 03:36:19 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: slp@redhat.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Igor Mammedov <imammedo@redhat.com>, Brad Smith <brad@comstyle.com>,
 gmaglione@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Thomas Huth <thuth@redhat.com>,
 stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v6 07/12] vhost-user: enable frontends on any POSIX system
Date: Tue, 28 May 2024 12:35:38 +0200
Message-ID: <20240528103543.145412-8-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528103543.145412-1-sgarzare@redhat.com>
References: <20240528103543.145412-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 meson.build        | 1 -
 hw/net/vhost_net.c | 5 +++++
 hw/block/Kconfig   | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/meson.build b/meson.build
index 6386607144..a72500be77 100644
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


