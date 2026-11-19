Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B18606A32A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 10:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kmRCEhzC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTzIw-0006Bx-BB; Thu, 19 Nov 2026 05:23:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xTzIs-0006BR-76; Thu, 19 Nov 2026 05:23:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rathc@linux.ibm.com>)
 id 1xTzIq-0004Rp-IL; Thu, 19 Nov 2026 05:23:41 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6uQPS3436183; Thu, 19 Nov 2026 10:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=XmV9mBwXrxEQ9JGlUA7QXUjM+y6+hay+hfdvWwqo6
 uQ=; b=kmRCEhzC1y48yx3q4V86ROjgyYFfGjiYHWYMA3eFKIMJla5RC0s9EPvT0
 33FVygeoC+kO8y7S+MJSkCMjB8axKA+4O7s6HP0Y5/bvWkoKAbaym8jpISDUDOPA
 Qn8/vmJZYbykYgTl6cXPv4PknIxPr3oHAdO/WggSe5pSMRUI4WKSI9xUlukoC35P
 CXs10wZo1Je36FDcRwsekiXHito4qoa/71ANxs6Zn6G7b54DLMxqXUotuGcMkaLn
 zc3VrhHWTtTAAerIDDNWEBjTOPu869i05m+B5zG1dbxedJ1/FB+5z9q6ZGzdr9y3
 4vs6i0jVNrmEGYcS4YLr6sty47QCQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105t89px-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 10:23:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJA9Jmc2161163; Thu, 19 Nov 2026 10:23:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1v9x8ybh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 10:23:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AJANUSE44499242
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Nov 2026 10:23:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC1282006B;
 Thu, 19 Nov 2026 10:23:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B0AC720071;
 Thu, 19 Nov 2026 10:23:28 +0000 (GMT)
Received: from li-18a0a34c-33fc-11b2-a85c-d9f1631c5692.bl1-in.ibm.com (unknown
 [9.123.8.229]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Nov 2026 10:23:28 +0000 (GMT)
From: Chinmay Rath <rathc@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, harshpb@linux.ibm.com,
 philmd@oss.qualcomm.com, Chinmay Rath <rathc@linux.ibm.com>
Subject: [PATCH] docs/tcg-ops: Rename cpu_env to tcg_env
Date: Thu, 19 Nov 2026 15:53:19 +0530
Message-ID: <20261119102319.2618086-1-rathc@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IouL47/g c=1 sm=1 tr=0 ts=6afece27 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=u-eO6-5vl9_8RLgDY4QA:9
X-Proofpoint-ORIG-GUID: asKFt_ScTLfbBSncjgw85lsdMsc27_lw
X-Proofpoint-GUID: asKFt_ScTLfbBSncjgw85lsdMsc27_lw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzOSBTYWx0ZWRfXzAERSTw/Ww9F
 63PwCdfEPdEdEQBVye2p3uEsM3O4xc8htTOn3umk46Paa+pnvg1Tu8usaz84jxC8xLfFPfYerKE
 YTP+Dm20MJF6aJfCzRQ/4h6i3XCjoWpcG9EOVyZZ0FQI6P/GyI9ilpTMpjkfd2YD4/aGFHEBuAU
 IMssARbzbJRqg1bRqImnVoSY0Rgox5oupVXLrrHFCYjyg5l7pgK9wXoVEWAGdMba7EToVDYK/oO
 937CmPX0MxxHrTjo5E/xgbF45eFE6ccaLiXTdvt81ks81ZgZGbBQm6/kV4o/R0z/SuOS5ztpQV4
 pHdxmduwtDHz4r8cTuZImrWbGZPX0hoYK3hqui8rTf+6s3PjQFz0y+PmLWf50Wlsz1JMW2Qs8/P
 MC69bJiy2T5gttesh4JNBR/O9w2pKUm/mhdT5s2xqpVNQ8YWd1g3SFqFNBi49cxaR4+vuboV8yA
 VmJMqc1ievGbHELPIyQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzOSBTYWx0ZWRfXy3DqL4+ayxzj
 0dmSyj5xrFytMhcaV/Tbu4OLZsocvVo2od+XTxuvF2C5enbpT96Y9HqhPgmVnR3GcmE/IUx7TfX
 2NhgIs/iyVe1bLDQKroX2RWrww/lU5M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1011 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190039
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

Commit ad75a51e (tcg: Rename cpu_env to tcg_env) from 2023, renamed
cpu_env to tcg_env. However the same was never done in the docs.
Updating docs with the necessary renaming.

Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
---
 docs/devel/tcg-ops.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index 51fa183e91..7ee419f959 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -66,7 +66,7 @@ Variables
 
 * ``TEMP_FIXED``
 
-  There is one TCG *fixed global* variable, ``cpu_env``, which is
+  There is one TCG *fixed global* variable, ``tcg_env``, which is
   live in all translation blocks, and holds a pointer to ``CPUArchState``.
   This variable is held in a host cpu register at all times in all
   translation blocks.
@@ -75,7 +75,7 @@ Variables
 
   A TCG *global* is a variable which is live in all translation blocks,
   and corresponds to memory location that is within ``CPUArchState``.
-  These may be specified as an offset from ``cpu_env``, in which case
+  These may be specified as an offset from ``tcg_env``, in which case
   they are called *direct globals*, or may be specified as an offset
   from a direct global, in which case they are called *indirect globals*.
   Even indirect globals should still reference memory within
-- 
2.55.0


