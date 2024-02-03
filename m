Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68539C4828D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Feb 2024 09:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWCNs-0003xx-1c; Sat, 03 Feb 2024 04:32:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rWCNq-0003x5-Ll
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 04:32:22 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rWCNp-0005hh-5Q
 for qemu-devel@nongnu.org; Sat, 03 Feb 2024 04:32:22 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6ddc1fad6ddso2458640b3a.0
 for <qemu-devel@nongnu.org>; Sat, 03 Feb 2024 01:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706952740; x=1707557540;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/Zrx+cM9JnBC8UHWhVfp2cUkKCiTKN/0k3qIHo/fadQ=;
 b=AUGMcw+5SSTo5cexcieeYKFPvJ9bOp0N7hXyEAqDXZlEWvDVGB75/vtqaph2SOODfk
 P/ncS0EOYBemnUJpqBnLGRBn1wmCR2p6Us2kKwlJXDri3RGy1aG17LNOJ9c4FO82EaAo
 RnFWUr6raeLNPpj++zdoGz3XafH1HmP8r4k50oKVG17kzUlw+PdD0xGIdXt8LgXeNYae
 cd7Ar32Zw7w/g1+u2lneagPOegNQQ1Lw5TqmSzEqMNjv/1t+LH7lZ23pplunzjkvCYEu
 KzAd0dTZUwEhu/Y81oILSaimLQXXAwUALEe5+jmT4+hfgLU7zdh2itzD9PODjXn8q9Kn
 4cTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706952740; x=1707557540;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Zrx+cM9JnBC8UHWhVfp2cUkKCiTKN/0k3qIHo/fadQ=;
 b=HLAsy2/wpgIzDQCMzzxUhArvVFsOljyicLc0Ym+szyJgcaSOHhf3Aks9J23+9xAzwJ
 UTMVVmz7T1vANGK2I9mUoSF93K5ASYiaZG3EuTNuf61HSHVD9D1xyLGoD61kXMPYgn2j
 YI7KWbpl2BVMzBskMT6i9YX87ZCCooKIDmXdiCblznfyeuJduInhVKiP3wp86LeM1or3
 dOvB/p04NQXCvwuy3AsfQd1l5mI3RpEhgjCtNSwy8R6Sw0ZyQzVOqHQ1R03Qh7KuTXQT
 iyJ70ji6gPYa0VK+xRBKAfzsY/WHcDAHtDLD5CeaGL5vvoJIw7LQAU12wKRpOeCF6jn4
 lV9w==
X-Gm-Message-State: AOJu0YwBwrU6nrzfyUQckuZD1rEJ0qaWLzFxuBRGyNEJ7ueXr+EuPXrD
 jUoFXvjEOgUdOa4wsr96bfwX6VUwOeLaKC5XK9k5DzFxXiRZ4rzCzwQQF1eWChE=
X-Google-Smtp-Source: AGHT+IH62ZGdKCr8i/rqEc1456iWcjLZR00cRyHq9nd/iB1ejHZHJYpFJx/9uSG8CzOnidIvFWgORw==
X-Received: by 2002:a05:6a00:1823:b0:6e0:25a0:f6c with SMTP id
 y35-20020a056a00182300b006e025a00f6cmr2576754pfa.33.1706952739949; 
 Sat, 03 Feb 2024 01:32:19 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCUrVPY9EJDWqCXDSpLPjk21XnUY/HrjgfRuB6Lnb8xGx28/lvjKCL9G/08OYMhf13GNXWd4oFDCvvve2opLEJ9D963zx6nxTtTnDJQMK085KzyKoA55++YOvJs44cNER60jPKJDpSogev0WJd3jMFE8yxYQTmADzqMknKfFnHwHPn68oLkHmdUms4bP/wk2LxRgSaUPImDwchygibcnQrGupurJbhqdrYRpuKvrtdxsjuG7ZpHU3wHSk4Kiqza5pDoRNuanGm3geCzBO2zZ7m1RCyP5P+eLd+7vjbeKt1kj0RgzRTCJEYdvuqJhG7f/Us0BqVNygIa9kti6CzzGMl8FFttOcLYByHvTmsO94Al5z8XK0AGCGGI/nCJvkw8URoORqVVvmzBDq8Ltip5UEl9uh97jA4vg3LsC6fcqYg==
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 f4-20020a056a000b0400b006e02cdad499sm617591pfu.99.2024.02.03.01.32.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Feb 2024 01:32:19 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 03 Feb 2024 18:31:55 +0900
Subject: [PATCH 1/6] hw/pci: Determine if rombar is explicitly enabled
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-reuse-v1-1-5be8c5ce6338@daynix.com>
References: <20240203-reuse-v1-0-5be8c5ce6338@daynix.com>
In-Reply-To: <20240203-reuse-v1-0-5be8c5ce6338@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::42a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

vfio determines if rombar is explicitly enabled by inspecting QDict.
Inspecting QDict is not nice because QDict is untyped and depends on the
details on the external interface. Add an infrastructure to determine if
rombar is explicitly enabled to hw/pci. PCIDevice::rom_bar is changed to
have -1 by the default to tell rombar is explicitly enabled. It is
consistent with other properties like addr and romsize.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pci_device.h | 5 +++++
 hw/pci/pci.c                | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index d3dd0f64b273..54fa0676abf1 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -205,6 +205,11 @@ static inline uint16_t pci_get_bdf(PCIDevice *dev)
     return PCI_BUILD_BDF(pci_bus_num(pci_get_bus(dev)), dev->devfn);
 }
 
+static inline bool pci_rom_bar_explicitly_enabled(PCIDevice *dev)
+{
+    return dev->rom_bar && dev->rom_bar != -1;
+}
+
 uint16_t pci_requester_id(PCIDevice *dev);
 
 /* DMA access functions */
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 76080af580d7..d08548d8ffe9 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -71,7 +71,7 @@ static Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
     DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
     DEFINE_PROP_UINT32("romsize", PCIDevice, romsize, -1),
-    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, 1),
+    DEFINE_PROP_UINT32("rombar",  PCIDevice, rom_bar, -1),
     DEFINE_PROP_BIT("multifunction", PCIDevice, cap_present,
                     QEMU_PCI_CAP_MULTIFUNCTION_BITNR, false),
     DEFINE_PROP_BIT("x-pcie-lnksta-dllla", PCIDevice, cap_present,

-- 
2.43.0


