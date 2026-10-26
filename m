Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC8E606A31B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Sk31uGg/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLHl-0007dk-Ai; Mon, 26 Oct 2026 10:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xLLH1-0006wo-Tj; Mon, 26 Oct 2026 10:02:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xLLGy-00018A-Qw; Mon, 26 Oct 2026 10:02:03 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QBEabQ3273120; Mon, 26 Oct 2026 14:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=02rkMUgk19pEu/DUc
 kbbYYfNlloYsqxEfWGsrrfr/8A=; b=Sk31uGg/52SJqfQGwSa2wQ7vqc9bHhMGN
 7Tsw/dPv4RPZQ+SjHDcdBnJmCawG9N/qysvvTm1dHyTbkJ0lnMruxqQ02KrmLQyG
 kzDNnJR9tSkTeyhmRobfDhoyXPs36RKsykJ3BqxPppGEb5u2G5VGl/GT/NfdmvE5
 jr/XNVKoPMkF32onNZ1gJYKqy6PPbIt+CS1Qlj6GNlmFKi5rNpEoli2lDT/HEbrW
 DKA72QEFWpnaFqy2cZCcjgn67HKEPzzRyNtAW//sW4pCoaWR3w4bgobqnWbf2y27
 fveiVAbQDvs9U0hnjw2KmbcC/q3ibx96qAVjL1Xfx6ZoHl1T0DTFw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgj3m2gew-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 14:01:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QB4vcD1270469; Mon, 26 Oct 2026 14:01:58 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hh97gp118-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 26 Oct 2026 14:01:58 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69QE1va952036072
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 26 Oct 2026 14:01:57 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0FFF158053;
 Mon, 26 Oct 2026 14:01:57 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3595F58063;
 Mon, 26 Oct 2026 14:01:56 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.109.57]) by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 26 Oct 2026 14:01:56 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Collin Walling <walling@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PULL 1/6] target/s390x: externalize feat dependency array
Date: Mon, 26 Oct 2026 10:01:48 -0400
Message-ID: <20261026140153.2072253-2-farman@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261026140153.2072253-1-farman@linux.ibm.com>
References: <20261026140153.2072253-1-farman@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA1NCBTYWx0ZWRfXx6hmU7wYt3q0
 XAyHyWrAA3+IHVmJQXoOBt/CN0jWkBcpQLZloo0Rk0rMhSRx4fEzB+Q9ZWYJLT2qecRnOx4fcsT
 hHABVINcLDLBolmY5gIHZp51HgHIuZ4=
X-Proofpoint-ORIG-GUID: papbCozmV9k0yQOXxH-rKHaPEFxXlhDj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA1NCBTYWx0ZWRfXyW45bG6K8Kk/
 0+HrojvKhi8VK8uusWkQkTqNpKiabQnTCFWSphTUnaEdXZay5wQLJpavoxzhNwBVXIcNrekedIf
 knZo+0Pygwh7LBAvQKZ5U00QQ6nn1gzkFVAfYgCXKG6EtKaRDOk5K3zgYGxJaxyc5wquWoXI21z
 eF5i4Mlf9Rl0rIWzO02ySQTmwjwUUFfnYzOyzvN06JSWWn5J42zsVmfCxtQbtZPOopzdX1GjnxE
 pCaYJ9YvXT8r2K1I0TnXbwp4Rrlpbh5yLPqerafQNUgf/Vu1bnRYyRfwp3RWVOuOzRxq6OWf4n0
 j70KXeH7cgpK6eOHMwuifp7lynr8UgkvxV8nUmHf7fE4eyEsZXPyRIF1Vgn/42ySI3Kecn7RdPL
 Rcot5c6Jju8fLoXkvYxSssgU/j1A/jjLptsw6K2+IpXQ9cQxlHqjOr0G896UCYVniDuSkyL0xNy
 HzQVlXPgqzVoCaLzgMQ==
X-Authority-Analysis: v=2.4 cv=G7uJgNk5 c=1 sm=1 tr=0 ts=6adf5d57 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=EhjxLoTV9ItuFGM4bXUA:9
X-Proofpoint-GUID: papbCozmV9k0yQOXxH-rKHaPEFxXlhDj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260054
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Collin Walling <walling@linux.ibm.com>

Move the feature dependency array (dep[][2]) from cpu_models.c to
cpu_features.c, rename the array to s390_feat_deps, and externalize
its length.

