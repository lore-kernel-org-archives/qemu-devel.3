Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D45C2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 12:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMoDM-0007lN-GV; Thu, 27 Jun 2024 08:27:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMoDI-0007kl-MG
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:26:57 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMoDG-0003gT-LM
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 08:26:56 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2ec3f875e68so87016681fa.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 05:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719491212; x=1720096012; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oLHP1XkRo0/fL47l0ds5Mlcb6EGB8gd+LBZVQENDmxU=;
 b=L+WW1Zquud09AFpUCAnnfO67pl0gHLmQ6qwzUFH75hDdesUZ609Ij+duaox077gfJx
 owr9VXoa+CNMMwrRpxx9aTlQfHLcAJ3D4dKABu3wz37D7BtJF584tvKu/0IrCPui270I
 LEzr5YR90vTPDwFzzFopqt1/o4VHQv6CB5XoeEbpeR86JGAlu0caevH4vpo/i9o0DP1H
 s+fqY9I7R63NowRX4Ps7RkJ8s/DjQUnzQQUMhnjL4zmjL481FNd7gtxDpY5orqw7xRqg
 J0UuqA41aLZshVVUDwlPTXkh6w9VVert6KcA+cYBQFJrT37lCooHQEvV5W/sHixCHC5h
 M5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719491212; x=1720096012;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oLHP1XkRo0/fL47l0ds5Mlcb6EGB8gd+LBZVQENDmxU=;
 b=H11z7L5kDs+Ux8IcTwXy50DZpTuPdkQcALXFUtVwEonHYcSu6GhFvHV5Ak9XAtMpgD
 aA9hJfxuKimIrc5lMID79Z98BgcU8omxIDUsP/798WGpiWEIFKkekBO/odIudwTiMQvX
 xMAgk8jSkhgVB3EEqE9oQZfqYxm6PlA92ng5N5G8k2JVL4BIm4eqjhb8HQXA6M2D/KZw
 IolqNRbZ5rFwHh4Y04FM+5Qj7iwWmGjvs96Z/KT5NW7vJW6jLdHV0jIH5NTEUEewToB8
 c1rZWyxFeBrj34BZn3XRLBjq0XXUg0tjEhbg+r3SP6ugx3A5jHRTsvdq58MrHJVr6G0l
 FVdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+R8PphgbC0hE0NqsXcPd7RdVKt+VStSoujvdzMhZzg9wt0VFn2OYfXqLl1E5Pk3ryHblU6zGxrbsoCitAmNaQ+h8ORQo=
X-Gm-Message-State: AOJu0YyQvPhAaSsFZG1qqf1kXIY/UCHWNRKIHTvwBrULltlvB3BpSwrg
 D3yQXHHmivttMOCjvZUdN4b+DYHjvU2kuuUES03p3IANP4S68PSC3jEtFIfSQSg=
X-Google-Smtp-Source: AGHT+IEWZPZKpgUpuwdJzBpwNReEa78zdxUTr+wW+q5x88ZEd60ZUrhhOIWjfeg9rAzgsVfJXA5C9w==
X-Received: by 2002:a05:6512:2308:b0:52c:daac:bfba with SMTP id
 2adb3069b0e04-52ce1ece4f3mr10376100e87.67.1719491212143; 
 Thu, 27 Jun 2024 05:26:52 -0700 (PDT)
Received: from [192.168.23.175] ([81.185.165.118])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357ff4fsm1691598f8f.42.2024.06.27.05.26.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jun 2024 05:26:51 -0700 (PDT)
Message-ID: <b7a9150f-3271-456b-a4fd-05d77107155a@linaro.org>
Date: Thu, 27 Jun 2024 14:26:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] gdbstub: Make get cpu and hex conversion functions
 non-internal
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, peter.maydell@linaro.org
References: <20240627041349.356704-1-gustavo.romero@linaro.org>
 <20240627041349.356704-8-gustavo.romero@linaro.org>
 <e0412202-3dd3-465d-8ed9-37ea9af1751b@linaro.org>
 <874j9eprwd.fsf@draig.linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <874j9eprwd.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
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

