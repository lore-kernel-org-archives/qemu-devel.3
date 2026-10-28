Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260FD606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 05:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HNFGAs/t
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLw2Y-0002qW-JV; Wed, 28 Oct 2026 01:17:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1xLw2S-0002py-KV; Wed, 28 Oct 2026 01:17:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1xLw2Q-0005a7-Fs; Wed, 28 Oct 2026 01:17:28 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S4jApe229994; Wed, 28 Oct 2026 05:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GcQ4d0
 x+TuAC1K/kvnCz/cqg2iCYrILgAnbAg9KzEJ8=; b=HNFGAs/tTSIEzHTjM/I5IL
 mEP0m54j5UL1C2r/wj1bduK+zr/R4Kq22OizdZPVH1NFLN2kNA4a7CdUD7GhPR9/
 lNaQ/CWZw+KcD5IZC/nmVCtkPRvmsw2F5UJbiffixpqx8Nm/mtP+pyqCk1pESVMg
 /QzmX9hi5vlbBvi2niPdY4ct6GuW+jMM6WK8msmS6WWLrbbi0JZK9GUVBw/hKFf2
 tEGbWqMaIt2oBzoXujN0BIhrvKM2CU+4bCn1TF1ixJ9xTzs+qYIvwI2iTeJJ9UsY
 I/LhqRdKXrZe6JNrg7yZt9ZZROQpjJHHxUVLEWTkofyL1bUmyvJr8n6g30vzuNxw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgj3mb6t0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2026 05:17:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 69S4YxOE1081712; Wed, 28 Oct 2026 05:17:23 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh8gh5yft-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 Oct 2026 05:17:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 69S5HJlQ48038288
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 Oct 2026 05:17:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5863C2004B;
 Wed, 28 Oct 2026 05:17:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F2E3D20040;
 Wed, 28 Oct 2026 05:17:16 +0000 (GMT)
Received: from [9.123.5.65] (unknown [9.123.5.65])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 28 Oct 2026 05:17:16 +0000 (GMT)
Message-ID: <1b2d62bd-14e0-4856-b686-ce204a7866f6@linux.ibm.com>
Date: Wed, 28 Oct 2026 10:47:16 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ppc/spapr: Disable VFIO BAR mmap during EEH PE
 reset
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org, sbhat@linux.ibm.com, mahesh@linux.ibm.com,
 sourabhjain@linux.ibm.com, adityag@linux.ibm.com, npiggin@gmail.com,
 harshpb@linux.ibm.com, alex@shazbot.org
Cc: amachhiw@linux.ibm.com, hbathini@linux.ibm.com, shivangu@linux.ibm.com,
 anushree.mathur@linux.ibm.com
References: <20261027160258.48207-1-nnmlinux@linux.ibm.com>
 <20261027160258.48207-3-nnmlinux@linux.ibm.com>
 <3cbe37ab-96aa-4489-828a-60ead423791b@redhat.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <3cbe37ab-96aa-4489-828a-60ead423791b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAyMCBTYWx0ZWRfXzCXFdHgpmTM8
 N+NCEaQF7VsjCfavBkVxSHwmwxmJyhX/Vqzo/rDrExUg1+nJv5N8a5ph/lRXNp9AZu1ICo0xP1c
 p0r9yX0xclEDCKT3rCxiniJWOB4UpsA=
X-Proofpoint-ORIG-GUID: Vtg_nj8pWgqmpR7qlDo4TYpdYTSrlwyd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAyMCBTYWx0ZWRfX1gF3HrSU1YJ/
 BCp7ZDQCebs3Zj0k5SEEVLE24OFzx6ZcCt9OZgdLt4ci09nbZ3Oj3IU+WYZycMQLFBr/5nBPHuN
 dykHwSsvSkfW+HCx6VHpEOrB7btVOmgpGc/EfpyYUwB8ZeETjQWg9ZCmazNh1p7Md7BYrpSNReG
 sbPRPXQRX8IQsYbKT3orVm1CIAU2FmRSTKd2XP7PwyNj6VNFJ7EnjOowyNDuTHI67hrJ/oKCCc9
 shTNUKrqBMCNx0IwfyC5pQNO8RYeEmlrsqdb+Pkg7u9yxSB3U2E5LfHsidlb4lFZ3mPy/Zv/4zT
 BB0iHYCyA0w9IZO17fGoAHXCNHCnVJzvzTHDw3NGOs7g81EDSsIqXQUZhSyO33sOpqxRLup8LGK
 T2nDhXJhNamI83/YWoZ1tdNVi4yqT9VAcvC6eozd/7J7do4rnzIa9VJf3oZz88hmXaa0UtnvBi8
 qTazEtgLewIH6MOrOsw==
