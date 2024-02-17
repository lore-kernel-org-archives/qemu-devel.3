Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36968C48BC4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 20:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbRCz-0002JA-Jz; Sat, 17 Feb 2024 15:22:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbRCw-0002In-3d
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 15:22:46 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbRCu-0005iT-9g
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 15:22:45 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-6e4423b64acso397523a34.2
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 12:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708201363; x=1708806163; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S0Lzpg6UwbR1YMcZ98o/enuk3si1S2tauwtSUqBSUQg=;
 b=V6CnYTLcIC2VHcFmhgEQ/CYfwxRMwRs2YLpOJHuWVq6maqs77H/SUo9GU8wJnNUrui
 haRRcRFWTPNhcCzV9BKxCV5WKP852/RXlXviIgyw9flN81utAGQb4zCc/qMIBExd2q9y
 E0jGXgiWzFTxaNF+ngbxA8or59uH1WgBtbARl3TUcXWmWsOitgb+6+7znb1eFPMyiM8k
 z3tmlFfNorwh+wNudkFikFqOgUObeh3yOgIgasHqk8/iklNaC2ceTrf0pPYZawrJhkx6
 8lYT8bAZReEovuBsyC8AULHJNtagRjcqRfVkUeSGCvm4GS6ktjxfU3XUyw1ml90y21hW
 QtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708201363; x=1708806163;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S0Lzpg6UwbR1YMcZ98o/enuk3si1S2tauwtSUqBSUQg=;
 b=RxESkSj2syWNYWim2KRz2bHqySksq+imIgX2R0DNDq1ysApZfnPKCq5X+AYAZ1X91e
 odrmUi9ntrkwuBuIsOHfJQPauxlnrFsTPxyHZb+34VcNtLPzg1wyDz+DH3kuZVFysiJW
 rl/ficznJHClhSV6kIYtceoYPrqQfvaRp7e/8VSmbJ1cIbeC856xW72vBG1ORcwR9aZc
 f8rhIcGaEqHNT6o3aVzKK8kHRtylEPPmVsKVzoNIIpl5m/wHB5OM9lxLc+tA3l2FtNcu
 TdNz4VGqHfxC09Jpql2YtW8dGbuycofd69r8TKSjQDLs/W1kEtIsaOnrj+6r/Yo5oNSn
 VfPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpxywt3oBVV6s035EikRwvCYb/Em5U68T8TacGAHvv/gL02CSlAICXNPu4jPj2d/zNXP1Ui2IF10t0UvpO+B5Lrde12wY=
X-Gm-Message-State: AOJu0Yxq1Tf4nz4Pfp8yRQMY+nI3+ASnmx7+vhFFCaC9Bj7svHOMErzp
 zMI+HvDyLl3n7ZKReFACo9frVMSm0UUZCe9wBuvMei+lio7SuwmKNWsejf8a4IA=
X-Google-Smtp-Source: AGHT+IFLEPaImehlHsdSoFUxfof7oM2BRgYachvffftOGEhsWIKiAwRXJpTl3UQHttFF9jiqPbQwYw==
X-Received: by 2002:a05:6830:a58:b0:6e2:f0f5:e118 with SMTP id
 g24-20020a0568300a5800b006e2f0f5e118mr8902326otu.16.1708201362952; 
 Sat, 17 Feb 2024 12:22:42 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 fd4-20020a056a002e8400b006e0901b71e4sm2043206pfb.48.2024.02.17.12.22.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 12:22:42 -0800 (PST)
Message-ID: <ccd10805-0f0b-4731-8c91-899b1b55fce5@linaro.org>
Date: Sat, 17 Feb 2024 10:22:40 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/11] {linux,bsd}-user: Update ts_tid after fork()
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
References: <20240216130817.369377-1-iii@linux.ibm.com>
 <20240216130817.369377-3-iii@linux.ibm.com> <87ttm82thj.fsf@draig.linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87ttm82thj.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 2/16/24 07:45, Alex Bennée wrote:
> Ilya Leoshkevich <iii@linux.ibm.com> writes:
> 
>> Currently ts_tid contains the parent tid after fork(), which is not
>> correct. So far it has not affected anything, but the upcoming
>> follow-fork-mode child support relies on the correct value, so fix it.
>>
>> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>> ---
>>   bsd-user/main.c   | 1 +
>>   linux-user/main.c | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/bsd-user/main.c b/bsd-user/main.c
>> index e5efb7b8458..4140edc8311 100644
>> --- a/bsd-user/main.c
>> +++ b/bsd-user/main.c
>> @@ -127,6 +127,7 @@ void fork_end(int child)
>>            * state, so we don't need to end_exclusive() here.
>>            */
>>           qemu_init_cpu_list();
>> +        ((TaskState *)thread_cpu->opaque)->ts_tid = qemu_get_thread_id();
>>           gdbserver_fork(thread_cpu);
>>       } else {
>>           mmap_fork_end(child);
>> diff --git a/linux-user/main.c b/linux-user/main.c
>> index 74b2fbb3938..e6427d72332 100644
>> --- a/linux-user/main.c
>> +++ b/linux-user/main.c
>> @@ -160,6 +160,7 @@ void fork_end(int child)
>>               }
>>           }
>>           qemu_init_cpu_list();
>> +        ((TaskState *)thread_cpu->opaque)->ts_tid = qemu_get_thread_id();
>>           gdbserver_fork(thread_cpu);
>>       } else {
>>           cpu_list_unlock();
> 
> Given how many functions do this cast dance it does make we wonder if we
> should just have a helper for *-user:
> 
>    TaskState * get_task_state(CPUState *cs)
>    {
>          return (TaskState *) cs->opaque;
>    }
> 
> and be done with it. Richard?

Seems like a good idea.


r~

