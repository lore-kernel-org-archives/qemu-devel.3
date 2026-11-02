Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91430606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 03:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OxT1CEEF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNj8u-0002D2-7Y; Sun, 01 Nov 2026 22:55:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xNj8r-0002A1-UO; Sun, 01 Nov 2026 22:55:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xNj8q-0003Kt-6O; Sun, 01 Nov 2026 22:55:29 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A20iESQ317309; Mon, 2 Nov 2026 03:55:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=2edLtG71pN5ZeKcnu
 AbD4JjAOMPaNk4qVD0kkoe1HN0=; b=OxT1CEEFrlL6JbIo5Ww0eHjf5TfS/9gcb
 kiDNpmB+G+nP90ej91HgTIRxjkbIPP5+QsTUsraPZLjDJ5FKNvCsL8e0IokuOx9F
 FwIA5j5GeHy0H2LIx6R6LbYdKiGOxEUbJRdQXeIoV7MnDexjtXtoXgEp67w0E6WB
 g55TPv3jSqjTN7QtHYlmiCagGXogYml00/asvDZ7jXa4AL112gdUB3Q2sR+f9uvY
 p0Q0IYv0WvhkHukUg2ImoMSn3KMqospIhNNMHxcjrUIsxnif1HkkW3x/lWargKO8
 aijFPCelC+Hxj571+X+3WQtgcFgt/cKcLGo7TcNqSIJIh2iVTSvFQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rcxjqe-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 03:55:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A20Z6KS132761; Mon, 2 Nov 2026 03:55:23 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnu1vc426-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 03:55:23 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A23tMR035717576
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Nov 2026 03:55:22 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3108658062;
 Mon,  2 Nov 2026 03:55:22 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1035058052;
 Mon,  2 Nov 2026 03:55:16 +0000 (GMT)
