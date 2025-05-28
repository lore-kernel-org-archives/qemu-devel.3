Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8A2C5B549
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 16:40:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKJoc-0002SQ-7k; Wed, 28 May 2025 12:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uKJoa-0002Rx-95
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:39:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uKJoY-00076I-Gl
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:39:40 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SCq5pr028798;
 Wed, 28 May 2025 16:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=D4F4U
 1oS0pmY5R1lX7//qOO7o5Gzn6OV5A4ui2DnaVQ=; b=lTy8Lyjfbc++vKrbVlYxK
 2I0EjQpOQ6MQwLQSwzsd05YFKyXONPRxJ1ny2u8vXqow453fclP9FdqP5QyPVSuc
 9rYnxbb+3QRTH2T6e2R+HfNI335/ePQgA3UBExzS+3zfnf0ov8HY1DniZZstoVJf
 z6ap61pJkuW5NG8vTsi/njuKEIfccFbytGl+zFg+bKkOz9WNhMjbhtJHbkkWZkM/
 sTnc/ccTb50Rr8fanf0GeB6MQ73GbR9H6GRW7W6qXws4Z3tHksGIogZuJ9kFhXOI
 ZleC0ROpZktImaSUli7IC3zkErqlzjue4l26aowQj4/kQYvpxZw+AUqFdNSHvAui
 Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v21s6a43-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 16:39:29 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54SFi5Ae027802; Wed, 28 May 2025 16:39:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4jannk7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 16:39:28 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54SGdSBb015845;
 Wed, 28 May 2025 16:39:28 GMT
Received: from localhost.localdomain (dhcp-10-43-12-51.usdhcp.oraclecorp.com
 [10.43.12.51])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 46u4jannht-1; Wed, 28 May 2025 16:39:27 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, slp@redhat.com, eblake@redhat.com,
 armbru@redhat.com, annie.li@oracle.com, miguel.luis@oracle.com
Subject: [PATCH 03/13] acpi: Support Control Method sleep button for x86
Date: Wed, 28 May 2025 12:39:17 -0400
Message-ID: <20250528163917.2167-1-annie.li@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE0NSBTYWx0ZWRfX+LqCQl/u/beb
 JF7dQofe4ZgjH97htpiqI9VJBjE4Of8K8aFzURJS4JsNtc8YR73Qudt5hLa6G8pZM/LlAqHh8w3
 qNYUjzeZORJ8HgO76wR+dG9tgONMlKR1vSNMdh8xC5JmxtrawTPF9Ds16Is55ewi06eofJkxSAn
 oC6PNvbHp64vd75EG6z8xwp701pmR80NYcrua5ltRzJyx3VMM8OxkIbfocVuYs22OclX/M04hdG
 hlwv0ECNbjGD/gf0j8c4vvoy/0VmbOdRC9bkmwa5C87174zytwwn+Pa+qMGOUss1V72eylXS7tu
 ZaXU/JC+edkMqvtRfzpSps2G75nx3ryOmRPdmTvkPeT4TmvuB3pAiD3BUyH9r+PwHtFQZq7k9wj
 PwSzz5reLpWtxNnoprdWlB2cIDDTMrjnyfaI/IXG/FdWotqKrdcDUh2OvtS4yJUy4JE5Z6w1
X-Proofpoint-GUID: GN-PLF8VGgrJW01i1I_Xq9cFvMH6UtQW
X-Authority-Analysis: v=2.4 cv=UvhjN/wB c=1 sm=1 tr=0 ts=68373c41 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=gxMm4iIJXT6Pl5sU14IA:9
X-Proofpoint-ORIG-GUID: GN-PLF8VGgrJW01i1I_Xq9cFvMH6UtQW
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

Add Control Method Sleep button and its GPE event handler for
x86 platform. The GPE event handler notifies OSPM when the
Sleep button event is triggered.

Signed-off-by: Annie Li <annie.li@oracle.com>
---
 hw/i386/acpi-build.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 3fffa4a332..2ddf669006 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -40,6 +40,7 @@
 #include "hw/acpi/acpi_aml_interface.h"
 #include "hw/input/i8042.h"
 #include "hw/acpi/memory_hotplug.h"
+#include "hw/acpi/control_method_device.h"
 #include "system/tpm.h"
 #include "hw/acpi/tpm.h"
 #include "hw/acpi/vmgenid.h"
@@ -1359,7 +1360,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
                                                      NULL);
     Object *q35 = object_resolve_type_unambiguous(TYPE_Q35_HOST_DEVICE, NULL);
     CrsRangeEntry *entry;
-    Aml *dsdt, *sb_scope, *scope, *dev, *method, *field, *pkg, *crs;
+    Aml *dsdt, *sb_scope, *scope, *dev, *method, *field, *pkg, *crs, *condition;
     CrsRangeSet crs_range_set;
     PCMachineState *pcms = PC_MACHINE(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(machine);
@@ -1465,6 +1466,27 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     }
     aml_append(dsdt, scope);
 
+    sb_scope = aml_scope("_SB");
+    acpi_dsdt_add_sleep_button(sb_scope);
+    aml_append(dsdt, sb_scope);
+
+    /*
+     * The event handler for the control method sleep button is generated
+     * for notifying OSPM (ACPI v6.5, Section 4.8.2.2.2.2).
+     */
+    scope =  aml_scope("\\_GPE");
+    method = aml_method("_L07", 0, AML_NOTSERIALIZED);
+    condition = aml_if(aml_name("\\_SB."ACPI_SLEEP_BUTTON_DEVICE".SBP"));
+    aml_append(condition,
+               aml_store(aml_int(1),
+                         aml_name("\\_SB."ACPI_SLEEP_BUTTON_DEVICE".SBP")));
+    aml_append(condition,
+               aml_notify(aml_name("\\_SB."ACPI_SLEEP_BUTTON_DEVICE),
+                                    aml_int(0x80)));
+    aml_append(method, condition);
+    aml_append(scope, method);
+    aml_append(dsdt, scope);
+
     if (pcmc->legacy_cpu_hotplug) {
         build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
     } else {
-- 
2.43.5


