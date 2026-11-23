Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BEA606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=o5RWMYz+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVPDy-0007fe-D6; Mon, 23 Nov 2026 03:16:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1xVPDv-0007fH-44; Mon, 23 Nov 2026 03:16:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1xVPDt-0008MM-9c; Mon, 23 Nov 2026 03:16:26 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AN558Vq2634291; Mon, 23 Nov 2026 08:16:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=7GOsM3P8lLIw14ZIkOr/3K4718vqnYuXeQ/p5ctHB
 2E=; b=o5RWMYz+KS4DOX7qwDIPaHj3ZcO6RTf3e+M46EzL9onBUw5uiQGn2rbAC
 4y3JWpQU3KoPpVm8F5cDK8+8eHePo4Nh0ix7Z7xss796U2ORlij/d8xwy6gyxUkW
 R4mjAKuACHSC/qN6jdNvZ45PoYGbmdqaVKJEfL3Saq1G1IQFmBhnwb8km5DSTwf7
 7oY0fancSyoe53tp+8f+xGCnqAr0f3i0e3Vd/tLNHmGc+LNUk2WGSxzLTYWqTHZD
 H8XsNrYqscJ2l1XXahapA0KdgicWXWZS46l1pk9+B+lRQODzZVJVefPQB6f0ZTXm
 ecf1vyvZaSwCMXH70eshPzr1DYVFQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g11v7v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 23 Nov 2026 08:16:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AN54Gw02817223; Mon, 23 Nov 2026 08:16:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3pmjwws6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Nov 2026 08:16:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AN8GHFe49086886
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Nov 2026 08:16:17 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E39B92004D;
 Mon, 23 Nov 2026 08:16:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6655220049;
 Mon, 23 Nov 2026 08:16:14 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.bl1-in.ibm.com (unknown [9.123.4.64])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Nov 2026 08:16:14 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sbhat@linux.ibm.com,
 mahesh@linux.ibm.com, sourabhjain@linux.ibm.com, adityag@linux.ibm.com,
 npiggin@gmail.com, harshpb@linux.ibm.com, alex@shazbot.org, clg@redhat.com
Cc: amachhiw@linux.ibm.com, hbathini@linux.ibm.com, shivangu@linux.ibm.com,
 anushree.mathur@linux.ibm.com
Subject: [PATCH v3 0/2] ppc/spapr: Fix MSI-X shadow and BAR mmap handling
 during EEH PE reset
Date: Mon, 23 Nov 2026 13:45:47 +0530
Message-ID: <20261123081546.49210-4-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: LuJCdhPabOVAaMClcAKMCHfvQBP0n43a
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDAzMiBTYWx0ZWRfXy5/raqTA0en+
 Svx2WVbiXtAXtT1gfjFYapS27O268Y6JGSKbLhEy4LR3AWCT3qwLC7giWI4LgmAowEtGc2VSVUk
 hqbeiLCGfhJD5zs51bt8JBwzMA9ik+4=
X-Proofpoint-GUID: bvhLmKDdEGJy0Rs6YjMHx3qH7I0xFzrD
X-Authority-Analysis: v=2.4 cv=c8M+0h9l c=1 sm=1 tr=0 ts=6b03f656 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=3REYezb3TOSOMFSrjX0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDAzMiBTYWx0ZWRfX1HCfAB5IYaX5
 UFJFYEMDEU34MxyopcOeU4d88uWCvsFHmplDLApMMDHr6CHKpCLYlLvRHmBceBpTnP6HQQQdacz
 6utfSLePsxADLJU6TgEIbk+M83helpG1l5ydKy+zXWjqAZcnBGHQOmnXkFT7WtX02+Vr1wjSsGO
 n4ByU7PvQx9v9xsWQOY0CrAjWgddHH7YjkSqstBkf04SXE36iV6mvod6f1Hk45QNOI0vw4DT2W9
 lrxrt2QLWDviXABMqSVRJizqF7kC12Fop4zFRGfcPpmM8MDKA4iF3MMkMom15xXBl/XPvLZF6RW
 i28RHmMYJaM3Zrhv+gq4pGRZMzE050jPQ82jClAG486hFUoGw46KVbKrQ0E1zpwp8AShiQbAku1
 DSJMCOHvBK+kROuLWie9l6OnU5NnLs1Ac39k9VTE9BxtrclB4Ug0KT/fTDytw2GmViGi148nY/V
 UD8/suoidVJjy4WPV7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_01,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230032
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes two independent but related problems in the sPAPR EEH
PE reset path for VFIO pass-through devices.

Patch 1 fixes MSI-X interrupt delivery after EEH recovery.  The existing
pre-reset path calls msix_reset(), which clears QEMU's MSI-X table shadow.
On pSeries, this shadow is populated through:

    ibm,change-msi
        -> spapr_msi_setmsg()
        -> msix_set_message()

and is not necessarily rebuilt before the guest restores MSI-X after an
EEH reset.

