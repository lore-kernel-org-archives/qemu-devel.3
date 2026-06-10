Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C886CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 09:38:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXFNS-0004q2-2m; Wed, 10 Jun 2026 05:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXFNQ-0004pU-DJ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 05:37:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wXFNO-00020q-Oa
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 05:37:36 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65A7ipR6997567
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lM5UWcwDDxSAAYu0W+ChEIVwJmkj+A9RIiZ34ZrORdQ=; b=V1FbUH6sZ3gPxPfa
 oC8B4Dyn90UOWXN42bLVnJK6Jf/DxDNHpXd4CDMsEMOD0dMqi0aNCm17nGJPT9pN
 ksaJo06ARi/NuIky+V2WnfXbQkxwcdbFVr/OUHFYAVHhKuwqk15QgL8pgT84RmDN
 dqI4vZp3mvEfp96sq3Ey06vNBqlbq2gcSw5geVecWXcCQZCW0DIhtpkRxp0733a0
 9Ub5lmBv8A7hwoY8xVpNft78OzzzP+ihgXAPhlebdjToVpsql9qi3xgpdxjiJM/v
 NXbWebTkfB06gA5BKZqo4blJ33NPcmwARTZd1X2GouC89BpIMzOO7+oDMjOAvRLI
 Zefodw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eq10a94b1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:37:32 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6cfe512e871so3035770137.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 02:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781084252; x=1781689052; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lM5UWcwDDxSAAYu0W+ChEIVwJmkj+A9RIiZ34ZrORdQ=;
 b=LyKOssQor7tft0jHa7hPjb0qp85LxDcu5ibBl7VmLM3qwM/fW16K46JBnc8JuqACht
 9ikZcWqJr62XuoKB0vPlVZy98Wz3jE169jQXjcC/pWmn1AAURUQDzLbyRmIE6lDbzk54
 km5mp9bV7ufP/chSc90zPw0CvV/hcYcXC/CAclGeINov4TfVH0VwEZ1iyeTOxDAyI5K7
 WAriScO/95mQMAFh70LPQq6BFW7JIVluGJq82LRByJA1NZnofC7zSDLi7zTHnxniwB2x
 vhtDA4PA6yZM9oqAU3mHA713vB67xueEOTcVSVsi8j6GUFJV+X6M4WJFlmPB33dh9D+N
 Uzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781084252; x=1781689052;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lM5UWcwDDxSAAYu0W+ChEIVwJmkj+A9RIiZ34ZrORdQ=;
 b=l2AUitSjvWXHz9vWv7y0hBXcKJdhR0ZlRR0RHCMTqTv+3zN+p4RXJ9DFmEjCRzqDWP
 0Mm/yukZvr+0nD2FzejfV3rxwUO3Pu0wrydk4u2Z/taxuYR33QjPZ4pmtVpsq7MByUty
 BZlE5PnZUFNapULPXYxI7RYmy6nGS1gPo88dtFViXICA7IuRX5qIYCBs/SHW89Kv0B0f
 H8V75iKzfpYngJxEj9uO5ZXtnNrcPB/4V2UkFxTf7iDaZQnqUxd+lI/LwP2THc1ylXcK
 qXFXgtU7ZYC9mns5GfjyVPuC0cAx3J37MmSYvSm/2Jb6vtp+9aA6B+WDvGfE+uTfwWNz
 wCSQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+QREdNTtGdKnKElWUucdA/wYlYbxhOPXvkwIrivIZi+UVpk0PiyyVZK/Vz4KYI86xztdnLS21Q5+SE@nongnu.org
X-Gm-Message-State: AOJu0YwreCmQAEWSwJhgEq97QRypF8+R5R/Yn3116OZ7tIGiF6Uq+42U
 DFxhIL5Mk8Ldt4eMjHQ4phiKRllDCH8Y9ZT9O8HnIRkzf1GQQOuO1TIJaDEbRX86wkz6TuWKKdq
 GRmZopxLfYYCyUl1kvq5c70Q2fCPBHIQsy62V5At91ASBdd033BDalKfA6Q==
