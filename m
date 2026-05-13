Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E890CD4F24
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 08:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN4tX-0008GP-Ku; Wed, 13 May 2026 04:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wN4tW-0008Fw-51; Wed, 13 May 2026 04:24:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nnmlinux@linux.ibm.com>)
 id 1wN4tG-0003r6-QQ; Wed, 13 May 2026 04:24:41 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64D2ip4k3773759; Wed, 13 May 2026 08:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=y8Fqpb
 A6xAsDFk32lEW7uNLXIE2AUEKDAW2SgT0De/A=; b=az/dbQh/RX0cpBIicKRcbS
 F9TNvhTtAHy2UNDFVB8XSeLM3z7P1dX5QkQGacWgOQ9TFsmXzmpyBLiyNqo2ufTg
 k6nje+DQbOL0vwS88qIFOTx9khSaSmOz6hWjnVHv58MTVhUGXTxHl4N5yaHIhi4u
 GcymEB9uqEMZr+WHK1yA0J2OnbHg3WEr+nFLy/UL+NXRgFw2lgJUTQ+WxGK38MeH
 V7MF4aIRcqv/wXmSP/Orkvq2dlRT1hR3DsrRyWGDVJBQjAB7M7w0fd7piQDWvGuw
 Ryfi9B+n7ckBXbvNtwYs1b3ZwfdjrRV0hUDXAH7mRmy+OhH35Rc/boGughw/+esg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6pfm4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 May 2026 08:24:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64D89Uee006532;
 Wed, 13 May 2026 08:24:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgpvav-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 May 2026 08:24:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64D8OIIh45744454
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 13 May 2026 08:24:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 371732004B;
 Wed, 13 May 2026 08:24:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 16FED20040;
 Wed, 13 May 2026 08:24:16 +0000 (GMT)
Received: from [9.123.10.31] (unknown [9.123.10.31])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 13 May 2026 08:24:15 +0000 (GMT)
Message-ID: <26dfb1d3-e8b0-4315-842a-1bd62ec7bfd0@linux.ibm.com>
Date: Wed, 13 May 2026 13:54:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Narayana Murty N <nnmlinux@linux.ibm.com>
Subject: Re: [PATCH 5/6] hw/ppc: Rename spapr_pci_vfio.c to
 spapr_pci_vfio_eeh.c
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, harshpb@linux.ibm.com, mahesh@linux.ibm.com,
 ganeshgr@linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com,
 anushree.mathur@linux.vnet.ibm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260512071112.9675-1-nnmlinux@linux.ibm.com>
 <20260512071112.9675-6-nnmlinux@linux.ibm.com>
 <ebc9e323-6acb-4224-84a7-1fdcc0841205@redhat.com>
Content-Language: en-US
In-Reply-To: <ebc9e323-6acb-4224-84a7-1fdcc0841205@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=KbvidwYD c=1 sm=1 tr=0 ts=6a043537 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=6MIDTr5e4q5RNehgIOAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA4MiBTYWx0ZWRfXxkQNmgNDa+Oa
 ChdwS+8BPrgY0aTdIp63kDrz4OYroNiMjDYpdB7extwBudwiqR5S84iED5ziPZrmRYxCI7sNV6l
 ZVpvf+LwVfQLBpCuGGY0nhey2LYS9zyOppQ3f6tXw8U4K8b4nLwrqekfaWrfk+tk7h539+Djfs1
 g2C3LiDXZTePfRSXBaKz0hqK2Bfv1uQJMAcGSFfaokGgk09vMYa7XqfR6AAIJQY8RkRKcqE0o1q
 ZQgcYssir1JKQwDh24HhL4Mxe8Gub/gNwW1JJGGngtJ4/fn5GZIGj5cpIy9wJMUhoqT/LIJy/Fj
 4zJHw0Q1sPA3czJjbjTOUaSP+4svtkq+oT3EEo1g5Lx4mUi6PvL6sUV9SLMMyaLQBJY9swDREvL
 GidWyt6tZ2rqYBKDaOztD5CwgqufLqzEmINrcrdIgR57sJAY3wNQASwUYYQdACOHNwN8bGi51BM
 EZ60EgrxDVFT5/hi3Dg==
X-Proofpoint-GUID: gabHXgBaVnQH2qq68k7LrKWW__x5E7FK
X-Proofpoint-ORIG-GUID: hR9uiw_Dtg8UCNPGQSMovRlU6nRxq9so
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 clxscore=1011
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130082
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=nnmlinux@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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



On 12/05/26 1:24 PM, Cédric Le Goater wrote:
> + Pierrick, Philippe
>
> On 5/12/26 09:11, Narayana Murty N wrote:
>> The file spapr_pci_vfio.c contains exclusively EEH (Enhanced Error
>> Handling) related functions for VFIO devices on sPAPR platforms.
>> To better reflect its specific purpose and improve code organization,
>> this commit:
>>
>> 1. Renames spapr_pci_vfio.c to spapr_pci_vfio_eeh.c
>> 2. Moves spapr_phb_vfio_eeh_reenable() from spapr_pci_vfio_eeh.c to
>>     spapr_pci.c, as it's a general PHB operation not specific to
>>     VFIO EEH error injection/recovery
>>
>> After this change, spapr_pci_vfio_eeh.c contains only the core VFIO
>> EEH error handling functions, making the file's purpose more focused
>> and clear.
>>
>> This is a refactoring change with no functional impact.
>>
>> Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
>> ---
>>   hw/ppc/Kconfig                                    |  2 +-
>>   hw/ppc/meson.build                                |  2 +-
>>   hw/ppc/spapr_pci.c                                | 14 ++++++++++++++
>>   hw/ppc/{spapr_pci_vfio.c => spapr_pci_vfio_eeh.c} | 12 +-----------
>
>
> There is a CONFIG_VFIO_PCI in this file that could be replaced
> with stub definitions.
>
Hi Cedric,
We are using CONFIG_VFIO_PCI in the new eeh specific file as is for eeh 
specific routines and stubs.
Are you suggesting to retain spapr_pci_vfio.c with the remaining single 
routine "spapr_phb_vfio_reset"
and its stub?

