Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D90C43327
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfJUc-0000qE-B6; Thu, 02 Jul 2026 11:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wfJUV-0000p6-Os; Thu, 02 Jul 2026 11:38:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1wfJUT-0007w0-LV; Thu, 02 Jul 2026 11:38:15 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662EIkgT3968655; Thu, 2 Jul 2026 15:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=3Ovk7w
 qgxa7F/wzelQ7kel5eYyrSdKKCfQspFY5g9sU=; b=iRCSoKxBxBeBRhOim+Z8UL
 OeOSGicJnNALluMufexCVVawJr0mZ6jntXkxPg4WOuI3ki92VJGV+JUtlt1D7++K
 o8fw8UHXbA8Ber/u1S/qEN4/XulZmtiPzpiXCS32J/HbIneFhMnTzooYo+90B6ZX
 si3CXh9HpokYvT12qp4GVMfcsJTq8nFzUNjdvfZaJFCETEf8uB4pQ3Ma3Ebnmb7r
 UaeezIm67/CVZ+L5m+5DqO1SqGvBzq3oboA7jIlD6UHzxj7G9WwZWA5UsrhRPUMD
 3kPtUDdmDguE5l70Ftr8j89cRKbVBdAnvxIxRlVBzvR0knEfGLchA0OFrlObs+7w
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mk2aea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 15:38:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 662FYol4032454;
 Thu, 2 Jul 2026 15:38:06 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhmj57-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 02 Jul 2026 15:38:06 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 662Fc5XO22676142
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 2 Jul 2026 15:38:05 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F17458052;
 Thu,  2 Jul 2026 15:38:05 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CB0D25805D;
 Thu,  2 Jul 2026 15:38:03 +0000 (GMT)
Received: from [9.61.149.146] (unknown [9.61.149.146])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTPS;
 Thu,  2 Jul 2026 15:38:03 +0000 (GMT)
Message-ID: <557a4ef8-a6eb-4ab1-8ed1-b8cd5ec4cee6@linux.ibm.com>
Date: Thu, 2 Jul 2026 11:38:03 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 18/35] hw/s390x/ipl: Rework s390_ipl_map_iplb_chain
 for certificate storage
To: Eric Farman <farman@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, berrange@redhat.com, richard.henderson@linaro.org,
 david@kernel.org, walling@linux.ibm.com, jjherne@linux.ibm.com,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com,
 alifm@linux.ibm.com, brueckner@linux.ibm.com,
 pierrick.bouvier@oss.qualcomm.com, jdaley@linux.ibm.com
References: <20260701204922.1320349-1-zycai@linux.ibm.com>
 <20260701204922.1320349-19-zycai@linux.ibm.com>
 <5dd80793bb0139b0b4e69eee31c832f72493dede.camel@linux.ibm.com>
Content-Language: en-US
From: Jared Rossi <jrossi@linux.ibm.com>
In-Reply-To: <5dd80793bb0139b0b4e69eee31c832f72493dede.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE2MCBTYWx0ZWRfXzeZuMzzKulxt
 Um1jlLoL89Ns9HXLwUGnJX8/kPWjVtvTSiAf05XpjoVSRkvBMeWt8D8TJBG/asWbeXf2ro5+Sjm
 87s8Ezi3NcmtuECHF97Fh6kaZhkWc3RMVrFc4cXYkkXUqAJfcMPU5NeYmtQc20LngwW5KHcrDB6
 F+agMNIugqD9O9Ec7It3Gjg1wh1fZKalU9cY0zRNHWX6pinPF5g3kVjd/Gf0ELF+OpbsBapzXEe
 cuuBXhU5RjsKdpvaBdr2Wab1UP3kx5wlh24gPj4gQicqXAFDa6W9QxlovgUmpbLVzfrcxxb6cCE
 WTltHkfWJbfUd2/SDZ+/lULohsDHKbf/KVWObZNKeB3/xvdoEjbGLab2kvmbn2jCzvaRYtI1Aw8
 gkahI3snJeizheNxFctBXsx8ABWn8kKxOHuEdf6AB0Q+w5lb2U8MGR05/hdwie1CJfqGyKUFqXn
 fVhrO1vhnQmFIGS56LQ==
