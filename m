Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1453BC5DF81
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 07:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy2kX-0002YB-Kk; Sun, 23 Aug 2026 03:36:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wy2kW-0002Xa-FT
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 03:36:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wy2kU-0005qF-Bw
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 03:36:12 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67N71dxh2501604
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 07:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=SWQ1iTbDtnWO5Wgrg
 Fer/xzTWNBTrEncPz36qCGhBsU=; b=rjMCpMtyrrLKQWdHdpUqy5Y3iWWBwlttM
 HSjKxgj9m8I2G+o7gKqxwNklxY72PeorpHTywTokfW4WFovYrLhjxZLJuivZQVdk
 lNFEhImxKtF9BG9TEt/bqXTfPqJEKT0JfKIsrTTAviH3ws4abTrJvTf5qa8H+mdB
 rJY1wbzImcn5oTZQAznz3xleirJ5CXDYzZTFwPkZ3SnG4vIVBZbVrOLdnyfiYkkl
 1kpcnkpcZnVfu1igN//DLE3W47l4Muj50X2ij7G9X+lkHIsrPuKM+iAgAkLmVgiv
 +UnCaKEVIL4e9O5d/vUOsBeL6e+yAQt6NCcxyl4ww7yfoM8tTFecg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4c14y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 07:36:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67N7QFw9027829
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 07:36:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3prxh7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 07:36:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67N7a4pJ26083898
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 23 Aug 2026 07:36:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A40720043;
 Sun, 23 Aug 2026 07:36:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D5C0D20040;
 Sun, 23 Aug 2026 07:36:02 +0000 (GMT)
Received: from Mac.com (unknown [9.39.19.238])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sun, 23 Aug 2026 07:36:02 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>,
 Aditya Gupta <adityag@linux.ibm.com>
Subject: [PULL 7/7] MAINTAINERS: add self as reviewer for PowerPC RAS
Date: Sun, 23 Aug 2026 13:05:33 +0530
Message-ID: <20260823073536.40282-8-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260823073536.40282-1-harshpb@linux.ibm.com>
References: <20260823073536.40282-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QZKTKW-1RzNDueqOPTe-vftyRm8wZ4OG
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIzMDA2NiBTYWx0ZWRfX2hFTJr/BZiZT
 yvK4Bpt9kT3H97XjsIBU/Hq8NBF6SfavTpL83VTmodBD9cZ3BWa1g4wtr9VMgfqTDjiOeDZMkHP
 VkEDeG6pbjgn6nY6bwH1Kt2uEUP7Jj4=
X-Proofpoint-GUID: QZKTKW-1RzNDueqOPTe-vftyRm8wZ4OG
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8aa2e8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=qI0GqOVoFEWQFRkWlOEA:9
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIzMDA2NiBTYWx0ZWRfX369dNukmeyNq
 MuHSi5iW2oZB2UtCCidZK6t2HmkRdymbx1hS43kMu+uxd4xYflvjpkQOziEPiZ7Ce3kvTwID0Ca
 eaN9N36pqNVTCR7vZ7cAJSUi9PcNuycn1mFJXbdY1cv4Kgc2GhGGFh4by/68xWjBqOCYYLLHuBu
 lj5QRK1Xi2JJn3DsAK+BuCcyMBzPNOHweD98j4RvnFJiSHhiEyr5hYRJscQ8xvlmXRzo7McJvtd
 uspXF+67sOvuDpAjf4QoMqm4qLvde+x4Nqz2Wc0wdcIyLDScR0jQCBeeCX5IwZaDJ43tYj9m1Y2
 epTkF+vASdanMpboJ7CRszmo/MfwS1vyaP65hWYH5mZNwBog7Wg9B1J8Cunwx4lFmbRPT6iWVJv
 c/arHA0mVO19MK6CMTVDEENwdyCP0dduV3oUyKwPMJts1PhOy5FbpymcAVXj8leHL7zVQWE+Boa
 Hzwi/z0rXbWNvEvG/lQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-23_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608230066
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Shivang Upadhyay <shivangu@linux.ibm.com>

I have been contributing to Fadump, MPIPL as well as PowerNV for quite
some time, and my daily work responsibilities includes taking care of
PowerPC RAS features. I, therefore would like to step up as a reviewer
to get notified of incoming changes in this area and help reviewing
them.

Acked-by: Aditya Gupta <adityag@linux.ibm.com>
Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260819193757.1072909-3-shivangu@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c47e0790ba..60c7f51c23 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1769,6 +1769,7 @@ PowerPC RAS (Reliability, Availability and Serviceability)
 M: Aditya Gupta <adityag@linux.ibm.com>
 R: Sourabh Jain <sourabhjain@linux.ibm.com>
 R: Hari Bathini <hbathini@linux.ibm.com>
+R: Shivang Upadhyay <shivangu@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Maintained
 F: hw/ppc/spapr_events.c
-- 
2.52.0


