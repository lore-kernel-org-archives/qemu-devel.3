Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1AA0C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 11:53:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFAeS-0007Pc-DG; Wed, 14 May 2025 07:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAeF-0006p5-8T
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:51:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uFAe5-0006Rv-Sm
 for qemu-devel@nongnu.org; Wed, 14 May 2025 07:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747223490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CPjE//v0FbHndDkIbo/kN/ViVZAa/5rEK/Vw1YXqcLc=;
 b=AY6PtHZZeMb37Bpfti8FDXmh/NXyQjX9/3psTrqROu+8+JmwZtkFCfxBlxkJVzAZt/5oR/
 2BJPY+SDfGghasrI1AGY+/Pwp7fpOj2O7e+/d6r2kXkJ9O8d++vra2/uwWKXUgvt3F1mqx
 lg48kiSvpFXCK7hdKt8vaHSIckhTsHM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-PLuNCbasM-ihZbcX03yThQ-1; Wed, 14 May 2025 07:51:29 -0400
X-MC-Unique: PLuNCbasM-ihZbcX03yThQ-1
X-Mimecast-MFC-AGG-ID: PLuNCbasM-ihZbcX03yThQ_1747223488
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43eea5a5d80so38032635e9.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 04:51:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747223488; x=1747828288;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CPjE//v0FbHndDkIbo/kN/ViVZAa/5rEK/Vw1YXqcLc=;
 b=B3lZt9W9U7i+sJ9+fwW1TnF1qRFYFQTM03SGw79IO+lQmJbGsQAxfqy/e6TW7t60qE
 s9Dc+OOFSBpTjxQmZ2R+DdPWn2g5ksJCBpFL30Xgk9yBVwQgFZzh/3lKptThZQrBT1wB
 BuYR7E97OFk321rDrvnN2ReVguVennSPY+ci9nYfOr1fbdgekS/ezIVwyfvsy+m/YfUh
 +Uv/BI4PYM64CqoMJr0n0mziYLEkhh+ldmHWiyX3gZvIxf1mMdzhk627rAv4bz22kFSa
 JfoDJEnVkxeFgaJ3JnDr+rjsjIIDu/GC4IIFVB9FHdxgLSm4yVzZNrRo8XtGnX2OvUBU
 dsqg==
X-Gm-Message-State: AOJu0YxbuIkzkJXh1BEv8FZpUXIWPEaq+dSlrrRGxabj//O35U1TqQDm
 2aYa6bsUxUaYVEa9n5T8jmrPjKqpnWvn28pexiJh0KE6tK5y+CUA/y59o8NrnRAoWeJLeLg34k6
 ugvsaE5dUO7ZaiJALcj6ng/sCASHyKfeghroBjZFuUHELbBlkjrNxA0rACXTGMPgwH6qMmvW3bJ
 pOgi1HkPo9yxqO7Uzsfr9CpGA4WliBNQ==
X-Gm-Gg: ASbGncu3IpnZU6Nh+WBUKI/4EcXWvqkoDEQYtDBOpZqLPh0VM9F4M+naORxdteGiQhd
 l4gxukO+HIGgCR/dpubUxfLf0lRxHRQ2jYnHc6YQ9ZjuOD0cig/wA8taPa9kBgSOL4sSd34judl
 PHgpiWJP9Ugt89XGo48aIeflA8asc/GGZiL5XZFouapgZHv6l/leLJ1BBQd9yeY/3x6VAGckcNe
 m0u3atky8Nbr7HGjt1QRzdj6dQ+xZrAmQDf1Hg33yNrQRVEBJwtYtBZ6k4qm2ailZPadoXyVe58
 y5kH3w==
X-Received: by 2002:a05:600c:8505:b0:43d:45a:8fca with SMTP id
 5b1f17b1804b1-442f216d56emr35291945e9.30.1747223487770; 
 Wed, 14 May 2025 04:51:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQKp3y7z+0XmconLflEqMvyMcNL5AHLdiz2BSm621czVY4VwhYK0zld+RQYlKIFZwYJnb0hw==
X-Received: by 2002:a05:600c:8505:b0:43d:45a:8fca with SMTP id
 5b1f17b1804b1-442f216d56emr35291535e9.30.1747223487342; 
 Wed, 14 May 2025 04:51:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f3951a8csm27659315e9.23.2025.05.14.04.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 04:51:26 -0700 (PDT)
Date: Wed, 14 May 2025 07:51:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 27/27] hw/i386/amd_iommu: Allow migration when explicitly
 create the AMDVI-PCI device
