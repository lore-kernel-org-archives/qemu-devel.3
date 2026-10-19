Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793D2609B647
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Tsqcc1Ap
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIp2o-0006lF-Mt; Mon, 19 Oct 2026 11:12:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xIp2c-0006hK-DZ; Mon, 19 Oct 2026 11:12:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xIp2a-0002Vp-3b; Mon, 19 Oct 2026 11:12:46 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JEELSQ3929247; Mon, 19 Oct 2026 15:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=DYzmQDhUoyKSu1obL
 33pF9GdGU8GSCbrPdlc2iugXMM=; b=Tsqcc1ApzZcN5qdz7RZhCtta9D+E2wzXs
 27t/bk1FEViQ974gpzKLrHWc+8388X+gynBnBiHag07UGEn2I1y4j/X4L8B5emF3
 mLuZNCNST+O1r2CPENrGpEnYx7SFbZnLxYj1X4vUc0L9zDHqSCVJkLb7HyrcxdzS
 bAv3bozLa1Wk5VDtGe3S+brCr/IjNxEWmOGyyRVsuxhsgbKr1nhohifj7001H9+6
 jFqufwsKPJaUaz09sED3W3K6R1kDbmmPQ+iEmV/ai3f1EoznFqO2jlWnkl8QN6AE
 MRh73Wfxem/+J49q4AoXbDZY4IMLg3mXi3sySY3bCR+1pichiu0ng==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hbxehug9f-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 15:12:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JE4vKp020682; Mon, 19 Oct 2026 15:12:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hckbq6cmn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 15:12:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69JFCZDs37880206
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Oct 2026 15:12:35 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E4742004E;
 Mon, 19 Oct 2026 15:12:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F49D2004D;
 Mon, 19 Oct 2026 15:12:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon, 19 Oct 2026 15:12:35 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 0572F1612ED; Mon, 19 Oct 2026 17:12:35 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v1 4/4] tests/tcg/ppc64: Add float_convs test
Date: Mon, 19 Oct 2026 17:12:31 +0200
Message-ID: <20261019151233.230172-5-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019151233.230172-1-farman@linux.ibm.com>
References: <20261019151233.230172-1-farman@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1OCBTYWx0ZWRfX5Pvxg545rKxb
 GwS8RMYbH45KQcnGDIcZt9qsWJ6/Trhrvtct4noYhijUuFsD23lD194Grve15TorzDhG4+eKrUh
 UQAl/x48t8nK71MK1N/TVuccl3Rw0UQESL2a+WdgDOWZeSA7NvYm6O30lf6Y0nStY697JeB2dUm
 BvX7QsB1HIw9p8UeD1R9J+nsJ8ugO5Hk3/00eMxtLGzWLNDQSe18YJiH2m1oMcU4oKFE/m5BgqP
 ht+R8Pk1AvaqpUZrCrSTJI8SduIeNQkMq7Z4bELd7MHOg6CyhSklvpAQqn56giGpL6QwXOZb0pO
 g0MNYOzhw/ppMjXntZIrfQMHvBRaNNX6aHbTEEhQdr6BF2CM0dAzBi0WFgd5kxeRY6S28pdNnl4
 p4e2VE+ZBb33mop2QgniAwUiv8xgESKCcFkvNPiongAHx50oIEt9Af7FXbJA1ESFXGlKyc87FsF
 9iu+Z+RiIqijLVorIZA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1OCBTYWx0ZWRfX6pM/2VM22XbF
 ChqwQpexXsfsp/3d55DJC3K5m/xtn5Kl1AhaqfHStVBJMnM3zDm1+pUUxJACVqYpn+FL7SRsvpM
 yHFawePnvWPttO71Dd97IrXn/IQVef8=
X-Proofpoint-GUID: -S8TScHaw7d1pcSr3Fp_K7ZEj9RTdtPo
X-Proofpoint-ORIG-GUID: Z3KcUcLtBamUZTtNvaPnGJ_YIvjG4jkI
X-Authority-Analysis: v=2.4 cv=OZQNnRTY c=1 sm=1 tr=0 ts=6ad63368 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=EyJSuCcodugoBwrUV90A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190058
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
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

Pass "power8" as a compiler flag, and update the reference file
with the new output.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 tests/tcg/ppc64/float_convs.ref | 80 ++++++++++++++++-----------------
 tests/tcg/ppc64/meson.build     |  4 ++
 2 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/tests/tcg/ppc64/float_convs.ref b/tests/tcg/ppc64/float_conv=
