Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 212E1CFB420
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 18:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx98h-0005D0-Gz; Sat, 05 Oct 2024 14:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx98f-0005Cf-EQ
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 14:04:21 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sx98d-0000OU-NT
 for qemu-devel@nongnu.org; Sat, 05 Oct 2024 14:04:21 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20b90ab6c19so34670045ad.0
 for <qemu-devel@nongnu.org>; Sat, 05 Oct 2024 11:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728151458; x=1728756258; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=f3j5c+Q77KPbfQZaSmFen4DmaiQkLvEorP6rTLAdviU=;
 b=xTFMoCtAVJmJ03o8Q06pbRFelV/7wOt8OhFBs+N305kl27FrWCb4JCMFccphY/CuG/
 pWq2Q6hoIbFtkVVUDo5d3xWCILMegc6k9EhvNIFMuVgICmOc9RmDMv41m2J224R4iTl5
 LtckRFHPG5AxOVOEaGWvmwkaNNOxEC3jJRsjWaQd0HI/icSS/Dd8azvGLQOJPUuqlZ8Q
 LQVh21jlRp6lIqf9aUAlSrL+D/uIgm55PqQpdkj7Y51rKmd7CJxcMrRKHc1Vm1DVX/9v
 slAsMPy1RE5fvgBa+em018Cf64VSCKnFUxMgeY7NaBQp3jJ6h4tJh5Zqz9Pdt1oR3Psq
 WY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728151458; x=1728756258;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f3j5c+Q77KPbfQZaSmFen4DmaiQkLvEorP6rTLAdviU=;
 b=X1EWSZg9aWzxAWdmOvQkxY7YiIDeFfS66CYRWby7mcm0YH2/QCuVW7zFEYaOV+/UE1
 O5vB3fNUQIGF+s4RthxavZel49YWj0SBxr6wrc7J1+c4pu+MlZ+IHXMgm9VkdnPlPc9j
 Jhg3wyh6pNJHIw8tIFBdvNUmekr0VNw97cpR3RgSx4N33ZkpkjyQFVoAPVsVdk/6FSqA
 rB82T7eIhxzx/aOXvykvh1F8dh8Hi4iq4pNW7PYiiuArhcauiDsdFzb2JzpeIRvnQCI+
 fCOqKocsk+efmZXUQxebtKnwJ6+blZU+SO/iU3E0yFQd1VcIKj1/OzZ2E4SCWz9Xy+8W
 iLIA==
X-Gm-Message-State: AOJu0YwRaITh6lCHDOOa897H1/xE3C+uScLrWsFjqUM4qJEMjPv0Gq3D
 iIveZb3eG1JSHrk/J3OdBty6InzEc3ggicjBcQzcMmE3AFMEceT3p5om/uPhw9g=
X-Google-Smtp-Source: AGHT+IEurlUHoky71AD99H3UJFGrg5951Vuaih/RHa9+hQDkVMMFWEHgaCi2BOaU9ucOa875P68EqQ==
X-Received: by 2002:a17:902:f602:b0:20b:b40b:345a with SMTP id
 d9443c01a7336-20bfee37052mr101011785ad.52.1728151458054; 
 Sat, 05 Oct 2024 11:04:18 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c139a4b50sm15657475ad.306.2024.10.05.11.04.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 05 Oct 2024 11:04:17 -0700 (PDT)
Message-ID: <a6fc3a32-570c-4cc4-90ec-a146fe34bf10@linaro.org>
Date: Sat, 5 Oct 2024 11:04:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Trace wait4()'s and waitpid()'s wstatus
From: Richard Henderson <richard.henderson@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org
References: <20241001193244.14939-1-iii@linux.ibm.com>
 <cb4ccc1a-cb6c-4c1c-bc46-2ec81543e6da@linaro.org>
Content-Language: en-US
In-Reply-To: <cb4ccc1a-cb6c-4c1c-bc46-2ec81543e6da@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 10/5/24 10:57, Richard Henderson wrote:
> On 10/1/24 12:32, Ilya Leoshkevich wrote:
>> Borrow the code for formatting the most frequent WIFEXITED() and
>> WIFSIGNALED() special cases from from the strace's printstatus().
>>
>> Output examples:
>>
>>      474729 wait4(-1,0x7f00767ff0a0,0,(nil)) = 474733 (wstatus={WIFEXITED(s) && 
>> WEXITSTATUS(s) == 1})
>>      475833 wait4(-1,0x7f7de61ff0a0,0,(nil)) = 475837 (wstatus={WIFSIGNALED(s) && 
>> WTERMSIG(s) == SIGKILL})
>>      1168 waitpid(1171,0x7f44eea00340,0) = 1171 (wstatus={WIFSIGNALED(s) && WTERMSIG(s) 
>> == SIGKILL})
>>
>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> ---
>>   linux-user/strace.c    | 61 ++++++++++++++++++++++++++++++++++++++++++
>>   linux-user/strace.list |  6 +++--
>>   2 files changed, 65 insertions(+), 2 deletions(-)
>>
>> diff --git a/linux-user/strace.c b/linux-user/strace.c
>> index b4d1098170e..d5d1f18304d 100644
>> --- a/linux-user/strace.c
>> +++ b/linux-user/strace.c
>> @@ -4168,6 +4168,67 @@ print_ioctl(CPUArchState *cpu_env, const struct syscallname *name,
>>   }
>>   #endif
>> +#if defined(TARGET_NR_wait4) || defined(TARGET_NR_waitpid)
>> +static void print_wstatus(int wstatus)
>> +{
>> +    if (WIFSIGNALED(wstatus)) {
>> +        qemu_log("{WIFSIGNALED(s) && WTERMSIG(s) == ");
>> +        print_signal(WTERMSIG(wstatus), 1);
>> +        if (WCOREDUMP(wstatus)) {
>> +            qemu_log(" && WCOREDUMP(s)");
>> +        }
>> +        qemu_log("}");
>> +    } else if (WIFEXITED(wstatus)) {
>> +        qemu_log("{WIFEXITED(s) && WEXITSTATUS(s) == %d}",
>> +                 WEXITSTATUS(wstatus));
>> +    } else {
>> +        print_number(wstatus, 1);
>> +    }
>> +}
>> +
>> +static void print_ret_wstatus(abi_long ret, abi_long wstatus_addr)
>> +{
>> +    if (!print_syscall_err(ret)) {
>> +        qemu_log(TARGET_ABI_FMT_ld " (wstatus=", ret);
>> +        if (wstatus_addr == 0) {
>> +            qemu_log("NULL");
> 
> I think you could merge the == 0 check into the outer IF, and avoid printing the returned 
> wstatus entirely.
> 
> Otherwise
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Adjusted and queued.

r~

