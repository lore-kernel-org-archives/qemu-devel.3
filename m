Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3388C54E41
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 13:42:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riwwy-0005dp-1b; Sat, 09 Mar 2024 08:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1riwwu-0005cC-PW
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 08:41:16 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1riwws-0004dC-KU
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 08:41:16 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-565b434f90aso3599446a12.3
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 05:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709991672; x=1710596472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KXU17ruymLLc6lSn7drp5OcQjoUr1KAP7ri2ERYsk4A=;
 b=OMsyEAZfvEt8v6M8mLY/V/HwOxgFNQ7Q5MB/7rFNQb8L3262nAEfgSLJW/NzoainuS
 SPdPEMex/nSiu2Fn7tusHRtQJGaEupQN5Rc2ZyXvkpd35nfeqs26tv/Tl4/5N7+fLk9t
 N2ZnXtPpUn1usUUCDPlqp5+zs45aKbE+zCAM0B+5j1j5uIBmfiCudAqA1eq86ISusSvX
 nRwIvyyw7WhgTBPoI3iWgLb9eM6qEfsOHf95vval/JR1lu4ZNQAR100Pwb5fYHxpeHtl
 HLmRKgrsz1eeLaIyO1N05z3lVzC3PTri7B5AaIQDwByXX9sVSAza0+zbEDDHVfvZMHpm
 Bl+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709991672; x=1710596472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KXU17ruymLLc6lSn7drp5OcQjoUr1KAP7ri2ERYsk4A=;
 b=SL1auS5toKR4fpqFOeFjI5BFxW6EosxzIsgUqbWCXh5aO2VhvfWDZZIFHICdxKsPkm
 w1vn4fIbaefYNLUkqrNAGjUIvdjJFtSp6f4+tGefWc9lvm3mlgVK3x0vNr8a/JIBedtb
 uvhH+FEHEEJS9avw4KOtfZ1FVBcWhcGWCj3wpCuWZ+H1eH1AKbWRi9KGLCcdHgfdZMgE
 JfTDHxPuQf36StEvPnPyAFyDkEuH3V0VB+6mrEanVT0CL5m2rxjP7sky8aE/oYjsNoDx
 UlEouYPaxJB+HYHFxC8iUVIMMUd6zDENaoEzDqlFqXJ6D5iXIzBOBaILihk7X9o7cxTD
 mnMQ==
X-Gm-Message-State: AOJu0Yz8z/b6iX8Q2vLvz+BGXKTnsm7SuKQzVqn2iNPKcxWX8cDmyNpy
 x8AHB6RP7w27NVhXaWcPn1JMvTYzB8dZCmxOJjql5QjE/MJ78hIU5BHMwFh0
X-Google-Smtp-Source: AGHT+IH0IOZxP5W1euoVZEcK7sOce4YVWAV592bgYJCeC7LR8inBEkPFcS6tJNpk5gNf35uU6l8K6g==
X-Received: by 2002:a50:8e12:0:b0:568:17c0:54dd with SMTP id
 18-20020a508e12000000b0056817c054ddmr1535247edw.35.1709991672099; 
 Sat, 09 Mar 2024 05:41:12 -0800 (PST)
Received: from archlinux.. (dynamic-078-054-250-034.78.54.pool.telefonica.de.
 [78.54.250.34]) by smtp.gmail.com with ESMTPSA id
 b2-20020aa7c902000000b00564e489ce9asm906157edt.12.2024.03.09.05.41.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 05:41:11 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 2/2] hw/pci-host/pam: Remove northbridge-specific
 PAM_REGIONS_COUNT
Date: Sat,  9 Mar 2024 14:40:56 +0100
Message-ID: <20240309134056.1605-3-shentey@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240309134056.1605-1-shentey@gmail.com>
References: <20240309134056.1605-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

