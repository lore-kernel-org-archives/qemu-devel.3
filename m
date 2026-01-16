Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D22C98302
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 22:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgryt-0007FE-24; Fri, 16 Jan 2026 17:07:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgryn-0007Cz-RA
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 17:07:41 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgryl-0008Oi-MI
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 17:07:41 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2a0d52768ccso16554915ad.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 14:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768601257; x=1769206057; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=CaUnjkzmIlXy4WClBwaasEh59UFEB36zlXETfSa6fBw=;
 b=wb/Z1WWNSCuAjkBLe1mxdbd/AtrAbooG8kn61z4m0oCwihrzF4CDi1qw5GAQn/c4dk
 zVx2sb2IPDVY7kz9dt4H+ePHpX6aKM7ieoy+HcXjc/PZZWrkVSKt4PP2z2oNsPuMTj4w
 X8Lw38ittCm4fyBsi505tudQn5vKhTvIxqk4SPJT6KTNjdqvTOpP7dRj+tbG8YeGq2yT
 ShSN9DD+83cEah07ZLaQjbjUZI92yh0v2v331HVsg0DVPHaBpixw15Y77jaaiv1fMW9G
 +D0g5N+ZHFWnA8U0jOKVDaqNXBjMsvjl7oCrTpub5mMmo1li4P5zc2ZofChCZgTt6p0B
 T5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768601257; x=1769206057;
 h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
 :from:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CaUnjkzmIlXy4WClBwaasEh59UFEB36zlXETfSa6fBw=;
 b=E1wFkp3ySG5/4pLYQ1nHKNaoA8/kl9pAYji2A4Phuq2o8RMj1esQBPoS4Ho4iYg3RG
 UMQ9RbCMoOM/WRGIY4TK22t5EADy2FVXBLE6FjKmFxa/Q0JaM+f3L/ahIW1JCeHeyoNN
 2tosJNHa7P8lrvE0ajA2cANZHC+kprkNKZZqnVdfStCVdWxq6l8bfY2hNAvd2VyZA7Na
 dllYV6+HvWAEtHOGUMdYz90t+VvEhgCedIV+B1ThYOBwt5/ILwz76xF5nOhKtpzioSeR
 QmBCK1qeK9utcfQ2VPLWfwiCTOucdcddCr6eCjAtbgnm7hCPO5O1LUC/6wMN38+fSiI6
 qIIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIIWzmTppPaaO7iQqD8P8WKuK1AyTBU+rmqcWxdFIJs+Lt9ZQBPDWOWTdLfbciNYOmXurwfbWA5jIA@nongnu.org
X-Gm-Message-State: AOJu0YyW5Mc/J1xc2JGqpU+vHKNw4+6DYptzZac6Z8pD6Zaq5K4/jugW
 SppveMB5HJl7CO5wvlpFsmWvbagThtIvKvF3tBMZWhjJAwF8lzGHkFFWPPKEIaZxkAw=
X-Gm-Gg: AY/fxX6j3oHXeaaP3pk45ryxEfzed80ySQKLCyS+EL84SDXRb6RxJKvNQv2oyzcN/OL
 DfmxuaGT1i/r4hAoaimWTjRiBvy/RjQLIr3CJQleD4x6B1j+Ali59pNZTk1gD1CfbnQMmyvP2QH
 9ximURqyBmKujTZx9pRLDTRXqiBUfOOrB/d1L3l8nGwlgE0VReyWeSJ5I5Q+gkISw8c4WLNs30F
 +IMcj+4ZIRxEh6aVGFNxuXh27Gr3isqPosisqQ752xwIE9GAYw9p1TM2YNZxfdG89NZC6JSMVBQ
 GNfOn/TNXecr2G/fWPF9HZTKhMNmxUgGRiOvs0IffzmG6dtdB7SlPqHSjPjZ/VR+noqJmgbN0zX
 rv39JHNu+4EQ8GgjGofzoR1HLeVBIoAFKh3aaq5AzJatHWX7q0LR5uIyfaQHP1XYU00FYjx70nv
 MiqTj0SnHIMzh76Eu65ZufeA5hfho1ceobEKQ8VrxufmKuWbAe6qoKCH62
X-Received: by 2002:a17:902:f60b:b0:29d:9b39:c05f with SMTP id
 d9443c01a7336-2a71751c5dbmr38768475ad.10.1768601256617; 
 Fri, 16 Jan 2026 14:07:36 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a719411cc0sm29234415ad.85.2026.01.16.14.07.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 14:07:36 -0800 (PST)
Message-ID: <24141f5c-85dd-4af2-821a-ff5ad0fe009e@linaro.org>
Date: Fri, 16 Jan 2026 14:07:35 -0800
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

Meant:

bool qemu_plugin_read_register(struct qemu_plugin_register *handle,  	 

                                GByteArray *data);
bool qemu_plugin_write_register(struct qemu_plugin_register *handle,
                                 GByteArray *data);

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
>> Best regards,
>> Florian
> 
> I think it pushes a lot of changes just for a simple comment change, so
> I would understand if you don't want to do this whole refactoring beyond
> plugins interface. I can pick it up, or let you work on it if you have
> time/interest. Feel free to let us know.
> 
> In all cases, thank you for pointing this.
> 
> Regards,
> Pierrick


