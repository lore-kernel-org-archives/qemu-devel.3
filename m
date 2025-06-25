Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F64FC7115C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 03:57:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUHFI-0002tU-Re; Tue, 24 Jun 2025 23:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uUHFF-0002so-DE
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 23:56:21 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uUHFC-0002EG-AN
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 23:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750823778; x=1782359778;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tpymHpn+nijunVKbBYR8Eum+TluOcNujC11ASkix3oo=;
 b=Y8SaStIAZYPhL05M9KGQuJ6LozezrGFtYE/wrOCIGOdKQ6avAorpXFfS
 DaGSj6FlfVeGAIbu7WrTn3s8dJuW6KmxdgW+UndlL3FwGJaCANCrZPbkI
 +X858Xe3HLGJ2THl0Ro4rQWDEY6lAaRHk3102SKdU5MPq4RFqf4V94ni3
 1UYOJGsMBKUfO4nAVXlyhBX4PJfAKAKeRCeMUHzutt0eZs/v4Eiujmdn5
 ICWqs+MMwLgK3ZYkOOQ5HcO5uhJw7Zr5uFPRU+c2ySdnzt6J1eKlOG3FJ
 i0kcBKq8Bkl0SBazQC67xkDf3IzonhgtYTcyZH8E5BuVT8MtUiT7H6M+W Q==;
X-CSE-ConnectionGUID: ZotafcejS9aaVuNBd89AFg==
X-CSE-MsgGUID: IN2SsoHmSoKxXipNI/GAWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11474"; a="52800071"
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; d="scan'208";a="52800071"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jun 2025 20:56:14 -0700
X-CSE-ConnectionGUID: Pd4ItP/zTcGzFqfvI88msQ==
X-CSE-MsgGUID: o+wPGyVxRYWMuZVCfMAsTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,263,1744095600"; d="scan'208";a="151848920"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa009.jf.intel.com with ESMTP; 24 Jun 2025 20:56:13 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 xiaoyao.li@intel.com, qemu-devel@nongnu.org
Subject: [PATCH 1/2] i386/Kconfig: Make I386 and X86_64 independant
Date: Wed, 25 Jun 2025 11:49:02 +0800
Message-ID: <20250625034903.2770272-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250625034903.2770272-1-xiaoyao.li@intel.com>
References: <20250625034903.2770272-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.20; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

Commit 4921d0a7535b ('i386: switch boards to "default y"') makes
CONIFG_X86_64 select CONFIG_I386, which makes it difficult to define
X86_64 only configs, e.g., for TDX.

Decouple I386 from X86_64.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 hw/i386/Kconfig     | 10 +++++-----
 target/i386/Kconfig |  1 -
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index eb65bda6e071..6fc353930985 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -74,7 +74,7 @@ config PC_ACPI
 config I440FX
     bool
     default y
-    depends on I386
+    depends on (I386 || X86_64)
     imply E1000_PCI
     imply VMPORT
     imply VMMOUSE
@@ -91,7 +91,7 @@ config I440FX
 config ISAPC
     bool
     default y
-    depends on I386
+    depends on (I386 || X86_64)
     imply VGA_ISA
     select ISA_BUS
     select PC
@@ -103,7 +103,7 @@ config ISAPC
 config Q35
     bool
     default y
-    depends on I386
+    depends on (I386 || X86_64)
     imply VTD
     imply AMD_IOMMU
     imply E1000E_PCI_EXPRESS
@@ -122,7 +122,7 @@ config Q35
 config MICROVM
     bool
     default y
-    depends on I386 && FDT
+    depends on (I386 || X86_64) && FDT
     select DEVICE_TREE
     select SERIAL_ISA # for serial_hds_isa_init()
     select ISA_BUS
@@ -168,4 +168,4 @@ config VMMOUSE
 config XEN_EMU
     bool
     default y
-    depends on KVM && I386
+    depends on KVM && (I386 || X86_64)
diff --git a/target/i386/Kconfig b/target/i386/Kconfig
index 6b0feef02997..f16efa7137d5 100644
--- a/target/i386/Kconfig
+++ b/target/i386/Kconfig
@@ -6,4 +6,3 @@ config I386
 
 config X86_64
     bool
-    select I386
-- 
2.43.0


