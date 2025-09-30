Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9E5CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 12:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Zab-0002G4-TQ; Tue, 30 Sep 2025 08:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3ZaS-0002Fe-Ke
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:36:13 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3ZaI-0007iH-1i
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:36:08 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e42deffa8so50320155e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 05:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759235751; x=1759840551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oXb58rYrjxPuyublF8i/PNw1E8UtKBUjINjyx90boZk=;
 b=UYgec2bUorsGM4utvtQ70vhFacgVL0R+aFuZ7wReMdHjKmzFns9V2qpq0yu58hsnlJ
 AlUe5ZtT+2KnPSQOE2pFGV2HzSVvLU/xcmQ9eDFYegjIHiuk1oIauWI4FBMoMlWoEXy7
 m3r4e5+MCO/0YoECJAKYvxNtVsWYlUWSYPGkFoTTKbfFCxWgxDP46P/di+UHZjajiUfB
 ZgkSuTp3QR6e3+bBw7pHNq7m5enCr0jNVWy9XGr9t6UFe3LluoOz3HeZvHt8cBGryM5h
 zD5NPoyv4aFbdwjCBba27Ff+q1yVefe7d7q7vYoubQkKCg8tUF+LCoBHMuOFiL7ZIlo3
 mXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759235751; x=1759840551;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oXb58rYrjxPuyublF8i/PNw1E8UtKBUjINjyx90boZk=;
 b=srnjRrWaI2YeHdvjI/UDMnWrjSSVBB9dMXRKJUiTthW02Fa77tzVl+j1vwZostorVe
 0pfoGULg1bAy1oenTdZomfLqwqo22Vnpc6nix3s7wBrvMyXzusLUZxTuTuWD0RiKgMgQ
 LuRjgED6wcagR1LVDz6CSP8aYEMafzLX9uaQrrnFYjhDI6iUk35zmIyW9mSbnEuSXl9L
 sGt2rREh31OmMkhUqRFbBj4C8bk8WUqPDsKUgb6S4/6pawXhbFNXdx+nF+SLFVLrbLRr
 F8+A70o3aDPCc7UH1vVOtsKB125Hj5ncpq5c9NFkfkV1jVMX/8bh9mhGuAkV4BBFTyMH
 4tLg==
X-Gm-Message-State: AOJu0YxLIpSPcA6tFjOmYm598hcRbyFqS1vRpYJ3mjQcln81+Y34JoI0
 JCcyjVpr28IKm4TRIBbDOUoOODmo9KZO8YpU/m6wkEaTi55/ZWIIs4BeGvprU96wDO6ljUk6dA5
 Ngl3nexrbDQ==
X-Gm-Gg: ASbGncuWOmUzmCsJZ/w3U4VestJvsILvLr0DSoFfduKuC5CKw8lh/GbbVwsLg9DH0gd
 Oh8xmR7ZJPwV0q3mWTh+aJ/5YLOaFSp0sC1CD/I5M5etYH+coR1nV6Dsk5l5YzjdsqrRL1YH8kL
 WEhhP5cG56ZvwSpe6KPm0xysEFBBU8k8YJLdv4LTlhDEbXv+7vmvceY9HPWvFatCv3pmX/w+sX8
 Uwy2NFqD7F5r2USn747P14RTyLUCItZWuperJF99pH/xWkF5HKlKybRh1aG5eh+lNNey6sSU5G6
 7sYI+qhFlj1FR0uRGlVtuR+6bhnwYZTnnBWhaWt0ZM5yoDfE1vcWe+O7vQ/B0Hh3vLaJEZqGP/6
 DwW98+e5V3oIXNxtIhnEIHkQWAoGvHIJKVekRVsNDOiadJ6V5iWlU5EazEio0OV05hZASCL4/2R
 z9WwzYIGCZ40O1Ou5Te20PztojyNZZ/j9ViiGmBqmKiw==
X-Google-Smtp-Source: AGHT+IGy+sT71JHpBA2kNf2+XMSiLP33E+5QA+bybmolxzdqy2+CWOqIpgm8WYrp0ocmtTKTGmRD7w==
X-Received: by 2002:a05:600c:1ca8:b0:46e:4580:c6c5 with SMTP id
 5b1f17b1804b1-46e4580c7a4mr118528875e9.35.1759235750814; 
 Tue, 30 Sep 2025 05:35:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5603356sm22972284f8f.30.2025.09.30.05.35.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 05:35:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Levon <john.levon@nutanix.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 4/4] hw/vfio: Use uint64_t for IOVA mapping size in
 vfio_container_dma_*map
Date: Tue, 30 Sep 2025 14:35:28 +0200
Message-ID: <20250930123528.42878-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930123528.42878-1-philmd@linaro.org>
References: <20250930123528.42878-1-philmd@linaro.org>
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
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Cédric Le Goater <clg@redhat.com>
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


