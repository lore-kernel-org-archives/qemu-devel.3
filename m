Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D247FD3772
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 16:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvHe5-0008BH-8s; Wed, 25 Feb 2026 11:21:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vvHe3-0008An-M0; Wed, 25 Feb 2026 11:21:51 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vvHe2-00061u-6C; Wed, 25 Feb 2026 11:21:51 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61PFFhWH2771372; Wed, 25 Feb 2026 16:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=ZzC2+Y8+E7TCODtvPlnLXD1Aj8qnAxpPs32FCY/+T
 qI=; b=ecAOFF4EkoaaSrqGxlXSA4hwsbwqFYwXbBbeJl2LWbh31vAQ/L5geis9v
 HxZvarU1Z0qhsgkFGl0c7bC9ZtK/dNAYhzaNfd6VV91KXu+jHaBcN/z1x3E82IcX
 OGfzq19melkbe4hFFVtJVfwotZ/sGWARiXsM51wDm0cWdguwxqrl7z2OFy5fpTnd
 OKlmsoyK3c7+KOeUm2Y9qPLVEln2yInPBgKoKudGFGhB7+CyVMWmFqRvPFO8py0z
 hcZmof5ed1tZ7LCsZSW2ZsZ0HtTTxa7FUtzYJGfwAiXF0YQt8UV1P4lQPVieeqXL
 mhRvNf5I2i2EgHfi+j0YJxql1Z5+Q==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf34c8d9k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Feb 2026 16:21:48 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61PDMllp003836;
 Wed, 25 Feb 2026 16:21:47 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfs8jwv2b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 25 Feb 2026 16:21:47 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61PGLlCS24379958
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 25 Feb 2026 16:21:47 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E96195803F;
 Wed, 25 Feb 2026 16:21:46 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 905B258056;
 Wed, 25 Feb 2026 16:21:46 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 25 Feb 2026 16:21:46 +0000 (GMT)
From: Glenn Miles <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, harshpb@linux.ibm.com,
 rathc@linux.ibm.com
Subject: [PATCH] MAINTAINERS: Add self as reviewer for PowerPC TCG
Date: Wed, 25 Feb 2026 10:21:04 -0600
Message-ID: <20260225162118.914008-1-milesg@linux.ibm.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE1NSBTYWx0ZWRfX7XPm18hIPmXG
 vLNE4STnoD6JZtjANEA6atwwY1V32p2AmqI1CNTA9Qiy/79hH5cgvfpFt1EdyU8GE9mXCaz78uj
 E5Oe5yhhLd43Q8l1bqoAIg3b+a4qNGm4QkcEw1MdKo65G6BZNvo4JdtBKTYgzYQ46Tbp2Tb0aRb
 6VIRgCF0rHFSiRZb/IoX32DOmmwkQhCkP8aMhvGb9hVwTd7wWH/95bNVfERSGm7wZNfgHk355Sf
 qzt/zBIX2XZ5nW37F+6qJy6lpqpldaMP8zHTEtLnfxbhbl31yDtwarBhBeGobONDL5POsjMqlSU
 bbhcIKk2wG6NFvltJJsitMxmsG4YGbhgjJt2fKHLvSwZg9eWR4YhnBf+xX04kZw1LrfXymYRw0B
 6WB4SSVN6hwRdXuJ9ftEByoE3DpsERPjJXkblqKIfxlGn6VJbzzlQfVVufHYncMrgpoIhh7mRWf
 164ZtbqgUIo0jl7NTPw==
X-Proofpoint-ORIG-GUID: 7_-pUNF4Qk9qgm_AAw9bRWqfyw_MOXsD
X-Authority-Analysis: v=2.4 cv=F9lat6hN c=1 sm=1 tr=0 ts=699f219c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=69wJf7TsAAAA:8
 a=E4yikVmuLDfcT8_usIQA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: 7_-pUNF4Qk9qgm_AAw9bRWqfyw_MOXsD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_02,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602250155
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
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

Added myself as a reviewer for PowerPC TCG

Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 233d2a5e71..7aa8516d69 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -312,6 +312,7 @@ F: tests/tcg/or1k/
 PowerPC TCG CPUs
 M: Nicholas Piggin <npiggin@gmail.com>
 R: Chinmay Rath <rathc@linux.ibm.com>
+R: Glenn Miles <milesg@linux.ibm.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: target/ppc/
-- 
2.43.7


