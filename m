Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA57D6B084
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUaV-00008f-GM; Thu, 29 Jan 2026 11:09:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaL-0008Ua-EZ
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:33 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaJ-0006Zi-L5
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:33 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4807068eacbso9920035e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702970; x=1770307770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0+bTXNZrF8nEHoS/zxRQKgSxIuUNxJKWJE+/JYInqmk=;
 b=aSPnj+sphKWcpFW+EoWAioFyWPxVx+LXgf6pF9faibMCHt+5WIIEBb8kOK3QNN2Zsd
 odKRHjA+MTweTdH2ZhJZdMIencE6ejBQI4DSvCiTCa065e9LzCGTW//SZVag8hTAWM1U
 wPonPbFCdMFsEB8SjJyfsT0BYsNEcZAd+U+aCfoNVs6X1U94TZpQ/biUlqU7/oiWTcj9
 AcVZf9zv60Hc3UvDup4whQvKra6xK8cSkLH7lkQx7g9TJSxR0fPTcDi3XIoHfvqTlJ5u
 fYr/FNAwH7NszkOCf/xH3kTRV3CsDcqR0e/6a2VOlzzzqD1TqZQGZNUJJdd5yhk34vJW
 SLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702970; x=1770307770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0+bTXNZrF8nEHoS/zxRQKgSxIuUNxJKWJE+/JYInqmk=;
 b=rNdMYMYAV0V9r8Hx3SVxL2f85VfVrTMIDvCdjp8e+mGLQ4L/rUAIZHKOcDZiNl7RTY
 hOK/Td/tUJyYMMqTQHWdZmsxCaXL02AxKV5R2V0H5Eiqq56G9Rhau3qYlk9VEOGy2aKY
 sFZcfQztOBF/4UD6G9VUTPfqzM1evdkQySlvQ+TKTydh85BEWRAbsmPBvSTgq81IlPEb
 WCMDHu2paKjDz2Zxftq6Q4glgepZujqRnwRHTcpkTv8U7KBK+43NbAHxX5ec/gapJedC
 zl12Dw3lP/dUgtDlfJ4VdZpeyqrRgEDobTzzFmLZ3YIIKXmWfjUouMZYNtq9U2J3kYeJ
 xqog==
X-Gm-Message-State: AOJu0YzYzfJElUGXO62YCwPpKjaeGwVPZ7fdO8dBQfRBcLpeVNP9EJQV
 BiAYL4Ok2dl9XkbN6LJUobBzvXYFXfGw6Kt89ePWB23El59igy25r0uiZTb6fI/3Xdy0pzuHTjP
 8PfftFfM=
X-Gm-Gg: AZuq6aJWSXSJn+0CgAY0+C9Xbe/rn6nORe8xGrI7pxHYjpe9AF7MgTVOQ3730ThZpff
 I/IGn+IbRI6mJXBSs2PK+OExa217rN4908E8p+XXF6xVFYPrTgLsYHmjGrMjj9Sw7L+njFem6/s
 wh5IB60sktu0TESqpEfgKf7u4lDg8lbUMGZGpcehLGEHGgjITgjJtLZoLfIWBmOtt9LzAmX5Xl7
 /zLSEbfH2RADdylroBEKvz2XZtZxK7hZhvLI2pL+cGXZk1IQs3+uLcLtWAHzugjGhL5UnwtJlUk
 NmRaCNe5Ut+qPPfgzMxcBI1nycZNgoQvFNFYxmqNufh1RKx2jsJG5WSi8gk8nZO1HhrCb8w/vYg
 nB7iYQ4yjO8qgfMEUufjNqp48pbpgTKH+8ZAYnBrWcnu5dj4z3QdypDwTtMHMyQVqpffx4iN3L4
 tV07YCNeGzDdJnpz5/eybEymKDtjK7rA==
X-Received: by 2002:a05:600c:1990:b0:47b:deb9:15fb with SMTP id
 5b1f17b1804b1-48069c8a660mr129120445e9.33.1769702969506; 
 Thu, 29 Jan 2026 08:09:29 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:28 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/43] hw/pci/pci: Add optional supports_address_space()
 callback
Date: Thu, 29 Jan 2026 16:08:42 +0000
Message-ID: <20260129160917.1415092-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32d.google.com
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

Introduce an optional supports_address_space() callback in PCIIOMMUOps to
allow a vIOMMU implementation to reject devices that should not be attached
to it.

Currently, get_address_space() is the first and mandatory callback into the
vIOMMU layer, which always returns an address space. For certain setups, such
as hardware accelerated vIOMMUs (e.g. ARM SMMUv3 with accel=on), attaching
emulated endpoint devices is undesirable as it may impact the behavior or
performance of VFIO passthrough devices, for example, by triggering
unnecessary invalidations on the host IOMMU.

The new callback allows a vIOMMU to check and reject unsupported devices
early during PCI device registration.

Cc: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Message-id: 20260126104342.253965-9-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/pci/pci.c         | 20 ++++++++++++++++++++
 include/hw/pci/pci.h | 19 +++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 229ea7cfb1..101e745bd5 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -135,6 +135,21 @@ static void pci_set_master(PCIDevice *d, bool enable)
     d->is_master = enable; /* cache the status */
 }
 
+static bool
+pci_device_supports_iommu_address_space(PCIDevice *dev, Error **errp)
+{
+    PCIBus *bus;
+    PCIBus *iommu_bus;
+    int devfn;
+
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
+    if (iommu_bus && iommu_bus->iommu_ops->supports_address_space) {
+        return iommu_bus->iommu_ops->supports_address_space(bus,
+                                iommu_bus->iommu_opaque, devfn, errp);
+    }
+    return true;
+}
+
 static void pci_init_bus_master(PCIDevice *pci_dev)
 {
     AddressSpace *dma_as = pci_device_iommu_address_space(pci_dev);
@@ -1424,6 +1439,11 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev,
     pci_dev->config_write = config_write;
     bus->devices[devfn] = pci_dev;
     pci_dev->version_id = 2; /* Current pci device vmstate version */
+    if (!pci_device_supports_iommu_address_space(pci_dev, errp)) {
+        do_pci_unregister_device(pci_dev);
+        bus->devices[devfn] = NULL;
+        return NULL;
+    }
     if (phase_check(PHASE_MACHINE_READY)) {
         pci_init_bus_master(pci_dev);
     }
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 6fd8984c99..ddb0c98e9f 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -417,6 +417,25 @@ typedef struct IOMMUPRINotifier {
  * framework for a set of devices on a PCI bus.
  */
 typedef struct PCIIOMMUOps {
+    /**
+     * @supports_address_space: Optional pre-check to determine whether a PCI
+     * device can be associated with an IOMMU. If this callback returns true,
+     * the IOMMU accepts the device association and get_address_space() can be
+     * called to obtain the address_space to be used.
+     *
+     * @bus: the #PCIBus being accessed.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @devfn: device and function number.
+     *
+     * @errp: pass an Error out only when return false
+     *
+     * Returns: true if the device can be associated with an IOMMU, false
+     * otherwise with errp set.
+     */
+    bool (*supports_address_space)(PCIBus *bus, void *opaque, int devfn,
+                                   Error **errp);
     /**
      * @get_address_space: get the address space for a set of devices
      * on a PCI bus.
-- 
2.43.0


