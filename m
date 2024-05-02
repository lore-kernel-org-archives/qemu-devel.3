Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC493C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 20:49:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2dM0-0007YW-Pv; Thu, 02 May 2024 16:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1s2dLy-0007YM-EI
 for qemu-devel@nongnu.org; Thu, 02 May 2024 16:48:30 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1s2dLr-0007Me-I7
 for qemu-devel@nongnu.org; Thu, 02 May 2024 16:48:30 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2b387e2e355so994321a91.3
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 13:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714682898; x=1715287698; darn=nongnu.org;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:references:to:from:subject:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uM7v/cEzO1jGRhCUU/FgZXqzFxJhk+NVI87h9oi6SDk=;
 b=NIh0GvEsA4rYa34ul5zc4YJTAH0/pHxH9x9ym18u5iy9EN1nBprqf3vniSHWSQaC8y
 rtteahCwzAxr+BjeoZ8Ik9QLsjQ6/2wceEZxVk8MVg4IvrXwf/FJznLzlkDZL2Vb5S3x
 Q93aDvnOTeSEMI49nyDp8rmavnL4at3TE5xetoDNGOZkaVtKvwNohdSS7/rrZKS+EuKw
 5YKEdsSYO08iYGrBZOB64+tlylOX29lYv544EW5h0xwcgthz91sEcBegwD3fIYtsmC/l
 eUo8Sx9DtBR7ShNvX0Gk/TD7WNT5rD1YAzoYlRplFw4vjyOJa53zLXT8xIWIJikGIwm3
 gFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714682898; x=1715287698;
 h=content-transfer-encoding:content-language:in-reply-to:mime-version
 :user-agent:date:message-id:references:to:from:subject
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uM7v/cEzO1jGRhCUU/FgZXqzFxJhk+NVI87h9oi6SDk=;
 b=CRkLkYpbI3yfMeHb13+3vSWxbm/4kaXy0P61M7ZEmlRIhZEOqmADabIfPv3ISjELBr
 WcIyDk4yUZRCqWEAf2Bpf1hWGBEnceov+FhAXOMxOZbl7Eo/seFUaQWh1RCP4yoza4t5
 2wIVDejC9DX2LG5i0awlWk6LuHAl83qACjO7ORwrKF7IQ8g2herYSXxMW8Fs1mbVimHE
 oyrbtUSvjbD+dxmCiWCydqQA6cTRSDWRuYpNCYM40ob7St7KylipMXK+oYP4cJMlQgW2
 NLHqvMhtTmOcGqEVUK/KPMxKOdcy3/Zc++T8sQHH8UxHaTJannt7icdcke4q1WZj5Bso
 Jy3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrL4ZDBnd19gXJFwZ7PRV6jqF5pfkH0TDZy8W0WoC3PxyvSs7kIVwI5VsUnWI9SpQ/I9YHGQO33DLV3ktNWnj6LrJE7rA=
X-Gm-Message-State: AOJu0YxZnO3o8zoI18kkabXOLXkbcSVQ6X0tq0QoS17alZqsTCOcGNOB
 Q62Wo+dioLBxmOGvjRMkvluFZp1FnxDGs0CRZ/VFsYF9mZf2b9/4vXmVOhvVYWFYfe9k1fPDNgg
 s
X-Google-Smtp-Source: AGHT+IH/Nbv3ddtIF8IfkFtX7JDm4RMQh4ooYGQdGSq6LRtyrxD4X8etd3oKt9WX3JFYMXbuoDElqQ==
X-Received: by 2002:a17:90a:628b:b0:2b3:6d3b:ca1 with SMTP id
 d11-20020a17090a628b00b002b36d3b0ca1mr892398pjj.28.1714682898034; 
 Thu, 02 May 2024 13:48:18 -0700 (PDT)
Received: from [192.168.0.102] (201-1-51-131.dsl.telesp.net.br. [201.1.51.131])
 by smtp.gmail.com with ESMTPSA id
 lw5-20020a17090b180500b002a6e67e197dsm1679800pjb.45.2024.05.02.13.48.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 13:48:17 -0700 (PDT)
Subject: Re: [PATCH v5 0/9] TCG plugins new inline operations
From: Gustavo Romero <gustavo.romero@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240502180847.287673-1-pierrick.bouvier@linaro.org>
 <b78563fd-1c06-8ee1-5508-39b3e83249cf@linaro.org>
 <b083716a-dd1e-4edb-ba57-530c7661305f@linaro.org>
 <b3474554-0333-27c2-df47-146e5ef317d9@linaro.org>
