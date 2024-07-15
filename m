Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D14C3DA4B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 23:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTUoX-0000Jo-3T; Mon, 15 Jul 2024 19:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sTUoV-0000JK-R0
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 19:08:59 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sTUoT-0007Gr-6Z
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 19:08:59 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-78964fd9f2dso3004199a12.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 16:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721084935; x=1721689735; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=djcKWPGd6XjV3faeOnZFczGLe40Ufn+fJJAagkZJWgE=;
 b=b22kGkgriDsNgHXsl9dlnZBWxa15Nt60SEyUuDXNiQn+0plpuFD6tjvye1E7ADpNa9
 JhHtRQDiN2hmEalqbVxzowO3P5gXHPosjdHabOYKH4Lh6gqgrFfI/9fy3rSY3vzfPBc2
 kgEguL0igKAmNAwBfTJvOpKbY9xYDm4jJ/62LCwXyLKNKIkox4hPTChN2igfH4LpImd/
 gNjh9UYmzD+mVGEmX1r4n0F65Afj5A01Ts6TgU2Wh+XhdKGkn6XQApm2pXHpRSxEBymi
 izrbsBUJlggNjjxcQ6WinHe5cvvdJa8eK/3qwwhXVh0Ltoov7TS/kORZsTSbvlvFAgsZ
 7a+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721084935; x=1721689735;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=djcKWPGd6XjV3faeOnZFczGLe40Ufn+fJJAagkZJWgE=;
 b=kPMOHkhZ9NnajLjx59Sd3ZvTZIrsnDFXIQc9OssA1knToHU6E4CPW7zbFFb/WNeyBN
 D6bCpHYI6n6iwaCN8Xj9lhBQ7gLzgQKEDE6Cp641nEKxR13MZR9nhbyZbvOZY/0BMCnR
 AlF97+mPQbcln++/vGuN1CjjlXzsyi9ve+REO/sYTnp7iwT31ygALqzTEow8LVDdvV5z
 BVD228oXNYTbZFYRCYWEmEoZNrVgpGAqoq/8/l+q7D/YlKHrxbj2kE2VIx/IOW5GIk6t
 6263YUc4ZNG9aEizQznw4knrUKKg6We4qeo4hNIHJ3W5y5JEdVC205Pm/+5GiupvmHqS
 nLNA==
X-Gm-Message-State: AOJu0YxrrXzYPri8A3xMoy4MSTYAe4dCR1ElbrQ6c648ZLzVaPELkQgW
 GyHCUhzzlf4U7psQjdNO50zfZwOv9h41UJhA28qnOms6+1Xo54c11iFLF9qNn4XCilU79og8ANd
 vHKA=
X-Google-Smtp-Source: AGHT+IE7KYHvf2wd4zjihLXGTiJPrg2+b18SrGdZTPIGpE/VIn7c6r4nBqJwgeJTn4ojKmCskbQ9DA==
X-Received: by 2002:a05:6a21:8cca:b0:1be:e265:81ff with SMTP id
 adf61e73a8af0-1c3f12b36f8mr482947637.56.1721084934901; 
 Mon, 15 Jul 2024 16:08:54 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9384:1d00::bfd3? ([2604:3d08:9384:1d00::bfd3])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eca6b19sm4980524b3a.161.2024.07.15.16.08.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jul 2024 16:08:54 -0700 (PDT)
Message-ID: <4967cfde-65d0-46ac-8956-a23eb9836e90@linaro.org>
Date: Mon, 15 Jul 2024 16:08:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] plugins/stoptrigger: TCG plugin to stop execution
 under conditions
To: Simon Hamelin <Simon.Hamelin@grenoble-inp.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20240710120854.34333-2-simon.hamelin@grenoble-inp.org>
 <87jzhsqm97.fsf@draig.linaro.org>
 <b03c9f17-a99a-4b6e-883b-37ce092d2a57@grenoble-inp.org>
 <95ebaf0d-2dee-4403-94c6-44e654f05b38@linaro.org>
 <ceab7747-1baa-46d3-860d-b99247e3a65c@grenoble-inp.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <ceab7747-1baa-46d3-860d-b99247e3a65c@grenoble-inp.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x533.google.com
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

On 7/15/24 01:09, Simon Hamelin wrote:
> Hello Pierrick,
> 
>> Could you share a bit more information on the final goal, if possible?
>> Is that used for fuzzing binaries, security analysis, or other things?
> 
> I'm currently using this plugin for security analysis purposes.
> Basically my goal is to simulate fault injection using QEMU. To do so
> I'm using this plugin along with another plugin that skips an
> instruction at a given address. With this plugin I'm able to see how the
> program reacts to the fault and stop it with a custom return code.
> Basically there are 4 cases:
>      - The fault does not disrupt the program and it reaches the expected
> address.
>      - The fault disrupt the program and it reaches an unexpected address
> known as the "target" address.
>      - The fault disrupt the program in such a way that it executes a lot
> of instructions without reaching the expected address, this situation is
> known as a "timeout".
>      - The fault crashes the guest, causing it to reach an error handler
> address.
> 

Thanks for sharing this, it's an interesting use case.

How did you implement instruction skipping?
Is that based on current API, or do you have a QEMU fork?

> In short, here's a command line that illustrates how I use the plugin:
> 
> $ qemu-system-aarch64 $(QEMU_ARGS) -plugin
> ./contrib/plugins/libstoptrigger.so,icount=timeout_count,addr=addr=expected_addr:0,error_handler_addr:1,target_addr:2
> -d plugin
> 
> --
> Simon Hamelin

