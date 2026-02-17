Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4062AE9A03E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 22:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsTIH-0002qS-K8; Tue, 17 Feb 2026 17:11:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsTI8-0002p7-9Q
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 17:11:37 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vsTI6-0002rQ-IE
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 17:11:36 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4837907f535so33646125e9.3
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 14:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771366291; x=1771971091; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VbSI8sKeyQtp3rjqTHj6mat5WvC8UwYmJX1WBuusKA4=;
 b=WuyUnQ+OCyZWBmz6t+1Q0qcQFjPhW9Xc0Zah4yPVOBGpyvGpwcojoj+nHCA/UpOFLf
 urukb6zx468LEIkTymdl4/VxFdjug0fF2sxE4OxYg56bSusLk9GGyIAc4hFVLs7HxefQ
 r6L2FBzKHXTFzMfVLRbmkCggP7lIFGo14y9IqmrfUmdRdjWXgZlPgwCVVmkrcAk4nhXS
 uUdX0RxZzD1mIQzLqFiRCu3baKsaOeoixsZdAzib3CnDJdlb+bIhW3S2oAX/BwPQ9vfc
 0X6AE4jt4urcmJ4jMzRJ5di9j8+e9laEc3XU2kEzksPFONOsfcHB742KaIE1XWiGGbhE
 L37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771366291; x=1771971091;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VbSI8sKeyQtp3rjqTHj6mat5WvC8UwYmJX1WBuusKA4=;
 b=MNjRJey8GA2XJa7cMy0RNx1p+1tlJEs5fw2hCk7J7sKxtZHOWYqPmCUQwdi3rpxoaf
 C0PXEvW7sqId3aH2bXcqJX0c5WKw6Cs+opuHjYfWwvZtgBApnHOo/67/5UcCAlPkgZ0L
 jFbh6trRJFmjrBU6OihiLjNN5aATb27KqeZnQlG2IOtByv4Y5O+q3ZykjbFeoWa8AYmQ
 gH8no6+lWk+Lk3a+owFUyu6kp6eB3KB5LyqjI0YVSRHc1y6pcb+0nXEOg+QJL58CgWHQ
 7998En2lzMZ2iJFOx8krToDo/tDkNlUHxuV/iJCiQGfwuzTniYGEYm62lS9X9/e/rDsI
 pVlA==
X-Gm-Message-State: AOJu0YzeS3Xuy1GKRyXL5gofPk32cwTUPPTVsyS+2yjnEFFU1uClpzlL
 fLOf3a2I/7sNz2yUpGgdIReH3F4qwQqsHpds5UAj/VQGfxvQOWy7sATWwI1x89LbE/0=
X-Gm-Gg: AZuq6aK2UI2yYr5svk+td3DqxDKAwRAEns4DORYPF3wj2t+lz+HFQRTpRRQTaTpkiNv
 yArn6mfIYB3+IXCHHN7hxDIHrIP98WOfr2MHPjyG25kp8QIrBmENk9i7m4MZgAZv4Wt2CoOTHPP
 eWLGtrspjtXTiKFK/u0l2eZN5EwqSOicnJ5J9DW7yAmJboJiWbL1kRTG2NqzcB7xvNAJT7aEB7f
 Dhe57d67RgQrAz0EotoyFFkxeVvKF6bgQy3z0W5em8Hi4RIrhkYAT+QWbXTm2cu4Pnj//y1aEJc
 O84bGqnPSmOyzFkUCzxeg/hRUYeqV2p6XFXoCwFO7RiZeFgtvtHBHgRcNmx/xsaBEmX/u7m9Wn5
 fuKqdODszCNe0FZ+Q2xHUzwVlKBl+BcankSBue2XbZcKHzNxc1qH7bluNOafra3JQKYgMUXgBs3
 op8VKNOGI1NdX3jZqfQK52kQIyQzFVAVdSmFteKoYY9XDkwzAIoMHrFpd4RxU3lB71FA==
X-Received: by 2002:a05:600c:45c8:b0:480:1b65:b741 with SMTP id
 5b1f17b1804b1-48379b9913cmr214399925e9.15.1771366291084; 
 Tue, 17 Feb 2026 14:11:31 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483983b837fsm3239155e9.5.2026.02.17.14.11.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 14:11:30 -0800 (PST)