PAM_REGIONS_COUNT being 13 seems to be Intel-specific. There are VIA 82cXX
northbridges having only 10, for example. Communicate this by having
northbridge-specific constants.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>

--

Do we need the constants or can we omit them, given they're just used once?
---
 include/hw/pci-host/i440fx.h | 4 +++-
 include/hw/pci-host/pam.h    | 2 --
 include/hw/pci-host/q35.h    | 4 +++-
 hw/pci-host/q35.c            | 2 +-
 4 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/hw/pci-host/i440fx.h b/include/hw/pci-host/i440fx.h
index c988f70890..9e9b252660 100644
--- a/include/hw/pci-host/i440fx.h
+++ b/include/hw/pci-host/i440fx.h
@@ -22,12 +22,14 @@
 
 OBJECT_DECLARE_SIMPLE_TYPE(PCII440FXState, I440FX_PCI_DEVICE)
 
+#define I440FX_HOST_PAM_REGIONS_COUNT 13
+
 struct PCII440FXState {
     /*< private >*/
     PCIDevice parent_obj;
     /*< public >*/
 
-    PAMMemoryRegion pam_regions[PAM_REGIONS_COUNT];
+    PAMMemoryRegion pam_regions[I440FX_HOST_PAM_REGIONS_COUNT];
     MemoryRegion smram_region;
     MemoryRegion smram, low_smram;
 };
diff --git a/include/hw/pci-host/pam.h b/include/hw/pci-host/pam.h
index b9b33aecc8..25dbe6feaf 100644
--- a/include/hw/pci-host/pam.h
+++ b/include/hw/pci-host/pam.h
@@ -79,8 +79,6 @@
 #define SMRAM_C_BASE_SEG_MASK  ((uint8_t)0x7)
 #define SMRAM_C_BASE_SEG       ((uint8_t)0x2)  /* hardwired to b010 */
 
-#define PAM_REGIONS_COUNT       13
-
 typedef struct PAMMemoryRegion {
     MemoryRegion alias[4];  /* index = mode value */
     uint8_t mode;
diff --git a/include/hw/pci-host/q35.h b/include/hw/pci-host/q35.h
index bafcbe6752..618ecf05f4 100644
--- a/include/hw/pci-host/q35.h
+++ b/include/hw/pci-host/q35.h
@@ -35,6 +35,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(Q35PCIHost, Q35_HOST_DEVICE)
 #define TYPE_MCH_PCI_DEVICE "mch"
 OBJECT_DECLARE_SIMPLE_TYPE(MCHPCIState, MCH_PCI_DEVICE)
 
+#define MCH_HOST_PAM_REGIONS_COUNT 13
+
 struct MCHPCIState {
     /*< private >*/
     PCIDevice parent_obj;
@@ -44,7 +46,7 @@ struct MCHPCIState {
     MemoryRegion *pci_address_space;
     MemoryRegion *system_memory;
     MemoryRegion *address_space_io;
-    PAMMemoryRegion pam_regions[PAM_REGIONS_COUNT];
+    PAMMemoryRegion pam_regions[MCH_HOST_PAM_REGIONS_COUNT];
     MemoryRegion smram_region, open_high_smram;
     MemoryRegion smram, low_smram, high_smram;
     MemoryRegion tseg_blackhole, tseg_window;
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 947d9aa9c4..6782bf4216 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -329,7 +329,7 @@ static void mch_update_pam(MCHPCIState *mch)
     int i;
 
     memory_region_transaction_begin();
-    for (i = 0; i < 13; i++) {
+    for (i = 0; i < ARRAY_SIZE(mch->pam_regions); i++) {
         uint8_t reg = pd->config[MCH_HOST_BRIDGE_PAM0 + DIV_ROUND_UP(i, 2)];
         pam_update(&mch->pam_regions[i],
                    (reg >> ((!(i & 1)) * 4)) & MCH_HOST_BRIDGE_PAM_MASK);
-- 
2.44.0


