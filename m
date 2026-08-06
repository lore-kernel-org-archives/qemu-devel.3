Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4A3FC5AC67
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 20:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ws4id-0000mp-Kp; Thu, 06 Aug 2026 16:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1ws4iP-0000a9-3y
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:29:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1ws4iN-0005bu-2r
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 16:29:20 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 676IHseE2704669
 for <qemu-devel@nongnu.org>; Thu, 6 Aug 2026 20:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UMWXMkFvRpu847s9DEFFKMvYb6/ndi8GaqD7H69G/pQ=; b=PoJQBAUd8BhGuOyr
 RmU44EZqmjdALXLwwjfdYwmrjkjOIQsyzUxCvgrtFYaFfAcw67vwKEljxqQPytsf
 clhVpn0b07LCNogwSO0fneLkW5+no/+522oXl6vROd240fpMRba7nHrK7Wn0/wgj
 NuH71NqNBDMjQekjF+64dDDeQKaJNC+XOruMTsnZMnVEp1/t2YuqS1EcKyEc2hXY
 4AWJxxbzwfurMiEK6aSHaQKOVcZotxgHokPlffEiklpxNmj5Vpo4P1HdxknYG+cO
 sMD/nfIG++/4x7gQfy+px1OG5Q4/tfvtNbKcLD8494TE7TqJKe/cqJfKavK7eANf
 9o2B2Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6h8muf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 20:29:15 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-930edb4362dso211156485a.3
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2026 13:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786048155; x=1786652955; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UMWXMkFvRpu847s9DEFFKMvYb6/ndi8GaqD7H69G/pQ=;
 b=XDV/JsCB0VoU8X23OVvDl07MLTiYSQF67Gg2lzLpqmkWy7lahKlN4BeZ6bN/R7Jrgq
 srEwgI0hlGmqa8NqABvudOx000Dl5x73MINMIgt0cHdEgu5jjnZM2nvHPXDMv773o6Bn
 rOltJ8wWon5Dd3x3Cq72yxy7IlKisJuXXy9aIjH6fAcam3ODWDmmvxvXqG0f7hdgRHAd
 GTdhTh75y5r1fUdj4u6rzd1cW6iAVT/MivdPtXZDl3eISlrj+EAN9ekR7jznqiMs4t6w
 +xq6zWBJ2/jjXNWlMHP6VggVMvoq0Wp7oxwObXVhCWOywVpuPc9RZlcRADDDmOSxKof8
 yEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786048155; x=1786652955;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UMWXMkFvRpu847s9DEFFKMvYb6/ndi8GaqD7H69G/pQ=;
 b=s2Jgm66MauqfRYLLEvVgiRTJYvK9Qqb4+xwwg/YefxRj3j5GDx1eA+uucq+Ko9V3WO
 K2T+LHshgEHbFAsyFGcU9K6wTlZF1zKf6LrHRppefhIkUVf5f/2MaT8X29ms1f1bhHZS
 9kg66yIPJaJqqQLh69sojGKnD4YQMVfBHtubvNuwUw7NtXLKCysk90Le+EstURIFZ7Px
 5BxVooT5ukDs9M1p+9y7Tgp2NY7pgJ8fyFxCxaAhSVC0MRqOZx/d0ICfBfxH+xuGMlOa
 AGDU3e6+DbrYccQoqgv+jQ7Nxib7azFlS4N6NCGlMnT3lQgQ/ECmh6S2a/9LK9PTp5s4
 X3xg==
X-Gm-Message-State: AOJu0YyEk0RjI02JxUks2QrktLZPY8wB+2Zdd7hwsfaUuxqY8wTOgVvE
 YVLxGCmxAPSkXKi1qg302WurlLkw+7vioBspVNQOFve2HpnRjrdxMzVENElMCdtTLvoK7U6EBtQ
 0FIuyl7JtQtqAVvtzh6NSuC5cM9ZS2bryRfDdoF5f0o5o0k0xNl3Ou2ZvBA==
X-Gm-Gg: AR+sD12HgaX/vIOf2u0X7NEzY065cBivCjX2UE7+hiIvxWZWSYfE1uCDxNLuAX+xPBL
 X4pfMo4IqoUpJ5wB5mkj0lZ56cFp/UsjS8Xzl7tNKI5T37tveHp3Zj+OdrXHDR4a4yxEW8jV06v
 qTN5Ibvaqc3sl39h/vy7Qd6WdDHlrFxXEbBD6vPqgOBIKt15CPMti42R0LABpL9V2NpkUwf7WoK
 TlfEbFa1TnFYtVP3Eye2nYIZPArYj+8YgGIU4PikU+bRhUvu0nJ7AhCI7Ywy6R65s3ZGMJdJTeG
 nyILzom7L4LzAscAa45b8YRfl1iOV3K2PDr900ytiS2ji3t7eVZJB7b7V+wbxNJkRM6Ta2tIw8v
 H+dDhXRCdpz1wwsFYuYKP7E6KOZHyjX3cRRR3
