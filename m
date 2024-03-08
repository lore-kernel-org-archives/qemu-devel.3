Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA17C54E41
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 20:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riglK-0005M5-B7; Fri, 08 Mar 2024 15:24:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1riglJ-0005Lw-39
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 15:24:13 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1riglH-0003Bi-5m
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 15:24:12 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dc0d11d1b7so21144165ad.2
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 12:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709929449; x=1710534249; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GoqmMpXPNri85j4sP3kEs506DCVeyrkzk6Zv5Mlibpc=;
 b=G31c3XnfEGs7VisacZ/fY1VqZpmiiLwFw6fGDvEdp+h10QK0mUXARUaQ9UgqBIyJY+
 LhPWY1y06OFo0cqwzZ0V6sRMtYMfOGn9PefZJJhW3e16uBrnR8KAyyLrZoLr+HWAidb6
 MRF6J1obkn+UawtcUKDjzlOnSv+bMjUsfm/zuZe0UVwBW7xL9jqMqePTF3QzWbmMawHq
 VSXSCnDASFI/X35+cj2scmnFgW/t0MLD5RkjxvF9m/hsvl2zhEtaMxwvmM/tH5tyXOjS
 eya9JAOkUp2mmibZ8Ig8mvtcI8I4Qquk+3bx4iGZWv3NlN7+xq+max4P5wossm6Qn+Gz
 8o+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709929449; x=1710534249;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GoqmMpXPNri85j4sP3kEs506DCVeyrkzk6Zv5Mlibpc=;
 b=tkoMjCXVQZ/AbFCRrst65HrFNNert0747bdxM9pmWjU8FszU9v2pCelGoiu1ew2Ar0
 8Uh5SE7VOVc1F/bVS+t7NzF8TpY6XHlftNQQdtqfSRUifTD9OijePDiQ5bbk8VTdtXjb
 1mSvRiD0MlBX1Bjmd3VVep8MNeFFThWorajZo8KfhBRE2Hozo1DExW+z0V1D3JHy6zQR
 J/LnoiMEX5a9ssof5sQrSpxopdfhfHfuqmGQNTOAfI1p+adWJvzM7TENmFzjYntrVk7f
 /K6pgIgVQJ1h07llzp0BHNhRPntO2qEJcL0Fm4ze1MvbnAnz+wpIG1ZDdl/Z8G1VeiOa
 q69w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXygMEMSPjbo+wDPN7aEbzFEhUeUozifTPJx41o4F3DKpa5krdRk66qhAfK7Dq1hUmxuK48+nVLw3pXX8wZAfCVIVPW3Fs=
X-Gm-Message-State: AOJu0Yy+uSOfiA/BDWHYnROtQyhO+/CSO6TgMRtncQQ7CkVRUZcBwnEj
 28Syyfz9KsPesE/A/3K5kS4I7mi/DYHWwRiLizSJd7tT0lD/VSgzwj0qMJuxUbcbx9BPkyBhm/e
 R
X-Google-Smtp-Source: AGHT+IGchH34H+q5+GPPhw5ZCoe4Qd7zAtnPg6tG5kSwxl1J5+gByx8eKTaPMDgoVRGcedsquOJc+A==
X-Received: by 2002:a17:902:ba83:b0:1db:5c84:9523 with SMTP id
 k3-20020a170902ba8300b001db5c849523mr114129pls.67.1709929449467; 
 Fri, 08 Mar 2024 12:24:09 -0800 (PST)
Received: from ?IPv6:2804:7f0:b401:7e8e:216c:3f1a:12a4:d415?
 ([2804:7f0:b401:7e8e:216c:3f1a:12a4:d415])
 by smtp.gmail.com with ESMTPSA id
 m7-20020a170902db0700b001dd54c4320esm45070plx.256.2024.03.08.12.24.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 12:24:09 -0800 (PST)
Subject: Re: [PATCH v2 3/5] gdbstub: Save target's siginfo
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, laurent@vivier.eu,
 philmd@linaro.org
References: <20240307182623.1450717-1-gustavo.romero@linaro.org>
 <20240307182623.1450717-3-gustavo.romero@linaro.org>
 <637e4407-4519-4d87-981a-acd9b5124970@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <0c484185-4d71-f35f-7eec-da4af962d979@linaro.org>
Date: Fri, 8 Mar 2024 17:24:05 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <637e4407-4519-4d87-981a-acd9b5124970@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.994,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Richard,

