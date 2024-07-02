Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F41C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 14:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOeEb-0008UQ-SW; Tue, 02 Jul 2024 10:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeEZ-0008NB-OD
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sOeET-000166-06
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 10:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719929504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H7aKbBLrPfQyo8uVQsyzpZUHAgZT+25N0abSYuF1Pc4=;
 b=Y9YcmC2ah/Hj8+KpJGxBKp+N3Lr06vZapcXG6AcOTEYnuJw3xn1QnuFVtkVFRo1XHGSRpC
 Mb/qoTUJlgh54KLsvNlwg+dcpEZMFlTE5C7e4I7zBwnbfmMtco7R0hb5VjnhLXTQh1TMz0
 ENSyNjP/OV+X9gv8RrP7aawQ4Gjz6Io=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-2D-uLXTLOPmdAc_6wl1mhw-1; Tue, 02 Jul 2024 10:11:42 -0400
X-MC-Unique: 2D-uLXTLOPmdAc_6wl1mhw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3642cc54bbfso2565048f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 07:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719929500; x=1720534300;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H7aKbBLrPfQyo8uVQsyzpZUHAgZT+25N0abSYuF1Pc4=;
 b=cZ3PzAjDB/TDECRxSpkEo1JloyqEqAWYiC9h7FYahZUK/n/uFAp692a5oQXtobUCLi
 wvkY5x45DCYKQcCLjb1KDCK81HYDUYB9Z4IdzsLC/ZGBvAw3ZTIn3s0IJpEEaWUrpZVH
 r7py7qjSDS3MsWb4pEnb1jMfKFvyiRvl2DwOjhdM88vDs1CG3IQd6cdPwjXrLCy2fByQ
 J8jKwteTcdTE8UGx7mDX10ypCc0iRvPuw5B2xRKY/QXE8CfH8CQHymI61BSJID2gqw4p
 CpAdqIc0UreN1NhSiMzr8rpyYtNs6oSk3dTCSquLbAq0ZenX4cVVskYP/RwReyM2IltH
 bAgA==
X-Gm-Message-State: AOJu0Yz4NpDomb3S0F9b5Hf5563wYVb5ODW17Czz80NUIOcKJL/D1c4D
 wqbwdF4dAsBzYgZxxc66jcMTTg4nHbIAO/t2GR79sFLAK4AKrdUjHZgbqirOOT5ziLxs20sL4+6
 4cXwcAJ8+Nj9N89GovSg1j3kfj+3r0RlIQBYigYFIr5CueLhOl4f6Uinr/DnaZnJNgQjJB/jZdS
 u+pvSutg/aftCksz6ewhpBTBX6Cjcm/w==
X-Received: by 2002:a5d:470b:0:b0:366:efab:2fb1 with SMTP id
 ffacd0b85a97d-367756c0143mr5616184f8f.38.1719929500631; 
 Tue, 02 Jul 2024 07:11:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDhsBPrbd+prKf0adDwinBYTnA0MySGgPStU0vXDOCe6tBZ+UOxLHLkkjtazwY+/qD0hJP+g==
X-Received: by 2002:a5d:470b:0:b0:366:efab:2fb1 with SMTP id
 ffacd0b85a97d-367756c0143mr5616165f8f.38.1719929500038; 
 Tue, 02 Jul 2024 07:11:40 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f5:eadd:8c31:db01:9d01:7604])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd687sm13405124f8f.14.2024.07.02.07.11.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 07:11:39 -0700 (PDT)
Date: Tue, 2 Jul 2024 10:11:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 90/91] pcie_sriov: Register VFs after migration
Message-ID: <525d3951082842984945c8baff5b447279565fca.1719929191.git.mst@redhat.com>
References: <cover.1719929191.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719929191.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

pcie_sriov doesn't have code to restore its state after migration, but
igb, which uses pcie_sriov, naively claimed its migration capability.

Add code to register VFs after migration and fix igb migration.

Fixes: 3a977deebe6b ("Intrdocue igb device emulation")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240627-reuse-v10-9-7ca0b8ed3d9f@daynix.com>
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
index e32a69f3fa..fa85f87b1c 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -733,10 +733,17 @@ static bool migrate_is_not_pcie(void *opaque, int version_id)
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
index fae6acea4a..56523ab4e8 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -252,6 +252,13 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
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


