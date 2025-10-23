Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB70CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 12:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBuGL-0001Ja-Vz; Thu, 23 Oct 2025 08:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuFr-0000uV-Mr
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:17:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBuFp-0006OJ-52
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 08:17:19 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N2124b027635
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=AH6f+QHYzACZOrv2G/umBWx+vX+e
 IP3SYe/93iZddz4=; b=Gz+jNKQvwAYQlgoThbxWONDoYckQ2zmyu2Ac1zEduoqn
 F9jXGSZmGOhiedWlnSZ9aBzaOo2PdJocL3O+9QbOzWFtswbHowuWtDE76t9z2e7S
 Xj+4uMjzK5hXPncTh5Tem0fKidwV3ZayA5KZiithd24hVNnXDN2Mks1h6QNXYmAT
 xOD7pmTsM/jvvCDBA27t1EezmfnsrKMK75a+5ft+EJjsAfEFNV8YiePNzwiW5fFk
 Wp+CRj2Ogi0qBawdoTgZX69Blv/ZacBa71dHQL90qQYKGjBA5dVeAyjk4CKyDuzO
 hX04HofSFhSwdNCsYU413zeZC0t6+cEx796KUCDa8g==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fj243-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N9J2EA014676
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7sdtrx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:02 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NCH06E56099316
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7333020043
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:17:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E297220040
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:16:59 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 12:16:59 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL RESEND 00/32] ppc-for-10.2 queue
Date: Thu, 23 Oct 2025 17:46:19 +0530
Message-ID: <20251023121653.3686015-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68fa1ccb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=p0WdMEafAAAA:8
 a=cNqUCJnAJEEDHSxotCYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=oH34dK2VZjykjzsv8OSz:22 a=poXaRoVlC6wW9_mwW8W4:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=QOGEsqRv6VhmHaoFNykA:22
X-Proofpoint-GUID: fCNeSCVGPqsPIgLkcCuHu_nPjISKYrgC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX0WkNFqGJsO1d
 2H2k0hrRNtTsVr26Pxj93zJX7fnbcoE1wGCjc5xecMBedsUKjy6jqBPDQbLMWPyA7g9jxebKUbp
 azb3g3SfVyfxkY9+cnv5bALaWUaD941MGCMIBsHDTq5bXqf5M3eqbzahq/UuIfWSyIJ77pUpEMB
 AuAONojD7ZDmXiDEfRru4owh0yvGvwS3AWXNtNmwte3hWy135mDbo/ZWVnUyWowY05OboTGmeNZ
 Bg1X92mu72+GYYx2qtNOMRQw5D/98fvTDR0aL+dxYyxaEuOofJOSHus7u1dxr4WL234mryirvda
 jl9scWnwlpPmtqE/KlhRICXsQT815YoVnoG0mZNMwZZvB9/y2CzuHHTwyQxMr9Tmf2XvrxF+SVe
 QRDOiAp4E6DdqzOIqazt1VQqch5iZw==
X-Proofpoint-ORIG-GUID: fCNeSCVGPqsPIgLkcCuHu_nPjISKYrgC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit c0e80879c876cbe4cbde43a92403329bcedf2ba0:

  Merge tag 'pull-vfio-20251022' of https://github.com/legoater/qemu into staging (2025-10-22 08:01:21 -0500)

are available in the Git repository at:

  https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-10.2-d2-20251023-1

for you to fetch changes up to 3db841bf1194b2720a08df2ee0a6ca517091ad0e:

  MAINTAINERS: Add entry for FADump (pSeries) (2025-10-23 17:37:42 +0530)

----------------------------------------------------------------
ppc queue for 10.2

* FADUMP Support for pSeries
* Pegasos II cleanup and Pegasos I emulation
* Deprecation of pseries 3.0 up till 4.2
* Coverity fix for amigaone (CID: 1641398)

----------------------------------------------------------------
Aditya Gupta (8):
      hw/ppc: Implement fadump register command
      hw/ppc: Trigger Fadump boot if fadump is registered
      hw/ppc: Preserve memory regions registered for fadump
      hw/ppc: Implement saving CPU state in Fadump
      hw/ppc: Pass dump-sizes property for fadump in device tree
      hw/ppc: Enable fadump for PSeries
      tests/functional: Add test for fadump in PSeries
      MAINTAINERS: Add entry for FADump (pSeries)

