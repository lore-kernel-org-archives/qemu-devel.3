Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EC4609B654
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=KiyUSPxI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIp2k-0006jf-TX; Mon, 19 Oct 2026 11:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xIp2d-0006hL-06; Mon, 19 Oct 2026 11:12:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xIp2a-0002Vq-2M; Mon, 19 Oct 2026 11:12:46 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JEEDLh4023842; Mon, 19 Oct 2026 15:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=5NGpZ171MzmokYmlm
 73DtNK+C2tRC0lKJT3Zdpj/tXA=; b=KiyUSPxIsc04IZgcQw9Rw+pVkfZSTyJ53
 chiZz0cB6QcgDncyOp12uSvF+9l6wzFnAhOk218Qc5v8nNR2yI1bWtTF8OJ8Uwrn
 kc7/8yY+YpUv4RhhF4PUW43bNOYjW9OBsPPEaJBe31XIBiOooJ2aqYw53t3oFZ0X
 C6SDpupWq7hOJ9MznfPN9EArxDHvwZ70fLq+O5+C4e8Mr4fNtQmD9Fiq8rpAl/Bq
 z9XsdANaCB33CQiQUHGw5Nc84h7wqF1JExeu61dCInp7PoCC7qf/9DJYlt0/HjDZ
 8TNU+n5r/wFRrvw7vEqpqV7+IPBfGnNBp1NNyr62o+ptaXdrKervw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0nvu2jf-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 15:12:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JE4ur9067453; Mon, 19 Oct 2026 15:12:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hcmugx57b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 15:12:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69JFCZgV34275780
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Oct 2026 15:12:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B00420049;
 Mon, 19 Oct 2026 15:12:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B9432004D;
 Mon, 19 Oct 2026 15:12:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon, 19 Oct 2026 15:12:35 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 0305E160EFC; Mon, 19 Oct 2026 17:12:35 +0200 (CEST)
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
Subject: [PATCH v1 3/4] tests/tcg/ppc64: Add float_convd test
Date: Mon, 19 Oct 2026 17:12:30 +0200
Message-ID: <20261019151233.230172-4-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019151233.230172-1-farman@linux.ibm.com>
References: <20261019151233.230172-1-farman@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1OCBTYWx0ZWRfX57Q89IvvUcAl
 BG+3Nyt/68TVuow0ofPkIG/ahnyOexp3xPodambU8ohtNyvkHE57XaWzIJk1QLK8/rW7Ego4Wdr
 QbtfkEX2t+yZunL8xh05re1aEQpvGM4=
X-Proofpoint-ORIG-GUID: -R1mzTaBfjf_aFcKuRZDIEptbu9L9FDE
X-Proofpoint-GUID: 9Ra5OLWDv7lNR6LIiILE_se0J5P0JG54
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1OCBTYWx0ZWRfXwOkx98L779bk
 eFgvyfZPnIcYxkGkBn16H1Rx5H71+o3mvjmo8zewt3Q7nt7qP0eyw8mBo03ivp2YTzT3QLNxWPS
 THTaWUMdBI9bFHUtjuNGeX76vkzUsRhLfSJLpb5ncxn0qpES+Zc1/Cz2FqKnGmoDhrXMTBsCNDs
 AgLWSwu119xUysZsIDs47VKGINswdjbYfpE7L3aQygOIxtGSDYrn90/EHwQAbhvoPsmLS/NlbM3
 slah5nAMtCEzPfTO7DiOJ8ljmznKzutddtj4dOAj6BC+OPa0L7OGmnkrGzIzaxnynSPfO1Yghtz
 N04sf5TyxU3JnaOLKylYcYHlVMfl+k/Dqoc2Q53lzBA1QLVK6h2NL0hS47cnmC7LxeYjFe233Sh
 EXZ7hjESQm8HyKhS6Zh2OSkbtye4IGH1PImteAKcnFCvGemd0Jfqm/rMXs/ET0o4NrKgwS0lZVM
 HduJg+NoevLr5P8u8sw==
X-Authority-Analysis: v=2.4 cv=MY35KJ/f c=1 sm=1 tr=0 ts=6ad63368 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=5OYcETvGXmoIBJ-MenUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0
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

Re-enable the float_convd test, passing "power8" directly
as a compiler flag to ensure a consistent result. Update the
reference output to match the newly expected output.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 tests/tcg/ppc64/float_convd.ref | 144 ++++++++++++++++----------------
 tests/tcg/ppc64/meson.build     |   4 +
 2 files changed, 76 insertions(+), 72 deletions(-)

