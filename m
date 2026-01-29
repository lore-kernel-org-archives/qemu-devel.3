Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD1CD6B086
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUat-0000qL-UB; Thu, 29 Jan 2026 11:10:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaU-00008Q-Sp
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:43 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaS-0006cu-QT
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:42 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso10444545e9.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702979; x=1770307779; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BHOEVBrGkeHnzIIkfAc0Zy0MYoZWsfrOamFR4imfJYM=;
 b=r0AiUjZ+C/N4uuRdBaPLimqJlA35vh/D+EFp4rdLmvr3IeML0xkVUBsrk70cbi0pOu
 YkNqy7nMQ7B/lXMZKrF9aMkOPY2w8dmoX835TSzx8yc5AX3T+AXhK6DYTROcXl3aR0pl
 bWyvdlVpIf2Qrd6Ue6Vg6gYLEnTEn4/AOJ2fjEVtj+mVjNs2ELIHM4w5KeDhD/sYOAF0
 /K3zwueinkdXxq7jp1+HuobbusZNCujw4QQBlvltM7/Lsx0G6T+V0tRCjCf8tIyftEM2
 4VCycsUKXdzywzZ8O1pBWSICKEHaZyXa9u4ZKOIX5QOsfpEGWBUaSKZdjfewLfb18kpK
 Ht5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702979; x=1770307779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BHOEVBrGkeHnzIIkfAc0Zy0MYoZWsfrOamFR4imfJYM=;
 b=D90fku65bzoNJqeGD0t9VHsTqT2S5ayZ6QMJUFhl7P1oXSOpIy6rE1i7F82iQTQhG7
 3scqtnwIkBZXtOiZF5X2VgLcqQy/dYfr2uCne+56/tsbgz8NGGGt62hKJp4CIzpOxKND
 kyGp8glzEwub7HhnDZnft3PRsUX7c3Iur3tA4UcJoBChiV4GvqUjDM4LxCVkadsncm1O
 8+bTdMWT7UXnyEOqoKsiHzjsjUep4N50uoMQVuSpEcgkdUYtrKg/phTXVuJV8+WdOCxL
 +edIMJWFfqGT4VEVRPxyxwsVAmNig0IivcYS3+38z/R/QofNJQKNU1gM97ORnchq9WQy
 11Yg==
X-Gm-Message-State: AOJu0YyY8J/1974fQmF4HTobNU3ROpNDUXCeJb6QV7KO4dwydWr3iQE5
 we69SO6RSnNLU+se7z7CcMdOuAZfGgyFBlljiQ2/2UvUBTaCfZreRkhakJd2KIWgI3hpdkdBId+
 lA53WPdc=
X-Gm-Gg: AZuq6aL9hDfI7dj5WeCc6hL51gCxrm7Uwtovv3zJOyaX7DyDj2lKLrUaockfqGhRdir
 Oxb4ZItDVfsizE102oy+UpE1kwBomeBlBgLHCbofTs/SFnc9qdi0XtRqabcsgP2T2zyfFwKrc0i
 SLkPjcEQ7zrNEXU8oBChK8FMpkguMZdqVXQXBFlTYYtOUHWvQcntOj0+kkOmOI8HCdiaeBfeY4G
 z/IY33Uasnm2seqh8t3rKHVUN8W/UYrngVnHa9yXnDx+DCh2Udt0MSLDVEfKu3yksJB/CoU2JOM
 5hcZzW8S6s4aps5AHXhR0h1iXbIotgydjE0TFosfg1XR3qe7ADBT7tFpomkC5dHGUXmipod6YM+
 KjkmZ0V3YatzHWfFkLl3R3PEM9j0MnUHIMynAK7FQBhQfGhnnofPJgs4ih5fdGBY2seD8lC6Ujb
 N++7drZ+i7fBuoVlYfw/cC47SebcoLcA==
X-Received: by 2002:a05:600c:a10b:b0:47d:52ef:c572 with SMTP id
 5b1f17b1804b1-480828745e6mr39149785e9.1.1769702979072; 
 Thu, 29 Jan 2026 08:09:39 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/43] hw/pci/pci: Introduce a callback to retrieve the MSI
 doorbell GPA directly
Date: Thu, 29 Jan 2026 16:08:50 +0000
Message-ID: <20260129160917.1415092-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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

For certain vIOMMU implementations, such as SMMUv3 in accelerated mode,
the translation tables are programmed directly into the physical SMMUv3
in a nested configuration. While QEMU knows where the guest tables live,
safely walking them in software would require trapping and ordering all
guest invalidations on every command queue. Without this, QEMU could race
with guest updates and walk stale or freed page tables.

This constraint is fundamental to the design of HW-accelerated vSMMU when
used with downstream vfio-pci endpoint devices, where QEMU must never walk
guest translation tables and must rely on the physical SMMU for
translation. Future accelerated vSMMU features, such as virtual CMDQ, will
also prevent trapping invalidations, reinforcing this restriction.