Regards,
Narayana Murty

> Thanks,
>
> C.
>
>
>> include/hw/pci-host/spapr.h                       |  1 +
>>   5 files changed, 18 insertions(+), 13 deletions(-)
>>   rename hw/ppc/{spapr_pci_vfio.c => spapr_pci_vfio_eeh.c} (96%)
>>
>> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
>> index 347dcce690..886ce71ef8 100644
>> --- a/hw/ppc/Kconfig
>> +++ b/hw/ppc/Kconfig
>> @@ -6,7 +6,7 @@ config PSERIES
>>       imply PCI_DEVICES
>>       imply TEST_DEVICES
>>       imply VIRTIO_VGA
>> -    imply VFIO_PCI if LINUX   # needed by spapr_pci_vfio.c
>> +    imply VFIO_PCI if LINUX   # needed by spapr_pci_vfio_eeh.c
>>       select NVDIMM
>>       select DIMM
>>       select PCI
>> diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
>> index 37aa535db2..7cf0226b5e 100644
>> --- a/hw/ppc/meson.build
>> +++ b/hw/ppc/meson.build
>> @@ -35,7 +35,7 @@ ppc_ss.add(when: ['CONFIG_PSERIES', 'CONFIG_TCG'], 
>> if_true: files(
>>   ppc_ss.add(when: 'CONFIG_SPAPR_RNG', if_true: files('spapr_rng.c'))
>>   if host_os == 'linux'
>>     ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files(
>> -    'spapr_pci_vfio.c',
>> +    'spapr_pci_vfio_eeh.c',
>>     ))
>>   endif
>>   diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
>> index b00f71d92a..fcb7b850c0 100644
>> --- a/hw/ppc/spapr_pci.c
>> +++ b/hw/ppc/spapr_pci.c
>> @@ -2215,6 +2215,20 @@ void spapr_phb_dma_reset(SpaprPhbState *sphb)
>>       tcet->def_win = true;
>>   }
>>   +void spapr_phb_vfio_reset(DeviceState *qdev)
>> +{
>> +    /*
>> +     * The PE might be in frozen state. To reenable the EEH
>> +     * functionality on it will clean the frozen state, which
>> +     * ensures that the contained PCI devices will work properly
>> +     * after reboot.
>> +     */
>> +    spapr_phb_vfio_eeh_reenable(SPAPR_PCI_HOST_BRIDGE(qdev));
>> +}
>> +
>> +
>> +
>> +
>>   static void spapr_phb_reset(DeviceState *qdev)
>>   {
>>       SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(qdev);
>> diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio_eeh.c
>> similarity index 96%
>> rename from hw/ppc/spapr_pci_vfio.c
>> rename to hw/ppc/spapr_pci_vfio_eeh.c
>> index ed0b22a84a..c00cf1d24b 100644
>> --- a/hw/ppc/spapr_pci_vfio.c
>> +++ b/hw/ppc/spapr_pci_vfio_eeh.c
>> @@ -131,21 +131,11 @@ bool spapr_phb_eeh_available(SpaprPhbState *sphb)
>>       return vfio_eeh_as_ok(&sphb->iommu_as);
>>   }
>>   -static void spapr_phb_vfio_eeh_reenable(SpaprPhbState *sphb)
>> +void spapr_phb_vfio_eeh_reenable(SpaprPhbState *sphb)
>>   {
>>       vfio_eeh_as_op(&sphb->iommu_as, VFIO_EEH_PE_ENABLE);
>>   }
>>   -void spapr_phb_vfio_reset(DeviceState *qdev)
>> -{
>> -    /*
>> -     * The PE might be in frozen state. To reenable the EEH
>> -     * functionality on it will clean the frozen state, which
>> -     * ensures that the contained PCI devices will work properly
>> -     * after reboot.
>> -     */
>> -    spapr_phb_vfio_eeh_reenable(SPAPR_PCI_HOST_BRIDGE(qdev));
>> -}
>>     static void spapr_eeh_pci_find_device(PCIBus *bus, PCIDevice *pdev,
>>                                         void *opaque)
>> diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
>> index 417d1f6c31..5ca122a5f1 100644
>> --- a/include/hw/pci-host/spapr.h
>> +++ b/include/hw/pci-host/spapr.h
>> @@ -125,6 +125,7 @@ int spapr_phb_vfio_eeh_get_state(SpaprPhbState 
>> *sphb, int *state);
>>   int spapr_phb_vfio_eeh_reset(SpaprPhbState *sphb, int option);
>>   int spapr_phb_vfio_eeh_configure(SpaprPhbState *sphb);
>>   void spapr_phb_vfio_reset(DeviceState *qdev);
>> +void spapr_phb_vfio_eeh_reenable(SpaprPhbState *sphb);
>>   int spapr_phb_vfio_errinjct(SpaprPhbState *sphb, uint32_t func,
>>                               uint64_t addr, uint64_t mask, uint32_t 
>> type);
>>   #else
>