Received: from li-bd0dea4c-2912-11b2-a85c-e84940f94d2e.ibmuc.com (unknown
 [9.43.104.91]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Nov 2026 03:55:15 +0000 (GMT)
From: uverma@linux.ibm.com
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, jishnuvw@linux.ibm.com, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, jsnow@redhat.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 aleksandr.mikhalitsyn@futurfusion.io, Utkarsh Verma <uverma@linux.ibm.com>
Subject: [PATCH v7 04/10] tests/qtest/nvme-test: fix NVMe struct field
 endianness
Date: Mon,  2 Nov 2026 09:23:00 +0530
Message-ID: <20261102035306.2291147-5-uverma@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102035306.2291147-1-uverma@linux.ibm.com>
References: <20261102035306.2291147-1-uverma@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: sto9DwRkfECrcLr_-sKCcfaqCUiq5FHR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAxNCBTYWx0ZWRfX7+DyVTneTIci
 OJmrpmoyNgf8pdbRSnODvYK4l9kq/DY4Iz+agyxPrpZGZO4IJFJkyUnKvZOTDmzWYc68VILTtUZ
 CMZzXjNw9/9UdKN4tCsbUKRNBDhq3fIqTCI8CrTyTxDSnGCKoPOPrI86d4fTBBa+t6xS1droOVN
 vc2ce9e1BFk2ER4q9dMHyguUBL3Hz/VB/Ba33wExT02sQyl1h7UaXdUXHFJhNBP5CPYOJ42TMuL
 RJnrpiOTjFBHbhXVb1TKBnYmtdsTesosmY/k34bDK3D18eITs4cZ/mg8ibXFjRJaV3oNIAo3T50
 IX5IQ7raWYUWo7H2YlGXUnb+sQMn2GZiFq8nI2MXqZpDeB33Dn2XDvG8yNuf6nE+dTRJ1A7kCHV
 ZHKWkvEEcSwmclHhKjhqrbOGtCeLHDjWQVBxfgRa2IB/kSHz+PuU32J71rvM28BQ1fipfK+b4AA
 L9SKMJu8kJFMIW4bKvg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAxNCBTYWx0ZWRfXylGm4k6l7Rdl
 xZl3uTNSVXI+lIGE+AVRoK/lf+qJCg5hpWhRPdEilrJN8Ejh+1+mGv0XENf59qwN+H2ao+Uzqkn
 ShOi0PWDVjONLBAZRk5ttfohl6DV8zw=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6ae809ac cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=_DHHnKUEPh0LJhC6-tsA:9
X-Proofpoint-ORIG-GUID: cmm09tw0gzxbOsVJb5UMyW37c0O7pWM9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020014
Received-SPF: pass client-ip=148.163.158.5; envelope-from=uverma@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

From: Utkarsh Verma <uverma@linux.ibm.com>

NVMe queue structures in guest memory are written and read in little
endian byte order, so they must not be byte swapped depending on target
endianness. Instead, read using qtest_memread/memwrite with explicit
le*-to-cpu / cpu-to-le* conversions.
Also, fix the qtest_writel call with qtest_writeb for NvmeIdentify.cns
(uint8_t) access.

Signed-off-by: Utkarsh Verma <uverma@linux.ibm.com>
---
 tests/qtest/nvme-test.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/tests/qtest/nvme-test.c b/tests/qtest/nvme-test.c
index f9395cc252..edf982a111 100644
--- a/tests/qtest/nvme-test.c
+++ b/tests/qtest/nvme-test.c
@@ -223,10 +223,12 @@ static void nvme_init_cq(nvme_ctrl *ctrl, nvme_cq *cq, uint16_t db_idx,
 
 static int nvme_cqe_pending(nvme_cq *cq)
 {
-    uint16_t status = qtest_readw(
-        cq->common.ctrl->pdev->bus->qts,
-        PHYS_ADDR_OF(NvmeCqe, cq->phys_cqe, [cq->head].status));
-    return (status & 1) == cq->phase;
+    uint16_t status;
+
+    qtest_memread(cq->common.ctrl->pdev->bus->qts,
+                  PHYS_ADDR_OF(NvmeCqe, cq->phys_cqe, [cq->head].status),
+                  &status, sizeof(status));
+    return (le16_to_cpu(status) & 1) == cq->phase;
 }
 
 static int nvme_is_cqe_success(NvmeCqe *cqe)
@@ -253,8 +255,8 @@ static NvmeCqe nvme_handle_cqe(nvme_sq *sq)
     }
     cq->head = cq_next_head;
 
-    if (cqe.sq_head != sq->head) {
-        sq->head = cqe.sq_head;
+    if (le16_to_cpu(cqe.sq_head) != sq->head) {
+        sq->head = le16_to_cpu(cqe.sq_head);
         g_test_message("sq %p head = %u", sq, sq->head);
     }
 
@@ -298,15 +300,14 @@ static uint64_t nvme_get_next_sqe(nvme_sq *sq, uint8_t opcode,
     qtest_memset(sq->common.ctrl->pdev->bus->qts,
                  phys_sqe, 0, sizeof(NvmeCmd));
 
-    #define GUEST_MEM_WRITE(fn, phys_addr, val) \
-        fn(sq->common.ctrl->pdev->bus->qts, phys_addr, (val))
+    #define GUEST_MEM_WRITE(phys_addr, val) \
+        qtest_memwrite(sq->common.ctrl->pdev->bus->qts, phys_addr, &val, sizeof(val))
 
-    GUEST_MEM_WRITE(qtest_writeb,
-                    PHYS_ADDR_OF_FIELD(NvmeCmd, phys_sqe, opcode), opcode);
-    GUEST_MEM_WRITE(qtest_writew,
-                    PHYS_ADDR_OF_FIELD(NvmeCmd, phys_sqe, cid), cid);
-    GUEST_MEM_WRITE(qtest_writeq,
-                    PHYS_ADDR_OF_FIELD(NvmeCmd, phys_sqe, dptr.prp1), prp1);
+    GUEST_MEM_WRITE(PHYS_ADDR_OF_FIELD(NvmeCmd, phys_sqe, opcode), opcode);
+    cid = cpu_to_le16(cid);
+    GUEST_MEM_WRITE(PHYS_ADDR_OF_FIELD(NvmeCmd, phys_sqe, cid), cid);
+    prp1 = cpu_to_le64(prp1);
+    GUEST_MEM_WRITE(PHYS_ADDR_OF_FIELD(NvmeCmd, phys_sqe, dptr.prp1), prp1);
 
     #undef GUEST_MEM_WRITE
 
@@ -344,7 +345,7 @@ static uint64_t nvme_admin_identify_ctrl(nvme_ctrl *ctrl,
 
     GUEST_MEM_WRITE(qtest_writel,
                     PHYS_ADDR_OF_FIELD(NvmeCmd, phys_cmd_identify, nsid), 0);
-    GUEST_MEM_WRITE(qtest_writel,
+    GUEST_MEM_WRITE(qtest_writeb,
                     PHYS_ADDR_OF_FIELD(NvmeIdentify, phys_cmd_identify, cns),
                     NVME_ID_CNS_CTRL);
 
-- 
2.55.0


