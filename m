Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4D4606A320
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=E8D+nGVN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU0NW-0004N2-V2; Thu, 19 Nov 2026 06:32:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xU0NV-0004MX-8M; Thu, 19 Nov 2026 06:32:33 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xU0NT-0000FV-At; Thu, 19 Nov 2026 06:32:33 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJAuq1w2746734; Thu, 19 Nov 2026 11:32:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=yKxGJr3lcZzVxVis4
 aRvBAGB2yOV8pPdXGEQe0qCUJw=; b=E8D+nGVNRXn2T0eAAUhbR28YpsdgmF8GI
 e2FsOiBQTPhzyDA/POHlbmjMqe4ycHa9AES7S+uy9onbs3tFpStq77XrhGVB8rGY
 KqtGZuoFfWEli90/Z+TR3C8Q7pDc9m4Tr4nNdBkltgfHk9eeDF9S02CPgwUxwDQc
 j5mCCSzRxeK0sa9CRdvBJzjMnskaiCMotVkWA0l12zXf/Jw98GTILf8AtqbnOMVs
 jtJhLZbFEysFAznAYEL3bxjdODu1iQAEceZgu47tjvL8XMsOhVHqrTCMkC7LnzrO
 6hspffHC3z0YkmTpbeAPi3unehT4ro9IadVhBDAIKB6LyyYzPVv8A==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105w0bju-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 11:32:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJB5BnX2447672; Thu, 19 Nov 2026 11:32:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1v9x992v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 11:32:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AJBWMTo33358132
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Nov 2026 11:32:22 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BE6E820040;
 Thu, 19 Nov 2026 11:32:22 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 24A322004F;
 Thu, 19 Nov 2026 11:32:21 +0000 (GMT)
Received: from Mac.com (unknown [9.43.71.183])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Nov 2026 11:32:19 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>, qemu-stable@nongnu.org,
 Lazymio <mio@lazym.io>, Gautam Menghani <gautam@linux.ibm.com>
Subject: [PULL 1/6] hw/scsi: validate IU buffer bounds in
 vscsi_preprocess_desc()
Date: Thu, 19 Nov 2026 17:02:09 +0530
Message-ID: <20261119113207.79328-9-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261119113207.79328-8-harshpb@linux.ibm.com>
References: <20261119113207.79328-8-harshpb@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qc9XNJanxU-o2_kWqaa2aFhG-ip_BndL
X-Authority-Analysis: v=2.4 cv=Z8x5j3RA c=1 sm=1 tr=0 ts=6afede4b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=gtT2MXwoUA80MS-wKdUA:9
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: Qc9XNJanxU-o2_kWqaa2aFhG-ip_BndL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfXziXAFJ9tiA+6
 +nNAn1993mJx/xr6bl/ENDefGoTKzzDiOYUhgLbLCVWURhrwJpTzR59wrphUVEbCCfUZheHnRVC
 JsZWR5eWTONXrhfyHgTPOmUT/c1OhLM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfX6O6vxuos3nCe
 AUyIclZDQUqv86iG6TG3XV8elj9KQhCo5NJGd3UPbsW8lwhPgNrTrsS4iYzuzkJ9y0+UgbW5KCR
 Xbe+XMnBrfXp1lcKdaHq+6KpIdqwEpDx2vA1rDMs8ADyBoTYe29w9I8/buDX59JVjMKeBKFVizp
 hVopprZosbD2Sf94SDr15FhzU2cVCVGURf9d7NEyXaVuQ6l63EOJnLEdk02N7UlWjl7z5QHHra6
 5V1uauhZNiC6tEzAhmt3PRhBnfoYZDpupx4Nv7OmsDkUpDMlJvoXBOWNVf1YHJnGp9AfqCnrDOY
 Ye4HnawA3FyrmDQRdnKHigvrh2bnc4dFb9BAI++H1kvOf7wmOgQYKDNmYEVCW2SaDA+0MbdOtZg
 8GEZ39EAeZRQFf7W/lUxokrTIOsy49q8tXomgQ0QEBlur6lZ7radMplXaOgqZYy0Am8nrwzqOKv
 k4FkMePehPV6ybytFxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190045
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chinmay Rath <rathc@linux.ibm.com>

cdb_offset and local_desc values are dependent on the guest. If the value
is large enough, it can lead to an out-of-bounds read in vscsi_fetch_desc().

Add an 'avail' constant in vscsi_preprocess_desc() representing the number of
bytes available in srp_cmd.add_data[] and use it to prevent out-of-bound reads.

Make all callers of vscsi_preprocess_desc() check its return value and
handle failure accordingly.

