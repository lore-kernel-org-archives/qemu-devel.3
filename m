Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37F6EB106E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzyno-0007hp-Ls; Tue, 10 Mar 2026 11:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vzynZ-0006vN-B1
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:15:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vzynX-0000HW-GY
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:15:05 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62AA1Dj31849314
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=HaVK6d
 Q4jgMbXsjoR9kGYk8XU2DipitWKer1LH+/Pf0=; b=CcaSn+jBOMpP151L3wqgBS
 80iVRghKZwYvPum3hmtX4PaR2Pfk+6V3Rspd/wOMJmFIjxFzq7/D675Bws3uAzcA
 TeRC0Pz/I3Qe10kcE7ydG8s9SbdjQvKbt0YhVFaHRH2hK75yRXdIccEwxgJHJvNe
 H4P3JIB1hxKw3OD6FEIlwNn3W/v0bQoutRpjLl5q9yCLIFYl5mRDGDAKK28Mnqkd
 APfAOjuJKhwBoIK6nIfPpxb2VXviSjHTMHF5cuyY/U3YRDXvCochFjyccRQDOIzL
 8YHZ8V2uVmVtWFWaY00KkF0mpvdlw/BQd4hZj3A/VYAYU5q3kVz7OD9EpKrrNhRA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvmbhef-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:15:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62AD2M7k015761
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:15:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs1221bmm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:15:01 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62AFEvtd46661940
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 15:14:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 772A02004E;
 Tue, 10 Mar 2026 15:14:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2350A2004B;
 Tue, 10 Mar 2026 15:14:56 +0000 (GMT)
Received: from Mac.com (unknown [9.39.23.49])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2026 15:14:55 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PULL 10/10] MAINTAINERS: Add entry for MPIPL (PowerNV)
Date: Tue, 10 Mar 2026 20:44:30 +0530
Message-ID: <20260310151432.92531-11-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260310151432.92531-1-harshpb@linux.ibm.com>
References: <20260310151432.92531-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4pSa4sNEXRRzxaG4bcj97BcZBYl8Xnh8
X-Proofpoint-ORIG-GUID: 4pSa4sNEXRRzxaG4bcj97BcZBYl8Xnh8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEzMSBTYWx0ZWRfXyrqd7LfU3ps3
 9d0TGVzwMHkQtaFK4a7iqd/crf/mPqZmaoCZbc89PsWJGPjiLz/x/WBKTd2CXzk6PyNugTFJn3A
 dk5wo2fhNxRBgytcYf8Hx6ZkjJVuXLGuYW0nim0VWOplwaTn4vD3D0E9pGJ+aum2+O9PtTPBt9k
 7k04vAB22WKrA8oKH/xm2RGc8Cq5ibPNnfWTAbH4Ea/NSfXROF1bO/S5o5ah2a21gqCQMdSi6ip
 uEZTHhISR/YRv1R6eboP+whiZCzSMCFuVri1i15s1e5grOgisjN++MQ6tx5laJvFhvIDVArRBeS
 AaaS9tFmhr1Udb902+pcN98jTvSgfcElWKmi7XkR+ulhCMzTfrrKVo0J+PX4JLKMvDaae10X/WU
 2n8Z/PoCQqJV7JAmTHIQFIE1HwewxG0+7IDwMc8T32K+8HruMzDA2/udua38cG7uC4d7IU1v8oI
 k+etn1WB+v93sPReKFQ==
X-Authority-Analysis: v=2.4 cv=B5q0EetM c=1 sm=1 tr=0 ts=69b03576 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8 a=K3nGc4jhFjju3E8dwHwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100131
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

Add maintainer and reviewer for MPIPL subsystem.

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260310124619.3909045-11-adityag@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d1614fd7e..c030a3fec2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3303,6 +3303,14 @@ F: include/hw/ppc/spapr_fadump.h
 F: hw/ppc/spapr_fadump.c
 F: tests/functional/ppc64/test_fadump.py
 
+Memory-Preserving Initial Program Load (MPIPL) for PowerNV
+M: Aditya Gupta <adityag@linux.ibm.com>
+R: Hari Bathini <hbathini@linux.ibm.com>
+S: Maintained
+F: include/hw/ppc/pnv_mpipl.h
+F: hw/ppc/pnv_mpipl.c
+F: tests/functional/ppc64/test_fadump.py
+
 GDB stub
 M: Alex Bennée <alex.bennee@linaro.org>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
-- 
2.52.0


