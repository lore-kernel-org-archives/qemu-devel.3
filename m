Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E28D6FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 18:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI9j4-0007XY-A1; Wed, 29 Apr 2026 14:33:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wI9j2-0007X8-DF
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:33:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wI9iz-000754-NL
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 14:33:32 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63TGAKjY1823949
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:33:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=W3+7rJuGrxJce4Q0VjKxIQOqDAfx
 dSw231OQ5SPm/n0=; b=mTtgsL4O8Lo5LalxjGzFJoCQRtxHIv76b/JizPheGG7r
 adiVyYPwyglU58eg8jyPmoW8GlzveRoSAoOS4azwXjSiWCe0Ydg0MBhOXfbyylC1
 yqWWm4pjNPoi2UWTXBSRBn8BsCIP1btTe0bm+JRgY95gSV39zdgfS6gl95+7G8Dd
 Sj3Yu45oPkAEb8zWLyc+EzKWYi4oQo7pbCdxMY7qfKd9A33gNK/BmUu3otrpTYFK
 Kaj5+S4g8uPnJyDsrqpzRFxKdNMTbui3N6FiRLtY3OGCPXokP8jh1FB1YMFrrA+G
 Qodxkz2eRHsq21r9ieMOMrPVI7fjNWxx2qljzZ4o0Q==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1e2khn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:33:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63TINsD0017139
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:33:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds8avynv3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:33:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63TIXOUd26673576
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:33:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7A1D20040
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:33:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E6DD12004B
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:33:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.39.31.77])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 18:33:23 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/13] PPC PR for 11.1 (2026-04-29)
Date: Thu, 30 Apr 2026 00:02:50 +0530
Message-ID: <20260429183310.12455-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3QYyXSL4zVEQ5UNR0G24xCdogTDTXrh4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE4NCBTYWx0ZWRfX4wyLGUgVdOi6
 1KnXJZTEITIIS1JnW7phGdEMUAPESu074XVh8TjqyUc3anfVrGql1S4E++QYC9+3DYoCXVIdtrG
 aIy9brnDi2efFXjVlRrictxAYO+wXGOPVfeyvaFI33YCcHiZRMs7vNXzqpfwCPZF5GHKJMCTFWS
 clnpMykdLC8RwBJSyDCny4sLmPjP8z3QhTeVzu6NWbCvSIvKJsPAEiQZQxuc3OsqaCBmonHSth+
 jdF+TNfomoP6y8rL0rcp7XuBIxilAXU2sRiCMgj8fO8MU08FVTgoToQZkirszowXbGztCO8E+rY
 LjuyiBKhryEW8x/aNhxHpWgAmjfW3pLFeFje8qF6b7ZItx3YbCm86SUGcip9GRMB9VDQj/6iA3l
 nx+t0XQH7/jSU2krVg4lpM2VtkZ8w3KzCpFujeiyIOgVzMJGSS5EX0oI755YRBv7VbSEKw6PLha
 JmBABrnHMdzAb6Mo/Lg==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69f24ef7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=hGGjgxr9mvmLQU8hyTkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 3QYyXSL4zVEQ5UNR0G24xCdogTDTXrh4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290184
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit 282771e1f9b9b6e0147adf5f9d676325175b1767:

  Merge tag 'pull-riscv-to-apply-20260429-1' of https://github.com/alistair23/qemu into staging (2026-04-29 09:22:51 -0400)

are available in the Git repository at:

  https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-11.1-20260429

for you to fetch changes up to 1aee8067fce95d15061eca8fbb6772d8a90ea699:

  hw/intc/xics: Add a check for an invalid server id (2026-04-29 22:51:06 +0530)

----------------------------------------------------------------
PPC PR for 11.1

