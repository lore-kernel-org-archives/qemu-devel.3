Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A65D6B084
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:13:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUaM-0008Vd-LG; Thu, 29 Jan 2026 11:09:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaK-0008Sd-2s
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:32 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaI-0006YW-9L
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:31 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4801bc32725so8868545e9.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702968; x=1770307768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8uo5dKYAD+vYGvFL/kQyxMD5SHu1nUB/IkGWYYMNAkw=;
 b=uPyOzanG1O3grTLdoWeSl4hXa31gKpaAtBm0VfyEM9eDUWS1HmXNvMFrkCJBEA7rg8
 /bu89aEGnpK7aYClnkz1cMfdc2/IQ2zmeJgiakDTOKTKx2XltJoME1fsRM/Rbc/okS7t
 1f6mHseGpwQdl8Te/tpUm3VdhJNFiLsqzv+M1054Jp0akFjLKAFgrUyAFUy79gsl29gY
 mgedUbhzFHt+AFvBSjuK5smKocSIKVhHuznxABd8ywNzCqLczI1KglROUNDB/DJ6GtKA
 QSVrGRuQx36gCxqcQpTWCYQrkVBM7L/VUsou4bUL2VJWZJ+dmQMKTCT/BFGntQz75gx7
 e39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702968; x=1770307768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8uo5dKYAD+vYGvFL/kQyxMD5SHu1nUB/IkGWYYMNAkw=;
 b=roRM1pzyBMEbhfe7ApNwuGXOr4u3to9W5iZRy8zE23sU5BphVpzMgUkQmOEzGIZSmn
 1JAq+a6BnRv4pF4aG4jKMceDOdxyj2OeI7vuPqTCfgwL9yWStTO8jr3FFKskdIbFxIve
 lESEjSh3areOqfFHshDZi8INkCMKEzsJuv+wIK8xD51vhaBn4i7qwWOmM7eYxxXk4Uhg
 EsrE8zLB3vXZQ+wJhPME+NZMHhWT3SryhRfr9WKJdzZ8V/urm+Revh5ihfL7sAPXlmF8
 vyyj3tSQqdgypJdI9ateNrmTR5yfOarl+scnK4MPl+YYh3Ra7Ee/3PTOlyvmWy0bruGC
 xtzg==
X-Gm-Message-State: AOJu0YyfQ6x/ons55iddm7v//KFv2ehkGdCbEUWaQrrSSsHND2SQvCDC
 tggit14oFcttQ7WhTWSPfZONepjun18bLBySc615yEZvY3UPUmfYD3at3kXEkGEh05O552wZEp7
 m541/FIo=
X-Gm-Gg: AZuq6aJO7kFBOhfouKyTAUCRuwvf8KZG17xJXQ43iDVUGvMYUdY4NvhKmqs3Dk0RFsy
 h+Lai8OvaVe/9PBHkrOT3BG20g7BNWn7UEJIj1S3qswuNihwGigHl7TPuGWFiw7Fn0m7HkF5m9K
 A5VkKveKG/VfMKQMDAAGTGdY0Gi93ztfTNz3GlJOVFTaFIV++0JsZMbRLwOGkGyJJiIPAYA8c9c
 Fl2wxI719a0OwNDgDzaK+1l6ZR4Z78zYpQgnRI0iJZVgeVoR/N5n4IYSIEMOocyIpB9jFw9iaC1
 MwU+J0eOkzgE+D9k5hqmvHBp3Tc6ST/QhVRrDz8G6x+tJ6sIk3pTeyMuw8j8IruPW+k7rMdZi/i
 AFibi+piSm6VlwfKOs49nZcZ6D4QkQG7Qx/gGst5kYpOxz7/bhckASKG4vCRKsHGNZS2ekb1Sdl
 Msmwmhaj9NjcJfbklniOovZ3V4u81G7Q==
X-Received: by 2002:a05:600c:1994:b0:480:1c2f:b003 with SMTP id
 5b1f17b1804b1-48069c788e8mr115791675e9.20.1769702968337; 
 Thu, 29 Jan 2026 08:09:28 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:27 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/43] hw/pci/pci: Move pci_init_bus_master() after adding
 device to bus
Date: Thu, 29 Jan 2026 16:08:41 +0000
Message-ID: <20260129160917.1415092-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Shameer Kolothum <skolothumtho@nvidia.com>

During PCI hotplug, in do_pci_register_device(), pci_init_bus_master()
is called before storing the pci_dev pointer in bus->devices[devfn].

This causes a problem if pci_init_bus_master() (via its
get_address_space() callback) attempts to retrieve the device using
pci_find_device(), since the PCI device is not yet visible on the bus.

Fix this by moving the pci_init_bus_master() call to after the device
has been added to bus->devices[devfn].

This prepares for a subsequent patch where the accel SMMUv3
get_address_space() callback retrieves the pci_dev to identify the
attached device type.

No functional change intended.

Cc: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Message-id: 20260126104342.253965-8-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/pci/pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 8cbf5f5d70..229ea7cfb1 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1381,9 +1381,6 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
     pci_dev->bus_master_as.max_bounce_buffer_size =
         pci_dev->max_bounce_buffer_size;
 
-    if (phase_check(PHASE_MACHINE_READY)) {
-        pci_init_bus_master(pci_dev);
-    }
     pci_dev->irq_state = 0;
     pci_config_alloc(pci_dev);
 
@@ -1427,6 +1424,9 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
     pci_dev->config_write = config_write;
     bus->devices[devfn] = pci_dev;
     pci_dev->version_id = 2; /* Current pci device vmstate version */
+    if (phase_check(PHASE_MACHINE_READY)) {
+        pci_init_bus_master(pci_dev);
+    }
     return pci_dev;
 }
 
-- 
2.43.0


