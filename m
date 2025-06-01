Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 765FDC54FB3
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Jun 2025 15:25:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLkYo-0001rW-4b; Sun, 01 Jun 2025 11:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkYa-0001qp-3X
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uLkYW-0004O6-S6
 for qemu-devel@nongnu.org; Sun, 01 Jun 2025 11:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748791495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rTv0d6cHxOZy6ieVobHNUbUpmmn/DNQanxQCmUwQh7c=;
 b=LYFYipz3DFwC52CcNnPbIpg7LJv54PCE5uMaqUes5RHe6wVo1Pa/mn0PbStyGHUF1lq7rq
 PtkfSHKyuOSjsKFXUrwcjScBYzxbLN/B6iCEMjrXA5tgbySQvSIqzZE41BLrWqE5WfrUMe
 +stzS20hNOE/zyHPDCBXLilUKlrMM8g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-8ur90z8oMdOxfqj2XZWkMw-1; Sun, 01 Jun 2025 11:24:53 -0400
X-MC-Unique: 8ur90z8oMdOxfqj2XZWkMw-1
X-Mimecast-MFC-AGG-ID: 8ur90z8oMdOxfqj2XZWkMw_1748791492
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-440667e7f92so24461725e9.3
 for <qemu-devel@nongnu.org>; Sun, 01 Jun 2025 08:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748791491; x=1749396291;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rTv0d6cHxOZy6ieVobHNUbUpmmn/DNQanxQCmUwQh7c=;
 b=A9f1iRqxnyHakjh532aXhSg2S3YwlKZ8fLMnh9Gh/rqXNRdSufAbNz4Y6vPUI+coa+
 /WrXNUhSjuwthmMzTQ8mizm2AoASz7jEQJ8TT3+et1nCnB5BAVr824SQpxoZrfKO4IUC
 lVDfISe8Wc7UCf7Ca9+v3sr7oWv+4vf024DdTEDqvz7QyNQ/Njn4h/sbrHtgDNs0Ckm5
 MFZvc3lOzHpBH9nvlFET4ioB5r69LF5GsrhpjtKZFxRB1nGBbDDhh3M7x5nXqT+fPh8c
 1GTdVPuQFUBw608OVrkvVHmE6QHkoqoY4M9raNFXJniTHK1yXQhNOIxTV6QZneWnUyoH
 Zcdg==
X-Gm-Message-State: AOJu0Yzx1KSjhUCYMjU31G4ME4zL1s80n4WvIhSYwNa5I6A2bAz3Sqtp
 uPwGn8C7bRBIVO9EN6j4JDFQREg6lY+fF9mZJ+HjUNOx7EncwmSa7yULwnfPrG46rMcmyia24yS
 38K//TRy7LQRonDhLm0l4rkaFtldFI3z2fFX6Vfks86AK+2ZH4uXOvGXWQJ9Y6XvQXFMkthMKLG
 EmmARSu7tNiYIZhY0sH9vLP+VHbltI1F3lbQ==
X-Gm-Gg: ASbGncs/m/YWSP3ndK8R6QKT1x2m2BV/sOXnW83OK3Myt0UITKB4thjIx9DqlijExH2
 mFjEKTzVEtOPPyZWFvDiWiQ9C+a+I1AfePw5Spim+xwm2Cz2ewztILlqROeOvDbY8B+DTiOmfw7
 P5ZdRAlAE9eNn04yY++OeELGgRDPS3wGHNej4xsQ7QwS39JnEnK01GI7C1TYYGmulomO2M+DmyY
 OggcxsIE6gYwHlhbzmsJgY+R9dkGD5BDMQxx+jNAEHZVxh9FC1rVV1unVXsZXI5X5JqX+Mo+UKp
 3Q3qgXibiM9oIXLY
X-Received: by 2002:a05:600c:8b0f:b0:43c:f63c:babb with SMTP id
 5b1f17b1804b1-4511ecbbdc4mr39669015e9.1.1748791491278; 
 Sun, 01 Jun 2025 08:24:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL0U/8L6UeynEtKF1ImDj+ymGfJYvxrSyE7yqMsT7JKI1SqMgqiXF/R45KtLgd+NhJ5QLbAw==
X-Received: by 2002:a05:600c:8b0f:b0:43c:f63c:babb with SMTP id
 5b1f17b1804b1-4511ecbbdc4mr39668775e9.1.1748791490829; 
 Sun, 01 Jun 2025 08:24:50 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009745esm11870991f8f.71.2025.06.01.08.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Jun 2025 08:24:49 -0700 (PDT)
Date: Sun, 1 Jun 2025 11:24:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 02/31] hw/i386/amd_iommu: Fix device setup failure when PT is
 on.
Message-ID: <31753d5a336fbb4e9246397f4b90b6f611f27f22.1748791463.git.mst@redhat.com>
References: <cover.1748791463.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1748791463.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.071,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Sairaj Kodilkar <sarunkod@amd.com>

Commit c1f46999ef506 ("amd_iommu: Add support for pass though mode")
introduces the support for "pt" flag by enabling nodma memory when
"pt=off". This allowed VFIO devices to successfully register notifiers
by using nodma region.

But, This also broke things when guest is booted with the iommu=nopt
because, devices bypass the IOMMU and use untranslated addresses (IOVA) to
perform DMA reads/writes to the nodma memory region, ultimately resulting in
a failure to setup the devices in the guest.

Fix the above issue by always enabling the amdvi_dev_as->iommu memory region.
But this will once again cause VFIO devices to fail while registering the
notifiers with AMD IOMMU memory region.

Fixes: c1f46999ef506 ("amd_iommu: Add support for pass though mode")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Message-Id: <20250516100535.4980-2-sarunkod@amd.com>
Fixes: c1f46999ef506 ("amd_iommu: Add support for pass though mode")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
---
 hw/i386/amd_iommu.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 0775c8f3bb..17379db52a 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1426,7 +1426,6 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     AMDVIState *s = opaque;
     AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
     int bus_num = pci_bus_num(bus);
-    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
 
     iommu_as = s->address_spaces[bus_num];
 
@@ -1486,15 +1485,8 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
                                             AMDVI_INT_ADDR_FIRST,
                                             &amdvi_dev_as->iommu_ir, 1);
 
-        if (!x86_iommu->pt_supported) {
-            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
-            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
-                                      true);
-        } else {
-            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu),
-                                      false);
-            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, true);
-        }
+        memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
+        memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as->iommu), true);
     }
     return &iommu_as[devfn]->as;
 }
-- 
MST


