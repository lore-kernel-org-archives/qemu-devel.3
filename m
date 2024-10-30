Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79999D5CC8C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 10:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t665y-0000eP-VX; Wed, 30 Oct 2024 06:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangyuquan1236@phytium.com.cn>)
 id 1t665s-0000dN-7x
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 06:38:28 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangyuquan1236@phytium.com.cn>) id 1t665p-0007a3-Ms
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 06:38:28 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCn+oWWDCJniL8fAg--.22699S2;
 Wed, 30 Oct 2024 18:38:14 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAfwAXbXmODCJnZStAAA--.25600S4;
 Wed, 30 Oct 2024 18:38:10 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan.Cameron@Huawei.com, marcin.juszkiewicz@linaro.org,
 gaoliming@byosoft.com.cn, michael.d.kinney@intel.com,
 ardb+tianocore@kernel.org
Cc: chenbaozi@phytium.com.cn, qemu-devel@nongnu.org, devel@edk2.groups.io,
 Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [RFC EDK2 PATCH v2 1/1] MdePkg/IndustryStandard: add definitions for
 CXL3.1 CEDT
Date: Wed, 30 Oct 2024 18:37:13 +0800
Message-Id: <20241030103713.415432-2-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241030103713.415432-1-wangyuquan1236@phytium.com.cn>
References: <20241030103713.415432-1-wangyuquan1236@phytium.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwAXbXmODCJnZStAAA--.25600S4
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQAOAWchPJEEgAAAsh
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
 1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxXFWrAF1xGFy5WFy3Xw45Awb_yoW5tw1fpr
 4kAa90ga18AF4fZws7Zanavr48AF4xXw4UGF9xWr9avFWDKwn7WF4DXr1YvrWFyF48K3sF
 qF40q34UCF17u3DanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=wangyuquan1236@phytium.com.cn;
 helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
types in the CXL3.1 CXL Early Discovery Table (CEDT).

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 .../IndustryStandard/CxlEarlyDiscoveryTable.h | 113 ++++++++++++++++++
 1 file changed, 113 insertions(+)
 create mode 100644 MdePkg/Include/IndustryStandard/CxlEarlyDiscoveryTable.h

diff --git a/MdePkg/Include/IndustryStandard/CxlEarlyDiscoveryTable.h b/MdePkg/Include/IndustryStandard/CxlEarlyDiscoveryTable.h
new file mode 100644
index 000000000000..eac23911436b
--- /dev/null
+++ b/MdePkg/Include/IndustryStandard/CxlEarlyDiscoveryTable.h
@@ -0,0 +1,113 @@
+/** @file
+  ACPI CXL Early Discovery Table (CEDT) definitions.
+
+  This file contains the register definitions based on the Compute Express Link
+  (CXL) Specification Revision 3.1.
+
+  Copyright (c) 2024, Phytium Technology Co Ltd. All rights reserved.
+
+  @par Reference(s):
+    - Compute Express Link (CXL) Specification Revision 3.1.
+      (https://computeexpresslink.org/cxl-specification/)
+**/
+
+#ifndef CXL_EARLY_DISCOVERY_TABLE_H_
+#define CXL_EARLY_DISCOVERY_TABLE_H_
+
+#include <IndustryStandard/Acpi.h>
+
+///
+/// "CEDT" CXL Early Discovery Table
+///
+#define CXL_3_1_CXL_EARLY_DISCOVERY_TABLE_SIGNATURE  SIGNATURE_32 ('C', 'E', 'D', 'T')
+
+#define CXL_EARLY_DISCOVERY_TABLE_REVISION_01  0x1   // CXL2.0 ~ CXL3.0
+#define CXL_EARLY_DISCOVERY_TABLE_REVISION_02  0x2   // CXL3.1
+
+#define CEDT_TYPE_CHBS     0x0
+#define CEDT_TYPE_CFMWS    0x1
+#define CEDT_TYPE_CXIMS    0x2
+#define CEDT_TYPE_RDPAS    0x3
+#define CEDT_TYPE_CSDS     0x4
+
+#pragma pack(1)
+
+///
+/// Table header
+///
+typedef struct {
+  EFI_ACPI_DESCRIPTION_HEADER    Header;
+} CXL_3_1_CXL_EARLY_DISCOVERY_TABLE;
+
+///
+/// Node header definition shared by all structure types
+///
+typedef struct {
+  UINT8     Type;
+  UINT8     Reserved;
+  UINT16    Length;
+} CXL_3_1_CEDT_STRUCTURE;
+
+///
+/// Definition for CXL Host Bridge Structure (CHBS)
+///
+typedef struct {
+  CXL_3_1_CEDT_STRUCTURE           Header;
+  UINT32                           UID;
+  UINT32                           CXLVersion;
+  UINT32                           Reserved;
+  UINT64                           Base;
+  UINT64                           Length;
+} CXL_3_1_CXL_HOST_BRIDGE_STRUCTURE;
+
+///
+/// Definition for CXL Fixed Memory Window Structure (CFMWS)
+///
+typedef struct {
+  CXL_3_1_CEDT_STRUCTURE               Header;
+  UINT32                               Reserved;
+  UINT64                               BaseHPA;
+  UINT64                               WindowSize;
+  UINT8                                InterleaveMembers;
+  UINT8                                InterleaveArithmetic;
+  UINT16                               Reserved1;
+  UINT32                               Granularity;
+  UINT16                               Restrictions;
+  UINT16                               QtgId;
+  UINT32                               TargetList[16];
+} CXL_3_1_CXL_FIXED_MEMORY_WINDOW_STRUCTURE;
+
+///
+/// Definition for CXL XOR Interleave Math Structure (CXIMS)
+///
+typedef struct {
+  CXL_3_1_CEDT_STRUCTURE               Header;
+  UINT16                               Reserved;
+  UINT8                                HBIG;
+  UINT8                                NIB;
+  UINT64                               XORMAPLIST[4];
+} CXL_3_1_CXL_XOR_INTERLEAVE_MATH_STRUCTURE;
+
+///
+/// Definition for RCEC Downstream Port Association Structure (RDPAS)
+///
+typedef struct {
+  CXL_3_1_CEDT_STRUCTURE               Header;
+  UINT16                               SegmentNumber;
+  UINT16                               BDF;
+  UINT8                                ProtocolType;
+  UINT64                               BaseAddress;
+} CXL_3_1_RCEC_DOWNSTREAM_PORT_ASSOCIATION_STRUCTURE;
+
+///
+/// Definition for CXL System Description Structure (CSDS)
+///
+typedef struct {
+  CXL_3_1_CEDT_STRUCTURE               Header;
+  UINT16                               Capabilities;
+  UINT16                               Reserved;
+} CXL_3_1_CXL_DOWNSTREAM_PORT_ASSOCIATION_STRUCTURE;
+
+#pragma pack()
+
+#endif
-- 
2.34.1


