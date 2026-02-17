Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CFBBE9A03B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsSq4-0003Nk-7w; Tue, 17 Feb 2026 16:42:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsSpy-0003NQ-O6
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:42:31 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsSpw-0006xW-3L
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:42:29 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4837634de51so16115615e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 13:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771364546; x=1771969346; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=23lOLXH6UDtBRionhi+eC9hOB8wlhztFmCHPfKh7Jbc=;
 b=qqKm27rVtQ7pP2/cKeEHgcKQYdx7skGrX18TaX59OreFEkxEIFqekk44oOdldCJvfr
 QN1SM6kvDfnOo+Fpaaj7cR+UnRa/VpQu6JbxT1pWBRviqRlK8o8h/sho9IzUQvh1RLGQ
 dtdOCZOkAmtFnWjprTzwm4PAWtR6w6U4JOBv1l1pu9L9O4M3hZjJ4n3IUQvfc6hL2DhR
 ad+JgWn9Ap4qely4lpMd9PA/OkrlUIn5qNcYUFc4pe0LqSJI4f6oi93pe0gppiobKdZW
 NLtUn8W2LX0+n1xWPuVniJ041oz2aOzypX3dCpsboJTMGZvuXRo9fsVI1Zhq+Dm/AOo7
 YpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771364546; x=1771969346;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=23lOLXH6UDtBRionhi+eC9hOB8wlhztFmCHPfKh7Jbc=;
 b=QnKYcOhFypFTEOY5BKAq5+ExWo2kwx0F+Hr+X1MGuBdkITCT/ULd+9ZwnT0ZCsZ2gR
 ozIM0c07xU7x7atgW4kr0U+l0E0/UoEyhV8QuxjviMsSDTuJ23VlYcwvmoc+qgLLS/5Q
 Or2M2zrpJmv7a71mjtPEWHO10AfF0oWNMTTxN3C7PQv4dQbfrUVzBK6MmWo3fjYxhkbt
 G1WtmaJt/O/I83ASjdXT/IPUCmACVkCJ1vARRCbxInI7kvHjCL6OCDH8iWr7WCUXq3aC
 8L6x/ZEYU3OkmDpMfy51Y9jaytqpKoVJgcuMVnDHhBP29JsnL7/Ox9P/WRZ1gcY/biqT
 r4AA==
X-Gm-Message-State: AOJu0Yy3upxcIQcA9Ai1vrNqCoh/SZVCmQLG6pqdrc7u34DE6TSmAEV2
 vuVbsXYBEm6TUfbMjZnQu55GDQJ4RrDv+35J34gsGs1mMSUcL48cmYbMJAWsYoDoFnk=
X-Gm-Gg: AZuq6aLD8FtUvW/Bx+RLVPyrJFw2AVaWS7qVEnKvCtYD/FytGxqi8uk1icXjVJqv6zl
 ArGbR4+WQL6rvdhxV+FP2VzQUUZ89z2QeI8W/3OCRynjN4u94tvcx1joMHX2AX5zldE7v70hb0G
 cIvWRhIsyS/5FnUaNYJVoh1Xq5H9s3BzRLatOFs/jXms1josixZkoTfSg43nsHN4w74/TqOMBO6
 IxNw7q5Ubodv1a6dZowIHKetpTibkJl14USXJ+H1W/e+X09KL4c5c/siYcsA5jP5q2o4MdYl4bn
 jGkhxPaxyCBX98rOackojKsh/b2M1DC1REPk7vpAmtxFYEi6gLrH6QHzdFFUscudFsxjLYMh0Dm
 jpHQJl6KSuiYD04jHc8pIw65t28IxsHuEb/176oGEuzDwJJK1oIuw9KZQphs5V6kRu0ADtSYPHd
 V/dehzXkDu0QCKj97FzFt5IPSN3QgogLEsIIAYyN7+gTEJFs/gd4WLfQ6GfXSx8FI1HQ==
X-Received: by 2002:a7b:cde1:0:b0:483:7ae2:1737 with SMTP id
 5b1f17b1804b1-4837ae2184fmr162247885e9.17.1771364546321; 
 Tue, 17 Feb 2026 13:42:26 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4837e565f5esm359254205e9.10.2026.02.17.13.42.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 13:42:25 -0800 (PST)
Message-ID: <28c7b18c-c998-4392-a1f2-9b287d7545c5@linaro.org>
Date: Tue, 17 Feb 2026 22:42:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/alpha: Reset CPU
Content-Language: en-US
To: Yodel Eldar <yodel.eldar@yodel.dev>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>
References: <20260217-alpha-v1-0-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
 <20260217-alpha-v1-1-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
 <CAFEAcA_BJdifU=58m7ObeAe_ZByE6M-Zkg0cU70wP10+gpUkNg@mail.gmail.com>
 <385d1a8e-c202-4d72-a24a-1e49478278b4@yodel.dev>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <385d1a8e-c202-4d72-a24a-1e49478278b4@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 17/2/26 20:12, Yodel Eldar wrote:
> +Philippe
> 
> Hi,
> 
> On 17/02/2026 03:21, Peter Maydell wrote:
>> On Tue, 17 Feb 2026 at 06:35, Akihiko Odaki
>> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>>
>>> alpha_cpu_realizefn() did not properly call cpu_reset(), which
>>> corrupted icount. Add the missing function call to fix icount.
>>>
>>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>>> ---
> 
> So, the real culprit was hiding in plain sight in Alpha-specific code
> all along? Congrats on finding it!
> 
>>>   target/alpha/cpu.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
>>> index 1780db7d1e29..74281ebdb367 100644
>>> --- a/target/alpha/cpu.c
>>> +++ b/target/alpha/cpu.c
>>> @@ -124,6 +124,7 @@ static void alpha_cpu_realizefn(DeviceState *dev, 
>>> Error **errp)
>>>       }
>>>
>>>       qemu_init_vcpu(cs);
>>> +    cpu_reset(cs);
>>>
>>>       acc->parent_realize(dev, errp);
>>>   }
>>
>> Realize functions shouldn't call reset on themselves.
>> For CPU objects it is currently the responsibility of the
>> board code to arrange that the CPU objects get reset.
>>
>> thanks
>> -- PMM
>>
> 
> I think the following addresses Peter's remarks; it passed 100
> repetitions of the Alpha replay test after reapplying the reverted
> commit:
> 
> diff --git hw/alpha/dp264.c hw/alpha/dp264.c
> index 5e64528431..091ffc0085 100644
> --- hw/alpha/dp264.c
> +++ hw/alpha/dp264.c
> @@ -68,5 +68,7 @@ static void clipper_init(MachineState *machine)
>       memset(cpus, 0, sizeof(cpus));
>       for (i = 0; i < smp_cpus; ++i) {
> -        cpus[i] = ALPHA_CPU(cpu_create(machine->cpu_type));
> +        CPUState *cpu = cpu_create(machine->cpu_type);
> +        cpu_reset(cpu);
> +        cpus[i] = ALPHA_CPU(cpu);

Hmm this pattern is used a lot (creating CPUs in board_init without
manually calling cpu_reset). If this is the simplest fix, maybe
we could add a cpu_create_resetted() helper and use it where
appropriate (i.e. not where qemu_register_reset is then called).

>       }
> 
> I haven't tested Philippe's suggested code, yet, but will begin shortly,
> although it may take me a while as it's more broadly scoped in terms of
> affected code (and the problem it addresses).

My suggestion is likely crap, I was just thinking aloud ;)

> 
> Thanks,
> Yodel
> 