s.ref
index bd7b14d37e3..6e6f6368344 100644
--- a/tests/tcg/ppc64/float_convs.ref
+++ b/tests/tcg/ppc64/float_convs.ref
@@ -4,37 +4,37 @@ from single: f32(-nan:0xffa00000)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-nan:0xffc00000)
   to double: f64(-nan:0x00fff8000000000000) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-inf:0xff800000)
   to double: f64(-inf:0x00fff0000000000000) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff)
   to double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000) (O=
K)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-0x1.1874b200000000000000p+103:0xf30c3a59)
   to double: f64(-0x1.1874b200000000000000p+103:0x00c661874b20000000) (O=
K)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-0x1.c0bab600000000000000p+99:0xf1605d5b)
   to double: f64(-0x1.c0bab600000000000000p+99:0x00c62c0bab60000000) (OK=
)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-0x1.31f75000000000000000p-40:0xab98fba8)
   to double: f64(-0x1.31f75000000000000000p-40:0x00bd731f7500000000) (OK=
)
    to int32: 0 (INEXACT )
@@ -160,13 +160,13 @@ from single: f32(0x1.c0bab600000000000000p+99:0x716=
05d5b)
    to int32: 2147483647 (INVALID)
    to int64: 9223372036854775807 (INVALID)
   to uint32: -1 (INVALID)
-  to uint64: -1 (INEXACT INVALID)
+  to uint64: -1 (INVALID)
 from single: f32(0x1.fffffe00000000000000p+127:0x7f7fffff)
   to double: f64(0x1.fffffe00000000000000p+127:0x0047efffffe0000000) (OK=
)
    to int32: 2147483647 (INVALID)
    to int64: 9223372036854775807 (INVALID)
   to uint32: -1 (INVALID)
-  to uint64: -1 (INEXACT INVALID)
+  to uint64: -1 (INVALID)
 from single: f32(inf:0x7f800000)
   to double: f64(inf:0x007ff0000000000000) (OK)
    to int32: 2147483647 (INVALID)
@@ -178,50 +178,50 @@ from single: f32(nan:0x7fc00000)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(nan:0x7fa00000)
   to double: f64(nan:0x007ff4000000000000) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 ### Rounding upwards
 from single: f32(-nan:0xffa00000)
   to double: f64(-nan:0x00fff4000000000000) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-nan:0xffc00000)
   to double: f64(-nan:0x00fff8000000000000) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-inf:0xff800000)
   to double: f64(-inf:0x00fff0000000000000) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff)
   to double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000) (O=
K)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-0x1.1874b200000000000000p+103:0xf30c3a59)
   to double: f64(-0x1.1874b200000000000000p+103:0x00c661874b20000000) (O=
K)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-0x1.c0bab600000000000000p+99:0xf1605d5b)
   to double: f64(-0x1.c0bab600000000000000p+99:0x00c62c0bab60000000) (OK=
)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-0x1.31f75000000000000000p-40:0xab98fba8)
   to double: f64(-0x1.31f75000000000000000p-40:0x00bd731f7500000000) (OK=
)
    to int32: 0 (INEXACT )
@@ -347,13 +347,13 @@ from single: f32(0x1.c0bab600000000000000p+99:0x716=
05d5b)
    to int32: 2147483647 (INVALID)
    to int64: 9223372036854775807 (INVALID)
   to uint32: -1 (INVALID)
-  to uint64: -1 (INEXACT INVALID)
+  to uint64: -1 (INVALID)
 from single: f32(0x1.fffffe00000000000000p+127:0x7f7fffff)
   to double: f64(0x1.fffffe00000000000000p+127:0x0047efffffe0000000) (OK=
)
    to int32: 2147483647 (INVALID)
    to int64: 9223372036854775807 (INVALID)
   to uint32: -1 (INVALID)
-  to uint64: -1 (INEXACT INVALID)
+  to uint64: -1 (INVALID)
 from single: f32(inf:0x7f800000)
   to double: f64(inf:0x007ff0000000000000) (OK)
    to int32: 2147483647 (INVALID)
