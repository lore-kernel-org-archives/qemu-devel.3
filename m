Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EB04C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TpW-0004ZZ-94; Fri, 04 Sep 2026 09:19:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2TpS-0004Z3-AL
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:19:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x2TpP-0007Ff-04
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:19:37 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684AIAqU2094857
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 13:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ooexmYzr9QlTng9xMh8zj/GqVmvTdaKOOZFS/znyFdA=; b=AYzL8BwyEWr7xUHI
 +6KFIQsjNDSajl1SxLmljMgRuuKYYKNpDDoPJXOaYOr/Jo+6w+zDGeiAzywKTMrB
 JRdmod722KjVTqT6Vd5BlCxc6KA+7L56l8dAeVHah3n54srOyAsuZo8+ykdwL0+n
 9iKXJNUU1vluw9zuu8dsSCLiK4uz+Ia/ndAnWmqng+yHWlmUTwhEKk+MntmbXdsl
 O8IbAKANw2k8jTSH3bcOFGVbtq/tSkv9MdDQ0bQGUJ/VjEdQSBf/ol8+XEBlgxLq
 S/rea72vM9aVdJ4W3obKJiSPwBwiinpn4raHMNNV2bPdSz34hf7n1J64HWrwb90Y
 Obf+ew==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfpmqss5w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 13:19:31 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-9804eacbbefso78603241.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788527970; x=1789132770; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ooexmYzr9QlTng9xMh8zj/GqVmvTdaKOOZFS/znyFdA=;
 b=FC6NcIpO0j1TKBDOKTODUOnMEQRA1eRpwNvbsAmeX5oMw2hHhGz6/ypOplNIjfKu+H
 HXM8dv7esqJZOSu2rG/W8B0ZqFNIE8VD9mBUo0lgchARIjir3eKy4cqFm9HhzubhBMfl
 DjNsrGlERhTU1xcMLGugj/Bt7ThBkG3CzJR2bOkRJclp/SsE9fE9omr7ijhfbUI4F6py
 IbKqTKu6o+uyg7y5lx2BP4Sg3FrZXwuNVzxTeXb4nHvoOjOZjH2lZo2ncTPoPiR6cqLl
 W2JZBNnxwdQtFxqtBk2rtobNCvYt4MRDXJT7vaCV6+9G57IH7vj0nb9F+2L8L8ueFXIM
 w/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788527970; x=1789132770;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ooexmYzr9QlTng9xMh8zj/GqVmvTdaKOOZFS/znyFdA=;
 b=QaOaSJaiMh9d9ltg8yfKDZJGJg/027P7g5i4NIIQy9ySeEvU3Rp/CsVwrM6wGdIVjG
 4QfTBuhatHa24lcLHzbWpz3IEEcb4A05JtCRd2ksMOtnrGTIRaze8XWSorWh/3lArfBv
 RS32YypMa1N8WlFEjU6leH/mfTkwxoFwY9pKLGrPBEOuL+qbgFdE9v8SNl5B6OKsLrek
 Aj1CHhX0ydrgETefR4euVxuThI4U7pL6/w88OB916Iczmo0HKra8SbSGDEF0A05qzUhG
 gFKaelz6xdrwyUtXH20XDtRjeLRUrE5FCyMVbAtHV43jk6LDyuC2DUL2HgDd6HM1D472
 ccwg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzeXHfuyrq1JAo52XN64ulkfoPKxWKsRGt4XF5uUS4+1n4HE7mfz20DtJvnQscBKl2v3gM2kW2ed2pQ@nongnu.org
X-Gm-Message-State: AFuF++m1Bn9dm+YVzD2PpywDb9sjxLbwVwx37KmjcsPXM9Ihtefhm879
 6fUIhOI/s+PAjVNtK5CMEApeG+o9SF5tVn7uWLydeoA0P38bOoYCSZw2IEDE/Wns1EjttNzA3Zo
 r5mz0VWCHSPa0zmpIPQmdLJgHpJLEJaPVAHCq4TEee745gz68wsHKMKopnA==
X-Gm-Gg: AYBFou2KESkRnUNduRveQ9U1HcTXHtDMxNjBHypaUQSlOitcW+caOm9SYggHYEAEMxG
 DTfVIbdiSVcSljpjitG9KZKRB8dzkmHsHqEP7FczC2dYXmcNrlcUw+eMBjETnFjl1IVopCosswu
 T5TEKjxSDIGyOt58pf1jJMJOh/uechdNlDCHodHNbtnQOSwM8snPXWlhZr7SvXBooab5Natx5sX
 HUF2YHtwclVQpa3Dsz6S/fJW9MCmvkMpOV9fbY1fJlV2XPcdAYMlEjEbX7xWj9duv+M6YA5mUJz
 Dfz9oRSqP0NvqsYeErFLJ1ZuIx5XjWZ6dk8bqhit7yu/b/OEY0m1ehL1HH6rWuunFbR0DPl4IiJ
 4jl7spUFChKKA2x1veFBTimRbzwAKACJFlg==
X-Received: by 2002:a05:6102:292b:b0:782:e19d:6f39 with SMTP id
 ada2fe7eead31-78a4a483c93mr1602143137.0.1788527969737; 
 Fri, 04 Sep 2026 06:19:29 -0700 (PDT)
