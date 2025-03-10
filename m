Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33654C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 13:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trczF-0004sn-1N; Mon, 10 Mar 2025 09:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trcyx-0004d8-8U
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:15:56 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trcyu-0005Ez-0U
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 09:15:46 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac298c8fa50so169587666b.1
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 06:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741612542; x=1742217342; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Npjj/H95lRUb717cfXKRtBdPNO6MpxeDRdjcTTODHOI=;
 b=CZ8uICr8LRGdAB1TQji8ti1/KfLs3uZqE2aDFEah+p65DQ/kc90UjKkAYTeOhdjb9N
 4D1MYQ3iqg+PXo8LajyzNDU/MVkyLJQS4DIdDmP49KXazx0Tdp5REbsvXXtxUAmdu481
 sNzpL268DrLYFe1tkAUl+HZLCTIAba3hlVz+ioAQ06hK1wAVG5uCU1Gn8GXUzcILhXTT
 l7a3/y42Q5gWpXG/suJkKISYVPdLafImEZ3xn+ncXpnaVwZ5W3YFwRKEN79B9/jkGNZX
 FG0+O0LWp6RzFiH9I2AwFhvNeAAEnYexb0YCh0n1BOP1geOTKyIgSm8BzcZh9FI1RoM0
 UnBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741612542; x=1742217342;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Npjj/H95lRUb717cfXKRtBdPNO6MpxeDRdjcTTODHOI=;
 b=NlKOwYf2EOU/HlIXKNeBEa/MflpCU0UHWAGnqbJAippuMlCeEmRsAFZj8IjgF3KGDU
 9meBvQ0jhYSkF5WE686q/JynrxAwUhF/fEeYdDB1s0Ha0oNtHudfDzC28sWsud9mPWNy
 RcK1wmF0Kp12h9znTNlyF+tTym0SHhUWY4goBZktZ5T+olXn4RUzKzjsMrPkLX5BhhaW
 USNEfDt2edxwpjVtw1hB7bXVGgoduUCYWSoYHDz8kH/o7Aj812Ggs9QPjya3VuyHKaoZ
 FcelX0LQNJwLTyqDLk4RS9IAuxeuzX5yNvKL60WHTuZng2Um7KeqYq+GIc5b+pJR21cp
 faCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUM98yTFs1tNwncDEpyCWdW5CcG3FlUNx946dXZ5ki8x2YlkE6kchF6qjZLi8uRkRtClNojCtlxGxRR@nongnu.org
X-Gm-Message-State: AOJu0YxpAMuPkS8cyH830+/svhBJTfzZX/9ck8ApB8bmziSVqhhd0ON4
 UN84XEpZWF54QiyjtFg/spIpuc/OJ+zVabXfhzpy5o1Gd7ObOS86VFqeAjfyly3BMij5BNs4W8E
 BaAs=
X-Gm-Gg: ASbGncszVQxsvRkfbCUKidPjGjwQ7rn7CQuprCzpgwcN41ccCFsBOXNFsQVD8cHRzcT
 fXK7j/rQo44cEfxhtleJi+/Lj5HOOu2FmhDUDQRAwW4Cf3nVp3hz77QMSLSSk5uSPbsJDbpBchD
 LfvrPxAox56ZewpucDBM+0D+hLI8glSHC3voJv2ezxN37uoadi5elIyPnSxzl/KZ/pB6VrIuOVO
 DEc1QjZa/FuIFVZS8SWHdPUNUp+p9t+8MMXPYQ+fj5ZCoV/2PuvKDZKS9nvpYKCjXqEXMlOXiUL
 F3tJ0+r2SfUJr6gyY+yI5CapefmSK1R5/NPAWrHCnAvCArngLjxTjBp1plPjyg5G9fDgrk6FaEa
 d7CP5Bj3OuvS/
X-Google-Smtp-Source: AGHT+IHc1ZGMEsJ62l8vLUUhkzV+oeK4vjPTMxkR6gVNvyUe7aVbcZVyBE6GbZ7hXnS9Zlj3WYlqCw==
X-Received: by 2002:a05:6402:430b:b0:5df:25e8:26d2 with SMTP id
 4fb4d7f45d1cf-5e5e22a79ccmr32715842a12.5.1741612542143; 
 Mon, 10 Mar 2025 06:15:42 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac254b805f6sm613085766b.88.2025.03.10.06.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 06:15:41 -0700 (PDT)
Message-ID: <4842ddd6-acae-457d-8310-d2463773ee1b@linaro.org>
Date: Mon, 10 Mar 2025 14:15:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson.build: Set RUST_BACKTRACE for all tests
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>
References: <20250310102950.3752908-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250310102950.3752908-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

On 10/3/25 11:29, Peter Maydell wrote:
> We want to capture potential Rust backtraces on panics in our test
> logs, which isn't Rust's default behaviour.  Set RUST_BACKTRACE=1 in
> the add_test_setup environments, so that all our tests get run with
> this environment variable set.
> 
> This makes the setting of that variable in the gitlab CI template
> redundant, so we can remove it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   meson.build                         | 9 ++++++---
>   .gitlab-ci.d/buildtest-template.yml | 1 -
>   2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/meson.build b/meson.build
> index 8b9fda4d95e..2f373dc675f 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -5,9 +5,12 @@ project('qemu', ['c'], meson_version: '>=1.5.0',
>   
>   meson.add_devenv({ 'MESON_BUILD_ROOT' : meson.project_build_root() })
>   
> -add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default: true)
> -add_test_setup('slow', exclude_suites: ['thorough'], env: ['G_TEST_SLOW=1', 'SPEED=slow'])
> -add_test_setup('thorough', env: ['G_TEST_SLOW=1', 'SPEED=thorough'])
> +add_test_setup('quick', exclude_suites: ['slow', 'thorough'], is_default: true,
> +              env: ['RUST_BACKTRACE=1'])
> +add_test_setup('slow', exclude_suites: ['thorough'],
> +               env: ['G_TEST_SLOW=1', 'SPEED=slow', 'RUST_BACKTRACE=1'])
> +add_test_setup('thorough',
> +               env: ['G_TEST_SLOW=1', 'SPEED=thorough', 'RUST_BACKTRACE=1'])

Nitpicking, we can keep sorted:

          env: ['G_TEST_SLOW=1', 'RUST_BACKTRACE=1', 'SPEED=thorough'])

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


