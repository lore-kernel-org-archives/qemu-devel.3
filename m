Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3D3EB1067
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzynd-00071e-KY; Tue, 10 Mar 2026 11:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vzynN-0006p5-RH
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:14:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vzynL-0000Fd-NG
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:14:53 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62AAYBeG1721997
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:14:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=MMM8fqi8Az8/ii4Qk
 ag1EO3WTRA4KMdJ9e91Krm1NgQ=; b=L/wiwbnaJfQjzSxfIld5MSbhpSbQCSEhx
 lULZTlM+JonPJyByg/OcKxCnRklV+skF6cDDmLS9Y8y7Svx6OOfRwF6HT+vJFClf
 fU6FyS90EuimXDoo4ZehWMmg7svCH8xHYm45h1Rzi+AV0O9pBkN09lon58SQkKjK
 tDMXwf6QDitJrMv0gwdjCbMHqUJX6lquFjdzqjfCAL20/6Mv81+xEOTaBrmFcrfz
 Xb1u2/EjAwcDqBQuHogi7sWBTAWJ+gQRZPSCU0EWla6sn9jV7gqmQ8tkh2mfz2GM
 MpzusdCIF+Dn1Gi6qhu5y0O54u7llSBo9dNC7OV+VtQtJLI9p33rA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvrb6fe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:14:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62ACwnoV015750
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:14:49 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs1221bku-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:14:49 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62AFEjK044171536
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 15:14:46 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DC42C2004B;
 Tue, 10 Mar 2026 15:14:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC30C2004E;
 Tue, 10 Mar 2026 15:14:44 +0000 (GMT)
Received: from Mac.com (unknown [9.39.23.49])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2026 15:14:44 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: [PULL 03/10] ppc/pnv: Handle stash command in PowerNV SBE
Date: Tue, 10 Mar 2026 20:44:23 +0530
Message-ID: <20260310151432.92531-4-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260310151432.92531-1-harshpb@linux.ibm.com>
References: <20260310151432.92531-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEzMSBTYWx0ZWRfX9DIV4+bosLnF
 TVI6BbuEGEjUUBE25ImOZX8amOMHoZ9F4vwtLwx3WUdpGpu0rh0JlJp7F/FoDURTlFd51QWXkbm
 bKMOdffvJc07NrRGRuETtfSJZrraWDVL13vOUPH9tBwgho6z9vkfs92Os+L24dET9i/T8Ai0JIv
 7N2pux9yFr4a9Na4ySR41l9N2cm3+XppMAwHfoiYFzgyaBshNad+LoMzCtfRs2gmcmjN6k/Jz/z
 B4q8Gk5HtE6VoPAJxFaScSff/Oh+jTU6D1WxC12dyAN6Ikqd6M4zvyr5G0x88JPfsW4g24Abd7B
 M4KtWhJtBoL3R8rzMEVHDX7GH5GX3MbOIQZPEJkdJpg83Y5z4Pkj1u1sUZmATKVwacOjoWweCxQ
 mwEpYFjip/EZQclYRhNEfm6I5EO/iAE3yZKA+FUiBvWA6lZiygodxLEIM3xf+dfDKAHt2yX6vtw
 LJK56oesuhoGp37iAhQ==
X-Proofpoint-GUID: wu8UD6jKvZC06_hFuzIy-S6FLiKwR_jH
X-Proofpoint-ORIG-GUID: wu8UD6jKvZC06_hFuzIy-S6FLiKwR_jH
X-Authority-Analysis: v=2.4 cv=QoFTHFyd c=1 sm=1 tr=0 ts=69b0356a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=lqnwqb0_oS2Hd41rSKUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603100131
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

Earlier since the SBE_CMD_STASH_MPIPL_CONFIG command was not handled, so
skiboot used to not get any response from SBE:

    [  106.350742821,3] SBE: Message timeout [chip id = 0], cmd = d7, subcmd = 7
    [  106.352067746,3] SBE: Failed to send stash MPIPL config [chip id = 0x0, rc = 254]

Fix this by handling the command in PowerNV SBE, and sending a response so
skiboot knows SBE has handled the STASH command

