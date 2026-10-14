Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C4BCC6B2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH4z6-00041o-3c; Wed, 14 Oct 2026 15:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xH4z4-0003zx-Eg
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:49:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xH4z2-0002Aj-B1
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:49:53 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEbJHY152375
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xIzWdR+etPzAHiJmUNfvAqsevx1BleQykHLZSJ1Z7Sc=; b=D8bnM8Rc90ycDchZ
 XRidhSmK7HgqM0gHLMCTF3ZjirxgP3fmgq+AiiMG7qBlUaQMmLm4PHByMV7QvB0c
 OHHSpoUaS735PwJmeNtZ1P8yTQhynBkb6Rx8+mPMm78q9eQD9FuLjW4Rb+eKPhYB
 RrLViAjvq0PDe+5+Hr/A9OYu7zyJumsug5SCqmnNbhNUxtRLScBaZc2M+p/0S5uq
 hh8j/o4KG7LfvxE9WmNDgg0E/3uO28uy+zK/9IjD44XyzDq54+VfOOa8AFKvQVnm
 9FG0P8ItvyKmwAco14deXHjCf9nBMHMpx4cxVCQebEZP7gxKi93OVkbTflwNMkU6
 hJ/ndw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha7aejd2v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:49:45 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-934963b2bc0so875138885a.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 12:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792007385; x=1792612185; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xIzWdR+etPzAHiJmUNfvAqsevx1BleQykHLZSJ1Z7Sc=;
 b=OrcEuEorMW3rkCrSVd5/JcUQgq0pWNh4Z2O/SR8NSubpLfBD++XzZmW1xuTFDXoh11
 hra7I/idUx+ysvFmYkklElC1cfhzyaleiJoqWG1SzqSaumKIS+DwH5YSDbW9LelHYVLq
 hhxWzHtkIHqllnM5jYhSdJqC9Do0l2VBMOvLP0livxML35ANHshqloQG0P7RsLe11dvh
 MdIu6wDopBNbVUQ5cyH87ZKFh4CT57e0me/RtRbJatrDHIWfewyQrNwmL/l+mPXgC0mP
 44zgJtN1NOvlYmomcvvUdbYpshM/0A6EeiQOZ9scJR36Wdyk0r1AN0c+mDc4VeLlM9UV
 S+Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792007385; x=1792612185;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xIzWdR+etPzAHiJmUNfvAqsevx1BleQykHLZSJ1Z7Sc=;
 b=2CSL+HhbIKMpC7UQXDcY+CsWNhZ8CnY9VRfTPUvA4dS0Yn8eL80CtCqQbENwUmrert
 stlhUt/ayfkisjXlkC8fVv+NEgT/XczPQjqrKKdNOa76y6yCQ05Mf51f7cye/HDIrW1a
 NLw/xy6ji9z2F9mTD6mCDikgFmNZ1eOgcVSAA6zF27BniVL/dl+rG/R3/IUkfuk+I23T
 LoKbQAhpIsa05qNaIFQNa57IaK7Rdy19fLRhHMGPSV9dh/PewtfebTMcVAM+GrdMC6eI
 hsh0+zK2ON8MAIDhZ2W2jTWtFN5ZNCGv/zXBlL8KkoPo9KJECwejWZEJmwcpy/MMaK1k
 a5AA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxe+FLKXmuxKTq+5MN2Hn9uXmDPwsNUks0poM9NOGA8vbgbNFJM6INEq1yn4hbUSgDZY0+OjgcQlVWD@nongnu.org
X-Gm-Message-State: AFq9FYI5CwFjY5Wnj3oZrSnbRQbDp1/IB766AZroj4na4aS/p55pjl5H
 PdQEaYgOAhzwlvz+/V6YtpgCYrnP1XCQXoGQJVJbmjyLCAeUVz1XMOCzJaRYZ80hZNEhupiv8ni
 xrBhUzUTNnR8DtfgjicFhlrnsk9k3qEE7V5pn9u/TUAVijQ6/7YB3eQgxhw==
X-Gm-Gg: AYBFou0Da3VKYiCf0otLWvGCDRurlBboXcRFHgjRcXbH/1ZJXqsbqs4qg/SQynEZLU0
 rMCC90jgPdd613NgniFa9sGovD9uZ++BO9ZPjFnMX0FCucWXmYaROqhM1MH4g8iRnrLQbD70tWl
 bAYmwFY5l6m1YdwqMfiLfOKKabfre3vKbSsTUF7Y9WcJiJrRy/0+DCbt5heXrDkQZRgI8xrAcSA
 P7cvrd1ZGznNAXqnie8zBRoKmpaAa7TatwyJqCG0rmkfEQvtRKRMN9U5jTR17r6i6qi8A/IlGy+
 a+dCngsXK+mTwDb1cyKu+bqfjYwMnfSo8LqAHzTFxKJ4supzXJ8mfbaQ6WgeQpwM0InLn01Y9Li
 pvX6hg5ge6VFC7osF/5Ed8YK9p2cwfdZ8HQ==