For vfio-pci endpoints behind such a vSMMU, the only translation QEMU
needs is for the MSI doorbell used when setting up KVM MSI route tables.
Instead of attempting a software walk, introduce an optional vIOMMU
callback that returns the MSI doorbell GPA directly.

kvm_arch_fixup_msi_route() uses this callback when available and ignores
the guest provided IOVA in that case.

If the vIOMMU does not implement the callback, we fall back to the
existing IOMMU based address space translation path.

This ensures correct MSI routing for accelerated SMMUv3 + VFIO passthrough
while avoiding unsafe software walks of guest translation tables.

As a related change, replace RCU_READ_LOCK_GUARD() with explicit
rcu_read_lock()/rcu_read_unlock(). The introduction of an early goto
(set_doorbell) path means the RCU read side critical section can no longer
be safely scoped using RCU_READ_LOCK_GUARD().

Cc: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Message-id: 20260126104342.253965-17-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/pci/pci.c         | 17 +++++++++++++++++
 include/hw/pci/pci.h | 17 +++++++++++++++++
 target/arm/kvm.c     | 18 +++++++++++++++++-
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 101e745bd5..9035caca92 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2979,6 +2979,23 @@ bool pci_device_get_iommu_bus_devfn(PCIDevice *dev, PCIBus **piommu_bus,
     return aliased;
 }
 
+bool pci_device_iommu_msi_direct_gpa(PCIDevice *dev, hwaddr *out_doorbell)
+{
+    PCIBus *bus;
+    PCIBus *iommu_bus;
+    int devfn;
+
+    pci_device_get_iommu_bus_devfn(dev, &iommu_bus, &bus, &devfn);
+    if (iommu_bus) {
+        if (iommu_bus->iommu_ops->get_msi_direct_gpa) {
+            *out_doorbell = iommu_bus->iommu_ops->get_msi_direct_gpa(bus,
+                                iommu_bus->iommu_opaque, devfn);
+            return true;
+        }
+    }
+    return false;
+}
+
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
 {
     PCIBus *bus;
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index ddb0c98e9f..d9835dfd0d 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -683,6 +683,22 @@ typedef struct PCIIOMMUOps {
                             uint32_t pasid, bool priv_req, bool exec_req,
                             hwaddr addr, bool lpig, uint16_t prgi, bool is_read,
                             bool is_write);
+    /**
+     * @get_msi_direct_gpa: get the guest physical address of MSI doorbell
+     * for the device on a PCI bus.
+     *
+     * Optional callback. If implemented, it must return a valid guest
+     * physical address for the MSI doorbell
+     *
+     * @bus: the #PCIBus being accessed.
+     *
+     * @opaque: the data passed to pci_setup_iommu().
+     *
+     * @devfn: device and function number
+     *
+     * Returns: the guest physical address of the MSI doorbell.
+     */
+    uint64_t (*get_msi_direct_gpa)(PCIBus *bus, void *opaque, int devfn);
 } PCIIOMMUOps;
 
 bool pci_device_get_iommu_bus_devfn(PCIDevice *dev, PCIBus **piommu_bus,
@@ -691,6 +707,7 @@ AddressSpace *pci_device_iommu_address_space(PCIDevice *dev);
 bool pci_device_set_iommu_device(PCIDevice *dev, HostIOMMUDevice *hiod,
                                  Error **errp);
 void pci_device_unset_iommu_device(PCIDevice *dev);
+bool pci_device_iommu_msi_direct_gpa(PCIDevice *dev, hwaddr *out_doorbell);
 
 /**
  * pci_device_get_viommu_flags: get vIOMMU flags.
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 48f853fff8..0828e8b87b 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1621,26 +1621,42 @@ int kvm_arch_fixup_msi_route(struct kvm_irq_routing_entry *route,
         return 0;
     }
 
+    /*
+     * We do have an IOMMU address space, but for some vIOMMU implementations
+     * (e.g. accelerated SMMUv3) the translation tables are programmed into
+     * the physical SMMUv3 in the host (nested S1=guest, S2=host). QEMU cannot
+     * walk these tables in a safe way, so in that case we obtain the MSI
+     * doorbell GPA directly from the vIOMMU backend and ignore the gIOVA
+     * @address.
+     */
+    if (pci_device_iommu_msi_direct_gpa(dev, &doorbell_gpa)) {
+        goto set_doorbell;
+    }
+
     /* MSI doorbell address is translated by an IOMMU */
 
-    RCU_READ_LOCK_GUARD();
+    rcu_read_lock();
 
     mr = address_space_translate(as, address, &xlat, &len, true,
                                  MEMTXATTRS_UNSPECIFIED);
 
     if (!mr) {
+        rcu_read_unlock();
         return 1;
     }
 
     mrs = memory_region_find(mr, xlat, 1);
 
     if (!mrs.mr) {
+        rcu_read_unlock();
         return 1;
     }
 
     doorbell_gpa = mrs.offset_within_address_space;
     memory_region_unref(mrs.mr);
+    rcu_read_unlock();
 
+set_doorbell:
     route->u.msi.address_lo = doorbell_gpa;
     route->u.msi.address_hi = doorbell_gpa >> 32;
 
-- 
2.43.0