diff --git a/tests/tcg/ppc64/float_convd.ref b/tests/tcg/ppc64/float_conv=
d.ref
index 43aa3117f14..2995a767c04 100644
--- a/tests/tcg/ppc64/float_convd.ref
+++ b/tests/tcg/ppc64/float_convd.ref
@@ -4,61 +4,61 @@ from double: f64(nan:0x007ff4000000000000)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-nan:0x00fff8000000000000)
   to single: f32(-nan:0xffc00000) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-inf:0x00fff0000000000000)
   to single: f32(-inf:0xff800000) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.fffffffffffff0000000p+1023:0x00ffefffffffffffff)
   to single: f32(-inf:0xff800000) (OVERFLOW INEXACT )
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000)
   to single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000)
   to single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.1874b135ff6540000000p+103:0x00c661874b135ff654)
   to single: f32(-0x1.1874b200000000000000p+103:0xf30c3a59) (INEXACT )
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.c0bab523323b90000000p+99:0x00c62c0bab523323b9)
   to single: f32(-0x1.c0bab600000000000000p+99:0xf1605d5b) (INEXACT )
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.00000000000000000000p+1:0x00c000000000000000)
   to single: f32(-0x1.00000000000000000000p+1:0xc0000000) (OK)
    to int32: -2 (OK)
    to int64: -2 (OK)
-  to uint32: -2 (OK)
-  to uint64: -2 (OK)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.00000000000000000000p+0:0x00bff0000000000000)
   to single: f32(-0x1.00000000000000000000p+0:0xbf800000) (OK)
    to int32: -1 (OK)
    to int64: -1 (OK)
-  to uint32: -1 (OK)
-  to uint64: -1 (OK)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.00000000000000000000p-1022:0x008010000000000000)
   to single: f32(-0x0.00000000000000000000p+0:0x80000000) (UNDERFLOW INE=
XACT )
    to int32: 0 (INEXACT )
@@ -208,19 +208,19 @@ from double: f64(0x1.fffffe00000000000000p+127:0x00=
47efffffe0000000)
    to int32: 2147483647 (INVALID)
    to int64: 9223372036854775807 (INVALID)
   to uint32: -1 (INVALID)
-  to uint64: -1 (INEXACT INVALID)
+  to uint64: -1 (INVALID)
 from double: f64(0x1.fffffe00000000000000p+127:0x0047efffffe0000000)
   to single: f32(0x1.fffffe00000000000000p+127:0x7f7fffff) (OK)
    to int32: 2147483647 (INVALID)
    to int64: 9223372036854775807 (INVALID)
   to uint32: -1 (INVALID)
-  to uint64: -1 (INEXACT INVALID)
+  to uint64: -1 (INVALID)
 from double: f64(0x1.fffffffffffff0000000p+1023:0x007fefffffffffffff)
   to single: f32(inf:0x7f800000) (OVERFLOW INEXACT )
    to int32: 2147483647 (INVALID)
    to int64: 9223372036854775807 (INVALID)
   to uint32: -1 (INVALID)
-  to uint64: -1 (INEXACT INVALID)
+  to uint64: -1 (INVALID)
 from double: f64(inf:0x007ff0000000000000)
   to single: f32(inf:0x7f800000) (OK)
    to int32: 2147483647 (INVALID)
@@ -232,80 +232,80 @@ from double: f64(nan:0x007ff8000000000000)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(nan:0x007ff0000000000001)
   to single: f32(nan:0x7fc00000) (INVALID)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(nan:0x007ff4000000000000)
   to single: f32(nan:0x7fe00000) (INVALID)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 ### Rounding upwards
 from double: f64(nan:0x007ff4000000000000)
   to single: f32(nan:0x7fe00000) (INVALID)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-nan:0x00fff8000000000000)
   to single: f32(-nan:0xffc00000) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-inf:0x00fff0000000000000)
   to single: f32(-inf:0xff800000) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.fffffffffffff0000000p+1023:0x00ffefffffffffffff)
   to single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff) (OVERFLOW IN=
EXACT )
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000)
   to single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000)
   to single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.1874b135ff6540000000p+103:0x00c661874b135ff654)
   to single: f32(-0x1.1874b000000000000000p+103:0xf30c3a58) (INEXACT )
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.c0bab523323b90000000p+99:0x00c62c0bab523323b9)
   to single: f32(-0x1.c0bab400000000000000p+99:0xf1605d5a) (INEXACT )
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.00000000000000000000p+1:0x00c000000000000000)
   to single: f32(-0x1.00000000000000000000p+1:0xc0000000) (OK)
    to int32: -2 (OK)
    to int64: -2 (OK)
-  to uint32: -2 (OK)
-  to uint64: -2 (OK)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.00000000000000000000p+0:0x00bff0000000000000)
   to single: f32(-0x1.00000000000000000000p+0:0xbf800000) (OK)
    to int32: -1 (OK)
    to int64: -1 (OK)
-  to uint32: -1 (OK)
-  to uint64: -1 (OK)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.00000000000000000000p-1022:0x008010000000000000)
   to single: f32(-0x0.00000000000000000000p+0:0x80000000) (UNDERFLOW INE=
XACT )
    to int32: 0 (INEXACT )
