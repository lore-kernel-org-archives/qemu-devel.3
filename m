Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDEBC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgh76-0006Ei-1E; Mon, 06 Jul 2026 07:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wgh70-0006EM-24
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 07:03:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>) id 1wgh6y-0001G0-8G
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 07:03:41 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6669IUbC3826475; Mon, 6 Jul 2026 11:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=dEfnSzt14qe6qKjyLmD1H2AkRj00fBBFWh7KjIzyx
 qc=; b=feo45tFsKj/OQ17+q6eV4sWTjgOljWw2F3AjshWFlufDR67BFydgI6ZBA
 mrRgkRZZRdfYSX2nsHSbxz+vHf0XTzF4WdCi+7YNet5NhDkFRBxCoTP752y6ym6R
 Awbzi55xCmTaoqvMbwyGMc9UXqUDF60D5NxFzYtMCBnjUoXseb9fOYKm8cAC37Sd
 +qfc4OvK0q3KuQUrBdXpUI78ETjv40ozmGhz2dg6OF+vXvlb0FFF19FbC5MOCOKE
 riYbuL7hgMEHRvnRMG2QIANumFim3c10DS9ONpxjBrYjIUEVvKHKV/MY1daLvhKz
 It8cjWkUIg02gdcmcsCroW4QYvwWg==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qkn95f6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 11:03:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666AnZWU020126;
 Mon, 6 Jul 2026 11:03:36 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvvwdnp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 11:03:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 666B3Y2V50397496
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 11:03:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 131C72004E;
 Mon,  6 Jul 2026 11:03:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BCE5420040;
 Mon,  6 Jul 2026 11:03:33 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.23.52])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 11:03:33 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/1] accel/tcg: Retry page_check_range() on itree.start
 inconsistency
Date: Mon,  6 Jul 2026 12:57:24 +0200
Message-ID: <20260706110330.4150026-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4b8b88 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=WnMba3A5Bo_uwJxdN2cA:9 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: F7GGZsefYLQ6VaRvse-RwbN7GG7aTn7M
X-Proofpoint-ORIG-GUID: F7GGZsefYLQ6VaRvse-RwbN7GG7aTn7M
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEwOSBTYWx0ZWRfX+AY6Od3J5Tt4
 DMZ6s927sH4m+nPMzkjqqjwRADDpx7vfr5bC0yIZ4cmM4K/YMLygVO0qbEPKmIDGXku/+3jIJvb
 zC9qfjmbzwtHqblSkELJDgS9WGCuuyE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEwOSBTYWx0ZWRfX1+oCyslBycSM
 gMIcK7YFPFur5thpA38ckuuMJVUYtLJS6CM5jxf7pp3HQom6MqZ5B705UmCD65niVdAc+l1HPO8
 wl6cSNBwh1t8KfeskfgOdnaI9qT/dfb4Bh6eWRbJPQS2WVtAKnsJMJREjstqlU39lwy8QsrdObg
 +1dyg9rgn4b1D28/BnVCfSuzdxvawDoEpuhEYd3E4LA8gL/b8aCrgZ9U0p2Q+XCBKfyQHncPQNl
 KC4w95KWSSTc38XqaGBszwTWoq435ksj7xh/T8hKKdAXcxNn8D/c5+7euE4Pr0Up6MkUEPl5Yy8
 kAIUnC+Tk/CXj6x2SmmXBctrTYYTVCRoJytTitgrY9lQq7pCn+Lms4obOMKXJUtNP3fgsCPPJvI
 JJfPrjxMTa74XByp/xxbaNQZROy8Hrs3OODaSG9BWFgOOWylYiJNr2ar0Z/fG9pO/uVkR7nGL/P
 Kr6IobkYJMS38FtgrhQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060109
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

This is an attempt to improve the vma-pthread test situation sparked by
a bug report by wasmtime project. The patch doesn't fix all issues, but
it definitely makes things better and I think I understand what
particular thread interleaving leads to the issue (details are in the
commit message).

There is at least one other thing that I find suspicious about the
current code: page_check_range() fetches itree.last twice, and indeed,
using qatomic_read() there makes things even better, but still not
perfect, and I still cannot clearly elaborate what is the exact
interleaving with pageflags_set_clear() that causes a problem there, so
I'm not sending that one for now.

Best regards,
Ilya

Ilya Leoshkevich (1):
  accel/tcg: Retry page_check_range() on itree.start inconsistency

 accel/tcg/user-exec.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

-- 
2.54.0


