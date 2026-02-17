Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1923E9A03B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsSxW-0006qP-QL; Tue, 17 Feb 2026 16:50:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vsSxT-0006oD-8E
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:50:15 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vsSxP-0000qr-40
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:50:13 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 28F73596A3F;
 Tue, 17 Feb 2026 22:50:07 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 1W8_ono_5eO6; Tue, 17 Feb 2026 22:50:01 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C1F3F596A0D; Tue, 17 Feb 2026 22:50:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id BFC5E5969F0;
 Tue, 17 Feb 2026 22:50:01 +0100 (CET)
Date: Tue, 17 Feb 2026 22:50:01 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
cc: Yodel Eldar <yodel.eldar@yodel.dev>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, 
 Jim MacArthur <jim.macarthur@linaro.org>
Subject: Re: [PATCH 1/2] target/alpha: Reset CPU
In-Reply-To: <28c7b18c-c998-4392-a1f2-9b287d7545c5@linaro.org>
Message-ID: <6051494c-a55f-e4cd-faac-7c1f6c3288f0@eik.bme.hu>
References: <20260217-alpha-v1-0-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
 <20260217-alpha-v1-1-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
 <CAFEAcA_BJdifU=58m7ObeAe_ZByE6M-Zkg0cU70wP10+gpUkNg@mail.gmail.com>
 <385d1a8e-c202-4d72-a24a-1e49478278b4@yodel.dev>
 <28c7b18c-c998-4392-a1f2-9b287d7545c5@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1822290650-1771365001=:96587"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1822290650-1771365001=:96587
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 17 Feb 2026, Philippe Mathieu-Daudé wrote:
> On 17/2/26 20:12, Yodel Eldar wrote:
>> +Philippe
>> 
>> Hi,
>> 
>> On 17/02/2026 03:21, Peter Maydell wrote:
>>> On Tue, 17 Feb 2026 at 06:35, Akihiko Odaki
>>> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>>> 
>>>> alpha_cpu_realizefn() did not properly call cpu_reset(), which
>>>> corrupted icount. Add the missing function call to fix icount.
>>>> 
>>>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>>> ---
>> 
>> So, the real culprit was hiding in plain sight in Alpha-specific code
>> all along? Congrats on finding it!
>> 
>>>>   target/alpha/cpu.c | 1 +
>>>>   1 file changed, 1 insertion(+)
>>>> 
>>>> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
>>>> index 1780db7d1e29..74281ebdb367 100644
>>>> --- a/target/alpha/cpu.c
>>>> +++ b/target/alpha/cpu.c
>>>> @@ -124,6 +124,7 @@ static void alpha_cpu_realizefn(DeviceState *dev, 
>>>> Error **errp)
>>>>       }
>>>> 
>>>>       qemu_init_vcpu(cs);
>>>> +    cpu_reset(cs);
>>>> 
>>>>       acc->parent_realize(dev, errp);
>>>>   }
>>> 
>>> Realize functions shouldn't call reset on themselves.
>>> For CPU objects it is currently the responsibility of the
>>> board code to arrange that the CPU objects get reset.
>>> 
>>> thanks
>>> -- PMM
>>> 
>> 
>> I think the following addresses Peter's remarks; it passed 100
>> repetitions of the Alpha replay test after reapplying the reverted
>> commit:
>> 
>> diff --git hw/alpha/dp264.c hw/alpha/dp264.c
>> index 5e64528431..091ffc0085 100644
>> --- hw/alpha/dp264.c
>> +++ hw/alpha/dp264.c
>> @@ -68,5 +68,7 @@ static void clipper_init(MachineState *machine)
>>       memset(cpus, 0, sizeof(cpus));
>>       for (i = 0; i < smp_cpus; ++i) {
>> -        cpus[i] = ALPHA_CPU(cpu_create(machine->cpu_type));
>> +        CPUState *cpu = cpu_create(machine->cpu_type);
>> +        cpu_reset(cpu);
>> +        cpus[i] = ALPHA_CPU(cpu);
>
> Hmm this pattern is used a lot (creating CPUs in board_init without
> manually calling cpu_reset). If this is the simplest fix, maybe
> we could add a cpu_create_resetted() helper and use it where
> appropriate (i.e. not where qemu_register_reset is then called).

I've been bitten by this before and was suggested to add a 
machine_cpu_reset function that calls cpu_reset and register it with 
qemu_register_reset in the machine init method. That was a while ago so 
maybe things changed since but hw/ppc/ppc440_bamboo.c is a simple example 
showing this (although that machnie is old and not quite maintained 
machine so may not follow up to date recommendations) and most other ppc 
machines do this.

Regards,
BALATON Zoltan
--3866299591-1822290650-1771365001=:96587--

