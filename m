Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0168B606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EVQBuiuM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNqVj-00060H-ET; Mon, 02 Nov 2026 06:47:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xNqVh-0005oi-3n
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 06:47:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xNqVe-0005JD-FC
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 06:47:32 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29EFZ82489493; Mon, 2 Nov 2026 11:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=2rRTHH
 hMe8j9L2G+uFn4MmUo2nuxMKfUus0v/LFNEts=; b=EVQBuiuMElZV6ROnOXdRBm
 JW7kg8ypSz4n+VWCT6oQJpZN/QkysSD49xUAFZtMF/l1EQ+CaXByCWiwANFoXzoW
 zHMHMMmZIT8PaigCyWSmnw015NpaNHidvDJWYlf5zfF4VFxc0wD/5+WuVXmAuVvg
 8Y64AGPkz7NsVNYqRP2X3qqpEEMR/SxfipwmsuvHRQYKUukyANKGqpA66emubEBu
 NRnBlZVIrJmt6TnSYRKPgCi6hz/OD93BQi9TRqGCGG4B18ZtKgdIcmYZw/vQTTMT
 5NtF9aINYcyrEqXnWgJN3IPPIfFCuF+KHBN4IME5erL3cQqbhbxdP5XXHIO3hpAQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn826g74c-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 11:47:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29JvWI629627; Mon, 2 Nov 2026 11:47:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnunjwjuf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 11:47:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A2BkwI848955880
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Nov 2026 11:46:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1878920043;
 Mon,  2 Nov 2026 11:46:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6934920040;
 Mon,  2 Nov 2026 11:46:54 +0000 (GMT)
Received: from Mac.com (unknown [9.43.40.115])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Nov 2026 11:46:53 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Saif Abrar <saif.abrar@linux.vnet.ibm.com>,
 Saif Abrar <saif.abrar@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Caleb Schlossin <calebs@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>
Subject: [PULL 8/9] pnv/phb5: Implement IODA PCT table
Date: Mon,  2 Nov 2026 17:15:56 +0530
Message-ID: <20261102114558.62509-9-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261102114558.62509-1-harshpb@linux.ibm.com>
References: <20261102114558.62509-1-harshpb@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fDUqKrsLuoheIMrv2kEfIy89E2Hn17MA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfX1jhbReErYUS0
 JN76HtAvMc1Sfh+lxlCzczXZGJUGVl+ork00M/oNTgH5vcrU5P6k0vE16JneoLr3FKKO+CuE01f
 s2bAj67NLJWTkl8eXJdvXk1zHqcjm3QgxMao9TNFk7K0GjMHCvkVULPj1cD39cGH513wcGcAdtg
 6Bb8WyvvYAdubpcZssMsDtP2z3Y14QF+1OcOhaTUsAW7XTyaF+w1dVUD60lWpqPnb8R7//aCv0X
 1samUf+u9zur40dBcizngxiIxGvKNKAZnoHYtL0s35SFqcJiw6RraA7zqdoYPcvePToixpqeHrh
 cF9c4EG1tW1PjjytRsaRtg4MHgrVBoXEHap4NubdkgqCWPxR2HGa95BuNmZj5wsrL88MFDFcdVZ
 xjFevSHwZ3XtKGvz1ICrJgxKpNNDM0AUZqQYqASqndmNf+hbL8vI9H1l0yM5lkwHhv3iJ4XqtL5
 +4KoYjXmVU1ecUWduvA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfXzFTv+Pu5Tscg
 J28exkN96lzAOEl2dj0Z1fTuh5Xnv0vVkdSJXZoJ9aQ3Oq5zlB2T+5lkwuodE3gI9GRDd7kd82f
 +yT79iQT/2HHqcBM+DPFmK+/y4hMHM4=
X-Proofpoint-GUID: fDUqKrsLuoheIMrv2kEfIy89E2Hn17MA
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6ae87838 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=aow-egSQAAAA:8 a=eaHzrZHkp109S6yiJ2wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020046
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Link: https://lore.kernel.org/qemu-devel/20261029171047.3862430-9-saif.abrar@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/pci-host/pnv_phb4.h      | 2 ++
 include/hw/pci-host/pnv_phb4_regs.h | 1 +
 hw/pci-host/pnv_phb4.c              | 7 +++++++
 3 files changed, 10 insertions(+)

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
-- 
2.52.0


