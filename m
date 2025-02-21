Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84B65C021B5
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 12:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlS5A-0000lG-DS; Fri, 21 Feb 2025 07:24:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS53-0000Md-Ro
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tlS51-0007DV-SP
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 07:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740140671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2JcyUMGxDlcrXYgVkAaUWu6KNUElDakyOBWHSKnyH28=;
 b=fMY/cdsLIJPUISzWySV4VJhgQxGC02hb6ZsHHP2MjeM+OHdBN9/rYur6LVA8i5xztxzlvC
 wsCOvptVZ4Vw/rvGt1JPDAYaZReXy+SStYQQBE6k/mRhLXH3FzA+/NBdhZX3Tp1OloKiGY
 hcRO5fdGMRIXXV6WZv6OFt8cmAiTrFY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-6n3ak-6NPi-Kb_q0-Bmg-g-1; Fri, 21 Feb 2025 07:23:21 -0500
X-MC-Unique: 6n3ak-6NPi-Kb_q0-Bmg-g-1
X-Mimecast-MFC-AGG-ID: 6n3ak-6NPi-Kb_q0-Bmg-g_1740140600
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4399c5ba9e4so10937375e9.3
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 04:23:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740140599; x=1740745399;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2JcyUMGxDlcrXYgVkAaUWu6KNUElDakyOBWHSKnyH28=;
 b=XJddo16RdiBhjsOIEZ9HSiPAl9z8jMINYqTQW4v7pq4pHGy6mazzgsFl8kCHBaQc4t
 pnqq2BvHrjBdBj0UxzAJbLBgLzIecKm/WxTap5HtQWdjRZCvkmWghQl6FcGn2bK0qsfw
 b02E3QpUYzOohRtLa7Ewzs6qs5xFttcBTb+KMqFBoS98lZgD5O95demYUBd5hSLlZ0Mb
 Kc1/5UkK97xIzi5PXYrwqdZfOG0vhTo8XwyfbvuV0qzgGEy4BBJ7HyePELCC2O3XYf13
 3tnUV/rQHOEWBkiOuQRHxOc3t7zgKnpETSeZYu+pWKug5jHTa/yWkKcE0KBJ6NOZWn2v
 RCnA==
X-Gm-Message-State: AOJu0YwPvXuZXysUpWnMbA9ywXxAQmDTZlSc/aiLyngp5obB4unUGaOD
 pS3WsqSk5nOsGqpVcqhjB+j+Ov5Fj4BKsiWrbvfQ7NAKhSFcF8TuNGoSnjOykwelGvvVYNEN2UD
 t0LOSguTFBQMdLbqgMG8Wegv3wMiUJimA3h+m0PRtFTINHezd7Nhd6Bqm8Ke4YmsH8T2rnkPrzo
 vK30yy8H7HDs5Ngry9yqxPucoOeIxw0g==
X-Gm-Gg: ASbGncshQZhnauSGeirIADUtRxxNeBiTXm+PI6/Hl/oGtUNPkuvSkyRtgVN38aQ+nAa
 cszs29RB3XgrK3qiuGzkSUckUxWpNpYa6AfRwrYIqICATBhJzo5G/mKSUWMX5iPetxpeOmQOlBb
 iactsKBGD6+D9LY2Yg+ZjDgxK16qCi6oWpmWcofTFSzqcDXOYpXlX3jusVKG0Hi8TENPfiWVvxa
 Lpbv+xQvPxcMv6IhAmJOistIyyu5LYP98fLaS/91z8ars5R7hnZdMDONbVzKqExsUY0WwEbkJ80
 kdbzGQ==
X-Received: by 2002:a05:600c:3d8c:b0:439:9496:17e9 with SMTP id
 5b1f17b1804b1-439ae36d34bmr20372555e9.8.1740140599256; 
 Fri, 21 Feb 2025 04:23:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHu7XyLONuH1jkZt2HcsELssL6ffpIsFOwb9hXXYNdK1mOm+9HV1v6Q23UZmGZ4iQWGYha/LQ==
X-Received: by 2002:a05:600c:3d8c:b0:439:9496:17e9 with SMTP id
 5b1f17b1804b1-439ae36d34bmr20372365e9.8.1740140598919; 
 Fri, 21 Feb 2025 04:23:18 -0800 (PST)
Received: from redhat.com ([31.187.78.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b0371db0sm15474995e9.37.2025.02.21.04.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 04:23:18 -0800 (PST)
Date: Fri, 21 Feb 2025 07:23:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 13/41] pcie_sriov: Register VFs after migration
Message-ID: <f9efcd47110de43dd841ada5bd1a40ec169eabca.1740140520.git.mst@redhat.com>
References: <cover.1740140520.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740140520.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.424,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

pcie_sriov doesn't have code to restore its state after migration, but
igb, which uses pcie_sriov, naively claimed its migration capability.

Add code to register VFs after migration and fix igb migration.

Fixes: 3a977deebe6b ("Intrdocue igb device emulation")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20250116-reuse-v20-11-7cb370606368@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pcie_sriov.h | 2 ++
 hw/pci/pci.c                | 7 +++++++
 hw/pci/pcie_sriov.c         | 7 +++++++
 3 files changed, 16 insertions(+)

diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index 5148c5b77d..c5d2d318d3 100644
--- a/include/hw/pci/pcie_sriov.h
+++ b/include/hw/pci/pcie_sriov.h
@@ -57,6 +57,8 @@ void pcie_sriov_pf_add_sup_pgsize(PCIDevice *dev, uint16_t opt_sup_pgsize);
 void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
                              uint32_t val, int len);
 
+void pcie_sriov_pf_post_load(PCIDevice *dev);
+
 /* Reset SR/IOV */
 void pcie_sriov_pf_reset(PCIDevice *dev);
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 3e29b30d55..69a1b8c298 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -803,10 +803,17 @@ static bool migrate_is_not_pcie(void *opaque, int version_id)
     return !pci_is_express((PCIDevice *)opaque);
 }
 
+static int pci_post_load(void *opaque, int version_id)
+{
+    pcie_sriov_pf_post_load(opaque);
+    return 0;
+}
+
 const VMStateDescription vmstate_pci_device = {
     .name = "PCIDevice",
     .version_id = 2,
     .minimum_version_id = 1,
+    .post_load = pci_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_INT32_POSITIVE_LE(version_id, PCIDevice),
         VMSTATE_BUFFER_UNSAFE_INFO_TEST(config, PCIDevice,
diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
index 69609c112e..1eb4358256 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -248,6 +248,13 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
     }
 }
 
+void pcie_sriov_pf_post_load(PCIDevice *dev)
+{
+    if (dev->exp.sriov_cap) {
+        register_vfs(dev);
+    }
+}
+
 
 /* Reset SR/IOV */
 void pcie_sriov_pf_reset(PCIDevice *dev)
-- 
MST


