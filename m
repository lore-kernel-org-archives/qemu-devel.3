Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4FEC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 10:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZTAt-0005u2-TW; Thu, 01 Aug 2024 06:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTAi-0004zi-6i
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:36:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZTAg-0001fi-Ov
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 06:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722508593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YZJrjrbWqX6EKULFw0AJWSDhkMqAw8uHUBrOGrGavqw=;
 b=OiVEX86bOPZ2cb3Av66pDFUXqKGNk0oP4aEt6GRS/S6K8u0ahsnhiwxer+UUZWcZcZPTeW
 c76gDTpe9OdE+RFk4J6Y6yXxFLiJhZos96dBL/8H9TM0o2TRfCS3FKlY4TyzAZWqWYl16e
 8O8H/iU0H7YfVVsO31MP6qKVbknhjRE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-QL1dfpkCM4CPBHoWNfx-aQ-1; Thu, 01 Aug 2024 06:36:30 -0400
X-MC-Unique: QL1dfpkCM4CPBHoWNfx-aQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a77f0eca75bso627675566b.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 03:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722508588; x=1723113388;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YZJrjrbWqX6EKULFw0AJWSDhkMqAw8uHUBrOGrGavqw=;
 b=VQQxMBJJfBUPz9zTSnNYHn9kmfXw00MRIfCsa5vvVFoMcUXu6CzcKKxrU6163W40o5
 ns9QigBQ9A9/3dIOnBQu4cD6nB1ccn17GkGeyb16ush1ROqCHtqLLMC1hI/sD4CHSgn6
 pt2Jn8264dct3LbXOGJgK2uOxyiKkWfO3b7XqLfVAcN5pNjsc7uY1Ybzj9Zb7XKJhiN0
 6KOxpTUprKL2Khj8/7OzstDrgq/eTC8ft95l38e68Pm3jsZOPXxZO+GYIqveOxO6BfnJ
 O4KI9kXejSStTyVWTS1MS27QF15DXS0Gy9xFKL9WSknysuv8tFO7GIMF4lDXn57kFGED
 82ug==
X-Gm-Message-State: AOJu0YyIvFxCJzBfhclsriyrlXiAe4trPNpT24fNdC5MGEqOZskgk62+
 IGKK9l4fX3HKFgTMtY9p9N4lmCAk3DUHwb6HB7FaOCQBS0ZyB3mhlbW21xpOx+QfPTK3goO2aUS
 c4LGQO0wCg/VcM3WRpZFrxjMCJpxJ33cE+WUsUDaEi8WgsmotQnlx58By7RDvV1pdvmpeKbnMYt
 TP+muvDcHdaVx++yQwNmn0NVV8dzqW2Q==
X-Received: by 2002:a17:906:dc8b:b0:a6f:5150:b807 with SMTP id
 a640c23a62f3a-a7daf50c41cmr193577266b.35.1722508588276; 
 Thu, 01 Aug 2024 03:36:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd18rHx+j/26V/QAfEH2YP3UUT1TYMFZURiIRIYE5oZa0GlT6OjfOWdJboo0fN+s5BfCZE3g==
X-Received: by 2002:a17:906:dc8b:b0:a6f:5150:b807 with SMTP id
 a640c23a62f3a-a7daf50c41cmr193573966b.35.1722508587674; 
 Thu, 01 Aug 2024 03:36:27 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab23094sm880206366b.5.2024.08.01.03.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 03:36:25 -0700 (PDT)
Date: Thu, 1 Aug 2024 06:36:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 09/19] Revert "pcie_sriov: Register VFs after migration"
Message-ID: <b9ba81769499533488540b6d5ed7c7569476a427.1722508478.git.mst@redhat.com>
References: <cover.1722508478.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1722508478.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This reverts commit 107a64b9a360cf5ca046852bc03334f7a9f22aef.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pcie_sriov.h | 2 --
 hw/pci/pci.c                | 7 -------
 hw/pci/pcie_sriov.c         | 7 -------
 3 files changed, 16 deletions(-)

diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index c5d2d318d3..5148c5b77d 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -57,8 +57,6 @@ void pcie_sriov_pf_add_sup_pgsize(PCIDevice *dev, uint16_t opt_sup_pgsize);
 void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
                              uint32_t val, int len);
 
-void pcie_sriov_pf_post_load(PCIDevice *dev);
-
 /* Reset SR/IOV */
 void pcie_sriov_pf_reset(PCIDevice *dev);
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 4c7be52951..5c0050e178 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -733,17 +733,10 @@ static bool migrate_is_not_pcie(void *opaque, int version_id)
     return !pci_is_express((PCIDevice *)opaque);
 }
 
-static int pci_post_load(void *opaque, int version_id)
-{
-    pcie_sriov_pf_post_load(opaque);
-    return 0;
-}
-
 const VMStateDescription vmstate_pci_device = {
     .name = "PCIDevice",
     .version_id = 2,
     .minimum_version_id = 1,
-    .post_load = pci_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_INT32_POSITIVE_LE(version_id, PCIDevice),
         VMSTATE_BUFFER_UNSAFE_INFO_TEST(config, PCIDevice,
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 56523ab4e8..fae6acea4a 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -252,13 +252,6 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
     }
 }
 
-void pcie_sriov_pf_post_load(PCIDevice *dev)
-{
-    if (dev->exp.sriov_cap) {
-        register_vfs(dev);
-    }
-}
-
 
 /* Reset SR/IOV */
 void pcie_sriov_pf_reset(PCIDevice *dev)
-- 
MST


