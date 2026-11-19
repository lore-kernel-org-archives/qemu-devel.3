Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40CE606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=YWlkUkb9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU0NX-0004NE-9G; Thu, 19 Nov 2026 06:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xU0NU-0004M5-KU
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:32:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xU0NT-0000FS-3w
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 06:32:32 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJAuhtW4107726
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=n66uC+SBK6LsJXZza
 +U9zoOO57LNPDuin5qGIzf4okQ=; b=YWlkUkb9vtZSxrusnoHgSRzBYWoiBrYxb
 Oo/howbw6uEl7P4qU/n9s4/S5zWXY+SXJfBYs9tSY/a4hcLnzhSndf6iX7W46YTD
 cYcDilXIZ/RJHZbfG9jSSVlJXZD2gEy6hYqxh7zitxs6T+fi6Xn81gZr1r0L7weN
 c3A0eGt5E0GTLALIkZ6phBH3bAjrLqqPGC+qMBS1g91Zloe/Us62MbBPPc3kF3xu
 cVhsF+fcxLZ2aNGwJsfj0o2iH69YxHwdsDZ85yPylTZJ0LEWb9AA1xQDvCuOvAKW
 SNoyLYnPFIFFg8qSsogUbe9LIdAEleXXtKpS0pG/X3IdXJvz6+NTg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105ngmj1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:32:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJB5CoV2447688
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:32:29 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1v9x9931-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 11:32:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AJBWPHx50004318
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Nov 2026 11:32:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 609E72004E;
 Thu, 19 Nov 2026 11:32:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7D60220040;
 Thu, 19 Nov 2026 11:32:24 +0000 (GMT)
Received: from Mac.com (unknown [9.43.71.183])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 19 Nov 2026 11:32:24 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [PULL 3/6] MAINTAINERS: Step up as maintainer for PPC KVM CPUs
Date: Thu, 19 Nov 2026 17:02:11 +0530
Message-ID: <20261119113207.79328-11-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261119113207.79328-8-harshpb@linux.ibm.com>
References: <20261119113207.79328-8-harshpb@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfX4NKh6IkDKRtf
 VMIdT7nESMQ5J+yeGfaWI/n8bTXz9mvOg0wO3rlyYWIAe4/VBCCcNrVa5+RR+yEkWvwloawO+UK
 PCrW7Qkp9m3ufe3HauR4v+AhYC/uP5vDrv7wvVaoXY2gxhlg2F6v0vsk70Kv4rY8ntY3kwiBtnM
 R3hDK66gTL4WjDDoYXKb6XTqU3rGN6Cc2c7pLGGXSOXROO6cgih7Bska/WuX863MDSFQxAfi9Pg
 vLs8sWeDjqVSUksZZ3LnLBEZ8vOeC3hR0OHBo6batlasNFe6h3pGQ8rN/3AISVvoECa7MaM4yGB
 ud36Eem1qYSsQXLlqXdIFKOXx5ys3sayCnLcaiIlwKz36DYjkZ1r2NDqjCD4Fv/3tA7b5NvprHc
 f0Wl8KQnMlGtqFTxkN0pwjDkV5w6zvraVF80GHVm6nSfSAaGc7On+NS5B0RArvkMtHhN5dEG7SF
 rdjP4DRTMOn8atJQRsw==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afede4d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=4VVcHpUFlTeZ-k0x__MA:9
X-Proofpoint-GUID: z7vZH4zgseUqRDSlomfPBd3QzrM6Y3KY
X-Proofpoint-ORIG-GUID: z7vZH4zgseUqRDSlomfPBd3QzrM6Y3KY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfX/r19DnZJ2lvT
 CfFyxUl2c6Y6DcPJ28QeKANrNtivtVAQgjcEKC+hiTun1v48+Qyz4FWeQjTqwEUoc3ngS/JxtMc
 rPSJA0+/NcGq8lzDFFxruw2SFHOHLys=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190045
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

From: Amit Machhiwal <amachhiw@linux.ibm.com>

Update entry for PPC KVM CPUs: move from Reviewer (R:) to Maintainer
(M:) and reflect the improved coverage by changing status from
"Odd Fixes" to "Maintained".

Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261112164617.85849-2-amachhiw@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dcfdecedcf..0492190107 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -515,9 +515,9 @@ F: tests/functional/aarch64/test_kvm.py
 
 PPC KVM CPUs
 M: Nicholas Piggin <npiggin@gmail.com>
+M: Amit Machhiwal <amachhiw@linux.ibm.com>
 R: Harsh Prateek Bora <harshpb@linux.ibm.com>
-R: Amit Machhiwal <amachhiw@linux.ibm.com>
-S: Odd Fixes
+S: Maintained
 F: target/ppc/kvm.c
 
 S390 KVM CPUs
-- 
2.52.0