Message-ID: <e158b702-12f9-4fa5-890e-f3f80c13c3ff@linaro.org>
Date: Tue, 17 Feb 2026 23:11:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/alpha: Reset CPU
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, Yodel Eldar <yodel.eldar@yodel.dev>
References: <20260217-alpha-v1-0-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
 <20260217-alpha-v1-1-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
 <CAFEAcA_BJdifU=58m7ObeAe_ZByE6M-Zkg0cU70wP10+gpUkNg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_BJdifU=58m7ObeAe_ZByE6M-Zkg0cU70wP10+gpUkNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 17/2/26 10:21, Peter Maydell wrote:
> On Tue, 17 Feb 2026 at 06:35, Akihiko Odaki
> <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> alpha_cpu_realizefn() did not properly call cpu_reset(), which
>> corrupted icount. Add the missing function call to fix icount.
>>
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> ---
>>   target/alpha/cpu.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
>> index 1780db7d1e29..74281ebdb367 100644
>> --- a/target/alpha/cpu.c
>> +++ b/target/alpha/cpu.c
>> @@ -124,6 +124,7 @@ static void alpha_cpu_realizefn(DeviceState *dev, Error **errp)
>>       }
>>
>>       qemu_init_vcpu(cs);
>> +    cpu_reset(cs);
>>
>>       acc->parent_realize(dev, errp);
>>   }
> 
> Realize functions shouldn't call reset on themselves.

Agreed, but we are not consistent at all:

target/arm/cpu.c=1621=static void arm_cpu_realizefn(DeviceState *dev, 
Error **errp)
target/arm/cpu.c-1622-{
...
target/arm/cpu.c:2211:    cpu_reset(cs);

(this function is SO big!)

target/avr/cpu.c=126=static void avr_cpu_realizefn(DeviceState *dev, 
Error **errp)
target/avr/cpu.c-127-{
...
target/avr/cpu.c:140:    cpu_reset(cs);

target/hexagon/cpu.c=311=static void hexagon_cpu_realize(DeviceState 
*dev, Error **errp)
target/hexagon/cpu.c-312-{
...
target/hexagon/cpu.c:328:    cpu_reset(cs);

target/i386/cpu.c=9772=static void x86_cpu_realizefn(DeviceState *dev, 
Error **errp)
target/i386/cpu.c-9773-{
...
target/i386/cpu.c-10024- 
qemu_register_reset(x86_cpu_machine_reset_cb, cpu);
...
target/i386/cpu.c:10045:    cpu_reset(cs);

target/loongarch/cpu.c=525=static void 
loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
target/loongarch/cpu.c-526-{
...
target/loongarch/cpu.c:540:    cpu_reset(cs);

target/m68k/cpu.c=379=static void m68k_cpu_realizefn(DeviceState *dev, 
Error **errp)
target/m68k/cpu.c-380-{
...
target/m68k/cpu.c:396:    cpu_reset(cs);

target/mips/cpu.c=455=static void mips_cpu_realizefn(DeviceState *dev, 
Error **errp)
target/mips/cpu.c-456-{
...
target/mips/cpu.c:491:    cpu_reset(cs);

target/or1k/cpu.c=167=static void openrisc_cpu_realizefn(DeviceState 
*dev, Error **errp)
target/or1k/cpu.c-168-{
...
target/or1k/cpu.c:180:    cpu_reset(cs);

target/riscv/cpu.c=925=static void riscv_cpu_realize(DeviceState *dev, 
Error **errp)
target/riscv/cpu.c-926-{
...
target/riscv/cpu.c:953:    cpu_reset(cs);

target/rx/cpu.c=144=static void rx_cpu_realize(DeviceState *dev, Error 
**errp)
target/rx/cpu.c-145-{
...
target/rx/cpu.c:157:    cpu_reset(cs);

target/s390x/cpu.c=234=static void s390_cpu_realizefn(DeviceState *dev, 
Error **errp)
target/s390x/cpu.c-235-{
...
target/s390x/cpu.c:272:        cpu_reset(cs);

target/tricore/cpu.c=94=static void tricore_cpu_realizefn(DeviceState 
*dev, Error **errp)
target/tricore/cpu.c-95-{
...
target/tricore/cpu.c:123:    cpu_reset(cs);

FTR other references are in this thread:
https://lore.kernel.org/qemu-devel/CAFEAcA-PEY8utD0OiUmhOBJb24_znFpQwOtzS_BPgbYGJ=8cmg@mail.gmail.com/

If you don't beat me to it, this is a topic I'm interested in,
but not on the top of my priority list :/

> For CPU objects it is currently the responsibility of the
> board code to arrange that the CPU objects get reset.
> 
> thanks
> -- PMM
> 


