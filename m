Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25989606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AnW49s9c
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLdjW-0000d4-6Z; Tue, 27 Oct 2026 05:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1xLdjU-0000b4-VL; Tue, 27 Oct 2026 05:44:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1xLdjT-0001Qr-1f; Tue, 27 Oct 2026 05:44:40 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R5iZqx1441620; Tue, 27 Oct 2026 09:44:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4THQfx
 yfn9AfDVLt1rjABkhsEDuGjMkkiOLip8qulqk=; b=AnW49s9c5vRGY2A4/+D3Yu
 637MLWk3IQR3kV4dqQ4Y2adX6O0Z4PQZI2a7iYT5oCqcTbvw7sDtpYlJjX8vwMJj
 5cTvYQ++UerYNfuSOXfD2hxT50v127+05zL9Z9EPSJ5iPUWMPEm4Guv9437VlSH4
 Lq2avjxP93tYqDPPzJyjl4N7OYJFEWsRYhhvaqQCcQJBnRE8pEU0wu/jh4XiKwVV
 RtdfjdPIj/GJDtPbYAzfp1YFO2QFtPY4+h+N9FpuABME+mXY7dJGWKX5pkBFGw2o
 cTHxgp3OZylFp+gkzbqeJ7xiBpgSUwRO3wbTnEqsZTBZvccd06V7KgidccbP1K2w
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgj3m6th5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 09:44:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R5npXP3687782; Tue, 27 Oct 2026 09:44:21 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh7cvj8d5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 09:44:21 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69R9iJBb27853542
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Oct 2026 09:44:20 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C0E1E58062;
 Tue, 27 Oct 2026 09:44:19 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D232658056;
 Tue, 27 Oct 2026 09:44:18 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Oct 2026 09:44:18 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v7 8/9] pnv/phb5: Implement IODA PCT table
Date: Tue, 27 Oct 2026 04:43:49 -0500
Message-ID: <20261027094350.3645085-9-saif.abrar@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261027094350.3645085-1-saif.abrar@linux.ibm.com>
References: <20261027094350.3645085-1-saif.abrar@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAzNiBTYWx0ZWRfX+kRYvMZCBFTC
 TXoafNEnXBCgA29WZCcvKpxe/HZI0zmK+/TZC1L19zFapJ2MDw06bQy29Lo/BJK2uI0ndcrnuH8
 HoCfutYTXY3chwQd08uZzBAMmSofeNg=
X-Proofpoint-ORIG-GUID: Hq1UDc-QJYsfq3adN0TKmaG9dMjNuZPZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAzNiBTYWx0ZWRfXz1UsD0ODej66
 AfGakiHZ2kO289WVXGcL4K9VsU4traBFYH7Izyniyf2g1E+I8jbX2vPsTTUeK49pS7vOLkcfi6I
 Uu7/AxPbUHMrTEFjmrxMOda2JGag5If3abUPQKu9M64CWwqSYsaIgRuLiC6OoFocrKZaRWZ71T+
 oCg/Fjgu7LhLvOn5KIr/Fa0bJOeGtA2IL0RzbV8UfM/sYxkk1mEtG7Mg0TkIfx48Bg69BGcHx/+
 Vw4ij+B41U0RA4nqCsQv+dowBY0cGjI69O8O9QZCYmymnTHWpxuLp+aA5xsld6sMxKEg2popRcU
 RMHQsXKp8mctk4zzUT6mjvSIJGZoto1txep0PMt813RBjFkfOluxlC//OGZqdNYlnxYArky6rWj
 vpyU0UCVPK1GvKGv4Ai12voNj3oDewOIYseD2qDYZn1wB5NWPnqozI84g+9ptzs/wILMoeyP9GR
 9r9BZMiDaUsyOgh00CA==
