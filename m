Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50AEC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 18:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1pI7-00026K-AO; Wed, 02 Sep 2026 14:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1pI5-000268-OU
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 14:02:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1pI3-0005kX-Ts
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 14:02:29 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682HrGOt2976138
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 18:02:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9R88LIXZ+b9GkywzKmZQhEeyNBqJS1d2AnqIuxjs6ds=; b=POMBXgauGECpE7Eg
 +J26XUwodet4Off7NZMLQWPQ47y9nM+Os00569Y8FceLTdyy6s22E8xetvh+LTy3
 klv/p+GtJzE55yDrq5Wnt8r+07P92N0WHsyrAyUy/hav038jtCg/CANiRhZoyZ8L
 P4aOLaVxbg4zg5nbcHB5CSemcUfg2SXzN6xRbhhI9OtExzgUQ/8NEsUqlcBLThXz
 WfN56JVMEdrKDbtGnBSNOsKHh5lMSrxypZMbMhySXLPsLmE1BZCeLqOqgUOvQcAy
 zdCCYfnNK3GQ4DS/8rn0LNq51RCgboJRcumDTjga2sx3xDQKNyFGniK7my8a7nTF
 y8Mlew==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gerdn833p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 18:02:25 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-939694871aaso110576385a.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 11:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788372144; x=1788976944; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9R88LIXZ+b9GkywzKmZQhEeyNBqJS1d2AnqIuxjs6ds=;
 b=W5FtKD89dEVgaXcE4Mkgz1+PtoxboR4VrQaRK6dnXVb2aextcA3Kogyok7CF0oL/pV
 dmpvQJZgkW47AcUk0B/U/KnmvQY8v21Z2Khm0cKPb5m8Uz3XZ2K3I2tvYdkLWoRWRWUf
 c22a8jgg1lvDOO7Hl/9OOsSjwQ4/45GoFoaTIyJ5WyQccgOf0dGWCygDt/FF32lOKYjF
 FL0I67FOiqQr4oYHyx4S5OqVUCOaNd3ekFCs7j+KVexySRzYbUq4gGLnjVtYHG9dtFWJ
 tL1ZlIxAg41S9xlJTwEXpLZeULkNBZCqC40N9COPTGjAptA3vGKAa2BiVwdCAbSb7Yl8
 lNjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788372144; x=1788976944;
 h=content-transfer-encoding:content-type:in-reply-to:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9R88LIXZ+b9GkywzKmZQhEeyNBqJS1d2AnqIuxjs6ds=;
 b=Nmr3AEUUaWBvWe/i211J7YZAVbZjKZtYez0YCVoZ69+eTogtP7bt+2gKoxHgjxRjNI
 dI+mypPsJXiphcktZS4JRJ2O3EfRWKwqnYLLoAju0O6ayZvG26VHRbBjW/LraLC+92iC
 CBiJTQMH8R0egPfGbTMI6bhEsK0UZwnBddJKffomBKH60sKhKAjcwiy2eMzOtDAx0ka5
 0PFvzb58x2m/JoAdEfBSv+GDy1Ydyo/6ejQxntEnEYweZwyy9RPgmLxuY4BlyzSXJeAR
 2OPSROkJ8iOuv+c7KA3ILc9p0M2GeOV/GJmoqfMs0d5wOMMFAOa7Dw+fJiM/8wbqS4Qz
 Z0Sw==
X-Gm-Message-State: AFuF++kvBWD4APUMTOHUvdOwksKnBI6+JAo46vyFmzRhPT3f/ekx5P+7
 KMa7qxIGfADyM1oqTS4lToOhVxJrHagCC1rObor9iiQbqNxpmEC9/Uh7HNrLY+rMG7DOoNpn2i5
 xAaLM2KHMVjfQ4ZV8iw1qxalzOkI0xF96hj2J/jJmAUJb7FdfuMNGhvVmsw==
