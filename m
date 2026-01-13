Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7383BD30CC2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 20:37:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfl8G-0002cM-F4; Tue, 13 Jan 2026 15:36:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfl8E-0002b6-72
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 15:36:50 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfl8B-0006XR-FQ
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 15:36:49 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so573605e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 12:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768336606; x=1768941406; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=18nq5YW1Zn7IotmsLm+PZ7wRYFPyzzUH/6sFJ+jraZ0=;
 b=hs5zG3k6gCWIbvwhqLRJotsfCmh0a46rqWpnkoMfJL+t7ModuBGbKqtmB3vKRye6oR
 UgKi3a3Oeq0HsTDPAQXSrEkXpPaoIKE4b5tQ1OzorRZOnsYYcTsHMEL2YkGNPZzqEzrM
 Tfo1i75J9Zzz0g3Acs20owUa+2TnEfC7hU1rLRQkcZzmumJtBhzH1enJvOrNJUUHeEA0
 VEQR+UUKZl2+HT+Y5MyRiY36IZLnegS9S+0mtyZKCppUjtvzLoxUyBITNITPTSI137oW
 gR1EVZHBlc7RkMX/DlR+UwCT4DOCMHCZaC5fd35eeNPyGxTmoO3nqBPqDa8WlgglV1Xs
 21Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768336606; x=1768941406;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=18nq5YW1Zn7IotmsLm+PZ7wRYFPyzzUH/6sFJ+jraZ0=;
 b=b0WqziSUqSV5+LqIG2PoohMZcxZzPfb0AnqSnjkt5dFB+AlUDHg2qWYjpNyHfwFeWG
 ACw/KigG2r0iPhCG6ERFcKAaUJpTKeQwA6oxL4Kej2VjfvfS5OFp0Mv/oSjmgjOW1qXu
 ICPO3w7YtlGh8lW527PMxyPjzJROXcM8sLjaSSAl11CvzLsJbrQq660RrJVVyKUjmZKh
 W8OtN3AGcwHo/M+8U5yOi7WcZ4uqQG6yFTioZ8sOqMpBaLUaALWhorrtuaCWS5BBXrr5
 NhrJu6tA2+i78scegUQ82lnwI2+ZdJuNBb6azdcI9x2IGWwmx7Dw+onwd8RgRDEaAua+
 /PTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX22AYu1VNNbKEI2OTWiGpwRin6W51yXMxi0oou1WuuOpbpC9vxaGSw5uHlJTTYXTj0g+5AzEfxGSZG@nongnu.org
X-Gm-Message-State: AOJu0Yysxa0r6+vkbEb2yXp84xnwqTldle1vXhdbQtDfBOQvyCX1n0gJ
 2x3DQvnJW0ZGP2MuGJsKzjtsAl+7uVCq8ihEIwSJtmac+LdQjiSlCT8v8gUMguqXtzA=
X-Gm-Gg: AY/fxX7tuzig1YcaXXWAQU8tr4IzK/p5iyCL24EQoUgXKePF366gDEw7n4WzFe5pYwr
 DpMaB9u/cbB/EStu+ZBVxI7QUXLJZgZr0AVe5ZdGHy7b8r6Bp5KvaFGVVRrCReV9dx1pQUhZNkj
 iocpEfOKryt54UzsyN+YWyDEwcf/TpC3zt5BDQOlOisz5Lf1D3ZhlIh1bLKQnJf5T2EiVW7iUiB
 yT+B1H7Rfjj0Jhj6HyIO4orP6C2SY9FRfzFcQwHquSuWUr1pEHJobrfMvmmszCfwUEPYZ9DbS+n
 8dbWnLYL3iLbXICgrq8kP2LMdBAWXZxZLILYGT5ucZRnI7vHvkyZn7D1gKcI6+G4dx3yc+Zz8mz
 wLagXOejkjBvLxone7g7P1qGVAHMoCEsvWmHpLpya0cwlcd/Hgw1UIrzDLmDy0YN4xm84GkT/sb
 6JcAaiATI4y5FnRgYH0zrUrle73WCKjS5DBwHjW3AoXidnDTUNhULO6A==