X-Proofpoint-GUID: ap8ategGtXJavhVH38Tpqr5fgWa6WXmW
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a4685df cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=65CIrzbra0X4iqSXDy0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE2MCBTYWx0ZWRfX17XLDw/m3W6E
 axPnytnuekaZlH+qqSkpe+RRyLkbrzr8FcQF5X2RbvZ2Af3c5FpPQq8GnrIy+PPpIs6nSsjKMC/
 1dpC5lXppMJBCRfgw6FNdXIgutYwZa8=
X-Proofpoint-ORIG-GUID: ap8ategGtXJavhVH38Tpqr5fgWa6WXmW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020160
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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



On 7/2/26 10:56 AM, Eric Farman wrote:
> On Wed, 2026-07-01 at 16:49 -0400, Zhuoying Cai wrote:
>> Rework s390_ipl_map_iplb_chain to always allocate maximum memory for
>> the IPLB chain, regardless of the number of boot devices. This space
>> is also used to store certificates during secure boot, providing a
>> safe location for certificates until the kernel reads them during boot.
>>
>> Rename next_iplb to ipl_data to better reflect its multiple purposes:
>> storing both IPLB chains and certificate data.
>>
>> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
>> ---
>>   hw/s390x/ipl.c              | 13 ++++++++++---
>>   include/hw/s390x/ipl/qipl.h |  2 +-
>>   pc-bios/s390-ccw/iplb.h     |  4 ++--
>>   3 files changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
>> index 9cb41511e8..7734b6edc7 100644
>> --- a/hw/s390x/ipl.c
>> +++ b/hw/s390x/ipl.c
>> @@ -425,10 +425,9 @@ static S390PCIBusDevice *s390_get_pci_device(DeviceState *dev_st, int *devtype)
>>       return pbdev;
>>   }
>>   
>> -static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
>> +static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain, uint16_t count)
>>   {
>>       S390IPLState *ipl = get_ipl_device();
>> -    uint16_t count = be16_to_cpu(ipl->qipl.chain_len);
>>       uint64_t len = sizeof(IplParameterBlock) * count;
>>       uint64_t chain_addr = find_iplb_chain_addr(ipl->bios_start_addr, count);
>>   
>> @@ -629,8 +628,16 @@ static bool s390_init_all_iplbs(S390IPLState *ipl)
>>               dev_st = get_boot_device(i);
>>               s390_build_iplb(dev_st, &iplb_chain[i - 1]);
>>           }
>> +    }
>>   
>> -        ipl->qipl.next_iplb = cpu_to_be64(s390_ipl_map_iplb_chain(iplb_chain));
>> +    /*
>> +     * Allocate maximum space for IPLB chain and/or certificate storage.
>> +     * Once a valid boot device is found, this space will be used to store
>> +     * certificates if secure boot is enabled.
>> +     */
>> +    if (iplb_num > 1 || s390_has_certificate()) {
>> +        ipl->qipl.ipl_data = cpu_to_be64(s390_ipl_map_iplb_chain(iplb_chain,
>> +                                                                 MAX_BOOT_DEVS - 1));
> I think iplb_chain needs to be explicitly initialized to zero now that you're allocating a larger
> space. load_next_iplb() is still honoring the length of the count when walking the IPLBs, but the
> above does a memcpy of the whole array.
>

+1.  Eric is correct.  I missed this in my review.  We copy all 7 IPLB 
chain indices, but build_iplb() only populates the indices it actually 
needs and the array isn't automatically cleared when it is first 
declared, so it could potentially contain garbage at the end.

Thanks,
Jared Rossi

