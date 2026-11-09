Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BA8606A325
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=AamPCGkO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQW1W-0003pD-34; Mon, 09 Nov 2026 15:31:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bwalk@linux.ibm.com>)
 id 1xQSuD-0005Qy-Tz; Mon, 09 Nov 2026 12:11:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bwalk@linux.ibm.com>)
 id 1xQSu6-0004By-BB; Mon, 09 Nov 2026 12:11:39 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9G1JsP3443582; Mon, 9 Nov 2026 17:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=W5ZBmF3zViDKHDr5e
 QY+NQmUVhMzcoILUYViESYaIdc=; b=AamPCGkOUlylq888mqYPKyJ7zkoN5ONIe
 z9P1AUHhzdhKTKuc48WDz0yA+ucFZ4Z59MShDxs9pT6DZVkB7pXV7MA94kphHwiy
 ZAAOFpraH7RySuCh5+DahUbqIbmkccKK9diaMdF1rI4/t99bGGVzYq/lUr7tR6Ru
 +Lgo5ZKRG7S84KMMr0cA667auDFyvv1g2M1QzvbRAt5ozgJRl3sLhjeKVjgnPMyy
 AzYu9Lzkuo50nx4oyoXeobI4vy4DeTOP7oWVQSm67cyjBpj7/cKC2twZdMJrU1nf
 hl0UGJET4KfY/50f8Kc4DH5SWqdrzWd/FbydPONNn5TmV0awNpdWQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdkfvr2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 17:11:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9Gq4aC079625; Mon, 9 Nov 2026 17:11:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hteaq225w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Nov 2026 17:11:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A9HBOph44302806
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Nov 2026 17:11:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6DFD420040;
 Mon,  9 Nov 2026 17:11:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3A62720043;
 Mon,  9 Nov 2026 17:11:24 +0000 (GMT)
Received: from a46lp03.lnxne.boe (unknown [9.87.84.240])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Nov 2026 17:11:24 +0000 (GMT)
From: Bjoern Walk <bwalk@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Steffen Eiden <seiden@linux.ibm.com>,
 Andreas Grapentin <gra@linux.ibm.com>,
 Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
 Bjoern Walk <bwalk@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 qemu-s390x@nongnu.org (open list:S390 general arch...)
Subject: [RFC Patch 9/8] meson: Enable aarch64 KVM target on s390x host
Date: Mon,  9 Nov 2026 18:10:35 +0100
Message-ID: <20261109171036.3806884-10-bwalk@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109171036.3806884-1-bwalk@linux.ibm.com>
References: <20261109171036.3806884-1-bwalk@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af1fec0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=FS0upHgUAAAA:8 a=VnNF1IyMAAAA:8
 a=SZAF6puwEwma9LbWgO8A:9 a=BQgJtduX4OmZBxSA4osX:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2NiBTYWx0ZWRfX7/8c9rzwo+Q+
 cgaEm2KOmzXU3Tce5qHxS/jeTh3RuTRDuup+gzHF/qowazpA3Op1Zg9C/DfNAecHMV7yc/RwZhw
 24xTBp9zOIlMC0VcNn6fcKkKvWhKuHLaCrmmkGtuTbuDcroE2O8Mai4K4I4/YMJnFFV+oz8ub1W
 RJiD/Lao5F0tzhgviKbr4Ptmr3o+vj4wb3DWXH6g96n/+udgW9QrHj3bbMs6u4gCPNnEXA+ERkM
 gfp3CP2RJ1FxNqiwfz9KefLodBELbokVDCLlmpXrJPCIV0JO4py5N22s5wjqGTqK24vQpYhdRb3
 9wNhRgwbjm+UkKm9/sMVOQCvvWLhmPjxZja0lmANj7v/RGcXRH18gUFmZ4+Pxi0hEIaONm3TZBy
 agOhoaz1voes8lXt5A8rZWCakXWE/W47P+jl5QiW2JOc13QWJuIzCblAVP8195Zr9kTlH19UMzk
 YtI+O8Kg7lMBLQVhtMQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2NiBTYWx0ZWRfX1z1TwXNwmkcp
 CdAcrUph6xhK2KcjkuvTcPHWWVfETNj4wC4Pm9gmu0CsBtkpIrLgOhCsk2JK14zOpSvlQiyQc7q
 1C0/pf7njBtBVHVvNMxObVHktx/VZRc=
X-Proofpoint-ORIG-GUID: FsEqBAB3Niyd7ehj1sD8BPIsHeC4UfaA
X-Proofpoint-GUID: FsEqBAB3Niyd7ehj1sD8BPIsHeC4UfaA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090066
Received-SPF: pass client-ip=148.163.158.5; envelope-from=bwalk@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 09 Nov 2026 15:31:04 -0500
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

From: Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>

NOTE: This is not part of the RFC and meant to be a motivating outlook
why we want to discuss those changes.

Signed-off-by: Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>
Signed-off-by: Bjoern Walk <bwalk@linux.ibm.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index d7bcb581..2d52880c 100644
--- a/meson.build
+++ b/meson.build
@@ -285,7 +285,7 @@ if cpu == 'x86_64'
 elif cpu == 'aarch64'
   kvm_targets = ['aarch64-softmmu']
 elif cpu == 's390x'
-  kvm_targets = ['s390x-softmmu']
+  kvm_targets = ['s390x-softmmu', 'aarch64-softmmu']
 elif cpu == 'ppc64'
   kvm_targets = ['ppc-softmmu', 'ppc64-softmmu']
 elif cpu == 'riscv64'
-- 
2.56.0