Message-ID: <28931c2e1591deb4bfaaf744fdc8813e96c230f1.1747223385.git.mst@redhat.com>
References: <cover.1747223385.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747223385.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add migration support for AMD IOMMU model by saving necessary AMDVIState
parameters for MMIO registers, device table, command buffer, and event
buffers.

Also change devtab_len type from size_t to uint64_t to avoid 32-bit build
issue.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Message-Id: <20250504170405.12623-3-suravee.suthikulpanit@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.h |  2 +-
 hw/i386/amd_iommu.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 7a28181d9c..5672bdef89 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -329,7 +329,7 @@ struct AMDVIState {
     bool excl_enabled;
 
     hwaddr devtab;               /* base address device table    */
-    size_t devtab_len;           /* device table length          */
+    uint64_t devtab_len;         /* device table length          */
 
     hwaddr cmdbuf;               /* command buffer base address  */
     uint64_t cmdbuf_len;         /* command buffer length        */
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index f5466fdc98..0775c8f3bb 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1611,8 +1611,55 @@ static void amdvi_sysbus_reset(DeviceState *dev)
     amdvi_init(s);
 }
 
+static const VMStateDescription vmstate_amdvi_sysbus_migratable = {
+    .name = "amd-iommu",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .priority = MIG_PRI_IOMMU,
+    .fields = (VMStateField[]) {
+      /* Updated in  amdvi_handle_control_write() */
+      VMSTATE_BOOL(enabled, AMDVIState),
+      VMSTATE_BOOL(ga_enabled, AMDVIState),
+      VMSTATE_BOOL(ats_enabled, AMDVIState),
+      VMSTATE_BOOL(cmdbuf_enabled, AMDVIState),
+      VMSTATE_BOOL(completion_wait_intr, AMDVIState),
+      VMSTATE_BOOL(evtlog_enabled, AMDVIState),
+      VMSTATE_BOOL(evtlog_intr, AMDVIState),
+      /* Updated in amdvi_handle_devtab_write() */
+      VMSTATE_UINT64(devtab, AMDVIState),
+      VMSTATE_UINT64(devtab_len, AMDVIState),
+      /* Updated in amdvi_handle_cmdbase_write() */
+      VMSTATE_UINT64(cmdbuf, AMDVIState),
+      VMSTATE_UINT64(cmdbuf_len, AMDVIState),
+      /* Updated in amdvi_handle_cmdhead_write() */
+      VMSTATE_UINT32(cmdbuf_head, AMDVIState),
+      /* Updated in amdvi_handle_cmdtail_write() */
+      VMSTATE_UINT32(cmdbuf_tail, AMDVIState),
+      /* Updated in amdvi_handle_evtbase_write() */
+      VMSTATE_UINT64(evtlog, AMDVIState),
+      VMSTATE_UINT32(evtlog_len, AMDVIState),
+      /* Updated in amdvi_handle_evthead_write() */
+      VMSTATE_UINT32(evtlog_head, AMDVIState),
+      /* Updated in amdvi_handle_evttail_write() */
+      VMSTATE_UINT32(evtlog_tail, AMDVIState),
+      /* Updated in amdvi_handle_pprbase_write() */
+      VMSTATE_UINT64(ppr_log, AMDVIState),
+      VMSTATE_UINT32(pprlog_len, AMDVIState),
+      /* Updated in amdvi_handle_pprhead_write() */
+      VMSTATE_UINT32(pprlog_head, AMDVIState),
+      /* Updated in amdvi_handle_tailhead_write() */
+      VMSTATE_UINT32(pprlog_tail, AMDVIState),
+      /* MMIO registers */
+      VMSTATE_UINT8_ARRAY(mmior, AMDVIState, AMDVI_MMIO_SIZE),
+      VMSTATE_UINT8_ARRAY(romask, AMDVIState, AMDVI_MMIO_SIZE),
+      VMSTATE_UINT8_ARRAY(w1cmask, AMDVIState, AMDVI_MMIO_SIZE),
+      VMSTATE_END_OF_LIST()
+    }
+};
+
 static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
 {
+    DeviceClass *dc = (DeviceClass *) object_get_class(OBJECT(dev));
     AMDVIState *s = AMD_IOMMU_DEVICE(dev);
     MachineState *ms = MACHINE(qdev_get_machine());
     PCMachineState *pcms = PC_MACHINE(ms);
@@ -1634,6 +1681,7 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
         }
 
         s->pci = AMD_IOMMU_PCI(pdev);
+        dc->vmsd = &vmstate_amdvi_sysbus_migratable;
     } else {
         s->pci = AMD_IOMMU_PCI(object_new(TYPE_AMD_IOMMU_PCI));
         /* This device should take care of IOMMU PCI properties */
-- 
MST


