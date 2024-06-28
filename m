Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F365CC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 05:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN3uc-0001uP-1I; Fri, 28 Jun 2024 01:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sN3uW-0001sX-N4
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 01:12:38 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1sN3uU-0003Ej-Fq
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 01:12:36 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70679845d69so163381b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 22:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719551552; x=1720156352; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ylS7SdNjSxg8lJW/S3brZmG4AcaxdOTthF5UsXXEWlY=;
 b=aVe0VJdFCPUMjhXhKftGgEkzccLQ2cqNB5UipVbyitm8njQeIK+GFlVfl4YqnbwnC7
 kibPOHcnZ+2/vjjU1vODmWuDSmHmDQiVNIpHlVAyQfTe7kObEr358WyCyRek7Ow+rSCz
 a1Egvolo46aM9Fpr6bHfgys/+2dklOVnJFQCtbXIoC0CwPJBffBcScVqrraH+4wbZuCD
 neSQzHq3YfQ4C/mSjsXXkLM9KQ5GzjkSRmkFzl61JtYDKLhBmf3fBNUXnq4dJzI5qy2p
 U1CcFnuwJN8RmWXDd3xAIiXLOJO/VqndLv4sab0i0mjQisx1GRsXkR8KNd0ULdblvDoN
 UiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719551552; x=1720156352;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:from:references:cc:to:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ylS7SdNjSxg8lJW/S3brZmG4AcaxdOTthF5UsXXEWlY=;
 b=u42aI+irN8e0B42RB0c1tPDLQT/GYPEPgeXp1q+hx14ZdZPKRYNLbh2te9EVbqZMF6
 6vmq/KLGmTVNg/WcDY4jmAvqmaLQ1IgNwPngGCeNwTrY1MmN4Bp7x+jFKjCMqg+sH5zG
 McFvRsbtle2JMYxUA32QuKJJJmqM2lfBmlRqTECcNKQjqt0Hb/jrAHGuHpBObDTDwLCZ
 6hMgyrvfKVH9CPyz8OK7c5yBUW5YkINmmjWpZTZddh7MuG3vAMPMSd5EK/Wi9JFU0BrU
 gVf2SuG/VURopZZ+fM1qs9QQI9ZZsoSIXadn+pIXYivaLQRTPec8YAl/sqvsd/qHTvhv
 s0eg==
X-Gm-Message-State: AOJu0YzkhGA2xp5n/RobismF/+oZGAx6CXdK4B46XeYPBTCG8Di/zQcf
 xsh3i6AjA4mbC08XsoJO7XncoNj5gQjGFC+/EwZc+7ibwP3qYUngsef6pTtP+m8=
X-Google-Smtp-Source: AGHT+IFNXP+4h/tDC321OxZM+cQT0hvFuOCZE6ldH5Pk1qAKjkEaAgjZgbBLN1towtFuNQ+nrZ7W6A==
X-Received: by 2002:aa7:82c2:0:b0:706:6f39:1d63 with SMTP id
 d2e1a72fcca58-70674690fb3mr13375151b3a.22.1719551551577; 
 Thu, 27 Jun 2024 22:12:31 -0700 (PDT)
Received: from [192.168.0.102] ([191.205.218.108])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7080246c8ffsm639516b3a.62.2024.06.27.22.12.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 22:12:30 -0700 (PDT)
Subject: Re: [PATCH v5 7/9] gdbstub: Make get cpu and hex conversion functions
 non-internal
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
References: <20240627041349.356704-1-gustavo.romero@linaro.org>
 <20240627041349.356704-8-gustavo.romero@linaro.org>
 <e0412202-3dd3-465d-8ed9-37ea9af1751b@linaro.org>
 <874j9eprwd.fsf@draig.linaro.org>
 <b7a9150f-3271-456b-a4fd-05d77107155a@linaro.org>
From: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <e1fe0eff-4843-db5e-b699-c153d852cabd@linaro.org>
Date: Fri, 28 Jun 2024 02:12:27 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <b7a9150f-3271-456b-a4fd-05d77107155a@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.174,
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