X-Received: by 2002:a05:6102:292b:b0:782:e19d:6f39 with SMTP id
 ada2fe7eead31-78a4a483c93mr1602132137.0.1788527969284; 
 Fri, 04 Sep 2026 06:19:29 -0700 (PDT)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885be01bsm5845465f8f.31.2026.09.04.06.19.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 06:19:28 -0700 (PDT)
Message-ID: <f6c3b52e-dac2-49a2-8f68-8deb2baacab4@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 15:19:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] target/hexagon: gate GPCYCLE guest register
 reads on SSR:CE
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
References: <20260901173353.200474-1-brian.cain@oss.qualcomm.com>
 <20260901173353.200474-7-brian.cain@oss.qualcomm.com>
 <f7f34a43-c1cc-4dd8-a859-9ab72e1b015f@oss.qualcomm.com>
 <f06d81b1-35f8-4668-a92b-1d78c129d83c@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <f06d81b1-35f8-4668-a92b-1d78c129d83c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDExOSBTYWx0ZWRfXxOebAojnLz7E
 AoHerKjzOmjKiVzmFFoyO1dZeFCSqw8aUD4hq72MZ/slFlGbvHxQvjBNkZ79/szeqyOPXJ91yGf
 4xDW5Yd4X2KpNo+odd/Vy9FkR1o/f/Y=
X-Authority-Analysis: v=2.4 cv=eovvCIpX c=1 sm=1 tr=0 ts=6a9ac563 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=ePHWwmZI0fW8Pd2OE1IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDExOSBTYWx0ZWRfX2KGGk7tSC6gS
 7fHCutcUEt6xEY1TOHzIS9v+drsjeb+shnEKzMjm72fB0qa26cRo4lPlUaQtuLfLKR0BbwppQr9
 j29JohsohD4VHw1VYp3W8BaIA5tS25ZRPMgQObPXzRj4h6zRUyxXfSbccfxBXTEkX92x21FZ50v
 Vd1MqVtPDul413vzN9O6IYDgVssT5FrVstXbBqlN2/jpTRAj9sOtX6/NY2u2NjgR6NX87BlAiXX
 tnWlXl8oNZhQeTkz/LVODcJT0ULbMM3e8awz8H2kmEulRANDu18UxMRgu/uT25ZvMyBBwsUXbaY
 AbNsWY0PioUT0qTxHRCgZf8OLjPNlthr36mji9cxZkbgPmpm5U6daJTf6+utzAa123ek51xN2ck
 3T69TXHwCn7kWkixae4Wj+FzX6z39t1KlhqyjbMie4Km7CjOFSBekeGc2gji7uV4NdMekS3iMMz
 QRzjElz52eX9DWOfosg==
X-Proofpoint-ORIG-GUID: RpkZB-Zy5-z4-AgVRwbZfPfmLI24PvsK
X-Proofpoint-GUID: RpkZB-Zy5-z4-AgVRwbZfPfmLI24PvsK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040119
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 3/9/26 21:36, Brian Cain wrote:
> 
> On 9/2/2026 4:16 PM, Philippe Mathieu-Daudé wrote:
>> Hi Brian,
>>
>> On 1/9/26 19:33, Brian Cain wrote:
>>> GPCYCLELO/GPCYCLEHI read as zero unless the cycle counter is enabled
>>> (SSR:CE), matching the hardware.
>>>
>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>   target/hexagon/cpu.c       | 7 +++++--
>>>   target/hexagon/op_helper.c | 9 ++-------
>>>   2 files changed, 7 insertions(+), 9 deletions(-)
>>
>>
>>> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
>>> index 23894ff3d28..2cea1927263 100644
>>> --- a/target/hexagon/op_helper.c
>>> +++ b/target/hexagon/op_helper.c
>>> @@ -1912,13 +1912,8 @@ uint64_t HELPER(greg_read_pair) 
>>> (CPUHexagonState *env, uint32_t reg)
>>>           return (uint64_t)(env->greg[reg]) |
>>>                  (((uint64_t)(env->greg[reg + 1])) << 32);
>>>       }
>>> -    switch (reg) {
>>> -    case HEX_GREG_GPCYCLELO:
>>> -        return hexagon_get_sys_pcycle_count(env);
>>> -    default:
>>> -        return (uint64_t)hexagon_greg_read(env, reg) |
>>> -               ((uint64_t)(hexagon_greg_read(env, reg + 1)) << 32);
>>> -    }
>>> +    return (uint64_t)hexagon_greg_read(env, reg) |
>>> +           ((uint64_t)(hexagon_greg_read(env, reg + 1)) << 32);
>>>   }
>>
>> Just curious, does greg_read_pair() work with impair %reg?
> 
> 
> Not sure if I understand "impair %reg"?
> 
> But - if this refers to the odd-value pairs,

Yes I meant 'odd' ;)

> then no - they don't.  The 
> guest reg encoding only has the "g{odd}:{even}" designated by the even 
> reg's value.  Sent a follow up patch to assert this in greg_read_pair().
> 
> -Brian
> 
> 