X-Received: by 2002:a05:600c:35c6:b0:47e:e076:c7a2 with SMTP id
 5b1f17b1804b1-47ee3320904mr5946155e9.15.1768336605726; 
 Tue, 13 Jan 2026 12:36:45 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f6953fasm413006105e9.5.2026.01.13.12.36.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 12:36:44 -0800 (PST)
Message-ID: <a007e74f-9df6-45ce-a372-3721d6f45201@linaro.org>
Date: Tue, 13 Jan 2026 21:36:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 13/31] accel/nvmm: Replace @dirty field by generic
 CPUState::vcpu_dirty field
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250704101433.8813-1-philmd@linaro.org>
 <20250704101433.8813-14-philmd@linaro.org>
 <44ccfba7-21a3-4c24-aa6a-4b2bdb989792@redhat.com>
 <dd7fbe03-1458-4c44-b8db-a9d5e9ae33f1@linaro.org>
In-Reply-To: <dd7fbe03-1458-4c44-b8db-a9d5e9ae33f1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 13/1/26 21:30, Philippe Mathieu-Daudé wrote:
> On 13/1/26 20:32, Thomas Huth wrote:
>> On 04/07/2025 12.14, Philippe Mathieu-Daudé wrote:
>>> No need for accel-specific @dirty field when we have
>>> a generic one in CPUState.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>>> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>>> Message-Id: <20250703173248.44995-20-philmd@linaro.org>
>>> ---
>>>   target/i386/nvmm/nvmm-all.c | 21 ++++++++++-----------
>>>   1 file changed, 10 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
>>> index f1c6120ccf1..aea61a6fd2a 100644
>>> --- a/target/i386/nvmm/nvmm-all.c
>>> +++ b/target/i386/nvmm/nvmm-all.c
>> ...
>>> @@ -982,7 +981,7 @@ nvmm_init_vcpu(CPUState *cpu)
>>>           }
>>>       }
>>> -    qcpu->dirty = true;
>>> +    qcpu->vcpu_dirty = true;
>>>       cpu->accel = qcpu;
>>>       return 0;
>>
>> FYI, this does not seem to compile:
>>
>> ../src/target/i386/nvmm/nvmm-all.c: In function 'nvmm_init_vcpu':
>> ../src/target/i386/nvmm/nvmm-all.c:988:9: error: 'AccelCPUState' has 
>> no member named 'vcpu_dirty'
>>    988 |     qcpu->vcpu_dirty = true;
>>        |         ^~
> 
> s/qcpu/cpu/
> 
>>
>> Is anybody checking the netbsd builds at all?
> 
> 3 reviewers and 6 months later.

and 7 commits on top of this PR :)

$ git log --oneline 2098164a6be..master -- target/i386/nvmm/nvmm-all.c
d5e1d2dea11 target/i386: clear CPU_INTERRUPT_SIPI for all accelerators
5699f6a4409 target/i386/nvmm: Inline cpu_physical_memory_rw() in 
nvmm_mem_callback
9a191d3782d cpus: clear exit_request in qemu_process_cpu_events
f084ff128b6 accel: use atomic accesses for exit_request
ac6c8a390b4 accel: use store_release/load_acquire for cross-thread 
exit_request
602d5ebba26 treewide: clear bits of cs->interrupt_request with 
cpu_reset_interrupt()
87511341c30 add cpu_test_interrupt()/cpu_set_interrupt() helpers and use 
them tree wide
f96b157ebb9 Merge tag 'accel-20250715' of https://github.com/philmd/qemu 
into staging
f7a7e7dd217 accel: Extract AccelClass definition to 'accel/accel-ops.h'
d93972d88b0 target/i386: nvmm, whpx: add accel/CPU class that sets host 
vendor
51e18961999 accel: Propagate AccelState to AccelClass::init_machine()
b6637bd5561 accel/nvmm: Expose nvmm_enabled() to common code

> 
> Should we add a policy for bitrotting untested code?
> 
>> (I'm currently trying to update test/vm/netbsd to version 10.1, that's 
>> how I noticed it)
>>
>>   Thomas
>>
> 