Hi Phil, Alex,

On 6/27/24 9:26 AM, Philippe Mathieu-Daudé wrote:
> On 27/6/24 13:05, Alex Bennée wrote:
>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>
>>> On 27/6/24 06:13, Gustavo Romero wrote:
>>>> Make the gdb_first_attached_cpu and gdb_hextomem non-internal so they
>>>> are not confined to use only in gdbstub.c.
>>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>>> ---
>>>>    gdbstub/internals.h        | 2 --
>>>>    include/exec/gdbstub.h     | 5 +++++
>>>>    include/gdbstub/commands.h | 6 ++++++
>>>>    3 files changed, 11 insertions(+), 2 deletions(-)
>>>
>>>
>>>> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
>>>> index 1bd2c4ec2a..77e5ec9a5b 100644
>>>> --- a/include/exec/gdbstub.h
>>>> +++ b/include/exec/gdbstub.h
>>>> @@ -135,4 +135,9 @@ void gdb_set_stop_cpu(CPUState *cpu);
>>>>    /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
>>>>    extern const GDBFeature gdb_static_features[];
>>>>    +/**
>>>> + * Return the first attached CPU
>>>> + */
>>>> +CPUState *gdb_first_attached_cpu(void);
>>>
>>> Alex, it seems dubious to expose the API like that.
>>>
>>> IMHO GdbCmdHandler should take a GDBRegisterState argument,
>>> then this would become:
>>>
>>>    CPUState *gdb_first_attached_cpu(GDBRegisterState *s);
>>
>> Maybe instead of exposing this we can use user_ctx for something? If we
>> look at handle_set_reg/handle_get_reg we can see that passes down
>> gdbserver_state.g_cpu down to the eventual helpers. We could define
>> something like:
>>
>> --8<---------------cut here---------------start------------->8---
>> fixups to avoid get_first_cpu()
>>
>> 5 files changed, 25 insertions(+), 18 deletions(-)
>> gdbstub/internals.h        |  1 +
>> include/exec/gdbstub.h     |  5 -----
>> include/gdbstub/commands.h |  3 +++
>> gdbstub/gdbstub.c          |  7 ++++++-
>> target/arm/gdbstub64.c     | 27 +++++++++++++++------------
> 
> 
>> @@ -54,6 +54,8 @@ typedef union GdbCmdVariant {
>>    * "stop reply" packet. The list of commands that accept such response is
>>    * defined at the GDB Remote Serial Protocol documentation. See:
>>    * https://sourceware.org/gdb/onlinedocs/gdb/Stop-Reply-Packets.html#Stop-Reply-Packets.
>> + *
>> + * @need_cpu_context: pass current CPU to command via user_ctx.
>>    */
>>   typedef struct GdbCmdParseEntry {
>>       GdbCmdHandler handler;
>> @@ -61,6 +63,7 @@ typedef struct GdbCmdParseEntry {
>>       bool cmd_startswith;
>>       const char *schema;
>>       bool allow_stop_reply;
>> +    bool need_cpu_context;
>>   } GdbCmdParseEntry;
>>   #define get_cmd_parsers(p) (&g_array_index(p, GdbCmdParseEntry, 0))
>> modified   gdbstub/gdbstub.c
>> @@ -938,6 +938,7 @@ static bool process_string_cmd(const char *data,
>>       for (i = 0; i < num_cmds; i++) {
>>           const GdbCmdParseEntry *cmd = &cmds[i];
>> +        void *user_ctx = NULL;
>>           g_assert(cmd->handler && cmd->cmd);
>>           if ((cmd->cmd_startswith && !startswith(data, cmd->cmd)) ||
>> @@ -952,8 +953,12 @@ static bool process_string_cmd(const char *data,
>>               }
>>           }
>> +        if (cmd->need_cpu_context) {
>> +            user_ctx = (void *) gdbserver_state.g_cpu;
> 
> LGTM.

Thanks for the suggestion. I added it to v6.


Cheers,
Gustavo

