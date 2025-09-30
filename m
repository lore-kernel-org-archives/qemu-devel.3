Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED7CBCAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 09:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3WSM-0004wr-8o; Tue, 30 Sep 2025 05:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3WSF-0004sy-53
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:15:27 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3WS6-000191-OT
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:15:26 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e34bd8eb2so10668045e9.3
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 02:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759223713; x=1759828513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jyfUsjfODVQJYQKbba0puUbRexP7Udvd0C0uJa768IQ=;
 b=EMJo+ZS+AqsG7m1i+RN6muyArAx2TWxJa8egozEDHHQ3jPTa/jIfyjnWuIKgswdSDw
 JaQjkxz9/JHBIA3lII69mGpS9DSv5Aa8enONgLSHrx3GPusLOoWd0/Z3Xg6EwGMKs1PE
 Xv0uuHA2uZg6Wv29Zx+7YyOdtJERW43TFEM3f1vkCE4UuXRyn7heozkbCHMMTPgnSaBU
 JkRJkzCb05BL7GanLzUvN+KqCxbZ2wRyuOTzVBrN5pXKtncQOOy/dQ5/I8mibFTdJbwV
 MmtE9bm4vENdc0pU8Ic6dEi/L6K/lKsxFI3VWd3VMmgNItVt53fJmAj7J07F22N4Vawk
 aaXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759223713; x=1759828513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jyfUsjfODVQJYQKbba0puUbRexP7Udvd0C0uJa768IQ=;
 b=koXk+I8IMHnGs3AkBGCpe+R4yjX2DqQUTqA0w4VWrFNb5cF8DsJ/AoA/lIkmHkwwgH
 waS4hc9QmEvbXO/aq1VfudNnyusUd6RnGCfS2l75FmY/WAoZP5aoQNo/OFYAGiKYGV/8
 +qs8DjOi9YPzj00CXFm0w7M2rxGUwjMvtL3UPW5ZpbPpY3KCWkR3/qOU4DdK307+8YjU
 mK+T4p4VAgPGm6975Qi9F0ikSvEDTYQwT8nke/hgpuOBX4rKIPcZ2f42vj5F/8Y4OC8z
 hPNwUvfRCWDSyz7t7SldjKVcaRuIajdUE66NbSPdSKtXB+U2p3GsKrXXSrj0KddmZRMc
 Jkxw==
X-Gm-Message-State: AOJu0YzQeSvQ7xn/N41TYetWuSomvED7lq9Y9YLYrqcZs3SgW3HA2lOd
 8btnrMqDqMCRBj63NO7r56wfczm71817fyj9hoAzrjOUziIJ+U8blc6IWIJcjR5h2jM6jn1Co2G
 H8jVNLRIKMQ==
X-Gm-Gg: ASbGncvC6zPel4tRXRkH9vosBiYnVU0sVEYk1LcIGjKY36ihN8wpB2fTw27cd1nbBkX
 okDyUME0paiFB4/PkGMELiGlvCbzzyGmB/rP5X9VNJVBPoYgd+vg5Wu/llJI24G+2U7cWQ3dmH3
 zwGWAC0DzZ4vb49SSs6TJbLHakAJVJiwYtcGP53UwNrjnweO2g2DYBy5yGZoOgnkF4lQzfti9Nk
 jTal47zpGPieXJhixniJN0tQMwkhxmhMj+dZkOMdcntf6JwP/khFeHgWrh+s19f+00M0McKltXT
 uMlWq3Rlul8u6t5NNZfoxQxsJb36GiWLa1+glhjp3GKGrS/GYuJEYgx8GEThVjShu0ggI8Sta+b
 ZMsL+Q+oYnOVbvy4JBcogShCgnc+dHLw5wNQBqKb0KG1NOd0azktk4ct5xChU5PjMixgIcVBBZS
 308Qn8q+gKowZxeSoSCiKS
X-Google-Smtp-Source: AGHT+IHrJ1AOAIg3tX8s3cG29OdXc6+pUMYGelwaFUNI33VZputogZi6W5363Py7mIXbHlAe9FVEJA==
X-Received: by 2002:a05:6000:2410:b0:3ee:13ba:e133 with SMTP id
 ffacd0b85a97d-40e4354d631mr17350108f8f.1.1759223712906; 
 Tue, 30 Sep 2025 02:15:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb74e46bcsm22011810f8f.8.2025.09.30.02.15.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 02:15:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thanos Makatos <thanos.makatos@nutanix.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/3] hw/vfio: Use uint64_t for IOVA mapping size in
 vfio_container_dma_*map
Date: Tue, 30 Sep 2025 11:14:56 +0200
Message-ID: <20250930091456.34524-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930091456.34524-1-philmd@linaro.org>
References: <20250930091456.34524-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 include/hw/vfio/vfio-cpr.h       |  2 +-
 hw/vfio-user/container.c         |  4 ++--
 hw/vfio/container-legacy.c       |  8 ++++----
 hw/vfio/container.c              |  4 ++--
 hw/vfio/cpr-legacy.c             |  2 +-
 hw/vfio/iommufd.c                |  6 +++---
 7 files changed, 18 insertions(+), 18 deletions(-)

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
 
 
diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
index 26ee0c4fe15..81f4e24e229 100644
--- a/include/hw/vfio/vfio-cpr.h
+++ b/include/hw/vfio/vfio-cpr.h
@@ -21,7 +21,7 @@ struct VFIOIOMMUFDContainer;
 struct IOMMUFDBackend;
 
 typedef int (*dma_map_fn)(const struct VFIOContainer *bcontainer,
-                          hwaddr iova, ram_addr_t size, void *vaddr,
+                          hwaddr iova, uint64_t size, void *vaddr,
                           bool readonly, MemoryRegion *mr);
 
 typedef struct VFIOContainerCPR {
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
index 9d694393714..41de3439246 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -74,7 +74,7 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
 }
 
 int vfio_container_dma_map(VFIOContainer *bcontainer,
-                           hwaddr iova, ram_addr_t size,
+                           hwaddr iova, uint64_t size,
                            void *vaddr, bool readonly, MemoryRegion *mr)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
@@ -93,7 +93,7 @@ int vfio_container_dma_map(VFIOContainer *bcontainer,
 }
 
 int vfio_container_dma_unmap(VFIOContainer *bcontainer,
-                             hwaddr iova, ram_addr_t size,
+                             hwaddr iova, uint64_t size,
                              IOMMUTLBEntry *iotlb, bool unmap_all)
 {
     VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index bbf7a0d35f0..3a1d126556e 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -39,7 +39,7 @@ static bool vfio_dma_unmap_vaddr_all(VFIOLegacyContainer *container,
  * The incoming state is cleared thereafter.
  */
 static int vfio_legacy_cpr_dma_map(const VFIOContainer *bcontainer,
-                                   hwaddr iova, ram_addr_t size, void *vaddr,
+                                   hwaddr iova, uint64_t size, void *vaddr,
                                    bool readonly, MemoryRegion *mr)
 {
     const VFIOLegacyContainer *container = VFIO_IOMMU_LEGACY(bcontainer);
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


