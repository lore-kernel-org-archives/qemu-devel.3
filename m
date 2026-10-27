Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8C0606A31F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aYf00Sy0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLjeM-0005zn-1Y; Tue, 27 Oct 2026 12:03:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1xLje5-0005tp-N2; Tue, 27 Oct 2026 12:03:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1xLjdz-0006TO-9C; Tue, 27 Oct 2026 12:03:26 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69REE8Os2676151; Tue, 27 Oct 2026 16:03:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=l/vaBzFBNOdjLjS6IudXxnDsZHATVXrOdEw+d1fLE
 aY=; b=aYf00Sy0kkVSywxpVHJbTV+RpFPaSBfbQ5NbLXit3TmfvR3lOrcTIEyV/
 zbcqY7CEC9D1iex/lP9BTXUHt/she0UjzRHu0uPg+lejCt4txj8gQTmXh4+xsQgK
 TOtVnNuQ2uwuj/rl2iEw1pO5hpf2oiVymt3RTzGXowTNvnFUQWD3CPTBdMKJ62Gx
 5r3YtGe5ZT7a+7QYX2lZdZksvpczz5jF+eXtr0gWNL9Pi3+6zYulFPqSp/RMcgRv
 03L6zzRRQ3JkeYPlr9t78daaZfTTX35gTgyVOuACIMWphJfxqKwGf+KQZBk2yzJ8
 rnOL2OklNXHH+QHj/lCEY9tYFcPoA==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmd70d5v-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 16:03:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDoSRO4190112; Tue, 27 Oct 2026 16:03:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hjtnn95f4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 27 Oct 2026 16:03:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69RG3C3U41812442
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 27 Oct 2026 16:03:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D7E4B2005A;
 Tue, 27 Oct 2026 16:03:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7648020040;
 Tue, 27 Oct 2026 16:03:09 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.124.222.107])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 27 Oct 2026 16:03:09 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sbhat@linux.ibm.com,
 mahesh@linux.ibm.com, sourabhjain@linux.ibm.com, adityag@linux.ibm.com,
 npiggin@gmail.com, harshpb@linux.ibm.com, alex@shazbot.org, clg@redhat.com
Cc: amachhiw@linux.ibm.com, hbathini@linux.ibm.com, shivangu@linux.ibm.com,
 anushree.mathur@linux.ibm.com
Subject: [PATCH v2 0/2] ppc/spapr: Fix MSI-X shadow and BAR mmap handling
 during EEH PE reset
Date: Tue, 27 Oct 2026 21:32:56 +0530
Message-ID: <20261027160258.48207-1-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6ae0cb46 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=qJJtpQYPg_07LgkBUwAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MiBTYWx0ZWRfX7VmrXbDrLUVg
 brhkLZNLqjT/1o/SSXJJa9XD9DPXvxXMqvSvDj8PiH4Rtbc/9qTrF+TPyRBJAkKi6cYxtXzqXIU
 T7Rfb8qtgYdvgOF8E/uD7k5FRF63H1jDeTkEX3Pd++NAqCsVyBz5MtXjXLIUoRPDYHRzfgc+vnQ
 Ca97g6wwb8bERW6AeT6zmUSjoO49dYcVxYKP2ctMTSJHXnfj9SVZI34al7ciFz0Y5nMWrH+6qIc
 QVAOi9sdJ8Uo2bCU4a2XJTVxO23y34mn2AAt+LSt3pCsjhSoAyulMJLNITy+LE8WL76t3LKFax7
 lHhjNbk7C9exOcEsnzJJ1R6bje/zU+bdQxdgPST7YY3bMUBp+0sysMla1t1WrN21mfhapo67xiA
 kP31n11MGYQD0DP6neXRnLyfGJmVnc6pcp3UZkl4b/EVUwK5mIDKMHx/+xL93jWPgq1GZ/9KLYu
 LqDHJ/4R9/QqQUQlTvA==
X-Proofpoint-GUID: ORML-jOPX_iZImpHIvpuaFNEM5VTR9DY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2MiBTYWx0ZWRfX0Dig3jGC4zZA
 s5apI6zP7eiClXg+EU7phSl/dFlt6+jUw/QmvGeuEmoHbAaPPRDxpP1BoSmnHfEbr1iLH7Jk8NQ
 7CmWickEEujyDeyecBWOpYkDI/WqGnA=
X-Proofpoint-ORIG-GUID: lG50lfGBW2jisoGpsIOjU9bz8gZde7qk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270062
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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
v1:
- Move BAR mmap and INTx mmap timer handling into VFIO PCI helpers,
  as suggested by Mahesh.
- Avoid direct access to VFIOPCIDevice BAR and INTx internals from
  spapr_pci_vfio.c.
- Restore normal INTx mmap handling after successful PE configuration.
- Keep BAR mmap disabled when VFIO_EEH_PE_CONFIGURE fails.
- Keep the MSI-X shadow preservation behavior from patch 1 unchanged.
  v1: https://lore.kernel.org/qemu-devel/20260902114758.85160-1-nnmlinux@linux.ibm.com/

Narayana Murty N (2):
  ppc/spapr: Preserve VFIO MSI-X shadow across EEH reset
  ppc/spapr: Disable VFIO BAR mmap during EEH PE reset

 hw/ppc/spapr_pci_vfio.c | 102 ++++++++++++++++++++++++++++++++--------
 hw/vfio/pci.c           |  32 +++++++++++++
 hw/vfio/pci.h           |   2 +
 3 files changed, 116 insertions(+), 20 deletions(-)

-- 
2.54.0


