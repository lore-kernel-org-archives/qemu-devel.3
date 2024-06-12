Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986B7C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNdP-0006lb-Gb; Wed, 12 Jun 2024 09:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sHNdN-0006kT-UP
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:03:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1sHNdM-0008ER-BU
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:03:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718197403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W9nNY1euX5/uZx9rZmDV5gA5I22VILqEg+kz3/RnvbQ=;
 b=IMHSQGsRYQUMPysNYgjB3BYAjNf/p+jCQr89GV/1ZjEjhVFz+JvdkZCjCEzoqDJOno1vNB
 ADM6EtpOf7cNk8Cb6A8C+yJmd8nI/+ZC9h31GFT2cnd5HL5IS7pkhUM3dI4PlhZE45YcsX
 HzJKzOi4SRiY30n10bHf3YZpP/cHBa4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-0H2dSwAcMIaUN0o7OE7q_A-1; Wed, 12 Jun 2024 09:03:21 -0400
X-MC-Unique: 0H2dSwAcMIaUN0o7OE7q_A-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-795d19c522eso326860185a.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 06:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718197401; x=1718802201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W9nNY1euX5/uZx9rZmDV5gA5I22VILqEg+kz3/RnvbQ=;
 b=I42ryJ00RaHdnG0wtNJ84mcgGMqkkJLtKeVLuFZLoMztVVJ13wkj2n2//IQIlxqc2N
 nFSrbnn31C2q4E6LRKRG7bdJ7b5cDgEDgP0K/QuA61vUrLo38BubefT4w7iSmdsw1cey
 +3ASTApgIHhRXGHo1CKnHRO2HhHoPAU4Ro7liXwNe4xQeF4mgSkKW4OutWwrS205vUWj
 aYyCJFolo3XQGVfled5BZBZ2fNNDROSYo3Yc1dgwJEDU7f7nZr3x3N//kzeJL9Vx2MFC
 QlSY9tbWHV8S1rvVmkqfU2GbaD+bdK6uOxkBHW6QsB32tjUWKn1wOBVPj1Uk9oz9KNTs
 FYLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVS0evorTOs5Y53xiDQ3PQewMxxdgRDPw48sViNdPOxaAkv2z+tMWufHZoRB1bdkQOlDDrwGcRshKC3sQoGtli7VDXvu3o=
X-Gm-Message-State: AOJu0YyAmWR85ek4gI6ku5UzwKPC57OavG1fsUXfbJFNJnegPCyWQYKv
 N91QsndexxKOAHeS8T1nREBiha+R8glnsa3b95MLlRXkhPrimvJNThtv/9jbFBs85VEenWFflGm
 C+EpFloJ0JmizTSnUBYEnY0jNdVTDGrcjdBIedR3JfFMGdYnMRZlM
X-Received: by 2002:a05:620a:3193:b0:795:5de4:662e with SMTP id
 af79cd13be357-797f5f00567mr225193485a.12.1718197400668; 
 Wed, 12 Jun 2024 06:03:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFam35WX5YR7D+kjZ2CAmAzS8qpFT9IWRPbjmsn4XijrL6t7TgyWQU97gaGUhGnxegZzaDHPw==
X-Received: by 2002:a05:620a:3193:b0:795:5de4:662e with SMTP id
 af79cd13be357-797f5f00567mr225188285a.12.1718197400184; 
 Wed, 12 Jun 2024 06:03:20 -0700 (PDT)
Received: from step1.redhat.com ([193.207.132.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-797e8f4906bsm122609285a.80.2024.06.12.06.03.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 06:03:16 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Brad Smith <brad@comstyle.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, gmaglione@redhat.com,
 stefanha@redhat.com, Coiby Xu <Coiby.Xu@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, slp@redhat.com,
 Igor Mammedov <imammedo@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 David Hildenbrand <david@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH RESEND v7 07/12] vhost-user: enable frontends on any POSIX
 system
Date: Wed, 12 Jun 2024 15:01:35 +0200
Message-ID: <20240612130140.63004-8-sgarzare@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612130140.63004-1-sgarzare@redhat.com>
References: <20240612130140.63004-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
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
index ec59effca2..239044070f 100644
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


