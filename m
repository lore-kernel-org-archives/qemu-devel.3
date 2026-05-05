Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92576FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 15:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKHOp-0005Wh-3d; Tue, 05 May 2026 11:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wKHOY-0005VS-MJ; Tue, 05 May 2026 11:09:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wKHOW-0008E0-GB; Tue, 05 May 2026 11:09:10 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6450eoFn2062528; Tue, 5 May 2026 15:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=PLv9fx
 YOFZH+un6hdpOFo6RpRW+bvQ+g+jVcRLnXM5s=; b=TN5p3cHLvRXbVGSBMSLHhT
 l17TzKX6iGzXVmSB4InPBijkjpYXl6y3iZvseueGFQBZsnpnTkYxsTJIj9sRkgRo
 gWSWREhJKZSECsZapJeKMonSddNXg0szgOE3QpVKRWvMzNabskF3jpkqP4lTg3/9
 8/IEGEJta33BwYN8IkP++VaIhorVAXWu5wkJn6W5NuYeaA7Fl98Tvxcie96GlIxx
 6QM1R2LvuNP4VMOVg8VZJIQ884D0ZnpotgmDCmDTqlSB+lAA46u7jqb77+FGuZ5D
 LtiKvKLRHWyR1EX1OplzZz1w+OjVe6qVlpqRnOgE8NNRKHjAlyvaUuZek3O+B+6A
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6byrw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 15:08:59 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645Esfbk031323;
 Tue, 5 May 2026 15:08:58 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9y9w4s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 May 2026 15:08:58 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 645F8vDC31326726
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 May 2026 15:08:57 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85D5858054;
 Tue,  5 May 2026 15:08:57 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9535158045;
 Tue,  5 May 2026 15:08:49 +0000 (GMT)
Received: from [9.124.208.117] (unknown [9.124.208.117])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 May 2026 15:08:48 +0000 (GMT)
Message-ID: <91f9c6eb-5319-42d5-8c02-304ee16d904b@linux.ibm.com>
Date: Tue, 5 May 2026 20:38:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] pnv/phb4: Implement sticky reset logic in PHB4
Content-Language: en-GB
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-4-saif.abrar@linux.vnet.ibm.com>
 <28b35521-245f-48b8-a97e-f77f08afecc5@linux.ibm.com>
In-Reply-To: <28b35521-245f-48b8-a97e-f77f08afecc5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69fa080b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22
 a=VnNF1IyMAAAA:8 a=O1nRck82RF9-qVdPPv0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 10eaQyZLsmA4snPjShMkLPXxVFSycuIo
X-Proofpoint-GUID: lP_8ZVCTUPlcbG1NSLRPReDjvIPahy5f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE0NSBTYWx0ZWRfXxpPuB4g8Z2it
 UIfVNAufbOOrdUAYiMXw7JPedWf9kLbc/MTw8CtUccwiJZoQYTQZEfGZoBIMYsYZARNlFPi9406
 tL66fnWuMC3QZUBPX4oXdgvaoE+MzoVgM2ZmImRx6BmKnpvYEa6GZUr4w6ay6NDxsyn5h/T0nJk
 6LLDO+ga5tLWNYqUXfDBKrV2yffe8Ao07PGgZ3oH2R08YlPWcsaXZi4M7rYeNL3CBCSR9XoU9/Y
 iLO/pumcEWH4loNQDTr/6N7L8VmlfdbLtOLa+1xpBg4i3e4yWMBlcfMaEHm5Zegnsim5quChHzS
 lFAhB7qapILYxCaOnXESSC+6DyzwBgQ5Egm06wAzgCYwEAvqP+K4kkE4FADwEhCHqgdjP497lDm
 oxELvXomZ75Jmr0wZSGAal9Uur0EfIRXYuQGKaxuNTU4i0WFIg6+Q6UlTkcHq9Ur2xkHxyuTkj0
 wekzvd6wYf1sEMcLXCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050145
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 05/05/26 7:59 pm, Harsh Prateek Bora wrote:
> 
> 
> On 05/03/26 11:39 am, Saif Abrar wrote:
>> Sticky bits retain their values on reset and are not overwritten with
>> the reset value.
>> Added sticky reset logic for all required registers,
>> i.e. CFG core, PBL core, PHB error registers, PCIE stack registers and
>> REGB error registers.
>>
>> Tested by writing all 1's to the reg PHB_PBL_ERR_INJECT.
>> This will set the bits in the reg PHB_PBL_ERR_STATUS.
>> Reset the PBL core by setting PHB_PCIE_CRESET_PBL in reg PHB_PCIE_CRESET.
>> Verify that the sticky bits in the PHB_PBL_ERR_STATUS reg are still set.
>>
>> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
>> ---
>> v3: Updates for coding guidelines.
>>
>>   hw/pci-host/pnv_phb4.c              | 123 +++++++++++++++++++++++++++-
>>   include/hw/pci-host/pnv_phb4_regs.h |  20 ++++-
>>   tests/qtest/pnv-phb4-test.c         |  41 ++++++++++
>>   3 files changed, 179 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
>> index 763e9c9776..b3f46f7fe1 100644
>> --- a/hw/pci-host/pnv_phb4.c
>> +++ b/hw/pci-host/pnv_phb4.c
>> @@ -511,6 +511,18 @@ static uint32_t get_exp_offset(PCIDevice *pdev)
>>       return rpc->exp_offset;
>>   }
>> +/*
>> + * Apply sticky-mask 's' to the reset-value 'v' and write to the 
>> address 'a'.
>> + * RC-config space values and masks are LE.
>> + * Method pnv_phb4_rc_config_read() returns BE, hence convert to LE.
>> + * Compute new value in LE domain.
>> + * New value computation using sticky-mask is in LE.
>> + * Convert the computed value from LE to BE before writing back.
>> + */
>> +#define RC_CONFIG_STICKY_RESET(a, v, s) \
>> +    (pci_set_word(conf + (a), bswap32( \
>> +                     (bswap32(pci_get_word(conf + (a))) & (s)) | ((v) 
>> & ~(s)))))
> 
> Shouldn't we be using bswap16 here ?

If 32-bit helper is needed, we need to use pci_[get|set]_long instead.



