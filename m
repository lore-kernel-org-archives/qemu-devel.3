Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20056CD98EE
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 06:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZjfy-0001ui-RW; Wed, 17 Jun 2026 02:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZjVv-0006cJ-J2; Wed, 17 Jun 2026 02:12:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saif.abrar@linux.ibm.com>)
 id 1wZjVs-0001qE-8P; Wed, 17 Jun 2026 02:12:39 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GLmeDf2724696; Wed, 17 Jun 2026 06:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5u6IAM
 XHQmXiC4/0X6jAkEi8PWYYLyQKYlQ37883bDQ=; b=huHe0iYpkj1UVBm0gwn2Nb
 1sd6butnK/OdblXFFGceNZb7Bj+xPSJEgI/0Lldb2E2+ZX9IqFvGslzo30M86IsO
 6PsHEsUNKcuvh9BWo/xrlstgKWiqZAF/PNcscsTNkrqLIoDOcT1/9RV2TMqDKcPB
 mzDrsDgvwQqwavx2XHfTjfshEbf1WY7F8XJPvcQefGuWooay4veLHFjTnkRURhLb
 t+LyPi2S9efv7JKPRlRU18A01xhL/lnNwT2R14tJbTU3Vtoo9EwZHbX4BhNs4+7x
 HUXC03DLeO1B6rVXtkiimeADhA+syUha2scNrNE7ND0kHIWXJdpXNbPGTjDn2yyQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqvsftp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 06:12:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65H64mnx021541;
 Wed, 17 Jun 2026 06:12:23 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eudva9t0a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Jun 2026 06:12:23 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65H6CM1A10486372
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 17 Jun 2026 06:12:22 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2531758063;
 Wed, 17 Jun 2026 06:12:22 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4E6945805A;
 Wed, 17 Jun 2026 06:12:18 +0000 (GMT)
Received: from [9.43.52.172] (unknown [9.43.52.172])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 17 Jun 2026 06:12:17 +0000 (GMT)
Message-ID: <4eb83d0e-543e-4a4c-975f-18da426c64b5@linux.ibm.com>
Date: Wed, 17 Jun 2026 11:42:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] pnv/phb4: Add reset logic to PHB4
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: clg@kaod.org, npiggin@gmail.com, fbarrat@linux.ibm.com, mst@redhat.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com
References: <20260210134110.1515322-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-1-saif.abrar@linux.vnet.ibm.com>
 <20260305060923.3753402-3-saif.abrar@linux.vnet.ibm.com>
 <bdc3eaee-d117-476d-8d7c-2ffeb23730c3@linux.ibm.com>
Content-Language: en-US
From: Saif Abrar <saif.abrar@linux.ibm.com>
In-Reply-To: <bdc3eaee-d117-476d-8d7c-2ffeb23730c3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDA1MSBTYWx0ZWRfX0dSKxs8TH9jR
 NjLk0orgMRHOcypkeoKAr+hlYHaeqpgqJECvc6Rzp6gxgi6sWkhI7SVvMTy7O0oQHTYhVL6S9+T
 0leBzgXcvyNQpPRhbWB4K38V28c5mKs=
X-Proofpoint-GUID: D8c6Irk0Qw7OQt6mXGh97tx_RTPhx0Nn
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a323ac9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=aow-egSQAAAA:8 a=20KFwNOVAAAA:8 a=BVd8bmEYbGthRU22bVMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-ORIG-GUID: WSgjJ6bJh70wvXdmRCOanbjOWS_jyOip
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDA1MSBTYWx0ZWRfX2Wh8OWc0YsSQ
 UPyPMcyK5ue2+tGCqFXl7j8HJKw5nXOtfVdWLv2qoLCa1e1RybssHxL3Un3OZlBP7cXtWZ7p8w/
 k/a1+oOjmzj0XllQi0M65bPYujM0zSEgkw98cmc8Bro7E0VhWy0im/gZTxCffgYKkIi7JaNnHBh
 sF2SZVjUJYemvEwrLCBeUTwF0+w70C6Mat4gaVyvzKeWDauZ49ajIRm+L2cv6jogM+H1q7DxvEA
 0QdaiZIUzX80R3bP22CW/EZ+RQOA/FRwhHMTcDNfcmHO4FEHxkS5/V2Q+pLHUAL28MLYDDM+wHB
 iBAoDyAJ4gUtdY7F4GCs8nwBqISDkkUFv8MHQvLH6Xfq4X+r4CEhAvHFFo7xYt2DV++igmVwta0
 ijC1yUZtX3zLzWCPi+v1uyX1GVAdjYM3OeLiGUHeRHT62tlMTNuhaDcKNvn+WngXhEXxkBMVXq3
 07hASKoj/Jg/BKySN/g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170051
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
X-Mailman-Approved-At: Wed, 17 Jun 2026 02:22:58 -0400
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


