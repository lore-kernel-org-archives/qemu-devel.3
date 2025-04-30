Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5B8C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 14:28:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA8P9-0001Yi-4F; Wed, 30 Apr 2025 10:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA8Od-0001FY-7O
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:27:00 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uA8Oa-00076q-VV
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 10:26:46 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4775ccf3e56so12835111cf.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 07:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746023201; x=1746628001; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YNiEylsO3oY9vgtqAxWvkDME/V5ix0NbPvey475+kvI=;
 b=McjjehhpwnwT2lp1ICgRWWUoIT07IYKapu8Ch1x58d0xpLufKDFc5HfI5iGHCAh22+
 tzcIRQnZqx3BUtWYyyl9A82lDcxvoUzom+2XJY6lCD5Pdm+P7OMXoGegx9oTbnxit11h
 NWN8X4fcbuWSbB/UcNImr1B9KGpZS4+5BpJESoqCJcV1h6XhZpERYkvhWj/7W43Sd+A2
 ifLVwVasGhpkGK3zIpGJLKimgBcQazHNBWK5L7uv9fW2XUxg5AGBg+gPE1k5fe/UQyMt
 +8MraCjD5mzLp0XswsRIoHLBRvxOgUWBIf1HEOt2aulS+favnTmKiL19wcbd8wYXC5gF
 G6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746023201; x=1746628001;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YNiEylsO3oY9vgtqAxWvkDME/V5ix0NbPvey475+kvI=;
 b=ILHvFtYxbulEahaPXm3tjBDI9yMYA5eQK9bFLnFpFzdBsLCr7LUUCpR9T7oXj+zWDT
 MXugFqsTwgIIgQ8uT2Nq1syG7nvIg+hfgkvkhUlP0OEnh2sMEnPqRbnROePsH7US7jm1
 NCRD8IsfqVRG6nlkNygmra4lZXkUPTXddLb7IPe0OBrLj1c5GbFgMt1/kgw3oVaIvywW
 2XKuUJCpc1GT+GYhYqEanniF/0wYzZQ8ejCxe4kAd2NXgkAtUa4mrWxJE1KSeUiHnmpk
 udRgImaWefXEgm16q/SOG3EqPkZroj3SRJjVbL3HpPsg6KAnRTRQm9uwgmZeT77I8ZTQ
 xzVw==
X-Gm-Message-State: AOJu0Yy2iSPUlfGNCeJQEFRvP1A6cXW0XZ0wyLw4Ddv+ceR7kkRCK/+x
 +hTnuFsZZESAa/D17v2vQwCTK41PVX3fwJPgSTShNboWTVP+MH0TLJyVNULO0kfUnU895ucgW4/
 E
X-Gm-Gg: ASbGncsh7z7lP9Bv8guxGM6BslVUKHtiKpB++3x7EeeQKkTTfFLanIXbUWzNI10Qtoe
 0zm22nstEIjnKVeWFgelKBHH1a7pcsViftlBbLhSrdei0Z6058X24pBq47pN6Vic94D+anpLLWk
 YL5c092RaR1Bh72PpvlUXzYXy3klgUMdpSjnce97A1+grgOi7Ug2waRqpO9wGJtLeOtf2fcCsSS
 CN5FOc950AetnZ5Z8A7KGXpIFH77xr5WWPoVbeKuj9dSerTpvdathet/LNvFT6p886qDc0RqWxL
 aKg0APcbVZeSnjkLZ/cw8acSzEs8jHZtNEhvRLWcN8nnIzbVkOdkEzBWAU0ShJLH1gdGp/fN/tH
 xndquR5RAl2CBgNo=
X-Google-Smtp-Source: AGHT+IHIuuhl2d0QweUqC8LIA1LBxgrA9JuBF2OPV5h+GU8dN/1AvoMcH7B64fWgGf2b2RCFsMiHvQ==
X-Received: by 2002:a05:622a:17c3:b0:475:19cc:a81a with SMTP id
 d75a77b69052e-489cdce5f30mr50498161cf.21.1746023201331; 
 Wed, 30 Apr 2025 07:26:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-47e9f7aa2absm94274001cf.46.2025.04.30.07.26.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 30 Apr 2025 07:26:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Amit Shah <amit@kernel.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/5] hw/virtio/virtio-pci: Remove
 VirtIOPCIProxy::ignore_backend_features field
Date: Wed, 30 Apr 2025 16:26:07 +0200
Message-ID: <20250430142609.84134-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430142609.84134-1-philmd@linaro.org>
References: <20250430142609.84134-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=philmd@linaro.org; helo=mail-qt1-x830.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The VirtIOPCIProxy::ignore_backend_features boolean was only set
in the hw_compat_2_7[] array, via the 'x-ignore-backend-features=on'
property. We removed all machines using that array, lets remove
that property, simplify by only using the default version.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/virtio/virtio-pci.h | 1 -
 hw/virtio/virtio-pci.c         | 5 +----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index f962c9116c1..9838e8650a6 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -149,7 +149,6 @@ struct VirtIOPCIProxy {
     int config_cap;
     uint32_t flags;
     bool disable_modern;
-    bool ignore_backend_features;
     OnOffAuto disable_legacy;
     /* Transitional device id */
     uint16_t trans_devid;
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 8d68e56641a..7c965771907 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1965,8 +1965,7 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
      * Virtio capabilities present without
      * VIRTIO_F_VERSION_1 confuses guests
      */
-    if (!proxy->ignore_backend_features &&
-            !virtio_has_feature(vdev->host_features, VIRTIO_F_VERSION_1)) {
+    if (!virtio_has_feature(vdev->host_features, VIRTIO_F_VERSION_1)) {
         virtio_pci_disable_modern(proxy);
 
         if (!legacy) {
@@ -2351,8 +2350,6 @@ static const Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT, false),
     DEFINE_PROP_BIT("page-per-vq", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT, false),
-    DEFINE_PROP_BOOL("x-ignore-backend-features", VirtIOPCIProxy,
-                     ignore_backend_features, false),
     DEFINE_PROP_BIT("ats", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_ATS_BIT, false),
     DEFINE_PROP_BIT("x-ats-page-aligned", VirtIOPCIProxy, flags,
-- 
2.47.1


