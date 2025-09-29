Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67581CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3GQS-0000Qo-Pv; Mon, 29 Sep 2025 12:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3GQQ-0000On-4C
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:08:30 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3GQM-0004Fb-PR
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:08:29 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e42fa08e4so26254625e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 09:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759162104; x=1759766904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pPUY25OpRf2StCPP4Enm4s8CN2RqByc85IXcJXZI+xY=;
 b=A3dKCHhfBf4K6jGU3+afV6qpT0YdMnSIftHIOs2P0yBA7oF9X27glEkOfR+GfoH0vA
 eCReMjkeuZQCetCWwPtaRYcCzsulmMNSt7K9OcS8MtT2AGLE44fbHjeeWCpKclc6ALaY
 xmMwW4hm0vcekXFVbcqGuKifMUsvPh/RA5+mMriEEnYFX47rrYVGxVIuXeMxqAl9t+5/
 dSt3Sm/wLdcOHzSgzmDrBYCJh1Gz8rB/D6gI6GhIkWNHnU17xmJeGdyVvW2roRWoH00d
 +M6qRzAIaHKqih7nOfnUP/Tq2ahsUDgcr1OSFJG2H/0L6fH37CsX/SoIMOnjJIbQHqso
 MwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759162104; x=1759766904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pPUY25OpRf2StCPP4Enm4s8CN2RqByc85IXcJXZI+xY=;
 b=J/CeE6cfRzeyL6Ns1VeV/QbcJs4l1P36Nca8+bC9OVQ3vvzrEmjgqyU60f8WddfP0/
 OU8JCrcSp6nuooMlp2EAlrFoL4HLQOWrzHpou9XYZ0VV29Jh5G2+FGeQy13DhPWTsuHd
 r0jfiHxEWVLbIg1lVcakc+ElkGiDLYzRD5ryeaYrch8L6ObViSxOyExvDnwyL2vbGQL6
 +TPsCsxXeuv+N6T2DtsWMrquHt+kTmBfa/DOmz2Zr7HgeZEyoi0FT5FyC7/uZLyieJV1
 bQPGH9h92jmGdz5/KRgFB/N5CDKRVqKgJpS2rez3BpJt2xobhqdJZuaOp1iFT5IgfXnk
 0yew==
X-Gm-Message-State: AOJu0YxCLaqH3eEMwhwmE8qmjLymNhMlOagqkIBwzPxin7jfAuXAvtkB
 yu8aNeJRGFBKaH6RXRcWfzx/We4IqNyGH6roMsmc+UgjDlU4J+ijfSmchemo1dqUxuZgKnWKO/A
 AQBfGukMhjg==
X-Gm-Gg: ASbGncu7/xamsDmiURkbWWVmBUB3Jvp8lEJqW5r/9X2fX1IgSbHUHULlZt1YunH7zQM
 QS6liGo8ITEsMCvvGNdmQkAgkRlhjspy8oP5DbEoxqTpz+PNro1qiCk6qnG84Z3Ncv7v7ipqLAK
 OkAPv7K3XtZOkrNSHO8qfJR+hNNpCuhxNwVtQILs2ePKB3yUCWwPfSjALIu9tiS1UwmI5WfMjeu
 wRIDjaB5zqG5eYe7xHQ1rMe9vQytul83748tntbZmIQ+p4UR/dY4GTj1mq+gRfSt9wOSsusJo69
 wba5RtWy0GJhbb6GgKlGWmV+whUM1WZ8+FCwfN47Q235QwJKH3XkEmF4wZ0LFdo/x0z6YIjiXsP
 c9PLBX3zCPk2A6kXv1+HY4OwA1A95G9dhmW7qJzFbv87QZUUZ9+2RYQojG44Q1NtzBXchkzmXfh
 5ApuhZ5sE=
