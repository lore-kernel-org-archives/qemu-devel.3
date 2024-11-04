Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A4FDD1BDF3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84KC-0001HI-VN; Mon, 04 Nov 2024 16:09:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84K8-0000wU-Jk
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:09:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84K6-0005Wx-Nr
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:09:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kPkqbS0KzBZTstIImdMCo6tR4lv6gQtQBT2m2wr8v1o=;
 b=PKQqahs28VwQZl0sXn98Uj/A3iibLGk10CPbsSdYi6pMkTTKRWLn3gdcpq7WqoDfQoT0gW
 h+sWXdQvl2d73Wdn2l1DFPdPY/vJ1+CxYcPdrZkyh4LSjGC/Ghthsn7d3q9ZeLsiqqtIPO
 4aLs5V0Ha9STx75nznSIqlAuGPVeM5o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-4kFSM8Q2OB2IQlezImmHRA-1; Mon, 04 Nov 2024 16:07:31 -0500
X-MC-Unique: 4kFSM8Q2OB2IQlezImmHRA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d5016d21eso2136328f8f.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:07:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754450; x=1731359250;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kPkqbS0KzBZTstIImdMCo6tR4lv6gQtQBT2m2wr8v1o=;
 b=RArsMd4c6HR9KVfZk+hpKWBKD5LIH9xZhkmwsygjbUdVlvbAVKjHt29TtyTrVq4ygk
 HPu2iLTlB7FhqYu4ja1E+0919UvfwAD9FdcQu5GJLe9PBGk+WRGOFd2Do/3W9qOJqEMs
 VXQIFFrS666rSBLKvkcb/xhBukeFYMQcoogwgqJDg4DZSe46N709Pa4/Lq+6EPl/n6EN
 MJ5rwgAD6uJDI6EFa2PRAM3eSjASZqhKVmY1//qdkKgW2YV3xFqRGCZxpqOwHYss6Vxj
 sRdxFPsgkzVz6AjVte5yORvpmEvpmX5Ae3mcBZv8YCoNrMVXHVzQEfbcDRrqDyzDOSYT
 Z5/A==
X-Gm-Message-State: AOJu0YzqtI5KWapFgoR1VVWmCpEFe6pwfIJeKJe0k+xg/q7aL9NqqbRL
 ay7DbNMyU89jT8UyjeK0ebgBHf2Ethl11ENGANAizVn9puQKZ++ebI1jpXXGusYkNX1btdZbaGX
 z7ZHflMaXtZ99RWmocy7EZtokjgXYv0IOXduhLhkF3rwfD4k5rVRuXKBUSEOkl+gvOPl3EK53v6
 2KamiY9mXoKVqFKLUzoBA7MfJoHgDUqQ==
X-Received: by 2002:a5d:4a11:0:b0:374:c92e:f6b1 with SMTP id
 ffacd0b85a97d-380611585f8mr24122078f8f.23.1730754449899; 
 Mon, 04 Nov 2024 13:07:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYK+/Sm79EkWZWY4QxUccwt4jIS0yVBLWIwJRdLMHcemcBVhyXJIizUL7Ro2dB2pu7dhBfdg==
X-Received: by 2002:a5d:4a11:0:b0:374:c92e:f6b1 with SMTP id
 ffacd0b85a97d-380611585f8mr24122054f8f.23.1730754449343; 
 Mon, 04 Nov 2024 13:07:29 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd917fa7sm192135615e9.18.2024.11.04.13.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:07:28 -0800 (PST)
