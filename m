Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A8BC61DFD
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x16aO-0007hR-8F; Mon, 31 Aug 2026 14:18:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x16aK-0007gu-W6
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:18:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x16aJ-00070S-0A
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 14:18:20 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67VFpe9e037160
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 18:18:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ox8r1AKgndrscN9dH0zqNeIXsYwiQhHxVlUJLNcarMY=; b=WAGmsUo+QtsaL4jd
 kv3u/ysVM8GmdN7VYH9TOnIxqAP+Esgzi+0/kAWY1AS084mw4a6aY1ZCyLFLwi1B
 vULxeqrbJG8KdJTn7yqTU8xLYsdIlkTJBGPcyoUqxvyfvOitVUD++sv28XjzG1t3
 Javx1YepycAaDX30lYH8r8RuW7kzsRWzT+sLj0YBoiEDpwjeoTGeh1D7H9dbOdgB
 x2hA+OJZv2FDppCqi74fL/mW/pFoml+L8ZT8YakLBM5EKXu1tNUsI6nzFOWFZFVu
 63hUwqJelacfdTxIhQLDeQ5y0V9qrlkIOOIp5skRAdmFn92J0NMCgIt3Eb6Mttw6
 UbOYCg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd6jgjgud-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 18:18:16 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cf7dd9fd91so41350195ad.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 11:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788200296; x=1788805096; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ox8r1AKgndrscN9dH0zqNeIXsYwiQhHxVlUJLNcarMY=;
 b=MiHtaMQNj8S0rVMDJtlr/0vjOhdulHyNDYgDCSSg2WNSZ9T2EnuzxXtIAflF6sIUPO
 m/oTY3rov5zR7fjfQyi2DKuekjM29POq7SD+BsotzG1oeub8HTb3NYnK/jfsM9xrHHr4
 NpbGAog5Z6wJj2nDiMTe4ZkftK9MaOsYA6d8n9G985G0NoAoB906i/amXZrjpoxwqiY2
 C1Ad/HhNl5GCMIgS8cXQ38dOpCBjdDQm5vq3stPZj/xbDm9pTs0Bv0CrsAFei9ea31Ri
 t7YXRRIT0Mw6hKPDOFO9zs7Rnpxbt/pXhjZnCUqSpr/wDJWMZeiXDmmyklSGjVUwKYci
 DbBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788200296; x=1788805096;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ox8r1AKgndrscN9dH0zqNeIXsYwiQhHxVlUJLNcarMY=;
 b=dUBXAfHBf9OCZ17Nfa3qhMaLeOjJQLMY3CEAFzGSKusnjiL1umwpii7GB+qOsWY+33
 mm8AL7VchpDQLaDhcdXQnHwUKzeGHd9o8Ri74uStLMcdXFjuH/MqW+8ApkTc5jp07jMc
 5+5tSfPjjk16B9gSrGgdyvW4GiAesXuCL3rn0fqPqwA2X0kOMVaPZOD2GxXkNqOhItrR
 6bHOpuRljGAqyrqbrD/+pGj64Z3991UJpXKaaMJjq14uE1SiCc0cdGYAvHBNylQ8Wf62
 AFDZbixmgUSOtFm+5/2jfiJk2DZ7sKTyI5addmeVuEL65dMd4zjsNicTPxStalKU1ju4
 3Ygw==
X-Gm-Message-State: AFuF++ne5EP/vo2AQ5uhhufGT+mfeMT6mbTfc7QPGQ+Mkxn/eOFABewn
 3TzGbkbC9PwC/j/ASnMiyjeMkGNHKKLkK6KDls8Dd5M2y890vE1nqgjvoCoYoojCVWsr/LVi/Zt
 b4FQq9BpgqQiiuVCUE2XhX1XsGjmNsc510wvneiCoUmbZRf8OWPZYtNGLtQ==
X-Gm-Gg: AYBFou0+0gR++ROgwNan8ePYW9RPba9l0v7LlKUcznfdPti0hGfSs2qOzXotDYAZNoT
 iaBUTKw564LGrImUTasjYcvv1IHL9zJHZtVugNF95ho7c23jRtpicMguv68p0C8QrUfAIVX4R8B
 +ICqrZCW1RY5lBoJfEcDyfurf2Y1cnpNioOw5rd8R6bBkLGGsi7mdt7nY8hgIMhD0vzCe60luoQ
 Ych9sI5BIKd5sSLFpNiD08fz5qtRQ3aG9bZxjL4azwd2uO6MCv92flqM9Q4WKLRW4ne8G/bc6c8
 J75hyx6Ebhm9VndDJpLCZ8NRh3xz59hthOj8+qYe45k1TQ04VN/J5ymk0s/zH8d6EXnaRA6aXmX
 l3UxFCpnCV7pLsJ+z4g1jNgaVV029cNxgFy6Hc4bmU2GPByJRVCe7c7Q6FaNM1l78QrE6
X-Received: by 2002:a17:903:1b0e:b0:2d3:78c2:1f19 with SMTP id
 d9443c01a7336-2d74ddc6da3mr452922485ad.9.1788200295665; 
 Mon, 31 Aug 2026 11:18:15 -0700 (PDT)
X-Received: by 2002:a17:903:1b0e:b0:2d3:78c2:1f19 with SMTP id
 d9443c01a7336-2d74ddc6da3mr452921625ad.9.1788200295185; 
 Mon, 31 Aug 2026 11:18:15 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32b26fd7edbsm20446190eec.5.2026.08.31.11.18.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 11:18:14 -0700 (PDT)