On 01-05-2026 20:07, Harsh Prateek Bora wrote:
>
>
> On 05/03/26 11:39 am, Saif Abrar wrote:
>> Add a method to be invoked on QEMU reset.
>> Also add CFG and PBL core-blocks reset logic using
>> appropriate bits of PHB_PCIE_CRESET register.
>>
>> Tested by reading the reset value of a register.
>>
>> Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>> v3: Updates for coding guidelines.
>> v2:
>> - Using the ResettableClass.
>> - Reset of the root complex registers done in 
>> pnv_phb_root_port_reset_hold().
>>
>>   hw/pci-host/pnv_phb.c               |   1 +
>>   hw/pci-host/pnv_phb4.c              | 103 +++++++++++++++++++++++++++-
>>   include/hw/pci-host/pnv_phb4.h      |   1 +
>>   include/hw/pci-host/pnv_phb4_regs.h |  16 ++++-
>>   tests/qtest/pnv-phb4-test.c         |  28 +++++++-
>>   5 files changed, 145 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/pci-host/pnv_phb.c b/hw/pci-host/pnv_phb.c
>> index 0b556d1bf5..d4f452d7b2 100644
>> --- a/hw/pci-host/pnv_phb.c
>> +++ b/hw/pci-host/pnv_phb.c
>> @@ -232,6 +232,7 @@ static void pnv_phb_root_port_reset_hold(Object 
>> *obj, ResetType type)
>>       pci_set_long(conf + PCI_PREF_BASE_UPPER32, 0x1); /* Hack */
>>       pci_set_long(conf + PCI_PREF_LIMIT_UPPER32, 0xffffffff);
>>       pci_config_set_interrupt_pin(conf, 0);
>> +    pnv_phb4_cfg_core_reset(d);
>
> Cover letter says updating to PHB5 spec, but here we are calling phb4 
> specific reset in common phb code?
>
> If the reset logic applies to all versions of PHBs, we should better 
> call it just pnv_phb_cfg_core_reset(). Otherwise, need to better 
> refactor code such that pnv_phb.{h,c} contains only common code which 
> applies to all versions of phb, keep phb4 specific code in pnv_phb4.c, 
> export reusable routines from common code which can be called from 
> phb{4,5} specific code in pnv_phb{4,5}.c files respectively.


As mentioned in the code comment, this method is called for all PHB >= 4.

>
> I understand we already have phb5 specific code in pnv_phb4.c, but we 
> need to reorg it at some point of time, and it will be great if we can 
> do it sometime soon, preferably along with this series. However, I am 
> fine if you wish to take it as a follow-up work. Having said that we 
> need to get the naming corrected as applicable (i.e. just phb vs 
> phb{3,4,5}), so that later we would only need to take care of moving 
> phb5 specific code to pnv_phb5.c.


Refactoring PHB4 and PHB5 code is already taken up in a separate patchset.


>
>
>
>>   }
>>     static void pnv_phb_root_port_realize(DeviceState *dev, Error 
>> **errp)
>
> <snipped>
>
>> +
>> +static void phb4_tests(void)
>> +{
>
> I guess you meant phb5_tests here since using machine powernv10 inside ?


Renamed to phb5.


>
>> +    QTestState *qts = NULL;
>> +
>> +    qts = qtest_initf("-machine powernv10 -accel tcg");
>> +
>> +    /* Check reset value of a register */
>> +    phb4_reset_test(qts);
>> +
>> +    qtest_quit(qts);
>> +}
>> +
>>   /* Assert that 'PHB - Version Register' bits[24:31] are as expected */
>>   static void phb_version_test(const void *data)
>>   {
>> @@ -72,8 +95,6 @@ static void phb_version_test(const void *data)
>>       /* PHB Version register bits [24:31] */
>>       ver = ver >> (63 - 31);
>>       g_assert_cmpuint(ver, ==, expected_ver);
>> -
>> -    qtest_quit(qts);
>
> This should be cleaned up in the prev patch where it was introduced.


Added it back, as qtest_initf() to be followed by qtest_quit().


>
> Also, whenever sending next version of patches, please avoid sending 
> as reply to previous series. You can keep updating changelog in cover 
> letter with links to previous version when sending the next version.


Sure!


>
> Thanks for looking into it, significant work!
>
> regards,
> Harsh
>

Thanks,

Saif


>>   }
>>     /* Verify versions of all supported PHB's */
>> @@ -94,5 +115,8 @@ int main(int argc, char **argv)
>>       /* PHB[345] tests */
>>       add_phbX_version_test();
>>   +    /* PHB4 specific tests */
>> +    qtest_add_func("phb4", phb4_tests);
>> +
>>       return g_test_run();
>>   }
>

