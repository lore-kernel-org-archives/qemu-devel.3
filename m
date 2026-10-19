Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5813606A325
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=k4Tt+ULS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIqCZ-0002Mr-37; Mon, 19 Oct 2026 12:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1xIqCE-00029Z-Mh; Mon, 19 Oct 2026 12:26:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1xIqCC-0001Un-8X; Mon, 19 Oct 2026 12:26:45 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFj31A3042775; Mon, 19 Oct 2026 16:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=Q839harI6NKWSta2p
 oavzM2yxDm6fPJKONc0aFAObcs=; b=k4Tt+ULSDVYcq0eLxUqS7maVAm0Aqbn1q
 W7J4MKroDuotKq2cwTIZBMqqSAUrp5tMvuYcorvfBBrnB5DMOn7lgDJ0+y/hFAwF
 vejPC7LXMWr+ZOzSmTnMmsYVXwrIC571gHXmdNHIoElW2mkHc6XVFcK2nkZ+UG2z
 S05eopPCqlsL/UpmjT/6GrTOGKM7VK1gO72p+gxQ7h5neR3QzXKVmzdXXUDOrpoA
 1Y7O8MYrqXcfkDvepX0hehAZJT2nNPtaHuKMIBZTBJ9uG2Az3lVBQav8DvCWus/B
 JdYUDMUHwzqd69KVhd6lKzo7t18HPaRcm+ISQ4Fzx9dv3EB2PGY2Q==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hbyepunv0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 16:26:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFZ5j0121764; Mon, 19 Oct 2026 16:26:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hckbq6nr7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 16:26:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69JGQTH447382792
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Oct 2026 16:26:30 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C449F2004E;
 Mon, 19 Oct 2026 16:26:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1730F20040;
 Mon, 19 Oct 2026 16:26:26 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.124.217.62])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Oct 2026 16:26:25 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Sourabh Bhat <sbhat@linux.ibm.com>, anushree.mathur@linux.vnet.ibm.com,
 clg@redhat.com, Sourabh Jain <sourabhjain@linux.ibm.com>,
 adityag@linux.ibm.com, nikhilks@linux.ibm.com
Cc: pierrick.bouvier@oss.qualcomm.com, rathc@linux.ibm.com,
 Nicholas Piggin <npiggin@gmail.com>, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, hbathini@linux.ibm.com, shivangu@linux.ibm.com
Subject: [PATCH v6 6/6] MAINTAINERS: Add self as sPAPR EEH reviewer under PPC
 RAS
Date: Mon, 19 Oct 2026 21:55:40 +0530
Message-ID: <20261019162541.68440-7-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261019162541.68440-1-nnmlinux@linux.ibm.com>
References: <20261019162541.68440-1-nnmlinux@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2NCBTYWx0ZWRfX3M0hxi0AsjYW
 vjOTfKYeelWQzbt6wTyc9xehdQsreita1uhT3CSszX3xSxqp+s/iHExPTNpe4wxonGe+yBPLh1u
 I6LXJVfs6vowXYDQtHO1p5ZdCXrFBK0=
X-Authority-Analysis: v=2.4 cv=Z4R5j3RA c=1 sm=1 tr=0 ts=6ad644be cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=uPrgHAJC8kndP_WudMUA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: DXhjiqsAs1Xdz_u8iebLYN10kThmEzWI
X-Proofpoint-GUID: C-BCSZIXXjWR5JTM4Gbg2fmKk1hnkmiU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2NCBTYWx0ZWRfX0AXq899gPp+Y
 AIhm1Sz7L9qmJMzQm6ajOq+efuSMyO5RlU6ppMS0T6qENUsMQuNKWocabGdxndEemOOngykt/u6
 I1RDL2C19BYVFF6VoSQFO+tltKnhFBOnpoLk85Co+n6PRcGWkTeJ2HkSVgY7wowhU//lrJe1guB
 EhVyW+JDcr2x1YgQ+8ZYoJQhN0J4zpm5XZrEyiaDguo+YkElrZHfsXyecV8EBYH1v7te8b2QTJW
 OA020Mn0jbqTDg/94KPK7p9jaPP34i3vaJ8btSjaPwo0ilCcPLjnknpnRcuXTVbvJlcJ6vlTSlt
 Fxh4vx6TnsflkPJz9cYcVfXO2JWabe4Wb1WAz3nDWHPe69z2YO0tHg+gAhbUykxKLpvZZeGQ7uR
 lQo2I7SK2CbEKvG80V5zYpszLZyK8U/sboJhxMZMD0DLQfzNGv3TyUjTr8xOOvM9txmCWvnRJBI
 L/pVlz0epN7xHF+CZdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1011 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190064
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adding self as reviewer for the sPAPR EEH under PPC RAS.
Updating the EEH specific file name as got updated in previous patches.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 33b4f7c259..337d402fa6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1775,11 +1775,13 @@ M: Aditya Gupta <adityag@linux.ibm.com>
 R: Sourabh Jain <sourabhjain@linux.ibm.com>
 R: Hari Bathini <hbathini@linux.ibm.com>
 R: Shivang Upadhyay <shivangu@linux.ibm.com>
+R: Narayana Murty N <nnmlinux@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Maintained
 F: hw/ppc/spapr_events.c
 F: hw/ppc/spapr_fadump.c
 F: hw/ppc/spapr_pci_vfio.c
+F: hw/ppc/spapr_eeh.c
 F: hw/ppc/spapr_rtas.c
 F: hw/ppc/pnv_mpipl.c
 F: include/hw/ppc/spapr_fadump.h
-- 
2.51.1


