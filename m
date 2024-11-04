Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DB3D1BDF2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 21:08:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t84IQ-0000CT-Bw; Mon, 04 Nov 2024 16:07:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84IN-0008V9-4e
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:07:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t84IL-0005OF-B1
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 16:07:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730754448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fOAN2C/Gq+fL1Um9UhAsgi+uFdrVpTy3qKoA3Bihgaw=;
 b=J4VymFBTJGOZLVrzTl8VcgIpPaxMBEvxNk1IqtntYc4SDNAHVRX4UA01vMb/fcTjFI3t+A
 h5W2c0hiEbJgnd8h/XLuhCRGu+UgN5skii3XRzAjAKQWsJM7e+XcBws5YxJvj+Px8R/YDi
 WElJDqOlTLe/8o40j/NZ1IRYZU1FB34=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-wj61nPwvNUKen6gzOW__cA-1; Mon, 04 Nov 2024 16:07:27 -0500
X-MC-Unique: wj61nPwvNUKen6gzOW__cA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4316e2dde9eso39450635e9.2
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 13:07:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754446; x=1731359246;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fOAN2C/Gq+fL1Um9UhAsgi+uFdrVpTy3qKoA3Bihgaw=;
 b=gv2cIk7b1uHcYh2QpLkXjMCTQYUNxuheTG4TWCVLtSsuD/9TmPgZvznN9Jx/KSSgiL
 7kwNYPhcChqnEYKAz7Ss61a6cp2x1WOhwLhnMq9b4vIAiXzYpzRQYBI7FXzLi95IQYJN
 o8IxdU4318fhIIjiSYSwcYjB5+9mYA0ZGGSAS5Pee3WJLVtVUyNYCHJ+EVUtaXpCOjfh
 9fkrV+cRZTaRdYSQ/L/w0wubp3g33ML4ixJBP8UuszDOmcp4E0WtWGEyuIWDWwgIp3b5
 1SRVhdM/YpKkqjeX0AJeTEPUbYpugJ9mQd27hhoe7RXR99u196ESIY3ubcNKAWG2x01o
 Jfcw==
X-Gm-Message-State: AOJu0YzVRSpax/Qi3Ei4WzDcM6Xd351Y6oJfdG802HzoAW0r7Zbr33uW
 dmxpr5oxKqtm02DDNQw1M330nGeheyhn41zecNekqX6WeVaZb9lcJ6GSF96DZ6QuP8b/pwrU8ty
 XwhvOQrTXM8i6UwX2Un5ExCAvEU391sklNPXPTmlrayQLD0gX9ILJFPFNMahHcAQc68l7RXOpg7
 A+mrkrqfV1JOCcEqG5SutlLBXE9I0AEQ==
X-Received: by 2002:a05:600c:1d1e:b0:431:604d:b22 with SMTP id
 5b1f17b1804b1-43283255922mr142591315e9.16.1730754445927; 
 Mon, 04 Nov 2024 13:07:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlrGv0WZaoqpH0W4hZ1y6wxQgnCqJYzwvp1616S+EbVH2J3gP+Boe5naZ4fr6hfPHQxAtdGw==
X-Received: by 2002:a05:600c:1d1e:b0:431:604d:b22 with SMTP id
 5b1f17b1804b1-43283255922mr142591085e9.16.1730754445468; 
 Mon, 04 Nov 2024 13:07:25 -0800 (PST)
Received: from redhat.com ([2.52.14.134]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5bf225sm163464115e9.11.2024.11.04.13.07.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:07:24 -0800 (PST)
Date: Mon, 4 Nov 2024 16:07:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Santosh Shukla <santosh.shukla@amd.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 28/65] amd_iommu: Rename variable mmio to mr_mmio
Message-ID: <2e6f051cfc58e69dcb392cd245d8f01b0c2e963f.1730754238.git.mst@redhat.com>
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

Rename the MMIO memory region variable 'mmio' to 'mr_mmio'
so to correctly name align with struct AMDVIState::variable type.

No functional change intended.

Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
Message-Id: <20240927172913.121477-2-santosh.shukla@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.h  | 2 +-
 hw/i386/acpi-build.c | 4 ++--
 hw/i386/amd_iommu.c  | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 73619fe9ea..e5c2ae94f2 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -353,7 +353,7 @@ struct AMDVIState {
     uint32_t pprlog_head;        /* ppr log head */
     uint32_t pprlog_tail;        /* ppr log tail */
 
-    MemoryRegion mmio;                 /* MMIO region                  */
+    MemoryRegion mr_mmio;              /* MMIO region                  */
     uint8_t mmior[AMDVI_MMIO_SIZE];    /* read/write MMIO              */
     uint8_t w1cmask[AMDVI_MMIO_SIZE];  /* read/write 1 clear mask      */
     uint8_t romask[AMDVI_MMIO_SIZE];   /* MMIO read/only mask          */
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 508a6094aa..9fcc2897b8 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2324,7 +2324,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     /* Capability offset */
     build_append_int_noprefix(table_data, s->pci.capab_offset, 2);
     /* IOMMU base address */
-    build_append_int_noprefix(table_data, s->mmio.addr, 8);
+    build_append_int_noprefix(table_data, s->mr_mmio.addr, 8);
     /* PCI Segment Group */
     build_append_int_noprefix(table_data, 0, 2);
     /* IOMMU info */
@@ -2359,7 +2359,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     /* Capability offset */
     build_append_int_noprefix(table_data, s->pci.capab_offset, 2);
     /* IOMMU base address */
-    build_append_int_noprefix(table_data, s->mmio.addr, 8);
+    build_append_int_noprefix(table_data, s->mr_mmio.addr, 8);
     /* PCI Segment Group */
     build_append_int_noprefix(table_data, 0, 2);
     /* IOMMU info */
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 464f0b666e..abb64ea507 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1598,10 +1598,10 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     x86ms->ioapic_as = amdvi_host_dma_iommu(bus, s, AMDVI_IOAPIC_SB_DEVID);
 
     /* set up MMIO */
-    memory_region_init_io(&s->mmio, OBJECT(s), &mmio_mem_ops, s, "amdvi-mmio",
-                          AMDVI_MMIO_SIZE);
+    memory_region_init_io(&s->mr_mmio, OBJECT(s), &mmio_mem_ops, s,
+                          "amdvi-mmio", AMDVI_MMIO_SIZE);
     memory_region_add_subregion(get_system_memory(), AMDVI_BASE_ADDR,
-                                &s->mmio);
+                                &s->mr_mmio);
     pci_setup_iommu(bus, &amdvi_iommu_ops, s);
     amdvi_init(s);
 }
-- 
MST


