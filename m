Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC550C5321E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 05:02:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shMQF-00069I-Jz; Fri, 23 Aug 2024 01:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shMQ7-0005jk-Rj
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 01:01:09 -0400
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shMQ5-0008OJ-0N
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 01:01:07 -0400
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-8278b0ba494so2233839f.3
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 22:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1724389264; x=1724994064;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KhvSqXAEdDDWpyZ2TnpIXArJspefwxxfrLfBQ6hR8X0=;
 b=GYEr6lyDGvPcLMWyM7aQPLUvjOgVoqREvuUN7y36IbPL8pIe1ZJu7CDYQsXFH78jwl
 b1D+crYolyOJbzxqC5EG5NutE0nMb/G9MStoU3eRL2kdfW/0NC8BhLuK0cvlrmGcvfPQ
 pGVfFnMoiLAX4cP23puWW1a6mRB4EqSJOKEIJHWT8W6lXsQSnOMp1XDDYK7PnQRP9Uyy
 WR9wGlDM1p37zL0tTGYj/srKC4ziXjWb+BBvroNBCGLeCQgqZPMtmyyMS8Z4J+VTEHhQ
 rnvhcdpehW+gM/nMBm0T/cpbqwEohrkxHfaCf77lejqGotWniuqCru/qnwJitqhecN16
 UTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724389264; x=1724994064;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KhvSqXAEdDDWpyZ2TnpIXArJspefwxxfrLfBQ6hR8X0=;
 b=fRNYDlnW5ys8kxjU+zf7p+JDR0TZPkMSE8YbgEYSrUcbR3f5IJWRRbze7+3WV8TimX
 zn6ND1iu+az6pEi3bSos/2gKMWt9BIsbrGVRccwD16A/JrEBUWAqvqEf53IWOyJJUPM3
 aeVYKcW9REWLKOGBXPCvX8RT0XZ6/ThcYz2/9LSHazYdcTya2UkMbFo9ERvbISsPWSYn
 iWMgcxtdf4bDzOyG7iD7F28PtPPFDUkw889RaGKUrvb1+HH+H/hZ90rbIdxjHPqGI+bl
 O2RTm1DAr5bemAKDJckI1ajEvkXwTkGEZWDi2cRR8pHqQKEDe7KbUaDG0dhoJtpsEqjO
 Q2Cg==
X-Gm-Message-State: AOJu0YxRTDYALtnU0diJB3g9Nb7vsjS+KB03OuRUvBESxHx16s9McXM9
 Yam03KtrARi/L2FofsdkRGrJGvhlsdIIkU44GCXadN/tzdyW11mydaD2QRO936Y=
X-Google-Smtp-Source: AGHT+IH8TOXyjNLBnQeBNzLVOesOgQILP5R4rbuQLnnnNT+aVbju+4awJySzna2gGEx5AGUZln197w==
X-Received: by 2002:a05:6e02:2192:b0:398:a2e0:18dc with SMTP id
 e9e14a558f8ab-39e3c9c0d27mr10637295ab.17.1724389263613; 
 Thu, 22 Aug 2024 22:01:03 -0700 (PDT)
Received: from localhost ([157.82.207.23]) by smtp.gmail.com with UTF8SMTPSA id
 41be03b00d2f7-7cd9acdac47sm2275089a12.39.2024.08.22.22.01.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 22:01:03 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 23 Aug 2024 14:00:41 +0900
Subject: [PATCH for-9.2 v15 04/11] s390x/pci: Check for multifunction after
 device realization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-reuse-v15-4-eddcb960e289@daynix.com>
References: <20240823-reuse-v15-0-eddcb960e289@daynix.com>
In-Reply-To: <20240823-reuse-v15-0-eddcb960e289@daynix.com>
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
Received-SPF: none client-ip=2607:f8b0:4864:20::d2b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-io1-xd2b.google.com
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


