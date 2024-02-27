Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A760C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 10:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1revAz-0002PQ-Ep; Tue, 27 Feb 2024 05:59:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1revAp-0002Kp-Ak
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 05:58:59 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1revAm-0004cu-B8
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 05:58:59 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-29ad8ef1384so1030315a91.3
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 02:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709031532; x=1709636332;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TsDmIcNCrVwkgpZ3Rq+Sniy+ldkymAQlv95cwgKc05Q=;
 b=SnwFljKyC+A7tup8a1RwtjQ4D6/sUBTMkAqoUeaOT4MrHzYE/xhinXtGbZINfB2D/6
 jSOvvI6H4nHBvky58zATnXlfMv5PiZJHwJd4AW7aOMNpJUQeOX1kbhoyAaQzVu1s89pE
 n+jchiVa9gGRJMpNxBoyTXOx9pWKULVSQGsnIy81wG7ctXKCItXbXAQMBzxcPKnNe//S
 zeqoilKymCo6IOWFA6/jBGfiHv/0TTlEKi3aa+216gXIPJAtg6UeGv8+luj3SQskQ9Xn
 gvrgvL4Yt1/ptp8LapkUYQn3YrETppmvwaax7TesYmOdC5ynBN7HJTAR9xp6y9Nn+EHn
 gzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709031532; x=1709636332;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TsDmIcNCrVwkgpZ3Rq+Sniy+ldkymAQlv95cwgKc05Q=;
 b=FVGfsOOFhXxb3rizjtO+RRHb7OVXXPzjCHxP/49VJiXyGKi2oGrKlwg/W2onqz3KyG
 6zuJZk6XMr275MnfgUAiW1eYYOHFmsINKbRtlLKw65ry/odCMEXit6z1LOJqV4WlWRGu
 uJEt++0DJGZz/PH5IbpdDDBcwQNKP7oUyOWa0YYWAxh6/IjLc3qU7rjLixESfllHH8Pk
 P/6ZLlkNnEJbVkJBdmDacdiFJ0TcSNVsizJU11BgMF3lmghyz8JQl7XUn2e+r86fUDqa
 gYJzFlhcEC9eYRPKR4azx4MsVFMW5OOlBfFrv1+Sh+HAMCkGXb0H57If4973yoI7Prm7
 RX1Q==
X-Gm-Message-State: AOJu0Yy/dCqWlL1SJ+RqZdotE3U9HH2AbfQP2o7sbCPrdg5O40knkHSG
 rorAXZkQwy+WYT1FNs5dAoKE3RuTYdZsk73iX4rKMoOxkgRhvc0TjYWsP9CztiQ=
X-Google-Smtp-Source: AGHT+IE/xiDOvK/3wPL4R00Ude4nZVASCnxuRQ+do4oShLbadK9+gnNEMWTWVVSbYfenFG/UxyRKTw==
X-Received: by 2002:a17:90b:4a03:b0:298:b9e3:691f with SMTP id
 kk3-20020a17090b4a0300b00298b9e3691fmr7038770pjb.23.1709031532662; 
 Tue, 27 Feb 2024 02:58:52 -0800 (PST)
Received: from [157.82.203.206] ([157.82.203.206])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a17090ac88300b0029a4db713b9sm8183679pjt.39.2024.02.27.02.58.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 02:58:52 -0800 (PST)
Message-ID: <20e4981d-6378-4293-8625-7c24bb499f41@daynix.com>
Date: Tue, 27 Feb 2024 19:58:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/27] plugins: add an API to read registers
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-riscv@nongnu.org, Michael Rolnik <mrolnik@gmail.com>,
 Song Gao <gaosong@loongson.cn>, Alexandre Iooss <erdnaxe@crans.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, John Snow
 <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Brian Cain <bcain@quicinc.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bin Meng <bin.meng@windriver.com>, Laurent Vivier <laurent@vivier.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20240226165646.425600-1-alex.bennee@linaro.org>
 <20240226165646.425600-22-alex.bennee@linaro.org>
 <b7aac53e-cde5-4596-b0fc-d39f52d4ceb8@daynix.com>
 <878r36dxsv.fsf@draig.linaro.org>
 <485e6093-54e9-4ce4-ae01-c44525b202ef@daynix.com>
 <8734tedwun.fsf@draig.linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <8734tedwun.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 2024/02/27 19:29, Alex Bennée wrote:
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> On 2024/02/27 19:08, Alex Bennée wrote:
>>> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
>>>
>>>> On 2024/02/27 1:56, Alex Bennée wrote:
>>>>> We can only request a list of registers once the vCPU has been
>>>>> initialised so the user needs to use either call the get function on
>>>>> vCPU initialisation or during the translation phase.
>>>>> We don't expose the reg number to the plugin instead hiding it
>>>>> behind
>>>>> an opaque handle. For now this is just the gdb_regnum encapsulated in
>>>>> an anonymous GPOINTER but in future as we add more state for plugins
>>>>> to track we can expand it.
>>>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1706
>>>>> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
>>>>> Message-Id: <20240103173349.398526-39-alex.bennee@linaro.org>
>>>>> Based-on: <20231025093128.33116-18-akihiko.odaki@daynix.com>
>>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>
>>>> Hi,
>>>>
>>>> Mostly looks good. I have a few trivial comments so please have a look
>>>> at them.
>>> Done
>>> <snip>
>>>>> +        g_array_append_val(find_data, desc);
>>>>> +    }
>>>>> +
>>>>> +    return find_data;
>>>>> +}
>>>>> +
>>>>> +GArray *qemu_plugin_get_registers(void)
>>>>> +{
>>>>> +    g_assert(current_cpu);
>>>>> +
>>>>> +    g_autoptr(GArray) regs = gdb_get_register_list(current_cpu);
>>>>> +    return regs->len ? create_register_handles(current_cpu, regs) : NULL;
>>>>
>>>> Why do you need regs->len check?
>>> Not all guests expose register to gdb so we need to catch that:
>>>     TEST    catch-syscalls-with-libinsn.so on alpha
>>> **
>>> ERROR:../../plugins/api.c:459:qemu_plugin_get_registers: assertion failed: (regs->len)
>>> Aborted
>> Certainly regs->len can be 0, but why do you need to return NULL in
>> that case? Can't qemu_plugin_get_registers() return an empty array
>> just as gdb_get_register_list() does?
> 
> That seems more troublesome to handle the other end. NULL is nothing is
> a fairly common pattern here which makes short-circuiting the array
> iteration simple.

I'm not sure why you would want to short-circuiting array iteration. 
Iterating an empty array is often simpler.

In any case, the same logic also applies to gdb_get_register_list(), so 
you should change gdb_get_register_list() to return NULL instead of an 
empty array if you think that's more reasonable.

