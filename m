Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA412606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=ULCJqqmQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWUHa-0004KF-Cs; Thu, 26 Nov 2026 02:52:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xWUHY-0004Jf-UN; Thu, 26 Nov 2026 02:52:40 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xWUHX-00063c-13; Thu, 26 Nov 2026 02:52:40 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQ7Z50J2082524; Thu, 26 Nov 2026 07:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=fa64ZK965Hw88qQ08zeDYc+ueTpl
 F1/V/oqLLLtXo9E=; b=ULCJqqmQxOyXuKeNY6VK87PhLwIkiu8XkL9fzsQe7oTx
 T05rpyRmK8zqbySnBZaCE01r68cv8kZA2hqKqB94P2YyX8moEvLdECavLILJRAW8
 lyWCAFD8PYWgIPv2OLcIzRn6nfxKlJ3/9UjYI2oJNfCSrrwdPbIGO49DyHgKgk8Y
 wrbnBco4tejslZ5Vu3G7voqse7AThIlINWqPaGQDiU9HZ+eWMFplCaGSXAA7vrIy
 OlWgxF0c+0uUyi3LbC3BgZrqSWfClnIEYlLlKM05yUijYfKqpm4ZfTEF+zKmecxF
 I40tz+WCQtBuNSmr6VCGpqlvUnapRMsvLKE3/ajX6Q==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g3gafr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 26 Nov 2026 07:52:34 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQ7JFjp2009582; Thu, 26 Nov 2026 07:52:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5dcuxm21-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Nov 2026 07:52:33 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AQ7qWtU48628204
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 26 Nov 2026 07:52:32 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E60FA20063;
 Thu, 26 Nov 2026 07:52:31 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E95CF20043;
 Thu, 26 Nov 2026 07:52:29 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.bl1-in.ibm.com (unknown
 [9.123.8.229]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 26 Nov 2026 07:52:29 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 philmd@oss.qualcomm.com
Cc: gautam@linux.ibm.com, pbonzini@redhat.com, fam@euphon.net,
 Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH] hw/scsi: send error response when descriptor validation fails
Date: Thu, 26 Nov 2026 13:21:48 +0530
Message-ID: <20261126075213.364201-1-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b07e542 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=EUspDBNiAAAA:8
 a=VnNF1IyMAAAA:8 a=_4ijFCZXMxIMTcu4jv0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDAyOSBTYWx0ZWRfXyf5xwIrqaCWM
 x5v4kRz5ffM3aqm757ObX/r41YnCePqyjEkRWG++nXmSbTNv5oZvaap0sF1gk21BK0/yRubM0c1
 UVH1l0p03Sz0iHxwTHnbaCIzuQ8YQCI=
X-Proofpoint-ORIG-GUID: 4uv-ooxAp9sAEWnz_xrh_uSyJdtoOQhJ
X-Proofpoint-GUID: 4uv-ooxAp9sAEWnz_xrh_uSyJdtoOQhJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDAyOSBTYWx0ZWRfX5rIXIJdRQrn3
 ViW8JLKvz926c8EQp66EvKBD5JoQ5voS4VBfjBqn0uxwv+h827qNuTgasOResDDOyYZ/+eTQF2j
 lFLnYeyJzoTc8Ipr8KqgWcd9e2yJae6tpD203BZbOjARFwn2+H0CBxJ/0OUweqgOv9IX1O6R9Jp
 DUt2LOiveMBGpiCwWYlMc0pB2nbvQGZrPre+DI1q/O+SJNyEPTGmvT1O7Gu2FhUprAkPgwVkgqy
 B40x5prhgTI/eFgNHbe8y/OoYS8CFtP8TUZkxRFNNp1HaxJ6r1r3JgMojozHNln91RSPReHRwsz
 v7/ARVoyYcZ45vm+tY0/X+ONmELvfyWASkbRyU9i51q4CfObcw+0xmij0tYFFPd6B+ktJWJSle2
 OQkhMPOvlDHHEfDImL2ojSbo8QxKy8G7CaJih8mTfinHpLPEW4QKg+T1xjsJS1NeGrcPh3kodpG
 ZCvHgdvPfvXRWoyp3xw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_02,2026-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260029
Received-SPF: pass client-ip=148.163.156.1; envelope-from=rathc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Commit 8a91c8327c (hw/scsi: validate IU buffer bounds in vscsi_preprocess_desc())
made vscsi_queue_cmd() cancel the request when vscsi_preprocess_desc()
fails. However, scsi_req_cancel() does not send an SRP response by
itself. That is to be sent from vscsi_request_cancelled(), only when
req->dma_error is set, which was missed in the above mentioned commit.

Fixing that in this commit, preventing the guest from hanging until
timeout.

Fixes: 8a91c8327cc8 ("hw/scsi: validate IU buffer bounds in vscsi_preprocess_desc()")
Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 hw/scsi/spapr_vscsi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index 1283590844..466f6d99e6 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -854,6 +854,7 @@ static int vscsi_queue_cmd(VSCSIState *s, vscsi_req *req)
 
         /* Preprocess RDMA descriptors */
         if (vscsi_preprocess_desc(req) < 0) {
+            req->dma_error = true;
             scsi_req_cancel(req->sreq);
             return 1;
         }
-- 
2.56.1


