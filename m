Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DDC606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 18:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dvHoF1PT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIsWs-0007q9-2R; Mon, 19 Oct 2026 14:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xIsWp-0007pR-Hk
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:56:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1xIsWn-0000JK-Po
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:56:11 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFis2P4118029; Mon, 19 Oct 2026 18:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=Fe6Qr4wa0v/WL0cxRhsoLL+1u70Zmf7R2YrHAuPcs
 Ac=; b=dvHoF1PT1TWno0z4HGfDd+/HYnq6+9K1ZuK7bwvlSEY80BcBn2LP9tOjZ
 W1GLgJcQ72g4SU9iLJNqqbRZxwIFzm2CXZyNPA/jbP/LwqyvFD54WLBRlLBfbOV4
 nmzhOnHEPOPrE0mDCDLozIK43URs/xnJhNfgiIqrTaMh6EV/ukHwy9Co4fCotDML
 7J9Z64A/Dmri1sUKoTIk7DA9/oUMQhNW1Shon7zdB76YvDZuA0Q4Zo6voybrjpmR
 BeDGjVVNNOwiAvLFj58D5V0NI92U36c1fxHcrzdOIL003x1H8QMorwNChODIzYQ3
 VexyuLBVP3G/ai/6IL7TnbhoUPbmw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hbxehvkhp-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 18:56:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFZ6rr168447; Mon, 19 Oct 2026 18:56:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hcmugy01d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 18:56:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69JIu2Ue40304948
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Oct 2026 18:56:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3629B2004D;
 Mon, 19 Oct 2026 18:56:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0128220040;
 Mon, 19 Oct 2026 18:56:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
 Mon, 19 Oct 2026 18:56:01 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 4958)
 id D847E1610E1; Mon, 19 Oct 2026 20:56:01 +0200 (CEST)
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
Subject: [PATCH v2 0/2] tests/tcg fixes
Date: Mon, 19 Oct 2026 20:55:58 +0200
Message-ID: <20261019185600.2031729-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA3NCBTYWx0ZWRfX4yxwC/0qa6Y7
 gn6kXU+Pmf3N3H+nhGHSzgxKcdE6du/unb5Y69hnTICTQWNvKM1MgF+ix+snK1+0ZJekoql3m96
 HPPQwJrschABO8Y52r80hNs8iwjMZRvFn9t7pw9kyetqXK1+lmWr9tBGSJltOQSRJf7kd/pHUoJ
 IZFhZgtTRnHaM37LeyhMt1IePO0njxHXZj+h1hf10q3wZH2oLoypWS+cAcMKs2dSJutNVkIEB2z
 KfGULSNnmHSLhQtUN1HcqgrkVj0yGOTSCz+pxbzxCt+p1zzoCmnPkGXXhBM1ezIuYRVHcBnV97u
 pgImY40Xp6rSdMGmwXxg+s2gwA0lkdm+biYf6waR6B+XU0Sn/VsJ4Pg15EyAGATb6fSE4yv8k2D
 PGvbdCcoKD5yw/pnTEDIGR1VZ+AopMM/tzhC3FaR6bcSIYSqofPqW4IKNbWaDoiDZE4Fvs9kbdy
 zjFPc/W+m0bnvc04vLw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA3NCBTYWx0ZWRfXzmK6y6zdC3Kz
 wQDi4QIYJt1cAnA79GcIve0nvVwmNWvVpVmOGE2LuzD0fsOe6UENyU3WIGQ6/0GR9qCesoBbKff
 jMz/oOCVH7chE4/S9gZuUVkB7h1MoS4=
X-Proofpoint-GUID: B6Hm5ok7mYnAZPEbSk1J9mvhYWyT9795
X-Proofpoint-ORIG-GUID: lv-tqGgfojhhN0HwFFS4qa6YDn-KSdeF
X-Authority-Analysis: v=2.4 cv=OZQNnRTY c=1 sm=1 tr=0 ts=6ad667c7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Okj3z4qPkiDdXlMXt1IA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190074
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
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

Here's a quick turnaround on the tests/tcg fixes to address Pierrick's
comments on v1.

Quoting the important part of v1:

 - Patch 1 addresses an endianness problem that shows up when running
   on a big-endian (s390) host. It's existed for a while, as I can
   recreate similar errors (if slightly different messages) at least
   back to 11.0.0. Just never noticed (or looked into it) before.
 - Patch 2 addresses a change in behavior that occurs in the powerpc
   toolchain between power6 and power7 (based on experimentation with
   gcc -mcpu=3D settings). The tests as they currently are run fine for m=
e
   on either an s390 or x86 host running Fedora, but fail on both hosts
   running Debian.=20

v1->v2:
 - [PB] Add -mcpu in the loop processing the multiarch tests, rather than
   skipping it and adding it later.
 - [PB] Squash patches 2-4 into one
v1: https://lore.kernel.org/qemu-devel/20261019151233.230172-1-farman@lin=
ux.ibm.com/

Eric Farman (2):
  hw/i386: ELF endianness fixes
  tests/tcg/ppc64: Run float_conv* against power8

 hw/i386/x86-common.c            |   6 +-
 include/hw/elf_ops.h.inc        |  20 ++++-
 tests/tcg/ppc64/float_convd.ref | 144 ++++++++++++++++----------------
 tests/tcg/ppc64/float_convs.ref |  80 +++++++++---------
 tests/tcg/ppc64/meson.build     |   6 ++
 5 files changed, 140 insertions(+), 116 deletions(-)

--=20
2.53.0


