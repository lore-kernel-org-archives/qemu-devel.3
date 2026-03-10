Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF99EB106D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzynk-0007NT-8n; Tue, 10 Mar 2026 11:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vzynL-0006oP-Sy
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:14:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vzynI-0000Ef-TL
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:14:50 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A81pAs1177331
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=yJWgUF4R1GPsx8bjo
 UWbWPtkmgoOtugjqirrZiAMfv0=; b=g/Jv2ZOQK3FfLX2qLdabFnKxTlSmkTmk2
 h+2tgpVVLuERX1gcdkuOzIyj2aO1P23NzKuBOIfZzVGp0w+uots/V2lfesBxU/9y
 FlCykEWjFrSABptvfDxVTeaWwDlLZ5z2fpZdmsmEQ9aDT4YDmPZPndOSCiZyGgPC
 Wccfz2+0H0cJEXZb5A0W95d/zOKhz7NFxyD33C1mKz8+UKA+4HCO9ZTjVpxU2vFW
 U3U/GHR+hR0D9GVac/C60FIXLIkt7uMoY+BWccDhT3qQLutz9P9FMP54lp5pHc9M
 m2kTEnNKKocimSDiSDlWzRHrI09k0xEkrtrbOJYkSnlGW9HwXWpLw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvrb6f3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:14:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62ABKnWI023481
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:14:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ct8ng2jtn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:14:46 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62AFEgCi15532488
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 15:14:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A840B2004E;
 Tue, 10 Mar 2026 15:14:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4183F2004B;
 Tue, 10 Mar 2026 15:14:41 +0000 (GMT)
Received: from Mac.com (unknown [9.39.23.49])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2026 15:14:41 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PULL 01/10] ppc/pnv: Move SBE host doorbell function to top of file
Date: Tue, 10 Mar 2026 20:44:21 +0530
Message-ID: <20260310151432.92531-2-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260310151432.92531-1-harshpb@linux.ibm.com>
References: <20260310151432.92531-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEzMSBTYWx0ZWRfX+KCBTYV9A8bS
 cxqqO6Orcp1Unu33xNgyAvYP7BtFU/pmuIyXzq9CbaY9JJ7gTdwQsQHZqCRGCM7KhchZTzh8FBL
 s5AuZO+dpS6uzDEbfjoYhaiZ0dRkJIkpADFCZc6gWp/v2S4w0X//WfGWldzJQkq28ilQJ8nF72G
 VjhApL6+FPpdxUx80KrmgIG8e1pLypBOHo6kqAvvlmv+c6lkzq+IP7YYEqwUQ9y2EwMA0jL4de9
 XYmKhYXfB2hMz15evlbw6bkzzTFw7bxly9NGvjXcgX/uh0RsSZ6eJ9zK6+xLiNqfnt4eNXCfwtK
 jPERnMhnSiyguRbgswP73v/2puoPr+OwG/zK1ooMO717CdgtGt7SAjOFvs2CxQgwvycGgXiblDd
 pvU7s9/dcR/jK8I7uwNLWJR9usgbi0AH6rOmdUs1B1fvAaYAIAoPymBTTk8QneUNFemLlTMGCBi
 dELigRA5qkHD2ISUaDA==
X-Proofpoint-GUID: 7eOG8JIw5pJa2koBsRl3AJb8sj5gCgRS
X-Proofpoint-ORIG-GUID: 7eOG8JIw5pJa2koBsRl3AJb8sj5gCgRS
X-Authority-Analysis: v=2.4 cv=QoFTHFyd c=1 sm=1 tr=0 ts=69b03567 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=K3nGc4jhFjju3E8dwHwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603100131
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Aditya Gupta <adityag@linux.ibm.com>

Moved 'pnv_sbe_set_host_doorbell' as-it-is to above
'pnv_sbe_power9_xscom_ctrl_write'.

This is done since in a future patch, S0 interrupt implementation uses
'pnv_sbe_set_host_doorbell', hence the host doorbell function needs to
be declared/defined before 'pnv_sbe_power9_xscom_ctrl_write' where we
implement the S0 interrupt.

No functional change.

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260310124619.3909045-2-adityag@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/pnv_sbe.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/pnv_sbe.c b/hw/ppc/pnv_sbe.c
index 27383ce683..247617338a 100644
--- a/hw/ppc/pnv_sbe.c
+++ b/hw/ppc/pnv_sbe.c
@@ -80,6 +80,15 @@
 #define SBE_CONTROL_REG_S0              PPC_BIT(14)
 #define SBE_CONTROL_REG_S1              PPC_BIT(15)
 
+static void pnv_sbe_set_host_doorbell(PnvSBE *sbe, uint64_t val)
+{
+    val &= SBE_HOST_RESPONSE_MASK; /* Is this right? What does HW do? */
+    sbe->host_doorbell = val;
+
+    trace_pnv_sbe_reg_set_host_doorbell(val);
+    qemu_set_irq(sbe->psi_irq, !!val);
+}
+
 struct sbe_msg {
     uint64_t reg[4];
 };
@@ -125,15 +134,6 @@ static const MemoryRegionOps pnv_sbe_power9_xscom_ctrl_ops = {
     .endianness = DEVICE_BIG_ENDIAN,
 };
 
-static void pnv_sbe_set_host_doorbell(PnvSBE *sbe, uint64_t val)
-{
-    val &= SBE_HOST_RESPONSE_MASK; /* Is this right? What does HW do? */
-    sbe->host_doorbell = val;
-
-    trace_pnv_sbe_reg_set_host_doorbell(val);
-    qemu_set_irq(sbe->psi_irq, !!val);
-}
-
 /* SBE Target Type */
 #define SBE_TARGET_TYPE_PROC            0x00
 #define SBE_TARGET_TYPE_EX              0x01
-- 
2.52.0


