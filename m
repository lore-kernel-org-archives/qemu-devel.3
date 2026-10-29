Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47A6606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=K984XN22
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMTed-000642-AQ; Thu, 29 Oct 2026 13:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1xMTec-00063m-3z; Thu, 29 Oct 2026 13:11:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1xMTeZ-0007xH-Ku; Thu, 29 Oct 2026 13:11:05 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGE4aw461006; Thu, 29 Oct 2026 17:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=L5Dz8iQ1POFYOdCFe6Dk42uWAQoC
 c68G5AxhB5ZhAQw=; b=K984XN22P9FrMRPriQ+Mefry8TMMYsCYQGDvXisAm5yp
 d1fvCzotKR4WXtMxXY/ot5E+S+RTB8Ok1wpwyNLDK3LsJ8ChivbJVUX7M4lr9l/v
 pv1IqturbTex9s/yNhxQJVDVzsds7N85OMTISuj+VsiTsHhktRn/DBt/K9DClexB
 JjunM1vNG49or9mSgyizpfOZRQE0jSQWJgL4DdMkIjjmE/la6GpsbEAkWC3Q+m6n
 60N40fEyrGouPNFg7KfBY7vrTHcMtq6HjXMVaz0mEcuk6TqnguhlD8aOAjJfc5LE
 WTvbKHMheN3iZsz3E5Ssuxjfx+P2bTKAvjRai81Tew==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmd7bndv-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:10:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TGYk203418668; Thu, 29 Oct 2026 17:10:56 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hk55pg0h7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 29 Oct 2026 17:10:56 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69THAsVJ25166460
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 29 Oct 2026 17:10:55 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D66FD58052;
 Thu, 29 Oct 2026 17:10:54 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50DAE58050;
 Thu, 29 Oct 2026 17:10:53 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 29 Oct 2026 17:10:53 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v7 RESEND 0/9] pnv/phb5: Update PHB4 to the latest PHB5 spec
Date: Thu, 29 Oct 2026 12:10:38 -0500
Message-ID: <20261029171047.3862430-1-saif.abrar@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6ae37e21 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=p0WdMEafAAAA:8
 a=VnNF1IyMAAAA:8 a=Qosnl9tieUNGtTUi4_YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA2NSBTYWx0ZWRfX2ASfhwCPJuT3
 gJZEf9eJWB+ggViOrcAtbc/8XhMYehzgeEJPCEb1UDZhfKE537oFY51mJJFZ4aSRAV0mwnDTimY
 GIGkGSzbtNy/mKjLcLbpS6eAe1IQrw3TtPKHZxi5rjXuIgDemVG+ogs76ow5aYgTvdplOiGpjtt
 s7Cgj0bTMZlYZQaEtqCSGNv9Ls/t44rNZO9RjWrJFFhidyJqTvPmnH9pJrdIF7orUl4UD/PnM+c
 CcN9lD30rjfsU0MiNyWP3OV8FMcwKeF3FVQqpy5OxlRlxH4hXdHEJcipF1xkMfX3IJopxnSxdvd
 MifYZcef6hVJFnajqbP3AnIyCowF8Ud36GryThw+m8JgBqxnLUfNw5EwpRh9E7qq5jQZ3NGiphG
 zsZfPIE9ph2TeBIgXrcxrwP3AAmmpmxJlNg5zzUShM4FFnBJyIUuOs5k2MkqqKq+qNd+al8yX6I
 QwFX90GXmiOpKK/6tPw==
X-Proofpoint-GUID: JpzTN1I8SpGO1TVooBZ6CjA06DPMjW-e
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA2NSBTYWx0ZWRfX8/8GTCmxVlHA
 MpqwPqT58qWnSw9xOcgnL6jTrRJLvpDAY5qHJnHwHhqtddbFSdTHjQ+xoAmTo2uIjM38ZCF2JEk
 ntW7I5JPl8gtlhpvWkeuM3iPSKkXtRQ=
X-Proofpoint-ORIG-GUID: z-FOlIcLhCgf5_xZGBZ1a5JpOVL8KYZC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290065
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,
This series updates the existing PHB4 model to the PHB5 spec.
Also, a new testbench for PHB5 model is added, that does XSCOM read/writes
to various registers of interest and verifies the values.

