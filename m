Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC067C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 14:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhqnZ-0007JH-JD; Fri, 01 Aug 2025 10:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhO-0005RQ-I4
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uhqhK-0002iA-V1
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754058325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=skaRuHczCVKfOwEwu0xPYWoe46Si7UXt2McCcCPTErQ=;
 b=bQFgdzAaQgxTa27eY1c3p5ekSoZiQNRLD5niHzYrsfpbkzVUkGQMMSFqD1zIqLRNlToJZs
 CxCSHjk1X6vpJecq7Gm80WXy+pOmiQyRyqP+7/rzDwRBW+1SattjBcWU2CObDcXipVFJ/2
 OJgcuZbKbf0XjrT8m7UFQF9VUL6pyy4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-tu4jVcxYPf6HC6GjGpujYw-1; Fri, 01 Aug 2025 10:25:24 -0400
X-MC-Unique: tu4jVcxYPf6HC6GjGpujYw-1
X-Mimecast-MFC-AGG-ID: tu4jVcxYPf6HC6GjGpujYw_1754058323
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4560a30a793so3202195e9.3
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754058322; x=1754663122;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=skaRuHczCVKfOwEwu0xPYWoe46Si7UXt2McCcCPTErQ=;
 b=hZzci7Vm2d8r/Z+Xz1X4PFp2ekCHJIbaMQ9RcjFqQTdKsGzVuzIA5+2hxL53V6w8om
 phreh3Vrk1eqpass6u7maGiCeP3uX1goZAq+I/7hDFrjohgsd1dijLzXPbgFs94a9q5U
 3oudDzIBgv1D02SxmlHT2DowResP3ShgZjagaDVnTnDPWYshyCGE4m4yYZkyaqXY5HDX
 O5l9tUP3gc09I/7zBmXhhUdYKvIfsE7ocEM2kM/HaMOd/F2O4yizGRJ/inxBPuQXdHHF
 pcp+zPBkzcDJcpRApAeGFrptUKpCRCpbW6f1OkAI0iefJ5nHQkwXl2UWETixPp5LBQQf
 GBXQ==
X-Gm-Message-State: AOJu0YzPm9FU40WhlEVAOK0TWNlK9+l4qRZgftn9OaPxXGlZAhWKFrtv
 Zryy9+cnzeVU93ZcE7/ewstIhjYU9uPksM2PcCgNPWbO9p8zWAg2rrQUpZfmxxByEmfoaQcOEKv
 NLBMxtFkfh9Uxwh3gQr+/4LxkCBUOHPflgMr50x2DHFHbMsMOdTzLobfMtBRpeZEAgvdeGwVGax
 NX16VguZ7FVsyrSZYyKN23Pp4K010jEOD0vw==
X-Gm-Gg: ASbGnct5LWJm1FFJmwXFiYFy1ZgSGlYJ990vEfD/cgthYCSo6B/FEMihgnVxTJqycEF
 7cDq3A1LThmVdFUkiB/qlCKKTjzUH4KRvweK37KjavjcK03+NGDrWLyRrX5Irr2ffUKpNkW1M0/
 +/5W+Ah/wG+LDt/f5UL0qBj3hubX5MYZ4FD6LUR3TdPyoKXXkm2ey1JZ7QXbUwJ4t22GDeUAI0k
 9ZGJcPMob6dVS+9GUrMulPMH6kU0m5BB132kXNs2oHQhAXMsJ5OajaxAJlRlfAEF9DfdVLJp4A8
 U46Qn6TO714QCoZ50rwT8hrAUhpABDHn
X-Received: by 2002:a05:600c:1994:b0:445:1984:247d with SMTP id
 5b1f17b1804b1-45892b9530amr98227555e9.7.1754058322244; 
 Fri, 01 Aug 2025 07:25:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIGEyaBIvTZG0korKrC2t8k4QdI9uBOjsgVFbrFH20LswoJgbVsAqIWBcfeMfqwjaEa7o5cg==
X-Received: by 2002:a05:600c:1994:b0:445:1984:247d with SMTP id
 5b1f17b1804b1-45892b9530amr98227225e9.7.1754058321647; 
 Fri, 01 Aug 2025 07:25:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953e9b1csm102063335e9.22.2025.08.01.07.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Aug 2025 07:25:21 -0700 (PDT)
Date: Fri, 1 Aug 2025 10:25:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 08/17] hw/i386/amd_iommu: Move IOAPIC memory region
 initialization to the end
Message-ID: <a7842d94067cddc80b47ac42fb6e49e2fc02a3c5.1754058276.git.mst@redhat.com>
References: <cover.1754058276.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754058276.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Sairaj Kodilkar <sarunkod@amd.com>

Setting up IOAPIC memory region requires mr_sys and mr_ir. Currently
these two memory regions are setup after the initializing the IOAPIC
memory region, which cause `amdvi_host_dma_iommu()` to use unitialized
mr_sys and mr_ir.

Move the IOAPIC memory region initialization to the end in order to use
the mr_sys and mr_ir regions after they are fully initialized.

Fixes: 577c470f4326 ("x86_iommu/amd: Prepare for interrupt remap support")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Message-Id: <20250801060507.3382-4-sarunkod@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 037e78056d..7308611bf1 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1698,9 +1698,6 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
                                      amdvi_uint64_equal, g_free, g_free);
 
-    /* Pseudo address space under root PCI bus. */
-    x86ms->ioapic_as = amdvi_host_dma_iommu(bus, s, AMDVI_IOAPIC_SB_DEVID);
-
     /* set up MMIO */
     memory_region_init_io(&s->mr_mmio, OBJECT(s), &mmio_mem_ops, s,
                           "amdvi-mmio", AMDVI_MMIO_SIZE);
@@ -1723,6 +1720,9 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion_overlap(&s->mr_sys, AMDVI_INT_ADDR_FIRST,
                                         &s->mr_ir, 1);
 
+    /* Pseudo address space under root PCI bus. */
+    x86ms->ioapic_as = amdvi_host_dma_iommu(bus, s, AMDVI_IOAPIC_SB_DEVID);
+
     if (kvm_enabled() && x86ms->apic_id_limit > 255 && !s->xtsup) {
         error_report("AMD IOMMU with x2APIC configuration requires xtsup=on");
         exit(EXIT_FAILURE);
-- 
MST