X-Gm-Gg: AR+sD12RRfrnLvNFFpPtkoQ6cJvX3MmNWPqZOiG0KAmVDBc74QtIai3/LzputqU5rUZ
 8yqPiyTvh+8Yu7BT7hKmYqGF9RlM2fQjd/HIKOhBVxvzlIlIrtiLRW3SzmB/odQMhSSjnOjoMuh
 h4AWDqbP1frlpP/sAdwbpN5NZ1mSOtKCnI9u7rse7bG1zrqAiAmENpoxqio/UWSfabaPkYhlSLW
 s+rln6uxfsDxQYbpcCZh+mqlpgWdi+GdRKvR406Z0fT3XvbNid70NqwU26ReHHxVOf6mbzWVEO1
 J0/OANPikI1qwvLaVgrg2N7ycqxbaZLzrlZ4wRVV+nlFBm2PD3iJmVSEuYwOHReFz1GyXZAPRda
 YRK5f4QUlHdvK54tl688=
X-Received: by 2002:a05:620a:450f:b0:939:13a7:70f0 with SMTP id
 af79cd13be357-93960ccf33dmr744204085a.5.1788372139361; 
 Wed, 02 Sep 2026 11:02:19 -0700 (PDT)
X-Received: by 2002:a05:620a:450f:b0:939:13a7:70f0 with SMTP id
 af79cd13be357-93960ccf33dmr744194385a.5.1788372138788; 
 Wed, 02 Sep 2026 11:02:18 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448eea468sm8310452f8f.26.2026.09.02.11.02.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 11:02:17 -0700 (PDT)
Message-ID: <7766d96b-4065-4917-9d7d-094bd6d1f29c@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 20:02:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] target/arm: Extract halt-to-exec transition out of
 arm_cpu_exec_halt()
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
 <20260819145649.23439-7-philmd@oss.qualcomm.com>
 <44833559-f73d-4b8c-acec-a3e86b98c393@linaro.org>
 <CAFEAcA8xk8y1W0UvttpVhKYuoMBSQqZoF_15of0Rrq4wKkWDuw@mail.gmail.com>
 <bbe4b7d0-96ad-45d8-a5a9-0be2c5479d51@oss.qualcomm.com>
In-Reply-To: <bbe4b7d0-96ad-45d8-a5a9-0be2c5479d51@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YcmNIQRf c=1 sm=1 tr=0 ts=6a9864b1 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=nTIrALyzO7R1oIutnIsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE1OSBTYWx0ZWRfX/boBUHaW/InO
 ufm/C6oxN+BVqxhQUkd7abxOAKos66JKgC8C1s1dfI5QfdhxpoCb20Bocp57+kBghZkgrd7BmoU
 fqNSh45Ag30ABSsZpVwPdEL/Y7DYbBo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE1OSBTYWx0ZWRfX7Ogz5QccNrM9
 t0Gfb7RHvxNxhFBbya4x4jaXe5ymqtlNAb9RtbeFbS7AX1VRmXlZJuxn+1cSBsEKWKDqdGPxvWX
 V1g/Qw5TUii2BGoEAHZJaNgLP0mg6TFtGwXxcDhnl9ur2RLCgmgfWcDJwLJ2DgM3TZtg9MYyq2c
 SasJJx5eCm0CkX8F+045AKttB+kGgvkwc3XxGRZNHs83b8Q43PibF6zDQBNrEft78ScbXM5ze8M
 UDreUmYTTC3HmfXLa1GtLG9UcMnQ0ORb458lYs3sIOefx8dI/bvgXTwfwXImg/gP4EhcH4GD0VZ
 2N6yO64yG1vuzDfHoZgClF9Ifam3yAx3Ge8eqPITopNFqonXTG5V0VL2NFwnA6+Rppi/S2mA4vS
 /MWPtRAbvzpDXwMO8l6H0FDyDBNTEKo8onCY4N37mHSB+JcrI8/foRjmhzzgaWQjvaI2E5lGbGt
 ay3WSkM+Ht26ul5Uwmw==