Thanking all the reviewers for their valuable comments!

Testing
========

1. Git tree for testing: https://gitlab.com/syedsaifabrar/qemu/tree/phb5v72

2. Gitlab pipeline: https://gitlab.com/syedsaifabrar/qemu/-/pipelines/3004770329

3. QEMU ppc64 functional tests:
        Ok:                15
        Fail:              0
        Skipped:           3


Changelog
==========

v7 -> v7 RESEND:
- Rebased to upstream commit 5624b266cdd513506fb333e9041778407b6d1ac4
- Resolved a merge conflict in PHB4 code.

v6 -> v7:
- Updates for clean-up related review comments
- Tested with GitLab CI https://gitlab.com/syedsaifabrar/qemu/-/pipelines/2850120733/

v5 -> v6:
- Separate reset and register read/write methods for PHB5.
- PHB4 and PHB5 specific reset values.
- Read/write logic for registers added to and removed in PHB5.

v4 -> v5:
- Rename qtest file and all methods to phb5.
- New file for common defitions "pnv-qtest-common.h"
- Initializing PnvPHB4Class members within class_init method.
- Updated IODA3 PCT table max size to 128, each with 2 entries.
- New macro for SCOM to PCBA address conversion.
- Using be16_to_cpu as required.

v3 -> v4:
- Variables declaration moved to the top of the method pnv_phb4_reg_read()
- Resolves the tsan build failure seen in
https://gitlab.com/mstredhat/qemu/-/jobs/13201554945

v2 -> v3:
- Added class size for PnvPHB4Class.
- Updates for coding guidelines.

v1 -> v2:
- Added version check for PHB3 and PHB4 also.
- Using the ResettableClass.
- Reset of the root complex registers done in pnv_phb_root_port_reset_hold().
- New PnvPHB4Class to hold each register's RO mask.
- Introduced method pnv_phb4_xsrc_reset().

v1:
- Implemented sticky reset logic
- Implemented read-only, write-only, W1C and WxC logic
- Return all 1's on read to unimplemented registers
- Update PCIE registers for link status, speed and width
- Implement IODA PCT debug table without any functionality
- Set write-mask bits for PCIE Link-Control-2 register that is read/written by PHB4
- Update LSI Source-ID register based on small/big PHB number of interrupts
- New testbench for PHB4 model is added that does XSCOM read/writes to various registers of interest and verifies the values.

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Regards.

Saif Abrar (9):
  qtest/phb5: Add testbench for PHB
  pnv/phb5: Add reset logic to PHB5
  pnv/phb5: Implement sticky reset logic in PHB5
  pnv/phb5: Implement read-only and write-only bits of registers
  pnv/phb5: Implement write-clear and return 1's on unimplemented reg
    read
  pnv/phb5: Set link-active status in HPSTAT and LMR registers
  pnv/phb5: Set link speed and width in the DLP training control
    register
  pnv/phb5: Implement IODA PCT table
  pnv/phb5: Mask off LSI Source-ID based on number of interrupts

 hw/pci-host/pnv_phb.c               |  20 +-
 hw/pci-host/pnv_phb4.c              | 538 +++++++++++++++++++++++++---
 hw/pci-host/pnv_phb4_pec.c          |   2 +-
 hw/pci-host/pnv_phb5.c              | 197 +++++++++-
 hw/pci-host/pnv_phb5_pec.c          |   1 +
 hw/ppc/pnv.c                        |   1 +
 include/hw/pci-host/pnv_phb4.h      |  43 ++-
 include/hw/pci-host/pnv_phb4_regs.h |  58 ++-
 include/hw/pci-host/pnv_phb5.h      |  52 +++
 tests/qtest/meson.build             |   1 +
 tests/qtest/pnv-host-i2c-test.c     |  13 +-
 tests/qtest/pnv-phb-test.c          | 236 ++++++++++++
 tests/qtest/pnv-qtest-common.h      |  24 ++
 tests/qtest/pnv-xive2-common.h      |   7 +-
 14 files changed, 1089 insertions(+), 104 deletions(-)
 create mode 100644 include/hw/pci-host/pnv_phb5.h
 create mode 100644 tests/qtest/pnv-phb-test.c
 create mode 100644 tests/qtest/pnv-qtest-common.h

-- 
2.52.0


