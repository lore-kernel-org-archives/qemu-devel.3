Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A01C9EC69
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfFH4-0004Za-Al; Mon, 12 Jan 2026 05:35:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vfFGV-0003oC-Gb
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:35:15 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vfFGT-0002Mz-Cj
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:35:14 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60CAJiXN020335
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=GU1R0ExMjFm94dfOf
 plR+JUI8OhQIYtfO7zrdhfdfeI=; b=m6yUe1pxtXJGw4eeCymolXZqQqaQAprX9
 VWSVVAd34421QBC+BE4GI3liavjcx0kfkpgpcGggOo3mBLZvwxUCk5LtJFqidlgT
 uR4uxTSom3Y9Se0GZeomGv4wf2HA65ZSlvXd1+GPPhjNAEnPbJi0rwp3NmNfkmxa
 qB/buQMYP7VISfFe5/BW7//3pcXZuxJi/qBamU29c7V3KwbAtpRfEUvXZ9/g+iuP
 B0TwCiXGKNv9pRvyLBVX+Mtrh+x/bPGdd9ix1Zg5zZ9xvP33TXTyTTkyZpPgyN3h
 THgBkK2Gjlzeiij0eNqrNnMmK1szI54wMe4rd6NTfe1Z7D26Mlkdg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkd6dxd32-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:35:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60CAYmZw029743
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:35:10 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm3ajd74g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:35:10 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60CAZ6Ei36110786
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 12 Jan 2026 10:35:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B32D420043;
 Mon, 12 Jan 2026 10:35:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2FED520040;
 Mon, 12 Jan 2026 10:35:05 +0000 (GMT)
Received: from Mac.com (unknown [9.43.47.93])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 12 Jan 2026 10:35:04 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Caleb Schlossin <calebs@linux.ibm.com>,
 Michael Kowal <kowal@linux.ibm.com>, Aditya Gupta <adityag@linux.ibm.com>,
 Chalapathi V <chalapathi.v@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>
Subject: [PULL 08/10] hw/ppc: Add VMSTATE information to PnvPsi
Date: Mon, 12 Jan 2026 16:04:31 +0530
Message-ID: <20260112103433.8451-9-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112103433.8451-1-harshpb@linux.ibm.com>
References: <20260112103433.8451-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: E6Fg-Yrxf0RTKUFISe9tEZIrLZBznqke
X-Authority-Analysis: v=2.4 cv=LLxrgZW9 c=1 sm=1 tr=0 ts=6964ce5f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=vUbySO9Y5rIA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=fAueZ9Rv7cwqH87Z7dkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA4MSBTYWx0ZWRfX1loWulHwwbWU
 YeIgzqfYolTmNn5Hmm5uW98f0iHAvu+ZWQF+NHhEzOWnoZOTHMwc5KyGYunxfkG7RU1N5wOOl9o
 o8rdARna69x0TPvUBA5526PEDJgE6b0Fdh7f014dxQxwsJ7JXLXxsWtWP1nfRVoicmOGW+7iW7O
 uYo7djBFaH+mT3QB/El87WSLB0fMCM2QLQ5I2/eR+NBP5FgJjD6X1ItyRE7I6zyqBR24qgeGU1I
 3Gnf0qdRPfcn80Pgm2jkDxdMliHfWAjDWYCeNm6GVHcX16lpH5cqz264pcTVWTzx7/E/PM6BlJC
 hDEkFShZvalepiU3KXQ2578ZCiONH1qt+81v6LyqLwFSYjcTZ/Pzqw1xZyjH1qL6cloRK47AZL1
 w7qksH+JJIlBSyUrjRWBmSpHeJndUT92U2vctl+6mCEuNBxWrzPnxWadYU4j1TVY2MVhee/v+F9
 aFPhPo95etvtART8mZg==
X-Proofpoint-ORIG-GUID: E6Fg-Yrxf0RTKUFISe9tEZIrLZBznqke
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601120081
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Caleb Schlossin <calebs@linux.ibm.com>

PnvPsi needs to be able to save/load snapshots.  Add VMSTATE information
to the device class and a post_load() method to restore dynamic data items and
memory region mappings.

Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Chalapathi V <chalapathi.v@linux.ibm.com>
Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260105160138.3242709-8-calebs@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/pnv_psi.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 264568cdfb..e8701c6100 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -25,6 +25,7 @@
 #include "qemu/module.h"
 #include "system/reset.h"
 #include "qapi/error.h"
+#include "migration/vmstate.h"
 
 
 #include "hw/ppc/fdt.h"
@@ -130,12 +131,11 @@ static void pnv_psi_set_bar(PnvPsi *psi, uint64_t bar)
 {
     PnvPsiClass *ppc = PNV_PSI_GET_CLASS(psi);
     MemoryRegion *sysmem = get_system_memory();
-    uint64_t old = psi->regs[PSIHB_XSCOM_BAR];
 
     psi->regs[PSIHB_XSCOM_BAR] = bar & (ppc->bar_mask | PSIHB_BAR_EN);
 
     /* Update MR, always remove it first */
-    if (old & PSIHB_BAR_EN) {
+    if (memory_region_is_mapped(&psi->regs_mr)) {
         memory_region_del_subregion(sysmem, &psi->regs_mr);
     }
 
@@ -919,6 +919,37 @@ static const TypeInfo pnv_psi_power9_info = {
     },
 };
 
+static int vmstate_pnv_psi_post_load(void *opaque, int version_id)
+{
+    PnvPsi *psi = PNV_PSI(opaque);
+    Pnv9Psi *psi9 = PNV9_PSI(psi);
+    MemoryRegion   *sysmem = get_system_memory();
+    uint64_t esb_bar;
+    hwaddr esb_addr;
+
+    /* Set the ESB MMIO mapping */
+    esb_bar = psi->regs[PSIHB_REG(PSIHB9_ESB_CI_BASE)];
+
+    if (esb_bar & PSIHB9_ESB_CI_VALID) {
+        esb_addr = esb_bar & PSIHB9_ESB_CI_ADDR_MASK;
+        memory_region_add_subregion(sysmem, esb_addr,
+                                    &psi9->source.esb_mmio);
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_pnv_psi = {
+    .name = TYPE_PNV_PSI,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = vmstate_pnv_psi_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(regs, PnvPsi, PSIHB_XSCOM_MAX),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void pnv_psi_power10_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -926,6 +957,7 @@ static void pnv_psi_power10_class_init(ObjectClass *klass, const void *data)
     static const char compat[] = "ibm,power10-psihb-x\0ibm,psihb-x";
 
     dc->desc    = "PowerNV PSI Controller POWER10";
+    dc->vmsd = &vmstate_pnv_psi;
 
     ppc->xscom_pcba = PNV10_XSCOM_PSIHB_BASE;
     ppc->xscom_size = PNV10_XSCOM_PSIHB_SIZE;
-- 
2.52.0


