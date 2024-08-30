Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABCEBCA0ED2
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 03:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjs7h-00067w-QI; Thu, 29 Aug 2024 23:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1sjs7d-00062M-Ne
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 23:16:25 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>) id 1sjs7b-0002Ht-Ez
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 23:16:25 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCH3saDOdFm1Z6AAg--.18288S2;
 Fri, 30 Aug 2024 11:16:19 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwAnVLRyOdFmhaMpAA--.16473S5;
 Fri, 30 Aug 2024 11:16:15 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan.Cameron@Huawei.com, ardb+tianocore@kernel.org,
 quic_llindhol@quicinc.com, peter.maydell@linaro.org
Cc: devel@edk2.groups.io, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 chenbaozi@phytium.com.cn, wangyinfeng@phytium.com.cn,
 shuyiqi@phytium.com.cn, Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [RFC PATCH edk2-platforms 2/2] SbsaQemu: AcpiTables: Add CEDT Table
Date: Fri, 30 Aug 2024 11:15:45 +0800
Message-Id: <20240830031545.548789-3-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830031545.548789-1-wangyuquan1236@phytium.com.cn>
References: <20240830031545.548789-1-wangyuquan1236@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAnVLRyOdFmhaMpAA--.16473S5
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQANAWbQ2MkCEAAAs4
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxWF4kWr47CFWktw1kXF17GFg_yoWrKry3pF
 1IvFZYkr4kA343tr4xGanYvF4YkFya9F4DCa9xXr1UCrsxJF1UXa15Ka4IvFy7J3Z3Zw4D
 GF4Iv34jvr4fu3DanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Provide CXL Early Discovery Table that describes the static CXL
Platform Components of sbsa-ref.

This adds a static CXL Host Bridge structure and a CXL Fixed Memory
Window structure which are implemented as two independent space on
sbsa-ref: [SBSA_CXL_HOST] & [SBSA_CXL_FIXED_WINDOW].

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 .../Qemu/SbsaQemu/AcpiTables/AcpiTables.inf   |  6 +-
 Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc    | 70 +++++++++++++++++++
 Silicon/Qemu/SbsaQemu/SbsaQemu.dec            |  7 ++
 3 files changed, 82 insertions(+), 1 deletion(-)
 create mode 100644 Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc

diff --git a/Silicon/Qemu/SbsaQemu/AcpiTables/AcpiTables.inf b/Silicon/Qemu/SbsaQemu/AcpiTables/AcpiTables.inf
index b4d5aa807bd9..f39b06d708d5 100644
--- a/Silicon/Qemu/SbsaQemu/AcpiTables/AcpiTables.inf
+++ b/Silicon/Qemu/SbsaQemu/AcpiTables/AcpiTables.inf
@@ -21,7 +21,7 @@
   Fadt.aslc
   Mcfg.aslc
   Spcr.aslc
-
+  Cedt.aslc
 [Packages]
   ArmPlatformPkg/ArmPlatformPkg.dec
   ArmPkg/ArmPkg.dec
