Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF4DC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 07:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwxDx-000436-Fn; Thu, 20 Aug 2026 03:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwxDv-00042a-4P
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 03:30:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwxDr-00011D-4b
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 03:30:02 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K6nAI73732404
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 07:29:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uXPI8c8JjDelMRqZENLxxutCdt4diF9INsZSmjvmSG0=; b=XC8N2crlU2L0KYr2
 CGuBZ+uqkoqNCwSFdO+mWBKDBmjEHdpt/4UJnjTXysE4iJM55CjTYP09Dpizplln
 K3XplKf5lhFUF5d7Fxe4GVmkhXUIyd5M9EYu2PRFwRXLQqnYBxVyVsHO+kvYynhB
 cGbmzkE+kwwy2w7+xK/ZsMDQ4ldAf0yNQJL7peFsCbpq/YA9i1msFyNb2kpNLqAv
 sln5KwPy4oFmnHEC4jZN5eUPJmT7180YzZZyTi7H0OBqq1LC0Nb7b/6YVqKBKXZW
 XkEVtWI+Q9HC1OXXIc91d5uNxfjNEj4CHhzD4pd5f3cUyoyxaVNLrzzUaoqzUmiD
 hAD3Jw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5vn884xu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 07:29:56 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e62e3459fso222135685a.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 00:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787210995; x=1787815795; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uXPI8c8JjDelMRqZENLxxutCdt4diF9INsZSmjvmSG0=;
 b=bYt2RRGvnUwwkevmrKe6zXr3Ci8ZKXOxNotJUI9Pxh8wEt5vnkr8JcYCoohwjo7zYc
 bqLQFMY8BfxmP4zUMSGdbGuI5yyMUM9JbyhxbCi1Njfc+osyUW33qNexZfA/Eb+mF3TH
 0AA7pAvSrrhZDpTj2m85bxhtRcRHvkDxmNfFPUzWCVMtEBYmxJXepuk+t3s84ISZStFa
 lIBt3L8MFGiIq1Mz+WO5D7JbDqzbro3MIMVW+8HA4tDZ8XwQj27ALjD9shKyn+C+qBcT
 eIxyfgqF4eFyq89KEGN9Ypa4vW8a0b9hguwIywHn2Wx/+pf/PirKreAVnUyyXK9JReIj
 LBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787210995; x=1787815795;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uXPI8c8JjDelMRqZENLxxutCdt4diF9INsZSmjvmSG0=;
 b=gEwTmlYS6OGGEIbCQ1cPoSoAGi01/0vMEeRPu40GVvCS3QhXeIAbFvW0099Ipi4LON
 t3Muhmva0hyARvEngEAKhwSecP8hnsbaxvN5+4MvC4HF/zM2wh8WTC6nHyxVvIZ/0DwV
 F8/WrbQpytNnqWl/hJeV9O2f7x8GrAjdWt6gnWW0mYj1mh6+X4+uugkV20xtzGgKsqyw
 Tmui+pwhKmDssWCyqkxYAjLPAq+/CS4OYW7M5fF2VY2CIXOJeuGlXUZVQ5/KwGjQYSyW
 lhvwaltg0l0H4hhC/9+P6pd/CHRLxTFktD0n7ZNGkbSYxxVBbL75K/yKbl/3YN6RhAkX
 Xt1g==
X-Gm-Message-State: AOJu0Yw4XPhPI7f1TOT2e+exI3BFFCB37caHk1F/stjZeoLlTzmmvV4P
 q3C/YsbOzhbA5PdQAS07XL9aQIL47s8ZyNGSWcxoR070tiwLsfoKSJ1kX13OMg36ziYXWLQSsGK
 qAH57O7KMc9jiTojZy6UnMxS4DmOBwLnpvc4QlZKRlsel1ycL99XFWmEyQQ==
