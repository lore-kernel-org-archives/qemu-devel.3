Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE4EC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 06:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdkpR-0000eH-0O; Tue, 13 Aug 2024 02:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdkok-00073Q-CR
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:15:38 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sdkog-0003Y5-6y
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 02:15:36 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-70eae5896bcso4612133b3a.2
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 23:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1723529733; x=1724134533;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ou7ZJrgBuVzv4pqn/hJ30lFJuCggSMTVtSP3YbwS9Xw=;
 b=pA2xrd6YH+EbEtUyaA4Az0Nq7TW5sFkqg7qT8TFAYOE2TrJZz8Dp2l8TQieS2jwIRz
 cnMBEIBUS+yAYgsep18fIoRUF4mFFxyjAAz17klgz8VcRXgZhwPG6SoBf/BIYiajbTZg
 q1UohPXi2HMR8p4lKwq99J0TrtDFgChbXoKvyOLJaJ2YlydKOuzjFX+JEj6MKNi8GUjr
 5FhxWJ0XhogBKeOPSmdSdbAtNuUsqemXge0RPjuCU2KbMiS2LCpxB3MRNqC816eGpsbd
 /jL99KsqvR7PVXKBLQXPRdDhhw5ODJxKBIAQLtGHfL05PPP8lQH8Wh9wx1zWcZZ3f3/D
 KfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723529733; x=1724134533;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ou7ZJrgBuVzv4pqn/hJ30lFJuCggSMTVtSP3YbwS9Xw=;
 b=P09L3bVHlpXaMj6MLZbfE86x0II08VvRU9ifCtqVLKLN2BVbY5UP7sxffHarqinPt7
 2pFTUTWYiyUSzhpCAXrv7+7UvF5YRgogUVvEatoXXvlmXHjuHWd9HGKz2SZMPGsNYW4S
 Sc3rzvJzOhMAQC0KMhYEExefUVxQj6KJ04zF3OIE0Zd1f+jO2mePvOuRQgZK0rD3iIuD
 pYaTrZLRk5f1YkVVrKjSGi4MvwzgtBEdgStUvQw3ae3+7xBqV52HvIVBA6dq8YlrulSg
 ybz91QXY1WorZ9tugXBuDRrc1JnPArn36vOFaLeeWhzD4wjsSFX0LiqH69mw2RM1nHC/
 yR7g==
X-Gm-Message-State: AOJu0YyptfNfLgKSRzSw8VXCLfo3LJKuWgrpsBz02IF7kOTxf1bvV27l
 lE2Zp4YY1PBY21/rguNV7AH/HjrQJptvIyW7zrllMEoM0Hyol+2lOP4o2QsslkupxHbOg9EX1uD
 kxQE=
X-Google-Smtp-Source: AGHT+IHx/EpnZ0Lhs8UXd9p2r9G8bwJJMpiaX3jMO/FdaIfyIK1/wBxLDR2GRrxDkV3GvAdxSEIUMA==
X-Received: by 2002:aa7:8891:0:b0:710:4cf5:c570 with SMTP id
 d2e1a72fcca58-71254f5f826mr3640638b3a.0.1723529732626; 
 Mon, 12 Aug 2024 23:15:32 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-710e5ab56c4sm4927787b3a.203.2024.08.12.23.15.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 23:15:32 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 13 Aug 2024 15:14:52 +0900
Subject: [PATCH for-9.2 v14 09/11] pcie_sriov: Register VFs after migration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-reuse-v14-9-4c15bc6ee0e6@daynix.com>
References: <20240813-reuse-v14-0-4c15bc6ee0e6@daynix.com>
In-Reply-To: <20240813-reuse-v14-0-4c15bc6ee0e6@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::434;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

pcie_sriov doesn't have code to restore its state after migration, but
igb, which uses pcie_sriov, naively claimed its migration capability.

Add code to register VFs after migration and fix igb migration.

Fixes: 3a977deebe6b ("Intrdocue igb device emulation")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/hw/pci/pcie_sriov.h | 2 ++
 hw/pci/pci.c                | 7 +++++++
 hw/pci/pcie_sriov.c         | 7 +++++++
 3 files changed, 16 insertions(+)

diff --git a/include/hw/pci/pcie_sriov.h b/include/hw/pci/pcie_sriov.h
index 5148c5b77dd1..c5d2d318d330 100644
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
index 5c0050e1786a..4c7be5295110 100644
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
index 91e817617238..1eae9f0a0acf 100644
--- a/hw/pci/pcie_sriov.c
+++ b/hw/pci/pcie_sriov.c
@@ -242,6 +242,13 @@ void pcie_sriov_config_write(PCIDevice *dev, uint32_t address,
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
2.46.0


