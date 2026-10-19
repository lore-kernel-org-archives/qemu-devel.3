Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20D5609B64A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=VmD6j97r
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIp30-0006rP-OF; Mon, 19 Oct 2026 11:13:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xIp2d-0006hf-Lm; Mon, 19 Oct 2026 11:12:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xIp2a-0002W1-Ab; Mon, 19 Oct 2026 11:12:47 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JEE3qA4127704; Mon, 19 Oct 2026 15:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=xQft5iqzlmT7Mv8LJ
 6RlpBXtMJF+hH9jXOxBfxTYmBk=; b=VmD6j97rxHrdX/bjKSPmuM3Cb5keQ5gwC
 l+fNtwFENZT+OU261dbH/7b48/tKI71XdMSTG5hojL7sQdiudcTyh9YuNaeZwl19
 a63jK47T7pSRO6Y4OpHanzdB+42GnxJO3kRw4fXCbIPWs1/DI4TouOf4Du1NpmBW
 Akm3qp6Rm5Kdd7H02D4LGBep0EgrRRUw7E6HnDBmxBe+ppwPN6jAbb1+6J6MTCdb
 J48/wtPCgM+0kF64uD4y19vaSu3Cle9ihUjCX8sE3SBDr6nGJBJQpuNdYWqk2HmY
 WPZ1t2fQU6kf3l8opbtPnPCoJ5tB0zrn2wTUElZSToEQcYk+slt4w==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0h5byk9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 15:12:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JE4sqC3023642; Mon, 19 Oct 2026 15:12:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hcnjgx1ym-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 15:12:39 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69JFCZ7X16384350
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Oct 2026 15:12:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 421E92004D;
 Mon, 19 Oct 2026 15:12:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1710920040;
 Mon, 19 Oct 2026 15:12:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon, 19 Oct 2026 15:12:35 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id 007EB160E0B; Mon, 19 Oct 2026 17:12:35 +0200 (CEST)
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
Subject: [PATCH v1 2/4] tests/tcg/ppc64: Skip float_conv* tests
Date: Mon, 19 Oct 2026 17:12:29 +0200
Message-ID: <20261019151233.230172-3-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019151233.230172-1-farman@linux.ibm.com>
References: <20261019151233.230172-1-farman@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1OCBTYWx0ZWRfX1t1JKDFH6Zpp
 Pz5bvv4TohpMTT6ree4Oq2JBA5+aRoV63SPMq47LDTyz88fy/iz6uLx5mpLiSS4JbS2MFbbOUcG
 uwif+J7UBWD15OvmBhr9DAkgVJbNd38=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1OCBTYWx0ZWRfX0l9mfZ5CWDL3
 4+E2NpaRbdJ9BLDDY2fVegq8S4hSmUiHfCyQ36Px8Xfz0ypPrzubcOPzWfFt0mKij5ngkjaFLID
 2tsRXwNva2sdMzgoUwTqvNdLQhAjD9pQLdy0HuyDAVmRbWmVN8V8u2yh2mhStyZPNc2INGj7Dag
 P5speugtgy/f+DbPtxUQkmDkwJ68Cvzjc63ayfQavIWa1i3HZuaMhGCY+tJJg6raMe2MTn+o4bF
 hzcM6sXIUij3XyYzoDt7lPmjjJARLxtFnKdcCg0owZt64YYGLC891hqGzwEHRl7kxfj97mqZlrK
 tB1Ig0TDy1DxFUOqhh8HGb4LN3Gq5oXvQP7IvV2vU+cPPLPJUA22wk1vKqa2qexC2wsZB/MUh8h
 N/ZEDQkMRtMSPOGVYDlB2G7RPoohPObiEvVNIgTRj08lDuUywZYUgW8OdriC0nJGLCADC1kuCi7
 0ZAC7cm09MqU5APczkA==
X-Proofpoint-ORIG-GUID: ghb3kJa92qKtaZtWfQGowhO4V4KTxdzH
X-Proofpoint-GUID: BtdIZzPwzdVEbqb46jiKrQTKrvWUa77A
X-Authority-Analysis: v=2.4 cv=KujYSmWN c=1 sm=1 tr=0 ts=6ad63368 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=TYl8v_mP55eIv-gI3KwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190058
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
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
on a laptop:

  ### Rounding to nearest
  from double: f64(nan:0x007ff4000000000000)
    to single: f32(nan:0x7fe00000) (INVALID)
     to int32: -2147483648 (INVALID)
     to int64: -9223372036854775808 (INVALID)
    to uint32: 0 (INVALID)
    to uint64: 0 (INVALID)

The explanation seems to be a behavior change when compiling to different
versions of power hardware. Disable this for the time being, and it can
be added back in manually with the correct responses.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 tests/tcg/ppc64/meson.build | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/tcg/ppc64/meson.build b/tests/tcg/ppc64/meson.build
index 8cca4d65a4c..ee86a75c23a 100644
--- a/tests/tcg/ppc64/meson.build
+++ b/tests/tcg/ppc64/meson.build
@@ -13,6 +13,9 @@ foreach t: tcg_tests['multiarch-linux-user']['tests']
     if fs.stem(src) =3D=3D 'test-plugin-mem-access' and 'wrapper' in set=
up
       continue
     endif
+    if 'float_conv' in fs.stem(src)
+      continue
+    endif
     tests +=3D {src: setup}
   endforeach
 endforeach
--=20
2.53.0


