Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B2AC5478C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:49:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIQp-000476-9Z; Wed, 28 Feb 2024 06:49:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfIQm-0003rm-D9
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:49:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rfIQf-0003nT-Lr
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709120932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SuW2yr1ErTnpygHzGqWIClqySdaMuavIYT9oyHG6O0E=;
 b=VHCCsM4DOnp8txzcAg+zCnDO+NKrJWzj4k8gQm9WGlvU2NCg8telFryh+5/4KCas576rlu
 7rMlI/aCoEp3FmdVPF7jy9Pu/ZaUzAowcHO452AKE+0caJfSmNdpS5guXPwbiurOVFnzdq
 50rp3Rfly//IFQCgmsIMs5WWuiTWs5g=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-SnIwnUTWNAOS4BwXfGZkeA-1; Wed, 28 Feb 2024 06:48:51 -0500
X-MC-Unique: SnIwnUTWNAOS4BwXfGZkeA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-787ac304610so623434985a.2
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:48:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709120930; x=1709725730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SuW2yr1ErTnpygHzGqWIClqySdaMuavIYT9oyHG6O0E=;
 b=QScqqvGRZLLkzw1MhRqtQz7h48Kn3vVbq0PVrQaPvHgOxoUJxPmJ1yGB5vUBKWDTYK
 nHhasWB7lh0dqZpSYuyZDnacc61zfCdlNxFn7LJSwE0pYnmhgaEjiHifuVoypqsFUqxD
 dAHE4ziUZiq4BOXEhXERrKqW5VnzEhXiwy6A5rcQzxGX0Sy649Ncgsyh+6Z0MxhE7NlF
 KHFBQvdV0G0IsGw79yjyo9TB7Fw8gWjg0Uryy0oqKjI/21a7BsWSEaT1ozB3dL6irO/K
 evR1k5wskVUBN9Pw2QT5CdJW2u0/Q3V4KXsgkJMOqmlhTUt590lIp0ZhZYMDRJXKbJtF
 CxsA==
X-Gm-Message-State: AOJu0YxKwQeUuUvdu6b1HIyosMahyRuryGr6DN0RNsuFzgneqg32awuF
 oFx97y+cXqywarHWl0Yx8TywjpA+n9bexKywKoTUjBcFjoJrI+4ZAL4awb7oFgxv5L02jNXsBDs
 V1u7oJqHtPFeJVb/6F8pObco5Vh/lQBzDrcJWGO8PDHtV9xRc9nJN/VYHutZBubpgppc7nvtLqT
 X2qO22bkGBx7p6q5z+fPyhKiXjH4kruMQzdtq6
X-Received: by 2002:a05:622a:1b9f:b0:42e:58c6:bc9e with SMTP id
 bp31-20020a05622a1b9f00b0042e58c6bc9emr14402109qtb.60.1709120930260; 
 Wed, 28 Feb 2024 03:48:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSD7p68tHuqEcO9TQtrqscvTt0IR5KWQZFI7nOUE+yM97FuOub0zEb4zMVUezJpGvEmZPRRg==
X-Received: by 2002:a05:622a:1b9f:b0:42e:58c6:bc9e with SMTP id
 bp31-20020a05622a1b9f00b0042e58c6bc9emr14402075qtb.60.1709120929907; 
 Wed, 28 Feb 2024 03:48:49 -0800 (PST)
Received: from step1.redhat.com (host-82-57-51-64.retail.telecomitalia.it.
 [82.57.51.64]) by smtp.gmail.com with ESMTPSA id
 df24-20020a05622a0ed800b0042e5da69d93sm4520029qtb.1.2024.02.28.03.48.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Feb 2024 03:48:49 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Coiby Xu <Coiby.Xu@gmail.com>, slp@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Raphael Norwitz <raphael@enfabrica.net>, Kevin Wolf <kwolf@redhat.com>,
 David Hildenbrand <david@redhat.com>, stefanha@redhat.com,
 gmaglione@redhat.com, Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 6/9] vhost-user: enable frontends on any POSIX system
Date: Wed, 28 Feb 2024 12:47:56 +0100
Message-ID: <20240228114759.44758-7-sgarzare@redhat.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228114759.44758-1-sgarzare@redhat.com>
References: <20240228114759.44758-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
If we want to be more conservative, maybe we can leave `have_vhost_user`
auto only on linux. I removed it more to test with CI if we have any
problems in the other POSIX systems.

In hw/net/vhost_net.c maybe we can just do:
 #ifndef VHOST_FILE_UNBIND
 #define VHOST_FILE_UNBIND -1
 #endif

Any suggestion?

Thanks,
Stefano
---
 meson.build        | 1 -
 hw/net/vhost_net.c | 8 +++++++-
 hw/block/Kconfig   | 2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 0ef1654e86..462f2d7593 100644
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
index e8e1661646..346ef74eb1 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -34,8 +34,14 @@
 #include "standard-headers/linux/virtio_ring.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/virtio-bus.h"
-#include "linux-headers/linux/vhost.h"
 
+#if defined(__linux__)
+#include "linux-headers/linux/vhost.h"
+#else
+#ifndef VHOST_FILE_UNBIND
+#define VHOST_FILE_UNBIND -1
+#endif
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
2.43.2


