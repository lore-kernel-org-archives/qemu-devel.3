Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA9B606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 03:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QzU+wCoc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNj7b-0001UV-0I; Sun, 01 Nov 2026 22:54:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xNj7Z-0001U2-Mu; Sun, 01 Nov 2026 22:54:09 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uverma@linux.ibm.com>)
 id 1xNj7Y-0002pt-0r; Sun, 01 Nov 2026 22:54:09 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A20iCon317224; Mon, 2 Nov 2026 03:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=BcS9mqsgMHv9rLI8uwZnoenPxh/Y
 5S4t6BsSyqrW/2Y=; b=QzU+wCocNd3w2hNTlBg8VHd8FXDEGZislFNkiZSF44zr
 lkA222KT4+KCLsQEQoW+OU/NnjLIxr2bCDBa9VqlFAZ1JGhHEBFr4P25tU2etewe
 8zCjojQDzMrv8ECBBNjP6DM7iRjr2wW94mdTZrLiLDv2x5cVMEh5Zk0xDD7+nLVi
 Sg/nNbybRKT/I+sHlinGofvyog285BEXTgv4HuX5EOLo2J0IpEoLdz7mG9vBwFtK
 GC9+8wM8t+9sTWzXJ+13/TcEOMUa+hKsoMU2ELtRzB9Nj/Jomq3MiC0/SamSzUCk
 COnqnf+YExkPRdXWgA9/TofWUEXF7aN0CWGx5XEhAQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rcxjm4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 03:54:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A20KCPT034910; Mon, 2 Nov 2026 03:54:02 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnunjv0xt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 02 Nov 2026 03:54:02 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6A23s0rL32703074
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 2 Nov 2026 03:54:00 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C7E15805E;
 Mon,  2 Nov 2026 03:54:00 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7514E58052;
 Mon,  2 Nov 2026 03:53:54 +0000 (GMT)
Received: from li-bd0dea4c-2912-11b2-a85c-e84940f94d2e.ibmuc.com (unknown
 [9.43.104.91]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  2 Nov 2026 03:53:54 +0000 (GMT)
From: uverma@linux.ibm.com
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: npiggin@gmail.com, jishnuvw@linux.ibm.com, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, jsnow@redhat.com, farosas@suse.de,
 lvivier@redhat.com, pbonzini@redhat.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 aleksandr.mikhalitsyn@futurfusion.io, Utkarsh Verma <uverma@linux.ibm.com>
Subject: [PATCH v7 00/10] tests/qtest: pci and MSI-X fixes
Date: Mon,  2 Nov 2026 09:22:56 +0530
Message-ID: <20261102035306.2291147-1-uverma@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: am41UjLjC-hog1Ew7TUEp31IoVtQkcyQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAxNCBTYWx0ZWRfX9/8WWCIkN3nT
 eXvYqqlDDBPkrJE457mPnoHDun8VOJgsuFXmEIapARYxMPeQ44VjRDRgQPkvBI7JZhHehMmUP75
 U93WbvNtU3pro29hQW4msGJrM4bpX/JFSkVNUxKy67Snpi4kxbVp33fzxlfGpoWl/JasQBJScVK
 /+N2UWnDDZvV8SAbm/khfli4Xnw7r0FflnmCxMnSGNxCgugF62Nq9nXKDV9Us4uObjzaqBTT42X
 Bt/siI9j4r/uwxQ64AFXpGiOjEgGhDbVYdyvMgV0JKRYspWG52oKlgHEdOzFxiyIwvvwboM3PBg
 ZKfKN7SNCGO1zEe9NiUCqAEDttS7dzqxjAcb6hVvmn8lH31l3VoKddyVxbCv4WpxDG0ov0+EAGu
 LAzYVdyfjNBWohfUjVVPXAiROQfObDNj0iKR5xh7czEDgAKDyQ0sc4HMnUV3BFcJDbc6fyVD+tJ
 lzYHmTFB0T4G2hi5vew==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAxNCBTYWx0ZWRfX/gJlUFjTXj/e
 2uzca8obClWMRPdIaiWBozaedipyC9xRdMX0a+yhVpHaNEv5h5VGUc/g74pBuBpP2hTMdaXviXk
 SURvgGsZVryLXvNrOBL2woBUcYZT97g=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6ae8095a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=nC741_onCDcfFpK1ls8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: U-IC_e2pi2fKXnjJB9sHdwLJuYyM1pS3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020014
Received-SPF: pass client-ip=148.163.158.5; envelope-from=uverma@linux.ibm.com;
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Utkarsh Verma <uverma@linux.ibm.com>

This series fixes a number of issues in the pci and MSI-X qtest
infrastructure, and adds new functionality.

Nicholas Piggin is the original author of patches 1-3 and 5-10. Patch 4
is new in this version. This series takes Jishnu Warrier's v6 forward.

Changes since v6:
(https://lore.kernel.org/qemu-devel/20260817185539.376740-1-jishnuvw@linux.ibm.com/)

- Add patch 4: Fix endianness of NVMe queue structures in nvme-test.
- qpci_msix_test_interrupt(): Make msix_entry parameter to uint16_t to match
  other MSI-X helpers and validate it against qpci_msix_table_size() to catch
  uninitialized vectors instead of checking for != -1. (Patch 3/10)
- nvme-test migrate: use qpci_migrate_fixup() to carry the BAR mapping
  over to the destination device instead of unmapping the source BAR and
  mapping BAR0 again. (PATCH 7/10)

Nicholas Piggin (9):
  tests/qtest: Enforce zero for the "un-fired" msix message value
  tests/qtest: Fix virtio msix message endianness
  tests/qtest: Add libqos function for testing MSI-X interrupt status
  tests/qtest: Enable spapr dma with linear iommu
  tests/qtest/ahci: unmap pci bar before reusing device
  tests/qtest/libquos/pci: Add migration fixup helper for pci devices
  qtest/libqos/pci: Enforce balanced iomap/unmap
  qtest/libqos/pci: Fix qpci_msix_enable sharing bar0
  qtest/libqos/pci: Factor msix entry helpers into pci common code

Utkarsh Verma (1):
  tests/qtest/nvme-test: fix NVMe struct field endianness

 hw/ppc/spapr_iommu.c                   |  10 +-
 tests/qtest/ahci-test.c                |   7 +
 tests/qtest/e1000e-test.c              |  21 ---
 tests/qtest/igb-test.c                 |  21 ---
 tests/qtest/libqos/ahci.c              |  12 ++
 tests/qtest/libqos/ahci.h              |   2 +
 tests/qtest/libqos/generic-pcihost.c   |   1 -
 tests/qtest/libqos/pci-pc.c            |   3 -
 tests/qtest/libqos/pci-spapr.c         |   7 +-
 tests/qtest/libqos/pci.c               | 217 ++++++++++++++++++++++---
 tests/qtest/libqos/pci.h               |  21 ++-
 tests/qtest/libqos/virtio-pci-modern.c |  30 +---
 tests/qtest/libqos/virtio-pci.c        |  86 ++--------
 tests/qtest/nvme-test.c                |  39 ++---
 tests/qtest/vhost-user-blk-test.c      |   6 -
 tests/qtest/virtio-blk-test.c          |  12 --
 16 files changed, 280 insertions(+), 215 deletions(-)

-- 
2.55.0