X-Received: by 2002:a05:620a:a490:b0:930:b4f9:f327 with SMTP id
 af79cd13be357-9364910ae51mr1666211085a.33.1786048150231; 
 Thu, 06 Aug 2026 13:29:10 -0700 (PDT)
X-Received: by 2002:a05:620a:a490:b0:930:b4f9:f327 with SMTP id
 af79cd13be357-9364910ae51mr1666207085a.33.1786048149784; 
 Thu, 06 Aug 2026 13:29:09 -0700 (PDT)
Received: from [192.168.68.103] ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9364a4260c8sm486427985a.11.2026.08.06.13.29.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Aug 2026 13:29:09 -0700 (PDT)
Message-ID: <628f6692-7e03-423c-a6e3-b2c115350d30@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 17:29:05 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/27] single-binary: implement dynamic filtering for
 machine types
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
 <56625144-c2fe-4017-90ed-473e570fa35d@oss.qualcomm.com>
 <CAE2XoE_-amik0TXZFTKiL2o1hOd-Qo0zkBHrdrSGnasLxA6q3g@mail.gmail.com>
 <8726ffd9-542c-42b7-b95d-b872ba6b21ea@oss.qualcomm.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <8726ffd9-542c-42b7-b95d-b872ba6b21ea@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QGI21BDaOYqx_RaCCk2T3Uav7EY4rjJP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE1OSBTYWx0ZWRfXw7Y/Wi8A7uYf
 YRoAlNffUTf0E7Pl/V6hcicaz2XL44aguxAFBl9d0V60D3zz2h4Rluxj6vd0LzfhehJZsQbFGqD
 qMOfgjfx/NxJajjMcsB+xm57THG/9LXK8T23KF93aJEL5BfDCJuTRYdXf2tt79Xxr/G5E0mXmz6
 GJX5tRs+ftSnpATM4hHzSYYwZvWuTRJAiphAf4amM3JtLlFyHE5/COnH304wyyU09BUrb/vb/KH
 J+NNJflQGqZIo3SJO6cyKo5fg3aRCVtYXljcnOZ7BpP4h8jLSj9L4P1WYKAgOXaNAuidwGGSJCX
 edbj6uvtlUpSSFKEjf8TNzWqKWnq51PDeyHmhUUgiVycXrsCWdcJkGxgsdO+YvHw/z8uWWxN4Na
 Ezm6XVMLXcanAIUDIl2iQX4FakuT9zfmUotB1tjVbZI//kmexC0Q8I1poSxaBzjGEYHUM3VmtOL
 1s0c6wQhsw9GWdjMsIQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE1OSBTYWx0ZWRfX7fdfGx45aN10
 VBXAavKwaV1NyOjyknh2lzxgtzURvjVamNA8452UpBcdxH6dFaOz+n/sOoLwBt2OQe3qZmPYGro
 +guaqCOL8LTQgef7HQ+B8f6GB/YYdY4=
X-Proofpoint-ORIG-GUID: QGI21BDaOYqx_RaCCk2T3Uav7EY4rjJP
X-Authority-Analysis: v=2.4 cv=MbpcfZ/f c=1 sm=1 tr=0 ts=6a74ee9b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=gCpyw_pzYjWHHVy-gBMA:9 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060159
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



