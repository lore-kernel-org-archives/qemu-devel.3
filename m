Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA6AD149C6
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 16:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4NBs-0008PW-Th; Fri, 25 Oct 2024 12:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4NBr-0008P9-Nt
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:29:31 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t4NBq-00083L-2d
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 12:29:31 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71e983487a1so1631514b3a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 09:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729873768; x=1730478568; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iJVNoYpUvTgGEiZb9yvEK/Qib53bBkgmFygdkbPnd8E=;
 b=U8QRnlhkmiQXAb218A30xuk/l7KXNhgs+vRhWtB+zlTgOqeoupC8cd1Wtr7MYRNZkO
 EUM+FAC4w21eg0/FJ72lnWRmE5vr9WM8rIlwR123Abw7UBV5M9z3W6+1CNerDwQJFuFP
 gChpa2oFzhFp5pwIpkd71VFf9coFGy/guVEE0gQU2rIkmwKzqIEgQCkUBrTIkMp1wji7
 hUgsfkb0czFspveYnhqydcVBpkGRQtupliGzbZ7O061cCqWZ0bi+QOct+60lVsWcQks0
 j/TZf0aGWxM6kuuQCUlaok6GFwM4kxP7xOhtn2FAFDlUx5clhSZMqj3eosXX0QNGsaPW
 9QuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729873768; x=1730478568;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iJVNoYpUvTgGEiZb9yvEK/Qib53bBkgmFygdkbPnd8E=;
 b=Uo4Qje3gzyPMjGimqscmBo/HY5cQMHTAO4ruulaUR9xYlRe3JZH2t3c/hLDe1/Jt5z
 2BwsINRPx5J8jHey8EYEXWt03RET9QKDabBxS3xVfIwAsXCXgABrujylzRUvHpI3zwEH
 HRCFZ8qWQdx9gSrjEP3M9Qszbl6wA6y6wRfH6rVU/9ogq4lDfIFel28BY5KuqePAzzad
 tngtf7vdoKhaDjYg7EBy07F+KzOPT5g7iJbcmS+fphE9E7HygsCLxSGpF4gwAnQzXvXr
 wy31E/OR94zDPoV8rWqtMJnvii3B9AkgB0kN0lNGf6H2CgrRdMwHR0YM0yM4opCx06Re
 Ue7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1ktsiCIPPWHlVMNrcm9R9flY6SuETHWmT7TNUvoV80q1KbyQsAlW+87X9zOonQouDKsftm4vWOzW+@nongnu.org
X-Gm-Message-State: AOJu0Yz53ngNxHPwTyVeonOcHBB3ie1LeZcUR7xOtSrpN5ztKhismCh9
 p/TCe8lUcFMCY0VMQI2Kvfr8kZ7WzXbfLNWLEWSACMp6z3JhxA5h2PxoEeeRV58=
X-Google-Smtp-Source: AGHT+IGL7b+Dg3Ojs09a3qDn8bSS/GYoYvta+OkJjkYS84xHjF5qppxXlTW8mUS2uX5wZOAC/h2Kig==
X-Received: by 2002:aa7:870d:0:b0:71e:7604:a76 with SMTP id
 d2e1a72fcca58-72062f865a6mr136785b3a.1.1729873767938; 
 Fri, 25 Oct 2024 09:29:27 -0700 (PDT)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72057921983sm1289785b3a.10.2024.10.25.09.29.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 09:29:27 -0700 (PDT)
Message-ID: <49660209-56c4-44fd-956e-5e556eb51500@linaro.org>
Date: Fri, 25 Oct 2024 09:29:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/i386: fix hang when using slow path for
 ptw_setl
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>
References: <20241023222026.1430014-1-pierrick.bouvier@linaro.org>
 <20241023222026.1430014-2-pierrick.bouvier@linaro.org>
 <66320518-0270-4426-8daf-9be3ae7bfce7@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <66320518-0270-4426-8daf-9be3ae7bfce7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 10/24/24 09:25, Richard Henderson wrote:
> On 10/23/24 23:20, Pierrick Bouvier wrote:
>> When instrumenting memory accesses for plugin, we force memory accesses
>> to use the slow path for mmu. [1]
>> This create a situation where we end up calling ptw_setl_slow.
>>
>> Since this function gets called during a cpu_exec, start_exclusive then
>> hangs. This exclusive section was introduced initially for security
>> reasons [2].
>>
>> I suspect this code path was never triggered, because ptw_setl_slow
>> would always be called transitively from cpu_exec, resulting in a hang.
>>
>> [1] https://gitlab.com/qemu-project/qemu/-/commit/6d03226b42247b68ab2f0b3663e0f624335a4055
>> [2] https://gitlab.com/qemu-project/qemu/-/issues/279
>>
>> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2566
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Oh, wow.  I believe this will be fixed by
> 
> https://lore.kernel.org/qemu-devel/20241023033432.1353830-19-richard.henderson@linaro.org/
> 
> which is in a pending PR.
> 

I confirm this fix the issue and it's now merged upstream.

> 
> r~
> 
> 
>> ---
>>    target/i386/tcg/sysemu/excp_helper.c | 4 ++++
>>    1 file changed, 4 insertions(+)
>>
>> diff --git a/target/i386/tcg/sysemu/excp_helper.c b/target/i386/tcg/sysemu/excp_helper.c
>> index 8fb05b1f531..f30102b5362 100644
>> --- a/target/i386/tcg/sysemu/excp_helper.c
>> +++ b/target/i386/tcg/sysemu/excp_helper.c
>> @@ -108,6 +108,9 @@ static bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new)
>>    {
>>        uint32_t cmp;
>>    
>> +    /* We are in cpu_exec, and start_exclusive can't be called directly.*/
>> +    g_assert(current_cpu && current_cpu->running);
>> +    cpu_exec_end(current_cpu);
>>        /* Does x86 really perform a rmw cycle on mmio for ptw? */
>>        start_exclusive();
>>        cmp = cpu_ldl_mmuidx_ra(in->env, in->gaddr, in->ptw_idx, 0);
>> @@ -115,6 +118,7 @@ static bool ptw_setl_slow(const PTETranslate *in, uint32_t old, uint32_t new)
>>            cpu_stl_mmuidx_ra(in->env, in->gaddr, new, in->ptw_idx, 0);
>>        }
>>        end_exclusive();
>> +    cpu_exec_start(current_cpu);
>>        return cmp == old;
>>    }
>>    
> 

