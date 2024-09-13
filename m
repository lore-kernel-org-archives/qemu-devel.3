Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B075DEEEC08
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 03:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soxF6-00047A-ES; Thu, 12 Sep 2024 23:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1soxF1-0003vL-4H
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 23:45:04 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1soxEz-00083C-DN
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 23:45:02 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-718da0821cbso1326158b3a.0
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 20:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1726199100; x=1726803900;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZYny33Tgh+SOHfd6MwrD3WKa5Gl+M4qnADH3DvKBPFU=;
 b=rptXo4WZA7xFD6WMaDq51/tD5B6XOfrKUxEd6PH9nygGGaYtPISMVl+dmyWcSvIljH
 Sgy4mh8kmvvw0QXpKy/bnckLEtFH7fvpsQw/haCp40N+HnMFdZ/YzaZfm1DXJI9sqX4q
 mt2lIYpHUUxXDgZSN7gbrkqhGTTfaiPj2dIXrrTQ2M/pUFerniJ8nP+/gePc441GI/cW
 I1D2d86SQbPyNHPHv+ljZVjBnjU1sS6r5oX93Z0xjEVYXFnpJAVCZlXcxoGKS63M0hju
 q3obq2WJRVKHyVkUmpVf8vDT/0Czgt7EWtqyFak2KVEjlfdzs1G5gvjE45sOrua7J7Km
 I8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726199100; x=1726803900;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZYny33Tgh+SOHfd6MwrD3WKa5Gl+M4qnADH3DvKBPFU=;
 b=e1VadmwF22duoi4s2GvILqIKEf8i84qmUaAGWJkweGkC++qYjwimCiHxY+eeRlYOz0
 qzS+mRukZL7MNCrkwv/LDZllOvH/jfs5lwct24oUoEMT84+SYrYZoF8Uk3HX6zpypBec
 P22flniwFZjkup3oPRxLy9FdQSTT7pxXmM9eAB7uuKiZ6UppW+t1KcHMoXRj9+dAJC6B
 xJ6dQBGJHELHzCbmopA/XxgTY3GV9/BGRM5DYL3Cc0k4ub4W9Kk9sozp7/3+0Hqgq6ej
 I7Ax06LP9ux+vAj9feaLr3/uFGm8GFealkyGTOZm+tNKm5a2c1nSEeTwW7fCr1gHr3B7
 HUjQ==
X-Gm-Message-State: AOJu0YwvcHoau0SAOW2UH1PFzPspUV3KKiPYdw6hVNcvRtFOkasrnDCh
 7JOhvLx7fyj0UsIkjrAJj2Tx7orfoHaPdicOa7LnsdDcyxcl0IftT1ecsta4JU0=
X-Google-Smtp-Source: AGHT+IFy8usctI3p+0+RUWGyNPa8L5NO+K4umzggsXaSh+FUW6qyBNA+8xSAUPV04bRMvZ2Wg0IwLw==
X-Received: by 2002:a05:6a00:1783:b0:718:a3c1:60f6 with SMTP id
 d2e1a72fcca58-719261ecd95mr6610814b3a.18.1726199099803; 
 Thu, 12 Sep 2024 20:44:59 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-71908fca6a1sm5289696b3a.26.2024.09.12.20.44.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Sep 2024 20:44:59 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 13 Sep 2024 12:44:32 +0900
Subject: [PATCH v16 04/13] s390x/pci: Avoid creating zpci for VFs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-reuse-v16-4-d016b4b4f616@daynix.com>
References: <20240913-reuse-v16-0-d016b4b4f616@daynix.com>
In-Reply-To: <20240913-reuse-v16-0-d016b4b4f616@daynix.com>
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
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::432;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

VFs are automatically created by PF, and creating zpci for them will
result in unexpected usage of fids. Currently QEMU does not support
multifunction for s390x so we don't need zpci for VFs anyway.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/s390x/s390-pci-bus.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 3e57d5faca18..1a620f5b2a04 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1080,6 +1080,16 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 
         pbdev = s390_pci_find_dev_by_target(s, dev->id);
         if (!pbdev) {
+            /*
+             * VFs are automatically created by PF, and creating zpci for them
+             * will result in unexpected usage of fids. Currently QEMU does not
+             * support multifunction for s390x so we don't need zpci for VFs
+             * anyway.
+             */
+            if (pci_is_vf(pdev)) {
+                return;
+            }
+
             pbdev = s390_pci_device_new(s, dev->id, errp);
             if (!pbdev) {
                 return;
@@ -1167,7 +1177,9 @@ static void s390_pcihost_unplug(HotplugHandler *hotplug_dev, DeviceState *dev,
         int32_t devfn;
 
         pbdev = s390_pci_find_dev_by_pci(s, PCI_DEVICE(dev));
-        g_assert(pbdev);
+        if (!pbdev) {
+            return;
+        }
 
         s390_pci_generate_plug_event(HP_EVENT_STANDBY_TO_RESERVED,
                                      pbdev->fh, pbdev->fid);
@@ -1206,7 +1218,10 @@ static void s390_pcihost_unplug_request(HotplugHandler *hotplug_dev,
          * we've checked the PCI device already (to prevent endless recursion).
          */
         pbdev = s390_pci_find_dev_by_pci(s, PCI_DEVICE(dev));
-        g_assert(pbdev);
+        if (!pbdev) {
+            return;
+        }
+
         pbdev->pci_unplug_request_processed = true;
         qdev_unplug(DEVICE(pbdev), errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {

-- 
2.46.0