On 8/5/2026 1:20 PM, Pierrick Bouvier wrote:
> On 8/5/2026 6:30 AM, Yonggang Luo wrote:
>>
>>
>> On Fri, Jul 31, 2026 at 1:34 AM Pierrick Bouvier
>> <pierrick.bouvier@oss.qualcomm.com
>> <mailto:pierrick.bouvier@oss.qualcomm.com>> wrote:
>>>
>>> On 7/23/2026 5:09 PM, Pierrick Bouvier wrote:
>>>> Now that we can link a single-binary with at least two targets (arm,
>> aarch64),
>>>> we want to make sure that we expose the same set of machines (later
>> devices and
>>>> cpus) than target binaries. For that, we implemented a static
>> filtering based on
>>>> target interfaces that each machine will implement to declare which
>> targets have
>>>> this machine.
>>>>
>>>> However, we discovered that this static filtering is not enough.
>> Indeed, some
>>>> machines and devices do not depend only on target, and their
>> presence can depend
>>>> on Kconfig or host/target combination. Thus, our static approach
>> can't work, and
>>>> we need something more flexible.
>>>>
>>>> This series adds a new TYPE_TARGET_SPECIFIC, that declare a single
>> function
>>>> bool is_available(void). From there, any machine type (and later
>> devices and
>>>> cpus) can implement it to override their presence for each target.
>>>> We first replace the existing static mechanism with this, and once
>> done, we
>>>> cleanup all the old interface. One nice benefit is that we can get
>> rid of
>>>> config/targets/*.c files, which saves duplication.
>>>>
>>>> This series was tested by comparing list of machines for all qemu system
>>>> binaries, before and after this change, to make sure we don't
>> introduce a
>>>> regression.
>>>>
>>
>> I am also tracing for this. So what's the shape of the final command line?
>>
> 
> I have those commits ready, but I would like to get filtering done
> before so we can focus on command line independently.
> 
> Currently, what we have implemented is:
> ./build/qemu-system -target {arm,aarch64,microblaze}
> Or
> cp ./build/qemu-system ./build/qemu-system-{arm,aarch64,microblaze} and
> there is no need to use -target in this case.
> 
>> Maybe we can at least get arm/arm64/riscv32/risv64/riscv32-be/risv64-be
>> to be in a single binary.
>>
> 
> v0 will be arm/arm64/microblaze.
> risvc64 is a wip, it's not yet ready for integration.

I talked with Mr. Pierrick and Mr. Phil and offered a hand in the riscv side.
So far I wasn't able to do much about it - qemu-riscv has been more active than
usual and we're barely keeping up with the reviews and ongoing work we want
to push for 11.2 ... I think we'll be in better shape for v1 of this effort.

Thanks,
Daniel




> 
>> The -be is needed because gdbstub would need this to get gdb working
>> fine. so the endian mode is important. arm/arm64 have nothing about be
>> support yet, even though in spec also have
>>   
>>
>>
>>>> Pierrick Bouvier (27):
>>>>    include/qemu/target-info-qom.h: declare TYPE_TARGET_SPECIFIC interface
>>>>    hw/arm: implement TYPE_TARGET_SPECIFIC
>>>>    target-info: add target_riscv32 and target_base_riscv
>>>>    hw/riscv: implement TYPE_TARGET_SPECIFIC
>>>>    target-info: add target_config_multiprocess
>>>>    hw/remote/machine: remove unsupported arm target
>>>>    hw/remote/machine: implement TYPE_TARGET_SPECIFIC
>>>>    target-info: add target_config_xen
>>>>    hw/arm/xen-pvh: implement TYPE_TARGET_SPECIFIC
>>>>    hw/xenpv/xen_machine_pv: implement TYPE_TARGET_SPECIFIC
>>>>    target-info: add target_config_nitro
>>>>    hw/nitro/machine: implement TYPE_TARGET_SPECIFIC
>>>>    target-info-qom: implement new machine filtering per target
>>>>    target-info-qom: use TYPE_MACHINE instead of target_machine_typename
>>>>    target-info: remove target_machine_typename
>>>>    target-info-qom: add type_target_specific
>>>>    hw/arm: remove TYPE_TARGET_{AARCH64,ARM}_MACHINE
>>>>    hw/arm: remove {arm,arm_aarch64,aarch64}_machine_interfaces
>>>>    include/hw/core/boards.h: add DEFINE_MACHINE_TARGET_SPECIFIC
>>>>    hw/arm: remove DEFINE_MACHINE_{AARCH64,ARM}
>>>>    hw/arm: remove machines-qom.h
>>>>    hw/riscv: remove TYPE_TARGET_{RISCV32,RISCV64}_MACHINE
>>>>    hw/riscv: remove {riscv32,riscv32_64,riscv64}_machine_interfaces
>>>>    hw/riscv: remove DEFINE_MACHINE_{RISCV32,RISCV64}
>>>>    hw/riscv: remove machines-qom.h
>>>>    configs/targets: remove target info definitions
>>
>>>>    target-info: rename target-info-stub.c in target-info-def.c
>>
>> Does that mean  target-info-def.c would be compiled N-times. N is the
>> target list count and finally linkage into a single binary?
>> How to choose this target-info?
>>
> 
> Yes, correct.
> We choose either from -target arch, or from binary name.
> In case a single target-info is present, we don't check binary name and
> simply use it.
> 
>>
>>>>
>>>
>>> Gentle ping after a week.
>>> You're welcome to review only your architecture if time is limited, and
>>> validate the global approach.
>>>
>>> Regards,
>>> Pierrick
>>>
>>
>>
>> --
>>           此致
>> 礼
>> 罗勇刚
>> Yours
>>      sincerely,
>> Yonggang Luo
> 
> Regards,
> Pierrick


