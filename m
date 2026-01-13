Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04BB7D30CC0
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 20:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfl4s-0008Ry-GM; Tue, 13 Jan 2026 15:33:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfl2E-0004Z6-9j
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 15:30:41 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vfl2C-0004UP-L8
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 15:30:38 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47775fb6c56so76525545e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 12:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768336235; x=1768941035; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=REhjPoaz8XrOXTAx83gvUErAk7Tt3iaBrZLQ9xbklzw=;
 b=BT4B1q5d41iUS+x6Y3e9vUhhdYHsdIchztopIyVo6tJ1Ag4UfZqgS1Zq6e6914k7Q6
 BqSsPRFdgrvE30r1kRQ+/Sz1JT9wjzi0PGaShf4Gxaj1+iNmGSrwJJiSXpLNCeWJ5mKp
 fal6t/YmQa3WDK9KRFK2hQjWeO+aUrfalfUXlnJV7ffMsXWIBn+jIFq4Jxni7rCL0rlN
 ePJsNGnLoxBR5C0jRG57RUpilRnLubD1VTLJDGW3XrDoCF0hpYB5LdM5Qd6ZvW7Lkqku
 VHmcr3VvnOT4GnJB6LWNjZZj4yB4/spQoJN09+4SaaYQvqGR2L1nWCWNNlltkzTxHCao
 zT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768336235; x=1768941035;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=REhjPoaz8XrOXTAx83gvUErAk7Tt3iaBrZLQ9xbklzw=;
 b=eZJgLlPobCmn7BrIE4e2fzxEn0bvO93Afu3JWk7Iazk6ydaPX37SIDDPWNNZ3DgoT3
 LKnRJ02sRfLP4xQzgsfmadh0d+fFmCLnG0ToOrAEdBPS0fEzf1/nglkZ2uO5GYoQrWh5
 QczohZWQIkxlfwIfS2FSKnmMblHmIIDSOTUwxx6ukPRsX5Z2Szx252cT9qktISPUs6sp
 ppY+xWP96NGPTsSjXzYsmkp+DrB6QXdRw1wf2UrAv7S6VljroscqB0N/nwLrzDkeoIG0
 czDf56g8igK4Zr8FjxXxcZV2mpgBeQCz0/tl1p6M96MSII0okKX6RKSzPjx8d2YyTX9+
 WIng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA6cxZRN3eH7VfMyKhZ0jtyYDPYdO1cVwVYPppuE6nDmvsxv/GU8H3yQ7blLHUearTkikGM3y6NSqG@nongnu.org
X-Gm-Message-State: AOJu0YwuHAu7x4AvrLw3VI4M/wQFVqSbKkKgYTKcQSuT9zUDHCVKYyai
 xD4HHm8nxm49H81taLFTuSrhxbSSHoLdLRMFnkQmQkjyFvyGaCvlugmfck4gEn2kRpw=
X-Gm-Gg: AY/fxX6umvXeCgSVil7Zgds9/JOZSsZuc93jMZ60aMxAvcY7dU5kWjFsrD03ZDKlVpg
 1mdqnmR8DkWUU/bJfcJH5iXXw7dUWLuNyGTCQ5U9Gx1tygG5Fhlhwv/5yPj1A5xRPdAJ5cf4pRa
 2TAMFs9GAGPs/qiFzc8sbmsn+N12QfiAseVa94yXwAdFkToj/v7flusapmaBcYBaCXSgLZeCdGt
 RSWsTONyplqyJUwjc51qZu22Saj1eNzoiJll5aeRFd3wpAXcVLexDpkvPvUYBONdz5sTh0xnmYN
 13XAyExrkIOmk5wCi6+CmZyzzSAsKj1UmKxxJYtWt4j6S67Y+d/i0IQIff/Itxzmf1STTPkrFnJ
 MYyVU/wm3zpgNlNM9rmC+Xfj9KDtXaIn4NlAZnk+PqubLdOoP/pNwrewzvw1NnjbEz0LUETboFV
 SFRIEX6iybHN6gWE/8YI5ZKSrz6+EcHTO+nTpe7+rfihh6e6xeKgHtVg==
X-Received: by 2002:a05:6000:2506:b0:434:24ae:f694 with SMTP id
 ffacd0b85a97d-4342c4ee918mr158160f8f.6.1768336235011; 
 Tue, 13 Jan 2026 12:30:35 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5df8besm44383848f8f.26.2026.01.13.12.30.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 12:30:33 -0800 (PST)
Message-ID: <dd7fbe03-1458-4c44-b8db-a9d5e9ae33f1@linaro.org>
Date: Tue, 13 Jan 2026 21:30:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 13/31] accel/nvmm: Replace @dirty field by generic
 CPUState::vcpu_dirty field
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Ryo ONODERA <ryoon@netbsd.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20250704101433.8813-1-philmd@linaro.org>
 <20250704101433.8813-14-philmd@linaro.org>
 <44ccfba7-21a3-4c24-aa6a-4b2bdb989792@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <44ccfba7-21a3-4c24-aa6a-4b2bdb989792@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 13/1/26 20:32, Thomas Huth wrote:
> On 04/07/2025 12.14, Philippe Mathieu-Daudé wrote:
>> No need for accel-specific @dirty field when we have
>> a generic one in CPUState.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>> Message-Id: <20250703173248.44995-20-philmd@linaro.org>
>> ---
>>   target/i386/nvmm/nvmm-all.c | 21 ++++++++++-----------
>>   1 file changed, 10 insertions(+), 11 deletions(-)
>>
>> diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
>> index f1c6120ccf1..aea61a6fd2a 100644
>> --- a/target/i386/nvmm/nvmm-all.c
>> +++ b/target/i386/nvmm/nvmm-all.c
> ...
>> @@ -982,7 +981,7 @@ nvmm_init_vcpu(CPUState *cpu)
>>           }
>>       }
>> -    qcpu->dirty = true;
>> +    qcpu->vcpu_dirty = true;
>>       cpu->accel = qcpu;
>>       return 0;
> 
> FYI, this does not seem to compile:
> 
> ../src/target/i386/nvmm/nvmm-all.c: In function 'nvmm_init_vcpu':
> ../src/target/i386/nvmm/nvmm-all.c:988:9: error: 'AccelCPUState' has no 
> member named 'vcpu_dirty'
>    988 |     qcpu->vcpu_dirty = true;
>        |         ^~

s/qcpu/cpu/

> 
> Is anybody checking the netbsd builds at all?

3 reviewers and 6 months later.

Should we add a policy for bitrotting untested code?

> (I'm currently trying to update test/vm/netbsd to version 10.1, that's 
> how I noticed it)
> 
>   Thomas
> 


