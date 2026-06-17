Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 466AACD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 07:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZkUw-0005IW-7A; Wed, 17 Jun 2026 03:15:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1wZkUu-0005IJ-Go; Wed, 17 Jun 2026 03:15:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.vnet.ibm.com>)
 id 1wZkUs-0006Qv-TC; Wed, 17 Jun 2026 03:15:40 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GLmgKl2636350; Wed, 17 Jun 2026 07:15:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dq7WJA
 pIW2R2PQBT4a4r5koKDr+msvbr+mTF3OYfvZM=; b=afHSPmulUp3jRrXWIAl9iH
 o8yZ3+iOFWvRsxGDtn5ihJKkLVPFKCgoDdECNkkoSwoqdEA32dPc3/Nj/BoW/yBj
 bcgLoFJhvE3OLWacvbpcIB5GgObvNj9kE7sNEVEmq39xf5G2G1DG7S8cmALM6a+j
 /+jmDiBz2jAYrvwpvy7WymWSOgND6ad5x65Z0TTasV+SXTDA3LXuej5TcXYMwsXg
 cT3JxlvtRxG/NPSarG8ZzdzubOHDiz1RE2BG62b3WC2DI46Q0Er3QAaZmmoO1P9H
 jhjeJHuGFu9yLPDNhCr0ebzAqFMK1AgDbJWYTARsXJzyks9d5tN2mTKC3Io7mQjw
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx1p30-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 07:15:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H74cxk014940;
 Wed, 17 Jun 2026 07:15:28 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eudvaj0bj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 07:15:28 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65H7FRbE16450176
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 07:15:27 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 37F2B58060;
 Wed, 17 Jun 2026 07:15:27 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CD1EC58056;
 Wed, 17 Jun 2026 07:15:21 +0000 (GMT)
Received: from [9.43.52.172] (unknown [9.43.52.172])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jun 2026 07:15:21 +0000 (GMT)
Message-ID: <47fa7797-ad6b-4107-985f-032a7a27af3e@linux.vnet.ibm.com>
Date: Wed, 17 Jun 2026 12:45:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] pnv/phb4: Mask off LSI Source-ID based on number
 of interrupts
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, jishnuvw@linux.ibm.com
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-10-saif.abrar@linux.vnet.ibm.com>
 <af9M4YtLceZXP06j@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
In-Reply-To: <af9M4YtLceZXP06j@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA2MiBTYWx0ZWRfXzlVM+imwlhyw
 dzo4mIxjrtpIO5IYKvyf9QV5p5RD5YorwGi4F/W/9eQeSsmU3WR9W0ESnampvjiJOjqbBxfgovQ
 OMuUjEjVlFtXUo32knIeaWRiEnjkYNYxnpckId56045/28LeXkzMkgvDZWNlC96OjI5lwHIVb/K
 UF5LOpoFJafBYtncRt/NHYXahtB9l9fGepSnJS1nGwvcIbJsqlPNtbbPiNe9w/dJCAn+5A+MxGY
 w2g7seOKQTPhH/9J0QR8FuYhK9mNLp5WaYLVV1WhVGYh1c9CxlQp5Bgj+pp0+/2GnNsQICD2D73
 d2ir333Avrp7v+cP0qarteD78BIDjy7yO8mog7h/NqTQh9P2z2LIFMyRweLGwfqUyCaSAgzP6Ln
 Y6S0EPVrX74+kz3Ga5u3jxYOl2o6xb6UUUcG/MYJ8TqK4NPp5toG2NsWmJxb8XkCb9Ss7yUf1YX
 ce7H1zSBzefZifqa+aw==
X-Proofpoint-GUID: YVTyNtw3l3XxyMRgsc2HsP2lH1okew21
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA2MiBTYWx0ZWRfX2r0DCKyxD3fQ
 5zbfhRTwyyg+nEzMUfFunAwBa4aB1eSLDU3ue69IKN6UI/ujDKFQvcKI+eEhv1GF0YWyP+0taxh
 yeAB4XBeHxEgi2UwXiQ54GNqcMNVw+o=
X-Proofpoint-ORIG-GUID: 8oRekro8tKO0E6zd9U5tjN15edBqhfDr
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a324991 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kUKHeS9f1dJEPYFD:21 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22
 a=VnNF1IyMAAAA:8 a=aow-egSQAAAA:8 a=O4_W4pT-pIX9l9402FUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170062
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=saif.abrar@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


On 09-05-2026 20:34, Aditya Gupta wrote:
> On 26/03/05 12:09AM, Saif Abrar wrote:
>> Add a method to reset the value of LSI Source-ID.
>> Mask off LSI source-id based on number of interrupts in the big/small PHB.
>>
>> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>> ---
>> v3: Updates for coding guidelines.
>> v2: Introduced method pnv_phb4_xsrc_reset().
>>
>>   hw/pci-host/pnv_phb4.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
>> index 254bbe4089..5e885cb89d 100644
>> --- a/hw/pci-host/pnv_phb4.c
>> +++ b/hw/pci-host/pnv_phb4.c
>> @@ -490,6 +490,7 @@ static void pnv_phb4_update_xsrc(PnvPHB4 *phb)
>>   
>>       lsi_base = GETFIELD(PHB_LSI_SRC_ID, phb->regs[PHB_LSI_SOURCE_ID >> 3]);
>>       lsi_base <<= 3;
>> +    lsi_base &= (xsrc->nr_irqs - 1);
>>   
>>       /* TODO: handle reset values of PHB_LSI_SRC_ID */
>>       if (!lsi_base) {
>> @@ -1944,6 +1945,12 @@ static void pnv_phb4_ro_mask_init(PnvPHB4 *phb)
>>       /* TODO: Add more RO-masks as regs are implemented in the model */
>>   }
>>   
>> +static void pnv_phb4_xsrc_reset(PnvPHB4 *phb)
>> +{
>> +    phb->regs[PHB_LSI_SOURCE_ID >> 3] = PPC_BITMASK(4, 12);
>> +    pnv_phb4_update_xsrc(phb);
>> +}
>> +
>>   static void pnv_phb4_err_reg_reset(PnvPHB4 *phb)
>>   {
>>       STICKY_RST(PHB_ERR_STATUS,       0, PPC_BITMASK(0, 33));
>> @@ -2000,10 +2007,11 @@ static void pnv_phb4_reset(Object *obj, ResetType type)
>>       PnvPHB4 *phb = PNV_PHB4(obj);
>>   
>>       pnv_phb4_pbl_core_reset(phb);
>> +
>> +    pnv_phb4_xsrc_reset(phb);
>>       pnv_phb4_err_reg_reset(phb);
>>       pnv_phb4_pcie_stack_reg_reset(phb);
>>       pnv_phb4_regb_err_reg_reset(phb);
>> -    phb->regs[PHB_PCIE_CRESET >> 3] = 0xE000000000000000;
> why is resetting PHB_PCIE_CRESET removed here, is it not expected to
> change during reset ?


PHB_PCIE_CRESET is now reset within pnv_phb4_pcie_stack_reg_reset()

>
> - Aditya G


Thanks,

Saif



