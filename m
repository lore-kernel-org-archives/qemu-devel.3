Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22EFC9EC67
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:35:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfFGC-0003LU-4x; Mon, 12 Jan 2026 05:34:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vfFGA-0003KL-CC
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:34:54 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vfFG8-00028T-O1
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 05:34:54 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60BLqO0N029996
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=YdK0lJrzvw+G1BxFInbgdPVm8Smaxs1gAf5DVgZpI
 ik=; b=q1TzJw4vh4qgxeCIIGLF0ipGGKWOlcb91gC6oHgTQRLQuJPZV358EWiWw
 hjQ9nRQFSCxCJJIu4SsamzO56hnLroyC0urODTkR2LhqVhaGNeygkr6kts99Sunl
 oCphEMADSM6rW+1ZHOko64x9j0Z7hIJfQzl/T7mK7esBl6/giZbrJdQkfzs1hn2N
 B4AsysuyYXKuqyuHORun6zByzRcyBOnFw81ZWBTFU2ZWsm+h2JUab9zVO4yLWZRG
 yFOSnMdMVb0iUEQJ4ZbTRwE7SscsKQT4uZ5el89m6jyPK9Um6krd4WdLxHKUHoOM
 3Ovr0uqTjOM0fFefNJ0JXy8lPzC2Q==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedsp9v4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:34:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60C7GMmI030134
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:34:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bm3ajd730-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:34:50 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60CAYn7H47907298
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:34:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0AF0420043
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:34:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 95D3920040
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:34:48 +0000 (GMT)
Received: from Mac.com (unknown [9.43.47.93])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 10:34:48 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/10] ppc-for-11.0 queue
Date: Mon, 12 Jan 2026 16:04:23 +0530
Message-ID: <20260112103433.8451-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEyMDA4MSBTYWx0ZWRfX8w+tid9pDSXf
 LQc9TSanyNdpry8WolG3Zk1zatq9bHstQ1tPiaK07K2Wj0mxTLUsouQP+Ev05ev3YbiAO+WY4zP
 hqk71kBJ0Y6wiKbXnlO3Y20FtPAW+gVcdjQ8DOWgrMqPy9AL5r0ft50fn63xRcM/eKMQjWkrj5A
 THd5kfZpEvm6q+vdBNj8gN+VqpXUsG2EKHl9EDfU4NYlh9de/nY/Ys1s3ZtPuuBS4IC6lwLSEF3
 My+coajR1DVYwzJRt+NBLXRqYZqiKbYKHU/48DmsLBrjOyx3roFcOQeijQVLg4PVZ3qRDg29v4q
 iSSv76DsXndo2alI12W/bF7qRRCxRcOCxC4dJlDV3Cg6XBnXhtsGU8tv0KrV3Vw4lE9q2iPA2pf
 CtcN1Fo/odwIxT+6TK1AGCibN3bDBzKVS5Yp94KAULeqE/h7DHMxSJ1EXrUHeNPLUElKMqd9mEQ
 3mrFgxDsmadqU0Zkd0Q==
X-Proofpoint-GUID: v_fxvm0hgQiE5jHi2bXb92yfvPTiSx6W
X-Authority-Analysis: v=2.4 cv=WLJyn3sR c=1 sm=1 tr=0 ts=6964ce4b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=vUbySO9Y5rIA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8 a=y9vodQ7xxGY07D5UZ5oA:9
X-Proofpoint-ORIG-GUID: v_fxvm0hgQiE5jHi2bXb92yfvPTiSx6W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-12_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601120081
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit b254e486242466dad881fc2bbfa215f1b67cd30f:

  Merge tag 'pull-riscv-to-apply-20260109' of https://github.com/alistair23/qemu into staging (2026-01-10 10:31:57 +1100)

are available in the Git repository at:

  https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-11.0-20260112

for you to fetch changes up to f4e34d0fd56c25dd0c90722ed80a83a175160a6c:

  tests/functional: Add a OS level migration test for pseries (2026-01-12 15:34:04 +0530)