X-Proofpoint-GUID: s-V-U7BMrt2Y4y6wdhskOXdCP3Ue6GHj
X-Proofpoint-ORIG-GUID: s-V-U7BMrt2Y4y6wdhskOXdCP3Ue6GHj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020159
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

On 20/8/26 09:29, Philippe Mathieu-DaudÃ© wrote:
> On 2026-08-19 23:40, Peter Maydell wrote:
>> On Wed, 19 Aug 2026 at 21:14, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>>
>>> On 8/19/26 07:56, Philippe Mathieu-Daudé wrote:
>>>> Refactor the target-specific halt-to-execution transition
>>>> logic (disable WFE/WFI timers, clear the halt_reason flag)
>>>> into a separate arm_cpu_transition_halt_to_exec() function.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>>> ---
>>>>    target/arm/cpu.c | 22 +++++++++++++++-------
>>>>    1 file changed, 15 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>>>> index 77aa78f00e2..8e9b584559d 100644
>>>> --- a/target/arm/cpu.c
>>>> +++ b/target/arm/cpu.c
>>>> @@ -870,18 +870,26 @@ static bool 
>>>> arm_cpu_internal_is_big_endian(CPUState *cs)
>>>>    }
>>>>
>>>>    #ifdef CONFIG_TCG
>>>> +static void arm_cpu_transition_halt_to_exec(CPUState *cs)
>>>> +{
>>>> +    ARMCPU *cpu = ARM_CPU(cs);
>>>> +
>>>> +    assert(cpu_has_work(cs));
>>>
>>> In reply to patch 11 you suggest removing this.
>>> I wonder why you added it in the first place.
>>
>> Does the accel loop enforce that we hold the BQL when
>> arm_cpu_exec_halt() is called?
> 
> For MTTCG:
> 
> mttcg_cpu_thread_fn()
> {
>    bql_lock();
>    while (1)
>      qemu_process_cpu_events(cpu);
>      if (cpu_can_run(cpu)) {
>        bql_unlock();
>        tcg_cpu_exec(cpu);
>          cpu_exec(cpu);
>            if (cpu->halted) {
>              cpu_has_work_after_processing_async_events(cpu);
>                process_async_events(cpu);
>                  x86_cpu_process_async_events(); // APIC takes BQL
>                cpu_has_work(cpu);
>                transition_halt_to_exec(cpu);
>                  arm_cpu_transition_halt_to_exec(); // timer_lock
>                  x86_cpu_transition_halt_to_exec();
>          ...
>        bql_lock();
>        ...
> }
> 
> void x86_cpu_process_async_events()
> {
>      /* (BQL not held) */
>      if (cpu_test_interrupt()) {
>          bql_lock();
>          apic_poll_irq();
>            apic_sync_vapic();
>            apic_update_irq();
>              cpu_interrupt();
>          cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
>          bql_unlock();
>      }
> }


>> If not then the assertion
>> is racy, because something might get in and e.g. lower
>> an IRQ line so that cpu_has_work() is no longer true
>> (which would be fine -- it just means we made the decision
>> to wake up and that won vs the incoming interrupt).
>>
>> On the one hand, if we don't have the BQL in has_work and
>> exec_halt then we should be a lot more careful about how
>> we code them (e.g. use of the right kind of atomics, and
>> there's no way the call to do_interrupt_all() in the x86
>> exec_halt can be safe without the BQL, surely).
>>
>> On the other hand, if we do have the BQL in exec_halt
>> then why is the x86 implementation explicitly taking
>> the BQL when it calls apic_poll_irq()?

Trying harder, my understanding is apic_poll_irq() only requires
the BQL for the apic_update_irq() call, not apic_sync_vapic().

So maybe only apic_sync_vapic() belongs to process_async_events(),
leaving apic_update_irq() to transition_halt_to_exec().

Paolo does that sound like going in the good direction?

