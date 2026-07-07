Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BDAC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh9Zw-00060x-8L; Tue, 07 Jul 2026 13:27:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wh9Zs-00060M-7q
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:27:24 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wh9Zq-0004mc-GV
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:27:23 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2cad4170e8eso53849995ad.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 10:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783445240; x=1784050040; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W/Mw86EMifOutr48fRw4pUqE6lub5eryXGF8aL5mZBA=;
 b=f8OHsXxRUaga2nkd4bWBWm3zgjzG9fmQUrAFuqZItwZBR+m0hpgaXBnEIW0PjBOw4A
 fCNFVtj8uJXxwMxNRMnYMbUXwuvtZt4ReUe2yJxaaO/Ko6AmdPmrX/59woDCrHECyQnN
 be3OJKEdU5vkYTVUYfKnDABOh30zlxoehHccaEuPjeZD7XkcE3jL1n9Thqpd3tIwU+mN
 uuyy9ILLSfu1m3s1AJijLJ2Mm0TO4LJ02yic9iNiwUucJEKwXhaQ7sne5rwpdCa8UEAq
 pAzOXQhUSgl67tA0wNjZz6wkY2XPnAkzgsVuPvLpn6SGfUhOjH9z7Up9ipZADQOBT57z
 ApAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783445240; x=1784050040;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W/Mw86EMifOutr48fRw4pUqE6lub5eryXGF8aL5mZBA=;
 b=PVcVmzTeTBpAIAqHautllNjMvHZhRIZgAq3ISM5Ypt1UcmcDuiSD1hLkHZ95Dd62Fi
 0AjeGrj2X+rEvGruWIVLuCM6O9xF1z9oHvYzw1K7G8oB4oB6pYcHNfYJuN6Ej5JiK7vQ
 GkDl+4eJGriRIwZCnAfyBYtHngpXItwwKN3NWSNwIvSKO+2+NsROCU5wI9Tl+FxzZZD0
 mfhGR2a4D0sFckC782BoEUnSrEt2WhQqzRwSOgPxkXaYsQAEJmYRpxN1lG6Ul9fJu1Ki
 IxlhfTzfl8KKz0HH2Jw1lG8ca/0nlFjorVQpWyFKF500sf9VUlVsp7qpYrMgOvFInLd8
 EZHg==
X-Gm-Message-State: AOJu0Yw46dMYfrN7+Y7mEnH/X8qfegdqAO5RABo7AosKaJogdAjbPD8+
 WoO291c9UTUsvxZ1d6K4JBJ2vYZ5128F6r2o3NjzE8zgGSyRvyb2VX+rZb7KWaPZP5w=
X-Gm-Gg: AfdE7cnkTELMhP+nLA4u7GTraNMa6XzsmMp4nMeLz2P5k+DP2dUlTScYx0qZg2r8TE7
 uARIVmz/1ytf+OmAVmO9sIOcoPJIkox7CdZfBaCOX5RYDIgRuAtWaEOJ4GxdeaGySGYq6WmmH/l
 1zLfd93AOdS/sqEwQhmTXYTpe2jgTXQ4rVzLAaTmys5d6vb0DzhF21QQiHLBT/b38U4yZS90voc
 Ypn/ujrGkTBXvo9yyZ5TxEFcz9x++oBP8EFslvPEVlG628lms8yqeQvZjZod//BqtwHbKP/p/BN
 Mj0/0ft2HkFcutTbj2Gm1ptNCocFG8UjKZXwcktcWQif+uFzpBYrdjxzcouBJOtVTu5QPweFG3t
 0sD4jMXOLUz7AcL7Djs/PgJETf//ZVL4WuHipZBQa6NeBOpvvCyCGrEVDD6W70w+CrPoIKDmBcr
 5mj8cFWfH2vr4mwd6YO1nciIMn1VlTO7EqOHukFnfzxWnPoilsq+CjAcPY4fiwiFLMyg==
X-Received: by 2002:a17:902:c405:b0:2ca:c68:caba with SMTP id
 d9443c01a7336-2ccbf051d6bmr57068345ad.34.1783445240144; 
 Tue, 07 Jul 2026 10:27:20 -0700 (PDT)
