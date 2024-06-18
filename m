Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4E72C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 10:05:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJViB-0003rM-KG; Tue, 18 Jun 2024 06:05:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJVi8-0003mJ-NT
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:05:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sJVi5-0001Hq-Oo
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 06:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718705104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pp5ZUnNz+rNIrlfHLcPwbuNGbQD2zU63dazbFM6gki4=;
 b=Ll8Erg7wCkOnHvy4b1AULX3OG4IFHus8caHszIS+3wlmCrtauVXWW4c8Wi9p7saKT5IQic
 B5HgguOekhVYMOfnE3Goxv1+5CaShfsesaDmsXW/OVzsL+tmwkkQj0RTMEz3kD84uj7Ck0
 KJOnVgafFmR8avjuJf0SiDWJaGnc3Mk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-958x5cM8McOP4vAH9wB2dw-1; Tue, 18 Jun 2024 06:05:02 -0400
X-MC-Unique: 958x5cM8McOP4vAH9wB2dw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-421e17ae038so39569055e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 03:05:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718705101; x=1719309901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pp5ZUnNz+rNIrlfHLcPwbuNGbQD2zU63dazbFM6gki4=;
 b=McvAM6/AyddfTFNCUdooWx/pkoXvu/yRlc8fQUQGPvKF+AwiMJ/F1ZtwhpckNw3dFh
 hqz5eVRdHYZ1qTDZhDXsq2HiBPQCEec6OB8djtz/mof6YEiI8tl0npJznrZcloT2hfci
 L+p3yI4+ANvJfIhSBnfhiYNGtNlZErBcRg0hYV0OvxNI44GHgGGRX2KJhD4jcWzg2tjs
 LPFOs/vumn4cA+a7Hk5sKaX4bHcdNbcnwBqgnbAz8bv6XsmbRbSIZHgYPyJ/fdC+8YM+
 S5dXgoWUt8WzScyqBNaSP1OQf2cwiTaKT0Kw0CeMMNRaFiF81qAOM4bJ3MIiZOdIWInA
 cdEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb2RqHavs9GfCSFRaHWOBUCXrTpwT3Wn7ZdkjheXtRi8B1WgCN0Ma8P4DyoxRNmcK22CnrXPvsvIOrYWJs5nG84k0vxlk=
X-Gm-Message-State: AOJu0YzVUT78PUpWcAxLpIEWk+QbbNXydh9Kgaut20XeGPltJj28Iz1G
 pkb6UzoRb1btqOCnIBhJgUYpS5RV8DiW6IlbtyUkiknD/kFiS1vE3OT23Kyan53bzVE4+zFWOXU
 NuJu6+0Uod0ircVLVJ6Ru1RBj3G5gyWIeh7J/+C8LKs4Cfqo1rvt9
X-Received: by 2002:a05:600c:154d:b0:421:8028:a507 with SMTP id
 5b1f17b1804b1-4230482b872mr79833525e9.18.1718705101609; 
 Tue, 18 Jun 2024 03:05:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeuNQflOeD45AxbnD6s/40Ybo2KWrQFi6pETp60VQUIo3zbgsA9sIzpjjUDDJUkpTL9WDPnA==
X-Received: by 2002:a05:600c:154d:b0:421:8028:a507 with SMTP id
 5b1f17b1804b1-4230482b872mr79833145e9.18.1718705101190; 
 Tue, 18 Jun 2024 03:05:01 -0700 (PDT)
Received: from step1.redhat.com ([193.207.160.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422a1e68d04sm200747465e9.36.2024.06.18.03.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 03:04:59 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Brad Smith <brad@comstyle.com>,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Laurent Vivier <lvivier@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, slp@redhat.com, gmaglione@redhat.com,
 Igor Mammedov <imammedo@redhat.com>, stefanha@redhat.com,
 Raphael Norwitz <raphael@enfabrica.net>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v8 08/13] vhost-user: enable frontends on any POSIX system
Date: Tue, 18 Jun 2024 12:04:55 +0200
Message-ID: <20240618100455.145733-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618100043.144657-1-sgarzare@redhat.com>
References: <20240618100043.144657-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index 97e00d6f59..2ba95a8c35 100644
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
2.45.2


