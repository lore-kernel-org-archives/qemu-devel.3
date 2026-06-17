Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B39CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:32:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZjp4-00087z-H3; Wed, 17 Jun 2026 02:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZjp3-00087l-IE; Wed, 17 Jun 2026 02:32:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZjp1-0006CG-PS; Wed, 17 Jun 2026 02:32:25 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GLmkZd2724746; Wed, 17 Jun 2026 06:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=yHo3Ea
 cUPNpaVk7ohadPvHqulAg1UrrtiU0D2kaz5hk=; b=mmprZeTFqQApfU7kNUueAm
 H0U2O8ISktf3ETK2UvGsQS6VHqklcuhO/qZ3zPbiq9kYnyZMRZ3zgU2+4FCCZfPZ
 ALIAB1dEkiNhLDjez/CL0vTenVg8ypW8nB1X1iQJzSL/jRv6BjvMo4kOvEbk+aB3
 LSf5dmhysxOKTUGW+dxunhp+Di+YeDfItc5gHkvyPzUD07tMA1C2UUbI4mMF3O9P
 DD1QQb8nEhZxVfFzNVvHG3gikFOPk80yjK9KFYNDyrFIbRlZt5fWlIsj5bPeGsLg
 g8WkUOvBcoES1CajiNUwlhrIKQppv+RJ9R1RHcxfK3yKQicK+veccDlbk9Izx+yg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqvshs9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 06:32:13 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H6JfsQ029265;
 Wed, 17 Jun 2026 06:32:12 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eudva9ue5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 06:32:12 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65H6WBBn61538644
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 06:32:11 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E53758060;
 Wed, 17 Jun 2026 06:32:11 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F9F75805A;
 Wed, 17 Jun 2026 06:32:06 +0000 (GMT)
Received: from [9.43.52.172] (unknown [9.43.52.172])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jun 2026 06:32:06 +0000 (GMT)
Message-ID: <5fd13dd7-dfe0-42c4-bfb8-fbcb926671ac@linux.ibm.com>
Date: Wed, 17 Jun 2026 12:02:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] pnv/phb4: Set link-active status in HPSTAT and LMR
 registers
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, jishnuvw@linux.ibm.com
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-7-saif.abrar@linux.vnet.ibm.com>
 <af9LQsiL9Wear4kN@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.ibm.com>
In-Reply-To: <af9LQsiL9Wear4kN@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA1NyBTYWx0ZWRfX998B+nnqSvD3
 aAlD3umkTcFs64B/ZFSIhYNvsEXVO60Fm5smQ00iJXp5QcEJHj0sS5NlhnqiZIHzB7VJ85Zinze
 DT5sceRYUbMLISXcqOcfoXk/QHPH2/Q=
X-Proofpoint-GUID: qZhdTgvByXwSFEHWrktW8pDgrFdoCpiH
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a323f6e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=mtPk46M2fOgLPBnprAUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: EwpNU9yJlL3vzPihnU1ReKFZmxfpw2LZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA1NyBTYWx0ZWRfX9KgwjZ3jgIU1
 ptRlb6YCt/6IEvkMvf5oS11q485GixGqFw4/t12JK5bQJ4gpJVMLLI23tAc20y9UVwlUm+RxFZ+
 nfFE6JP4R/3sbSg4Lp+lcJJRBXDbHMWta1VME/8mAXnGo5jWzTSB26fZWGb4hsbhoe5hImnWEPF
 IRlLkXZBFO4UPf+zUW/Dk+8+TytWBoGRYUO163hksFqLoC9Lhb5DKHfu04kCUEE1YKxUEYVsN1U
 hTN7EIr6Tm2tmgLdePb5Y0jztQpbgtxH671EfPAyI4uk5HTle873Tdb8+YspNIirAb+skQSstdk
 wFvJpJGHeNx7EqAfUcHOVuqGxc0/1RdWbIO0KiC2Dq5m4cALNY+ZqT45b0Rc38Q+Do4digToO29
 bp2hDQ8jyE4NwVIyG5RVTo6l2RNIj4Kg9HyUyaurxnEnu6/aS/4iuG1MZZpwDE7v9Eht5ZuZr1v
 i41BitsSvycW6sZRT5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170057
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 09-05-2026 20:30, Aditya Gupta wrote:
> On 26/03/05 12:09AM, Saif Abrar wrote:
>> <...snip...>
>> --- a/hw/pci-host/pnv_phb4.c
>> +++ b/hw/pci-host/pnv_phb4.c
>> @@ -511,6 +511,20 @@ static uint32_t get_exp_offset(PCIDevice *pdev)
>>       return rpc->exp_offset;
>>   }
>>   
>> +/*
>> + * Config-read the link-status register in the PCI-E macro,
>> + * convert to LE and check the link-active bit.
>> + */
>> +static uint32_t is_link_active(PnvPHB4 *phb)
>> +{
>> +    PCIHostState *pci = PCI_HOST_BRIDGE(phb->phb_base);
>> +    PCIDevice *pdev = pci_find_device(pci->bus, 0, 0);
>> +    uint32_t exp_offset = get_exp_offset(pdev);
>> +
>> +    return (bswap32(pnv_phb4_rc_config_read(phb, exp_offset + PCI_EXP_LNKSTA, 4)
>> +                    ) & PCI_EXP_LNKSTA_DLLLA);
> should it be be32_to_cpu instead of bswap ?


Using be16_to_cpu now.

>
>> +}
>> +
>>   /*
>>    * Apply sticky-mask 's' to the reset-value 'v' and write to the address 'a'.
>>    * RC-config space values and masks are LE.
>> @@ -729,6 +743,11 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
>>           val = 0;
>>           break;
>>   
>> +    case PHB_PCIE_HOTPLUG_STATUS:
>> +        /* For normal operations, Simspeed diagnostic bit is always zero */
>> +        val &= PHB_PCIE_HPSTAT_SIMDIAG;
>> +        break;
> spec says this about HPSTAT_SIMDIAG bit in Hot Plug Status register:
>
> 	NOTE: if simulation code changes this bit (Simspeed diagnostic bit)
> 	it should also write bit '9' so that the input status signal
> 	will re-sample correctly.".
>
> i don't think bit 9 makes a difference for us currently, but i think
> good to set bit 9 too. what do you say ?


By simulation, spec means the RTL simulation.

There is no re-sampling in our case, hence not required.


>
>> <...snip...>
>>
>> +        /*
>> +         * Config-read the PCI-E macro register for slot-status.
>> +         * Method for config-read converts to BE value.
>> +         * To check actual bit in the PCI-E register,
>> +         * convert the value back to LE using bswap32().
>> +         * Clear the Presence-status active low bit.
>> +         */
>> +        if (bswap32(pnv_phb4_rc_config_read(phb, exp_base + PCI_EXP_SLTSTA, 4))
>> +                    & PCI_EXP_SLTSTA_PDS) {
>> +            val &= ~PHB_PCIE_HPSTAT_PRESENCE;
> be*_to_cpu makes more sense than bswap32 here, as PCI_EXP_SLTSTA_PDS is
> in qemu endianness


Updated.


>
> - Aditya G

Thanks,

Saif