On 3/7/24 6:09 PM, Richard Henderson wrote:
> On 3/7/24 08:26, Gustavo Romero wrote:
>> Save target's siginfo into gdbserver_state so it can be used later, for
>> example, in any stub that requires the target's si_signo and si_code.
>>
>> This change affects only linux-user mode.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   gdbstub/internals.h    |  3 +++
>>   gdbstub/user-target.c  |  3 ++-
>>   gdbstub/user.c         | 14 ++++++++++----
>>   include/gdbstub/user.h |  6 +++++-
>>   linux-user/main.c      |  2 +-
>>   linux-user/signal.c    |  5 ++++-
>>   6 files changed, 25 insertions(+), 8 deletions(-)
>>
>> diff --git a/gdbstub/internals.h b/gdbstub/internals.h
>> index 56b7c13b75..a7cc69dab3 100644
>> --- a/gdbstub/internals.h
>> +++ b/gdbstub/internals.h
>> @@ -58,6 +58,9 @@ typedef struct GDBState {
>>       int line_csum; /* checksum at the end of the packet */
>>       GByteArray *last_packet;
>>       int signal;
>> +#ifdef CONFIG_USER_ONLY
>> +    uint8_t siginfo[MAX_SIGINFO_LENGTH];
>> +#endif
> 
> If we this in GDBUserState in user.c -- no need for ifdefs then.

Thanks, I've moved it to user.c.


>> --- a/gdbstub/user-target.c
>> +++ b/gdbstub/user-target.c
>> @@ -10,11 +10,12 @@
>>   #include "qemu/osdep.h"
>>   #include "exec/gdbstub.h"
>>   #include "qemu.h"
>> -#include "internals.h"
>>   #ifdef CONFIG_LINUX
>>   #include "linux-user/loader.h"
>>   #include "linux-user/qemu.h"
>> +#include "gdbstub/user.h"
>>   #endif
>> +#include "internals.h"
>>   /*
>>    * Map target signal numbers to GDB protocol signal numbers and vice
> 
> Why are any changes required here?
> Perhaps this is improper patch split from one of the others?

This was intentional. Because I declared siginfo[MAX_SIGINFO_LENGTH] in
GDBState struct, which is in internals.h and MAX_SIGINFO_LENGTH is defined
in gdbstub/user.h I had to move internals.h after user.h was included so
MAX_SIGINFO_LENGTH could be found.

I'm reverting it.


>> @@ -140,6 +141,11 @@ int gdb_handlesig(CPUState *cpu, int sig, const char *reason)
>>           return sig;
>>       }
>> +    if (siginfo) {
>> +        /* Save target-specific siginfo. */
>> +        memcpy(gdbserver_state.siginfo, siginfo, siginfo_len);
>> +    }
> 
> A comment here about asserting the size at compile-time elsewhere would be welcome for future code browsers.

Done.


> Need to record siginfo_len for later use -- you don't want to expose all 128 bytes if the actual structure is smaller.

In the stub, the full size is only used to check if the requested offset+len is valid.
So the only size that matters for reading data from siginfo and assembling
the reply is the length in the query, not siginfo_len. But I agree it's better, even
more now that I moved the stub from user-target.c to user.c.


>> @@ -510,7 +516,7 @@ void gdb_breakpoint_remove_all(CPUState *cs)
>>   void gdb_syscall_handling(const char *syscall_packet)
>>   {
>>       gdb_put_packet(syscall_packet);
>> -    gdb_handlesig(gdbserver_state.c_cpu, 0, NULL);
>> +    gdb_handlesig(gdbserver_state.c_cpu, 0, NULL, NULL, 0);
>>   }
>>   static bool should_catch_syscall(int num)
>> @@ -528,7 +534,7 @@ void gdb_syscall_entry(CPUState *cs, int num)
>>   {
>>       if (should_catch_syscall(num)) {
>>           g_autofree char *reason = g_strdup_printf("syscall_entry:%x;", num);
>> -        gdb_handlesig(cs, gdb_target_sigtrap(), reason);
>> +        gdb_handlesig(cs, gdb_target_sigtrap(), reason, NULL, 0);
>>       }
>>   }
>> @@ -536,7 +542,7 @@ void gdb_syscall_return(CPUState *cs, int num)
>>   {
>>       if (should_catch_syscall(num)) {
>>           g_autofree char *reason = g_strdup_printf("syscall_return:%x;", num);
>> -        gdb_handlesig(cs, gdb_target_sigtrap(), reason);
>> +        gdb_handlesig(cs, gdb_target_sigtrap(), reason, NULL, 0);
>>       }
> 
> All of this makes me wonder if we should provide a different interface for syscalls, even if it uses the same code paths internally.

Should I address it in this series? I'm sure how that interface would be.


> Do we want to zero the gdbserver siginfo to indicate that the contents are no longer valid?  I know it's not a real signal delivered to the process, but might we need to construct a simple siginfo struct to match the sigtrap?

In gdb_handlesig we always copy the full size of siginfo to gdbserver_user_state siginfo,
which is passed in siginfo_len and now recorded gdbserver siginfo_len too for later use.
Isn't that copy guaranteeing that gdbserver siginfo has always no stale data?


Cheers,
Gustavo

