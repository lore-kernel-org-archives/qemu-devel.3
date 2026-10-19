Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F6A606A328
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qt9E/24E
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIqCf-0002Th-8r; Mon, 19 Oct 2026 12:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1xIqCA-00021z-SV; Mon, 19 Oct 2026 12:26:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1xIqBv-0001U3-HB; Mon, 19 Oct 2026 12:26:34 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFiFqO4115679; Mon, 19 Oct 2026 16:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=eCDl7inp1C2c6XtfC
 jZgHJftpWzTq5gX/EzI99Sh/Qw=; b=qt9E/24ETZZKUE5//h2uFbzefrRfQipUU
 IX8YCMTp4PUCXQecyi3TjKInF3GmoAvX9wM+EIroWZOfCawHyI+nW9shLBP4NRoN
 m0+zEDAZ/IAKm6te7+bFUjIxN6IyMj99NOURMD+SGyj7RHZOMFoO44+kqTWhN987
 6dStPlUe+q76G9Uf6t4nE+44Rf1vAHGRXgg49MQ5x6NbinVbU0H+yM9bTlgKzEr6
 J5ni24ZsSTKwgLPo6gqSpVO4lVLHl+h2BWNGxa2/mMEiva3IwyUH7J76d0LBbmuP
 er6KF+Xrlk+CC/42swn/IGhXJAfWUaA+6lQAWa9y0nKConhq0QEzA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hbxehuvxu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 16:26:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFZ6mi081550; Mon, 19 Oct 2026 16:26:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hcmbjxgcu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 16:26:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69JGQHNR17629450
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Oct 2026 16:26:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 30CD220043;
 Mon, 19 Oct 2026 16:26:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 548E820040;
 Mon, 19 Oct 2026 16:26:13 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.124.217.62])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 19 Oct 2026 16:26:13 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Sourabh Bhat <sbhat@linux.ibm.com>, anushree.mathur@linux.vnet.ibm.com,
 clg@redhat.com, Sourabh Jain <sourabhjain@linux.ibm.com>,
 adityag@linux.ibm.com, nikhilks@linux.ibm.com
Cc: pierrick.bouvier@oss.qualcomm.com, rathc@linux.ibm.com,
 Nicholas Piggin <npiggin@gmail.com>, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, hbathini@linux.ibm.com, shivangu@linux.ibm.com
Subject: [PATCH v6 3/6] ppc/spapr: Add support for ibm, open-errinjct and ibm,
 close-errinjct
Date: Mon, 19 Oct 2026 21:55:37 +0530
Message-ID: <20261019162541.68440-4-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261019162541.68440-1-nnmlinux@linux.ibm.com>
References: <20261019162541.68440-1-nnmlinux@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2NCBTYWx0ZWRfX9iaFb3JhGr9O
 oTI94YyF7SdSL8LJ6j0D4eRgJZ5rZVE2tVNTHsH1Vhfj21VXK8C7M5M72kxYo3kNXGnbPr9qFji
 ZdiETzJj+TGtraV4zxLzYLybPjYzbBapBez5sxgjGOHB1s+yDTlZSe6KSGf2DPdPrTvFqqsvyO6
 nowWbevLO5MAaApIgNmCsdC+UqfvMFMPy+sxxnN5g8j5++2zqRPFKXJwhhhNQ/NHT13pM4mhptv
 QEZ4szn6z7QlD+gQ0oJDnXzkCRdhnwYxY/7X1EXB+BKS4l8xjVlcnO0LuQzEssc5fBgHz6p4lGp
 Tqn+sYYLmxmMptC8FEZiM1CCEPwppXmltWdsa8ZLppoKlY5WPqOwWdYaIOQsLfmPucI0YONjC/U
 LRxM94vnL+ySERbUdeP3KqQqsjHmfU15TKVsG+K2FbGU0ycgZAxdTeQa7dnH/d8w+XxBlPYtY3v
 KkAPJWlE5d7TU9QU7uA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2NCBTYWx0ZWRfXwsbOXKoo7MkQ
 dEasSWoB8UYHxuwvruhXYSsB0d9R2T+ZCyjkIXPXvyCTZ/xugE9lnG1isdwSfLrxg2mRA78df9V
 7V66CqwrSOe0bcMf16ITAvAJkrrxLx0=
X-Proofpoint-GUID: fAcoCrlTKUhr5DiJr5ZJbT_O_EP9O1Jn
X-Proofpoint-ORIG-GUID: Gscc1Ynd_32Qm99TKcqDQabt9d6t5cTV
X-Authority-Analysis: v=2.4 cv=OZQNnRTY c=1 sm=1 tr=0 ts=6ad644b2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=iw8L5VQ-6e4m0g-3eYQA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190064
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

