Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F147D606A330
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QTn/JLrK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUNZy-0003lt-AL; Fri, 20 Nov 2026 07:18:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xUNZw-0003lT-Jz
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:18:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1xUNZu-0006dU-SS
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:18:56 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKAuK1I1668923; Fri, 20 Nov 2026 12:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=eM/ufT
 ZlP8lY2vNhQLxF8QTtuoo6WoCp6eXKDR/Jq7w=; b=QTn/JLrKatFOxq/xl9c/QX
 7LAhJyo7eNnEfGauN2jDL9BnBKm6rXh+g87r0VNE3J/o8O89auZeTSLgK6T3Pxad
 RyXn3d4G9tZSZA1sHkvm3mL8hg3idVjyNWwJDWNyLRFncWhqpw/9UHi5cvGYQ32b
 Yp9qOVq/v7lhIUtu0hVCa3TsDTJ+j2u+o7eswOME3SXihbKIWVNhZSDc8JBCYALN
 g7x4gEIbd2Cmk5BI8ajgSjRB37Z9CDDVjo8br+ioYeMlWZaSlmWV4wqjERYtowwb
 h+KbuviviyEvRZ+Bz9sFj28BlAiHzB+oHxO674M69ncLHb9idOwhYeQgEtrktlxg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105w7vdr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 12:18:51 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKAnxEW2162679; Fri, 20 Nov 2026 12:18:50 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j1m3j226j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 20 Nov 2026 12:18:50 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6AKCInDt27066994
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 20 Nov 2026 12:18:49 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6811258054;
 Fri, 20 Nov 2026 12:18:49 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D14E558045;
 Fri, 20 Nov 2026 12:18:47 +0000 (GMT)
Received: from [9.43.40.220] (unknown [9.43.40.220])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 20 Nov 2026 12:18:47 +0000 (GMT)
Message-ID: <a0d881e1-755b-48d8-931c-8291af54db16@linux.ibm.com>
Date: Fri, 20 Nov 2026 17:48:45 +0530
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 3/6] MAINTAINERS: Step up as maintainer for PPC KVM CPUs
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Amit Machhiwal <amachhiw@linux.ibm.com>
References: <20261119113207.79328-8-harshpb@linux.ibm.com>
 <20261119113207.79328-11-harshpb@linux.ibm.com>
 <87o6bj69ig.fsf@draig.linaro.org>
Content-Language: en-GB
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
In-Reply-To: <87o6bj69ig.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Mp4TlShjQ28VQFrZgdUgVn7bjlsb-s1b
X-Authority-Analysis: v=2.4 cv=Z8x5j3RA c=1 sm=1 tr=0 ts=6b003aab cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=f7IdgyKtn90A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=aESoteyOajKGsK0g2owA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Mp4TlShjQ28VQFrZgdUgVn7bjlsb-s1b
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA0NyBTYWx0ZWRfX3IomDkE47mO1
 kF7TpVo+wgBwX6VDfLR/wKBrYRY3poYVacHNXgOZ81KEDcIQel1prUJY5CGY+no7BwRYye7UT+h
 CIOwS0dp/FU8+lF7z41bk8zNVr8Q8pY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA0NyBTYWx0ZWRfX6haxnI6gvwfO
 oHmmg1kdGr7eozEUXda2PV+0amzbU6EkfuRu24+6+r6THxNkJCg543KOvRf/LDDEQ9HK5MXe132
 sI6gBapEgd8h3GB/6cUZNsfL7/xUDgWPqTlu/hGsJ61NshH/RxYDXADv+XsjEK4lvXQfG7nyKcD
 gyWJ1GpmxISvETfwd8s/dPESlKCWZlOPi791/f4Vcu+c4KI01FR/FqMxRavWEV1Gt10wEU5nVUE
 g9Hdtq9zjMPDpGPsTO1qi1+XeM2lUW2NxiWkQYZVJ3I/qIG0LZE2AgOiKjlfwzRmPSx9CzR6+zt
 Y5S/GaTmO8QM24d6N4nZBHockw+WQcEHb5syXfoBb+5RtZygPPmqmEKpJ9OwlmhrP1QTB51xVSD
 OEbEW7dCYjaWNMNVSpCIBH/apqT6ACAgbftT/h9tIR1SPLHKaDmJdzQVLoPazz0lOe1FkKnaSF4
 7QrLKJSGcy0LfW2yhVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_04,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200047
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 20/11/26 4:43 pm, Alex Bennée wrote:
> Harsh Prateek Bora <harshpb@linux.ibm.com> writes:
> 
>> From: Amit Machhiwal <amachhiw@linux.ibm.com>
>>
>> Update entry for PPC KVM CPUs: move from Reviewer (R:) to Maintainer
>> (M:) and reflect the improved coverage by changing status from
>> "Odd Fixes" to "Maintained".
>>
>> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
>> Link:
>> https://lore.kernel.org/qemu-devel/20261112164617.85849-2-amachhiw@linux.ibm.com
> 
> You should check your tooling as these should be Message-id: tags.

I see. I should take care of that going ahead. Thanks!

regards,
Harsh

> 
>> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> ---
>>   MAINTAINERS | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index dcfdecedcf..0492190107 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -515,9 +515,9 @@ F: tests/functional/aarch64/test_kvm.py
>>   
>>   PPC KVM CPUs
>>   M: Nicholas Piggin <npiggin@gmail.com>
>> +M: Amit Machhiwal <amachhiw@linux.ibm.com>
>>   R: Harsh Prateek Bora <harshpb@linux.ibm.com>
>> -R: Amit Machhiwal <amachhiw@linux.ibm.com>
>> -S: Odd Fixes
>> +S: Maintained
>>   F: target/ppc/kvm.c
>>   
>>   S390 KVM CPUs
> 