X-Gm-Gg: AR+sD12ZXFd/bdhs9MPUh5Z/KwqKTX0Sdl19oJKNIw+VGCb3ioBnRHMsPr8N4x+LbQj
 oMsrGOE5hAKfe9wWqwYEG3z1hI4CJaaLQECQgdEBZFFUyLlPgREoJLt/Jcny+dnO/g4XwzbtU8M
 aE4VmmYfYNa/V+/j7e7t1I1RHoznAjvv+PPTNi2USAXo+0TyJdH06MpEGS0DeCWHKOyG1gRVYBH
 dTDNFy1CjlQLrhYbx/+tBOQD9pM7CK1x3n0xh2DRA6YIFLht7bJ+z0G3xX0fZE7g6upUGRh9xhR
 C+soLuCGKN7saq4IzzRJjxYCveRDUWLSVaxKWQccL9I5fzdt8ts7ztAR+TsyjrssWJlOo4c1j5i
 tB64UUtXewmenq8JpCLZwTUo=
X-Received: by 2002:a05:620a:4012:b0:92e:f372:7b5b with SMTP id
 af79cd13be357-9371e1e04b1mr911394285a.10.1787210995090; 
 Thu, 20 Aug 2026 00:29:55 -0700 (PDT)
X-Received: by 2002:a05:620a:4012:b0:92e:f372:7b5b with SMTP id
 af79cd13be357-9371e1e04b1mr911391085a.10.1787210994560; 
 Thu, 20 Aug 2026 00:29:54 -0700 (PDT)
Received: from [10.111.143.150] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441748sm11572932f8f.8.2026.08.20.00.29.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 00:29:53 -0700 (PDT)
Message-ID: <bbe4b7d0-96ad-45d8-a5a9-0be2c5479d51@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 09:29:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/11] target/arm: Extract halt-to-exec transition out of
 arm_cpu_exec_halt()
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
 <20260819145649.23439-7-philmd@oss.qualcomm.com>
 <44833559-f73d-4b8c-acec-a3e86b98c393@linaro.org>
 <CAFEAcA8xk8y1W0UvttpVhKYuoMBSQqZoF_15of0Rrq4wKkWDuw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFEAcA8xk8y1W0UvttpVhKYuoMBSQqZoF_15of0Rrq4wKkWDuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA1MyBTYWx0ZWRfX1lSZNz1oEr0i
 TlIh/d7f5obrKWT5HjXw/q8BQmUFzM3S3L8NAZ3EDRhqzG+MAeiw3av/zbiNJUpVgpc+pphDF61
 1HsR8GHxG5rLU4pRNjVlx5Me7J5khv9pXR9oCUtfPYqkmL10aUtoJOdGSQmY15KvMJc+zEap0+Y
 9fWzDkDXhWJuwl8UFEb9Ac4H6vJK/65NWZ6xvBmPZBeM6wigr8PlATzbwQZRSfJFmPSphsnjpXj
 5WgIfOpAH2fZEwfsOaBlrp7mJ7dz2uDynPNiMwShGjCJWp8AlKpht3e49Pq3j88ljcX4O+WyMi7
 Z4TZR/2cx2ZfjF1LEIIfzGbXtM+yieiGfQFLGCNwifNzVJA5+qtKExLUcE6gTTRQ19FE/3+WDrV
 AQ3r6rSFZNvnNupfpnIu4CdHsZyU6z96c0MCoEGZPtkatHLJxU3MWgKaXkiWR3nG6A7ZyAMarO6
 DjPkR8HbAXYN3xjm0lQ==
X-Authority-Analysis: v=2.4 cv=KpJ9H2WN c=1 sm=1 tr=0 ts=6a86acf4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=G4IyrqO34B3xu_XtIhYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA1MyBTYWx0ZWRfXzkT43sUI55hV
 aTHQKOE5EvodKvsgt9QFyDmAnd2uxoa3NTFzWLvQbWRldaFVZ+4oR1cKwIK++L5uca4gJIKmR2k
 FwKxelIp56v4awQ7i/y3byRa11Cg7yE=
X-Proofpoint-ORIG-GUID: RgRYYZK3AgD8C0Fc3rdi-u6Jw_tKN_YD
X-Proofpoint-GUID: RgRYYZK3AgD8C0Fc3rdi-u6Jw_tKN_YD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200053
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