@@ -455,19 +455,19 @@ from double: f64(0x1.fffffe00000000000000p+127:0x00=
47efffffe0000000)
    to int32: 2147483647 (INVALID)
    to int64: 9223372036854775807 (INVALID)
   to uint32: -1 (INVALID)
-  to uint64: -1 (INEXACT INVALID)
+  to uint64: -1 (INVALID)
 from double: f64(0x1.fffffe00000000000000p+127:0x0047efffffe0000000)
   to single: f32(0x1.fffffe00000000000000p+127:0x7f7fffff) (OK)
    to int32: 2147483647 (INVALID)
    to int64: 9223372036854775807 (INVALID)
   to uint32: -1 (INVALID)
-  to uint64: -1 (INEXACT INVALID)
+  to uint64: -1 (INVALID)
 from double: f64(0x1.fffffffffffff0000000p+1023:0x007fefffffffffffff)
   to single: f32(inf:0x7f800000) (OVERFLOW INEXACT )
    to int32: 2147483647 (INVALID)
    to int64: 9223372036854775807 (INVALID)
   to uint32: -1 (INVALID)
-  to uint64: -1 (INEXACT INVALID)
+  to uint64: -1 (INVALID)
 from double: f64(inf:0x007ff0000000000000)
   to single: f32(inf:0x7f800000) (OK)
    to int32: 2147483647 (INVALID)
@@ -479,80 +479,80 @@ from double: f64(nan:0x007ff8000000000000)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(nan:0x007ff0000000000001)
   to single: f32(nan:0x7fc00000) (INVALID)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(nan:0x007ff4000000000000)
   to single: f32(nan:0x7fe00000) (INVALID)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 ### Rounding downwards
 from double: f64(nan:0x007ff4000000000000)
   to single: f32(nan:0x7fe00000) (INVALID)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-nan:0x00fff8000000000000)
   to single: f32(-nan:0xffc00000) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-inf:0x00fff0000000000000)
   to single: f32(-inf:0xff800000) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.fffffffffffff0000000p+1023:0x00ffefffffffffffff)
   to single: f32(-inf:0xff800000) (OVERFLOW INEXACT )
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000)
   to single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000)
   to single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.1874b135ff6540000000p+103:0x00c661874b135ff654)
   to single: f32(-0x1.1874b200000000000000p+103:0xf30c3a59) (INEXACT )
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.c0bab523323b90000000p+99:0x00c62c0bab523323b9)
   to single: f32(-0x1.c0bab600000000000000p+99:0xf1605d5b) (INEXACT )
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.00000000000000000000p+1:0x00c000000000000000)
   to single: f32(-0x1.00000000000000000000p+1:0xc0000000) (OK)
    to int32: -2 (OK)
    to int64: -2 (OK)
-  to uint32: -2 (OK)
-  to uint64: -2 (OK)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.00000000000000000000p+0:0x00bff0000000000000)
   to single: f32(-0x1.00000000000000000000p+0:0xbf800000) (OK)
    to int32: -1 (OK)
    to int64: -1 (OK)
-  to uint32: -1 (OK)
-  to uint64: -1 (OK)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.00000000000000000000p-1022:0x008010000000000000)
   to single: f32(-0x1.00000000000000000000p-149:0x80000001) (UNDERFLOW I=
NEXACT )
    to int32: 0 (INEXACT )
@@ -702,19 +702,19 @@ from double: f64(0x1.fffffe00000000000000p+127:0x00=
47efffffe0000000)
    to int32: 2147483647 (INVALID)
    to int64: 9223372036854775807 (INVALID)
   to uint32: -1 (INVALID)
-  to uint64: -1 (INEXACT INVALID)
+  to uint64: -1 (INVALID)
 from double: f64(0x1.fffffe00000000000000p+127:0x0047efffffe0000000)
   to single: f32(0x1.fffffe00000000000000p+127:0x7f7fffff) (OK)
    to int32: 2147483647 (INVALID)
    to int64: 9223372036854775807 (INVALID)
   to uint32: -1 (INVALID)
-  to uint64: -1 (INEXACT INVALID)
+  to uint64: -1 (INVALID)
 from double: f64(0x1.fffffffffffff0000000p+1023:0x007fefffffffffffff)
   to single: f32(0x1.fffffe00000000000000p+127:0x7f7fffff) (OVERFLOW INE=
XACT )
    to int32: 2147483647 (INVALID)
    to int64: 9223372036854775807 (INVALID)
   to uint32: -1 (INVALID)
-  to uint64: -1 (INEXACT INVALID)
+  to uint64: -1 (INVALID)
 from double: f64(inf:0x007ff0000000000000)
   to single: f32(inf:0x7f800000) (OK)
    to int32: 2147483647 (INVALID)