Message-ID: <6f37fbce-9fcc-ab7d-08fc-cfd8bb470f9b@linaro.org>
Date: Thu, 2 May 2024 17:48:14 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <b3474554-0333-27c2-df47-146e5ef317d9@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.296,
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

Hi Pierrick,

On 5/2/24 5:09 PM, Gustavo Romero wrote:
> On 5/2/24 4:45 PM, Pierrick Bouvier wrote:
>> Hi Gustavo,
>>
>> On 5/2/24 12:16, Gustavo Romero wrote:
>>> Hi Pierrick,
>>>
>>> On 5/2/24 3:08 PM, Pierrick Bouvier wrote:
>>>> This series implement two new operations for plugins:
>>>> - Store inline allows to write a specific value to a scoreboard.
>>>> - Conditional callback executes a callback only when a given condition is true.
>>>>     The condition is evaluated inline.
>>>>
>>>> It's possible to mix various inline operations (add, store) with conditional
>>>> callbacks, allowing efficient "trap" based counters.
>>>>
>>>> It builds on top of new scoreboard API, introduced in the previous series.
>>>>
>>>> NOTE: Two patches still need review
>>>>
>>>> v2
>>>> -- 
>>>>
>>>> - fixed issue with udata not being passed to conditional callback
>>>> - added specific test for this in tests/plugin/inline.c (udata was NULL before).
>>>>
>>>> v3
>>>> -- 
>>>>
>>>> - rebased on top of "plugins: Rewrite plugin code generation":
>>>>     20240316015720.3661236-1-richard.henderson@linaro.org
>>>> - single pass code generation
>>>> - small cleanups for code generation
>>>>
>>>> v4
>>>> -- 
>>>>
>>>> - remove op field from qemu_plugin_inline_cb
>>>> - use tcg_constant_i64 to load immediate value to store
>>>>
>>>> v5
>>>> -- 
>>>>
>>>> - rebase on top of master now that Richard's series was merged
>>>>
>>>> Pierrick Bouvier (9):
>>>>     plugins: prepare introduction of new inline ops
>>>>     plugins: extract generate ptr for qemu_plugin_u64
>>>>     plugins: add new inline op STORE_U64
>>>>     tests/plugin/inline: add test for STORE_U64 inline op
>>>>     plugins: conditional callbacks
>>>>     tests/plugin/inline: add test for conditional callback
>>>>     plugins: distinct types for callbacks
>>>>     plugins: extract cpu_index generate
>>>>     plugins: remove op from qemu_plugin_inline_cb
>>>>
>>>>    include/qemu/plugin.h        |  42 +++++++----
>>>>    include/qemu/qemu-plugin.h   |  80 ++++++++++++++++++++-
>>>>    plugins/plugin.h             |  12 +++-
>>>>    accel/tcg/plugin-gen.c       | 136 +++++++++++++++++++++++++++--------
>>>>    plugins/api.c                |  39 ++++++++++
>>>>    plugins/core.c               | 109 ++++++++++++++++++++--------
>>>>    tests/plugin/inline.c        | 130 +++++++++++++++++++++++++++++++--
>>>>    plugins/qemu-plugins.symbols |   2 +
>>>>    8 files changed, 466 insertions(+), 84 deletions(-)
>>>
>>> The description in the commit message of patches 1/9, 2/9, 6/9, 7/9, and 8/9 is missing.
>>>
>>> Is this intentional?
>>>
>>
>> Do you mean there is no multiline commit message for those changes?
>> Indeed, for some of those patches, the change is a single line commit message.
> 
> I just see a commit title and the Signed-off-by. For example, in 8/9
> I see the following on git log:
> 
> commit f518898aa09b42e317b887237bb75a432b477c6d
> Author: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Date:   Thu May 2 11:08:46 2024 -0700
> 
>      plugins: extract cpu_index generate
>      Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>      Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> It has only the title: "plugins: extract cpu_index generate"
> and R-b and S-b, so no description about the changes.

The description (the body of the commit message) is mentioned here:

https://www.qemu.org/docs/master/devel/submitting-a-patch.html#write-a-meaningful-commit-message

After quickly looking at the committed logs, I do notice some commits missing it,
but I really believe it's important to have it for the reasons outlined in these
guidelines.


Cheers,
Gustavo