Add RTAS handlers for ibm,open-errinjct and ibm,close-errinjct.  These
calls manage exclusive access to the error-injection facility through a
simple session token mechanism: only one session may be open at a time.

ibm,open-errinjct (nargs=0, nret=2):
  Returns rets[0]=token, rets[1]=status.
  On success: token=1, status=RTAS_OUT_SUCCESS.
  Already-open: token=0, status=RTAS_OUT_ALREADY_OPEN.
  Bad args:    token=0, status=RTAS_OUT_PARAM_ERROR.

ibm,close-errinjct (nargs=1, nret=1):
  Takes the session token in args[0].
  Returns RTAS_OUT_SUCCESS on a matching open token.
  Returns RTAS_OUT_NOT_OPEN if the token is invalid or no session exists.

RTAS_IBM_OPEN_ERRINJCT and RTAS_IBM_CLOSE_ERRINJCT token values and
RTAS_OUT_ALREADY_OPEN / RTAS_OUT_NOT_OPEN return codes are added to
include/hw/ppc/spapr.h.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
Reviewed-by: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
---
 include/hw/ppc/spapr.h |  8 +++++-
 hw/ppc/spapr_pci.c     | 57 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 47791c71bd..bcb1da5fab 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -825,8 +825,14 @@ enum rtas_err_type {
 #define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x2C)
 #define RTAS_CONFIGURE_KERNEL_DUMP              (RTAS_TOKEN_BASE + 0x2D)
 #define RTAS_IBM_ERRINJCT                       (RTAS_TOKEN_BASE + 0x2E)
+#define RTAS_IBM_OPEN_ERRINJCT                  (RTAS_TOKEN_BASE + 0x2F)
+#define RTAS_IBM_CLOSE_ERRINJCT                 (RTAS_TOKEN_BASE + 0x30)
 
-#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2F)
+#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x31)
+
+/* ibm,open-errinjct/ibm,close-errinjct return codes */
+#define RTAS_OUT_ALREADY_OPEN                   -4
+#define RTAS_OUT_NOT_OPEN                       -5
 
 /* RTAS ibm,get-system-parameter token values */
 #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index fa555f1092..ec9f6284c7 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -836,6 +836,57 @@ param_error_exit:
     rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
 }
 
+static void rtas_ibm_open_errinjct(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                                   uint32_t token, uint32_t nargs,
+                                   target_ulong args, uint32_t nret,
+                                   target_ulong rets)
+{
+    if (nargs != 0 || nret != 2) {
+        rtas_st(rets, 0, 0);
+        rtas_st(rets, 1, RTAS_OUT_PARAM_ERROR);
+        return;
+    }
+
+    if (spapr->errinjct_token) {
+        /* Session already open: return token=0, status=ALREADY_OPEN */
+        rtas_st(rets, 0, 0);
+        rtas_st(rets, 1, RTAS_OUT_ALREADY_OPEN);
+        return;
+    }
+
+    spapr->errinjct_token = 1;
+
+    /*
+     * ibm,open-errinjct has an unusual return convention: rets[0] is the
+     * session token and rets[1] is the status code.
+     */
+    rtas_st(rets, 0, spapr->errinjct_token);
+    rtas_st(rets, 1, RTAS_OUT_SUCCESS);
+}
+
+static void rtas_ibm_close_errinjct(PowerPCCPU *cpu, SpaprMachineState *spapr,
+                                    uint32_t token, uint32_t nargs,
+                                    target_ulong args, uint32_t nret,
+                                    target_ulong rets)
+{
+    uint32_t o_token;
+
+    if (nargs != 1 || nret != 1) {
+        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+        return;
+    }
+
+    o_token = rtas_ld(args, 0);
+
+    if (!spapr->errinjct_token || o_token != spapr->errinjct_token) {
+        rtas_st(rets, 0, RTAS_OUT_NOT_OPEN);
+        return;
+    }
+
+    spapr->errinjct_token = 0;
+    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
+}
+
 static void pci_spapr_set_irq(void *opaque, int irq_num, int level)
 {
     /*
@@ -2515,6 +2566,12 @@ void spapr_pci_rtas_init(void)
     spapr_rtas_register(RTAS_IBM_ERRINJCT,
                         "ibm,errinjct",
                         rtas_ibm_errinjct);
+    spapr_rtas_register(RTAS_IBM_OPEN_ERRINJCT,
+                        "ibm,open-errinjct",
+                        rtas_ibm_open_errinjct);
+    spapr_rtas_register(RTAS_IBM_CLOSE_ERRINJCT,
+                        "ibm,close-errinjct",
+                        rtas_ibm_close_errinjct);
 }
 
 static void spapr_pci_register_types(void)
-- 
2.51.1


