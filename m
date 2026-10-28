Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C497606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 05:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qWBTivAm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLw5c-0003Sd-VP; Wed, 28 Oct 2026 01:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xLw5a-0003SA-M2
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 01:20:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xLw5Y-0005x1-Tm
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 01:20:42 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S4iL15227350
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 05:20:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=3HaZCnXeTjYjm+/DcguG+giM3VO+snvyjkp82i0ba
 XI=; b=qWBTivAmF0RglPkOScCuHBvegsm58xljOB71pwaKtiXetbp9ysfCZg7Wh
 lxof89pHYyNJKuauW2CaPn6VEAhWp3e29vTP4UMHxde73F3XhnoEh05JGAsPoK5m
 o7AGpZXZpXofOATWlKgdxogZA6JY2gT+yEDaBDXn543i7hkER0m5gCZLex+sz8AF
 zfvH1xJnuN2NVbAmhCzzlPoEoaKDxBYZ8Jr5Pq3eGpdhA1aIC65XNpxpNVuvN4r2
 r7wtKMPJeEKmZU8ztqH/rKiXK7OPwMiVLHL9xlNaVUAV+VvV1IZynxypJ2on/9uU
 +rkespKEDF6Pucmv4jGLRHSMPKciw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgj3mb71k-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 05:20:38 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S4YwVg973653
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 05:20:38 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hjtnnbpdh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 05:20:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69S5Kamm31589096
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 05:20:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 12ED320043
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 05:20:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 844F120040
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 05:20:35 +0000 (GMT)
Received: from dhcp-9-123-3-122.bl1-in.ibm.com (unknown [9.123.3.122])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 05:20:35 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/6] ppc queue for 2026-10-28
Date: Wed, 28 Oct 2026 10:50:18 +0530
Message-ID: <20261028052024.38377-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAyMCBTYWx0ZWRfX26NG2zX8spjH
 hrQxDnBTxOvj+K5NDvqTjlJwMPVydZwAQeqLCmkuz9woOFoldJzhrbXQV/UKEnX7z/Z9mUY4IDL
 kPqiahEI05lihpdCKM++FIgGFCAUTVI=
X-Proofpoint-ORIG-GUID: Ff2NpKyLcHuCwXttl4VDnVfBzQkfKXl_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAyMCBTYWx0ZWRfXyzU89oT0C9wF
 TkpDkMwyY0PspQ6bY/F4VwYeWuVfn7KLS3wFdKxOZF2Wr1Ozi3tXUH4B2wxE0sVk1tI4ScsET1F
 KS6Nkiyxv0FG49oEO0P8N/gRXFHTTjdjNvv/nGrTL/VD9AVzmVFDo65bGUw5hkIv++sklLnkgY9
 bePZBwBLMveUeGVDtZ1PR8a2129Ac0VdlDxxEXbMwD43+bBktJDA9JXa8YB1WT2YAxTKnGBPv8z
 EPsydSvYHsF2eimWiaf1uLXTh544Zr4M/MDt7fJ68Sk1yADVLcojDaZSwnfmviPzeq9tFMGA2DZ
 lZwmoxNRfmPA3zeJPPpCzrciLrUZr6y8CBo7rdmdf4eTm+DVs6SBzGcmrJvMWNyLBYCFUPuV7tR
 Xl9pOqRdZlhCjqylRPpzZv2NyqI0W7plSi14pC4qu9/L/oJz/8IdKkmgZMEeaaycbZLqW9iUN05
 bOXZGDugRNS7TuGT+Bw==
X-Authority-Analysis: v=2.4 cv=G7uJgNk5 c=1 sm=1 tr=0 ts=6ae18626 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=NEAV23lmAAAA:8
 a=p0WdMEafAAAA:8 a=NdSIIfICmCX2OmTV6YQA:9
X-Proofpoint-GUID: Ff2NpKyLcHuCwXttl4VDnVfBzQkfKXl_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280020
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit d29412cca54899ba87d5ea5d61e8bad7643b15f0:

  Merge tag 'pull-riscv-to-apply-20261027' of https://github.com/alistair23/qemu into staging (2026-10-27 14:27:13 -0500)

are available in the Git repository at:

  https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-11.2-sf-20261028

for you to fetch changes up to 74e68729ca8ee576bef823798ffc80589b1edd63:

  spapr-vscsi: clamp adapter info DMA write length to struct size (2026-10-28 10:45:51 +0530)

----------------------------------------------------------------
ppc queue for 2026-10-28
- Misc fixes and func test improvements.

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEa4EM1tK+EPOIPSFCRUTplPnWj7sFAmrhhToACgkQRUTplPnW
j7uZnw/+OvWVsLH/lDUYqmpzZcYCqsJ9t/L407RcT5FvzTOpMiH95s7u8Hif/siz
ZV4iCP+kwwcsTFLjvLoCpCo+iY90XoeB1ThfNYmLQsJP75ze3HtAzRbk9L4NLNbK
xUdyRtAYDEb4peB5UTlwPufxS768swjYl3vybZUdz3TiGW06D/Lzz2c47ScZRUeo
TyU37T//v1bS+j5pIkosqfL8BegCUSvwdA3xIRbwX6rzyqawRZKWT9PHc7oEs+JA
7FtsYhUFkaH7rfSyYVMb/hLs/RadvU17s0WBP025pibf/xjO0BCeFelUS1JZYolU
MrSMlbJJCJRh6G3KeHnd9ZUin8Ogsrw82xI/IRNoF5WzyO946mMvRxvv1wW36Av8
SZG/F+LkeQ1spq/S0ngASunOiSLxfDpQ4Rs9Q8e3tNZljl693/Ax3mmtpJqRInDe
FxTEcx2dP+9xPVEoGCjiPSCoKg0ovhDwvRjhvaAOrbnDcXSwTalqfJ8WdhJMVb7G
Jx+GppFe/x+xR0c/+BfvG138GbqWPo/javCNiJ7ScJ6aerPN8nCE4pFs+gxXqp8b
7cfKMihRpbgYC6vC5NY3smC3lvglLo70X6okx4UTJkABm/XiXRE70kS0vvCa/93t
xGJmI/oYH8kOB2PusBtTHoqb7/cP/x3GflXyQ67qDC+bcSdxA/4=
=wHdy
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Aniket Sahu (2):
      tests/functional/ppc64: extend pseries migration tests
      tests/functional/ppc64: extend ppc64 powernv net device tests

Chinmay Rath (2):
      hw/net/spapr_llan: validate RxBufPool fields on migration load
      spapr-vscsi: clamp adapter info DMA write length to struct size

Nikhil Kumar Singh (1):
      hw/pci-host/pnv_phb4: fix guest-triggerable abort on 8-byte config access

Showta Ishizaki (1):
      hw/ppc/spapr: Add the "rtas-version" property to /rtas

 include/hw/ppc/spapr.h                   |  3 +++
 hw/net/spapr_llan.c                      | 18 ++++++++++++++++++
 hw/pci-host/pnv_phb4.c                   | 18 ++++++++++++++++--
 hw/ppc/spapr.c                           |  1 +
 hw/scsi/spapr_vscsi.c                    | 18 ++++++++++++++++--
 tests/functional/ppc64/test_migration.py |  4 ++--
 tests/functional/ppc64/test_powernv.py   |  7 +++++--
 7 files changed, 61 insertions(+), 8 deletions(-)

