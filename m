Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7F760A5BE3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Pw/tFldm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJtAF-0002Dj-AU; Thu, 22 Oct 2026 09:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xJt9W-0000Ur-KV
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:48:20 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <timpambor@gmail.com>)
 id 1xJt9R-00057Z-Rq
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 09:48:15 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48afbd2c386so1284262f8f.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 06:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792676888; x=1793281688; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R+NRdMT+YYqh7tZtf4wG6rEoxejvaUdHqjhlq1eRRiU=;
 b=Pw/tFldm65smK/ZB2nFP7p/Fjkw9Yk9tBVBvVp7wl36Nor3a76ISKcpkrrdU1pDQFm
 aw3O+8OyNff1JA7ht1tzNDV8PInDaQ1/Uiw/gdJ3FP/Dpvkrqd/Q7PkoqxcnaTW62xi0
 46DHHXY3nyX7Yd/dm7KRkauRNHcCsFJYK69ZDZibpswR4i9QPKX5MBHsoTGwyxZdTagP
 Dtfgm0NAT3kGueaeh19kEI4v5icrwJbne54Ztz7kGa3rHkUfMN2WZs3x9Eq0gfBjXyS0
 RORciiWUUtuDttEcpeBRes7OJCvSc9d8UghRVUwZQ7uxZeavxvFRaC+Rj+kF3pIm5yio
 ER6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792676888; x=1793281688;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R+NRdMT+YYqh7tZtf4wG6rEoxejvaUdHqjhlq1eRRiU=;
 b=HzCv19t12IbYgRGUY83VYwPoOhsSM+ObRmIJXVFLJD+F+00fDV7nI5ILGejiqNjiI1
 vgk/ZCbadhMcflYlGVy9//kZuCxFygbGj2wC0MDdGVJgVndFNRKGCXR+kfn/iWvbRmIN
 V1rZUTyjOu1YyyQriXzNoyi3hOFVj8RRhxf/XZ5vkkYNx9nRrlDlOdRKdh0/uc/uPpRo
 ySDiDuFYUYbb1MSg7Vi2WmcyRy5k3ubGmiPBNKI4JrDKO7tAdcYi1pjANLc5Rm4uG0tJ
 aBu4ZRMRgoGQhRL/zvyKAmU62VKhlroMlwr3SilyJfcBFNp9jgSnBww4fOi8W/1OJlKP
 2kiw==
X-Gm-Message-State: AFq9FYI1pScNcE/VMmKCqniNz1FChHG9ix6Ly+A4Td15SnexowVUY4sz
 8M1YULRohu50NJAAvKm8yZu9IqUQuJsH++BdeRyw48ghpkNmxk6Rqy2k
X-Gm-Gg: AYBFou0Xg3vpYJZP0JHSSt7k271gMPfvxRTf0iV9SMX868Km+xUfWScosj3NXoPTQwk
 8iK19UIzOtVi/dvnojWgsSzNXkOlfX9JO9s7Njc9CMIoDXXxS0GCQfIttrzcmAICnKqHaVssTVO
 9/GQWbP+q3hN+tMLZ7JG3Er8i0tsl9lcbmW9eWZbE427JX7UqYbXRaED4lUoYBxt7HYTXTbwjwU
 PuvYzlUUwRzADct15V6jfu9FWvzppInlECx838Uv/Hnz6XTV7Zks0VXQQQSsz4utsjL1EgUYn0S
 7rao1ABWueMGg7NglqnA+rZYccC8Vn7LOjCV7TFGeoRy3fVcaE31gSzncwaI8+iBGkXsewFycV5
 dvMqOkqv2pLN9RUlIatnOOnyiju+owpJpQJtcbLmJWn/dmA0E/DsFyYP1Gz3nyt8ZamoW1t+cge
 JwE9HxE2KHzMiul8B5GXQf1lgVHY43j1gGjwD+p19hFiYz6kxG20gtbVAB5wT5cligIgSd9GsIf
 haK2+LIVxxnoTkONOZIxR4+lTbCer2LuiFSWxaxyYZGObZ9LiP9a63mYdZfypD1yxpoJeo4RRxq
 1tuInL6L7or+1y3Y9awx5pfZY+SW33zlEfBcZspYbE51S+hSMoh+ff05lgoaKdtDzR5Ve6dFNgh
 T91DhhNxkIg==
X-Received: by 2002:a05:6000:2689:b0:48e:3fc:e393 with SMTP id
 ffacd0b85a97d-48e26423766mr12010947f8f.6.1792676885810; 
 Thu, 22 Oct 2026 06:48:05 -0700 (PDT)
Received: from tim-m2.local
 (dynamic-2a02-3100-5a78-7100-00df-217a-667a-8b0a.310.pool.telefonica.de.
 [2a02:3100:5a78:7100:df:217a:667a:8b0a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e254ef1bfsm13120414f8f.6.2026.10.22.06.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 06:48:05 -0700 (PDT)
From: Tim Pambor <timpambor@gmail.com>
Date: Thu, 22 Oct 2026 15:47:26 +0200
Subject: [PATCH 5/8] vhost-user: enable frontends on any POSIX system
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-vhost-user-posix-v1-5-0bd4d450d23c@gmail.com>
References: <20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com>
In-Reply-To: <20261022-vhost-user-posix-v1-0-0bd4d450d23c@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-block@nongnu.org, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Brad Smith <brad@comstyle.com>, 
 Tim Pambor <timpambor@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 David Hildenbrand <david@kernel.org>
X-Mailer: b4 0.16.0
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=timpambor@gmail.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Signed-off-by: Tim Pambor <timpambor@gmail.com>
---
 hw/block/Kconfig   | 2 +-
 hw/net/vhost_net.c | 6 ++++++
 meson.build        | 1 -
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/block/Kconfig b/hw/block/Kconfig
index 737dbcdb3e..7edcd7a8f6 100644
--- a/hw/block/Kconfig
+++ b/hw/block/Kconfig
@@ -28,7 +28,7 @@ config VHOST_USER_BLK
     bool
     # Only PCI devices are provided for now
     default y if VIRTIO_PCI
-    depends on VIRTIO && VHOST_USER && LINUX
+    depends on VIRTIO && VHOST_USER
 
 config SWIM
     bool
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 6e05c995f1..788913953d 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -33,7 +33,13 @@
 #include "standard-headers/linux/virtio_ring.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/virtio-bus.h"
+#if defined(__linux__)
 #include "linux-headers/linux/vhost.h"
+#endif
+
+#ifndef VHOST_FILE_UNBIND
+#define VHOST_FILE_UNBIND -1
+#endif
 
 void vhost_net_get_features_ex(struct vhost_net *net, uint64_t *features)
 {
diff --git a/meson.build b/meson.build
index b67a97ab45..eb296346a8 100644
--- a/meson.build
+++ b/meson.build
@@ -221,7 +221,6 @@ have_tpm = get_option('tpm') \
 
 # vhost
 have_vhost_user = get_option('vhost_user') \
-  .disable_auto_if(host_os != 'linux') \
   .require(host_os != 'windows',
            error_message: 'vhost-user is not available on Windows').allowed()
 have_vhost_vdpa = get_option('vhost_vdpa') \

-- 
2.55.0


