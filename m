Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F84E64002
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 07:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9HvM-0003wF-HQ; Sun, 05 Apr 2026 03:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1w9HvK-0003vR-VB
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 03:29:34 -0400
Received: from mail-dy1-x132c.google.com ([2607:f8b0:4864:20::132c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <scottjgo@gmail.com>)
 id 1w9HvI-0007Gn-Ph
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 03:29:34 -0400
Received: by mail-dy1-x132c.google.com with SMTP id
 5a478bee46e88-2b6b0500e06so4607999eec.1
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2026 00:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775374171; x=1775978971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BvX/ruZLVHznPTOumzyShvEw9LLr8MaO+93oE9E08wY=;
 b=UCdT6AHIVLoEnRjQJCpBEOH2nTCJrCaxg0m51vMedrqgLxwN6r08ofEn/xa+f04Jr4
 Kqz9rsi29VMCGrvAjrq7FYGlrTHzhnmduXCQAeNsPCPBQnwlv4XjA5qYwXvcPy3qM90V
 cjEMXXvclo1FYOnGB0x43BAFB6pPpGPpJd7W2Q+p7GiAMz5oEscw3yCGKnTjWcJofc5c
 7UKTepu+qkbfP7RLTvbZ0PXti1H20gWF54tx5GciltaHmiIfXuTzDeevsoHipqJxXqEt
 6fPTqIpm5eFBK/I5I6ayCzVzU6CSTPxsrvtQ0ufVHnVAmtQqSUhU/fvuV0+CZzZtuzXI
 BblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775374171; x=1775978971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BvX/ruZLVHznPTOumzyShvEw9LLr8MaO+93oE9E08wY=;
 b=m4IITi3PEOHJVkvbF/vyXJgb50S27En1iSUP8E1UGeizXD97L177Ktup3LfJDhxJ6D
 rjyQVENaTqRheziRWIkSziZsNFKipedEHo+dZHrpvB09akpbFfE7ALcBi3vkLC51QTrt
 3Lqw1iCbvx6clbc6ccj408bWSDRogknKwGecC68jgUJEqjaMOvSPltndGLYqkzSW+8qJ
 c0V0pEkIfTaz2V0MBCdlLqEoabNHzyuD+lOrrdFHayU1b88bfIg/e3OYKQ2FZDCp3PQu
 ba0hufvt/MDaJgW0S0G9VLJouEy0ZVrXjtC8LFU5cZVDbe5NobGIujP2KbsPQ85nUz4v
 p9Bw==
X-Gm-Message-State: AOJu0YyzZ9xZqkQd/nOXcbXYkUHxx/nY8QjlGOpk/hIskmiwh6FaVnZx
 rEFRglf+EMF4WnbaK5FYq9yhwnIpOEq5uJwycIwW/l759JV/ffLbMVR4682CCUog6Y8=
X-Gm-Gg: AeBDievhv4rrURYjFj95+vctVBDh/+SiYnQAJ17BmtqAVSBP+GBwK/Ao5yQtjJH1zB3
 VxARdkXUrJpCPwT4CLeYljEaZ5M4bpy0XYTyvdM2GI4O2V4kT1PdkqnlViHo4DKcOQNPXPtJsJp
 b/GUDIIN1PJUdy2gDee9E0oboUSSCx2Kuk+2xuZYOjqmOX1bnVZVhUDTpYA0kEcqMjM2IJVU32o
 7LilaigU1fBdP409MPWYoXMF6BVN/asW/yoQw+ErDlPazKfg3iKz+L77/M/NixBG8pMqEfFSOJC
 urX/j9LgiPTD0BTp+qkHt8TJ2DYpwAujKbcUGq1+MEjTCB30GnivI+tGJRMTaHFXflQkXpYSOAH
 BI/llqlqX5nGBew6uBFtRr/tbVqXoCTur/9iy3anvI3R0T/eFN7CGRLaxzk896QkSXxlA4u2MyL
 KQV9NBShhbIl1bNEdTjNwNL14mYVykezd2caNvlUkQlnBQ+nIOmvJb3rftkHd3aP1TAFXFKDpLy
 bcnvIcVjC3TrC3hXyI+Idn1XsQF0oHC/rd7dw==
X-Received: by 2002:a05:7301:1687:b0:2cb:bc02:6e13 with SMTP id
 5a478bee46e88-2cbfbf78978mr4369879eec.16.1775374170739; 
 Sun, 05 Apr 2026 00:29:30 -0700 (PDT)
Received: from localhost.localdomain ([2601:645:8200:47:41e4:ff2b:ff70:4d75])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2cb92ea0ef1sm7636502eec.21.2026.04.05.00.29.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Apr 2026 00:29:30 -0700 (PDT)
From: "Scott J. Goldman" <scottjgo@gmail.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, pbonzini@redhat.com, rbolshakov@ddn.com,
 phil@philjordan.eu, mst@redhat.com, john.levon@nutanix.com,
 thanos.makatos@nutanix.com, qemu-s390x@nongnu.org,
 "Scott J. Goldman" <scottjg@umich.edu>,
 "Scott J. Goldman" <scottjgo@gmail.com>
Subject: [RFC PATCH 04/10] vfio: Prepare existing code for Apple VFIO backend
Date: Sun,  5 Apr 2026 00:28:48 -0700
Message-ID: <20260405072857.66484-5-scottjgo@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260405072857.66484-1-scottjgo@gmail.com>
References: <20260405072857.66484-1-scottjgo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::132c;
 envelope-from=scottjgo@gmail.com; helo=mail-dy1-x132c.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: "Scott J. Goldman" <scottjg@umich.edu>

Adjust the shared VFIO code so a non-Linux backend can plug in:

- vfio_device_get_name(): accept a device that already has a name set
  without requiring sysfsdev or an fd.
- vfio_device_is_mdev(): return true on Darwin — the dext mediates all
  device access and manages DMA mappings explicitly, so the mdev
  assumptions (software-managed DMA, balloon-safe) hold.
- vfio_device_attach(): select the Apple IOMMU container type on Darwin.
- vfio_pci_realize(): allow realize when name is pre-set (no sysfsdev),
  and add a no_bar_quirks flag so subclasses can skip BAR quirk setup.
- Add TYPE_VFIO_IOMMU_APPLE and TYPE_VFIO_APPLE_PCI type strings.

Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
---
 hw/vfio/device.c                 | 20 ++++++++++++++++++++
 hw/vfio/pci.c                    |  8 +++++---
 hw/vfio/pci.h                    |  1 +
 hw/vfio/types.h                  |  2 ++
 include/hw/vfio/vfio-container.h |  1 +
 5 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/hw/vfio/device.c b/hw/vfio/device.c
index 973fc35b59..338becffa7 100644
--- a/hw/vfio/device.c
+++ b/hw/vfio/device.c
@@ -316,6 +316,13 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
     struct stat st;
 
     if (vbasedev->fd < 0) {
+        if (!vbasedev->sysfsdev) {
+            if (vbasedev->name) {
+                return true;
+            }
+            error_setg(errp, "No provided host device");
+            return false;
+        }
         if (stat(vbasedev->sysfsdev, &st) < 0) {
             error_setg_errno(errp, errno, "no such host device");
             error_prepend(errp, VFIO_MSG_PREFIX, vbasedev->sysfsdev);
@@ -404,7 +411,16 @@ bool vfio_device_is_mdev(VFIODevice *vbasedev)
     g_autofree char *tmp = NULL;
 
     if (!vbasedev->sysfsdev) {
+#ifdef CONFIG_DARWIN
+        /*
+         * On Darwin the dext mediates all device access and manages DMA
+         * mappings explicitly, so the mdev assumptions (software-managed
+         * DMA, balloon-safe) hold.
+         */
+        return true;
+#else
         return false;
+#endif
     }
 
     tmp = g_strdup_printf("%s/subsystem", vbasedev->sysfsdev);
@@ -462,9 +478,13 @@ bool vfio_device_attach_by_iommu_type(const char *iommu_type, char *name,
 bool vfio_device_attach(char *name, VFIODevice *vbasedev,
                         AddressSpace *as, Error **errp)
 {
+#ifdef CONFIG_DARWIN
+    const char *iommu_type = TYPE_VFIO_IOMMU_APPLE;
+#else
     const char *iommu_type = vbasedev->iommufd ?
                              TYPE_VFIO_IOMMU_IOMMUFD :
                              TYPE_VFIO_IOMMU_LEGACY;
+#endif
 
     return vfio_device_attach_by_iommu_type(iommu_type, name, vbasedev,
                                             as, errp);
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 5a1c2d8c2e..cf817d9ae7 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3483,7 +3483,7 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
     char uuid[UUID_STR_LEN];
     g_autofree char *name = NULL;
 
-    if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
+    if (vbasedev->fd < 0 && !vbasedev->sysfsdev && !vbasedev->name) {
         if (!(~vdev->host.domain || ~vdev->host.bus ||
               ~vdev->host.slot || ~vdev->host.function)) {
             error_setg(errp, "No provided host device");
@@ -3558,8 +3558,10 @@ static void vfio_pci_realize(PCIDevice *pdev, Error **errp)
         vfio_vga_quirk_setup(vdev);
     }
 
-    for (i = 0; i < PCI_ROM_SLOT; i++) {
-        vfio_bar_quirk_setup(vdev, i);
+    if (!vdev->no_bar_quirks) {
+        for (i = 0; i < PCI_ROM_SLOT; i++) {
+            vfio_bar_quirk_setup(vdev, i);
+        }
     }
 
     if (!vfio_pci_interrupt_setup(vdev, errp)) {
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index d6495d7f29..424acd71b6 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -187,6 +187,7 @@ struct VFIOPCIDevice {
     bool defer_kvm_irq_routing;
     bool clear_parent_atomics_on_exit;
     bool skip_vsc_check;
+    bool no_bar_quirks;
     uint16_t vpasid_cap_offset;
     VFIODisplay *dpy;
     Notifier irqchip_change_notifier;
diff --git a/hw/vfio/types.h b/hw/vfio/types.h
index 5482d90808..b44c234ac4 100644
--- a/hw/vfio/types.h
+++ b/hw/vfio/types.h
@@ -20,4 +20,6 @@
 
 #define TYPE_VFIO_PCI_NOHOTPLUG "vfio-pci-nohotplug"
 
+#define TYPE_VFIO_APPLE_PCI "vfio-apple-pci"
+
 #endif /* HW_VFIO_VFIO_TYPES_H */
diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
index a7d5c5ed67..5ccbabccb4 100644
--- a/include/hw/vfio/vfio-container.h
+++ b/include/hw/vfio/vfio-container.h
@@ -117,6 +117,7 @@ vfio_container_get_page_size_mask(const VFIOContainer *bcontainer)
 #define TYPE_VFIO_IOMMU_SPAPR TYPE_VFIO_IOMMU "-spapr"
 #define TYPE_VFIO_IOMMU_IOMMUFD TYPE_VFIO_IOMMU "-iommufd"
 #define TYPE_VFIO_IOMMU_USER TYPE_VFIO_IOMMU "-user"
+#define TYPE_VFIO_IOMMU_APPLE TYPE_VFIO_IOMMU "-apple"
 
 struct VFIOIOMMUClass {
     ObjectClass parent_class;
-- 
2.50.1 (Apple Git-155)


