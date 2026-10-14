Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC717CC6B2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 21:00:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH64m-0008A2-4M; Wed, 14 Oct 2026 16:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH64k-000897-Mj
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:59:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH64i-0008VA-L5
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:59:50 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EGZshx3469372
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BBWDYCK2U2u5hYkUdNKM5sK8qYvDJNn0g2Q02BsiSfo=; b=pPRzuq9lNMYErS9K
 lYdO739+6mKAaPtRb8ENil5+y9E0TQe03L4fnnLFto/0utbZhqsxkQjXm86LY6i3
 i85bTxmascfv4DY4ZIbOYF1/U1KExx3X+PiZebfA2+IjHkkDm9EDu2e9li7P/slV
 PP6QhcOQW8bpDP95LiL+D+7saM33TBfiKzX9m3MTIlYJdV5DUBTbJ3BduUOyIhTR
 0oj20eWwa5cgeZ3olRmsNrirVV4FjKvYPHioD/+ryaSCffKqY9SxT7wrMffkjKy5
 34UGynG4sqaxR7JmZmZXqO1TC4kXugkqXUuOwVSFQ/gZxByzHufaFPD5Nh+f/KSB
 Z4I97w==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hadd78xxh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:59:46 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3552883bd19so8452907eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 13:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792011585; x=1792616385; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BBWDYCK2U2u5hYkUdNKM5sK8qYvDJNn0g2Q02BsiSfo=;
 b=AUK3ijuM0FC8292iHOUzARkIE0wegCPKNp17nD/nDnA2OHiGbfp0oGSsTKqNkZnx09
 LB0Ai3J67NoPOotKXi6w6h6Iol3iv9BpzN1v/LL1zIWwsul03RGBRP8ewo7vS6q1dadG
 BlLNlP1YwLcPdaD0hSjE9jSL1mPDRlyEFB9YNFxqkfGwjB3RQRNcLz3SciLw3tA6qTUi
 3QYff2eT3ivLboOHlwQXYN26oZ4u18AWN5auGoW/AszdLLQeYn7FlE28XPBvblW/5vjA
 n+Xr7YE50Q5bfZnZvZh1Np6n42NY/+5kDbsm57mU79BsOLB6R38//HEjuoY/NjiF4cZv
 O5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792011585; x=1792616385;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BBWDYCK2U2u5hYkUdNKM5sK8qYvDJNn0g2Q02BsiSfo=;
 b=RtUc/Vl764NC5unj+LgQlTw+MyNR6rbuVoiNPJwaYWTsJTwUjETdXRHI+j5+XvuJk/
 urY57Rq/6d/LhA3xrZ7KgpeuEYgMoRWbZaz7ddEEarjoMxkJtSPw0sNfKc5hCdh8b/Ky
 mhtpmNIpERtK35tj9wkjmGQOWoPzRGeKlu5E2Bohy0Za0k6HRfGzWDhwgR6cKQfPXyqF
 ZQvQV764gfDroOTJX1FPeo7y07G7ZIh8H1wGheLli1hpTvIwNJyQZnjUp4Y2YPNKndYK
 jtWOZJluRlmvV978J9993lZX3OMzI0jFXhDZXt0Jn6iMvf8QEHxRThTAZTrPqVFSeNIq
 ZtFQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByBVsLE9wa94RfTxkbd03gcplldfNYkQRHRSCMLXphFCa8j0y8VvCmFK8Gex/xaH28ous05sZVBMsQi@nongnu.org
X-Gm-Message-State: AFq9FYIO5tQh0wYhr6pyjthHBVZbppefowZoEL560NSQg8mYGISKp7pH
 H9ej+sg0KiITOsWnSaKCTAHJj6daPJCOuXagD3tHlIqB73JqJCB22T2fmfZQyUknWkBeHX5ro31
 KuF0tQvA6rNOc+v8So9rKH5KcdSy86SJy0fWXxVXnS8zZ6C+aHdzLM2XAFg==
X-Gm-Gg: AYBFou0caVQ304XJXHTAbMrP90mpm7xvhw8mhWoGOt8/3Vyn4WJzG0aebUpLCwIRJLr
 kseTaJit9fxmCU0lMWugXcqOHIOm5CGhA8Jq+TrHcJ0q09pK7HIwiBb73pkwEtJC4MHEpqoRfSe
 UQyOFgDxuosTlpsBU1b8GlUjeEwsCpwj1doGA3SZ6J+TkDo1kHyTyNcc/hh5rLDxapsDD3dsJod
 H89KBLcS7d5ZsH4w5y4B/WGddPYcVp4ssTXYUA5gk7rebtJ/Sd0PUkscwTqIPQE0U42u/PXNpq3
 84EeN/qXydtb2vqjnGtbVk2eJGxO/oDQ8nsuLPqIdqrGPdxje05sCA0XdHM3jl1/zudpfQvGQWG
 gwy+ev+zdcrQUdt+noz0nRiW6VdpB3tAHvoPSfSYypTKPxBso/0omQMmHGVB82R+vbYCJaQ==
X-Received: by 2002:a05:7301:1929:b0:351:7ec0:daa3 with SMTP id
 5a478bee46e88-3537e04eeb2mr23743446eec.31.1792011585331; 
 Wed, 14 Oct 2026 13:59:45 -0700 (PDT)
