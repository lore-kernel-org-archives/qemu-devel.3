Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222F2606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 05:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VKsGYUIx
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLw5p-0003VY-JE; Wed, 28 Oct 2026 01:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xLw5n-0003VC-Ql
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 01:20:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xLw5l-0005yI-Rk
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 01:20:55 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S4i8Un287718; Wed, 28 Oct 2026 05:20:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=DPdHMU/ZI8F1xwJAm
 /9pnlfSIBvOyUS3sQzMtPNxv6k=; b=VKsGYUIxAIxywVdnt+325VWDIrsLpHUDY
 eFHmVVHwhzvABGu2CsqQLm9s3o+5KwgAjGJta5TB2k8kDMyag0ianfuUu3wcKPo6
 oo3ixXjGgJUkaaM5WXU7A6tX59pccygC0Oj/HPJ7BrhxCk1rZJeRuuHiG0ffnl4C
 iqQLXznODeEhGbyq7ab9obXhC4i4Ttm1khRGRnbYesZCAsYBWIIJLvJfXoLMZOLa
 JM+6WbkOkQA7ozHPH4rUEHVLHHhcfD+bZMo71XWCBebIaRG3fxfXDfQjTBeIlMkR
 2YP0Njp3L0LpuK8+5/AHwRz1p67KvW16Gfhs/bA84nNeL0X3q32yA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmd733jp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2026 05:20:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S4YwXP4039866; Wed, 28 Oct 2026 05:20:49 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hk010j6n5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2026 05:20:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69S5Kjdk40173930
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Oct 2026 05:20:46 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB16320043;
 Wed, 28 Oct 2026 05:20:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2DC220040;
 Wed, 28 Oct 2026 05:20:44 +0000 (GMT)
Received: from dhcp-9-123-3-122.bl1-in.ibm.com (unknown [9.123.3.122])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 28 Oct 2026 05:20:44 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>,
 Guthrie McAfee Armstrong <git@gmarmstrong.dev>,
 Gautam Menghani <gautam@linux.ibm.com>
Subject: [PULL 6/6] spapr-vscsi: clamp adapter info DMA write length to struct
 size
Date: Wed, 28 Oct 2026 10:50:24 +0530
Message-ID: <20261028052024.38377-7-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261028052024.38377-1-harshpb@linux.ibm.com>
References: <20261028052024.38377-1-harshpb@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6ae18632 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=HFWUlIUfFqO2-xBDwmUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAyMCBTYWx0ZWRfX0PCq+7NPjUXv
 u0IlVYRlnZVfAUoxiIFt7CJZ3Awe1VfdKONXom51XoPJSswpe0E/7pHXjJq63TP7MyI7f9lMLL3
 rlbSI5S6dyv66X31Gm4/uvbpW+jPSXMQrqi7DgC3tef3RhEy0Ub+XL/ocMxZCG51J6zznmJrvx0
 mwflBNqIkPJ4ko6/c88nKo6Oq1BSbxdCF2lp4LSPj2d3t2VQdic+cWKMSnh3DxMUT/oVdut6s1t
 glaVxdnDwS1cjYrpnssnsHR8pwAONV30mOLfgFq6+Rg+J50fsIUB01KJwijaZT3GSexSjgizkUH
 CBpqv0qywHL3eLsHPF+w/+sXQXXlK0iSmxVHGJeYqm+kDV0tTXgWe0O3iUQVY+izP+GkEcNLKIj
 cez8SbUyI/tLKpGjoM/dWiPnlHhVMrbnzq1Mx49+FPps4j7b1IdYcFVOwZh1ebU02F4IdwT9Au6
 miI7/l6aZzagjVrjt5A==
X-Proofpoint-GUID: 5XZ7vEEnipWuh5u6uePOCbslF0vmvILy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAyMCBTYWx0ZWRfXyN1Ua2IQy42+
 51+tsu6XWqhtuUfeCern8n52jASxIE7zmh5BDWKVVOoLh+QbSKCib4WNi9s8yccuc9J10wWHUk9
 gr6JNLJ6/H7s6J+90Phjysv/SX5If5k=
X-Proofpoint-ORIG-GUID: 5XZ7vEEnipWuh5u6uePOCbslF0vmvILy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1011
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280020
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
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chinmay Rath <rathc@linux.ibm.com>

vscsi_send_adapter_info() used the guest-supplied common.length
field directly as the size argument to spapr_vio_dma_write().
Since common.length is controlled by the guest, a value larger
than sizeof(struct mad_adapter_info_data) (148 bytes) caused
dma_memory_write() to read past the end of the stack-allocated info
struct, leaking arbitrary host stack contents into guest memory.

Fix this by clamping the write length to sizeof(info), then using
spapr_vio_dma_set() to zero-fill any remaining bytes the guest
requested beyond that size. This mirrors the existing pattern in
vscsi_send_capabilities().

Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4626
Reported-by: Guthrie McAfee Armstrong <git@gmarmstrong.dev>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261007144434.374749-1-rathc@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/scsi/spapr_vscsi.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index b4c8f94d22..7ec780da79 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -966,6 +966,8 @@ static int vscsi_send_adapter_info(VSCSIState *s, vscsi_req *req)
 {
     struct viosrp_adapter_info *sinfo;
     struct mad_adapter_info_data info;
+    uint16_t len, req_len;
+    uint64_t buffer;
     int rc;
 
     sinfo = &req_iu(req)->mad.adapter_info;
@@ -985,11 +987,23 @@ static int vscsi_send_adapter_info(VSCSIState *s, vscsi_req *req)
     info.os_type = cpu_to_be32(2);
     info.port_max_txu[0] = cpu_to_be32(VSCSI_MAX_SECTORS << 9);
 
-    rc = spapr_vio_dma_write(&s->vdev, be64_to_cpu(sinfo->buffer),
-                             &info, be16_to_cpu(sinfo->common.length));
+    req_len = len = be16_to_cpu(sinfo->common.length);
+    buffer = be64_to_cpu(sinfo->buffer);
+    if (len > sizeof(info)) {
+        fprintf(stderr, "vscsi_send_adapter_info: adapter info size mismatch !\n");
+        /*
+         * Just read and populate the structure that is known.
+         * Zero rest of the structure.
+         */
+        len = sizeof(info);
+    }
+    rc = spapr_vio_dma_write(&s->vdev, buffer, &info, len);
     if (rc)  {
         fprintf(stderr, "vscsi_send_adapter_info: DMA write failure !\n");
     }
+    if (req_len > len) {
+        spapr_vio_dma_set(&s->vdev, (buffer + len), 0, (req_len - len));
+    }
 
     sinfo->common.status = rc ? cpu_to_be32(1) : 0;
 
-- 
2.52.0


