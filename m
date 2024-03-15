Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FABC54E66
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 03:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkyiQ-0002gB-DM; Thu, 14 Mar 2024 23:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rkyiJ-0002dC-8Z
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 23:58:36 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rkyiD-00023h-6Q
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 23:58:30 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6e6b54a28d0so1465475b3a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Mar 2024 20:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1710475107; x=1711079907;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=d2B5PcXjV/WvrmnePjI8Cyfuht09Wwa24XAfpuPwLPk=;
 b=KUygdhwGydOSZxg5fzJvyPeJXKzYO+6TSvm59Wj/Fux97vVqDf5ZVQBFE0TxXHLWTf
 RAcpNPSVwBOkGVoohX7uWofdHO4jEjjZMBYLbKvJim/rhKe31z3Nxi9FPKBVa9nK3Hvi
 uIG+Ts1i4KnIJVr1Y4bMaZ2FUg1bgteu/flOLnIRm7LmCCBKeaBycMyvQ8RYaChAHkS4
 WF9njlL4t450HjdpHDTYErrYVSUbNaIzRoYSSPmFLl8BO6MMbBHBxHjVJqIdZr8IRI69
 wMrgfgaAhVReZaolluY57ygddTwp5XFEEXSZjNlWut/VJyJiLRdB9OnKsSEnUdax38C2
 zESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710475107; x=1711079907;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d2B5PcXjV/WvrmnePjI8Cyfuht09Wwa24XAfpuPwLPk=;
 b=wejXyFWR3jdthpI8X0YirtIjUtfJZV1CCre3gewQuU9CmQdDbBqSW0xN5grX5pOFM+
 k+dzy5Kb9yOJyzUlVGyRzUZgbG+Hwg3jFbP12vQkRRMVLS2/ND1RhL3lHwW9ssFT7n6R
 9VoOkYgwPbj/ppIgHo7Duku2iSmAdpV5AryJ+lKdFgMUpw0kLpe0BdL20+mDOc6PDMI8
 rdFkUZhJu/K2TfeoS0cnNmvC3N5C/b7pjcr0a/KgOI7rsRM/uibcZJ37nfPcvKZ3VPWp
 6EB3B9aiWHWa7BbOSWXvM0yacIN+t54ZdvmtCN61mVn4J9VceHw7wHkD1GLwxzewz1qj
 /EaQ==
X-Gm-Message-State: AOJu0Yy2xhk29aVrF/O5jStFwSLx2sKBkwacUKQCO3Pxmx81dJxdztct
 L5syG90/x7ZYezH4qq5+U7vVmijg+mBdHDE9GcktXpnoG6X+ViA3G/qVRi1vkVQ=
X-Google-Smtp-Source: AGHT+IFF8gJBBOG5sl40yPgi/PIsx15roazvTmbQh+Y+7KklQ6EHeCaeoCHq5jpQmPrvmiaYrocOiw==
X-Received: by 2002:a05:6a00:22c8:b0:6e6:9f03:6a6d with SMTP id
 f8-20020a056a0022c800b006e69f036a6dmr2220382pfj.3.1710475106833; 
 Thu, 14 Mar 2024 20:58:26 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 t188-20020a625fc5000000b006e6f8e9ab6asm328734pfb.15.2024.03.14.20.58.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Mar 2024 20:58:26 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 15 Mar 2024 12:57:54 +0900
Subject: [PATCH for 9.1 v9 07/11] pcie_sriov: Register VFs after migration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240315-reuse-v9-7-67aa69af4d53@daynix.com>
References: <20240315-reuse-v9-0-67aa69af4d53@daynix.com>
In-Reply-To: <20240315-reuse-v9-0-67aa69af4d53@daynix.com>
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
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::433;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
index 793d03c5f12e..d576a8c6be19 100644
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
index 750c2ba696d1..54b375da2d26 100644
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
index fae6acea4acb..56523ab4e833 100644
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
2.44.0