BALATON Zoltan (13):
      ppc/amigaone: Free allocated struct
      ppc/vof: Make nextprop behave more like Open Firmware
      hw/ppc/pegasos2: Remove explicit name properties from device tree
      hw/ppc/pegasos2: Change device tree generation
      hw/ppc/pegasos2: Remove fdt pointer from machine state
      hw/ppc/pegasos2: Rename mv field in machine state
      hw/ppc/pegasos2: Add south bridge pointer in the machine state
      hw/ppc/pegasos2: Move PCI IRQ routing setup to a function
      hw/ppc/pegasos2: Move hardware specific parts out of machine reset
      hw/ppc/pegasos2: Introduce abstract superclass
      hw/ppc/pegasos2: Add bus frequency to machine state
      hw/ppc/pegasos2: Add Pegasos I emulation
      hw/ppc/pegasos2: Add VOF support for pegasos1

Harsh Prateek Bora (5):
      ppc/spapr: remove deprecated machine pseries-3.0
      ppc/spapr: remove deprecated machine pseries-3.1
      ppc/spapr: remove deprecated machine pseries-4.0
      ppc/spapr: remove deprecated machine pseries-4.1
      ppc/spapr: remove deprecated machine pseries-4.2

Philippe Mathieu-Daudé (6):
      hw/ppc/spapr: Remove SpaprMachineClass::nr_xirqs field
      hw/ppc/spapr: Inline spapr_dtb_needed()
      hw/ppc/spapr: Inline few SPAPR_IRQ_* uses
      target/ppc/kvm: Remove kvmppc_get_host_serial() as unused
      target/ppc/kvm: Remove kvmppc_get_host_model() as unused
      hw/ppc/spapr: Remove SpaprMachineClass::phb_placement callback

 MAINTAINERS                               |   9 +
 include/hw/ppc/spapr.h                    |  27 +-
 include/hw/ppc/spapr_fadump.h             | 124 +++++
 include/hw/ppc/spapr_irq.h                |   1 -
 target/ppc/kvm_ppc.h                      |  12 -
 hw/ppc/amigaone.c                         |   2 +-
 hw/ppc/pegasos2.c                         | 769 +++++++++++++++---------------
 hw/ppc/spapr.c                            | 368 +++++---------
 hw/ppc/spapr_caps.c                       |  12 +-
 hw/ppc/spapr_events.c                     |  20 +-
 hw/ppc/spapr_fadump.c                     | 730 ++++++++++++++++++++++++++++
 hw/ppc/spapr_hcall.c                      |   5 -
 hw/ppc/spapr_irq.c                        |  36 +-
 hw/ppc/spapr_pci.c                        |  32 +-
 hw/ppc/spapr_rtas.c                       |  76 +++
 hw/ppc/spapr_vio.c                        |   9 -
 hw/ppc/vof.c                              |  50 +-
 target/ppc/kvm.c                          |  11 -
 hw/ppc/meson.build                        |   1 +
 pc-bios/dtb/meson.build                   |   2 +
 pc-bios/dtb/pegasos1.dtb                  | Bin 0 -> 857 bytes
 pc-bios/dtb/pegasos1.dts                  | 125 +++++
 pc-bios/dtb/pegasos2.dtb                  | Bin 0 -> 1701 bytes
 pc-bios/dtb/pegasos2.dts                  | 167 +++++++
 tests/functional/ppc64/meson.build        |   2 +
 tests/functional/ppc64/test_fadump.py     | 182 +++++++
 tests/functional/qemu_test/linuxkernel.py |  59 +++
 27 files changed, 2042 insertions(+), 789 deletions(-)
 create mode 100644 include/hw/ppc/spapr_fadump.h
 create mode 100644 hw/ppc/spapr_fadump.c
 create mode 100644 pc-bios/dtb/pegasos1.dtb
 create mode 100644 pc-bios/dtb/pegasos1.dts
 create mode 100644 pc-bios/dtb/pegasos2.dtb
 create mode 100644 pc-bios/dtb/pegasos2.dts
 create mode 100755 tests/functional/ppc64/test_fadump.py

