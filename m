Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BDA7F4BB83
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 20:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuylv-0000oN-Px; Tue, 24 Feb 2026 15:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuylu-0000ms-4Z
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 15:12:42 -0500
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuyls-00073J-9O
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 15:12:41 -0500
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-824adc96ad2so5917693b3a.3
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 12:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771963959; x=1772568759; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=R+C72cH1o5PNDpIFHgUykoGWgyf528nZA4p7vbGsXBk=;
 b=R3QAVaE2Wf/+a5q2Z+oMOqnUqVOJCbjzrtC9y/SyYb9OLErXEPXcPdhJ8OlFJ3nu+A
 URN7M/lmarb3OBHcqhBXNBQsrI2VaFheucQwjL7GoDenSyqMKGVKYO/Mo2BBU7x1/MUn
 aJEG1bM9nct851hYYJZ/FgoUXe5HwlwfK6Bgi7PGk56xJhru6P/FscckZuOsljCrMPU/
 XMg20FBLnlZqFtN/PJCNVCn5OEP1ojxp4BSMeI25CRqU9N8O8s1rovnqbiM1EqMbe9hz
 8Ct364McHNwMqMYn0+19FSB5x0089Ju/y2tqsmVQHsKPJrZuB3g5GI39zubmKdU5aNTL
 FS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771963959; x=1772568759;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R+C72cH1o5PNDpIFHgUykoGWgyf528nZA4p7vbGsXBk=;
 b=dv7UTmdWx4jBLt/8TNCL9+WNS1iZBNAMoFWKx16esvsO+jk8s//BfpS2lQIHB4lsED
 FYRBgIyfoJqLp03qQt7nDY/PnJmT2h4QzaARZUR5dhAGYP9rNZ6OsZbiTJPDo8UbSM9J
 yYM33x10SGjtPvnQUq2+w91LNH1kiYvgJRgBuylnVVaJgOlV3x3VmmBZ2B6d+aZLHgsl
 g9ugHQRRfED+dkhFa94vyZ5DZQfSOt+iDVIrzUlK4L6vYoffgQJKkYxyAB/I5QLFnLkE
 RNVnskg45aaIoKkVq5iPLba0R1VIMF+TC0jAfQh+DUwouF81XvKo2QF+CfPbPsgagl8+
 LUKQ==
X-Gm-Message-State: AOJu0YwgsjEOEQqlOZlIb93mo9Bur234DAh+mu7Jg1cJV234BRuZE3e/
 RUi+EL5baWx1s/G5gmE6QDLFE/wnH7ovdWnVMs6yQ1U7jX6AxK95zaLWIO5rKOrCBSE=
X-Gm-Gg: AZuq6aJjnLw6OmC8plaEJcOML5ZafmuI9mkIl+c+jjtW6NtJtPEQEgWUW650eCP9ZHH
 N9c8umd1OJImpRQl8nTFBfsOhOdANtr6xcXKZ72tpAMneRr3xAn9nqdFeWEAvYc6wVpwOm61FEr
 Q0vD4JxMZJPTdt8vIaPa6wdgZ9Jf9LPhtmA+sdVTE3Df2UhwCsZ/fWVYMlhEqw/iIiPJzZxB1uY
 kJsbAG0JV8FkEdirh0dVrls2+ttsBM7NFU3/kSPUO19h96KQ+uJPTwK+1QK7HaCLqg9ZHn8U086
 PY366Y/8RdemQkoX5ruz+LC6FitGG9xDjQA9mTsDPJNCDPyKoP8A7BluDsxPVFi01JIWiHEs6iF
 slZO3lLI5uPq39ho+ohCbpavcwj/oFx9YrQ+lCBcsnXM+LYC7tbjuBCeKohr5CEuQzJAfEu+dv2
 68Sfz4VhW2mfN7fnTLl5Roa7k66+eGHbzoiQouZZ4JrE438DOMCpq78T/iDDPgtWXHCESED0iOm
 arCysA=
