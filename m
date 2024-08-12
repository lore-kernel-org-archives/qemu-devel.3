Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266A0C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 23:21:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdeLI-0006C9-JK; Mon, 12 Aug 2024 19:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sdeLH-00069c-UJ
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 19:20:47 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sdeLF-0004Rq-BI
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 19:20:47 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-710ece280b6so1567092b3a.2
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 16:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723504843; x=1724109643; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0Ng77J3dV7QN+WUnlnE9QUZVEglA+jjS8yTW/cFqjRU=;
 b=DqzRRv6FCxCWjefKZlQkQ5uiPwiwdNp86i3EBiDwdNg7ls2yqVnc3JVy5edNhBq33p
 fCF9YUtJ1R5UmMERLxyyIjySBRfSyLE8TLz1xFKAey18h41QkDSIJjQUBYoAjOmg8rk7
 711Etzx5its/X3ZOBXOHUcJwA6xcwkxS9uOccVxkO2mYV7fNTFUJu+gTjeH/33joHJII
 tH1Gi4q1xb81hXomopBU+NSYiGa9hFbTQyvtIU0DzKxD9E69sBS/2WlO+6CPE09g1Ujs
 kBwPKFV76AaLJtAJb8k/eD/V7De1eQN7Rggvmxs1GR8Xr1ksHAZlAbeZQwcxV78Q8qql
 TWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723504843; x=1724109643;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0Ng77J3dV7QN+WUnlnE9QUZVEglA+jjS8yTW/cFqjRU=;
 b=flkasBkyjvVsBDgOWAiMp8TForZhmdOrPLvC0f8Ra+HlES857vgEtGfy2L1YR7Z9Vd
 hqx0WPKEveGDgCEZWj2/+tydSDTtkgOeqYLePWkWvNT1/CGq7EswIJlUb0BhuUZJqxc4
 tcv+OVCLQWZot/J5X4h04ENSJ3Wkq7xirp0wMgiivATxKLNMs8yvW1QazOqQwKqIyzVN
 qjy4N6G/Lq+d6Z1Mmy4Q2GJdDJAONDs8nhYiJeD1V0KbWo4cObN4k3155fFvxk7grXRx
 3V8JCUZCpSqDicUvG6ZBYhdL3mK0cuEl9EQXsZLpQV4PS/oC4OqL+v0KtaIKpTy8IWHS
 s2ww==
X-Gm-Message-State: AOJu0YyXOLQ1QJesYV3CALSd+v09oBdsdyIvyZtYFxGcEZBcR/o1ErZL
 QZfc3R69OxljiBz5zL1f+7aIvHvezA5gi9x2XpAfyFaaMvM5ncu6vYwZ+NF+DigsAxMBY7SznN0
 JufE=
X-Google-Smtp-Source: AGHT+IENzAPm6I+et594RMOeDmTOg6HfQ+g6gd9Ls5lBIyDx+kMWO62R49pkRE9+OPwN+7ZhstuReg==
X-Received: by 2002:a05:6a21:164e:b0:1c4:c1cd:a29d with SMTP id
 adf61e73a8af0-1c8d754d599mr2194252637.28.1723504843435; 
 Mon, 12 Aug 2024 16:20:43 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00:5b09:8db7:b002:cf61?
 ([2604:3d08:9384:1d00:5b09:8db7:b002:cf61])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1c9db8047sm8975126a91.41.2024.08.12.16.20.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 16:20:43 -0700 (PDT)
Message-ID: <934e9276-adfe-4929-bcad-43d1405cda9d@linaro.org>
Date: Mon, 12 Aug 2024 16:20:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] docs/devel: update tcg-plugins page
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240812231945.169310-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240812231945.169310-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

v2
--

rebased on top of master (plugins doc was split between several files)

v3
--

fix bad commit message