The stashed skiboot base is later used to access the relocated MDST/MDDT
tables when MPIPL is implemented.

The purpose of stashing relocated base address is explained in following
skiboot commit:

    author Vasant Hegde <hegdevasant@linux.vnet.ibm.com> Fri Jul 12 16:47:51 2019 +0530
    committer Oliver O'Halloran <oohall@gmail.com> Thu Aug 15 17:53:39 2019 +1000

    SBE: Send OPAL relocated base address to SBE

      OPAL relocates itself during boot. During memory preserving IPL hostboot needs
      to access relocated OPAL base address to get MDST, MDDT tables. Hence send
      relocated base address to SBE via 'stash MPIPL config' chip-op. During next
      IPL SBE will send stashed data to hostboot... so that hostboot can access
      these data.

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260310124619.3909045-4-adityag@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 include/hw/ppc/pnv_mpipl.h |  3 +++
 hw/ppc/pnv_sbe.c           | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/hw/ppc/pnv_mpipl.h b/include/hw/ppc/pnv_mpipl.h
index c544984dc7..60d6ede482 100644
--- a/include/hw/ppc/pnv_mpipl.h
+++ b/include/hw/ppc/pnv_mpipl.h
@@ -8,11 +8,14 @@
 #define PNV_MPIPL_H
 
 #include "qemu/osdep.h"
+#include "exec/hwaddr.h"
 
 typedef struct MpiplPreservedState MpiplPreservedState;
 
 /* Preserved state to be saved in PnvMachineState */
 struct MpiplPreservedState {
+    /* skiboot_base will be valid only after OPAL sends relocated base to SBE */
+    hwaddr     skiboot_base;
     bool       is_next_boot_mpipl;
 };
 
diff --git a/hw/ppc/pnv_sbe.c b/hw/ppc/pnv_sbe.c
index 5a2b3342d1..46c5047f1c 100644
--- a/hw/ppc/pnv_sbe.c
+++ b/hw/ppc/pnv_sbe.c
@@ -233,8 +233,11 @@ static void sbe_timer(void *opaque)
 
 static void do_sbe_msg(PnvSBE *sbe)
 {
+    PnvMachineState *pnv = PNV_MACHINE(qdev_get_machine());
+    MachineState *machine = MACHINE(pnv);
     struct sbe_msg msg;
     uint16_t cmd, ctrl_flags, seq_id;
+    uint64_t mbox_val;
     int i;
 
     memset(&msg, 0, sizeof(msg));
@@ -265,6 +268,40 @@ static void do_sbe_msg(PnvSBE *sbe)
             timer_del(sbe->timer);
         }
         break;
+    case SBE_CMD_STASH_MPIPL_CONFIG:
+        /* key = sbe->mbox[1] */
+        switch (sbe->mbox[1]) {
+        case SBE_STASH_KEY_SKIBOOT_BASE:
+            mbox_val = sbe->mbox[2];
+            if (mbox_val >= machine->ram_size) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                  "SBE: skiboot_base 0x%" PRIx64 " exceeds RAM size 0x%" PRIx64 "\n",
+                  mbox_val, machine->ram_size);
+                return;
+            }
+
+            pnv->mpipl_state.skiboot_base = mbox_val;
+            qemu_log_mask(LOG_UNIMP,
+                "Stashing skiboot base: 0x%" HWADDR_PRIx "\n",
+                pnv->mpipl_state.skiboot_base);
+
+            /*
+             * Set the response register.
+             *
+             * Currently setting the same sequence number in
+             * response as we got in the request.
+             */
+            sbe->mbox[4] = sbe->mbox[0];    /* sequence number */
+            pnv_sbe_set_host_doorbell(sbe,
+                    sbe->host_doorbell | SBE_HOST_RESPONSE_WAITING);
+
+            break;
+        default:
+            qemu_log_mask(LOG_UNIMP,
+                "SBE: CMD_STASH_MPIPL_CONFIG: Unimplemented key: 0x" TARGET_FMT_lx "\n",
+                sbe->mbox[1]);
+        }
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "SBE Unimplemented command: 0x%x\n", cmd);
     }
-- 
2.52.0


