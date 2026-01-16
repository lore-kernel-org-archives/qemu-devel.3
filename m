Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC64C98305
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 21:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgraU-0001IZ-Nm; Fri, 16 Jan 2026 16:42:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgraS-0001GY-UE
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 16:42:32 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgraR-00047u-8z
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 16:42:32 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-81f4a1a3181so1433845b3a.3
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 13:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768599750; x=1769204550; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=PzR+I0idtOJqBIv9nu7Y+LPM48T7D3txOGJnywP3H9Q=;
 b=M4l/G3hufCVTUjCAzxhDh+VYuskwFz7Mr0NSoXMa6iMGjJFJFdzxBw274zrgQx9TQZ
 i9tQgh+lEm7oGMF677IvU2PDe6JVp4GT4vYw+nzRRwpbPhFZscpAXSyxw8NP/M+krR6x
 ygjQ2z2DPuB4I70EL7JpVDgILbVbS8X4fg5z8MIIdkkz6Z+Jr3Zg1xF6iltERHHn+toL
 WCzUwPfJpJMSZu82ywKWZlXsiqJxlEmnwC0zG3R30lppHyBAP+0C0EzKy0RxCmn8smhg
 Hx3xLbyV5TAUlxVEsERPLFQg+L6omzzU6IKwWKdlS69mphXP/jKzVaIkxb6D0t89BAk/
 AcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768599750; x=1769204550;
 h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PzR+I0idtOJqBIv9nu7Y+LPM48T7D3txOGJnywP3H9Q=;
 b=T6Yzs1a3DnAZVQUUfLtN0dolFM23GDtEP081IuxpEL1QE8D8PfH78ZrnaJm1zCxvhG
 E32sNzJ6oQ2oZAQ6PAT/fOVDCAW/kNmV0jDmYD/gQTurpoeFR7w1X7fU8/TNzYQBOVjt
 5mUsOKuqb21C294LDp0h0TOApMtSPlrqGk2kqle8R6ATYoicyMROUz4mYoS7TmH/ADQC
 aai/3pRuytefb2v1SA3gHo27Sn4VJhHhdNNxcGHIIKwacL/fwHXr5BqA+AVvEZNbS4tT
 8bebnUtTprEk+ibnC1Jx1B7sG+fMNo7f2WFPQcbLCDnz9/MV07FaDMKpSnpJBtXvkLWd
 2+Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQT5bnZeCH+Wwy6Txh+dZcHqbJokHl77Yb1vAVGZXWQFHPGD74ec0vMEAsvgma9GtL7PQ2HgN1021J@nongnu.org
X-Gm-Message-State: AOJu0YzfkIiW5bBTYjPBzlh069RmZgDi9NL4UMXzrOkDPtsrW563LDJy
 IjE+0kKlVVeVup2QTnisRTAv+EU+W8XWM9gC/93VAzKV3CaZpQXhPVezYYMDhlIm+fU=
X-Gm-Gg: AY/fxX75px1FKuF1R9xuMD+A45dEKli27xuoRYJaNDyPr3/tby253KRsRO+4N9itFqv
 qdPQY1t1Qe8V8w/SK5DAuFQkXw1ztigK5h45hFEoUEnSYP1yfEJ/w65W+UsTZW3n2ogcoh3LjT8
 KNoCoiWwvu8NuAIaOJLf3QhmadJUck+LnhttN6eFODFewXQLqBnBMwV1C9jLcXyUSfG2V69v5kC
 wh2ke6WU3yKvIv5Iz5JD6mcVV9Oe7yxWj5Ib9HUYsrqrEY1rBePpNigr+LAyg1xRUNn+OWXQjlb
 MdL7dDk/h2iBOWi0zCBdeBcmCyGSZnIDWzG00Z5SyD40S2RlOzxh5x3Egt5gIgQG2jjQ+dMjyhD
 RhvG2yd9OvsQynXxkIFoBvm3JMEt8wjMJSlZERSDzKN+b98Vd6UFPHNaGMQygZTkkaUhPZ6GG22
 KM0dtQzH+bXqRlBaCZRTotsnVuKTA0lp6vlBUZQzKWBpYZ0I7oY7QYVI65
