Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA677606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TRHeyu47
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLdjK-0000UF-O3; Tue, 27 Oct 2026 05:44:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1xLdjG-0000Oe-64; Tue, 27 Oct 2026 05:44:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1xLdjD-0001Ow-L0; Tue, 27 Oct 2026 05:44:25 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R5i7fu4071140; Tue, 27 Oct 2026 09:44:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=RHrThs8dCEbzaI/zYnUfo8lsIjE9
 cWJD3c47HDYaPW8=; b=TRHeyu47fi/VFohyaYlykBc8IyaPfttXt6vG0EIUlbHx
 3mgAzN/+FxL1tuKla7IK3BzalnRZW4gggLShYut2oH0lyU777tDeFK8jE44/QuwK
 Tp80vo/D1B1jxN3ac9vvcbrudmnOBYIYPue/YA6uO6HXz2YAO6MBjI9pDEW3TF5B
 gX0jArHwymhl0rvZgxh5YWPRW4+jtWnz7JA6ZatnaCuHIbNJBuK/20BbJldw624n
 /GS3BB65WT8MZW5DnWmTrJQNlGYGtwUfLi3I+sBQb2ozUMGZ/PL3PIeC7XRmPFRj
 Ge8LofvOICUeGIvGr1IR6W10rq3E2tzP7es4IBXQ/A==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmbsxnhj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 09:44:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R5YrsI3643708; Tue, 27 Oct 2026 09:44:12 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh80jj449-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 09:44:12 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69R9iBWG31457860
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Oct 2026 09:44:11 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 879CC58056;
 Tue, 27 Oct 2026 09:44:11 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 968B258052;
 Tue, 27 Oct 2026 09:44:10 +0000 (GMT)
Received: from gfwr526.rchland.ibm.com (unknown [9.10.239.119])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Oct 2026 09:44:10 +0000 (GMT)
From: Saif Abrar <saif.abrar@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: harshpb@linux.ibm.com, clg@kaod.org, npiggin@gmail.com,
 fbarrat@linux.ibm.com, mst@redhat.com, marcel.apfelbaum@gmail.com,
 cohuck@redhat.com, pbonzini@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, danielhb413@gmail.com, kowal@linux.ibm.com,
 chalapathi.v@linux.ibm.com, calebs@linux.ibm.com, milesg@linux.ibm.com,
 jishnuvw@linux.ibm.com, adityag@linux.ibm.com, amachhiw@linux.ibm.com
Subject: [PATCH v7 0/9] pnv/phb5: Update PHB4 to the latest PHB5 spec
Date: Tue, 27 Oct 2026 04:43:41 -0500
Message-ID: <20261027094350.3645085-1-saif.abrar@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAzOCBTYWx0ZWRfXzsBeIeViFRG5
 DfWFwMdztwnr5mhmqfbV0ihjstiQsjKFNBODhRARX3EwSmfjas8YjXpDZYVOCKVPanjEf14ADr/
 81SMqkVG2MzwukklMU90HiMJRGEOqL4mvv00F9XehQ/OzmzPISvoAHe6NnRl7Wxn6oZmU0pE5UH
 V8DoAj6EKbxlqhTG+ca1q7dBEvGu/f2SKzGYpXwAtQ2AFkuc9/F9WZbF/c8Cp3iMSKXuzKXJzcG
 GQLQ9CeLygDq6nB6ThiQb1N0W7EkBneJcI5UpSujYJ/YjFRBfjrfNUj1gAZKqMt+Fq/0EEko2QF
 nEl91fPvlDZDlCA0HCuocpo6Dwc+lRnvEKsL5kNGcYP5ftcgqypbix7uQqF9acdUYSRHnRDuQlh
 Kb9RDSClf7553TiSgZ94QZOy4yal2PfzfojHYqRwLqn2azpNxb3FlQ/IPBFlsAfXP41nBQw0qvN
 5vObriu23p3/0cEomgA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAzOCBTYWx0ZWRfX3Kv+BAEO0iqv
 DrpehKdPpnc37F2vz7EVJBIk8lSv4u+UPOaTOG1C7SKjKnnSlytXPPTy4kMNyXAv78+ryGVfutH
 NsjQrafuKeZ0Dyf7kFsB1ZGJffLGASE=
X-Proofpoint-ORIG-GUID: XN73SfyLIn7k4sn7ScupDhGj6ZIEdHpL
X-Proofpoint-GUID: wMbqMzeO-OD8pH5JkxwX7ES1iBhb33zr
X-Authority-Analysis: v=2.4 cv=CeKdd7rl c=1 sm=1 tr=0 ts=6ae0726e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=p0WdMEafAAAA:8 a=_ELLP2wDCUlohOkaFtgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 malwarescore=0 phishscore=0 clxscore=1011
 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270038
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=saif.abrar@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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
This patchset resolves the cleanup related review comments for v6:
https://lore.kernel.org/qemu-devel/20260831123005.1485518-1-saif.abrar@linux.ibm.com/

Tested with 'make check' and 'make check-functional-ppc64',
and GitLab CI
https://gitlab.com/syedsaifabrar/qemu/-/pipelines/2850120733/

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


