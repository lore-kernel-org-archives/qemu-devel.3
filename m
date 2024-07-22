Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9154C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 00:27:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVgmR-0007yZ-T4; Sun, 21 Jul 2024 20:19:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVglJ-00024d-Jo
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sVglG-0005vo-FP
 for qemu-devel@nongnu.org; Sun, 21 Jul 2024 20:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721607521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qrDoyOU8aLoqXDosKSDaANOTDQMMjAFfwW6ZQlvyVxk=;
 b=ZJOPUbI+drLGKe1cL/rmFS01zhQon5KKovKfmTQasewl07kG2M/rpnftvU8G8VOrC+iN7Q
 oo3RW7y6Ud6Wdb7HnXDZBswv2DtscrAonCZj2rzzXB9R2C650qAfKWxl2yxGwUr+VL2bBg
 fqTmQns615FfJoCPyWm9LvAquMWT4Sc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-DOjRHeDHMGGq2GkFQDRyvg-1; Sun, 21 Jul 2024 20:18:38 -0400
X-MC-Unique: DOjRHeDHMGGq2GkFQDRyvg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-369bf135b49so665350f8f.0
 for <qemu-devel@nongnu.org>; Sun, 21 Jul 2024 17:18:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721607517; x=1722212317;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qrDoyOU8aLoqXDosKSDaANOTDQMMjAFfwW6ZQlvyVxk=;
 b=UuBZUH3BbKmqDdd8g9QD/toeFje772BEZ/lg6vux4d4hJvrRbasa6VlBae2xucNewg
 DYPoWr0yJhGYih6M9tMAFN/ZP9XZPuEPz5t/6/6P5iAzMixU5Iia6/KP90X+qcT/V2sX
 DjzsdgkHgS2HxJJ8zmmfUq3WMYQHGJr3/c0Q0kSfJoSbPnAfZhjvSGJCIHo65k1JZSb8
 NqZ5zJk0pJA5xh+Fyxj5souCIrtUJtOP2ubEs5r1YabtqGrotLv1D6fKqKfLnlrf+QQX
 d6ZAeJrDPpjcOScXbiPaEJ4ZcrP3C0s4hwn+OI8qpkvnmswmgSANg4Vo4aoQ6iW9KIyZ
 8vqA==
X-Gm-Message-State: AOJu0Yy61pVvv8m+618ebjeufsT30TZve5Q5wfm2cQrYkGZqiAt187Rz
 nwErf0g4qp8nzSJiSXrufAMMuRJUa8sVCKpYHpW3BenI3HDEuDfaCK1EgZPePCSoORRYTi5SMxz
 DTGJuccnWJLyKRpUjBvqd8lZ8mtxr4zNg6b2mEsNNbBvq24vLQ3T890M0yabN8STTvCoXzjWOLQ
 m8Xp1OA4FuGpBDo79FWss6q49KaMyaKg==
X-Received: by 2002:a5d:53d0:0:b0:360:728d:8439 with SMTP id
 ffacd0b85a97d-369b66a18camr3956902f8f.2.1721607516836; 
 Sun, 21 Jul 2024 17:18:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoLrhS4w9mdOYGKXhYPKqbrEl4aoz0iTh0xJskX67EREMMdJq5Ff9axOlDY/5bJXnKCUa4Fg==
X-Received: by 2002:a5d:53d0:0:b0:360:728d:8439 with SMTP id
 ffacd0b85a97d-369b66a18camr3956892f8f.2.1721607516303; 
 Sun, 21 Jul 2024 17:18:36 -0700 (PDT)
Received: from redhat.com (mob-5-90-113-158.net.vodafone.it. [5.90.113.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ced33sm7053287f8f.86.2024.07.21.17.18.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jul 2024 17:18:35 -0700 (PDT)
Date: Sun, 21 Jul 2024 20:18:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PULL 49/63] hw/vfio/common: Add vfio_listener_region_del_iommu
 trace event
Message-ID: <82679f515adbd6ebca1908042d873be31989764d.1721607331.git.mst@redhat.com>
References: <cover.1721607331.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721607331.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

Trace when VFIO gets notified about the deletion of an IOMMU MR.
Also trace the name of the region in the add_iommu trace message.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Message-Id: <20240716094619.1713905-6-eric.auger@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/vfio/common.c     | 3 ++-
 hw/vfio/trace-events | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 6d15b36e0b..cfc44a4569 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -599,7 +599,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
         IOMMUMemoryRegion *iommu_mr = IOMMU_MEMORY_REGION(section->mr);
         int iommu_idx;
 
-        trace_vfio_listener_region_add_iommu(iova, end);
+        trace_vfio_listener_region_add_iommu(section->mr->name, iova, end);
         /*
          * FIXME: For VFIO iommu types which have KVM acceleration to
          * avoid bouncing all map/unmaps through qemu this way, this
@@ -725,6 +725,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
     if (memory_region_is_iommu(section->mr)) {
         VFIOGuestIOMMU *giommu;
 
+        trace_vfio_listener_region_del_iommu(section->mr->name);
         QLIST_FOREACH(giommu, &bcontainer->giommu_list, giommu_next) {
             if (MEMORY_REGION(giommu->iommu_mr) == section->mr &&
                 giommu->n.start == section->offset_within_region) {
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index e16179b507..98bd4dccea 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -95,7 +95,8 @@ vfio_region_read(char *name, int index, uint64_t addr, unsigned size, uint64_t d
 vfio_iommu_map_notify(const char *op, uint64_t iova_start, uint64_t iova_end) "iommu %s @ 0x%"PRIx64" - 0x%"PRIx64
 vfio_listener_region_skip(const char *name, uint64_t start, uint64_t end) "SKIPPING %s 0x%"PRIx64" - 0x%"PRIx64
 vfio_spapr_group_attach(int groupfd, int tablefd) "Attached groupfd %d to liobn fd %d"
-vfio_listener_region_add_iommu(uint64_t start, uint64_t end) "region_add [iommu] 0x%"PRIx64" - 0x%"PRIx64
+vfio_listener_region_add_iommu(const char* name, uint64_t start, uint64_t end) "region_add [iommu] %s 0x%"PRIx64" - 0x%"PRIx64
+vfio_listener_region_del_iommu(const char *name) "region_del [iommu] %s"
 vfio_listener_region_add_ram(uint64_t iova_start, uint64_t iova_end, void *vaddr) "region_add [ram] 0x%"PRIx64" - 0x%"PRIx64" [%p]"
 vfio_known_safe_misalignment(const char *name, uint64_t iova, uint64_t offset_within_region, uintptr_t page_size) "Region \"%s\" iova=0x%"PRIx64" offset_within_region=0x%"PRIx64" qemu_real_host_page_size=0x%"PRIxPTR
 vfio_listener_region_add_no_dma_map(const char *name, uint64_t iova, uint64_t size, uint64_t page_size) "Region \"%s\" 0x%"PRIx64" size=0x%"PRIx64" is not aligned to 0x%"PRIx64" and cannot be mapped for DMA"
-- 
MST