@@ -726,80 +726,80 @@ from double: f64(nan:0x007ff8000000000000)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(nan:0x007ff0000000000001)
   to single: f32(nan:0x7fc00000) (INVALID)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(nan:0x007ff4000000000000)
   to single: f32(nan:0x7fe00000) (INVALID)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 ### Rounding to zero
 from double: f64(nan:0x007ff4000000000000)
   to single: f32(nan:0x7fe00000) (INVALID)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-nan:0x00fff8000000000000)
   to single: f32(-nan:0xffc00000) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-inf:0x00fff0000000000000)
   to single: f32(-inf:0xff800000) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.fffffffffffff0000000p+1023:0x00ffefffffffffffff)
   to single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff) (OVERFLOW IN=
EXACT )
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000)
   to single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.fffffe00000000000000p+127:0x00c7efffffe0000000)
   to single: f32(-0x1.fffffe00000000000000p+127:0xff7fffff) (OK)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.1874b135ff6540000000p+103:0x00c661874b135ff654)
   to single: f32(-0x1.1874b000000000000000p+103:0xf30c3a58) (INEXACT )
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.c0bab523323b90000000p+99:0x00c62c0bab523323b9)
   to single: f32(-0x1.c0bab400000000000000p+99:0xf1605d5a) (INEXACT )
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.00000000000000000000p+1:0x00c000000000000000)
   to single: f32(-0x1.00000000000000000000p+1:0xc0000000) (OK)
    to int32: -2 (OK)
    to int64: -2 (OK)
-  to uint32: -2 (OK)
-  to uint64: -2 (OK)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.00000000000000000000p+0:0x00bff0000000000000)
   to single: f32(-0x1.00000000000000000000p+0:0xbf800000) (OK)
    to int32: -1 (OK)
    to int64: -1 (OK)
-  to uint32: -1 (OK)
-  to uint64: -1 (OK)
+  to uint32: 0 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(-0x1.00000000000000000000p-1022:0x008010000000000000)
   to single: f32(-0x0.00000000000000000000p+0:0x80000000) (UNDERFLOW INE=
XACT )
    to int32: 0 (INEXACT )
@@ -949,19 +949,19 @@ from double: f64(0x1.fffffe00000000000000p+127:0x00=
47efffffe0000000)
    to int32: 2147483647 (INVALID)
    to int64: 9223372036854775807 (INVALID)
   to uint32: -1 (INVALID)
-  to uint64: -1 (INEXACT INVALID)
+  to uint64: -1 (INVALID)
 from double: f64(0x1.fffffe00000000000000p+127:0x0047efffffe0000000)
   to single: f32(0x1.fffffe00000000000000p+127:0x7f7fffff) (OK)
    to int32: 2147483647 (INVALID)
    to int64: 9223372036854775807 (INVALID)
   to uint32: -1 (INVALID)
-  to uint64: -1 (INEXACT INVALID)
+  to uint64: -1 (INVALID)
 from double: f64(0x1.fffffffffffff0000000p+1023:0x007fefffffffffffff)
   to single: f32(0x1.fffffe00000000000000p+127:0x7f7fffff) (OVERFLOW INE=
XACT )
    to int32: 2147483647 (INVALID)
    to int64: 9223372036854775807 (INVALID)
   to uint32: -1 (INVALID)
-  to uint64: -1 (INEXACT INVALID)
+  to uint64: -1 (INVALID)
 from double: f64(inf:0x007ff0000000000000)
   to single: f32(inf:0x7f800000) (OK)
    to int32: 2147483647 (INVALID)
@@ -973,16 +973,16 @@ from double: f64(nan:0x007ff8000000000000)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(nan:0x007ff0000000000001)
   to single: f32(nan:0x7fc00000) (INVALID)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
 from double: f64(nan:0x007ff4000000000000)
   to single: f32(nan:0x7fe00000) (INVALID)
    to int32: -2147483648 (INVALID)
    to int64: -9223372036854775808 (INVALID)
   to uint32: 0 (INVALID)
-  to uint64: -9223372036854775808 (INVALID)
+  to uint64: 0 (INVALID)
diff --git a/tests/tcg/ppc64/meson.build b/tests/tcg/ppc64/meson.build
index ee86a75c23a..ed8403eb67e 100644
--- a/tests/tcg/ppc64/meson.build
+++ b/tests/tcg/ppc64/meson.build
@@ -36,6 +36,10 @@ tests +=3D {
     'cc_feat': 'power10',
     'cflags': ['-O3'],
     'qemu_args': ['-cpu', 'POWER10'],
+  },
+  '../multiarch/float_convd.c': {
+    'cflags': float_cflags + ['-mcpu=3Dpower8'],
+    'expected_output': 'float_convd.ref',
   }
 }
=20
--=20
2.53.0


