Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2A1CD8CA4
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 08:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWsFl-0007r7-Cx; Tue, 09 Jun 2026 04:56:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wWsFj-0007qY-86; Tue, 09 Jun 2026 04:56:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wWsFh-0005GL-81; Tue, 09 Jun 2026 04:56:07 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6592a8mL647384; Tue, 9 Jun 2026 08:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Lt0XFV
 G0Fbeh5UspJQ76bRe/xRbUbhb0XLQaSZSUBKk=; b=WPPEyFhnkC56WxLkmkA7O8
 8H4cCjU9qoeZ1U8CfzU9sv4pRjmk7tkIwiE00E2rjPl0AoMgqE3s6TPyVNowlEsS
 7oxbSwwCgHYrO/FQcbIfnb+zrHLUdvtf9gmS1y6f6M1LMcsCEALpnUytgBuv10EK
 5sgOaMy0lOgysKh77eMjiTgddemdw84w8NRjvAzaA7HNsPoovNDDVG7rk/5mE3na
 oTcOXvK2ghCXESaCqh6sn2mwGzqPK7L5Eo0juKed83QZXgDnv1Z10uOiHKhbah6q
 3ZGyIY7Y2ueYV5p9Ka/Jxb40tyLZ63+46CDQDhpAy+eAQPnLw3JiBEJvasnhHJ2A
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em9ye36c6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2026 08:56:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6598najO011699;
 Tue, 9 Jun 2026 08:56:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvq1csk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 09 Jun 2026 08:56:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6598tukm50397662
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 9 Jun 2026 08:55:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADBB320049;
 Tue,  9 Jun 2026 08:55:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C5A720040;
 Tue,  9 Jun 2026 08:55:53 +0000 (GMT)
Received: from [9.124.209.207] (unknown [9.124.209.207])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  9 Jun 2026 08:55:53 +0000 (GMT)
Message-ID: <f85ea418-f285-4d12-8612-4bb641e1888b@linux.ibm.com>
Date: Tue, 9 Jun 2026 14:25:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] ppc/spapr: Add RTAS error injection support for
 VFIO EEH
To: Anushree Mathur <anushree.mathur@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, mahesh@linux.ibm.com,
 ganeshgr@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com, clg@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@linaro.org
References: <20260520095446.64206-1-nnmlinux@linux.ibm.com>
 <c705eb45-18d9-4239-8e99-b964048f946c@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <c705eb45-18d9-4239-8e99-b964048f946c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3OSBTYWx0ZWRfX9dyN3LFzvN/g
 TpF1Aps8TPQDChgJwS1LFn8wE1NHV8sD7RrNk2doBYexzzOwSFJHKZeTdE20+HnZUP9ZK/CWPYC
 gyMxoxO6mP+LN5fQQhtRF9YCznayRN3m1XFDhskT+glPmB4zhjMVmYE7XtNFoxHQxMvc/IgW9Yb
 70yxPC5yVsKkJ3d5a2L1oTSXTLTjSDyNAE+wCSwYlgLBnmSnXb4o1fD5G/9zb7SeqN1d8rOkUsu
 T3Ls0TEuvwPM4fj1dc3OLY4H33a1H9I1sjsVagsyxQ6283QQuKD7DbxgzP7tG2P1HyeB/EovLBA
 2z4SA/UVqrWMFgEis1Nzv/2uGAnEi+cuTZ+A8UmSMoNJZvCjLCMMT/nDJ88IQ/mD6QDMU6YRz4K
 B8/bLyFr+ELtv1MfLXEvrvUq3qMLQw6Wwkm2UA43iIaFGEkHkfdOfciTigHK5YeFmsqMofTqEZq
 E7kPouEf+G5Lnr9tGlA==
X-Authority-Analysis: v=2.4 cv=QKhYgALL c=1 sm=1 tr=0 ts=6a27d521 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=NEAV23lmAAAA:8
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=PTf7GiqIeJPFJNF9sscA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZE_qrAQrpBit91EyuRDShm7tjNwGMBkN
X-Proofpoint-ORIG-GUID: Z1wudBxIPZk_E2detLbLfKbh-enVqg5r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090079
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 08/06/26 11:01 PM, Anushree Mathur wrote:
> Hi Narayana,
> I tested this patch and saw a qemu crash just after triggering error 
> injection on guest after applying the patch series.
> Here is my full analysis:
>
> 1) Started the guest
> 2) Attached an NVME backplane device to the guest.
> 3) Triggered the error injection on guest console for the attached 
> NVME device.
>
> It came to the following message and the guest crashed:
>
> Injecting an ioa-bus-error...
>
> Following is the qemu logs after crash:
>
>
> 2026-06-08T06:25:16.420015Z qemu-system-ppc64: warning: kernel_irqchip 
> allowed but unavailable: IRQ_XIVE capability must be present for KVM
> Falling back to kernel-irqchip=off
> 2026-06-08T06:25:16.495864Z RTAS: Read 236 bytes from device-tree
> 2026-06-08T06:28:43.769276Z qemu-system-ppc64: 0213:60:00.0 BAR 0: 
> failed to create dma-buf: PCI BAR IOMMU mappings may fail: Invalid 
> argument
> 2026-06-08T13:21:00.218278Z RTAS: Read 236 bytes from device-tree
> 2026-06-08T13:21:05.658991Z qemu-system-ppc64: warning: kernel_irqchip 
> allowed but unavailable: IRQ_XIVE capability must be present for KVM
> Falling back to kernel-irqchip=off
> 2026-06-08T13:21:05.794879Z RTAS: Read 236 bytes from device-tree
> 2026-06-08T13:41:59.736480Z RTAS: Read 236 bytes from device-tree
> 2026-06-08T13:42:13.712991Z qemu-system-ppc64: warning: kernel_irqchip 
> allowed but unavailable: IRQ_XIVE capability must be present for KVM
> Falling back to kernel-irqchip=off
> 2026-06-08T13:42:13.848406Z RTAS: Read 236 bytes from device-tree
> 2026-06-08T14:24:42.012714Z qemu-system-ppc64: 0213:60:00.0 BAR 0: 
> failed to create dma-buf: PCI BAR IOMMU mappings may fail: Invalid 
> argument
> 2026-06-08 14:34:09.570+0000: shutting down, reason=crashed
>
Hi Anushree,

