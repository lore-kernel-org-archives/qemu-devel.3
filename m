Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B1BC28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 07:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuoEu-0003lf-E3; Wed, 19 Mar 2025 03:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuoEs-0003lQ-PG
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 03:53:23 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuoEp-0002Z2-GP
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 03:53:22 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so29202685e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 00:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742370796; x=1742975596; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dPKBO+pX1GvSQ6t8gQtNdQofWuJ8ObBgPLfneDkaTFc=;
 b=iIIjkawMqWlnJ+lFsWWwIVuu/HkjBvhUUy3cdVG/JOeM7YNHE96MAjb5herufopQzy
 3aaSjR4cxBW0Aquby9/O2he2a/j3SfwkHdaIKGxVQrPyJwayqaFKfHRyPf4SjLHzjFjA
 rD58/f/P9t/DjD0eX3D7fkB7Tt07Pd480dEq/1YkDhMgqrUkwWFBRKoyAZKW+ZS+0lLk
 kf2meNOZvNrEoWS7SyipCxsJaNCKiEQkcPwqkURLT2JSr/xPaHq7p7hC+bLDQ9oRnZmK
 zGhtUJEBOpVrttjZDn4GYVSIsY2z1HJjpmX0WCIkOOsYAPe02NCelmyQuEErGc0hHJzs
 3ncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742370796; x=1742975596;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dPKBO+pX1GvSQ6t8gQtNdQofWuJ8ObBgPLfneDkaTFc=;
 b=SH2pxDTOFJlTnZV+hRZH+C2QKX83LaE3Yyx8qXaGF2oAFz/xvVnra5DFda9dZaP7uQ
 Vk9uUeHbFqwq+Tq+EZ/p86lLPItM6nwlwX79n6gHmU+K4f0B6DHxUvgebuJ6VG96UvEa
 mx5Kz9hLHs69FizQkfQbWHU0qv04E2xtEowpP2y2TAO4ynIdQO3JII9YD6VwQ+lTlkpn
 OII8ty7IrIFz77F8E2T0StdPta6dqXEbDkMjYmO71pqs9zlQ5rR1iFvFc5HsUlA70cQO
 7D5Rne976xiNT1BbmrAqOy+z1vx+3/zMC53s+bgQ9ItSd2G43NI2Ihet8ZIhWrr2RIEJ
 ju3w==
X-Gm-Message-State: AOJu0Yysc6udGiEwD6Gnx7nCjMf5U5iEUjwWBSbFsDrfj17I9YZKJrhT
 +LA+JNKdjsZ0RBmVjJCJ6jnGNEhInQYrXYF9SzFlJJ987S818wESIfBADWhI9q9yRPP205j3XXN
 G
X-Gm-Gg: ASbGnctoWB7DlpsfceiD65yCahqxzk29vfnJftGzEzA2vQkXFpajPJjaG2I8KM+1pLc
 5y7P0siDgvB62J1GSgrwAfmaDwTXnzzyv+Bdg+HWpKhNGWGbZUu1JGHNA4U859Kfck60X8r3V66
 der69DCYPCuZ7O7052bHQlhDV2Z8XmQAlCm88WqnPNZ2FZ/iN37PqF/ZuTYwZDBaumJOHjN0tfu
 Np0gCykevP5+gcwPqvia1h0PsPYd0uGIz3XnQNo9ZdQnXJJ6IZGlI0anLxLwarO6x53Sa8zBL09
 NmGDpaSou8+Fav3fvpHRGMyjq5B+Q59cOVG2J/qbiW4kX0DiB66Wk7IhJF3GS8ZuhDCQ0Ej4Z1R
 MIuyIg8PtZDn6z5/JjbGDGL8=
X-Google-Smtp-Source: AGHT+IFn8bEEbhvYUF9BcuJmpglFLp+voGgkViY/cOfm36hPsa2cnGp8gzZhHlVohShNi6o8ppqtPw==
X-Received: by 2002:a05:600c:1f14:b0:43c:f5e4:895e with SMTP id
 5b1f17b1804b1-43d43781539mr11253555e9.1.1742370796184; 
 Wed, 19 Mar 2025 00:53:16 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d3ae040f9sm33435795e9.0.2025.03.19.00.53.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 00:53:15 -0700 (PDT)
Message-ID: <9a0a5864-1660-474b-b4b7-70e846889de9@linaro.org>
Date: Wed, 19 Mar 2025 08:53:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] accel/tcg: Remove cpu_unwind_state_data() unused
 CPUState argument
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20241115152053.66442-1-philmd@linaro.org>
 <20241115152053.66442-7-philmd@linaro.org>
 <9796cc60-5efb-4a2d-9437-4832a6c43edf@linaro.org>
 <CAFEAcA95k0yX+jns13qx0j+u0aJUjYpaqyDX-y-Cd8xQ4Z9kUA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA95k0yX+jns13qx0j+u0aJUjYpaqyDX-y-Cd8xQ4Z9kUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

+Pierrick & Anton

On 15/11/24 18:33, Peter Maydell wrote:
> On Fri, 15 Nov 2024 at 17:24, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 11/15/24 07:20, Philippe Mathieu-Daudé wrote:
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>    include/exec/translate-all.h | 3 +--
>>>    accel/tcg/translate-all.c    | 2 +-
>>>    target/i386/helper.c         | 3 ++-
>>>    target/openrisc/sys_helper.c | 7 +++----
>>>    4 files changed, 7 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/include/exec/translate-all.h b/include/exec/translate-all.h
>>> index f06cfedd52..9303318953 100644
>>> --- a/include/exec/translate-all.h
>>> +++ b/include/exec/translate-all.h
>>> @@ -23,7 +23,6 @@
>>>
>>>    /**
>>>     * cpu_unwind_state_data:
>>> - * @cpu: the cpu context
>>>     * @host_pc: the host pc within the translation
>>>     * @data: output data
>>>     *
>>> @@ -32,7 +31,7 @@
>>>     * function returns false; otherwise @data is loaded.
>>>     * This is the same unwind info as given to restore_state_to_opc.
>>>     */
>>> -bool cpu_unwind_state_data(CPUState *cpu, uintptr_t host_pc, uint64_t *data);
>>> +bool cpu_unwind_state_data(uintptr_t host_pc, uint64_t *data);
>>
>> Hmm.  I wonder if it should be called "cpu_*" at all then?
>> Worth renaming to "tcg_*" or something?
> 
> Yes, it's odd, isn't it?
> 
> What's the plan for this function in a multi-target
> emulation world? At the moment it (or functions it
> calls) uses TARGET_INSN_START_WORDS which is a
> target-CPU-type-specific value. If in the future we're
> going to want it instead to look that up as e.g. some
> property of the CPU class then maybe we should keep
> passing it the CPU pointer? Or would we instead say
> that we'll define TARGET_INSN_START_WORDS as the worst
> case for any target, since it's always between 1 and 3,
> so it doesn't waste that much space if we have a couple
> of extra sleb128 zero values for targets that don't need
> all 3 words?
> 
> thanks
> -- PMM


