Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B8BEB106D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzynY-0006pB-Uh; Tue, 10 Mar 2026 11:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vzynE-0006e3-Hx
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:14:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vzynB-0000Dy-Ta
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:14:44 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A85HPv1478497
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=pd8ItWiwvS33YPnOa+8wVktOzi8CKHoVFp5ShkX4Q
 gg=; b=dMjWEXqAKzRVNsjlQ6AoZMyxtG0qZpB16DbIWXNzRfL4D8XIkUc1BaKMM
 7UAyTMlR0VBA/cLwhQFIxT3D1CSx2CfT+UkpXDV28SO0BikKI8n02mn9LpxMDzB4
 NJ1ahj4kriRv+hCP84jfCA5+EP4UnKwPHRv58tRTGTTBE9E5sRvJ3ZBtKznc7wG4
 n/++KYYvdxL4HDONjR6nIm13UWi+AeN8R0Dun8fj/Mc2WgLhBWGbyLJLt9RyI+Bf
 DINHRucXg/LXX0N8TCLbdzbCnspQmm8+4i2oV5dnf5xmfeDuVfTm20cQK1eStdt2
 W8z0ZHbBsempKD5hfvlQaMOUHYoJA==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvrb6dq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:14:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62AD2M7c015761
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:14:38 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs1221bk2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:14:38 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62AFEa6Q30605748
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:14:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF50A2004E
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:14:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 385662004B
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:14:36 +0000 (GMT)
Received: from Mac.com (unknown [9.39.23.49])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 15:14:35 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/10] PPC PR for 11.0 soft-freeze
Date: Tue, 10 Mar 2026 20:44:20 +0530
Message-ID: <20260310151432.92531-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEzMSBTYWx0ZWRfX7NXKf03mNY/Z
 rGAtOtY/xKvs7CQbUuaJlIHZcYuCGY7CARZVKhI0BYFP39sZ0i5sVcROvlxShPc34rg9Chshyr+
 90TsMN368ZtHJA1CZ4+ESRjjoHzmwzuuMuEazM1I4kxGxio2Bz24p3csP2YwQXUUUX+nV1LXZn0
 gHjs8Gr3YkrrXo/HvTOW2k7Zn2SKS1t5XD0qcJW2809tUNQgiRyG5OCD/2fGSBCqKp172obzrHk
 rsf8B8xmf/GMIKK69qckYoV1sUYVbfmS+08xJn0kP1XyqMoifJegD0Yj5EEXK3lSOpkLUgK55GW
 VwQWFZpBpT1FS+Q/rXgBS8LntQCdfQcM7mwe9G9uMIhqC25Eh2PFamuSWC1/A02+ufrYNcg8KMx
 tSZBx9Beozolb+Z2D6qzuDj2/Wmk3ZClRqIoESlAZ6E0GZ0Ti9MycySQqjriq83HCaInyud4HT8
 K3vndG6wWk0Wf7WrUEg==
X-Proofpoint-GUID: ixsjVenWwTzmUM2Af-eyiYG5u2SmcLlG
X-Proofpoint-ORIG-GUID: ixsjVenWwTzmUM2Af-eyiYG5u2SmcLlG
X-Authority-Analysis: v=2.4 cv=QoFTHFyd c=1 sm=1 tr=0 ts=69b0355f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=p0WdMEafAAAA:8
 a=EBZGVqy1oaxPReS0wPsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603100131
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit ae56950eac7b61b1abf42003329ee0f3ce111711:

  Merge tag 'firmware-20260310-pull-request' of https://gitlab.com/kraxel/qemu into staging (2026-03-10 13:32:30 +0000)

are available in the Git repository at:

  https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-11.0-softfreeze-20260310

for you to fetch changes up to 8d00b61217814fa6809768b8d2ca13167ad4106a:

  MAINTAINERS: Add entry for MPIPL (PowerNV) (2026-03-10 20:23:46 +0530)

----------------------------------------------------------------
PPC PR for 11.0 soft-freeze

- MPIPL support for PowerNV

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEa4EM1tK+EPOIPSFCRUTplPnWj7sFAmmwMSQACgkQRUTplPnW
j7sRUw/9G0iQ9VAao0nmmf4M/cKsQueZEA01KS2C4nGb2ggoDkS0oBrnFivW+Spq
YLR5dNw/p9eu5OzRIVHIHaGA8128vXWYUU/aa4rFOTQRMheLgnlNSqslnEJ+JJ05
RF/P6MhlY6kvXr3p7zE63SWStmzDKdzWsAYKWBFxQh5Vy7hnDL5p3G3Pq6WEf2x6
eK7b0x+WM6ni1SCTXkDnr0Cvk7f8oAshcuPV7hl2Y4jLvjkNzCMtcJOKAYfZxLW0
63f1Hpw27mJEVuOfb9UseyVsw/N/rtd/nSTf0mXpua/q5OVtgMjw/GELNCF4MQNa
Rlh1wz4UuAnRTPWxnT940TadIOVZU3m8+XMk1eAzvKWgeHcEk+yXKmlMT8D1weLL
Y3raH5zua/Jt2j4BczjCb4ho27pzraEzk5CAPgwS0po66J0D69T6eC+kE3MAKA8s
aj5cXB+fiH5/NA6VpQJ2jmYDErAJctiTTnYFL8MawzBr2/aaJqjMjyZUJl9ZJtFS
7PvW+gASC6IV74U4x+QVWHLHgjHzBcqu+nRFQTlmCq3xWrWf9oJe08XPzSBnsuZB
Ujf/tpG3Uw9PE/BDbIxNE44R5BJGQv0jjQUhjZTX755tOmcqSyU/g4vgqi2d6RmA
GGQpG7T5CjUxe0k8KmYZ/MjzGlCQONCJ0itIRJbwnzZn0yiDSTk=
=DVCE
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

 MAINTAINERS                           |   8 +
 include/hw/ppc/pnv.h                  |   7 +
 include/hw/ppc/pnv_mpipl.h            | 168 ++++++++++++
 hw/ppc/pnv.c                          |  98 +++++++
 hw/ppc/pnv_mpipl.c                    | 482 ++++++++++++++++++++++++++++++++++
 hw/ppc/pnv_sbe.c                      |  84 +++++-
 hw/ppc/meson.build                    |   1 +
 tests/functional/ppc64/test_fadump.py |  35 +--
 8 files changed, 852 insertions(+), 31 deletions(-)
 create mode 100644 include/hw/ppc/pnv_mpipl.h
 create mode 100644 hw/ppc/pnv_mpipl.c

