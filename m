Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853F4606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=mcsSO07t
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIsWx-0007rJ-GT; Mon, 19 Oct 2026 14:56:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xIsWt-0007qK-5Y
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:56:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xIsWo-0000JP-Tg
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:56:14 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFiTg13041651; Mon, 19 Oct 2026 18:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=W91IzZ7hEPlqVCbHC
 samYFx6badT/p0SGBMWJ1R1KFc=; b=mcsSO07tHvHF6xdxfMGG5wuhp/xOyEUMN
 1EwcHdIhi6w1/wP8AW9UmIlfRkToy8Ung9fCyh3B4hmu/9glfOs9WTm0jDoWvPdd
 MNK+kI158pWH1zLg1S8OaKSt8BXrbFImFbicsixoMpzIn8sG8JZJXF72FSEO+sxw
 eCkRmteGVPbPmYUX1mSBVxPuZfl7+bk6cJHjhq3Ajd3+g+5CniqXq+JUpVp5XR/Q
 IOc/namH5DvqJQpd626EqouF3j3UX4ngG9/LfHaLqR0N0sF2BQxC2pxVh3IhoDnW
 imvzYs8YN/1QCAbuH6Fw1nYyX4GGENMAzqRlHahEtZHLFo9dKwvfg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hbyepvchs-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 18:56:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFZ6RK3125182; Mon, 19 Oct 2026 18:56:08 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hcnjgxvrt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 18:56:07 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69JIu2jh39911840
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Oct 2026 18:56:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5245D20040;
 Mon, 19 Oct 2026 18:56:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 073A72004B;
 Mon, 19 Oct 2026 18:56:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon, 19 Oct 2026 18:56:01 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id DDD2216131E; Mon, 19 Oct 2026 20:56:01 +0200 (CEST)
From: Eric Farman <farman@linux.ibm.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v2 2/2] tests/tcg/ppc64: Run float_conv* against power8
Date: Mon, 19 Oct 2026 20:56:00 +0200
Message-ID: <20261019185600.2031729-3-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019185600.2031729-1-farman@linux.ibm.com>
References: <20261019185600.2031729-1-farman@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA3NCBTYWx0ZWRfX31ZfVwX5jLJ5
 Im5GpeToGpuOeHs+WJfxOjpLwGov/8sg8rRA4IRCVea/E/qfxs5j1mGJluP3XF7URVshY1+z8zA
 Ar7KUGRtv1A6WY0xLy6odgplHWH8qKw=
X-Authority-Analysis: v=2.4 cv=Z4R5j3RA c=1 sm=1 tr=0 ts=6ad667c9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=mTO5zd2ZRFQLC5amIzUA:9
X-Proofpoint-ORIG-GUID: 924rhI5YjEMDaDMXbzugqG78EFDniwnK
X-Proofpoint-GUID: WS6kx1lHfCSpvl-lnlAgsoP7ozaHgtmy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA3NCBTYWx0ZWRfX5nkNg1V5XWQ6
 j/rBr13TqAsmX9hvNLjhCAD3/14Ey6B+ZLwZofB92VBIiTKWEjk++OPxypWPds7bEDHek5WCod6
 uRiSYC8+1zwJOfPYhArOQ031c2S8NNwG5UpgiJwJRnhJd8NujNg3M5H7K4am/QfkB5YON7E1HtU
 0VrVcrgL231KRuf+czcu7mRKL5atLnXTnMTjchKM0aLQWwe75lX1FAZNpWDok6lOPmR56sKfOJ6
 Do60wRdp8RRlJkYuL4WCnO4It15hpbQxF6o5eHRymE/ay/RtwqBbwxTuuDQACgiMyTFp5hHby7n
 aPnSzFrLkDQsYTEJm24cfThUhz7ec5OtXscjhQWVkE749WbOYY2ssQ71m2rtWqcgaWifUkpuLAi
 QoHwhwxUYXqRUx+urbF3Geq9datnRk4y7pwcVg+nupTZyPoibkjEaoapFio6SiKcdZBgP5WRXIP
 z5EK2azp1VcDYza8ioQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190074
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There is an oddity that turns up with the float_convd and float_convs
tests, when running from different toolchains. As one example, the
expectation at the start of tests/tcg/ppc64/float_conv*.ref is:

  ### Rounding to nearest
  from double: f64(nan:0x007ff4000000000000)
    to single: f32(nan:0x7fe00000) (INVALID)
     to int32: -2147483648 (INVALID)
     to int64: -9223372036854775808 (INVALID)
    to uint32: 0 (INVALID)
    to uint64: -9223372036854775808 (INVALID)

But, other hosts offer a different response, e.g., this debian guest
on my laptop:

  ### Rounding to nearest
  from double: f64(nan:0x007ff4000000000000)
    to single: f32(nan:0x7fe00000) (INVALID)
     to int32: -2147483648 (INVALID)
     to int64: -9223372036854775808 (INVALID)
    to uint32: 0 (INVALID)
    to uint64: 0 (INVALID)

The explanation seems to be a behavior change when compiling to different
versions of power hardware. When building the arguments from the multiarc=
h
directory, let's ensure these float tests offer a deterministic response
to these NaN tests by explicitly binding them to a CPU architecture.

Chose power8 for no real reason. This behavior change appears between
power6 and power7, but other tests that rely on a specific architecture
today pick either power8 or power10.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 tests/tcg/ppc64/float_convd.ref | 144 ++++++++++++++++----------------
 tests/tcg/ppc64/float_convs.ref |  80 +++++++++---------
 tests/tcg/ppc64/meson.build     |   6 ++
 3 files changed, 118 insertions(+), 112 deletions(-)

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
index 8cca4d65a4c..d9b4b153d94 100644
--- a/tests/tcg/ppc64/meson.build
+++ b/tests/tcg/ppc64/meson.build
@@ -13,6 +13,12 @@ foreach t: tcg_tests['multiarch-linux-user']['tests']
     if fs.stem(src) =3D=3D 'test-plugin-mem-access' and 'wrapper' in set=
up
       continue
     endif
+    if fs.stem(src).contains('float_conv')
+      # Ensure float NaN tests are done against a known cpu generation
+      if 'cflags' in setup
+        setup +=3D {'cflags': setup['cflags'] + '-mcpu=3Dpower8'}
+      endif
+    endif
     tests +=3D {src: setup}
   endforeach
 endforeach
--=20
2.53.0