X-Authority-Analysis: v=2.4 cv=G7uJgNk5 c=1 sm=1 tr=0 ts=6ae07276 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=zgsLwUnGCMBw8fX4dgEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-GUID: MtiBSzyklooXHdpx6UUP-8K6s7JMEsBv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270036
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=saif.abrar@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>

IODA PCT table is implemented
without any functionality, being a debug table.

Signed-off-by: Saif Abrar <saif.abrar@linux.ibm.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Caleb Schlossin <calebs@linux.ibm.com>
Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Michael Kowal <kowal@linux.ibm.com>
---
 hw/pci-host/pnv_phb4.c              | 7 +++++++
 include/hw/pci-host/pnv_phb4.h      | 2 ++
 include/hw/pci-host/pnv_phb4_regs.h | 1 +
 3 files changed, 10 insertions(+)

diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index b0a5bdfdd6..9983781bd4 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -263,6 +263,11 @@ static uint64_t *pnv_phb4_ioda_access(PnvPHB4 *phb,
         mask = phb->big_phb ? PNV_PHB4_MAX_MIST : (PNV_PHB4_MAX_MIST >> 1);
         mask -= 1;
         break;
+    case IODA3_TBL_PCT:
+        tptr = phb->ioda_PCT;
+        mask = phb->big_phb ? PNV_PHB4_MAX_PCT : (PNV_PHB4_MAX_PCT >> 1);
+        mask -= 1;
+        break;
     case IODA3_TBL_RCAM:
         mask = phb->big_phb ? 127 : 63;
         break;
@@ -361,6 +366,8 @@ static void pnv_phb4_ioda_write(PnvPHB4 *phb, uint64_t val)
     /* Handle side effects */
     switch (table) {
     case IODA3_TBL_LIST:
+    case IODA3_TBL_PCT:
+        /* No action for debug tables */
         break;
     case IODA3_TBL_MIST: {
         /* Special mask for MIST partial write */
diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb4.h
index 33e11a3fe8..8d5822f339 100644
--- a/include/hw/pci-host/pnv_phb4.h
+++ b/include/hw/pci-host/pnv_phb4.h
@@ -65,6 +65,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(PnvPHB4RootBus, PNV_PHB4_ROOT_BUS)
 #define PNV_PHB4_MAX_LSIs          8
 #define PNV_PHB4_MAX_INTs          4096
 #define PNV_PHB4_MAX_MIST          (PNV_PHB4_MAX_INTs >> 2)
+#define PNV_PHB4_MAX_PCT           (128 * 2)
 #define PNV_PHB4_MAX_MMIO_WINDOWS  32
 #define PNV_PHB4_MIN_MMIO_WINDOWS  16
 #define PNV_PHB4_NUM_REGS          (0x3000 >> 3)
@@ -138,6 +139,7 @@ struct PnvPHB4 {
     /* On-chip IODA tables */
     uint64_t ioda_LIST[PNV_PHB4_MAX_LSIs];
     uint64_t ioda_MIST[PNV_PHB4_MAX_MIST];
+    uint64_t ioda_PCT[PNV_PHB4_MAX_PCT];
     uint64_t ioda_TVT[PNV_PHB4_MAX_TVEs];
     uint64_t ioda_MBT[PNV_PHB4_MAX_MBEs];
     uint64_t ioda_MDT[PNV_PHB4_MAX_PEs];
diff --git a/include/hw/pci-host/pnv_phb4_regs.h b/include/hw/pci-host/pnv_phb4_regs.h
index 9ad6713d37..897c869d20 100644
--- a/include/hw/pci-host/pnv_phb4_regs.h
+++ b/include/hw/pci-host/pnv_phb4_regs.h
@@ -478,6 +478,7 @@
 
 #define IODA3_TBL_LIST          1
 #define IODA3_TBL_MIST          2
+#define IODA3_TBL_PCT           3
 #define IODA3_TBL_RCAM          5
 #define IODA3_TBL_MRT           6
 #define IODA3_TBL_PESTA         7
-- 
2.52.0