Cc: qemu-stable@nongnu.org
Fixes: CVE-2026-132127
Fixes: 8ca8a17c9a16 (pseries: rework PAPR virtual SCSI)
Reported-by: Lazymio <mio@lazym.io>
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4162
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260819095855.115823-1-rathc@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/scsi/spapr_vscsi.c | 43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/hw/scsi/spapr_vscsi.c b/hw/scsi/spapr_vscsi.c
index eedae00273..1283590844 100644
--- a/hw/scsi/spapr_vscsi.c
+++ b/hw/scsi/spapr_vscsi.c
@@ -484,6 +484,8 @@ static int data_out_desc_size(struct srp_cmd *cmd)
 static int vscsi_preprocess_desc(vscsi_req *req)
 {
     struct srp_cmd *cmd = &req_iu(req)->srp.cmd;
+    /* bytes available for descriptors behind srp_cmd.add_data */
+    const unsigned avail = SRP_MAX_IU_LEN - offsetof(struct srp_cmd, add_data);
 
     req->cdb_offset = cmd->add_cdb_len & ~3;
 
@@ -498,16 +500,35 @@ static int vscsi_preprocess_desc(vscsi_req *req)
     case SRP_NO_DATA_DESC:
         break;
     case SRP_DATA_DESC_DIRECT:
+        if (req->cdb_offset + sizeof(struct srp_direct_buf) > avail) {
+            fprintf(stderr,
+                    "vscsi_preprocess_desc: direct desc out of bounds\n");
+            return -1;
+        }
         req->total_desc = req->local_desc = 1;
         break;
     case SRP_DATA_DESC_INDIRECT: {
-        struct srp_indirect_buf *ind_tmp = (struct srp_indirect_buf *)
-                (cmd->add_data + req->cdb_offset);
+        struct srp_indirect_buf *ind_tmp;
+
+        if (req->cdb_offset + sizeof(struct srp_indirect_buf) > avail) {
+            fprintf(stderr,
+                    "vscsi_preprocess_desc: indirect desc out of bounds\n");
+            return -1;
+        }
+        ind_tmp = (struct srp_indirect_buf *)(cmd->add_data + req->cdb_offset);
 
         req->total_desc = be32_to_cpu(ind_tmp->table_desc.len) /
                           sizeof(struct srp_direct_buf);
         req->local_desc = req->writing ? cmd->data_out_desc_cnt :
                           cmd->data_in_desc_cnt;
+
+        /* desc_list[] entries must also fit inside the IU buffer */
+        if (req->local_desc * sizeof(struct srp_direct_buf) >
+            avail - req->cdb_offset - sizeof(struct srp_indirect_buf)) {
+            fprintf(stderr,
+                    "vscsi_preprocess_desc: local_desc out of bounds\n");
+            return -1;
+        }
         break;
     }
     default:
@@ -725,7 +746,11 @@ static void vscsi_inquiry_no_target(VSCSIState *s, vscsi_req *req)
     memcpy(&resp_data[8], "QEMU    ", 8);
 
     req->writing = 0;
-    vscsi_preprocess_desc(req);
+    if (vscsi_preprocess_desc(req) < 0) {
+        vscsi_makeup_sense(s, req, HARDWARE_ERROR, 0, 0);
+        vscsi_send_rsp(s, req, CHECK_CONDITION, 0, 0);
+        return;
+    }
     rc = vscsi_srp_transfer_data(s, req, 0, resp_data, len);
     if (rc < 0) {
         vscsi_makeup_sense(s, req, HARDWARE_ERROR, 0, 0);
@@ -775,7 +800,12 @@ static void vscsi_report_luns(VSCSIState *s, vscsi_req *req)
         i += 8;
     }
 
-    vscsi_preprocess_desc(req);
+    if (vscsi_preprocess_desc(req) < 0) {
+        g_free(resp_data);
+        vscsi_makeup_sense(s, req, HARDWARE_ERROR, 0, 0);
+        vscsi_send_rsp(s, req, CHECK_CONDITION, 0, 0);
+        return;
+    }
     rc = vscsi_srp_transfer_data(s, req, 0, resp_data, len);
     g_free(resp_data);
     if (rc < 0) {
@@ -823,7 +853,10 @@ static int vscsi_queue_cmd(VSCSIState *s, vscsi_req *req)
         req->writing = (n < 1);
 
         /* Preprocess RDMA descriptors */
-        vscsi_preprocess_desc(req);
+        if (vscsi_preprocess_desc(req) < 0) {
+            scsi_req_cancel(req->sreq);
+            return 1;
+        }
 
         /* Get transfer direction and initiate transfer */
         if (n > 0) {
-- 
2.52.0


