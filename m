Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32551CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 17:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWdor-0001q4-7P; Mon, 08 Jun 2026 13:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1wWdop-0001ps-TS; Mon, 08 Jun 2026 13:31:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1wWdon-0001tM-N7; Mon, 08 Jun 2026 13:31:23 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 658D3Yq62813091; Mon, 8 Jun 2026 17:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1mu+pB
 xNy/YdBEpWGoSwHu4fnap+Pe85YrlfkAp//RM=; b=T+XGOMt2cykdp66Vpw/XLl
 Gws9066/x+qqD7xFnyGsAP1d+BxPfO5AUyI0q6AIifeBMNkmJ34TQ6PGFBJrkPVQ
 EoY6K5y/DWIaKKFHNRsy0zFaEH+1Bc7d5mKq8j64xH0BicO2Gi+gOillElexEVhS
 CDZKppw4e7+B5NAp71k5S8nE2ZcdgQ0l+XdIoM8FsBWxAJva+Hpp2ePuDhEk5x0L
 IYidw1TXLOBwqS9wPMYuEDq2tVsEENFQ+jgWlNd5Byv70ecCdjjArlI3A2sRFjDf
 NV+dXvLZLjnkpdpTYPoFrGrnPTUS9NhTHB4+u0I1sXaTT2YiuswWpo23M+lRmtfA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb958gaa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 17:31:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 658H4fn1003217;
 Mon, 8 Jun 2026 17:31:14 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jy654a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 08 Jun 2026 17:31:14 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 658HVDNU11207246
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 8 Jun 2026 17:31:13 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 605C358054;
 Mon,  8 Jun 2026 17:31:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 381C85805C;
 Mon,  8 Jun 2026 17:31:09 +0000 (GMT)
Received: from [9.61.246.235] (unknown [9.61.246.235])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  8 Jun 2026 17:31:08 +0000 (GMT)
Message-ID: <c705eb45-18d9-4239-8e99-b964048f946c@linux.ibm.com>
Date: Mon, 8 Jun 2026 23:01:07 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] ppc/spapr: Add RTAS error injection support for
 VFIO EEH
To: Narayana Murty N <nnmlinux@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, mahesh@linux.ibm.com,
 ganeshgr@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com, clg@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@linaro.org
References: <20260520095446.64206-1-nnmlinux@linux.ibm.com>
Content-Language: en-US
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
In-Reply-To: <20260520095446.64206-1-nnmlinux@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a26fc64 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=mQcMlHRJ_0SQdqnm09cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ZOmfXlFQNcuwOrhBzruzuZGorjc7tloN
X-Proofpoint-GUID: A3Ym6viybL1ImjzhXCjthy1cqVJToya-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE2MiBTYWx0ZWRfX5LvnEtKHme6c
 sPRHv0gTPGn05oFrGugPyd8hrHBsgRdOrulCNPRoDtGI93AVpvpXDHKM9fdWgwG4DPW2r3x7YJ8
 kLNpaW/nxf1FhvAmAAo0bmchI+1xEQb6iFCOEeZEV1f3FsDe/OENx+rwY1z/QokR/fXQC6T6VmW
 pIrtXeKuySfzFrPTorvBzq9HObdMKzkGpdHZPpRZtbY/BuTRUh9xbbu3JQhD9R0EDH7A+TOf96P
 eJUxaex6QMg9kdzdulV4My9XSm6+PtF9FnUWDYavdGniB6DNWCI7ctClsfN/s/Y55O7eEIdwlBh
 n05HrKagxwYr8iIgtODKJkwnEkZOJoSNM9CfbU2XWF8o3+Rtm9przMuTCYoKT1G0b81NkhKI4Oe
 OHR8VivkJu+OErWkBu6sMltmgZN2K83nal5Pli2HEpuR/aSg98UbZs2YDxIcQMjvUamdYrBLs+b
 Folbelnx2vWrrsH1fyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1011 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080162
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=anushree.mathur@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

Hi Narayana,
I tested this patch and saw a qemu crash just after triggering error 
injection on guest after applying the patch series.
Here is my full analysis:

1) Started the guest
2) Attached an NVME backplane device to the guest.
3) Triggered the error injection on guest console for the attached NVME 
device.

It came to the following message and the guest crashed:

Injecting an ioa-bus-error...

Following is the qemu logs after crash:


