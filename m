Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2110BC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 18:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uACFH-00024Z-1d; Wed, 30 Apr 2025 14:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uACF9-00023x-VL
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:33:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1uACF7-0006pA-AT
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:33:15 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UB4CXU025985;
 Wed, 30 Apr 2025 18:33:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=GCllil
 89j8m9iYH6ZPtQOsBmk1NUEtfdrcigMO36UKo=; b=EhI7+cnvZBm+Z8RHiZT1qF
 abbo1YobEngr7tNClLMZiA30nFuI4ECOkOncOVMcFZOxFA9Qw+ckTQRKGJvO07ig
 CVmsgLL2S4Yv8lZvvLdpAjB5TOQVvHa9FqEh2P1bE3T1dm9CfyilIwzo9peqh8Y7
 G3y9qFpuyApumJXO4dJa1Ai2YsF/zF1/1mAbGSEtJjeJBjlsGHy3Euk8ep72vhdt
 x64IK15GCIIgbVgBb7JG2JjTj8O5Uhz/7kI5azPB6Xdgz7B27SnX2HWRRLGp1ul9
 gIvyuuQ+UJaivMD+Xrsxqflpfe0B/H+DJsiSQ1O3+knRcJxL0QqbPv4iA+SvFGoQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46b6wwctmd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 18:33:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53UGKKco000717;
 Wed, 30 Apr 2025 18:33:06 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469atph83q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 30 Apr 2025 18:33:06 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53UIX4Z229688332
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 30 Apr 2025 18:33:04 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8FC3958050;
 Wed, 30 Apr 2025 18:33:04 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 50C5158045;
 Wed, 30 Apr 2025 18:33:02 +0000 (GMT)
Received: from [9.61.242.230] (unknown [9.61.242.230])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 30 Apr 2025 18:33:02 +0000 (GMT)
Message-ID: <12288279-df65-4869-84a3-b42ca47f9a7a@linux.ibm.com>
Date: Wed, 30 Apr 2025 11:32:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] include: Add a header to define host PCI MMIO
 functions
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, stefanha@redhat.com, mjrosato@linux.ibm.com,
 schnelle@linux.ibm.com, philmd@linaro.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net
References: <20250417173801.827-1-alifm@linux.ibm.com>
 <20250417173801.827-3-alifm@linux.ibm.com>
 <8decd67b-f1f7-4dcb-b2d5-519ea907e317@redhat.com>
 <e07375e3-6984-46aa-90b7-848594539f81@linux.ibm.com>
 <f632f551-b9c2-4474-9116-eaea3e2b4410@redhat.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <f632f551-b9c2-4474-9116-eaea3e2b4410@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IyK-OkS1z938rljNedZ_ukhjyWVo0tki
X-Proofpoint-GUID: IyK-OkS1z938rljNedZ_ukhjyWVo0tki
X-Authority-Analysis: v=2.4 cv=GOIIEvNK c=1 sm=1 tr=0 ts=68126ce2 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=NEAV23lmAAAA:8 a=fwGQEqoWTAA2FJirNzMA:9
 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ImwWUX5h3JJ3gRE9moBe:22 a=z2U-W3hJrleVIN9YIjzO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDEzMSBTYWx0ZWRfX7NmeBPgCiIe1
 lBKcZrxyZA+uHQrspBVPgWENYiV1eq6qsd9kA+SW5qadh1P3CKSnwuq1U8CdacHSMagSkqELzyl
 PGQoeHtNi8IvRTZ9hesV0wRo7pl1oAb7TMT9wWu5x3vK/tUQZUt9STIiE8cegjT4/hFvnOdRak7
 yiNaVAQdGr2DtgZ/Bs0FdP7wSi14h8fgHZMnY4bktOAYYWZ61TGHWmh/EF+ESgwrbfEggBtO02U
 NuaUUh/u3zromAMPkQScc1YNLQ8vM32iAnD3UsznJ+/VXf8ZAIg2M3vxC1ngyjB9uD3uxpjwFj7
 Um5JIv0OBTcLoxCs1iHQKrFHZc80KEjHVGmZZFI0cT+OwoNQZhaPnU/ewMZx+igLQM/wo8WOCB1
 UoIjGaNHuAsfHZ/tcZI/qGvtJ8s1ll5U2zrmNnRt0sMxy7KWRFV1zRRT6EQp8yolsBKBIfP2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 impostorscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=904
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504300131
Received-SPF: pass client-ip=148.163.158.5; envelope-from=alifm@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 4/30/2025 10:52 AM, Thomas Huth wrote:
> On 30/04/2025 18.47, Farhan Ali wrote:
>>
>> ..snip...
>>
>>>> +static inline uint32_t host_pci_ldl_le_p(const void *ioaddr)
>>>> +{
>>>> +    uint32_t ret = 0;
>>>> +#ifdef __s390x__
>>>> +    ret = le32_to_cpu(s390x_pci_mmio_read_32(ioaddr));
>>>> +#else
>>>> +    ret = (uint32_t)ldl_le_p(ioaddr);
>>>
>>> This is the only spot where you used a cast. Is it necessary, or 
>>> could it be omitted?
>>
>> Yes, the ldl_le_p returns an int. We do similar cast here https:// 
>> github.com/qemu/qemu/blob/73d29ea2417b58ca55fba1aa468ba38e3607b583/include/ 
>> qemu/bswap.h#L416
>
> ... but that function there returns an 64-bit value, while you are 
> assigning the value to a 32-bit variable here, and you also only 
> return a 32-bit value from the function here. So there is no way that 
> this could accidentally be sign-extended, could it?
>
>  Thomas
>
>
I checked the Linux kernel and there too we seem to be returning 
unsigned 32 bit values (readl) for 32 bit mmio reads. So I think it 
should be safe. Do you think we should remove the cast?

Thanks

Farhan


