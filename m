Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE141CA0ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 02:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjr73-0006fh-TR; Thu, 29 Aug 2024 22:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1sjr71-0006YT-Lz
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 22:11:43 -0400
Received: from zg8tmja5ljk3lje4ms43mwaa.icoremail.net ([209.97.181.73])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>) id 1sjr6y-0003KG-Pa
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 22:11:43 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBX4zRYKtFm8Wo+Ag--.62572S2;
 Fri, 30 Aug 2024 10:11:36 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwD3IbJOKtFmc50pAA--.1107S4;
 Fri, 30 Aug 2024 10:11:30 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan.Cameron@Huawei.com, marcin.juszkiewicz@linaro.org,
 gaoliming@byosoft.com.cn, michael.d.kinney@intel.com,
 ardb+tianocore@kernel.org
Cc: chenbaozi@phytium.com.cn, wangyinfeng@phytium.com.cn,
 shuyiqi@phytium.com.cn, qemu-devel@nongnu.org, devel@edk2.groups.io,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [RFC PATCH 1/1] MdePkg/IndustryStandard: add definitions for ACPI 6.4
 CEDT
Date: Fri, 30 Aug 2024 10:11:17 +0800
Message-Id: <20240830021117.538954-2-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830021117.538954-1-wangyuquan1236@phytium.com.cn>
References: <20240830021117.538954-1-wangyuquan1236@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwD3IbJOKtFmc50pAA--.1107S4
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQANAWbQ2MkBnQAAs2
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxXFW7Aw1kCrW7Gr1xtw13urg_yoW5Ary3pF
 s5Cay5KryDJa97Zr1aqF4Fvr4fKF4Igw1UGFs3ur9xZrWYgw1kuan8Cr18tFyFvr4FgwnF
 qFs2qry5GrsrCFJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=209.97.181.73;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=zg8tmja5ljk3lje4ms43mwaa.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

This adds #defines and struct typedefs for the various structure
types in the ACPI 6.4 CXL Early Discovery Table (CEDT).

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 MdePkg/Include/IndustryStandard/Acpi64.h      |  5 ++
 .../IndustryStandard/CXLEarlyDiscoveryTable.h | 69 +++++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100644 MdePkg/Include/IndustryStandard/CXLEarlyDiscoveryTable.h

diff --git a/MdePkg/Include/IndustryStandard/Acpi64.h b/MdePkg/Include/IndustryStandard/Acpi64.h
index bbe6a3c9eb..c988de8ebf 100644
--- a/MdePkg/Include/IndustryStandard/Acpi64.h
+++ b/MdePkg/Include/IndustryStandard/Acpi64.h
@@ -3169,6 +3169,11 @@ typedef struct {
 ///
 #define EFI_ACPI_6_4_XEN_PROJECT_TABLE_SIGNATURE  SIGNATURE_32('X', 'E', 'N', 'V')
 
+///
+/// "CEDT" CXL Early Discovery Table
+///
+#define EFI_ACPI_6_4_CXL_EARLY_DISCOVERY_TABLE_SIGNATURE  SIGNATURE_32 ('C', 'E', 'D', 'T')
+
 #pragma pack()
 
 #endif
diff --git a/MdePkg/Include/IndustryStandard/CXLEarlyDiscoveryTable.h b/MdePkg/Include/IndustryStandard/CXLEarlyDiscoveryTable.h
new file mode 100644
index 0000000000..84f88dc737
--- /dev/null
+++ b/MdePkg/Include/IndustryStandard/CXLEarlyDiscoveryTable.h
@@ -0,0 +1,69 @@
+/** @file
+  ACPI CXL Early Discovery Table (CEDT) definitions.
+
+  Copyright (c) 2024, Phytium Technology Co Ltd. All rights reserved.
+
+**/
+
+#ifndef __CXL_Early_Discovery_TABLE_H__
+#define __CXL_Early_Discovery_TABLE_H__
+
+#include <IndustryStandard/Acpi.h>
+#include <IndustryStandard/Acpi64.h>
+
+#define EFI_ACPI_CXL_Early_Discovery_TABLE_REVISION_01  0x1   //CXL2.0
+#define EFI_ACPI_CXL_Early_Discovery_TABLE_REVISION_02  0x2   //CXL3.1
+
+#define EFI_ACPI_CEDT_TYPE_CHBS     0x0
+#define EFI_ACPI_CEDT_TYPE_CFMWS    0x1
+
+#pragma pack(1)
+
+///
+/// Table header
+///
+typedef struct {
+  EFI_ACPI_DESCRIPTION_HEADER    Header;
+} EFI_ACPI_6_4_CXL_Early_Discovery_TABLE;
+
+///
+/// Node header definition shared by all structure types
+///
+typedef struct {
+  UINT8     Type;
+  UINT8     Reserved;
+  UINT16    Length;
+} EFI_ACPI_6_4_CEDT_Structure;
+
+///
+/// Definition for CXL Host Bridge Structure
+///
+typedef struct {
+  EFI_ACPI_6_4_CEDT_Structure    header;
+  UINT32                         UID;
+  UINT32                         CXLVersion;
+  UINT32                         Reserved;
+  UINT64                         Base;
+  UINT64                         Length;
+} EFI_ACPI_6_4_CXL_Host_Bridge_Structure;
+
+///
+/// Definition for CXL Fixed Memory Window Structure
+///
+typedef struct {
+  EFI_ACPI_6_4_CEDT_Structure    header;
+  UINT32                         Reserved;
+  UINT64                         BaseHPA;
+  UINT64                         WindowSize;
+  UINT8                          InterleaveMembers;
+  UINT8                          InterleaveArithmetic;
+  UINT16                         Reserved1;
+  UINT32                         Granularity;
+  UINT16                         Restrictions;
+  UINT16                         QtgId;
+  UINT32                         FirstTarget;
+} EFI_ACPI_6_4_CXL_Fixed_Memory_Window_Structure;
+
+#pragma pack()
+
+#endif
-- 
2.34.1