2026-06-08T06:25:16.420015Z qemu-system-ppc64: warning: kernel_irqchip 
allowed but unavailable: IRQ_XIVE capability must be present for KVM
Falling back to kernel-irqchip=off
2026-06-08T06:25:16.495864Z RTAS: Read 236 bytes from device-tree
2026-06-08T06:28:43.769276Z qemu-system-ppc64: 0213:60:00.0 BAR 0: 
failed to create dma-buf: PCI BAR IOMMU mappings may fail: Invalid argument
2026-06-08T13:21:00.218278Z RTAS: Read 236 bytes from device-tree
2026-06-08T13:21:05.658991Z qemu-system-ppc64: warning: kernel_irqchip 
allowed but unavailable: IRQ_XIVE capability must be present for KVM
Falling back to kernel-irqchip=off
2026-06-08T13:21:05.794879Z RTAS: Read 236 bytes from device-tree
2026-06-08T13:41:59.736480Z RTAS: Read 236 bytes from device-tree
2026-06-08T13:42:13.712991Z qemu-system-ppc64: warning: kernel_irqchip 
allowed but unavailable: IRQ_XIVE capability must be present for KVM
Falling back to kernel-irqchip=off
2026-06-08T13:42:13.848406Z RTAS: Read 236 bytes from device-tree
2026-06-08T14:24:42.012714Z qemu-system-ppc64: 0213:60:00.0 BAR 0: 
failed to create dma-buf: PCI BAR IOMMU mappings may fail: Invalid argument
2026-06-08 14:34:09.570+0000: shutting down, reason=crashed


Thank you,
Anushree Mathur

On 20/05/26 3:24 PM, Narayana Murty N wrote:
> This patch series implements comprehensive RTAS-based error injection
> support for VFIO EEH (Enhanced Error Handling) on PowerPC sPAPR platforms.
> The implementation enables guest-initiated PCI error injection for improved
> testing and diagnostics of EEH recovery mechanisms.
>
> Background
> ----------
> EEH is a critical feature on PowerPC platforms that provides error detection,
> isolation, and recovery for PCI devices. Testing EEH recovery paths requires
> the ability to inject various types of errors into the system. While physical
> hardware supports error injection through firmware interfaces, QEMU's VFIO
> implementation previously lacked this capability.
>
> This series bridges that gap by implementing the IBM RTAS error injection
> interface, allowing guests to inject PCI errors through the same firmware
> calls used on physical hardware. This enables comprehensive testing of device
> drivers' EEH recovery code paths in virtualized environments.
>
> Implementation Overview
> -----------------------
> The patch series introduces three new RTAS calls:
>    - ibm,open-errinjct:  Opens an error injection session
>    - ibm,errinjct:       Injects a specific error type
>    - ibm,close-errinjct: Closes the error injection session
>
> The implementation supports multiple error types including:
>    - IOA bus errors (32-bit and 64-bit addressing)
>    - Memory/IO/Config space load/store errors
>    - DMA read/write errors
>    - Cache and TLB corruption scenarios
>    - Special recovery events
>
> Tesed on pseries and powernv hosts on kvm guest with errinjct tool.
>
> Patch Organization
> ------------------
> Patch 1: Adds the VFIO backend for error injection
> Patch 2: Implements the ibm,errinjct RTAS call handler
> Patch 3: Adds session management (open/close) RTAS calls
> Patch 4: Advertises capabilities via device tree properties
> Patch 5: Refactors EEH specific code/stubs to new files.
> Patch 6: Updates MAINTAINERS file
>
> Changelog:
> ----------
> v3:
>    - Fixed the build failure reported at https://github.com/p-b-o/qemu-ci/actions/runs/26094993976
>    - Also fixed a gitlab CI breakage in patch 2 (qemu_log_mask LOG_UNIMP)
> v2: Addressed refactor suggestions from Cedric, Pierrick
> v1: https://lore.kernel.org/all/20260512071112.9675-1-nnmlinux@linux.ibm.com/
>
>
> Narayana Murty N (6):
>    ppc/spapr: Add VFIO EEH error injection backend
>    ppc/spapr: Add ibm,errinjct RTAS call handler
>    ppc/spapr: Add support for 'ibm, open-errinjct' and 'ibm,
>      close-errinjct'
>    ppc/spapr: Advertise RTAS error injection call support via FDT
>      property
>    ppc/spapr: Split VFIO code and refactor EEH interface
>    MAINTAINERS: Add entry for sPAPR PCI VFIO EEH support
>
>   MAINTAINERS                  |   6 +
>   hw/ppc/Kconfig               |   2 +-
>   hw/ppc/meson.build           |   1 +
>   hw/ppc/spapr.c               | 104 +++++++++++
>   hw/ppc/spapr_pci.c           | 219 ++++++++++++++++++++++
>   hw/ppc/spapr_pci_vfio.c      | 314 +------------------------------
>   hw/ppc/spapr_pci_vfio_eeh.c  | 346 +++++++++++++++++++++++++++++++++++
>   include/hw/pci-host/spapr.h  |  37 +---
>   include/hw/ppc/spapr.h       |  57 +++++-
>   include/hw/ppc/spapr_vfio.h  |  28 +++
>   stubs/meson.build            |   1 +
>   stubs/spapr_phb_vfio-stubs.c |  52 ++++++
>   12 files changed, 816 insertions(+), 351 deletions(-)
>   create mode 100644 hw/ppc/spapr_pci_vfio_eeh.c
>   create mode 100644 include/hw/ppc/spapr_vfio.h
>   create mode 100644 stubs/spapr_phb_vfio-stubs.c
>