X-Google-Smtp-Source: AGHT+IFD3i+7OtSGiOJAEoH0LLF+VL1bAQoCaKYcLhPFKIbotDQ15wwd0qmR1leVcbT25+V1qzR2/w==
X-Received: by 2002:a05:600c:1c88:b0:45f:2919:5e6c with SMTP id
 5b1f17b1804b1-46e329c5735mr246557515e9.16.1759162103840; 
 Mon, 29 Sep 2025 09:08:23 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc72b0aeesm19293029f8f.49.2025.09.29.09.08.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 09:08:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <john.levon@nutanix.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/3] hw/vfio: Use uint64_t for IOVA mapping size in
 vfio_container_dma_*map
Date: Mon, 29 Sep 2025 18:08:07 +0200
Message-ID: <20250929160807.73626-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929160807.73626-1-philmd@linaro.org>
References: <20250929160807.73626-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

The 'ram_addr_t' type is described as:

  a QEMU internal address space that maps guest RAM physical
  addresses into an intermediate address space that can map
  to host virtual address spaces.

This doesn't represent well an IOVA mapping size. Simply use
the uint64_t type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/vfio/vfio-container.h | 10 +++++-----
 hw/vfio-user/container.c         |  4 ++--
 hw/vfio/container-legacy.c       |  8 ++++----
 hw/vfio/container.c              |  5 ++---
 hw/vfio/iommufd.c                |  6 +++---
 5 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
