Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43206C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDGI-0008BU-AN; Tue, 23 Jul 2024 07:00:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDFm-00060f-AP
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:00:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDFk-0002te-4w
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qrDoyOU8aLoqXDosKSDaANOTDQMMjAFfwW6ZQlvyVxk=;
 b=Ead2z9nvYNb8s9hcP5ksBaLOVJ1vt1xLuQXulzCNsFf4FmbIvYUhnbrZwChviLFjoKQpTC
 c17pHxjnRiKe7fztIo+qDAGbXnAb4afM4MOTSwa8QqX1KzXXSSNAdsrMa4kn+UZc2KZ99f
 XcnNnEOC9rLBd2PBtl40VP2wiLmwRps=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-SlcFmwKOMvyCU1XHAg1jMg-1; Tue, 23 Jul 2024 07:00:17 -0400
X-MC-Unique: SlcFmwKOMvyCU1XHAg1jMg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-427a7a65e7dso21580245e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 04:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732415; x=1722337215;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qrDoyOU8aLoqXDosKSDaANOTDQMMjAFfwW6ZQlvyVxk=;
 b=TLJAXPi0G6HSocF72tVZrSxanT3Gtf6SXgAK1GuU0Ng/b3Xo2pSG3frW12OB5Uiad0
 Yn/AmrdzqHYpatAGlB1OItFFV2XV8wzhMezzkkrtttCx+MQTQN2EN7C6mkle7xKZ5MHH
 y/LPIId53hn77VWRDgF2OFHrFlz19Lp+ReO3YBfMuxceuRQKcoFvC6f1TfibU9fupM8Q
 hyPSNOEtKcqspkTizZpq3XOqOA/3UlDV8OCCk81rE6Hr1plPXAHkHR0+XTkHKWZQbusA
 lB6oVX/HmHVYSssbsowQ1KUuz0bH+brn0JR5mlGpIoRZcj1ak3yvSDRq3K2M9cJH7FhJ
 lfWA==
X-Gm-Message-State: AOJu0YyMg4XZ336kAr59ExhptKTvX4j98cDoCEuHQJrxnZ/7PKw0hVhx
 jpYAzfrWcjBcrh87JzoTFSWvRUp/hhgJmX3/B73rBE4XW3isi/zdjWQDYT2eL+hdUYUjT+rAw71
 N/Xlfd03GJkdNXnhxDCa4cub544p34LWJ9Q8rN0C5mBOfsM/OJYpKHBG6kpQiqEWqTnfi5jdeDT
 Ne7GeKAamR57EES6ED3BTnEQGL7X5NVQ==
X-Received: by 2002:a05:600c:3504:b0:426:6eb6:1374 with SMTP id
 5b1f17b1804b1-427eef58c6fmr14045925e9.0.1721732415776; 
 Tue, 23 Jul 2024 04:00:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfafN4lDxgYgbXHTAVzIRDQhBtOA3sYlDRqUCS/oFzlj1zIkomEFRXOFphrBxX18vIr79fYA==
X-Received: by 2002:a05:600c:3504:b0:426:6eb6:1374 with SMTP id
 5b1f17b1804b1-427eef58c6fmr14045525e9.0.1721732415220; 
 Tue, 23 Jul 2024 04:00:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d7263687sm166867875e9.4.2024.07.23.04.00.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 04:00:14 -0700 (PDT)
Date: Tue, 23 Jul 2024 07:00:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PULL v2 48/61] hw/vfio/common: Add vfio_listener_region_del_iommu
 trace event
Message-ID: <a6586419a13ec9698428d9585ef8540c594f978f.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