Received: from [192.168.0.4] (71-212-39-188.tukw.qwest.net. [71.212.39.188])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bf737bsm15480685ad.19.2026.07.07.10.27.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 10:27:19 -0700 (PDT)
Message-ID: <a14481eb-9eed-43c0-a29c-187798f7f769@linaro.org>
Date: Tue, 7 Jul 2026 10:27:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/arm: report M-profile BKPT to gdbstub when
 attached
To: Peter Maydell <peter.maydell@linaro.org>,
 Gilles Grimaud <gilles.grimaud@univ-lille.fr>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260705224407.32464-1-gilles.grimaud@univ-lille.fr>
 <CAFEAcA9Heev=ydTzO2u3EzeF_2q7dytOF8=67qF8ZMMY6Ky2Tw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA9Heev=ydTzO2u3EzeF_2q7dytOF8=67qF8ZMMY6Ky2Tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 7/6/26 02:21, Peter Maydell wrote:
> On Sun, 5 Jul 2026 at 23:44, Gilles Grimaud
> <gilles.grimaud@univ-lille.fr> wrote:
>>
>> While working on Raspberry Pi Pico/RP2040 support, I noticed that Pico SDK
>> programs deliberately execute BKPT from _exit(). On real hardware this is
>> useful when a debug probe is attached: returning from main() stops the
>> debugger at the program exit point.
>>
>> Under QEMU this currently does not behave like the debug-probe case. For
>> M-profile guests, the BKPT instruction is routed through the architectural
>> guest debug exception path. Without halting debug, that path should remain a
>> guest-visible DebugMonitor exception when DebugMonitor is enabled, or escalate
>> towards HardFault otherwise. This patch deliberately leaves that no-debugger
>> architectural path unchanged.
>>
>> The problem addressed here is the case where GDB is connected to QEMU's
>> gdbstub. In that situation, firmware that uses BKPT as a debugger stop point
>> should stop in the attached debugger. Instead, the M-profile guest currently
>> continues down the guest exception path and may end in HardFault/lockup rather
>> than reporting a clean trap to GDB.
>>
>> This is not specific to the RP2040 machine model. It is a generic
>> Cortex-M/gdbstub interaction: firmware that uses BKPT as a debugger stop point
>> should be reported to the attached debugger, while keeping the guest
>> architectural exception path when no debugger is attached.
>>
>> Expose a small gdbstub helper to test whether a CPU is visible to an attached
>> debugger. When an M-profile BKPT instruction is executed with such a debugger
>> attached, leave the translated block with EXCP_DEBUG so the existing gdbstub
>> stop path reports a trap to GDB.
>>
>> Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
>> ---
>>   gdbstub/gdbstub.c      | 13 ++++++++++++-
>>   include/exec/gdbstub.h |  6 ++++++
>>   target/arm/tcg/debug.c |  9 +++++++++
>>   3 files changed, 27 insertions(+), 1 deletion(-)
>>
>> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
>> index c3c944e965..9f259fc005 100644
>> --- a/gdbstub/gdbstub.c
>> +++ b/gdbstub/gdbstub.c
>> @@ -237,6 +237,18 @@ static GDBProcess *gdb_get_cpu_process(CPUState *cpu)
>>       return gdb_get_process(gdb_get_cpu_pid(cpu));
>>   }
>>
>> +bool gdb_cpu_is_attached(CPUState *cpu)
>> +{
>> +    GDBProcess *process;
>> +
>> +    if (!gdbserver_state.init || !cpu) {
>> +        return false;
>> +    }
>> +
>> +    process = gdb_get_cpu_process(cpu);
>> +    return process && process->attached;
>> +}
> 
> No other architecture, CPU or board in QEMU needs to do this,
> so my instinct is to say that M-profile should not be special here.
> Richard, Alex: how do we usually handle breakpoint insns for the
> gdbstub ?

We handle them via CPUBreakpoint structures; we never inject code changes.

The patch description explains the confusion: this is attempting to replicate a feature of 
the Raspberry Pi Pico SDK, wherein a guest BPKT really is trapped by an external debugger.

The only question is whether we want to follow that, and I suspect the answer is no.


r~