On 27/6/24 13:05, Alex Bennée wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
>> On 27/6/24 06:13, Gustavo Romero wrote:
>>> Make the gdb_first_attached_cpu and gdb_hextomem non-internal so they
>>> are not confined to use only in gdbstub.c.
>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>    gdbstub/internals.h        | 2 --
>>>    include/exec/gdbstub.h     | 5 +++++
>>>    include/gdbstub/commands.h | 6 ++++++
>>>    3 files changed, 11 insertions(+), 2 deletions(-)
>>
>>
>>> diff --git a/include/exec/gdbstub.h b/include/exec/gdbstub.h
>>> index 1bd2c4ec2a..77e5ec9a5b 100644
>>> --- a/include/exec/gdbstub.h
>>> +++ b/include/exec/gdbstub.h
>>> @@ -135,4 +135,9 @@ void gdb_set_stop_cpu(CPUState *cpu);
>>>    /* in gdbstub-xml.c, generated by scripts/feature_to_c.py */
>>>    extern const GDBFeature gdb_static_features[];
>>>    +/**
>>> + * Return the first attached CPU
>>> + */
>>> +CPUState *gdb_first_attached_cpu(void);
>>
>> Alex, it seems dubious to expose the API like that.
>>
>> IMHO GdbCmdHandler should take a GDBRegisterState argument,
>> then this would become:
>>
>>    CPUState *gdb_first_attached_cpu(GDBRegisterState *s);
> 
> Maybe instead of exposing this we can use user_ctx for something? If we
> look at handle_set_reg/handle_get_reg we can see that passes down
> gdbserver_state.g_cpu down to the eventual helpers. We could define
> something like:
> 
> --8<---------------cut here---------------start------------->8---
> fixups to avoid get_first_cpu()
> 
> 5 files changed, 25 insertions(+), 18 deletions(-)
> gdbstub/internals.h        |  1 +
> include/exec/gdbstub.h     |  5 -----
> include/gdbstub/commands.h |  3 +++
> gdbstub/gdbstub.c          |  7 ++++++-
> target/arm/gdbstub64.c     | 27 +++++++++++++++------------


> @@ -54,6 +54,8 @@ typedef union GdbCmdVariant {
>    * "stop reply" packet. The list of commands that accept such response is
>    * defined at the GDB Remote Serial Protocol documentation. See:
>    * https://sourceware.org/gdb/onlinedocs/gdb/Stop-Reply-Packets.html#Stop-Reply-Packets.
> + *
> + * @need_cpu_context: pass current CPU to command via user_ctx.
>    */
>   typedef struct GdbCmdParseEntry {
>       GdbCmdHandler handler;
> @@ -61,6 +63,7 @@ typedef struct GdbCmdParseEntry {
>       bool cmd_startswith;
>       const char *schema;
>       bool allow_stop_reply;
> +    bool need_cpu_context;
>   } GdbCmdParseEntry;
>   
>   #define get_cmd_parsers(p) (&g_array_index(p, GdbCmdParseEntry, 0))
> modified   gdbstub/gdbstub.c
> @@ -938,6 +938,7 @@ static bool process_string_cmd(const char *data,
>   
>       for (i = 0; i < num_cmds; i++) {
>           const GdbCmdParseEntry *cmd = &cmds[i];
> +        void *user_ctx = NULL;
>           g_assert(cmd->handler && cmd->cmd);
>   
>           if ((cmd->cmd_startswith && !startswith(data, cmd->cmd)) ||
> @@ -952,8 +953,12 @@ static bool process_string_cmd(const char *data,
>               }
>           }
>   
> +        if (cmd->need_cpu_context) {
> +            user_ctx = (void *) gdbserver_state.g_cpu;

LGTM.

> +        }
> +
>           gdbserver_state.allow_stop_reply = cmd->allow_stop_reply;
> -        cmd->handler(params, NULL);
> +        cmd->handler(params, user_ctx);
>           return true;
>       }


