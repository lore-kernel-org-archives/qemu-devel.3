Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E37104891A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 21:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw5ck-0001mq-3u; Fri, 27 Feb 2026 16:43:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vw5ci-0001mH-Mq
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 16:43:48 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vw5ch-0001pp-4v
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 16:43:48 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c70f5d6a6a4so1379406a12.1
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 13:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772228625; x=1772833425; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UJx0MSMj60UAiO1en17kEvWL75MEKEJEQL1IJF6VyN8=;
 b=mhXiWMMItq+ci4WbgbJsU7WqFsxwzJ2w4GFJBCrQsOyj72aOQLxARtpz479PHqGcpQ
 fl57jUeqlKQ/Pn+0F4mi3zvEGj1/3Y4p2DtTGb1hquiCpJIAkV0RYzNI12Sm/fI/yfKg
 9CSTNOCx4pLls5UlmAxs+Dx/l678Qj5CfhHGerq+5rrCGFwKcQAlggXQD7XnjI6LNVxs
 ymKQ7w6eCAiYxOgLw5kzELVol1PAWTyE5Hj8X19fcm8C/kIjnZ3eSPrXV2jIsRZdoQgS
 TT8KjEOquW9fg+XCdGgNOrdJB0vnP245rLFzJVIYKxtQDiqExrwrKOol46uUPiWVi+u9
 TWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772228625; x=1772833425;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UJx0MSMj60UAiO1en17kEvWL75MEKEJEQL1IJF6VyN8=;
 b=laiMnjPurx8jabsoSQvk9JuBW3oe6Mi+AhY1nO7lQREjFAYU4BmHVzYefRQhPED9MR
 zu30/1uE904j1MxwGvAB8MWSOzDjkgYvn49mGNtS5WJeNQaIv58mtPl87vDr3xouZUZo
 dr/ygK+JU51KouNDNWoQWIeeitRMQKnL/yA/2gFeTXUxc2UluCSTeRnPahKiRfKOGCgY
 kt+eP6PHnfPFlQwsjzKW8KGzb9fEJLyWIBQtAjsgrgIWbJ5naFEhNvqwSUNa722UVSBp
 s5d70Z6kMN0ktCHoqgbJh0Oivs/qvsI6drcja4qAweMgKt1WfdI08kWLKgQ0fOPUOLYD
 ml+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYUXR9avL+ijcScy+4jeZageRLUJlqzJsU4q3iUcEkJB4qwZN7YU4n552FAmaDhc7MWMtVPAHz81zg@nongnu.org
X-Gm-Message-State: AOJu0YzyibGqIhgsyexoaCN+o7O5tnquNoeKadhvT0EoBTSoqA+ZrnL3
 8KPKa7xWiOBQfityHKmJijhLgcgP/F2PHJeLrWBUGAFErRR+juF7HKro+ffJAjM2Q3s=
X-Gm-Gg: ATEYQzx/1F1ho4bkDOBus2KuTb7MLqMGjnKH7ukXccqSuhnqH5mm+iotUpfL3ekV19C
 z2YYt65N994zszN9h9tYXY3SJ+RqTgHYz0XxaX3mb4gpGgsu/fzGcNRtoGuLMimcHtAK0Cz9/iP
 O08R8TqQbxvNzGmGv1QEgwrQMmQeDsOicXQZ4ZWy5idHCu0bhCy65QZbgIZMnuGSMoNW51FzjQ4
 1uQJ7uVqKt0rB4JKvs3o7bpIYYvHw/u6Vh+SMTA/wnx5xLSz7MsOJcZ3P7JM9rmp0YVvBuq3kaJ
 YwHVUFGMYGDxJdLDWQaoePSUxo106PxCcKyaS7y6olCFW5SjXq7sq8hwovtuSTXtrGwhka0ZQXu
 e9wBFy0c4Bi1jkso/309scBj1GzoPhaEqtDqNwLBLwnYW3oc0CRswlEh1DU2kQuuAGbijfhXtUP
 6kXH5jRomJ0TIuclq9qR0sH8vUzkWs4FoXnphzrWM5hY22Fak5C/KWAs6QFg1rQ8xQtA0i4RUT0
 m5MdeI=
X-Received: by 2002:a17:903:38c7:b0:2ad:4265:bfab with SMTP id
 d9443c01a7336-2ae2e3ce346mr46701425ad.5.1772228624882; 
 Fri, 27 Feb 2026 13:43:44 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c70fa5e4aafsm5637823a12.4.2026.02.27.13.43.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Feb 2026 13:43:44 -0800 (PST)
Message-ID: <3f07b026-3975-4869-9c3f-b64dd9ddeaab@linaro.org>
Date: Fri, 27 Feb 2026 13:43:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ppc-linux-user GDB stub broken
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Florian Hofhammer <florian.hofhammer@fhofhammer.de>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <e44df309-d40d-46f0-88a8-7ac55f9a3634@fhofhammer.de>
 <CAPMQPEL1__biyd5e81EW78OA1rmVYqfsdEOmH5cs-nOvwnB3cg@mail.gmail.com>
 <70d4f460-c5c5-45ac-9ef0-2307ea4834f2@linaro.org>
 <3ec72a91-7326-43ff-8a8a-30135920ebe1@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <3ec72a91-7326-43ff-8a8a-30135920ebe1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
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

On 2/27/26 1:40 PM, Philippe Mathieu-Daudé wrote:
> On 27/2/26 14:09, Philippe Mathieu-Daudé wrote:
>> On 27/2/26 10:58, Philippe Mathieu-Daudé wrote:
>>> Hi Florian,
>>
>>
>>>> on current master (d8a9d97317d03190b34498741f98f22e2a9afe3e), the basic
>>>> gdb stub test fails for ppc-linux-user when running "make check-tcg".
>>
>>
>>>> I've debugged around a bit but I don't know my way around the gdbstub
>>>> internals enough to propose a patch right away, so I'll just summarize
>>>> what I figured out so far.
>>>> 1. Due to cc->gdb_num_core_regs not being set explicitly anymore, it is
>>>>      set to 0 at the end of gdbstub/gdbstub.c:gdb_init_cpu(). In the same
>>>>      function, cpu->gdb_num_regs gets set to 70.
>>>> 2. When the test tries to read a register in gdbstub/
>>>> gdbstub.c:gdb_read_register(),
>>>>      the first condition of "reg < cc->gdb_num_core_regs" is always
>>>> false.
>>>>      Also, the register number for fpscr passed to the function is is
>>>> 103,
>>>>      and cpu->gdb_num_regs is also 103. If the register number is
>>>> supposed
>>>>      to be an index (as I understand it), this would indicate an
>>>>      off-by-one error somewhere.
>>>>
>>>> If you have some pointers on where to look / what to check out for
>>>> fixing this, I'll happily try to work on a patch. But I suppose that
>>>> somebody more experienced with this could probably fix this much faster
>>>> than I can.
>>>
>>> I'll have a look.
>>
>> Short term, this seems to fix it:
> 
> Series for the generic fix posted:
> 
> https://lore.kernel.org/qemu-devel/20260227213958.21170-1-philmd@linaro.org/
>

Broken link, and unknown series.
Can you send the good one?

Regards,
Pierrick

