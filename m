Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DFEFF459FC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 18:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBGSZ-0000F6-IQ; Fri, 10 Apr 2026 14:20:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBGSX-0000Ef-JG
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 14:20:01 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBGSU-0008VR-Fq
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 14:20:01 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso25807785e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 11:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775845196; x=1776449996; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nXl8Ns5iG79tarvyMgM8HOyOkIuENseuXWd0OueXkYc=;
 b=PR6/l9lcVg//CZTS4l37OIEPg/V0ZPPGbCZUbjE/eDNTFlU78ookvL6PG7+dzCLPBh
 zaNRTAeHMs5a6l4K8grxU02uCuLm9C/a5katdKxtYfi2cvq3iUBKGO2nUG92EMkPHdUm
 Bb5wREnOSmby5uc9LwooMNsfIdkSFifpXSf/X6NjHNyD7YhmGDr+4Uz4h5d5gp++SDZC
 IHXWNH4lzeW6yeSCj23AL08emZUKGkAsmEJEr8GmrDm3ED7rnBHKP8n/t6eAQLMbCYuB
 QuqxaPtoNibEQhTfqc5b66JfNb/sUZ62tykxH+MbBqHnn40By2yLhr/7G5+hkqGcRb6s
 vkbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775845196; x=1776449996;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nXl8Ns5iG79tarvyMgM8HOyOkIuENseuXWd0OueXkYc=;
 b=q8NU2ZowUPg6OZMNXmSP7PbCWkHguOiXi4YyCwHR9xa9yD/DdTgIVgDyUZC6cqDwQR
 D2r5tETC8jd7cPPuR8O1bZKLv5E0Ee8p3DERRxhQJNyuXfgz2pQKNB64VPNguQcjNPi+
 AtOmsOa6P+LanDgthZQ1g/uXklFvKYyOPvP0UHhLjCm/E1DOBl7ysL936GBjy5JOHM8Y
 Qi0wPdoDuqYbiwaosxuzWJt53z4pUgdlWp9u98GsfezFLCIQPVqZXuOPXCyLd1Ah6aIl
 kJyDh2jHPTQq71CpfYf8InYCdwmFdD/f5+mWIyJxB2NduZbCQ3WLeDqKKhWRKR1ZMX1h
 lLUA==
X-Gm-Message-State: AOJu0Yxz86WGZTHytSwSai2PnrkznTtG6H04C+7zR5WuXCkvln/LTAru
 sohqcuhULmHApEz3uWYeS+dpcPwIqbplgZ2/bqqN8xacLNQLQ/eUqetlFkRc+ksRIKw=
X-Gm-Gg: AeBDiesVEkVAuFVDQULhV7Ix+o2Mg3QWPAgOwrIynTpEtRnLrg1WdSyoJGPOKNoZCVp
 oPZiUn3uzzqlosbBcQYPwps1Ar02h8f6+hn9TGGJM3/2CIShBMCFzQGqQjUZeKoe7zDy+qMZPdA
 JoYNyqvnBBXZdmw5rLKTpe1Xiz961HuzUIQM6oXsifS7OmBCmkhUgkjWL7WgpYrymIOZxStGy8o
 MuWBiEkz+9qnKtePFKgas6phSBgGMNTHeJrkNNLtr7vV7Q5fY+FD+pNzX7GLU108jnTWEb+Dmpy
 wmxzAlFaX7blL2+6OMnDzgJU59D477Yww7+3zaehLQIoIESrkeTzX/U4kE2Vn/vNTZIkacgIgv0
 4Y1Izuocn4c15Daiar/kJqozk07z/CA/RCnlwSpUW0HoZLYOSVSzFBddipX6IY+HBJLv3VvSLba
 6deiDCOoEMa6x/ce/9CEc44URu7JXAQM5DMxa1F1HxRpAB3dx8TORZ5UPeK6nzcrFBtA==
X-Received: by 2002:a05:600c:8717:b0:477:9890:9ab8 with SMTP id
 5b1f17b1804b1-488d6816f5amr57028525e9.3.1775845195770; 
 Fri, 10 Apr 2026 11:19:55 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5dcf845sm25552895e9.11.2026.04.10.11.19.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2026 11:19:55 -0700 (PDT)
Message-ID: <821e6a48-941f-4094-9475-fff0aea8f0b1@linaro.org>
Date: Fri, 10 Apr 2026 20:19:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 v4] target/arm: Use vaddr type in
 handle_psci_call()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260410142932.33089-1-philmd@linaro.org>
 <CAFEAcA_=DjrPvYXyPJ-mBRtsSaKhdC6NYABcvz9R271V2cvznw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA_=DjrPvYXyPJ-mBRtsSaKhdC6NYABcvz9R271V2cvznw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 10/4/26 16:43, Peter Maydell wrote:
> On Fri, 10 Apr 2026 at 15:29, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Use 'vaddr' type for @entry, which is the start %pc for the
>> on-lining vCPU. This allows to remove an unnecessary target_ulong
>> in hvf_handle_psci_call().
>>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   target/arm/hvf/hvf.c  | 2 +-
>>   target/arm/tcg/psci.c | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
>> index 5fc8f6bbbd9..124644918ef 100644
>> --- a/target/arm/hvf/hvf.c
>> +++ b/target/arm/hvf/hvf.c
>> @@ -1418,7 +1418,7 @@ static bool hvf_handle_psci_call(CPUState *cpu, int *excp_ret)
>>       bool target_aarch64 = true;
>>       CPUState *target_cpu_state;
>>       ARMCPU *target_cpu;
>> -    target_ulong entry;
>> +    vaddr entry;
>>       int target_el = 1;
>>       int32_t ret = 0;
>>
>> diff --git a/target/arm/tcg/psci.c b/target/arm/tcg/psci.c
>> index 56754bde951..5df17bd059d 100644
>> --- a/target/arm/tcg/psci.c
>> +++ b/target/arm/tcg/psci.c
>> @@ -68,7 +68,7 @@ void arm_handle_psci_call(ARMCPU *cpu)
>>       CPUARMState *env = &cpu->env;
>>       uint64_t param[4];
>>       uint64_t context_id, mpidr;
>> -    uint64_t entry;
>> +    vaddr entry;
>>       int32_t ret = 0;
>>       int i;
> 
> So we take our argument which is a uint64_t in param[], and we
> put it into a vaddr entry, and then the only thing we do with that
> is pass it to arm_set_cpu_on() which takes a uint64_t... I'm not
> sure what the vaddr type is getting us here.
> 
> Should we just do in hvf.c the same thing we did already for
> tcg/psci.c in 3580aa03547f92, and make 'entry' a uint64_t ?

Well this was v3, I just wanted to address Richard comment:
https://lore.kernel.org/qemu-devel/e02da1c8-9f48-4dab-b4b8-302ab8c69d74@linaro.org/

I'll repost v3 as v5 so we can choose :)