@@ -365,50 +365,50 @@ from single: f32(nan:0x7fc00000)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(nan:0x7fa00000)
   to double: f64(nan:0x007ff4000000000000) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 ### Rounding downwards
 from single: f32(-nan:0xffa00000)
   to double: f64(-nan:0x00fff4000000000000) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-nan:0xffc00000)
   to double: f64(-nan:0x00fff8000000000000) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-inf:0xff800000)
   to double: f64(-inf:0x00fff0000000000000) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff)
   to double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000) (O=
K)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-0x1.1874b200000000000000p+103:0xf30c3a59)
   to double: f64(-0x1.1874b200000000000000p+103:0x00c661874b20000000) (O=
K)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-0x1.c0bab600000000000000p+99:0xf1605d5b)
   to double: f64(-0x1.c0bab600000000000000p+99:0x00c62c0bab60000000) (OK=
)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-0x1.31f75000000000000000p-40:0xab98fba8)
   to double: f64(-0x1.31f75000000000000000p-40:0x00bd731f7500000000) (OK=
)
    to int32: 0 (INEXACT )
@@ -534,13 +534,13 @@ from single: f32(0x1.c0bab600000000000000p+99:0x716=
05d5b)
    to int32: 2147483647 (INVALID)
    to int64: 9223372036854775807 (INVALID)
   to uint32: -1 (INVALID)
-  to uint64: -1 (INEXACT INVALID)
+  to uint64: -1 (INVALID)
 from single: f32(0x1.fffffe00000000000000p+127:0x7f7fffff)
   to double: f64(0x1.fffffe00000000000000p+127:0x0047efffffe0000000) (OK=
)
    to int32: 2147483647 (INVALID)
    to int64: 9223372036854775807 (INVALID)
   to uint32: -1 (INVALID)
-  to uint64: -1 (INEXACT INVALID)
+  to uint64: -1 (INVALID)
 from single: f32(inf:0x7f800000)
   to double: f64(inf:0x007ff0000000000000) (OK)
    to int32: 2147483647 (INVALID)
@@ -552,50 +552,50 @@ from single: f32(nan:0x7fc00000)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(nan:0x7fa00000)
   to double: f64(nan:0x007ff4000000000000) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 ### Rounding to zero
 from single: f32(-nan:0xffa00000)
   to double: f64(-nan:0x00fff4000000000000) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-nan:0xffc00000)
   to double: f64(-nan:0x00fff8000000000000) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-inf:0xff800000)
   to double: f64(-inf:0x00fff0000000000000) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff)
   to double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000) (O=
K)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-0x1.1874b200000000000000p+103:0xf30c3a59)
   to double: f64(-0x1.1874b200000000000000p+103:0x00c661874b20000000) (O=
K)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-0x1.c0bab600000000000000p+99:0xf1605d5b)
   to double: f64(-0x1.c0bab600000000000000p+99:0x00c62c0bab60000000) (OK=
)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(-0x1.31f75000000000000000p-40:0xab98fba8)
   to double: f64(-0x1.31f75000000000000000p-40:0x00bd731f7500000000) (OK=
)
    to int32: 0 (INEXACT )
@@ -721,13 +721,13 @@ from single: f32(0x1.c0bab600000000000000p+99:0x716=
05d5b)
    to int32: 2147483647 (INVALID)
    to int64: 9223372036854775807 (INVALID)
   to uint32: -1 (INVALID)
-  to uint64: -1 (INEXACT INVALID)
+  to uint64: -1 (INVALID)
 from single: f32(0x1.fffffe00000000000000p+127:0x7f7fffff)
   to double: f64(0x1.fffffe00000000000000p+127:0x0047efffffe0000000) (OK=
)
    to int32: 2147483647 (INVALID)
    to int64: 9223372036854775807 (INVALID)
   to uint32: -1 (INVALID)
-  to uint64: -1 (INEXACT INVALID)
+  to uint64: -1 (INVALID)
 from single: f32(inf:0x7f800000)
   to double: f64(inf:0x007ff0000000000000) (OK)
    to int32: 2147483647 (INVALID)
@@ -739,10 +739,10 @@ from single: f32(nan:0x7fc00000)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from single: f32(nan:0x7fa00000)
   to double: f64(nan:0x007ff4000000000000) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
diff --git a/tests/tcg/ppc64/meson.build b/tests/tcg/ppc64/meson.build
index ed8403eb67e..8fe9094b44f 100644
--- a/tests/tcg/ppc64/meson.build
+++ b/tests/tcg/ppc64/meson.build
@@ -40,6 +40,10 @@ tests +=3D {
   '../multiarch/float_convd.c': {
     'cflags': float_cflags + ['-mcpu=3Dpower8'],
     'expected_output': 'float_convd.ref',
+  },
+  '../multiarch/float_convs.c': {
+    'cflags': float_cflags + ['-mcpu=3Dpower8'],
+    'expected_output': 'float_convs.ref',
   }
 }
=20
--=20
2.53.0


