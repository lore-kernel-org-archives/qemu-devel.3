Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA544C61DCD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:11:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzplb-0007So-MD; Fri, 28 Aug 2026 02:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzpla-0007NE-8d
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wzplY-0000xv-Bi
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 02:08:42 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67S22OLh597167
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=tJOPf5WbdkLXk++Df
 5PfKNl2a09Dtnvx0Ohj3tbMq3M=; b=SLEWS8ntzHKr405Hq7TMZuVNFDTXyMaTU
 cz4Gb96sRoKV7EtTO1W7e92Du6gBfFDVLqJYCWUYYTupndos56rU8hZ5N8ZE5xuh
 DQ2+1iqZJLeMiNK8XiNbhgAO8FVzUOR7TbgwlOY9lMUsplNBnVUyKstKNOMcmIos
 023suDL89PK/uujbQ/VRW3cd3bqhiO59SjHfSWLDmJVy78RtTvFGt2aEFP/4hOVV
 NkHeTiWucE5qfEaTVSsYc+Kmq5VtnRxqUSEcB5KpXz1xHSNz3i2q5JAZEw1xfb17
 cxFh2/jCUYjUKQwoIQu2qOZZfhytwC/cGlyJGZRB4L19wZbsSl/dw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g7394je87-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67S5uEsL025163
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragvgdw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 06:08:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67S68Ydd34472368
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 28 Aug 2026 06:08:34 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 199C420043;
 Fri, 28 Aug 2026 06:08:34 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5104120040;
 Fri, 28 Aug 2026 06:08:32 +0000 (GMT)
Received: from Mac.com (unknown [9.124.217.17])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 28 Aug 2026 06:08:32 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PULL 26/41] target/ppc: make do_ea_calc_ra available for 32 bit
 builds
Date: Fri, 28 Aug 2026 11:37:01 +0530
Message-ID: <20260828060716.91672-27-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260828060716.91672-1-harshpb@linux.ibm.com>
References: <20260828060716.91672-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _zZrpnhSjhyU1jSfXeD_bOYAFvTlsnLd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX/8UuR5iZ3Ire
 icYIPq5S0wWhrVZdKx3zCccMCgKhlC7efwvAeMoNG9TAYtS5nn+ZD3CplFyiXSoWG2AioQp/8ny
 KNJsbft2JOrUSPywOf8Ivc0XhAp52q4zHH3J9pFqWmrZsSn7XbyPePyS10zpqa9ctqmZIcuSnia
 Rsh2YQW373ordwA6rUKN/Sw1GphjC4T/NW2ITov+WJibit7lHv44NBfaj8kifpXdrsTkpSHkO1n
 DBxFn491dFkcO/RD8JMdW2pJwPJbVkVoDq6oGGII5b5JPewuvYfKuoIFU65a8h5szi0xfQqz3gl
 iBOggV5Dnx12fCAoVSxxokG8nkwWd+RaF6idLNhKK4ITySvO7shNCRmFj3evw/OrdHTZR5M9baW
 6md+IJKi/QyJeG+s+iKYjDG1YvpfLuYk40Cs/Jtdi/8WnbVejmg2uN1HlWbkQNdscYxSXQGHHQy
 7NvV7NBeR8rHZjEYkag==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a9125e6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=tTuln9y6vRRPCHsaWd0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDA1MCBTYWx0ZWRfX6WkKq15Z+DGE
 nk2qFYKTMiXvfFnh2/XIP8jVb7B9btpbXXCYxThJQPqO/tyS9zKTXJV0wuBy5aKGUXagQ0oRMms
 GDI5Z3fnVBtewejjV0VVhC78yS6bRWM=
X-Proofpoint-ORIG-GUID: _zZrpnhSjhyU1jSfXeD_bOYAFvTlsnLd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_01,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280050
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

From: Chinmay Rath <rathc@linux.ibm.com>

There is no reason to keep do_ea_calc_ra exclusive to TARGET_PPC64.
Make it available for PPC32 builds.

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260827133010.278889-23-rathc@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 target/ppc/translate.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index c5361d8db5..c45883ac30 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -2397,7 +2397,6 @@ static TCGv do_ea_calc(DisasContext *ctx, int ra, TCGv displ)
     return ea;
 }
 
-#if defined(TARGET_PPC64)
 /* EA <- (ra == 0) ? 0 : GPR[ra] */
 static TCGv do_ea_calc_ra(DisasContext *ctx, int ra)
 {
@@ -2411,7 +2410,6 @@ static TCGv do_ea_calc_ra(DisasContext *ctx, int ra)
     }
     return EA;
 }
-#endif
 
 /***                             Integer load                              ***/
 #define DEF_MEMOP(op) ((op) | ctx->default_tcg_memop_mask)
-- 
2.52.0