X-Authority-Analysis: v=2.4 cv=G7uJgNk5 c=1 sm=1 tr=0 ts=6ae18564 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=WvrQyxpcuulkC-c7AqsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 7AewzIr-QFJCwGBcfvM1iOcC7oTu8FX8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280020
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Cédric,

On 27/10/26 9:38 PM, Cédric Le Goater wrote:
>> index 428ab2f069..931df22add 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -1949,6 +1949,38 @@ static void vfio_mmap_set_enabled(VFIOPCIDevice 
>> *vdev, bool enabled)
>>       }
>>   }
>> +/*
>> + * Prevent a pending INTx mmap timer from restoring BAR mmap while
>> + * the PE is undergoing EEH reset.  Keep BAR accesses on the VFIO
>> + * region read/write path until PE configuration completes.
>> + */
>> +void vfio_pci_eeh_pre_reset(PCIDevice *pdev)
>> +{
>> +    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
>> +
>> +    if (vdev->intx.mmap_timer) {
>> +        timer_del(vdev->intx.mmap_timer);
>> +    }
>> +
>> +    vfio_mmap_set_enabled(vdev, false);
>> +}
>> +
>> +void vfio_pci_eeh_post_configure(PCIDevice *pdev)
>> +{
>> +    VFIOPCIDevice *vdev = VFIO_PCI_DEVICE(pdev);
>> +
>> +    if (vdev->interrupt == VFIO_INT_INTx && vdev->intx.pending) {
>> +        if (vdev->intx.mmap_timer && vdev->intx.mmap_timeout) {
>> +            timer_mod(vdev->intx.mmap_timer,
>> +                      qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) +
>> +                      vdev->intx.mmap_timeout);
>> +        }
>> +        return;
>> +    }
>> +
>> +    vfio_mmap_set_enabled(vdev, true);
>> +}
>> +
>>   static void vfio_bar_prepare(VFIOPCIDevice *vdev, int nr)
>>   {
>>       VFIOBAR *bar = &vdev->bars[nr];
>> diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
>> index c9ab949870..63fa378fbc 100644
>> --- a/hw/vfio/pci.h
>> +++ b/hw/vfio/pci.h
>> @@ -266,6 +266,8 @@ struct vfio_pci_hot_reset_info;
>>   void vfio_pci_pre_reset(VFIOPCIDevice *vdev);
>>   void vfio_pci_post_reset(VFIOPCIDevice *vdev);
>> +void vfio_pci_eeh_pre_reset(PCIDevice *pdev);
>> +void vfio_pci_eeh_post_configure(PCIDevice *pdev);
>>   bool vfio_pci_host_match(PCIHostDeviceAddress *addr, const char *name);
>>   int vfio_pci_get_pci_hot_reset_info(VFIOPCIDevice *vdev,
>>                                       struct vfio_pci_hot_reset_info 
>> **info_p);
> 
> These are POWER-only routines. Why put them under hw/vfio/pci.c ?
Yes, agreed.

These helpers are specific to the sPAPR EEH recovery sequence, so putting
vfio_pci_eeh_pre_reset() and vfio_pci_eeh_post_configure() in generic
VFIO PCI code is not the right layering.

I'll move the EEH-specific pre-reset/post-configure handling back into
hw/ppc/spapr_pci_vfio.c and remove the corresponding declarations from
hw/vfio/pci.h.

Thanks,
Narayana Murty.>
> C.


