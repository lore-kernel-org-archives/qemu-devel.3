Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040A8D46C1E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 03:45:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlIxH-0007cG-RA; Wed, 28 Jan 2026 22:44:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlIxE-0007bt-KM
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 22:44:24 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlIxC-0005RH-Dk
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 22:44:23 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-35334ea1f98so201196a91.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 19:44:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769658260; x=1770263060; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=NkhP4wNEJTfMWe4N9q3961mEt+qkZNj3LN6Y3Hfx31Q=;
 b=FF1Tu1Mp8iFkOWeFvldi/renFlZvJ/5nxdF2F2TX4aXVwBXmFx3JbkzyeUpKdz+v4+
 OUx6UAZN28GGEbvS+kBJfb2ml1RXeJMKo5RNRc0FQ2LcNrFZMfzsey7O263Hq9MYOCok
 vsKjg8yp2OlcsefO5xtE8vBOLBi+cXHUbaxv11ye8eIerQNSBP+dENQu8pkGE98UtM0q
 ALGrr2dFKraoyDSkI9hF6wrT/uMuQqtor+sbqF9hDyGjXpv0UtRfSb0+ht1H2Apky+mM
 CYeCFsdgtaf9y5kpEIP9hjc2v4oR+zpRCxoKq7XP1RWx1aFTheUmESUff6CKTBbhRBqQ
 DTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769658260; x=1770263060;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NkhP4wNEJTfMWe4N9q3961mEt+qkZNj3LN6Y3Hfx31Q=;
 b=M1ILpt9NIizsdRrmAgJQQZp3AeSsAiGknbIc9flZMKIRsh3Tz6YAGI0UWguvbzNMfJ
 UP1mskBzjXf7bB1bBVPI7DL1a5D9RcsIbHIDezwN3tFwVZHsrrFBDOe2aYQcxoyhSeRp
 PNifFkIGP1gVeVz4nXiObNlv1BDF0NgUT5iGhfkLMpgKXAQqgJ48VQQMbvQmkXvsAOwv
 7hm9jxkXw5AnDn8ecq5xcn0vWySV8fDePwAXHS5nuc4pAAPNl5LPv+JlZQ5oCVgWkB7P
 NaxckbJIgJEn7f0bBbQ3vjCee54YJGoP9ESD11DCV/FfvzHMHI7K+OWiQpOW4u4c4D4M
 YM6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVC/J9ND3UgySPWxT5fOraGgLVOUynezIjvYuj7+lTEbgFv7vDWaw4QWiR8pV/pQlQd9AI+vU1/IkkG@nongnu.org
X-Gm-Message-State: AOJu0YxvH/xcsYJNe/RlgTsbixle73cS5DA6kTF7UB96h/qADO1EcB1f
 XBJlgzQp6TjCba4766WKBaxV6HcjWvGVVRna6zbB5RT07a3rLL0v+ebIUuQNasFKRaw=
X-Gm-Gg: AZuq6aI3t1FueeER0iHjVJZQyNSDF+ODkeJURTbcNyQBaXoveZPoWNWejXb+Bf/aRWE
 jOBlwJmap0wg6xX4J4W5eu8Q8pGRuryJbApg2HMGCEwlUnJToTun6gktMF1BzBYv4EcRp5Ir1Hd
 4Zyl1p33BL+1fMddI9ZUq8kdGRzb/2j+YcSMhuWkxwfanIEsuxZXSa/Sp+66pnQHxE7MEsWO7Lp
 O4KV8obYJwnQULdzPqRQnxRuvhqkExrsTgB2xKxoIPpR8Le6rdGilsHVr0Dxt56/Qg2axj5A6jh
 0gRbbSWuqvzdoaJ/RT8XCz33hPeW/kHjgvFw7sJVc0PoEWj9gFibWMjtq5kxxgwQ8F1NmDsFkB/
 vlX+UrMQ4sjSRXK8cr3NwZAyu6WB8KZ7hiMIH/zNoYwy0fmkzsOhnOhx0klZA80Eh9dnIe6q4k4
 GKCfULhhdE9z5gACU9xBs1O/HQGAxsIVOA8a9rnNXAUL+ous07yv4nJj4j