Instead of resetting the MSI-X state, disable MSI-X by clearing only the
Enable bit using QEMU's cached PCI configuration value and dispatch the
write through pci_host_config_write_common().  This lets VFIO tear down
the active vectors and KVM irqfd routes through vfio_msix_disable() while
preserving the MSI-X shadow needed when the guest later re-enables MSI-X.

Patch 2 handles BAR mmap access while the PE is undergoing an EEH reset.
BAR mmap access is disabled before issuing the hot or fundamental PE
reset and restored only after VFIO_EEH_PE_CONFIGURE completes
successfully.  During this interval BAR accesses fall back to the VFIO
region read/write path.

Following review feedback, the BAR mmap and INTx mmap timer handling are
now encapsulated in VFIO PCI helpers instead of accessing
VFIOPCIDevice internals directly from the pSeries code.  The pre-reset
helper cancels a pending INTx mmap re-enable timer and disables the BAR
mmap path after interrupt teardown.  The post-configure helper restores
the normal mmap/INTx timer policy after successful PE configuration.

Without the fixes, EEH recovery itself reports success for the
passed-through BCM5719/tg3 device, but the interface does not recover its
link:
<snip>
    EEH: Beginning: 'resume'
    PCI 0001:00:01.0#0001: EEH: Invoking tg3->resume()
    PCI 0001:00:01.0#0001: EEH: tg3 driver reports: 'none'
    EEH: Finished:'resume'
    EEH: Recovery successful.
</snip>
<snip>
    # ethtool enP1p0s1 | grep Link
            Link detected: no
</snip>

With the series applied, EEH recovery completes and the link subsequently
comes back:

<snip>
    EEH: Beginning: 'resume'
    PCI 0001:00:01.0#0001: EEH: Invoking tg3->resume()
    PCI 0001:00:01.0#0001: EEH: tg3 driver reports: 'none'
    EEH: Finished:'resume'
    EEH: Recovery successful.
    tg3 0001:00:01.0 enP1p0s1: Link is up at 1000 Mbps, full duplex
    tg3 0001:00:01.0 enP1p0s1: Flow control is on for TX and on for RX
</snip>
<snip>
    # ethtool enP1p0s1 | grep Link
            Link detected: yes
</snip>

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
Change log:
v2:
- Reworked the BAR mmap handling based on review feedback so that generic
  VFIO provides only the mmap mechanism and the pSeries code retains the
  EEH policy.
- Replaced the EEH-specific generic VFIO helpers
  `vfio_pci_eeh_pre_reset()` and `vfio_pci_eeh_post_configure()` with a
  neutral `vfio_pci_mmap_block()` helper.
- Added per-device `mmap_blocked` state in vfio-pci.  Once BAR mmap is
  blocked, later attempts to re-enable the mmap subregions, including
  those from INTx timer or interrupt-mode transitions, are ignored.
- Changed the BAR mmap handling from temporary disable/restore to a
  persistent block after an EEH PE reset.  In particular, BAR mmap is no
  longer restored after `VFIO_EEH_PE_CONFIGURE`.
- Removed the pSeries post-configure device/bus walkers that were added
  in v2 solely to restore BAR mmap.
- Moved the generic mmap-block implementation into patch 1/2 and kept
  the pSeries EEH use of that mechanism in patch 2/2.
- Block BAR mmap before changing MSI-X state during EEH reset
  preparation, so subsequent VFIO interrupt-mode activity cannot restore
  the direct mmap path.
- Retained the v2 MSI-X shadow preservation behavior: clear only
  `PCI_MSIX_FLAGS_ENABLE` through the normal PCI config-write path and
  do not call `msix_reset()`.
- Updated the BAR mmap recovery policy based on BCM5719 passthrough
  testing: restoring direct BAR mmap after PE configure could result in
  the device becoming inaccessible again during guest resume, while
  keeping BAR accesses on the VFIO region read/write path allowed the
  Guest-2 EEH recovery to complete and the device to remain functional.

v1:
- Move BAR mmap and INTx mmap timer handling into VFIO PCI helpers,
  as suggested by Mahesh.
- Avoid direct access to VFIOPCIDevice BAR and INTx internals from
  spapr_pci_vfio.c.
- Restore normal INTx mmap handling after successful PE configuration.
- Keep BAR mmap disabled when VFIO_EEH_PE_CONFIGURE fails.
- Keep the MSI-X shadow preservation behavior from patch 1 unchanged.
  v1: https://lore.kernel.org/qemu-devel/20260902114758.85160-1-nnmlinux@linux.ibm.com

Narayana Murty N (2):
  vfio/pci: Add persistent BAR mmap blocking helper
  ppc/spapr: Preserve VFIO MSI-X shadow and block BAR mmap on EEH reset

 hw/ppc/spapr_pci_vfio.c | 75 ++++++++++++++++++++++++++++-------------
 hw/vfio/pci.c           | 59 ++++++++++++++++++++++++++++++++
 hw/vfio/pci.h           |  7 ++++
 3 files changed, 117 insertions(+), 24 deletions(-)

-- 
2.54.0


