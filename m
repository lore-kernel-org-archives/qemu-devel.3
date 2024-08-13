Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73849C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 06:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdkoS-0006LV-L3; Tue, 13 Aug 2024 02:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdkoM-000686-6B
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:15:16 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdkoJ-0003Uj-BW
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:15:13 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3db157cb959so3552959b6e.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 23:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723529709; x=1724134509;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KhvSqXAEdDDWpyZ2TnpIXArJspefwxxfrLfBQ6hR8X0=;
 b=kooshb32Tyd7CCsKJPzPXVZ5F/M0055Ab1mcRGnLBr1GF1x/xko8XQLtfaeKwvRyr+
 LVYpN/GF0Or/FJgxORj47jj3G2dFLKEh5H6AojSLkjwCuW+CSdhPR7a8rXiCWOw1yzaH
 mr+DVIbmrjSivHFSWhLh1ezeVSkB0169cYAUfXrj4zKCW0ntC4E++4QYvqyv5aAXMThA
 0SF/OKIgZmYwfRi2emFQnhKPoTOn2FIpnaaE6k0qbilfhcpDuTX9kF7+oANlkDN2OrQ+
 gVZVz5qYUcQITOD3AUY1664o5kMMKNdWUYZZQiltl7eSSMVhkzFuI23pAFCVbjFPO3KX
 1CHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723529709; x=1724134509;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KhvSqXAEdDDWpyZ2TnpIXArJspefwxxfrLfBQ6hR8X0=;
 b=FXx9Ejm+wQZqCPMirAxwJA5yI8p5ZMSpCP3iJ1r+ZO+L1+OPclvcZttH7zpLpsCF52
 3tEaHYXAMDe0erY3Scy7XrijPPrIwNZ8nKNWNRcRa9Bs0ZFV/LMkBvybe44WA4Xn1hrU
 D5oSeKTNXhGqdUEGjjkIl75ZHznpGZIK7DEEVDgk4JJ5L+/1H7D+wNcnf8YEHbUY4LrH
 7zyZIgf/xQdxl2hqqII0a06lJnQhyx+CefRLraxNnsCnEY8MnQNcIWfRMXSvF+WDqAcm
 IkWkOIABfmmLcZ093W6IwPCAu8T7BrIn+LRYQWf01EErNx1fHBeu6mfchQc6A7SygUnk
 u6Tw==
X-Gm-Message-State: AOJu0YwNzG4f/0bFbsqMDtCTRSwNyEdnb7kGborRU52ijZz+t0P9XWGW
 04Ic8zYIK6uscO5FND7wv7QKpiq401RfeJpttZCOYweVuyPU8e7zbEIfiKe4DDo=
X-Google-Smtp-Source: AGHT+IHtIty8dKgBr/1waQO6p9mgcPghJoGbZxHu/gzzfRvLwUAb6l/96T0V3KeILkFm6YzceIwtTw==
X-Received: by 2002:a05:6870:e314:b0:254:affe:5a05 with SMTP id
 586e51a60fabf-26fcb6ca3ecmr2971068fac.21.1723529709419; 
 Mon, 12 Aug 2024 23:15:09 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-711e3b21bf3sm2499312b3a.85.2024.08.12.23.15.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 23:15:09 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 13 Aug 2024 15:14:47 +0900
Subject: [PATCH for-9.2 v14 04/11] s390x/pci: Check for multifunction after
 device realization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-reuse-v14-4-4c15bc6ee0e6@daynix.com>
References: <20240813-reuse-v14-0-4c15bc6ee0e6@daynix.com>
In-Reply-To: <20240813-reuse-v14-0-4c15bc6ee0e6@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::235;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oi1-x235.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
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

The SR-IOV PFs set the multifunction bits during device realization so
check them after that. This forbids adding SR-IOV devices to s390x.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/s390x/s390-pci-bus.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 3e57d5faca18..00b2c1f6157b 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -971,14 +971,7 @@ static void s390_pcihost_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                     "this device");
     }
 
-    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
-        PCIDevice *pdev = PCI_DEVICE(dev);
-
-        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
-            error_setg(errp, "multifunction not supported in s390");
-            return;
-        }
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
         S390PCIBusDevice *pbdev = S390_PCI_DEVICE(dev);
 
         if (!s390_pci_alloc_idx(s, pbdev)) {
@@ -1069,6 +1062,11 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         pdev = PCI_DEVICE(dev);
 
+        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+            error_setg(errp, "multifunction not supported in s390");
+            return;
+        }
+
         if (!dev->id) {
             /* In the case the PCI device does not define an id */
             /* we generate one based on the PCI address         */

-- 
2.46.0


