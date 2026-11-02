Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C078606A327
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=pBY4I6Ws
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNqUU-0003FF-8K; Mon, 02 Nov 2026 06:46:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xNqUS-0003Ew-W5
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 06:46:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xNqUQ-0005Cg-P3
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 06:46:16 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29ERuG1334231
 for <qemu-devel@nongnu.org>; Mon, 2 Nov 2026 11:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=R2bbo8AJdmlHZl44ir2RbyTifF0u
 EpSPknpELDSJOH4=; b=pBY4I6WssxVGusZMGJXauLIKmD4Fiya0jVgO0ERx1DIe
 mR6RC1b66TVGTGy5ASywAWe8b6TfEJTWMsU3Pj/hbfY9Xv5jL0DJsNb4Mqp7ETeW
 PLsreKZQTeOa0fUVgN1JwhLAqlVHGY3dfkr2CezdDzqImc2hZvMiedBDUF1lFMvP
 mdU/fL1gVyscrHoK6ez9NsVriOIYJi4zbvnwSSPglDvRhNF0vrh4Fv5e0gv8fRlR
 P4Kj7PDjW2RoxV3idFp2L0zWdRxaZZs+9rOZPJGlesPt/3ZNjVgYDBZY0pjfJpI+
 dWMipoXiAlXNcQp87LBT4aulSQOhC8GXtBU03f/5+w==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rd08e0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 11:46:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A29JtbA703010
 for <qemu-devel@nongnu.org>; Mon, 2 Nov 2026 11:46:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hntnpwr2q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2026 11:46:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A2Bk8hp44040686
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Mon, 2 Nov 2026 11:46:08 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2A1D320043
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2026 11:46:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0764120040
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2026 11:46:07 +0000 (GMT)
Received: from Mac.com (unknown [9.43.40.115])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2026 11:46:06 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] PPC PR for 11.2 Soft Freeze
Date: Mon,  2 Nov 2026 17:15:48 +0530
Message-ID: <20261102114558.62509-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EBwKas5w9Zvvv76aoIs_R879Dy-ZhPBs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfX9/LuNy6TYM4G
 jTcQOZufsij41qudXn0WAvZSNxdc7LhS1rvcz9L2yXqUA7vU6TSlWt0vX2N2Nr3Ene5QK/VKNYh
 MlObqGvJhA2K94k2nh4jOBTuIdAQFFz+wm1E+T3RCpQX9UsZF2H4PD77yxpmWrg0TRZfC/GeNsq
 kjpgs0eX4fzYDCRlTbfi90M+nlENn8CvuAs/Wd6LNm7oPb/ps3iHhy1LVOLp+ltDxP3aAOR4Mv1
 3j3YXN6z8OwCqHALlBH2pkeXEGbLV7NsckhYohDZT+Mz48z6mtrPBdXD75n+zURUlGQesttrpbw
 BjMoRDTqgCaXmuDFCWR0BFOLarsoTDBzDxrlgiKnzxH71aimy8Bh6jtIaWcpvRugS9kkMGJyOg5
 j/JxD6waSInUNFdKqgMGAsd3byiwqYV4HD8xEdyuUT6Du0m+a9cPToizQ2tdx82APcvUBfZKiBJ
 tdRgN/o1Wg2pC5APaFA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0NiBTYWx0ZWRfX64Mv1HXPSQQ8
 gbf4MCzpGUqQV6p08SlF2piRYlXCUc0eYWQcozCbKaMQLZ8f5LRzAqkO7DubuhORPPzaKcFA+Zn
 OziqfUyG/WEwxJIomTWoCn6Wmfswp/0=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6ae87802 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=A4W1-d2cKtFLbGZcfDcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: EBwKas5w9Zvvv76aoIs_R879Dy-ZhPBs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020046
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The following changes since commit 56afd82bd4db9688f1c1c9d0e2ea163b8cde3283:

  Merge tag 'qemu-sparc-20261101' of https://github.com/mcayland/qemu into staging (2026-11-01 08:37:48 -0800)

are available in the Git repository at:

  https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-11.2-sf-20261102