X-Gm-Gg: Acq92OHr9nUq4hE3AxCC4VXJ8lIhDnkcra21anWEpKJd8IHcjHdZkL/xyg9LycFWgnj
 XPMdgchZWTS66msVFKlFG5o/s3j6Phd+/tXSXM1gRbGopTylAoTAYly7KPrymUXgzrs9Jp0OL5N
 t/Ll8bHRUa6HizNdEM5ZUDpG9ZO5CubV/SGUjqGh7OfZrIuzXBChn0xDtXdjuoFZScunDHiYUbh
 kjBW5rsiK60bNab3v7Zao74rxnJqFewuNQUtSlaeDrnwpasXX6NI4OhHew4uqwboD80FnOk+LZ/
 uoaTHyjre0K+9D9w80NW3NUdqmBJ2TZKWZHfBAM8WrvZgbyJBikonanu6ArltWkCBqM7OW/yziV
 tDtYm38oWd/+SFJ+a6kmG9BJalY2lqP1N0AVXHItmJfryL7QzYX85IlgqqRy6xT772VWT
X-Received: by 2002:a05:6102:554c:b0:6a2:b2a1:f16a with SMTP id
 ada2fe7eead31-6feef09ad62mr12605333137.2.1781084252222; 
 Wed, 10 Jun 2026 02:37:32 -0700 (PDT)
X-Received: by 2002:a05:6102:554c:b0:6a2:b2a1:f16a with SMTP id
 ada2fe7eead31-6feef09ad62mr12605323137.2.1781084251777; 
 Wed, 10 Jun 2026 02:37:31 -0700 (PDT)
Received: from [192.168.68.106] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-6eb5549144csm19475478137.3.2026.06.10.02.37.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 02:37:31 -0700 (PDT)
Message-ID: <25dc379c-7421-44e2-98a7-15593db4f93c@oss.qualcomm.com>
Date: Wed, 10 Jun 2026 06:37:26 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: add 'trigger-count' debug property
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260609213905.1126795-1-daniel.barboza@oss.qualcomm.com>
 <6db02c91-83fb-4021-91ec-72e6b56afeb3@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <6db02c91-83fb-4021-91ec-72e6b56afeb3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GoFyPE1C c=1 sm=1 tr=0 ts=6a29305c cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=C11olbwvBXIHrrjHZpIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: lsO1RDrL8YkaEbuIbBXoGMD_bA9FZPew
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDA5MCBTYWx0ZWRfXynYojGXdRSTk
 NHP0DVpCY1eCgZv76q2lLtFkKTq3O7TkZrhX5R9JeZUVqPVG/1mPHAuPpqwqJruLIukx1B8hSL2
 DUr1ZMQxi6wRY0745Z1OC0zsj1UL4li/f7BHn9mtYPmydPBJ/a8ZwThJVAO7lEOqDRVczV68aLP
 xbVG9lNIUZmkWrPs5CJrDFv7yRNBg6p5JiEePo3UNg05YN703jOyrG6M80PQqdqR7Q2c4DfSqvB
 93QLXmDiCyH5NYEQr/qEftmb0e+FW1vhE3EtAehrAIomvqdlKbSpRANX8rL3GQgjYj+Oc8ew+5/
 Cx6DjqErSchuFbyjdnESDyriFPZ+6oCT/yJpPZF70HcNr+y/R+pxZaPK6Ovx42eaGr+d3rYOJoY
 SPFMZjPI0Qyh1edUgdFlDYzCm+7QwJUcv7NWlGQDtKa6FuQCxpGx5hlwzl2Wa/lOsEaiM+P92jI
 tGK9lrwJBX4464z+y/w==