On 2026-08-19 23:40, Peter Maydell wrote:
> On Wed, 19 Aug 2026 at 21:14, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 8/19/26 07:56, Philippe Mathieu-Daudé wrote:
>>> Refactor the target-specific halt-to-execution transition
>>> logic (disable WFE/WFI timers, clear the halt_reason flag)
>>> into a separate arm_cpu_transition_halt_to_exec() function.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>> ---
>>>    target/arm/cpu.c | 22 +++++++++++++++-------
>>>    1 file changed, 15 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
>>> index 77aa78f00e2..8e9b584559d 100644
>>> --- a/target/arm/cpu.c
>>> +++ b/target/arm/cpu.c
>>> @@ -870,18 +870,26 @@ static bool arm_cpu_internal_is_big_endian(CPUState *cs)
>>>    }
>>>
>>>    #ifdef CONFIG_TCG
>>> +static void arm_cpu_transition_halt_to_exec(CPUState *cs)
>>> +{
>>> +    ARMCPU *cpu = ARM_CPU(cs);
>>> +
>>> +    assert(cpu_has_work(cs));
>>
>> In reply to patch 11 you suggest removing this.
>> I wonder why you added it in the first place.
> 
> Does the accel loop enforce that we hold the BQL when
> arm_cpu_exec_halt() is called?

For MTTCG:

mttcg_cpu_thread_fn()
{
   bql_lock();
   while (1)
     qemu_process_cpu_events(cpu);
     if (cpu_can_run(cpu)) {
       bql_unlock();
       tcg_cpu_exec(cpu);
         cpu_exec(cpu);
           if (cpu->halted) {
             cpu_has_work_after_processing_async_events(cpu);
               process_async_events(cpu);
                 x86_cpu_process_async_events(); // APIC takes BQL
               cpu_has_work(cpu);
               transition_halt_to_exec(cpu);
                 arm_cpu_transition_halt_to_exec(); // timer_lock
                 x86_cpu_transition_halt_to_exec();
         ...
       bql_lock();
       ...
}

void x86_cpu_process_async_events()
{
     /* (BQL not held) */
     if (cpu_test_interrupt()) {
         bql_lock();
         apic_poll_irq();
           apic_sync_vapic();
           apic_update_irq();
             cpu_interrupt();
         cpu_reset_interrupt(cpu, CPU_INTERRUPT_POLL);
         bql_unlock();
     }
}

void arm_cpu_transition_halt_to_exec()
{
     /* (BQL not held) */
     timer_del();
       qemu_mutex_lock();
       timer_del_locked();
       qemu_mutex_unlock();
}

void x86_cpu_transition_halt_to_exec()
{
     /* (BQL not held) */
     do_interrupt_all();
       handle_even_inj();
       x86_ldl_phys(VMCB);
         address_space_ldl_le(VMCB);
           device MMIO?
       x86_stl_phys(VMCB);
         address_space_stl_le(VMCB);
           device MMIO?
}

VMCB address is guest-controlled, it comes from the guest %EAX
register passed to the VMRUN instruction (see helper_vmrun).
(I'm not looking further at the SVM specification).

> If not then the assertion
> is racy, because something might get in and e.g. lower
> an IRQ line so that cpu_has_work() is no longer true
> (which would be fine -- it just means we made the decision
> to wake up and that won vs the incoming interrupt).
> 
> On the one hand, if we don't have the BQL in has_work and
> exec_halt then we should be a lot more careful about how
> we code them (e.g. use of the right kind of atomics, and
> there's no way the call to do_interrupt_all() in the x86
> exec_halt can be safe without the BQL, surely).
> 
> On the other hand, if we do have the BQL in exec_halt
> then why is the x86 implementation explicitly taking
> the BQL when it calls apic_poll_irq()?

This analysis is similar before this series applied.
I don't have any idea how to proceed, I suppose from
here you expect Paolo / Richard to provide their feedback.