On 8/12/24 16:19, Pierrick Bouvier wrote:
> Reflect recent changes on API (inline ops) and new plugins.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   docs/about/emulation.rst   | 49 ++++++++++++++++++++++++++++++++------
>   docs/devel/tcg-plugins.rst | 13 ++++++----
>   2 files changed, 50 insertions(+), 12 deletions(-)
> 
> diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
> index c03033e4e95..eea1261baac 100644
> --- a/docs/about/emulation.rst
> +++ b/docs/about/emulation.rst
> @@ -207,8 +207,8 @@ Once built a program can be run with multiple plugins loaded each with
>   their own arguments::
>   
>     $QEMU $OTHER_QEMU_ARGS \
> -      -plugin contrib/plugin/libhowvec.so,inline=on,count=hint \
> -      -plugin contrib/plugin/libhotblocks.so
> +      -plugin contrib/plugins/libhowvec.so,inline=on,count=hint \
> +      -plugin contrib/plugins/libhotblocks.so
>   
>   Arguments are plugin specific and can be used to modify their
>   behaviour. In this case the howvec plugin is being asked to use inline
> @@ -219,6 +219,14 @@ Linux user-mode emulation also evaluates the environment variable
>   
>     QEMU_PLUGIN="file=contrib/plugins/libhowvec.so,inline=on,count=hint" $QEMU
>   
> +QEMU plugins avoid to write directly to stdin/stderr, and use the log provided
> +by the API (see function ``qemu_plugin_outs``).
> +To show output, you may use this additional parameter::
> +
> +  $QEMU $OTHER_QEMU_ARGS \
> +    -d plugin \
> +    -plugin contrib/plugins/libhowvec.so,inline=on,count=hint
> +
>   Example Plugins
>   ~~~~~~~~~~~~~~~
>   
> @@ -260,8 +268,7 @@ Behaviour can be tweaked with the following arguments:
>     * - Option
>       - Description
>     * - inline=true|false
> -    - Use faster inline addition of a single counter. Not per-cpu and not
> -      thread safe.
> +    - Use faster inline addition of a single counter.
>     * - idle=true|false
>       - Dump the current execution stats whenever the guest vCPU idles
>   
> @@ -381,6 +388,15 @@ run::
>     160          1      0
>     135          1      0
>   
> +Test inline operations
> +......................
> +
> +``tests/plugins/inline.c``
> +
> +This plugin is used for testing all inline operations, conditional callbacks and
> +scoreboard. It prints a per-cpu summary of all events.
> +
> +
>   Hot Blocks
>   ..........
>   
> @@ -394,9 +410,6 @@ with linux-user execution as system emulation tends to generate
>   re-translations as blocks from different programs get swapped in and
>   out of system memory.
>   
> -If your program is single-threaded you can use the ``inline`` option for
> -slightly faster (but not thread safe) counters.
> -
>   Example::
>   
>     $ qemu-aarch64 \
> @@ -736,6 +749,28 @@ The plugin will log the reason of exit, for example::
>   
>     0xd4 reached, exiting
>   
> +Limit instructions per second
> +.............................
> +
> +This plugin can limit the number of Instructions Per Second that are executed::
> +
> +    # get number of instructions
> +    $ num_insn=$(./build/qemu-x86_64 -plugin ./build/tests/plugin/libinsn.so -d plugin /bin/true |& grep total | sed -e 's/.*: //')
> +    # limit speed to execute in 10 seconds
> +    $ time ./build/qemu-x86_64 -plugin ./build/contrib/plugins/libips.so,ips=$(($num_insn/10)) /bin/true
> +    real 10.000s
> +
> +
> +.. list-table:: IPS arguments
> +  :widths: 20 80
> +  :header-rows: 1
> +
> +  * - Option
> +    - Description
> +  * - ips=N
> +    - Maximum number of instructions per cpu that can be executed in one second.
> +      The plugin will sleep when the given number of instructions is reached.
> +
>   Other emulation features
>   ------------------------
>   
> diff --git a/docs/devel/tcg-plugins.rst b/docs/devel/tcg-plugins.rst
> index d8725c2854a..9463692c411 100644
> --- a/docs/devel/tcg-plugins.rst
> +++ b/docs/devel/tcg-plugins.rst
> @@ -61,11 +61,14 @@ translation event the plugin has an option to enumerate the
>   instructions in a block of instructions and optionally register
>   callbacks to some or all instructions when they are executed.
>   
> -There is also a facility to add an inline event where code to
> -increment a counter can be directly inlined with the translation.
> -Currently only a simple increment is supported. This is not atomic so
> -can miss counts. If you want absolute precision you should use a
> -callback which can then ensure atomicity itself.
> +There is also a facility to add inline instructions doing various operations,
> +like adding or storing an immediate value. It is also possible to execute a
> +callback conditionally, with condition being evaluated inline. All those inline
> +operations are associated to a ``scoreboard``, which is a thread-local storage
> +automatically expanded when new cores/threads are created and that can be
> +accessed/modified in a thread-safe way without any lock needed. Combining inline
> +operations and conditional callbacks offer a more efficient way to instrument
> +binaries, compared to classic callbacks.
>   
>   Finally when QEMU exits all the registered *atexit* callbacks are
>   invoked.