* MPIPL support for PowerNV
* ppc/pnv: Add a nest MMU model
* hw/ssi/pnv_spi: Fix fifo8 memory leak on unrealize
* hw/intc/xics: Add a check for an invalid server id
-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEa4EM1tK+EPOIPSFCRUTplPnWj7sFAmnySUMACgkQRUTplPnW
j7veug/9ERfiOVoFLe9qYY+IRlAI7yWwieTW7gW1huXstcshk6e3y1tXH43DakE4
CAN5hzqBo/iUwgx7QaSgQUxtOU4waLURkBFWQUQ0syZcKKIg2rENELm4VN6GJunz
L5JOs0/55lcdLHCb4lJIhuW4AlYuVWYEzC9kGQD4dyliv7b9VygPnaYwWrmOM8KF
BiPXumDpbBJAwqnuMec08x6IU/I8CGyJuj6pbsPbL4XAVKfXmB5xM3zbK2gUUhky
cpD9AzdvPpeMCJCWwijYq3/s6ZqH4E4HrpEWqS8vVeorTvA4069bPw4ZBj6CFeJN
V1WvTMOukTwC4u6QMKnjrIaoKgIvtvHtSCTTdy6QhfMQxmguksAGMeoIDqKDLlQu
povwybYGh9viASpyPNaqkVM//ni1C68/rhsQ2wSk75f/D706M1JjGkTmAHclZRl3
xWiw3LxkGNka2BRWkfJCP+e7ntK4+k9j/kGwnLDTn870c7CcYO6bUiBdrNbqvWcP
5Rg5NeZeAc7caHZL+Zju28V2ntGdR+9dPyynDSliDJvUzb/biOdVLFfAZzD9rwYT
0yeLahsIlG2CQpr4LmmrQa7si+ZrYDHEUf3mjNPVS3rEDpdaso+TnSzulsYguIEM
fcmyhVw4cYqhaxn+nKpVQGfF/MQZfOHDmVi2DoEiTXr6xxTzLwc=
=Y8PU
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Aditya Gupta (10):
      ppc/pnv: Move SBE host doorbell function to top of file
      ppc/mpipl: Implement S0 SBE interrupt
      ppc/pnv: Handle stash command in PowerNV SBE
      pnv/mpipl: Preserve memory regions as per MDST/MDDT tables
      pnv/mpipl: Preserve CPU registers after crash
      pnv/mpipl: Set thread entry size to be allocated by firmware
      pnv/mpipl: Write the preserved CPU and MDRT state
      pnv/mpipl: Enable MPIPL support
      tests/functional: Add test for MPIPL in PowerNV
      MAINTAINERS: Add entry for MPIPL (PowerNV)

Caleb Schlossin (2):
      hw/ssi/pnv_spi: Fix fifo8 memory leak on unrealize
      ppc/pnv: Add a nest MMU model

kiki (1):
      hw/intc/xics: Add a check for an invalid server id

 MAINTAINERS                           |   9 +
 include/hw/ppc/pnv.h                  |   6 +
 include/hw/ppc/pnv_chip.h             |   3 +
 include/hw/ppc/pnv_mpipl.h            | 168 ++++++++++++
 include/hw/ppc/pnv_nmmu.h             |  28 ++
 include/hw/ppc/pnv_xscom.h            |   4 +
 hw/intc/xics.c                        |   8 +
 hw/ppc/pnv.c                          | 128 ++++++++-
 hw/ppc/pnv_mpipl.c                    | 482 ++++++++++++++++++++++++++++++++++
 hw/ppc/pnv_nmmu.c                     | 132 ++++++++++
 hw/ppc/pnv_sbe.c                      |  85 +++++-
 hw/ssi/pnv_spi.c                      |   8 +
 hw/ppc/meson.build                    |   2 +
 tests/functional/ppc64/test_fadump.py |  35 +--
 14 files changed, 1066 insertions(+), 32 deletions(-)
 create mode 100644 include/hw/ppc/pnv_mpipl.h
 create mode 100644 include/hw/ppc/pnv_nmmu.h
 create mode 100644 hw/ppc/pnv_mpipl.c
 create mode 100644 hw/ppc/pnv_nmmu.c