X-Received: by 2002:a05:6a00:909e:b0:81f:995d:6cb with SMTP id
 d2e1a72fcca58-81fa01ec7f9mr3977096b3a.36.1768599749658; 
 Fri, 16 Jan 2026 13:42:29 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa108c4dbsm2871470b3a.5.2026.01.16.13.42.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 13:42:29 -0800 (PST)
Message-ID: <2ea37e5b-b671-42e4-bd78-127714e0a2e6@linaro.org>
Date: Fri, 16 Jan 2026 13:42:28 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial] plugins: correct docstring for write_register API
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: Florian Hofhammer <florian.hofhammer@epfl.ch>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
References: <60089475-3891-4448-bfe0-8dd698cd2435@epfl.ch>
 <0d32ba74-9171-425d-ac0e-1303d6ca154a@linaro.org>
 <0458a52c-b86b-43e8-84f6-ec75b012a9a2@epfl.ch>
 <3d9c9fbe-711c-4be1-84f6-5fa3cc18d2a8@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <3d9c9fbe-711c-4be1-84f6-5fa3cc18d2a8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 1/16/26 1:39 PM, Pierrick Bouvier wrote:
> On 1/16/26 10:48 AM, Florian Hofhammer wrote:
>> On 16/01/2026 19:24, Pierrick Bouvier wrote:
>>
>>> In practice, it may return anything else than 0 (see arm_cpu_gdb_write_register for instance).
>>> So the right (vague) description should be:
>>> On success returns 0.
>>
>> Hmm, it seems to me as if the code is a bit inconsistent here: the
>> plugin API in plugins/api.c returns -1 if it detects an error directly,
>> and the arm_cpu_gdb_write_register() (but it's similar for other archs,
>> e.g., x86_cpu_gdb_write_register()) returns 0 if the register is unknown
>> and the number of bytes written otherwise (in the arm example: 4 for the
>> general-purpose registers).
>> That means that currently, both -1 and 0 as return value indicate an
>> error.
>>
>> Thanks for the catch, that made me dig into the actual gdbstub code a
>> bit more!
>>
> 
> Indeed, same for me. I've been reading too quick when answering through
> your first email, and missed the nuance.
> 
>> In order to make this consistent, there are two options I see:
>> 1) Change the plugin API function to return 0 on error (but then it's
>> inconsistent with the qemu_plugin_read_register() function which returns
>> -1 on error), or
>> 2) Change the arch-specific gdbstub functions to return -1 on error
>> instead of 0.
>>
>> What do you think? I'd be happy to prepare a patch for either option.>
> 
> For sake of consistency, we should make this use the same interface than
> {read,write}_memory_vaddr, minus the len param.
> bool qemu_plugin_read_memory_vaddr(uint64_t addr,
>                                      GByteArray *data, size_t len);
> bool qemu_plugin_write_memory_vaddr(uint64_t addr,
>                                      GByteArray *data);
> 
> So it would be:
> bool qemu_plugin_read_register(uint64_t addr, GByteArray *data);
> bool qemu_plugin_write_register(uint64_t addr, GByteArray *data);
> 
> This is better and unambiguous, as no one needs a documentation to know
> what a bool return is, and data already holds the size information.
> 
> As well, writing this, I realized that existing write_register is broken
> by design: we never check the size of data array (except > 1) and
> blindly an arbitrary amount of memory from it, which is wrong.
> Even though the doc mentions it, we should just fix it, detect when size
> < reg_size, and return false.
> 
> This comes from the fact gdb_write_register itself has no notion of size
> and trust the pointer. so it would need another refactor also. And while
> at it, change gdb_{read,write}_register definition to return bool also.
>

I reviewed that code by the way, so definitely my fault I let it through.

