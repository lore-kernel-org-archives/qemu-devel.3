Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287AE606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 05:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YhzBdK3L
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLw5m-0003Ut-Q5; Wed, 28 Oct 2026 01:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xLw5k-0003UE-Py
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 01:20:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xLw5i-0005xt-Sm
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 01:20:52 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S4iD2R2858188; Wed, 28 Oct 2026 05:20:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=0zFFNCzJLGNBB4ZPV
 WKcSa+l10brbedBx0U0CRG28/8=; b=YhzBdK3L6dXuFU2ZVxZnQ3ObdQVgAPeLn
 g8Px2enK//Z6mvNiTs1DsBo6kAgR4pZGtVdyj+QQ2aS6bmO+9XtUrAxeYY7CaqZQ
 8dzvFTkMc/quWtWJooF8WsU7mn5cQ6X2MOLTum8zJScDSUbrmhglw1SAz6WcKbfw
 bIo2krnqItuyQqlh3pkWOVFfyW1t3TRRxWMyu5gWPo6t52uIZA7O1Jg4/WNcRIsn
 y3I22Q64PEws6NXlVshG77yR47RT2vlZ3Vqx/tgZbBT1PFAu2oknfnC9o2gXSuHt
 mafOn4oRyOPOpreSGdgv5TkYbH8kOItmtznJgRTAYZsFBgYgJ9+uA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmbt33qj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2026 05:20:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S4YvrH973648; Wed, 28 Oct 2026 05:20:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hjtnnbpdr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2026 05:20:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69S5KiZg45285722
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Oct 2026 05:20:44 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 609EE20040;
 Wed, 28 Oct 2026 05:20:44 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 726E120043;
 Wed, 28 Oct 2026 05:20:43 +0000 (GMT)
Received: from dhcp-9-123-3-122.bl1-in.ibm.com (unknown [9.123.3.122])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 28 Oct 2026 05:20:43 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Showta Ishizaki <zakinko@snowrabbit.org>,
 Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PULL 5/6] hw/ppc/spapr: Add the "rtas-version" property to /rtas
Date: Wed, 28 Oct 2026 10:50:23 +0530
Message-ID: <20261028052024.38377-6-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261028052024.38377-1-harshpb@linux.ibm.com>
References: <20261028052024.38377-1-harshpb@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAyMCBTYWx0ZWRfX3jdTa861JZMV
 2APjTRg/h/B2Myl/YLpYfl0CKOiBxcDCDwrM2jtMUBPPunByv9mOBQoufxHacogYXnvu7bKh6gB
 5iLxXB+NGWP3hPSE2qhqD1JQHIBOsQhDiG1PxK3bxPXb6caJ36l4kKw1Twx5CXpzFiLBc2W4LJe
 5tkUwjiRgZS0zURkPvwaumDeY3thjlkr+27GaZk/iWdYLPgEpeboGJDWY/m4hh+N+aKknvR88v1
 pAzgiK1mkkwaroKzM+qFL5U+xsQeRJi8lLYcmvTsvyC6PzTZP2I5OTsjvr+p804RJsMokn1wOlh
 PDszK8U76R7aHwv3+iVYTjJZqAGMy/HmKZV0tgxoBpSOiID8f7wbddmXCpJNv7h+RbUNfz+jeWa
 Z2LhX+F43Dhb/hd+nf1Zsxq8wilnx8y1XQxhlYlrw7vFLgRkKZdXLDIJtZBd8uuH+o9NXhJDbnG
 8G7xQiRrExrqU4eCIUQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAyMCBTYWx0ZWRfX1K4O49RzM3Ni
 EybfV+fg9BRx6UFzco/2dbJsHB0rJio5FMXcFqT0c0bKYiQ7oMdWfBpaweAhjtxqEVcyDQokTrK
 26ZK0xRVPfvCxwWl9HNPLjIcGo4R69Q=
X-Proofpoint-ORIG-GUID: i9hK7k8x9C4aAg_MUblmVVtTo5lNJwho
X-Proofpoint-GUID: i9hK7k8x9C4aAg_MUblmVVtTo5lNJwho
X-Authority-Analysis: v=2.4 cv=CeKdd7rl c=1 sm=1 tr=0 ts=6ae18631 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=L9C5IM_eAAAA:8 a=VnNF1IyMAAAA:8 a=TVUzaum_DjIj2wzR_eEA:9
 a=d8_PwHeUR2dB5DzxAQPm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1011
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280020
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

From: Showta Ishizaki <zakinko@snowrabbit.org>

PAPR requires every property listed in its table of /rtas device tree
properties to be present before the OS is booted (R-7.2.6-3 and Table
20 in PAPR v10.60; the same requirement is in LoPAR 2.9 and LoPAPR
1.1). One of them is "rtas-version", an integer encoding of the RTAS
interface version, and PAPR says it describes version 1 of that
interface.

spapr_dt_rtas() sets "rtas-size", "rtas-error-log-max" and
"rtas-event-scan-rate" but never "rtas-version", so a client that reads
it finds no RTAS: NetBSD's RTAS driver fails to attach when the
property is absent.

Set it to 1, the version PAPR describes.

Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Tested-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Showta Ishizaki <zakinko@snowrabbit.org>
Link: https://lore.kernel.org/qemu-devel/20261005161859.3119EC92F0@bambi.snowrabbit.org
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/spapr.h | 3 +++
 hw/ppc/spapr.c         | 1 +
 2 files changed, 4 insertions(+)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 9acda15d4f..98a9099b8a 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -830,6 +830,9 @@ void spapr_load_rtas(SpaprMachineState *spapr, void *fdt, hwaddr addr);
 
 #define RTAS_EVENT_SCAN_RATE    1
 
+/* RTAS interface version, as defined by PAPR v10.60 Table 20 */
+#define RTAS_VERSION            1
+
 /* This helper should be used to encode interrupt specifiers when the related
  * "interrupt-controller" node has its "#interrupt-cells" property set to 2 (ie,
  * VIO devices, RTAS event sources and PHBs).
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6d99464486..8a1b5b37b6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1068,6 +1068,7 @@ static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
                           RTAS_ERROR_LOG_MAX));
     _FDT(fdt_setprop_cell(fdt, rtas, "rtas-event-scan-rate",
                           RTAS_EVENT_SCAN_RATE));
+    _FDT(fdt_setprop_cell(fdt, rtas, "rtas-version", RTAS_VERSION));
 
     g_assert(msi_nonbroken);
     _FDT(fdt_setprop(fdt, rtas, "ibm,change-msix-capable", NULL, 0));
-- 
2.52.0


