Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EFBC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 16:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKJpj-0004u8-JW; Wed, 28 May 2025 12:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uKJph-0004pR-UP
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:40:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uKJpg-0007Pl-6W
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:40:49 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SCq58v028802;
 Wed, 28 May 2025 16:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=dgYjU
 hbzCWw7BmLWpu5TatEczWO7WDpscTWo1mkxhcA=; b=KlHU4+HjGP9PgXboaKWHl
 thzeHNOgSMXVEDPTREo34VaiM3jB+4SpQzOJKTfiJwruoBH2rSKaGijqwCyHVlPk
 KiTrYyib/0gk54GvfRGMxLArH02j2s7ECxdnlTpvIprbZR8g568650eX3h1ykBkC
 Xqs82GicAhyoqMlQ7zlwZUoEA60eO4m/rpbeGINfEZPbbeCtACEBaooPK8pQpDXc
 LMNj9nD6JmFdOhHbmnqo3UgndyNcoKBLUvXJZ24//Rx0TUzaxnN7rEBtYMeEtiHU
 Bm1OLSV5estsPWmZ6oOmnpoy+vn6rO9j/gbjP+mFoYlurDy1VfUOtI/H0xtZl5cf
 g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v21s6a81-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 16:40:40 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54SGOjuM028466; Wed, 28 May 2025 16:40:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4janpqg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 16:40:39 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54SGa1J2004728;
 Wed, 28 May 2025 16:40:38 GMT
Received: from localhost.localdomain (dhcp-10-43-12-51.usdhcp.oraclecorp.com
 [10.43.12.51])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 46u4janpp8-1; Wed, 28 May 2025 16:40:38 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, slp@redhat.com, eblake@redhat.com,
 armbru@redhat.com, annie.li@oracle.com, miguel.luis@oracle.com
Subject: [PATCH 07/13] microvm: Add ACPI Control Method Sleep Button
Date: Wed, 28 May 2025 12:40:28 -0400
Message-ID: <20250528164029.2199-1-annie.li@oracle.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20250528163545.2143-1-annie.li@oracle.com>
References: <20250528163545.2143-1-annie.li@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_08,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2505280145
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE0NSBTYWx0ZWRfX5ImfIxs6On8h
 fimuVxXCT+8zIH6mQ0mDIcvoRTnZqVtWgvthPb02hoX5LfSsDM2jOEe1O5ZJokJ7VGxN7vzSyRj
 FTcKUk4DFUSURYpZwQCQihDUqq+QOOlHaqXT/Ql4gHOSfSrqWaSwJUfPFsjUS8vLmlsHCnhwcc5
 fABkcWbbGhptd9OtBVneSYYD1dkJgm76ZlStHP1BabHg/mHwJHmQj1xZTABux6cafNSOOYyhbn+
 JvnHA+7cYgfRgFX7qQ1qpBxJf0grt/US0nD6hn/0XjGhmkTAoV2eoLUuIzSvoJFsQv3e2/LqZUP
 Q0XjJZi1QyAC5Dnp4YpjvXXDM60rrbVlHSKcFELFapI8qYL/kVvM/JGYgQ1DYzP+9oRVZ31hstp
 KKKs8nOkRShIG+ZREwqLGb9cbxiYBeFTatcVqHwu48wc0wuTuWjz1FUgeChXdD1LyMEite9R
X-Proofpoint-GUID: aY8LcL-5zavyuSMvfjh8R3Lckn2XY1mo
X-Authority-Analysis: v=2.4 cv=UvhjN/wB c=1 sm=1 tr=0 ts=68373c88 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=XNJOhtfp-WJYUvHO5McA:9
X-Proofpoint-ORIG-GUID: aY8LcL-5zavyuSMvfjh8R3Lckn2XY1mo
Received-SPF: pass client-ip=205.220.177.32; envelope-from=annie.li@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.498,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add the support of ACPI Control Method Sleep Button and System
S3 Sleeping State for microvm.

Signed-off-by: Annie Li <annie.li@oracle.com>
---
 hw/i386/acpi-microvm.c                 | 13 ++++++++++++-
 include/hw/acpi/generic_event_device.h |  1 +
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/i386/acpi-microvm.c b/hw/i386/acpi-microvm.c
index 279da6b4aa..c14e12b2d8 100644
--- a/hw/i386/acpi-microvm.c
+++ b/hw/i386/acpi-microvm.c
@@ -32,6 +32,7 @@
 #include "hw/acpi/generic_event_device.h"
 #include "hw/acpi/utils.h"
 #include "hw/acpi/erst.h"
+#include "hw/acpi/control_method_device.h"
 #include "hw/i386/fw_cfg.h"
 #include "hw/i386/microvm.h"
 #include "hw/pci/pci.h"
@@ -123,12 +124,22 @@ build_dsdt_microvm(GArray *table_data, BIOSLinker *linker,
     build_ged_aml(sb_scope, GED_DEVICE, x86ms->acpi_dev,
                   GED_MMIO_IRQ, AML_SYSTEM_MEMORY, GED_MMIO_BASE);
     acpi_dsdt_add_power_button(sb_scope);
+    acpi_dsdt_add_sleep_button(sb_scope);
     acpi_dsdt_add_virtio(sb_scope, mms);
     acpi_dsdt_add_xhci(sb_scope, mms);
     acpi_dsdt_add_pci(sb_scope, mms);
     aml_append(dsdt, sb_scope);
 
-    /* ACPI 5.0: Table 7-209 System State Package */
+    /* ACPI 6.5, Table 7.11: System State Package */
+    scope = aml_scope("\\");
+    pkg = aml_package(4);
+    aml_append(pkg, aml_int(ACPI_GED_SLP_TYP_S3));
+    aml_append(pkg, aml_int(0)); /* ignored */
+    aml_append(pkg, aml_int(0)); /* reserved */
+    aml_append(pkg, aml_int(0)); /* reserved */
+    aml_append(scope, aml_name_decl("_S3", pkg));
+    aml_append(dsdt, scope);
+
     scope = aml_scope("\\");
     pkg = aml_package(4);
     aml_append(pkg, aml_int(ACPI_GED_SLP_TYP_S5));
diff --git a/include/hw/acpi/generic_event_device.h b/include/hw/acpi/generic_event_device.h
index d2dac87b4a..28c5785863 100644
--- a/include/hw/acpi/generic_event_device.h
+++ b/include/hw/acpi/generic_event_device.h
@@ -85,6 +85,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(AcpiGedState, ACPI_GED)
 #define ACPI_GED_SLP_TYP_POS       0x2   /* SLP_TYPx Bit Offset */
 #define ACPI_GED_SLP_TYP_MASK      0x07  /* SLP_TYPx 3-bit mask */
 #define ACPI_GED_SLP_TYP_S5        0x05  /* System _S5 State (Soft Off) */
+#define ACPI_GED_SLP_TYP_S3        0x03  /* System _S3 State (Sleeping State) */
 #define ACPI_GED_SLP_EN            0x20  /* SLP_EN write-only bit */
 
 #define GED_DEVICE      "GED"
-- 
2.43.5


