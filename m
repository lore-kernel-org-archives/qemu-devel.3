Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A1BCD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 07:17:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZkWR-0005tj-G4; Wed, 17 Jun 2026 03:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZkWN-0005rx-8T; Wed, 17 Jun 2026 03:17:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZkWL-0006fM-Jy; Wed, 17 Jun 2026 03:17:11 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GLnb2L2726649; Wed, 17 Jun 2026 07:16:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=i8mUHs
 Cdgz33kDzmw5LDv750tiCwDgOl6ifP6vAi5O0=; b=sClposnrLX547Dv/jr3QgM
 X0MN8goe43BxPuo49ghf/qQaB9RlLEfWHS5Gth3GTo6I11LPbWop4GdPPMv5phdW
 QnPRNdWtBtT1EIg260RP7PlEryctQy0nZFEEx7Ib4IDKzf/rxhxWmAqR5TFTHgP6
 791XqhUpDHSJSZXxLtaSVN7+MPtvLKxARhZWWcItZFYJu9F2RucIcN+rhKxHbWcu
 mKrBqnZdxE5lxOUBolQIGAlxmBrP/vOLjYnYV3+XtbC8JP5k+TxSeTjBc+3fQFfZ
 wUfWWWcmQxHlyCQC8K9TOJV4+t/xWyu5DC8Al81IwFCJEkVsr7VklKdHxkrhsNFw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqvspvr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 07:16:58 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H74iwS020357;
 Wed, 17 Jun 2026 07:16:57 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eudvaa0xg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 07:16:57 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65H7Gu6h32637556
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 07:16:56 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C8135803F;
 Wed, 17 Jun 2026 07:16:56 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E7B458056;
 Wed, 17 Jun 2026 07:16:51 +0000 (GMT)
Received: from [9.43.52.172] (unknown [9.43.52.172])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jun 2026 07:16:51 +0000 (GMT)
Message-ID: <cb8f0fc3-f95f-47d0-9695-c257ee49d79c@linux.ibm.com>
Date: Wed, 17 Jun 2026 12:46:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 9/9] pnv/phb4: Mask off LSI Source-ID based on number
 of interrupts
To: Jishnu Warrier <jishnuvw@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com, adityag@linux.ibm.com
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-10-saif.abrar@linux.vnet.ibm.com>
 <auxjiykky33cggvrgi7jbeaaje3qo6szmtiilpgfs6dnbbolc5@zejcua7lpp5x>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.ibm.com>
In-Reply-To: <auxjiykky33cggvrgi7jbeaaje3qo6szmtiilpgfs6dnbbolc5@zejcua7lpp5x>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA2MiBTYWx0ZWRfX7DiV/mcmpU6z
 qPZkmEiaSVn5BToHDjaLdbJLWjcLYl4v68kagcf/ZSGbUz+KqpYCzOwTbIzV7CQv/vugMzxZpDP
 sNQU0yfqwg57ajjvpB3eHOAHTPibpr8=
X-Proofpoint-GUID: vuSypYF5Zvyt7AWOWlJD0J4_itk0wx__
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a3249eb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kUKHeS9f1dJEPYFD:21 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=VnNF1IyMAAAA:8 a=aow-egSQAAAA:8 a=icP3stVFIlYJmjWPloYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-ORIG-GUID: 7kBEm3-ruC-BNqla9zMM19WmnUHbVQ6V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA2MiBTYWx0ZWRfXxQ6GzYqkTJQV
 Fhqr/lu9wGkmOv5OaKqv7Uy2D6OmQYt56bWa2Z5nOo+hoKxNlNzqAfLYQxlxgSvPZBBUZZLKU8q
 sqjs5uo9URqvIzswRzbmX5s6R7bFQlHJwdvUD638Z9yL8l+EkskL3h7gDdtSvRuzixw9EJCppdC
 +3A14s19XO/8Drmpxx1zFjhU821oJqRfrbYG3J2n/brpMMD+AORoQWaaY7Oqikt5pFX0Xzo9XhD
 +2CdsirrmTt8Okx0suhWa63BLpGntqOwtBx6PYjoP1sDvZZ6FfRa6UiyGaxDVCGfFcIxFhdLlOr
 s2MHQWl3+l1PBP7WN25NXRqMK5z+2JS+IDjnM9Bi0oBB4v2G4KjkwtlAJdS/WMPoKKoqlrBwXwr
 FWHmVfLXnB468ZbhNh7IWIbInvFpCM0YCFhMwcQAk+0AWDXu0fqKRVCOAY+Ji8XZBiNEjohe3k1
 NxSWbMKAYF8fWddUqbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170062
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


On 11-05-2026 14:16, Jishnu Warrier wrote:
> On Thu, Mar 05, 2026 at 12:09:11AM -0600, Saif Abrar wrote:
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
> If I am not wrong, according to PHB5 spec page 104, the LSI Source ID field should be bits 3-15:
>      PPC_BITMASK(3, 15)  // 0x1FF8000000000000ULL
> 03:12 LSI Source ID(00:09)
> RW
>
> 13:15 LSI Source ID(10:12)
> R0


This patchset is for PHB5. Your observation is about the next version PHB5B.


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
>>   }
>>   
>>   static void pnv_phb4_instance_init(Object *obj)
>> @@ -2080,8 +2088,6 @@ static void pnv_phb4_realize(DeviceState *dev, Error **errp)
>>           return;
>>       }
>>   
>> -    pnv_phb4_update_xsrc(phb);
>> -
>>       phb->qirqs = qemu_allocate_irqs(xive_source_set_irq, xsrc, xsrc->nr_irqs);
>>   
>>       pnv_phb4_xscom_realize(phb);
>> -- 
>> 2.47.3
>>

Thanks,

Saif