Message-ID: <8a893eb6-44d9-4687-871c-8d4ddd4c0544@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 11:18:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/27] target-info: add target_riscv32 and
 target_base_riscv
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
 <20260724000948.234657-4-pierrick.bouvier@oss.qualcomm.com>
 <CAE2XoE8jht9TP8OrTGAZNfALOTBECz+_2dRtKzmjwwf5kur2Jw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE8jht9TP8OrTGAZNfALOTBECz+_2dRtKzmjwwf5kur2Jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2PNvi7qsZ5YWVrV4mYqj-Fr1WezxEe1J
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDE1OCBTYWx0ZWRfX9B2ivttfVqxf
 ZxKD9HRMPEueCCkArhDn2ckrcsBHt8vtmkZC5xhUAErNELT7V+FbCP5TJBjic9kgZdgWGlwjHwA
 d37O8c67aNiO8+akqQCqDpkvMJ8G4m0=
X-Proofpoint-ORIG-GUID: 2PNvi7qsZ5YWVrV4mYqj-Fr1WezxEe1J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDE1OCBTYWx0ZWRfXwUwYIpsiAksl
 p1Jf7htnn6s81GbZ1QiNvzmdM4mAI9GIt6fxf/yIA0IKcMZMCXVEsS5SSO9/WgobYEYf9VgE+1b
 kVxIm8AcLMypIg6mXa5/QvqTnjuysJezp//9mR7z68VJ3F3pU/4k0hpXiNZbP8AIyqW2P34xQIk
 a+CAaNBypZTYxdvzNN2VRhSnxqhESefwRFKeTU4WV1RMkyG5InvgM1y2yMgK8yTs9MF/68vrUUC
 pzyeIyG/oqP2B34uZQ708ub0k4vSJbUgt1jKXpnBIYDLX9wxO9e7oBGCgvm3dEjCs6VpNzPy7xl
 UAA5eOYy/ujzMVBVp8BBJlye8OB69nbVey8bfi7C7aqGt+TK5W+1m9vLiCfcZ8tvdNCkH7vALO/
 uLC09lHXIgltDGXOaBgkwpK9uQlTrYBAfyS/xiPx4O2jycUBmXJmJCtBP8EeRI0Ek29dERa2rgH
 Dv5eQ4PZh6N+gFfrhIg==
X-Authority-Analysis: v=2.4 cv=YsY/gYYX c=1 sm=1 tr=0 ts=6a95c568 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=g5O3t26umuFA7Ibat5IA:9 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310158
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 8/31/2026 7:07 AM, Yonggang Luo wrote:
> 
> 
> On Fri, Jul 24, 2026 at 8:11 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com
> <mailto:pierrick.bouvier@oss.qualcomm.com>> wrote:
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com
> <mailto:pierrick.bouvier@oss.qualcomm.com>>
>> ---
>>  include/qemu/target-info.h | 16 +++++++++++++++-
>>  target-info.c              | 16 ++++++++++++++++
>>  2 files changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
>> index 6c5b714288e..88ccef2a988 100644
>> --- a/include/qemu/target-info.h
>> +++ b/include/qemu/target-info.h
>> @@ -99,10 +99,24 @@ bool target_ppc64(void);
>>   */
>>  bool target_s390x(void);
>>
>> +/**
>> + * target_base_riscv:
>> + *
>> + * Returns whether the target architecture is RISC-V 32-bit or 64-bit.
>> + */
>> +bool target_base_riscv(void);
>> +
>> +/**
>> + * target_riscv32:
>> + *
>> + * Returns whether the target architecture is RISC-V 32-bit.
>> + */
>> +bool target_riscv32(void);
>> +
>>  /**
>>   * target_riscv64:
>>   *
>> - * Returns whether the target architecture is riscv64
>> + * Returns whether the target architecture is RISC-V 64-bit.
>>   */
>>  bool target_riscv64(void);
>>
>> diff --git a/target-info.c b/target-info.c
>> index 04c69c41f8a..7ac2260b182 100644
>> --- a/target-info.c
>> +++ b/target-info.c
>> @@ -94,6 +94,22 @@ bool target_s390x(void)
>>      return target_arch() == SYS_EMU_TARGET_S390X;
>>  }
>>
>> +bool target_base_riscv(void)
>> +{
>> +    switch (target_arch()) {
>> +    case SYS_EMU_TARGET_RISCV32:
>> +    case SYS_EMU_TARGET_RISCV64:
>> +        return true;
>> +    default:
>> +        return false;
>> +    }
> 
> This can be improved by using  (TARGET_ARCH_BITMASK(target_arch()) &
> QEMU_ARCH_RISCV
> 
> TARGET_ARCH_BITMASK should be a new macro in base-arch-defs.h
> #define TARGET_ARCH_BITMASK(sys_emu) 1UL << (sys_emu)
>

What is the added benefit compared to using an enum, is it supposed to
be a code optimization, or more readable?

> 
> And the enum in base-arch-defs.h can be update with this emu, so once
> the sys_emu maximal >32 still works in future.
> 
>> +}
>> +
>> +bool target_riscv32(void)
>> +{
>> +    return target_arch() == SYS_EMU_TARGET_RISCV32;
>> +}
>> +
>>  bool target_riscv64(void)
>>  {
>>      return target_arch() == SYS_EMU_TARGET_RISCV64;
>> --
>> 2.43.0
>>
>>
> 
> 
> --
>          此致
> 礼
> 罗勇刚
> Yours
>     sincerely,
> Yonggang Luo


