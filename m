Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C494CAC5BD
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 09:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3WSN-0004xO-VU; Tue, 30 Sep 2025 05:15:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3WSF-0004sx-5N
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:15:27 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3WS3-00017Y-9S
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:15:24 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3f0134ccc0cso3886239f8f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 02:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759223708; x=1759828508; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9WFpW9ypRp+isif0eE27JaFFn5D2+mWBML36ZQI1h6A=;
 b=CTi2yeuwHnV2vz9QF9g7xGar/lU5B+Pl7IMfLF53IozlBOZKIYDWkc2Hiu1rhBfDiZ
 Vpgdfukyza+ZG2Fv8utc4jbQk1jXBZ0oIyamjzFqlST9vvwYpZCwM+wXKfC2IIfUxr+G
 3T7Zlt5+X59I97L1sUtI474IxWNClGt98NIThoXJvBDIgbOk54idjo9WufaWeTd8+ng9
 grxGg+7AfLH1c8FTCHfl9VCz5zWM9sUqg/TnqQC2AzUzdmaumu6B28gX8RDqpML2G4XG
 lh6mX24swSK3UMnB1SHrBDnVa6lBAxDlcDdQXBO3LAKI7rJ/LKOfqb1HPMYLwqDnbn5c
 KU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759223708; x=1759828508;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9WFpW9ypRp+isif0eE27JaFFn5D2+mWBML36ZQI1h6A=;
 b=F3yqDLmFgwg+K6nrIZqR926Mej02EPkcC/rdKLN5Hrk7HHSd8dkMdO4Y87iWv5BcW4
 do/6d26On0YJ6fSRHYgU3P15VBdF/nAtiyvngZZDWo8PSUC3lF+VXCnf95s/Z2wIxbcP
 6HRoejkPb094j2j8IS0wgy8UZpysqCdOJGIPVjxo0x8u5pi4cuH9DAcXtCaVV0CkO/fV
 XnoDjzK+uDE+IAiOGGR3oJSgSoPcI5i52hbjN3Cwei1Bt41Ku5mh97fPYZkMwefNZxUZ
 22WyNyFlnnCKnfO+xgNGAo/hihVIjv2vGrp9/K2Crti/UDe3cv3tkYbGuc6RFO+g1/fj
 UbWg==
X-Gm-Message-State: AOJu0YwKCRoNmS/rwh67OvRRCWm0xsyKVseZJBKYet0Bna+vE3mf7ZBN
 LoLxeYKHrXK7lGu6/b/UJkg7ctBnbrtcFcGqB7qh7t3o6SJXdmSM9rerKtl2loNm1GisLeiqRjg
 An4DPm3I7CA==
X-Gm-Gg: ASbGncuGNZbPfFPdEfwkvQmb82112nE9mQTaEIxcaRfZH7Pbz42CH996UfHX+Rn1ujw
 5jvtFedEQqHbHutaJNkSwvfvFKcGLv0FztW4I1DAdrgef+dnmHOJT5RpE/XwkqlHCLKNZEQY0ti
 xwpaTyUp4YrpF9GSloGHcV2Bdbj0Oys9Uw/zTgCVOOI+UJEKF1cA1plZ/NDylizTR6HJrmtRUX6
 b0J+qnVjOs3X3mp3X9PRrt2SREIaGjwowHUF0f5ENmyoMttiLeZmCnmnIA8P54uTgzMyDHGwkfB
 kdRyoPn8wjadKXQU9QmYAWNLNsiekXFvRUz1dBg3s3RCPB2I2GycaTcrpkQtzB4MkxvQ9Sv206U
 +h+8is83g6nFXapJGvqZcCNsMZHU2fjC9TUZLPwaYD442r+EvfWok3Zb03JgWAJ7NwCNxqFl81g
 wg8ySKaJ+vT5Us6GL1BGDg4IFrYCZrGK8=
X-Google-Smtp-Source: AGHT+IH9rK3GzgXLjxZvYt9xiU1DMXIbzMT3q6OC7g2eMAZBYQUcBbaIwuSBzcfSkocqMTULK+xfng==
X-Received: by 2002:a05:6000:25c3:b0:3ec:6259:5096 with SMTP id
 ffacd0b85a97d-40e45b8770fmr15917620f8f.21.1759223707849; 
 Tue, 30 Sep 2025 02:15:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-41f00aebdb7sm9073250f8f.57.2025.09.30.02.15.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 02:15:07 -0700 (PDT)
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
Subject: [PATCH v2 2/3] hw/vfio: Avoid ram_addr_t in
 vfio_container_query_dirty_bitmap()
Date: Tue, 30 Sep 2025 11:14:55 +0200
Message-ID: <20250930091456.34524-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930091456.34524-1-philmd@linaro.org>
References: <20250930091456.34524-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