Thank you very much for the detailed crash report and thorough testing!
This is extremely valuable feedback that helped identify a critical bug in
the error injection implementation.

I'll prepare a v4 of the patch series with this fix. Could you please 
test it
again once I send it out? I'd particularly appreciate testing with:
- Multiple PHBs in the system
- Devices attached to different PHBs
- Both IOA bus errors and other error types (if possible)

Thanks again for the excellent bug report!

Best regards,
Narayana Murty N
>
> Thank you,
> Anushree Mathur
>
> On 20/05/26 3:24 PM, Narayana Murty N wrote:
>> This patch series implements comprehensive RTAS-based error injection
>> support for VFIO EEH (Enhanced Error Handling) on PowerPC sPAPR 
>> platforms.
>> The implementation enables guest-initiated PCI error injection for 
>> improved
>> testing and diagnostics of EEH recovery mechanisms.
>>
>> Background
>> ----------
>> EEH is a critical feature on PowerPC platforms that provides error 
>> detection,
>> isolation, and recovery for PCI devices. Testing EEH recovery paths 
>> requires
>> the ability to inject various types of errors into the system. While 
>> physical
>> hardware supports error injection through firmware interfaces, QEMU's 
>> VFIO
>> implementation previously lacked this capability.
>>
>> This series bridges that gap by implementing the IBM RTAS error 
>> injection
>> interface, allowing guests to inject PCI errors through the same 
>> firmware
>> calls used on physical hardware. This enables comprehensive testing 
>> of device
>> drivers' EEH recovery code paths in virtualized environments.
>>
>> Implementation Overview
>> -----------------------
>> The patch series introduces three new RTAS calls:
>>    - ibm,open-errinjct:  Opens an error injection session
>>    - ibm,errinjct:       Injects a specific error type
>>    - ibm,close-errinjct: Closes the error injection session
>>
>> The implementation supports multiple error types including:
>>    - IOA bus errors (32-bit and 64-bit addressing)
>>    - Memory/IO/Config space load/store errors
>>    - DMA read/write errors
>>    - Cache and TLB corruption scenarios
>>    - Special recovery events
>>
>> Tesed on pseries and powernv hosts on kvm guest with errinjct tool.
>>
>> Patch Organization
>> ------------------
>> Patch 1: Adds the VFIO backend for error injection
>> Patch 2: Implements the ibm,errinjct RTAS call handler
>> Patch 3: Adds session management (open/close) RTAS calls
>> Patch 4: Advertises capabilities via device tree properties
>> Patch 5: Refactors EEH specific code/stubs to new files.
>> Patch 6: Updates MAINTAINERS file
>>
>> Changelog:
>> ----------
>> v3:
>>    - Fixed the build failure reported at 
>> https://github.com/p-b-o/qemu-ci/actions/runs/26094993976
>>    - Also fixed a gitlab CI breakage in patch 2 (qemu_log_mask 
>> LOG_UNIMP)
>> v2: Addressed refactor suggestions from Cedric, Pierrick
>> v1: 
>> https://lore.kernel.org/all/20260512071112.9675-1-nnmlinux@linux.ibm.com/ 
>>
>>
>>
>> Narayana Murty N (6):
>>    ppc/spapr: Add VFIO EEH error injection backend
>>    ppc/spapr: Add ibm,errinjct RTAS call handler
>>    ppc/spapr: Add support for 'ibm, open-errinjct' and 'ibm,
>>      close-errinjct'
>>    ppc/spapr: Advertise RTAS error injection call support via FDT
>>      property
>>    ppc/spapr: Split VFIO code and refactor EEH interface
>>    MAINTAINERS: Add entry for sPAPR PCI VFIO EEH support
>>
>>   MAINTAINERS                  |   6 +
>>   hw/ppc/Kconfig               |   2 +-
>>   hw/ppc/meson.build           |   1 +
>>   hw/ppc/spapr.c               | 104 +++++++++++
>>   hw/ppc/spapr_pci.c           | 219 ++++++++++++++++++++++
>>   hw/ppc/spapr_pci_vfio.c      | 314 +------------------------------
>>   hw/ppc/spapr_pci_vfio_eeh.c  | 346 +++++++++++++++++++++++++++++++++++
>>   include/hw/pci-host/spapr.h  |  37 +---
>>   include/hw/ppc/spapr.h       |  57 +++++-
>>   include/hw/ppc/spapr_vfio.h  |  28 +++
>>   stubs/meson.build            |   1 +
>>   stubs/spapr_phb_vfio-stubs.c |  52 ++++++
>>   12 files changed, 816 insertions(+), 351 deletions(-)
>>   create mode 100644 hw/ppc/spapr_pci_vfio_eeh.c
>>   create mode 100644 include/hw/ppc/spapr_vfio.h
>>   create mode 100644 stubs/spapr_phb_vfio-stubs.c 