@@ -78,6 +78,10 @@
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBarSize
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBarLimit
 
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdChbcrBase
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCfmwsBase
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCfmwsSize
+
   gEfiMdeModulePkgTokenSpaceGuid.PcdSerialRegisterBase
 
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdPlatformAhciBase
diff --git a/Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc b/Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc
new file mode 100644
index 000000000000..66c9dc8858bc
--- /dev/null
+++ b/Silicon/Qemu/SbsaQemu/AcpiTables/Cedt.aslc
@@ -0,0 +1,70 @@
+/** @file
+*  CXL Early Discovery Table (CEDT)
+*
+*  Copyright (c) 2024, Phytium Technology Co Ltd. All rights reserved.
+*
+**/
+
+#include <IndustryStandard/CXLEarlyDiscoveryTable.h>
+#include <IndustryStandard/Acpi64.h>
+#include <IndustryStandard/SbsaQemuAcpi.h>
+
+#pragma pack(1)
+
+typedef struct
+{
+  EFI_ACPI_6_4_CXL_Early_Discovery_TABLE           Header;
+  EFI_ACPI_6_4_CXL_Host_Bridge_Structure           Chbs;
+  EFI_ACPI_6_4_CXL_Fixed_Memory_Window_Structure   Cfmws;
+} SBSA_REF_CEDT;
+
+
+SBSA_REF_CEDT Cedt =
+{
+  // EFI_ACPI_6_4_CXL_Early_Discovery_TABLE(Header)
+  {
+     SBSAQEMU_ACPI_HEADER  // EFI_ACPI_DESCRIPTION_HEADER
+     (
+       EFI_ACPI_6_4_CXL_EARLY_DISCOVERY_TABLE_SIGNATURE,
+       SBSA_REF_CEDT,
+       EFI_ACPI_CXL_Early_Discovery_TABLE_REVISION_01
+     ),
+  },
+  // EFI_ACPI_6_4_CXL_Host_Bridge_Structure
+  {
+    // EFI_ACPI_6_4_CEDT_Structure
+    {
+        EFI_ACPI_CEDT_TYPE_CHBS,                                 // Type
+        0,                                                       // Reserved
+        sizeof (EFI_ACPI_6_4_CXL_Host_Bridge_Structure),         // Length
+    },
+    FixedPcdGet32 (PcdCxlBusMin),          // UID
+    0x1,                                   // CXLVersion
+    0,                                     // Reserved
+    FixedPcdGet32 (PcdChbcrBase),          // CHBCR Base
+    0X10000,                               // Length
+  },
+  // EFI_ACPI_6_4_CXL_Fixed_Memory_Window_Structure
+  {
+    // EFI_ACPI_6_4_CEDT_Structure
+    {
+        EFI_ACPI_CEDT_TYPE_CFMWS,                                // Type
+        0,                                                       // Reserved
+        sizeof (EFI_ACPI_6_4_CXL_Fixed_Memory_Window_Structure), // Length
+    },
+    0,                                     // Reserved
+    FixedPcdGet32 (PcdCfmwsBase),          // BaseHPA
+    FixedPcdGet32 (PcdCfmwsSize),          // WindowSize
+    0,                                     // InterleaveMembers
+    0,                                     // InterleaveArithmetic
+    0,                                     // Reserved1
+    0,                                     // Granularity
+    0xF,                                   // Restrictions
+    0,                                     // QtgId
+    FixedPcdGet32 (PcdCxlBusMin),          // FirstTarget
+  }
+};
+
+#pragma pack ()
+
+VOID* CONST ReferenceAcpiTable = &Cedt;
diff --git a/Silicon/Qemu/SbsaQemu/SbsaQemu.dec b/Silicon/Qemu/SbsaQemu/SbsaQemu.dec
index 7d8c7997160b..dff838315d06 100644
--- a/Silicon/Qemu/SbsaQemu/SbsaQemu.dec
+++ b/Silicon/Qemu/SbsaQemu/SbsaQemu.dec
@@ -65,6 +65,13 @@ HardwareInfoLib|Include/Library/HardwareInfoLib.h
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBusMin|254|UINT32|0x00000019
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCxlBusMax|255|UINT32|0x00000020
 
+  # PCDs complementing base address for CXL CHBCR (CXL Host Bridge Component Registers)
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdChbcrBase|0x60120000|UINT64|0x00000021
+
+  # CXL Fixed Memory Window
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCfmwsBase|0xA0000000000|UINT64|0x00000022
+  gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdCfmwsSize|0x10000000000|UINT64|0x00000023
+
 [PcdsDynamic.common]
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdSystemManufacturer|L""|VOID*|0x00000110
   gArmVirtSbsaQemuPlatformTokenSpaceGuid.PcdSystemSerialNumber|L""|VOID*|0x00000111
-- 
2.34.1