X-Proofpoint-GUID: lsO1RDrL8YkaEbuIbBXoGMD_bA9FZPew
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100090
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 6/10/2026 6:04 AM, Philippe Mathieu-Daudé wrote:
> Hi Daniel,
> 
> On 9/6/26 23:39, Daniel Henrique Barboza wrote:
>> All CPUs have the same amount of triggers: 2 triggers per hart, set via
>> RV_MAX_TRIGGERS.  This is not enough anymore: we'll have at least one
>> future CPU that will demand more triggers per hart when implementing the
>> RISC-V Server Ref Platform, requiring at least 11 triggers per hart.
>>
>> Parametrize the trigger amount using a new 'trigger_count' env property.
>> The default amount is kept at 2.  Set the new maximum to an educated
>> guess of 128 triggers per hart (which is less than 2^XLEN theoretical
>> maximum by the spec).  All relevant callers (csr.c and debug.c) will now
>> use env->trigger_count instead of RV_MAX_TRIGGERS.
>>
>> We're also adding two ways of setting the property:
>>
>> - a '.trigger_count' CPU definition flag, allowing CPUs to set a custom
>>    amount inside the CPU def in DEFINE_RISCV_CPU();
>> - a new 'trigger-count' user property.  The user property has a higher
>>    priority than an existing '.trigger_count' CPU def setting.
>>
>> Assuming a hypotetical case where a CPU 'X' is defined with
>> '.trigger_count = 8':
>>
>> - -cpu X,trigger-count=30 => trigger_count set to 30
>> - -cpu X (...)            => trigger_count set to 8
>>
>> For a CPU that doesn't set '.trigger_count':
>>
>> - -cpu rv64,trigger-count=30 => trigger_count set to 30
>> - -cpu rv64 (...)            => trigger_count set to 2
>>
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> ---
>>   target/riscv/cpu.c         | 11 +++++++++++
>>   target/riscv/cpu.h         | 23 ++++++++++++++++++++++-
>>   target/riscv/csr.c         |  2 +-
>>   target/riscv/debug.c       | 16 ++++++++--------
>>   target/riscv/machine.c     |  4 ++--
>>   target/riscv/tcg/tcg-cpu.c |  7 +++++++
>>   6 files changed, 51 insertions(+), 12 deletions(-)
> 
> 
>> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
>> index 6e70b145a5..a667c06b17 100644
>> --- a/target/riscv/machine.c
>> +++ b/target/riscv/machine.c
>> @@ -240,8 +240,8 @@ static int debug_post_load(void *opaque, int version_id)
>>   static const VMStateDescription vmstate_debug = {
>>       .name = "cpu/debug",
>> -    .version_id = 3,
>> -    .minimum_version_id = 3,
>> +    .version_id = 4,
>> +    .minimum_version_id = 4,
> 
> Since you bump the migration version, we can also change the array size
> to only serialize the number of trigger used:
> 
> @@ -246,9 +246,9 @@ static const VMStateDescription vmstate_debug = {
>       .post_load = debug_post_load,
>       .fields = (const VMStateField[]) {
>           VMSTATE_UINTTL(env.trigger_cur, RISCVCPU),
> -        VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
> -        VMSTATE_UINTTL_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
> -        VMSTATE_UINTTL_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),
> +        VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, env.trigger_count),
> +        VMSTATE_UINTTL_ARRAY(env.tdata2, RISCVCPU, env.trigger_count),
> +        VMSTATE_UINTTL_ARRAY(env.tdata3, RISCVCPU, env.trigger_count),

Good stuff.  I searched a bit yesterday to see if there was a way of putting a
variable in the array size of this macro and figured this wasn't possible.
Didn't find any example after searching for like 2 minutes, then convinced
myself that the vmstate array should have a static size.

I'll send a v2.



>           VMSTATE_END_OF_LIST()
>       }
>   };
> 
> Orthogonal, we'd need to replace these target_ulong at some point
> (likely bumping the version number again).

I suppose we should do that in a separated patch that handles all ulongs
from all vmstate objects of this file.  Then we can do a mass bump on
everything.


Thanks,
Daniel