vfio_container_query_dirty_bitmap() doesn't expect such QEMU
intermediate address, but a guest physical addresses. Use the
appropriate 'hwaddr' type, rename as @translated_addr for
clarity.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/vfio/vfio-container.h |  3 ++-
 hw/vfio/container.c              | 11 ++++++-----
 hw/vfio/listener.c               | 12 ++++++------
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/hw/vfio/vfio-container.h b/include/hw/vfio/vfio-container.h
index b8fb2b8b5d7..093c360f0ee 100644
--- a/include/hw/vfio/vfio-container.h
+++ b/include/hw/vfio/vfio-container.h
@@ -98,7 +98,8 @@ bool vfio_container_dirty_tracking_is_started(
 bool vfio_container_devices_dirty_tracking_is_supported(
     const VFIOContainer *bcontainer);
 int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
-    uint64_t iova, uint64_t size, ram_addr_t ram_addr, Error **errp);
+                                      uint64_t iova, uint64_t size,
+                                      hwaddr translated_addr, Error **errp);
 
 GList *vfio_container_get_iova_ranges(const VFIOContainer *bcontainer);
 
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 250b20f4245..9d694393714 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -246,7 +246,7 @@ static int vfio_container_devices_query_dirty_bitmap(
 
 int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
                                       uint64_t iova, uint64_t size,
-                                      ram_addr_t ram_addr, Error **errp)
+                                      hwaddr translated_addr, Error **errp)
 {
     bool all_device_dirty_tracking =
         vfio_container_devices_dirty_tracking_is_supported(bcontainer);
@@ -255,7 +255,7 @@ int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
     int ret;
 
     if (!bcontainer->dirty_pages_supported && !all_device_dirty_tracking) {
-        cpu_physical_memory_set_dirty_range(ram_addr, size,
+        cpu_physical_memory_set_dirty_range(translated_addr, size,
                                             tcg_enabled() ? DIRTY_CLIENTS_ALL :
                                             DIRTY_CLIENTS_NOCODE);
         return 0;
@@ -280,11 +280,12 @@ int vfio_container_query_dirty_bitmap(const VFIOContainer *bcontainer,
         goto out;
     }
 
-    dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap, ram_addr,
+    dirty_pages = cpu_physical_memory_set_dirty_lebitmap(vbmap.bitmap,
+                                                         translated_addr,
                                                          vbmap.pages);
 
-    trace_vfio_container_query_dirty_bitmap(iova, size, vbmap.size, ram_addr,
-                                            dirty_pages);
+    trace_vfio_container_query_dirty_bitmap(iova, size, vbmap.size,
+                                            translated_addr, dirty_pages);
 out:
     g_free(vbmap.bitmap);
 
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 3b6f17f0c3a..4e2565905e0 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -1059,7 +1059,7 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
     VFIOGuestIOMMU *giommu = gdn->giommu;
     VFIOContainer *bcontainer = giommu->bcontainer;
     hwaddr iova = iotlb->iova + giommu->iommu_offset;
-    ram_addr_t translated_addr;
+    hwaddr translated_addr;
     Error *local_err = NULL;
     int ret = -EINVAL;
     MemoryRegion *mr;
@@ -1108,7 +1108,7 @@ static int vfio_ram_discard_query_dirty_bitmap(MemoryRegionSection *section,
 {
     const hwaddr size = int128_get64(section->size);
     const hwaddr iova = section->offset_within_address_space;
-    const ram_addr_t ram_addr = memory_region_get_ram_addr(section->mr) +
+    const hwaddr addr = memory_region_get_ram_addr(section->mr) +
                                 section->offset_within_region;
     VFIORamDiscardListener *vrdl = opaque;
     Error *local_err = NULL;
@@ -1118,7 +1118,7 @@ static int vfio_ram_discard_query_dirty_bitmap(MemoryRegionSection *section,
      * Sync the whole mapped region (spanning multiple individual mappings)
      * in one go.
      */
-    ret = vfio_container_query_dirty_bitmap(vrdl->bcontainer, iova, size, ram_addr,
+    ret = vfio_container_query_dirty_bitmap(vrdl->bcontainer, iova, size, addr,
                                 &local_err);
     if (ret) {
         error_report_err(local_err);
@@ -1183,7 +1183,7 @@ static int vfio_sync_iommu_dirty_bitmap(VFIOContainer *bcontainer,
 static int vfio_sync_dirty_bitmap(VFIOContainer *bcontainer,
                                   MemoryRegionSection *section, Error **errp)
 {
-    ram_addr_t ram_addr;
+    hwaddr addr;
 
     if (memory_region_is_iommu(section->mr)) {
         return vfio_sync_iommu_dirty_bitmap(bcontainer, section);
@@ -1198,12 +1198,12 @@ static int vfio_sync_dirty_bitmap(VFIOContainer *bcontainer,
         return ret;
     }
 
-    ram_addr = memory_region_get_ram_addr(section->mr) +
+    addr = memory_region_get_ram_addr(section->mr) +
                section->offset_within_region;
 
     return vfio_container_query_dirty_bitmap(bcontainer,
                    REAL_HOST_PAGE_ALIGN(section->offset_within_address_space),
-                                 int128_get64(section->size), ram_addr, errp);
+                                 int128_get64(section->size), addr, errp);
 }
 
 static void vfio_listener_log_sync(MemoryListener *listener,
-- 
2.51.0