X-Received: by 2002:a05:620a:3942:b0:93e:e531:b78d with SMTP id
 af79cd13be357-93ee531ba1cmr1537822585a.7.1792007385159; 
 Wed, 14 Oct 2026 12:49:45 -0700 (PDT)
X-Received: by 2002:a05:620a:3942:b0:93e:e531:b78d with SMTP id
 af79cd13be357-93ee531ba1cmr1537820785a.7.1792007384725; 
 Wed, 14 Oct 2026 12:49:44 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd91c55bsm13048565e9.0.2026.10.14.12.49.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 12:49:43 -0700 (PDT)
Message-ID: <f5af12a0-1022-4ad6-bb60-b1ad291f1907@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 21:49:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] semihosting: declare semihosting cpu ops
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
 <20261014182543.135965-6-pierrick.bouvier@oss.qualcomm.com>
 <09d841b5-8d8b-4f7b-8c62-e28d0e338d57@oss.qualcomm.com>
In-Reply-To: <09d841b5-8d8b-4f7b-8c62-e28d0e338d57@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfXzxxgClcSEyW8
 kVAFT2asAb3sVhunZZ8Kgb9umc+Mh5A4NT7unYuoJljdsEySseHm0sDxZFefdJUZG+5SLxqOlvf
 yovrZYyXXRdLS9IViGG3m3zbpnbQDTAaKBR9hTaspSOMvGNVbhYOuAaa42T8cVDCEiqLUsFNw+t
 /28ukqZ2pwKBSDSNMo4i++bKYTYFnEu5sfH1s+5eUSd1suQF/PkkA+qLc73zT7cNdOzUm6E0jDm
 0z+2dMmd9bJofn/GJ7aG5tnktkQSI0wTfEJJuGI/nRVkQgImLjMCGX3ZlBEDbl4gh1aAu/GQxi8
 drH7OH7wUrcY85ZJvkwSkChrRIq0f2MtfdSa0f8fwTSBHhw/2MHTzydrBXVkhkmZZbdVu0ro52P
 wByMR0JtfaKtUk+nPHfLYTZ0G2lYNw==
X-Proofpoint-ORIG-GUID: Ag_V1b_LW7kz7P5JcMU-7bh-bl5UETZY
X-Proofpoint-GUID: Ag_V1b_LW7kz7P5JcMU-7bh-bl5UETZY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX617Ctd8DLQSU
 RWyyX3a50575sK8WJX5pJW482QYE+GtmC4HKK94I7Lh3nX0pMybpYuW6OIjmAzMWNdxCKPSLa4c
 mjyyFRYXJgRx+Jtb+0syFERnqv7LHfI=
X-Authority-Analysis: v=2.4 cv=NctzRGD4 c=1 sm=1 tr=0 ts=6acfdcd9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=hwid9rXpeu7gJ50w8eMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 spamscore=0 malwarescore=0
 phishscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 14/10/26 21:45, Philippe Mathieu-DaudÃ© wrote:
> On 14/10/26 20:25, Pierrick Bouvier wrote:
>> This allows a specific target to declare its implementation of
>> semihosting.
>>
>> Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   include/hw/core/cpu.h             |  6 ++++++
>>   include/semihosting/common-semi.h | 17 +++++++++++++++++
>>   2 files changed, 23 insertions(+)
> 
> 
>> diff --git a/include/semihosting/common-semi.h b/include/semihosting/ 
>> common-semi.h
>> index 1e7699d7bbd..618f60f76e7 100644
>> --- a/include/semihosting/common-semi.h
>> +++ b/include/semihosting/common-semi.h
>> @@ -34,6 +34,23 @@
>>   #ifndef COMMON_SEMI_H
>>   #define COMMON_SEMI_H
>> +typedef struct SemihostingCPUOps {
>> +    /* Return argument @argno */
>> +    uint64_t (*arg)(CPUState *cs, int argno);
> 
> To be cleaned on top: const

Actually looking at how the series is structured, this could
be done now. I'd rather it but won't insist.

> 
>> +    /* Set return value for semihosting call */
>> +    void (*set_ret)(CPUState *cs, uint64_t ret);
>> +    /* Set an error for a semihosting call */
>> +    void (*set_err)(CPUState *cs, int err);
>> +    /* True if the guest is using the 64-bit semihosting ABI */
>> +    bool (*is_64bit)(CPUState *cs);
> 
> const
> 
>> +    /* True if SYS_EXIT takes an extended parameter block */
>> +    bool (*sys_exit_is_extended)(CPUState *cs);
> 
> const
> 
>> +    /* Return lowest address until which stack can grow */
>> +    uint64_t (*stack_bottom)(CPUState *cs);
> 
> const
> 
>> +    /* True if SYS_SYNCCACHE is implemented */
>> +    bool (*has_synccache)(CPUState *cs);
> 
> const
> 
>> +} SemihostingCPUOps;
>> +
> 
> 
> 


