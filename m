Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B05C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 16:42:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKJr8-0007HQ-Tb; Wed, 28 May 2025 12:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uKJqx-00071I-3f
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:42:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <annie.li@oracle.com>)
 id 1uKJqv-0007aw-Be
 for qemu-devel@nongnu.org; Wed, 28 May 2025 12:42:06 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54SCqMTV024174;
 Wed, 28 May 2025 16:41:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=jrols
 50ttmQYOJ46x4EgitOBjw2wF8AJ7w27GxNoKlQ=; b=OS1dBN6SsYRPdgOkudCC1
 J6i/48ZrANyIuHdUGHzMNzuYrNzLdd0Md2RKk5XjnAgVFc7z+imHF0FIM1qNjTE7
 d+7ImTz9+TV05D5RAj2ReX9CxL/3CeCZu7bKVBRpc7C76bfxjU/hZ39jpblVhv+E
 7aAYieF8tTIUVplI2oJTsgI9EOOGYzsBeTIyfJLlsc5Yl1Q4LRzoo6ycMYi8BwgG
 XpYklZktq7uwkkYGPHoSmC57YS6HeSf9CwL2HJS+uPmuSHILvG1gel9KGLx3Nn9C
 8dhr04iGbfiBeV+1UeYKwGcovMSJm/LQqG0DGsDfERqE9noo6s8iTcg1rpb3Smw/
 g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46v0ykxj55-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 16:41:56 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54SGUGqF027836; Wed, 28 May 2025 16:41:56 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 46u4janr29-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 16:41:56 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 54SGfthv023737;
 Wed, 28 May 2025 16:41:55 GMT
Received: from localhost.localdomain (dhcp-10-43-12-51.usdhcp.oraclecorp.com
 [10.43.12.51])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 46u4janr0m-1; Wed, 28 May 2025 16:41:55 +0000
From: Annie Li <annie.li@oracle.com>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, slp@redhat.com, eblake@redhat.com,
 armbru@redhat.com, annie.li@oracle.com, miguel.luis@oracle.com
Subject: [PATCH 11/13] microvm: suspend the system as requested
Date: Wed, 28 May 2025 12:41:44 -0400
Message-ID: <20250528164145.2231-1-annie.li@oracle.com>
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
X-Proofpoint-GUID: u6zy3F1BAXLUOMWk47_Y3znwSPCp6kpj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDE0NSBTYWx0ZWRfX7QLPYcq5PpHJ
 afxLlcRKEnIFWYB+JZ6AQHZlKxe7lE6ftfPGywTrUdaGRrJIKpIzBn30245liw/5Kqqwj8o5BFT
 +DtFpjXPey91OHMdg5AcO/w6lsLFHfYD83GA4IqqXXruZ0XTr1Q+C9gEU+ZUNVB7UskE8mX0tl2
 Aa9fKdECQ2YjRn/+D00gO2ZJmgX3x5WlEjH5sXme7b5BhBJJFaVVLSTDabhcmkJMD3nJ3BHZkK6
 0bvYM+QCpOzimhHn9eqiMjTz+dEJXvjjDU3cFiJB8Vbb0zD7TgsNOB8swBMPUDmIHZvVS/meV6b
 MU2vdPmyTvuevffl5Go3c7SkLm0bBY1VfKneRF6E/T+RYn+K+2piPrFbPSlgOu1Og2MRl3A3xOP
 yn/tjcG3dzkGrkCgaBNgBnJI95d4BTtyUs+ixI4OsKe9qZIuQ/ZCTLTRNXqwJ4y2AXgb1MF+
X-Proofpoint-ORIG-GUID: u6zy3F1BAXLUOMWk47_Y3znwSPCp6kpj
X-Authority-Analysis: v=2.4 cv=N7MpF39B c=1 sm=1 tr=0 ts=68373cd4 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=dt9VzEwgFbYA:10 a=yPCof4ZbAAAA:8 a=6ePxH0XHyxwHeyQBJ1UA:9
Received-SPF: pass client-ip=205.220.165.32; envelope-from=annie.li@oracle.com;
 helo=mx0a-00069f02.pphosted.com
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

Once the microvm guest requests to go to sleep state and
sets the GED register with S3 type, QEMU needs to continue
suspending the system.

Signed-off-by: Annie Li <annie.li@oracle.com>
---
 hw/acpi/generic_event_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 5a1ac8e362..bc53551a45 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -213,6 +213,9 @@ static void ged_regs_write(void *opaque, hwaddr addr, uint64_t data,
         if (slp_en && slp_typ == ACPI_GED_SLP_TYP_S5) {
             qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
         }
+        if (slp_en && slp_typ == ACPI_GED_SLP_TYP_S3) {
+            qemu_system_suspend_request();
+        }
         return;
     case ACPI_GED_REG_SLEEP_STS:
         return;
-- 
2.43.5