X-Received: by 2002:a17:90b:3b8c:b0:33f:f22c:8602 with SMTP id
 98e67ed59e1d1-353fed88e82mr6547849a91.26.1769658260421; 
 Wed, 28 Jan 2026 19:44:20 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-353f61292bdsm6865282a91.6.2026.01.28.19.44.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 19:44:20 -0800 (PST)
Message-ID: <b030fad3-3cef-4e59-98bb-6305f2f2323e@linaro.org>
Date: Wed, 28 Jan 2026 19:44:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 06/20] linux-user: add plugin API to filter syscalls
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Ziyang Zhang <functioner@sjtu.edu.cn>, Mingyuan Xia <xiamy@ultrarisc.com>
References: <20260129013134.3956938-1-pierrick.bouvier@linaro.org>
 <20260129013134.3956938-7-pierrick.bouvier@linaro.org>
 <a44ba710-25ca-44c2-bcdb-db917efaaaeb@linaro.org>
 <e85a01a2-faf3-406e-a260-ce8a832ed9cb@linaro.org>
Content-Language: en-US
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <e85a01a2-faf3-406e-a260-ce8a832ed9cb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

On 1/28/26 6:56 PM, Pierrick Bouvier wrote:
> On 1/28/26 6:28 PM, Richard Henderson wrote:
>> On 1/29/26 12:31, Pierrick Bouvier wrote:
>>> --- a/include/user/syscall-trace.h
>>> +++ b/include/user/syscall-trace.h
>>> @@ -39,5 +39,22 @@ static inline void record_syscall_return(CPUState *cpu, int num, abi_long ret)
>>>         gdb_syscall_return(cpu, num);
>>>     }
>>>     
>>> +static bool send_through_syscall_filters(CPUState *cpu, int num,
>>> +                                         abi_long arg1, abi_long arg2,
>>> +                                         abi_long arg3, abi_long arg4,
>>> +                                         abi_long arg5, abi_long arg6,
>>> +                                         abi_long arg7, abi_long arg8,
>>> +                                         abi_long *sysret)
>>> +{
>>> +    uint64_t sysret64 = 0;
>>> +    bool filtered = qemu_plugin_vcpu_syscall_filter(cpu, num, arg1, arg2,
>>> +                                                    arg3, arg4, arg5, arg6,
>>> +                                                    arg7, arg8, &sysret64);
>>> +    if (filtered) {
>>> +        *sysret = sysret64;
>>> +    }
>>> +    return filtered;
>>> +}
>>
>> FreeBSD build failure:
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/12906481914
>>
>> In file included from ../bsd-user/freebsd/os-syscall.c:34:
>> /tmp/cirrus-ci-build/include/user/syscall-trace.h:42:13: error: unused function
>> 'send_through_syscall_filters' [-Werror,-Wunused-function]
>>       42 | static bool send_through_syscall_filters(CPUState *cpu, int num,
>>          |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> 1 error generated.
>>
>> Why is this in the header anyway?  If it really *should* be shared with FreeBSD, then it
>> could just as well live somewhere in plugins/.  If it really is linux-specific, then it
>> could just as well live in linux-user/syscall.c.
>>
>>
>> r~
> 
> Sorry, it fell through the cracks.
> 
> FreeBSD has no werror by default, and the pipeline I ran doesn't add
> explicitly add --enable-werror. Warning is there though:
> https://github.com/pbo-linaro/qemu/actions/runs/21461090659/job/61813517774
> I'll make sure to build with werror enabled for next runs.
> 
> This function was added in this header, next to
> record_syscall_start/end, which is not used by BSD neither. It doesn't
> raise a warning because they are static inline. The original dev added
> it where it made sense.
> 
> Current series only has BSD implementation, but original

only has *Linux* implementation

> qemu_plugin_vcpu_syscall supports only Linux too.
> It could be implemented though, but not sure someone will spend time on
> that for BSD.
> 
> If that's ok for you, I can move the function to linux-user/syscall.c
> and remove the header. How about that?
> 
> Regards,
> Pierrick