index 093c360f0ee..c4b58d664b7 100644
--- a/include/hw/vfio/vfio-container.h
+++ b/include/hw/vfio/vfio-container.h
@@ -81,10 +81,10 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
                                VFIOContainer *bcontainer);
 
 int vfio_container_dma_map(VFIOContainer *bcontainer,
-                           hwaddr iova, ram_addr_t size,
+                           hwaddr iova, uint64_t size,
                            void *vaddr, bool readonly, MemoryRegion *mr);
 int vfio_container_dma_unmap(VFIOContainer *bcontainer,
-                             hwaddr iova, ram_addr_t size,
+                             hwaddr iova, uint64_t size,
                              IOMMUTLBEntry *iotlb, bool unmap_all);
 bool vfio_container_add_section_window(VFIOContainer *bcontainer,
                                        MemoryRegionSection *section,
@@ -167,7 +167,7 @@ struct VFIOIOMMUClass {
      * Returns 0 to indicate success and -errno otherwise.
      */
     int (*dma_map)(const VFIOContainer *bcontainer,
-                   hwaddr iova, ram_addr_t size,
+                   hwaddr iova, uint64_t size,
                    void *vaddr, bool readonly, MemoryRegion *mr);
     /**
      * @dma_map_file
@@ -182,7 +182,7 @@ struct VFIOIOMMUClass {
      * @readonly: map read only if true
      */
     int (*dma_map_file)(const VFIOContainer *bcontainer,
-                        hwaddr iova, ram_addr_t size,
+                        hwaddr iova, uint64_t size,
                         int fd, unsigned long start, bool readonly);
     /**
      * @dma_unmap
@@ -198,7 +198,7 @@ struct VFIOIOMMUClass {
      * Returns 0 to indicate success and -errno otherwise.
      */
     int (*dma_unmap)(const VFIOContainer *bcontainer,
-                     hwaddr iova, ram_addr_t size,
+                     hwaddr iova, uint64_t size,
                      IOMMUTLBEntry *iotlb, bool unmap_all);
 
 
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index 411eb7b28b7..e45192fef65 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -39,7 +39,7 @@ static void vfio_user_listener_commit(VFIOContainer *bcontainer)
 }
 
 static int vfio_user_dma_unmap(const VFIOContainer *bcontainer,
-                               hwaddr iova, ram_addr_t size,
+                               hwaddr iova, uint64_t size,
                                IOMMUTLBEntry *iotlb, bool unmap_all)
 {
     VFIOUserContainer *container = VFIO_IOMMU_USER(bcontainer);
@@ -81,7 +81,7 @@ static int vfio_user_dma_unmap(const VFIOContainer *bcontainer,
 }
 
 static int vfio_user_dma_map(const VFIOContainer *bcontainer, hwaddr iova,
-                             ram_addr_t size, void *vaddr, bool readonly,
+                             uint64_t size, void *vaddr, bool readonly,
                              MemoryRegion *mrp)
 {
     VFIOUserContainer *container = VFIO_IOMMU_USER(bcontainer);
diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
index c0f87f774a0..3a710d8265c 100644
--- a/hw/vfio/container-legacy.c
+++ b/hw/vfio/container-legacy.c
@@ -69,7 +69,7 @@ static int vfio_ram_block_discard_disable(VFIOLegacyContainer *container,
 }
 
 static int vfio_dma_unmap_bitmap(const VFIOLegacyContainer *container,
-                                 hwaddr iova, ram_addr_t size,
+                                 hwaddr iova, uint64_t size,
                                  IOMMUTLBEntry *iotlb)
 {
     const VFIOContainer *bcontainer = VFIO_IOMMU(container);
@@ -122,7 +122,7 @@ unmap_exit:
 }
 
 static int vfio_legacy_dma_unmap_one(const VFIOContainer *bcontainer,
-                                     hwaddr iova, ram_addr_t size,
+                                     hwaddr iova, uint64_t size,
                                      IOMMUTLBEntry *iotlb)
 {
     const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
@@ -185,7 +185,7 @@ static int vfio_legacy_dma_unmap_one(const VFIOContainer *bcontainer,
  * DMA - Mapping and unmapping for the "type1" IOMMU interface used on x86
  */
 static int vfio_legacy_dma_unmap(const VFIOContainer *bcontainer,
-                                 hwaddr iova, ram_addr_t size,
+                                 hwaddr iova, uint64_t size,
                                  IOMMUTLBEntry *iotlb, bool unmap_all)
 {
     int ret;
@@ -210,7 +210,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainer *bcontainer,
 }
 
 static int vfio_legacy_dma_map(const VFIOContainer *bcontainer, hwaddr iova,
-                               ram_addr_t size, void *vaddr, bool readonly,
+                               uint64_t size, void *vaddr, bool readonly,
                                MemoryRegion *mr)
 {
     const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 9d694393714..b5af3ac174c 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -15,7 +15,6 @@
 
 #include "qemu/osdep.h"
 #include "system/tcg.h"
-#include "system/ram_addr.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/vfio/vfio-container.h"
@@ -74,7 +73,7 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
 }
 
 int vfio_container_dma_map(VFIOContainer *bcontainer,
-                           hwaddr iova, ram_addr_t size,
+                           hwaddr iova, uint64_t size,
                            void *vaddr, bool readonly, MemoryRegion *mr)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
@@ -93,7 +92,7 @@ int vfio_container_dma_map(VFIOContainer *bcontainer,
 }
 
 int vfio_container_dma_unmap(VFIOContainer *bcontainer,
-                             hwaddr iova, ram_addr_t size,
+                             hwaddr iova, uint64_t size,
                              IOMMUTLBEntry *iotlb, bool unmap_all)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
index f0ffe235919..68470d552ec 100644
--- a/hw/vfio/iommufd.c
+++ b/hw/vfio/iommufd.c
@@ -35,7 +35,7 @@
             TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
 
 static int iommufd_cdev_map(const VFIOContainer *bcontainer, hwaddr iova,
-                            ram_addr_t size, void *vaddr, bool readonly,
+                            uint64_t size, void *vaddr, bool readonly,
                             MemoryRegion *mr)
 {
     const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
@@ -46,7 +46,7 @@ static int iommufd_cdev_map(const VFIOContainer *bcontainer, hwaddr iova,
 }
 
 static int iommufd_cdev_map_file(const VFIOContainer *bcontainer,
-                                 hwaddr iova, ram_addr_t size,
+                                 hwaddr iova, uint64_t size,
                                  int fd, unsigned long start, bool readonly)
 {
     const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
@@ -57,7 +57,7 @@ static int iommufd_cdev_map_file(const VFIOContainer *bcontainer,
 }
 
 static int iommufd_cdev_unmap(const VFIOContainer *bcontainer,
-                              hwaddr iova, ram_addr_t size,
+                              hwaddr iova, uint64_t size,
                               IOMMUTLBEntry *iotlb, bool unmap_all)
 {
     const VFIOIOMMUFDContainer *container = VFIO_IOMMU_IOMMUFD(bcontainer);
-- 
2.51.0