Date: Mon, 4 Nov 2024 16:07:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Santosh Shukla <santosh.shukla@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 29/65] amd_iommu: Add support for pass though mode
Message-ID: <c1f46999ef506d9854534560a94d02cf3cf9edd1.1730754238.git.mst@redhat.com>
References: <cover.1730754238.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730754238.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Introduce 'nodma' shared memory region to support PT mode
so that for each device, we only create an alias to shared memory
region when DMA-remapping is disabled.

Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
Message-Id: <20240927172913.121477-3-santosh.shukla@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.h |  2 ++
 hw/i386/amd_iommu.c | 49 ++++++++++++++++++++++++++++++++++++---------
 2 files changed, 42 insertions(+), 9 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index e5c2ae94f2..be417e51c4 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -354,6 +354,8 @@ struct AMDVIState {
     uint32_t pprlog_tail;        /* ppr log tail */
 
     MemoryRegion mr_mmio;              /* MMIO region                  */
+    MemoryRegion mr_sys;
+    MemoryRegion mr_nodma;
     uint8_t mmior[AMDVI_MMIO_SIZE];    /* read/write MMIO              */
     uint8_t w1cmask[AMDVI_MMIO_SIZE];  /* read/write 1 clear mask      */
     uint8_t romask[AMDVI_MMIO_SIZE];   /* MMIO read/only mask          */
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index abb64ea507..7c7760c573 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -60,8 +60,9 @@ struct AMDVIAddressSpace {
     uint8_t bus_num;            /* bus number                           */
     uint8_t devfn;              /* device function                      */
     AMDVIState *iommu_state;    /* AMDVI - one per machine              */
-    MemoryRegion root;          /* AMDVI Root memory map region */
+    MemoryRegion root;          /* AMDVI Root memory map region         */
     IOMMUMemoryRegion iommu;    /* Device's address translation region  */
+    MemoryRegion iommu_nodma;   /* Alias of shared nodma memory region  */
     MemoryRegion iommu_ir;      /* Device's interrupt remapping region  */
     AddressSpace as;            /* device's corresponding address space */
 };
@@ -1412,6 +1413,7 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     AMDVIState *s = opaque;
     AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
     int bus_num = pci_bus_num(bus);
+    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
     iommu_as = s->address_spaces[bus_num];
 
@@ -1436,13 +1438,13 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
          * Memory region relationships looks like (Address range shows
          * only lower 32 bits to make it short in length...):
          *
-         * |-----------------+-------------------+----------|
-         * | Name            | Address range     | Priority |
-         * |-----------------+-------------------+----------+
-         * | amdvi_root      | 00000000-ffffffff |        0 |
-         * |  amdvi_iommu    | 00000000-ffffffff |        1 |
-         * |  amdvi_iommu_ir | fee00000-feefffff |       64 |
-         * |-----------------+-------------------+----------|
+         * |--------------------+-------------------+----------|
+         * | Name               | Address range     | Priority |
+         * |--------------------+-------------------+----------+
+         * | amdvi-root         | 00000000-ffffffff |        0 |
+         * |  amdvi-iommu_nodma  | 00000000-ffffffff |       0 |
+         * |  amdvi-iommu_ir     | fee00000-feefffff |      64 |
+         * |--------------------+-------------------+----------|
          */
         memory_region_init_iommu(&amdvi_dev_as->iommu,
                                  sizeof(amdvi_dev_as->iommu),
@@ -1461,7 +1463,25 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
                                             64);
         memory_region_add_subregion_overlap(&amdvi_dev_as->root, 0,
                                             MEMORY_REGION(&amdvi_dev_as->iommu),
-                                            1);
+                                            0);
+
+        /* Build the DMA Disabled alias to shared memory */
+        memory_region_init_alias(&amdvi_dev_as->iommu_nodma, OBJECT(s),
+                                 "amdvi-sys", &s->mr_sys, 0,
+                                 memory_region_size(&s->mr_sys));
+        memory_region_add_subregion_overlap(&amdvi_dev_as->root, 0,
+                                            &amdvi_dev_as->iommu_nodma,
+                                            0);
+
+        if (!x86_iommu->pt_supported) {
+            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
+            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
+                                      true);
+        } else {
+            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
+                                      false);
+            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, true);
+        }
     }
     return &iommu_as[devfn]->as;
 }
@@ -1602,6 +1622,17 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
                           "amdvi-mmio", AMDVI_MMIO_SIZE);
     memory_region_add_subregion(get_system_memory(), AMDVI_BASE_ADDR,
                                 &s->mr_mmio);
+
+    /* Create the share memory regions by all devices */
+    memory_region_init(&s->mr_sys, OBJECT(s), "amdvi-sys", UINT64_MAX);
+
+    /* set up the DMA disabled memory region */
+    memory_region_init_alias(&s->mr_nodma, OBJECT(s),
+                             "amdvi-nodma", get_system_memory(), 0,
+                             memory_region_size(get_system_memory()));
+    memory_region_add_subregion_overlap(&s->mr_sys, 0,
+                                        &s->mr_nodma, 0);
+
     pci_setup_iommu(bus, &amdvi_iommu_ops, s);
     amdvi_init(s);
 }
-- 
MST