----------------------------------------------------------------
First PPC PR for 11.0

- Snapshot support for several ppc devices
- Migration fix and OS level migration test for pseries
- Minor code cleanups
-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEa4EM1tK+EPOIPSFCRUTplPnWj7sFAmlky2YACgkQRUTplPnW
j7vXUg/8Dx/nsygeDspmhlmvqEWjyXm3fjIGnyCtSZWSkDkhh1x+uc0khFLuG8in
1Ep2D4qkGDBrdv079WzDKJDhgH21gTApA92xUsJFof2LLgN+MZOgi2Im6wR+Prtr
EddB7jJ062fDDyMQWBdg+9jkl0+xuj+JE5JXPbXV0Fqu+t3rVJvn7c1b3uRXRrC9
hgiss0xgTpXdVGnVjsQYLr3+iJ5Qcd7+6UhtRzTgv7S02IJRjpVoHSayBnKmzG9r
eLqQMykyqU8drmQUruTk1nM2PRbaGTuRO+Swcld7SgqxOxxYIXD72f89B94kZKqM
qZKv/C03EP30wS7/zJMwWsIEuXKM/oUwXl4i5C5eRUIa637VjcFEhuj0fCd8qxmz
mUp6tVTYaGESpWUJA9TLZOkvLO9c4gumbTWa5valYeRWCLdXFQZgDg0wrwu7SL5M
vdzKdnTMozkkKIY0W2Gk5j6E6aHpcGvNxREGrtI1BEUGKtGVzPjMHZmYDormSLIz
lvgZj7JEncjkGv6uIYKMv1tT7Cbo2YxoGRWbx59PWpK9Ekl8307BMi2OtPYqZm7N
CKS0lK+OM8CUP7Ao4nwxzH+T6X+C88Ivjt31sS25ixdUK6+Wy8tCEK2XCwA8gxjH
QuBMDYMoAWgZ+mQITNy+HrqM1TBI8a4PiF9DjX2xj3sdyBd67F8=
=2zBL
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Caleb Schlossin (7):
      hw/ppc: Add VMSTATE information for LPC model
      hw/ppc: Add pnv_spi vmstate support
      hw/ppc: Add pnv_i2c vmstate support
      hw/ppc: pnv_adu.c added vmstate support
      hw/ppc: pnv_core.c add vmstate support
      hw/ppc: pnv_chiptod.c add vmstate support
      hw/ppc: Add VMSTATE information to PnvPsi

Fabiano Rosas (2):
      target/ppc: Fix env->quiesced migration
      tests/functional: Add a OS level migration test for pseries

Gautam Menghani (1):
      target/ppc/kvm : Use macro names instead of hardcoded constants as return values

 include/hw/ppc/pnv_chiptod.h             |  2 ++
 target/ppc/cpu.h                         |  1 +
 hw/ppc/pnv_adu.c                         | 12 +++++++
 hw/ppc/pnv_chiptod.c                     | 38 ++++++++++++++++++++
 hw/ppc/pnv_core.c                        | 22 ++++++++++++
 hw/ppc/pnv_i2c.c                         | 11 ++++++
 hw/ppc/pnv_lpc.c                         | 41 +++++++++++++++++++++
 hw/ppc/pnv_psi.c                         | 36 +++++++++++++++++--
 hw/ppc/spapr.c                           |  6 ++++
 hw/ssi/pnv_spi.c                         | 27 ++++++++++++++
 target/ppc/cpu_init.c                    |  7 ++++
 target/ppc/kvm.c                         | 18 +++++-----
 target/ppc/machine.c                     | 62 ++++++++++++++++++++++++++++++++
 tests/functional/ppc64/test_migration.py | 12 +++++++
 tests/functional/ppc64/test_pseries.py   | 35 ++++++++++++++++++
 15 files changed, 319 insertions(+), 11 deletions(-)