This will allow the array to be used between both files.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20261009185559.144750-2-walling@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 target/s390x/cpu_features.c | 126 ++++++++++++++++++++++++++++++++++
 target/s390x/cpu_features.h |   4 ++
 target/s390x/cpu_models.c   | 133 ++----------------------------------
 3 files changed, 135 insertions(+), 128 deletions(-)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index c634e74123..20f9947c7b 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -223,6 +223,132 @@ void s390_feat_bitmap_to_ascii(const S390FeatBitmap features, void *opaque,
     };
 }
 
+const int s390_feat_deps[][2] = {
+    { S390_FEAT_IPTE_RANGE, S390_FEAT_DAT_ENH },
+    { S390_FEAT_IDTE_SEGMENT, S390_FEAT_DAT_ENH },
+    { S390_FEAT_IDTE_REGION, S390_FEAT_DAT_ENH },
+    { S390_FEAT_IDTE_REGION, S390_FEAT_IDTE_SEGMENT },
+    { S390_FEAT_LOCAL_TLB_CLEARING, S390_FEAT_DAT_ENH},
+    { S390_FEAT_LONG_DISPLACEMENT_FAST, S390_FEAT_LONG_DISPLACEMENT },
+    { S390_FEAT_DFP_FAST, S390_FEAT_DFP },
+    { S390_FEAT_TRANSACTIONAL_EXE, S390_FEAT_STFLE_49 },
+    { S390_FEAT_EDAT_2, S390_FEAT_EDAT},
+    { S390_FEAT_MSA_EXT_5, S390_FEAT_KIMD_SHA_512 },
+    { S390_FEAT_MSA_EXT_5, S390_FEAT_KLMD_SHA_512 },
+    { S390_FEAT_MSA_EXT_4, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_SIE_CMMA, S390_FEAT_CMM },
+    { S390_FEAT_SIE_CMMA, S390_FEAT_SIE_GSLS },
+    { S390_FEAT_SIE_PFMFI, S390_FEAT_EDAT },
+    { S390_FEAT_MSA_EXT_8, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_MSA_EXT_9, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_MSA_EXT_9, S390_FEAT_MSA_EXT_4 },
+    { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_TOD_CLOCK_STEERING },
+    { S390_FEAT_VECTOR_PACKED_DECIMAL, S390_FEAT_VECTOR },
+    { S390_FEAT_VECTOR_PACKED_DECIMAL_ENH, S390_FEAT_VECTOR_PACKED_DECIMAL },
+    { S390_FEAT_VECTOR_PACKED_DECIMAL_ENH2, S390_FEAT_VECTOR_PACKED_DECIMAL_ENH },
+    { S390_FEAT_VECTOR_PACKED_DECIMAL_ENH3, S390_FEAT_VECTOR_PACKED_DECIMAL_ENH2 },
+    { S390_FEAT_VECTOR_ENH, S390_FEAT_VECTOR },
+    { S390_FEAT_VECTOR_ENH2, S390_FEAT_VECTOR_ENH },
+    { S390_FEAT_VECTOR_ENH3, S390_FEAT_VECTOR_ENH2 },
+    { S390_FEAT_INSTRUCTION_EXEC_PROT, S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2 },
+    { S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2, S390_FEAT_ESOP },
+    { S390_FEAT_CMM_NT, S390_FEAT_CMM },
+    { S390_FEAT_GUARDED_STORAGE, S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2 },
+    { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_STORE_CLOCK_FAST },
+    { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_TOD_CLOCK_STEERING },
+    { S390_FEAT_SEMAPHORE_ASSIST, S390_FEAT_STFLE_49 },
+    { S390_FEAT_KIMD_SHA3_224, S390_FEAT_MSA },
+    { S390_FEAT_KIMD_SHA3_256, S390_FEAT_MSA },
+    { S390_FEAT_KIMD_SHA3_384, S390_FEAT_MSA },
+    { S390_FEAT_KIMD_SHA3_512, S390_FEAT_MSA },
+    { S390_FEAT_KIMD_SHAKE_128, S390_FEAT_MSA },
+    { S390_FEAT_KIMD_SHAKE_256, S390_FEAT_MSA },
+    { S390_FEAT_KLMD_SHA3_224, S390_FEAT_MSA },
+    { S390_FEAT_KLMD_SHA3_256, S390_FEAT_MSA },
+    { S390_FEAT_KLMD_SHA3_384, S390_FEAT_MSA },
+    { S390_FEAT_KLMD_SHA3_512, S390_FEAT_MSA },
+    { S390_FEAT_KLMD_SHAKE_128, S390_FEAT_MSA },
+    { S390_FEAT_KLMD_SHAKE_256, S390_FEAT_MSA },
+    { S390_FEAT_KMAC_HMAC_SHA_224, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_KMAC_HMAC_SHA_256, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_KMAC_HMAC_SHA_384, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_KMAC_HMAC_SHA_512, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_KMAC_HMAC_ESHA_224, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_KMAC_HMAC_ESHA_256, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_KMAC_HMAC_ESHA_384, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_KMAC_HMAC_ESHA_512, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_KM_FULL_XTS_AES_128, S390_FEAT_MSA_EXT_4 },
+    { S390_FEAT_KM_FULL_XTS_AES_256, S390_FEAT_MSA_EXT_4 },
+    { S390_FEAT_KM_FULL_XTS_EAES_128, S390_FEAT_MSA_EXT_4 },
+    { S390_FEAT_KM_FULL_XTS_EAES_256, S390_FEAT_MSA_EXT_4 },
+    { S390_FEAT_PRNO_TRNG_QRTCR, S390_FEAT_MSA_EXT_5 },
+    { S390_FEAT_PRNO_TRNG, S390_FEAT_MSA_EXT_5 },
+    { S390_FEAT_SIE_KSS, S390_FEAT_SIE_F2 },
+    { S390_FEAT_AP_QUERY_CONFIG_INFO, S390_FEAT_AP },
+    { S390_FEAT_AP_FACILITIES_TEST, S390_FEAT_AP },
+    { S390_FEAT_PTFF_QSIE, S390_FEAT_MULTIPLE_EPOCH },
+    { S390_FEAT_PTFF_QTOUE, S390_FEAT_MULTIPLE_EPOCH },
+    { S390_FEAT_PTFF_STOE, S390_FEAT_MULTIPLE_EPOCH },
+    { S390_FEAT_PTFF_STOUE, S390_FEAT_MULTIPLE_EPOCH },
+    { S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, S390_FEAT_AP },
+    { S390_FEAT_DIAG_318, S390_FEAT_EXTENDED_LENGTH_SCCB },
+    { S390_FEAT_CERT_STORE, S390_FEAT_EXTENDED_LENGTH_SCCB },
+    { S390_FEAT_SIPL, S390_FEAT_EXTENDED_LENGTH_SCCB },
+    { S390_FEAT_SCLAF, S390_FEAT_EXTENDED_LENGTH_SCCB },
+    { S390_FEAT_SCLAF, S390_FEAT_SIPL },
+    { S390_FEAT_NNPA, S390_FEAT_VECTOR },
+    { S390_FEAT_RDP, S390_FEAT_LOCAL_TLB_CLEARING },
+    { S390_FEAT_UV_FEAT_AP, S390_FEAT_AP },
+    { S390_FEAT_UV_FEAT_AP_INTR, S390_FEAT_UV_FEAT_AP },
+    { S390_FEAT_PFCR_QAF, S390_FEAT_CCF_BASE },
+    { S390_FEAT_PFCR_CSDST, S390_FEAT_CCF_BASE },
+    { S390_FEAT_PFCR_CSDSTG, S390_FEAT_CCF_BASE },
+    { S390_FEAT_PFCR_CSTST, S390_FEAT_CCF_BASE },
+    { S390_FEAT_PFCR_CSTSTG, S390_FEAT_CCF_BASE },
+    { S390_FEAT_INEFF_NC_TX, S390_FEAT_TRANSACTIONAL_EXE },
+    { S390_FEAT_PLO_CLO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_CSO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_DCSO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_CSSTO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_CSDSTO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_CSTSTO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TCS, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TCSG, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TCSX, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TCSO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QCS, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QCSG, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QCSX, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QCSO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_LO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_DLX, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_DLO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TL, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TLG, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TLX, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TLO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QL, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QLG, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QLX, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QLO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_STO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_DST, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_DSTG, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_DSTX, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_DSTO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TST, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TSTG, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TSTX, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TSTO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QST, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QSTG, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QSTX, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QSTO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_SIE_ASTFLEIE2, S390_FEAT_STFLE },
+};
+
+const size_t s390_feat_deps_len = ARRAY_SIZE(s390_feat_deps);
+
 void s390_get_deprecated_features(S390FeatBitmap features)
 {
     static const int feats[] = {
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index 421978faa4..8097b21959 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -57,6 +57,10 @@ typedef struct {
     int bit;                /* bit within the feature type area (fixed) */
 } S390FeatDef;
 
+/* Tuple of features[][0] that depend on other features[][1] */
+extern const int s390_feat_deps[][2];
+extern const size_t s390_feat_deps_len;
+
 /* use ordinary bitmap operations to work with features */
 typedef unsigned long S390FeatBitmap[BITS_TO_LONGS(S390_FEAT_MAX)];
 
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index c41d629d68..c30ea2df17 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -440,137 +440,14 @@ void s390_cpu_list(void)
 
 static void check_consistency(const S390CPUModel *model)
 {
-    static int dep[][2] = {
-        { S390_FEAT_IPTE_RANGE, S390_FEAT_DAT_ENH },
-        { S390_FEAT_IDTE_SEGMENT, S390_FEAT_DAT_ENH },
-        { S390_FEAT_IDTE_REGION, S390_FEAT_DAT_ENH },
-        { S390_FEAT_IDTE_REGION, S390_FEAT_IDTE_SEGMENT },
-        { S390_FEAT_LOCAL_TLB_CLEARING, S390_FEAT_DAT_ENH},
-        { S390_FEAT_LONG_DISPLACEMENT_FAST, S390_FEAT_LONG_DISPLACEMENT },
-        { S390_FEAT_DFP_FAST, S390_FEAT_DFP },
-        { S390_FEAT_TRANSACTIONAL_EXE, S390_FEAT_STFLE_49 },
-        { S390_FEAT_EDAT_2, S390_FEAT_EDAT},
-        { S390_FEAT_MSA_EXT_5, S390_FEAT_KIMD_SHA_512 },
-        { S390_FEAT_MSA_EXT_5, S390_FEAT_KLMD_SHA_512 },
-        { S390_FEAT_MSA_EXT_4, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_SIE_CMMA, S390_FEAT_CMM },
-        { S390_FEAT_SIE_CMMA, S390_FEAT_SIE_GSLS },
-        { S390_FEAT_SIE_PFMFI, S390_FEAT_EDAT },
-        { S390_FEAT_MSA_EXT_8, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_MSA_EXT_9, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_MSA_EXT_9, S390_FEAT_MSA_EXT_4 },
-        { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_TOD_CLOCK_STEERING },
-        { S390_FEAT_VECTOR_PACKED_DECIMAL, S390_FEAT_VECTOR },
-        { S390_FEAT_VECTOR_PACKED_DECIMAL_ENH, S390_FEAT_VECTOR_PACKED_DECIMAL },
-        { S390_FEAT_VECTOR_PACKED_DECIMAL_ENH2, S390_FEAT_VECTOR_PACKED_DECIMAL_ENH },
-        { S390_FEAT_VECTOR_PACKED_DECIMAL_ENH3, S390_FEAT_VECTOR_PACKED_DECIMAL_ENH2 },
-        { S390_FEAT_VECTOR_ENH, S390_FEAT_VECTOR },
-        { S390_FEAT_VECTOR_ENH2, S390_FEAT_VECTOR_ENH },
-        { S390_FEAT_VECTOR_ENH3, S390_FEAT_VECTOR_ENH2 },
-        { S390_FEAT_INSTRUCTION_EXEC_PROT, S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2 },
-        { S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2, S390_FEAT_ESOP },
-        { S390_FEAT_CMM_NT, S390_FEAT_CMM },
-        { S390_FEAT_GUARDED_STORAGE, S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2 },
-        { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_STORE_CLOCK_FAST },
-        { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_TOD_CLOCK_STEERING },
-        { S390_FEAT_SEMAPHORE_ASSIST, S390_FEAT_STFLE_49 },
-        { S390_FEAT_KIMD_SHA3_224, S390_FEAT_MSA },
-        { S390_FEAT_KIMD_SHA3_256, S390_FEAT_MSA },
-        { S390_FEAT_KIMD_SHA3_384, S390_FEAT_MSA },
-        { S390_FEAT_KIMD_SHA3_512, S390_FEAT_MSA },
-        { S390_FEAT_KIMD_SHAKE_128, S390_FEAT_MSA },
-        { S390_FEAT_KIMD_SHAKE_256, S390_FEAT_MSA },
-        { S390_FEAT_KLMD_SHA3_224, S390_FEAT_MSA },
-        { S390_FEAT_KLMD_SHA3_256, S390_FEAT_MSA },
-        { S390_FEAT_KLMD_SHA3_384, S390_FEAT_MSA },
-        { S390_FEAT_KLMD_SHA3_512, S390_FEAT_MSA },
-        { S390_FEAT_KLMD_SHAKE_128, S390_FEAT_MSA },
-        { S390_FEAT_KLMD_SHAKE_256, S390_FEAT_MSA },
-        { S390_FEAT_KMAC_HMAC_SHA_224, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_KMAC_HMAC_SHA_256, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_KMAC_HMAC_SHA_384, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_KMAC_HMAC_SHA_512, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_KMAC_HMAC_ESHA_224, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_KMAC_HMAC_ESHA_256, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_KMAC_HMAC_ESHA_384, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_KMAC_HMAC_ESHA_512, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_KM_FULL_XTS_AES_128, S390_FEAT_MSA_EXT_4 },
-        { S390_FEAT_KM_FULL_XTS_AES_256, S390_FEAT_MSA_EXT_4 },
-        { S390_FEAT_KM_FULL_XTS_EAES_128, S390_FEAT_MSA_EXT_4 },
-        { S390_FEAT_KM_FULL_XTS_EAES_256, S390_FEAT_MSA_EXT_4 },
-        { S390_FEAT_PRNO_TRNG_QRTCR, S390_FEAT_MSA_EXT_5 },
-        { S390_FEAT_PRNO_TRNG, S390_FEAT_MSA_EXT_5 },
-        { S390_FEAT_SIE_KSS, S390_FEAT_SIE_F2 },
-        { S390_FEAT_AP_QUERY_CONFIG_INFO, S390_FEAT_AP },
-        { S390_FEAT_AP_FACILITIES_TEST, S390_FEAT_AP },
-        { S390_FEAT_PTFF_QSIE, S390_FEAT_MULTIPLE_EPOCH },
-        { S390_FEAT_PTFF_QTOUE, S390_FEAT_MULTIPLE_EPOCH },
-        { S390_FEAT_PTFF_STOE, S390_FEAT_MULTIPLE_EPOCH },
-        { S390_FEAT_PTFF_STOUE, S390_FEAT_MULTIPLE_EPOCH },
-        { S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, S390_FEAT_AP },
-        { S390_FEAT_DIAG_318, S390_FEAT_EXTENDED_LENGTH_SCCB },
-        { S390_FEAT_CERT_STORE, S390_FEAT_EXTENDED_LENGTH_SCCB },
-        { S390_FEAT_SIPL, S390_FEAT_EXTENDED_LENGTH_SCCB },
-        { S390_FEAT_SCLAF, S390_FEAT_EXTENDED_LENGTH_SCCB },
-        { S390_FEAT_SCLAF, S390_FEAT_SIPL },
-        { S390_FEAT_NNPA, S390_FEAT_VECTOR },
-        { S390_FEAT_RDP, S390_FEAT_LOCAL_TLB_CLEARING },
-        { S390_FEAT_UV_FEAT_AP, S390_FEAT_AP },
-        { S390_FEAT_UV_FEAT_AP_INTR, S390_FEAT_UV_FEAT_AP },
-        { S390_FEAT_PFCR_QAF, S390_FEAT_CCF_BASE },
-        { S390_FEAT_PFCR_CSDST, S390_FEAT_CCF_BASE },
-        { S390_FEAT_PFCR_CSDSTG, S390_FEAT_CCF_BASE },
-        { S390_FEAT_PFCR_CSTST, S390_FEAT_CCF_BASE },
-        { S390_FEAT_PFCR_CSTSTG, S390_FEAT_CCF_BASE },
-        { S390_FEAT_INEFF_NC_TX, S390_FEAT_TRANSACTIONAL_EXE },
-        { S390_FEAT_PLO_CLO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_CSO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_DCSO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_CSSTO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_CSDSTO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_CSTSTO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TCS, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TCSG, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TCSX, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TCSO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QCS, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QCSG, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QCSX, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QCSO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_LO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_DLX, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_DLO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TL, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TLG, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TLX, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TLO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QL, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QLG, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QLX, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QLO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_STO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_DST, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_DSTG, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_DSTX, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_DSTO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TST, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TSTG, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TSTX, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TSTO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QST, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QSTG, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QSTX, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QSTO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_SIE_ASTFLEIE2, S390_FEAT_STFLE },
-    };
     int i;
 
-    for (i = 0; i < ARRAY_SIZE(dep); i++) {
-        if (test_bit(dep[i][0], model->features) &&
-            !test_bit(dep[i][1], model->features)) {
+    for (i = 0; i < s390_feat_deps_len; i++) {
+        if (test_bit(s390_feat_deps[i][0], model->features) &&
+            !test_bit(s390_feat_deps[i][1], model->features)) {
             warn_report("\'%s\' requires \'%s\'.",
-                        s390_feat_def(dep[i][0])->name,
-                        s390_feat_def(dep[i][1])->name);
+                        s390_feat_def(s390_feat_deps[i][0])->name,
+                        s390_feat_def(s390_feat_deps[i][1])->name);
         }
     }
 }
-- 
2.56.0


