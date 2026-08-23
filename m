Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D080EC5DF8C
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2026 07:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wy2kC-0002RR-Q0; Sun, 23 Aug 2026 03:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wy2kB-0002Qz-Bn
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 03:35:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wy2k9-0005le-K5
 for qemu-devel@nongnu.org; Sun, 23 Aug 2026 03:35:51 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67N72JLn2503264
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 07:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=/FuIezSzG6L3LeIjUJxcs3rEf8T+
 dUPykwf45viT2sA=; b=siXF2IoRF5ENNLCM/mezpFyajlsHVaoqckEkuLTj94rS
 UO0k2M3YVGwkz1z7kaP7tm9hIlqLuDKop+pqEusTzVyzD2xbc74q/E/WiqJ8bB9z
 vzOlWrBPfsRumnD9uuGbRy0d3cOoMuHosJYfIsAhjywW40llS+Bn+fn/H6ilBec9
 VlouXg9RKHt/Dvf9BvzhtRGcTblH14vMp45eMkWx+GodrE+BFIH5csqL1bJpYPgB
 BhkwXOvXrSE6lNNXUSy2wcPvM13UQhYwj6S1wxOzkXSyoyHpi3MLq1gxvzZvzZq2
 ipf6886F3p0nGXdve6XWeZQn/nfUUYnbPNMCHyUZag==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4c147-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 07:35:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67N7QGPC012306
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 07:35:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag0kub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 07:35:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67N7ZiJK51249564
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 07:35:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B61B120043
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 07:35:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E4D6120040
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 07:35:43 +0000 (GMT)
Received: from Mac.com (unknown [9.39.19.238])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 07:35:43 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/7] ppc-for-11.2 queue
Date: Sun, 23 Aug 2026 13:05:26 +0530
Message-ID: <20260823073536.40282-1-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WV5bvBWdvwSCDxaVnVwb0e3z7d394jIW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIzMDA2NiBTYWx0ZWRfX3lDaEzf0fkNG
 0AyY9aCVtd9ho4Zq0n18CvOWjjn8Sg0WlujnZgbawvCP9Kq+i32BwwYJd4pleJ2s1h3o0JV2KVY
 ORQkwOxwuUCwti9/K+Ytjgqv1TPjQFU=
X-Proofpoint-GUID: WV5bvBWdvwSCDxaVnVwb0e3z7d394jIW
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8aa2d3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=p0WdMEafAAAA:8 a=wJTs_X9a1zpoxQM4yDwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIzMDA2NiBTYWx0ZWRfXzGIycfFplmm4
 uOkBN20ayBWaWzpd/DENy5+6zda9TIU1FwyFyURPNtMwcIW/XPTv42gjLPND0tDMjwOft0N3Nw/
 eBByMPCsO7S+WGDG+U3Olt25MT9Ur8tMYZ58ynVSOzZ602cvKYKrjSjTqI3mt+nAFtY9jVtH6Bg
 2G2/K/dokHAqTbYuIyZrZCi4yZ5TXvl7F0N/51qhg92gNOryNbdINRvofQ9t/4dnBFhWrKCm1jD
 vRcJOwyCSTTeHKRtoZoR9vMRaGVpROPMN+nzggqiO0K3FxfVo1hDKa9IZFw0wc6bV6X/zfRLHJf
 wtLJvuGLenagE5vNkPkOG8ripMI/7b/+cwb3Al3Ckah6vFtbCDYlCBWLqxlbqOwIiF8xxEErwwU
 nIVMXtn6oSS3fd5MPHbfG9X0vudfVogtRncfhEWJxKjspmp46QNuiUsR/AHJukRrJKEmhIu+3hj
 Jw0H+pC5x2M9ehVXBuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-23_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608230066
Received-SPF: pass client-ip=148.163.156.1; envelope-from=harshpb@linux.ibm.com;
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit eea8fe61b8be8f3016e522e6af24924a0266ca95:

  Merge tag 'igvm-20260821-pull-request' of https://gitlab.com/kraxel/qemu into staging (2026-08-21 10:39:31 -0700)

