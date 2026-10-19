Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D29609B65D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qJNbZHF1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIp2q-0006ls-Ia; Mon, 19 Oct 2026 11:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xIp2d-0006hl-Oj; Mon, 19 Oct 2026 11:12:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xIp2b-0002Vw-8I; Mon, 19 Oct 2026 11:12:47 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JEEB414023781; Mon, 19 Oct 2026 15:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=Tf0vMtXnduSRXhUtSDZ9EQdJgHgu
 y7780nLGLBH2q/Y=; b=qJNbZHF1wi/Q/LGj/ZY3yIQBgKBGBl8SEMRMJeOT151n
 UANgcPLjkww/Etcj8N+9pHuqoV9BHhficJBqouMLEpZZ0D0ggptwsXNDCLW4ZcWk
 3R8zjPIfhEmgmMdWTMsVzLceXpTvjuT3+mRbZL+Fmxq2Su+Sz8a6QeIAEoEqHtDQ
 g1xFK+wrekkEM/oJ7B8KB88EyNlEJBIQuHTGxP6ZyGlfu9iiwNYk2WZgGLZxeIA0
 CS01AUKhiHZHoj8vjhwT9M7udt48uw+orixD/F7TFcsQEJJIoWaX9/sZpBviDOHk
 /mEjg6eCEwDCeNUCC/mnAAHjlyidTB/PH5MyQydztA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0nvu2jq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 15:12:40 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JE4vFc4174114; Mon, 19 Oct 2026 15:12:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hcmbjx7d2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 15:12:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69JFCZeJ34275778
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Oct 2026 15:12:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 41E912004E;
 Mon, 19 Oct 2026 15:12:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 16BCF20049;
 Mon, 19 Oct 2026 15:12:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon, 19 Oct 2026 15:12:35 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id F17BC160CFD; Mon, 19 Oct 2026 17:12:34 +0200 (CEST)
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
Subject: [PATCH v1 0/4] tests/tcg fixes
Date: Mon, 19 Oct 2026 17:12:27 +0200
Message-ID: <20261019151233.230172-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1OCBTYWx0ZWRfX/CwGPBBmBp15
 Ky6stCXEGCfOyC2RNDWv4ZCLCf9bfHtwxiGLSG5fH2EtJobcDP4Ls3dgpFtgicBJwBB6a44NvId
 T/4eDuwHg1l83jgQLE9kKAdb1CVkKYk=
X-Proofpoint-ORIG-GUID: JI82h5wbc1exwz8DbNzsM-oiBjdweN50
X-Proofpoint-GUID: aIBdtXAL_ePd28k3uNqnkAqdBvseiGQ7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1OCBTYWx0ZWRfXwWEXA29LRlLo
 k3VsF0wsQM4kUd7/QZO7FRp12GZVCu3s0Zu4jNpAdhoixCWLjmzXFYtjaBGQgwfLjuEOEdEG+BL
 RNOy1OA3Olrt8eDFmpNq9KobX1l+bYTseD5Lp0YOP15s2ifve1GqakYbGSKwn9ufV/WXzEJTVBM
 pV46ywoKF1Tp5rKRT1Tl4FyYWMlxLfuQ9fT5+ARayHFhdaVkJda6PvCxA0jXC0gurBL6RDdQvJa
 FICJAsRvKqln9RfQvvPRasSUZsdKoSz+QEQbA1B+gdPKSRR7PqonXaJw6/8nA/4RnxroMXmZk1z
 RvYZMk0WRyRMIUwxZOcXwYvEnfK4oUyZc1QbCzuiZsDIz+3cS2sxKeOHKZdEeUykzGKIZEhWU72
 ywU3ocpUJCa0emYnUtkRu+mxdhX2UAHqzXKxKXEoftrEtNqx8N1RrnmTZ9b4mSEbkZFmv0SzBpt
 Dk86boDmkpOw0IyC19w==
X-Authority-Analysis: v=2.4 cv=MY35KJ/f c=1 sm=1 tr=0 ts=6ad63369 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=QbD7gNHDlg4_N-IKhW0A:9
 a=QEXdDO2ut3YA:10
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

With the tests/tcg rework that went in recently, we now see the results
of make check-tcg tests as part of make check output, which is a nice
addition so thank you for that! Of course, it did expose a few problems
in the non-container environment that I'd like to consider here.

=C2=A0- Patch 1 addresses an endianness problem that shows up when runnin=
g
=C2=A0=C2=A0=C2=A0on a big-endian (s390) host. It's existed for a while, =
as I can
=C2=A0=C2=A0=C2=A0recreate similar errors (if slightly different messages=
) at least
=C2=A0=C2=A0=C2=A0back to 11.0.0. Just never noticed (or looked into it) =
before.
=C2=A0- Patches 2-4 addresses a change in behavior that occurs in the pow=
erpc
=C2=A0=C2=A0=C2=A0toolchain between power6 and power7 (based on experimen=
tation with
=C2=A0=C2=A0=C2=A0gcc -mcpu=3D settings). The tests as they currently are=
 run fine for me
=C2=A0=C2=A0=C2=A0on either an s390 or x86 host running Fedora, but fail =
on both hosts
=C2=A0=C2=A0=C2=A0running Debian. I opted to disable the tests up front, =
and then add
   the problematic tests one at a time, since passing a cpu generation
   to the compiler changes the expected reference output.

Can't say I understand the details of the ppc64 compiler behavior,
but this gets make check-tcg running cleanly in all my configs.

Eric Farman (4):
  hw/i386: ELF endianness fixes
  tests/tcg/ppc64: Skip float_conv* tests
  tests/tcg/ppc64: Add float_convd test
  tests/tcg/ppc64: Add float_convs test

 hw/i386/x86-common.c            |   6 +-
 include/hw/elf_ops.h.inc        |  20 ++++-
 tests/tcg/ppc64/float_convd.ref | 144 ++++++++++++++++----------------
 tests/tcg/ppc64/float_convs.ref |  80 +++++++++---------
 tests/tcg/ppc64/meson.build     |  11 +++
 5 files changed, 145 insertions(+), 116 deletions(-)

--=20
2.53.0


