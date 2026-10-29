Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA845606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kdjS3PM1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTfB-0006Oh-DD; Thu, 29 Oct 2026 13:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1xMTf3-0006Fx-Nn; Thu, 29 Oct 2026 13:11:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1xMTf0-00080T-SG; Thu, 29 Oct 2026 13:11:33 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGE3mQ460979; Thu, 29 Oct 2026 17:11:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=9gpBmC
 FxKMjUaIet0V0EIZpGa8+b36EAztvkTEoizXk=; b=kdjS3PM1VCQruWLM7Rebn+
 gcyqeWKFw7HmLaFYOMS6qJZ+B7n9bWDOSgrTQGd/yIb03ReWVtVlKT2VZEBXjsad
 mvuTQ0130YoTpejit3F3WgPXbEfqEeMF39oCSnShSS7qSYm4JkUD7COPK0htd7j2
 xbaBrTqJysYOnYsHL+c51wh5MKWAmiOfaHxb6Da4riBxg/UBYjw6hc4bAOL8kDUU
 gSI+wNmJ0hS17jg668DIUcRzI842IxT088eUgoWEsJ7YKZF8FAzwqQ5ldanGDgpb
 vUbi5Jdl69XHW8aO2RPWlPEeIIpwxOV+vKNLmQqPbaFXF/CKLrXiAgybs3tUuKcg
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmd7bnf8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:11:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGJxiT3393108; Thu, 29 Oct 2026 17:11:09 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hm69e167q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:11:09 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69THB8Fk27787842
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Oct 2026 17:11:08 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E79658045;
 Thu, 29 Oct 2026 17:11:08 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6E4D58050;
 Thu, 29 Oct 2026 17:11:06 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Oct 2026 17:11:06 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v7 RESEND 8/9] pnv/phb5: Implement IODA PCT table
Date: Thu, 29 Oct 2026 12:10:46 -0500
Message-ID: <20261029171047.3862430-9-saif.abrar@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261029171047.3862430-1-saif.abrar@linux.ibm.com>
References: <20261029171047.3862430-1-saif.abrar@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6ae37e2e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=zgsLwUnGCMBw8fX4dgEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2NSBTYWx0ZWRfX1w0F/V1k7ZhU
 +foVDQp3UgsBUL3C4KO3ooPqVHTuI0zxONzs+YuPj8VwGsAPIagngjIna5XvvwzMkFdw2y3FCwT
 DQ/XelsxRHshbFj187ZN3C1etcrnAX8v72koft8tzdsjCOIprN5BBD4Yf1a23rZ5vUw3cUgiV+4
 FjSXCFoG48t2hBYRjVPvBVEu0PI81mbEbXU5r5IjYJOQy0zr0Tcx5+ZfY8fdINi7bSN5rp5+j7K
 1Y7Hhedtsrbwn254mTKLCHAbkHOVGxh/0BMXzdPK+hk82xy/LMo9SRF5TmPPh6g0OIxt1fJqe2t
 XlGVrlzY0eVmUi51Cc4xRQU1a1Kv/scpUdQTlq9zQMj/aj8z5Pb9l8IPJfXoK/6scS0uDhC4KX0
 25apCC/39uNC+NiV8Rb/ATchOXivRx3q7JuZMCwMPYY61vjBbiTC1BYG03KAps8Gj7hNPRFvKPF
 yddzjI64iRJSdeJudUw==
X-Proofpoint-GUID: GhgqTKMzv9ZPMwOrJOKzvMzHt1YZsIDW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2NSBTYWx0ZWRfXz8ufsHBr/Z+T
 fJobYB6xYE2dFf5DRkvdjuscCSKiGAewAKJ+9c0UUHk+ht6KZXHEhw9JweA+iHqEBJmNi9ozT1K
 U1uMssxz6lNDtdAZ4whfvw0JsSfbKrc=
X-Proofpoint-ORIG-GUID: 8r9Gm-Hp1_RP8xgxziDvyPAkJTOGePLS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290065
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 4a49461f4e..956d82f551 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -267,6 +267,11 @@ static uint64_t *pnv_phb4_ioda_access(PnvPHB4 *phb,
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
@@ -365,6 +370,8 @@ static void pnv_phb4_ioda_write(PnvPHB4 *phb, uint64_t val)
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


