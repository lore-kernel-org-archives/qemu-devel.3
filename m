Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F53C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJVb-0002QN-TD; Tue, 06 May 2025 10:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJSY-0007AB-KW
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:39:51 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCJSW-0001Ut-MC
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:39:50 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so35728445e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542386; x=1747147186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0BkDThoIzdV48soT64XeZ7dLWYwQOfmi2dWyVwZ8yvw=;
 b=L5T7lB1k65aXzizKf0jtGFNHk5kb/ssx60xTe2kNvNwa7+rYJ9ppl2zAxQFEXR6Sfr
 Rko2w07X4l9PAWFVjpqxXZTFDWDOb2Lw2Nw/Xw2yMnZcqJdesfeWLEc755ZULpzwT7bH
 8vsOOYflYF+zA9AGIdochWthEVc9Ee8N3XryeDUOQ5R5RuCBpXs9VSBk3jSpL9/Qd4mG
 eQaUQVsKFob3GKfxedQxTUG8k0A2QLfyWc9vNyieCyjs/COuuG+4WoT/3z9sTBV8zYmg
 I6kNsmjvZYd9pfEBOpfTgttuDp5LlycILxK+5NIA0O/ZOW8f+2OoWv9zZm4gJoGjnrAv
 wPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542386; x=1747147186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0BkDThoIzdV48soT64XeZ7dLWYwQOfmi2dWyVwZ8yvw=;
 b=YlLxBMi7EjOqrOFi+waSaxt5rZ8H5x0ogI1ELE/gQIggLQjWtgiArkIP1QqjZ0+b9F
 mGxYt2Ar7b31wCyFEbAWV9XJiJZiMlJ4xirXZw/xXAr0c8lWwnfUsFta2scnA233EPpm
 lF7GMIAPkJTs/bSsayRIyTPe0aTSN8K6AJIHFeXB7tBuzBlwH67fCqr9rRs5HATOXohc
 ynsynY3Yf6qpWT1AfvOguew7hisfBB+iaBX8c/wWY+DkjqQTLeikIYo6sZbKMdqdFVXC
 EqZ23V92HeCJVGnw+E5ZJfV78LStgzCA2gDh11xTIxLx5LyyEeKzypjquJSdGyvognxd
 pghw==
X-Gm-Message-State: AOJu0YxibXq0rrOgV4B4R+H0071aUl4W0FApvuEwd20hx66P1q9JY2gq
 0YVOzkVRV1IfBv2/KL9VJDDw3Ni3KiYdAmvwe5ElqH6P2AqTrXR4vOMCm5oRMnFZjSkuv5RJ/YH
 S
X-Gm-Gg: ASbGncuFrE9BhQRSyAfIfx0TSHayNyGUQRrqRe/0sm7uCQbAwnQCDW4DJsm+KPI3qjl
 0OlrbEYm5+SU7UP+17SlIZi7LLWuwPuA1o56XaWWDBzAAbcQlCU0rGyOHJ/l+hRs3Pg+lFGHrC2
 1ws6YdLbtKcF4DSySdWcER+tFv0LYDfp9Fq1x6IGm46b7HqrC1CaDIRiiH54QnOYykpC3093l0l
 Y+MTZqpprgJQcrcrHV0CsNW+vaP9FFqxxqMdxMkx8CqaHfYto8F1YvjtMeFJBAhw1uh3/t9nLbw
 yj8j8kH0Ap7poCTASbze1OtaWOqNCRIxS5XWvaJcELNiD7sOo2YB5Z6y70zlo9TuaPYoHHil619
 tTLuH1VNVEixjU1yCc0Nq
X-Google-Smtp-Source: AGHT+IEzA4suOOKyRuacYKw5G5zSnEF4pGG+1ZsU2PVDNbUjmAqVQ9DKPdfocbrKDtzecmQBJU0UjA==
X-Received: by 2002:a05:600c:860b:b0:43d:5264:3cf0 with SMTP id
 5b1f17b1804b1-441d3a6e1f8mr132225e9.11.1746542386476; 
 Tue, 06 May 2025 07:39:46 -0700 (PDT)
Received: from localhost.localdomain (91-163-26-170.subs.proxad.net.
 [91.163.26.170]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a0ad661602sm2342151f8f.61.2025.05.06.07.39.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 06 May 2025 07:39:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Fam Zheng <fam@euphon.net>,
 Hanna Reitz <hreitz@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-block@nongnu.org, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 08/19] hw/virtio/virtio-pci: Remove
 VIRTIO_PCI_FLAG_DISABLE_PCIE definition
Date: Tue,  6 May 2025 16:38:54 +0200
Message-ID: <20250506143905.4961-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250506143905.4961-1-philmd@linaro.org>
References: <20250506143905.4961-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

VIRTIO_PCI_FLAG_DISABLE_PCIE was only used by the hw_compat_2_4[]
array, via the 'x-disable-pcie=false' property. We removed all
machines using that array, lets remove all the code around
VIRTIO_PCI_FLAG_DISABLE_PCIE (see commit 9a4c0e220d8 for similar
VIRTIO_PCI_FLAG_* enum removal).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/virtio/virtio-pci.h | 4 ----
 hw/virtio/virtio-pci.c         | 5 +----
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/hw/virtio/virtio-pci.h b/include/hw/virtio/virtio-pci.h
index d39161766e0..f962c9116c1 100644
--- a/include/hw/virtio/virtio-pci.h
+++ b/include/hw/virtio/virtio-pci.h
@@ -33,7 +33,6 @@ enum {
     VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT,
     VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT,
     VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT,
-    VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT,
     VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT,
     VIRTIO_PCI_FLAG_ATS_BIT,
     VIRTIO_PCI_FLAG_INIT_DEVERR_BIT,
@@ -53,9 +52,6 @@ enum {
  * vcpu thread using ioeventfd for some devices. */
 #define VIRTIO_PCI_FLAG_USE_IOEVENTFD   (1 << VIRTIO_PCI_FLAG_USE_IOEVENTFD_BIT)
 
-/* virtio version flags */
-#define VIRTIO_PCI_FLAG_DISABLE_PCIE (1 << VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT)
-
 /* have pio notification for modern device ? */
 #define VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY \
     (1 << VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index a3e2e007d6c..8d68e56641a 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -2349,8 +2349,6 @@ static const Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_BUS_MASTER_BUG_MIGRATION_BIT, false),
     DEFINE_PROP_BIT("modern-pio-notify", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY_BIT, false),
-    DEFINE_PROP_BIT("x-disable-pcie", VirtIOPCIProxy, flags,
-                    VIRTIO_PCI_FLAG_DISABLE_PCIE_BIT, false),
     DEFINE_PROP_BIT("page-per-vq", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_PAGE_PER_VQ_BIT, false),
     DEFINE_PROP_BOOL("x-ignore-backend-features", VirtIOPCIProxy,
@@ -2379,8 +2377,7 @@ static void virtio_pci_dc_realize(DeviceState *qdev, Error **errp)
     VirtIOPCIProxy *proxy = VIRTIO_PCI(qdev);
     PCIDevice *pci_dev = &proxy->pci_dev;
 
-    if (!(proxy->flags & VIRTIO_PCI_FLAG_DISABLE_PCIE) &&
-        virtio_pci_modern(proxy)) {
+    if (virtio_pci_modern(proxy)) {
         pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
     }
 
-- 
2.47.1