X-Received: by 2002:a05:7301:1929:b0:351:7ec0:daa3 with SMTP id
 5a478bee46e88-3537e04eeb2mr23743412eec.31.1792011584530; 
 Wed, 14 Oct 2026 13:59:44 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35b690af3easm25812493eec.1.2026.10.14.13.59.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 13:59:43 -0700 (PDT)
Message-ID: <83913c7f-72cb-4c08-9215-b3233ca5c12f@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 13:59:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] semihosting: declare semihosting cpu ops
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
 <20261014182543.135965-6-pierrick.bouvier@oss.qualcomm.com>
 <09d841b5-8d8b-4f7b-8c62-e28d0e338d57@oss.qualcomm.com>
 <8eccbbad-9f8f-4b64-abb8-d634b3e5de3b@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8eccbbad-9f8f-4b64-abb8-d634b3e5de3b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BaVNQbt2 c=1 sm=1 tr=0 ts=6acfed42 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=ZWaQPk0mfVxbOS7YAckA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: II-ZYn1tj9HQOF-ZYvfreugLgm4T-4ib
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4MyBTYWx0ZWRfXxs+/11+t2BVK
 hEYgl5FJWTfIaE4xJ618/1ejozvAaFIFEFHC8Bk0nSVvH54w1LH4SwZF7a0RWEB8YE2yNE4mnB2
 beG781N3paMDScMT7c/qxlqpdIzCadn1NxbXkVO6iBB69CnH+2KXhG8jq6Ck+Phkt8psSs4fRVx
 yF+mSQkGDoEl8v1yhJGFOL/RlZlBhUKlPdA6dmf8A2C3BX3zzxjlTaB7ZDEDwIgL+yMHigK6+OT
 EghEWbpWGhygO5zprH5iTlLqzf+KZqI5T+JnKP50o2lmtsp6xHHjY3zg5Cb48kvjpwWOHRlgjcE
 xL5c8vE2g+bweh9h2Rr8B/sKuWnaBCXP3PcQV5vkqEINAnkdFxgn59KO/eWaklYhOM3Q2dh+4qc
 6hts139gJQmv9sQFG9slzaJ0u8qsp7kbh98z7f+38WyzAsgYLhex8+ZJ7lTKpqqHgzJ8sb9GpEe
 sZDF93IUCM8PCK9JHmg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4MyBTYWx0ZWRfXyq7wMHLJXsJj
 ayUx0i+glplKCwLBQD113Fnkgt8l0HQ0bfeBpoSxU42F4tHU5gtsPF2JPCMVGIjDKbP8jTk+B9q
 mmNH/Rq3qvBRMFo8symAXnRuSY05XXU=
X-Proofpoint-ORIG-GUID: II-ZYn1tj9HQOF-ZYvfreugLgm4T-4ib
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140083
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 10/14/2026 1:21 PM, Pierrick Bouvier wrote:
> On 10/14/2026 12:45 PM, Philippe Mathieu-Daudé wrote:
>> On 14/10/26 20:25, Pierrick Bouvier wrote:
>>> This allows a specific target to declare its implementation of
>>> semihosting.
>>>
>>> Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>   include/hw/core/cpu.h             |  6 ++++++
>>>   include/semihosting/common-semi.h | 17 +++++++++++++++++
>>>   2 files changed, 23 insertions(+)
>>
>>
>>> diff --git a/include/semihosting/common-semi.h b/include/semihosting/
>>> common-semi.h
>>> index 1e7699d7bbd..618f60f76e7 100644
>>> --- a/include/semihosting/common-semi.h
>>> +++ b/include/semihosting/common-semi.h
>>> @@ -34,6 +34,23 @@
>>>   #ifndef COMMON_SEMI_H
>>>   #define COMMON_SEMI_H
>>>   +typedef struct SemihostingCPUOps {
>>> +    /* Return argument @argno */
>>> +    uint64_t (*arg)(CPUState *cs, int argno);
>>
>> To be cleaned on top: const
>>
>>> +    /* Set return value for semihosting call */
>>> +    void (*set_ret)(CPUState *cs, uint64_t ret);
>>> +    /* Set an error for a semihosting call */
>>> +    void (*set_err)(CPUState *cs, int err);
>>> +    /* True if the guest is using the 64-bit semihosting ABI */
>>> +    bool (*is_64bit)(CPUState *cs);
>>
>> const
>>
>>> +    /* True if SYS_EXIT takes an extended parameter block */
>>> +    bool (*sys_exit_is_extended)(CPUState *cs);
>>
>> const
>>
>>> +    /* Return lowest address until which stack can grow */
>>> +    uint64_t (*stack_bottom)(CPUState *cs);
>>
>> const
>>
>>> +    /* True if SYS_SYNCCACHE is implemented */
>>> +    bool (*has_synccache)(CPUState *cs);
>>
>> const
>>
>>> +} SemihostingCPUOps;
>>> +
>>
>>
> 
> It's a nice intention, but this triggers more changes since some usage
> of cs will be inherently unconst, for instance riscv_cpu_mxl.
> Yes, we could patch all the callees to reflect real constness, but it's
> beyond the scope of this series IMHO. I'll keep it as it is for now.
>

It's luckily the only change required, I'll do this constification and
send a v3.

> Regards,
> Pierrick