X-Received: by 2002:a05:6a21:4d17:b0:366:14ac:e1ef with SMTP id
 adf61e73a8af0-39545ffbffemr11031343637.65.1771963957326; 
 Tue, 24 Feb 2026 12:12:37 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c70b7269771sm11093878a12.30.2026.02.24.12.12.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 12:12:36 -0800 (PST)
Message-ID: <8cd3610f-c6c2-4b8e-85cc-ad4711deab9b@linaro.org>
Date: Tue, 24 Feb 2026 12:12:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] plugins: add PC diversion API function
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, laurent@vivier.eu,
 imp@bsdimp.com, berrange@redhat.com
References: <909b0a4f-9759-4e27-bba8-997ae2f41bd6@epfl.ch>
 <33eb2408-b4c3-4ca4-9555-b2015fa38630@epfl.ch>
 <87wm022fxi.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <87wm022fxi.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
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

On 2/24/26 9:46 AM, Alex Bennée wrote:
> Florian Hofhammer <florian.hofhammer@epfl.ch> writes:
> 
>> This patch adds a plugin API function that allows diverting the program
>> counter during execution. A potential use case for this functionality is
>> to skip over parts of the code, e.g., by hooking into a specific
>> instruction and setting the PC to the next instruction in the callback.
>>
>> Link: https://lists.nongnu.org/archive/html/qemu-devel/2025-08/msg00656.html
>> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
>> ---
>>   include/plugins/qemu-plugin.h | 13 +++++++++++++
>>   plugins/api.c                 | 13 +++++++++++++
>>   2 files changed, 26 insertions(+)
>>
>> diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
>> index a6ec8e275d..04c884e82b 100644
>> --- a/include/plugins/qemu-plugin.h
>> +++ b/include/plugins/qemu-plugin.h
>> @@ -76,6 +76,7 @@ typedef uint64_t qemu_plugin_id_t;
>>    *
>>    * version 6:
>>    * - changed return value of qemu_plugin_{read,write}_register from int to bool
>> + * - added qemu_plugin_set_pc
>>    */
>>   
>>   extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
>> @@ -1042,6 +1043,18 @@ QEMU_PLUGIN_API
>>   bool qemu_plugin_write_register(struct qemu_plugin_register *handle,
>>                                   GByteArray *buf);
>>   
>> +/**
>> + * qemu_plugin_set_pc() - set the program counter for the current vCPU
>> + *
>> + * @vaddr: the new virtual (guest) address for the program counter
>> + *
>> + * This function sets the program counter for the current vCPU to @vaddr and
>> + * resumes execution at that address. This function only returns in case of
>> + * errors.
>> + */
>> +QEMU_PLUGIN_API
>> +void qemu_plugin_set_pc(uint64_t vaddr);
>> +
>>   /**
>>    * qemu_plugin_read_memory_vaddr() - read from memory using a virtual address
>>    *
>> diff --git a/plugins/api.c b/plugins/api.c
>> index e754b7c69c..ca3e93a194 100644
>> --- a/plugins/api.c
>> +++ b/plugins/api.c
>> @@ -41,6 +41,7 @@
>>   #include "qemu/log.h"
>>   #include "system/memory.h"
>>   #include "tcg/tcg.h"
>> +#include "exec/cpu-common.h"
>>   #include "exec/gdbstub.h"
>>   #include "exec/target_page.h"
>>   #include "exec/translation-block.h"
>> @@ -466,6 +467,18 @@ bool qemu_plugin_write_register(struct qemu_plugin_register *reg,
>>       return (gdb_write_register(current_cpu, buf->data, GPOINTER_TO_INT(reg) - 1) > 0);
>>   }
>>   
>> +void qemu_plugin_set_pc(uint64_t vaddr)
>> +{
>> +    g_assert(current_cpu);
>> +
>> +    if (qemu_plugin_get_cb_flags() != QEMU_PLUGIN_CB_RW_REGS_PC) {
>> +        return;
>> +    }
> 
> I think its fine to assert() here - we do it elsewhere in the api, if
> the user is holding it wrong we should exit now rather than leave the
> plugin more confused in the future.
>

Agree.
With the assert instead of return,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

