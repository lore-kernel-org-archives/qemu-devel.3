Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9440CDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 06:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcdGU-0002Va-BO; Thu, 25 Jun 2026 02:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wcdGS-0002Tp-N8; Thu, 25 Jun 2026 02:08:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1wcdGR-0000aB-1a; Thu, 25 Jun 2026 02:08:40 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P3mNs42889202; Thu, 25 Jun 2026 06:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=bSV3dJ
 Gz7vjlm2IWNkVQl/IKf9n913HrKidCc1q6+1M=; b=IX3rMXqtnzwwJNYhYirKRL
 S4WNToLa8mU49fhAp2670w5/EaWswwhGrL4T4YnAgm+ddW3eQEzLUpWDvAgnHxo3
 mLaqm5deqYNtiumsAwOdc5P8NPakeZDCDoKLloH5pgV+t+odAyHvHd/Kz09wllxK
 hSYWOYGe5meuEKcfK5X7Ox9mxpwf1zEkKUIW9rtOh9Si/pIsoqt7gZnvbAVmivwL
 e6o16yvmZbP8SHLhcXSGoQoiOAfNjHoSsJ/r4bZdObIPJ65oliHp3zP76l55TlpD
 jSIJPcfP3xUjBvtXFSwAN6DvNn+jlmYvBdMd6LPUHwTtmPY6kV8k7t74rKvDOdHQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgsyur8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 06:08:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65P64gb8030689;
 Thu, 25 Jun 2026 06:08:27 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phmncd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 06:08:27 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65P68PYK11534962
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jun 2026 06:08:26 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A44A858051;
 Thu, 25 Jun 2026 06:08:25 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 596635805C;
 Thu, 25 Jun 2026 06:08:19 +0000 (GMT)
Received: from [9.123.1.190] (unknown [9.123.1.190])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Jun 2026 06:08:18 +0000 (GMT)
Message-ID: <95280841-3f37-4e90-8e8e-149d659c3f1b@linux.ibm.com>
Date: Thu, 25 Jun 2026 11:38:17 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] tests/qtest: Add Power11 chip & machine to qtests
Content-Language: en-GB
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 Misbah Anjum N <misanjum@linux.ibm.com>,
 Anushree Mathur <anushree.mathur@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 kvm@vger.kernel.org, Gautam Menghani <gautam@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>
References: <20260623141933.577981-1-adityag@linux.ibm.com>
 <20260623141933.577981-4-adityag@linux.ibm.com>
 <54a9b8d16347f6cc94a625aca81897ba6b875385.camel@linux.ibm.com>
 <ajvemcUx0k12xOIW@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
 <4edf1ef8-1d88-4ad1-92eb-d587974bcd20@linux.ibm.com>
 <2afab235-5239-8663-a35e-91ce83485ca0@eik.bme.hu>
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <2afab235-5239-8663-a35e-91ce83485ca0@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA0OCBTYWx0ZWRfX0WWmy5lPRc/p
 uu5DsUDBgoZDr5ljmP2tjxxD/DNN15x2xfbQeGaD0Wh/0uN96395YItSm7Vp3pgThrKbLgZTpg+
 R8lcHtj/Y4lmvJXm2XhGAmM73OstDkAh8hkK2cHjz6j2g92tlh8mS3JSoV1eaMo3XwWHjuQ3AKf
 fuFFuChievDS3es6BVLv89pDU7n2425r0tVhNePYGPX+WaOVgHbMsRaXcZ9ZENJTmo6v4P/3/cL
 gScolxfuUNQBX+UMXZWz4bMmFvyO8PRVOvhSVO6uEe7yWLZW8MW/JOCSdMUXq4FNlCHQMitCjpO
 EDy8ad8nB6QmS0RbCGecbFe0bKyQUHYlxppChzOsk78sBd2WtLciPGXeu10w8Y/oRPEG2sZfslc
 I5OG97srXpXu7qmGPUvZk5OCuwTApKU1P2fdTUG0HRANh2fRJSUymiyaVEvDY1JHogFnltsyGUx
 hxbwMbOL8M5/eYYLptg==
X-Proofpoint-GUID: kZ33jlWSHrfl-3pnnUOUmM3OCXxaYTGB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA0OCBTYWx0ZWRfX+tYTXVEMNwlG
 GQA9kKCWuNOfpCj0ylmXbRjUAekq8BKcfbbvEggmXP4vsSv9bRKpCb/P+EQ2/DJVdnP5NN9v+po
 0q7qTMn0a2oFDgaTqqRuwUhbmTNamOo=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3cc5dc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22
 a=K921VAwX_w4cuZeCnOoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ulxAsjOvQ8vn7N-_ZS5LQ1YqVbd8fhG0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250048
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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



On 25/06/26 11:33 am, BALATON Zoltan wrote:
> On Thu, 25 Jun 2026, Harsh Prateek Bora wrote:
>> On 24/06/26 7:14 pm, Aditya Gupta wrote:
>>> On 26/06/23 09:24PM, Shivang Upadhyay wrote:
>>>> On Tue, 2026-06-23 at 19:49 +0530, Aditya Gupta wrote:
>>>>> +static const char *pnv_get_machine_type(enum PnvChipType chip_type)
>>>>> +{
>>>>> +    if (chip_type == PNV_CHIP_POWER8) {
>>>>> +        return "powernv8";
>>>>> +    } else if (chip_type == PNV_CHIP_POWER9) {
>>>>> +        return "powernv9";
>>>>> +    } else if (chip_type == PNV_CHIP_POWER10) {
>>>>> +        return "powernv10";
>>>>> +    } else if (chip_type == PNV_CHIP_POWER11) {
>>>>> +        return "powernv11";
>>>>> +    } else {
>>>>> +        g_assert_not_reached();
>>>>> +    }
>>>>> +}
>>>>
>>>> How about refactoring to the following?
>>>>
>>>>      static const char *const machine_types[] = {
>>>>          [PNV_CHIP_POWER8]  = "powernv8",
>>>>          [PNV_CHIP_POWER9]  = "powernv9",
>>>>          [PNV_CHIP_POWER10] = "powernv10",
>>>>          [PNV_CHIP_POWER11] = "powernv11",
>>>>      };
>>>>      return machine_types[x];
>>>
>>> Has a subtle difference, that it may not assert/segfault on unknown
>>> value for x, I want the test to crash/fail if this is called with an
>>> unknown/new processor chip. I believe the if-else/switch is better as it
>>> handles (by 'crashing') unknown values too.
>>
>> We could just do:
>>
>> if (chip_type >= PNV_CHIP_MAX) {
>>    g_assert_not_reached();
>> } else {
>>    return machine_types[chip_type];
>> }
> 
> Or even g_assert(chip_type < PNV_CHIP_MAX); without the if?

Absolutely :)

> 
> Regards,
> BALATON Zoltan
> 
>> That way just adding new array entry would work for future chips.
>>
>>>
>>> - Aditya G
>>>
>>>>
>>>> ~Shivang.
>>
>>
>>