for you to fetch changes up to 9e0dff1dca5d50a79b02de6e72a8adcc22b23143:

  pnv/phb5: Mask off LSI Source-ID based on number of interrupts (2026-11-02 12:44:37 +0530)

----------------------------------------------------------------
PPC PR for 11.2 Soft Freeze
* PowerNV: Add initial support for PHB5

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEa4EM1tK+EPOIPSFCRUTplPnWj7sFAmrocFsACgkQRUTplPnW
j7sIWg/8C1FVTFJYm+gFZs1rb9drL4khMMoy0HcpHvBwDMFtnknK7I6Ul33edLHy
nZBQq/9FPVgy9iBBTbG9oo1POA7wY/J55LAyxh31CW5fATZvjNZZ+58xjTtj5ji+
BuyW9jDMcpbt0zF4yyY53QQ9tUXIym8QU0SkzOc1sQOBaY+zGXsSel75yXwR9eJU
gpfZ+Lw4AieCX+6FWc8jK0m65CpNcNn9SMmENa9y/fYjDjyEX4bJ20YFuMMLwtG6
J/vDY1gqNKXToIR3lEvwJyJQfWai9n6f/gW6lNBFOa2U6OPK7UBer5vE7OB+RRfV
5Sv2Jy/hOu1rWWSFaxrJ+Pw9zuk5iVEKpLJnoYFrDJlbDexUsDZw8YR+Rpkcn64+
lN4C6BEjb7TaY/pJS7agDQ85SiScDif7/dkG2qV9i0k3RR/YbZEnkbKVhWHzcjIv
I6eqDTSs11Lb7Xc9DR/xn+Lkt1KfBYZzKYDXqy6veM0hqA1YwD+jT/K+KUMbldFe
AeI8MPauMVifY5oI2vnXC5dFsr+O7hxAp6raMQci0m6KdUUM1wN5Gz9ghPRdjjyV
f4C4rPzhpk0dy7X14qccfVVquhz0UFHjwwfwFewg1IoSSvh9vl46FGa1bO+MJGNu
dJUk0Q2wW/VgJ2S7Dt04SoGlE+PqBLwJoMvnDCQEOmBYZaUI010=
=rVvI
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Saif Abrar (9):
      qtest/phb5: Add testbench for PHB
      pnv/phb5: Add reset logic to PHB5
      pnv/phb5: Implement sticky reset logic in PHB5
      pnv/phb5: Implement read-only and write-only bits of registers
      pnv/phb5: Implement write-clear and return 1's on unimplemented reg read
      pnv/phb5: Set link-active status in HPSTAT and LMR registers
      pnv/phb5: Set link speed and width in the DLP training control register
      pnv/phb5: Implement IODA PCT table
      pnv/phb5: Mask off LSI Source-ID based on number of interrupts

 include/hw/pci-host/pnv_phb4.h      |  43 ++-
 include/hw/pci-host/pnv_phb4_regs.h |  58 +++-
 include/hw/pci-host/pnv_phb5.h      |  52 ++++
 tests/qtest/pnv-qtest-common.h      |  24 ++
 tests/qtest/pnv-xive2-common.h      |   7 +-
 hw/pci-host/pnv_phb.c               |  20 +-
 hw/pci-host/pnv_phb4.c              | 538 ++++++++++++++++++++++++++++++++----
 hw/pci-host/pnv_phb4_pec.c          |   2 +-
 hw/pci-host/pnv_phb5.c              | 197 ++++++++++++-
 hw/pci-host/pnv_phb5_pec.c          |   1 +
 hw/ppc/pnv.c                        |   1 +
 tests/qtest/pnv-host-i2c-test.c     |  13 +-
 tests/qtest/pnv-phb-test.c          | 236 ++++++++++++++++
 tests/qtest/meson.build             |   1 +
 14 files changed, 1089 insertions(+), 104 deletions(-)
 create mode 100644 include/hw/pci-host/pnv_phb5.h
 create mode 100644 tests/qtest/pnv-qtest-common.h
 create mode 100644 tests/qtest/pnv-phb-test.c