are available in the Git repository at:

  https://gitlab.com/harshpb/qemu.git tags/pull-ppc-for-11.2-20260823

for you to fetch changes up to 45caf67b9a6a446629e1c133b76a3d9a3cebdcf1:

  MAINTAINERS: add self as reviewer for PowerPC RAS (2026-08-23 11:42:57 +0530)

----------------------------------------------------------------
PPC PR for 11.2 - 20260823

* powernv: boot OpenBSD on POWER9
* Misc fixes in target/ppc and spapr_watchdog
* MAINTAINERS: adding reviewers - Amit (PPC KVM, sPAPR) and Shivang (PPC RAS)

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEa4EM1tK+EPOIPSFCRUTplPnWj7sFAmqKlQcACgkQRUTplPnW
j7tgEw//anSKG8cNMcauqfv9kB4buOdtGPLZS7QjO35JPYD6bI8Z+DvPMSJKi+xP
3GcjT3rZbzCI0OsbAzw5OmSCZzsY/Cgr+1FrlJcC49jOEHC4VklD7tVV6dH5MS1j
CUZlxd5TQrf49URitZcaOcQWHNxrr1WjDhGxmdz0VnV4nJF4QQMyACRM6e+KpgXN
0qLGfuHF77N79g+ttf1psI+VYESk8kMg48rQDDBqlF1y27D1GEMdsNqq8lhvzvZc
tLUiui3xvhXPRqUTE6AcvGrpCfdkoiAsR/R6i0kdu+HrQ10CcRHTXCyYpPjBj2wg
bo7erO4jQBHroIXXkAJ8EJzOTNMmaBtHuXjMZYgCHO9pYMGgHzp3yXvqyC9k3F/c
dlOgrdw6mC7K+3b4REHeG8kaYRtIFi8vbENGQNSMyEDZswvU+obwKZWz24nmOvvl
A6QP2C6/gAraodcoDMaJ9pYhU6/5ynGhbcrfjzqiGN1z/pmXIiXffW342oLciWa/
/yAMCiHhH9k7aBULm27JqcCWOiotk/Xv9J1/TlLfcs6h3YuMlVGl6V4zMvctufYO
XqqP/iJqbj3djdYQLGUEdEG1Yh2LItO9KYu5F00jET1fE8DW6NS9ceUe4A6oma8f
nMv3ErfxAbVkr5rN/vibo35yG2O26ApwW8oQDM0NzlesklsMHd0=
=vkyg
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Amit Machhiwal (1):
      MAINTAINERS: Add myself as a reviewer for PPC KVM and sPAPR

Chinmay Rath (1):
      hw/watchdog: Add lower bound check for watchdogNumber

Kirill A. Korinsky (1):
      powernv: boot OpenBSD on POWER9

Minhang Zhang (1):
      target/ppc: Validate HTABMASK and reserved bits in SDR1 for 32-bit mode

Pierrick Bouvier (1):
      target/ppc/cpu_init: make cpu listing deterministic

Shivang Upadhyay (2):
      MAINTAINERS: add dedicated PowerPC RAS section
      MAINTAINERS: add self as reviewer for PowerPC RAS

 MAINTAINERS                            | 35 ++++++++++++-----------
 hw/ppc/pnv_psi.c                       | 11 +++++--
 hw/watchdog/spapr_watchdog.c           | 16 +++++++----
 target/ppc/cpu_init.c                  |  2 +-
 target/ppc/mmu-book3s-v3.c             | 21 +++++++++++---
 target/ppc/mmu_common.c                | 25 ++++++++++++----
 tests/functional/ppc64/meson.build     |  2 ++
 tests/functional/ppc64/test_openbsd.py | 52 ++++++++++++++++++++++++++++++++++
 8 files changed, 129 insertions(+), 35 deletions(-)
 create mode 100755 tests/functional/ppc64/test_openbsd.py

