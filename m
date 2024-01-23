Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24AEC47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 23:53:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSQaK-000237-Ml; Tue, 23 Jan 2024 18:53:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSQaI-00022j-S3
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 18:53:38 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSQaH-0005rR-7R
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 18:53:38 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5ce74ea4bf2so3198491a12.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 15:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706054015; x=1706658815; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YR/6IZdoMpApMNPayM6rp9uVnlkzmT9gg8m8LRchJVY=;
 b=msKxkJ3Eigvw7kT1df6V+7u8nlMAV6AkUaqMH3hfN2UafWPx+/OgzhN0hGRCaReXXN
 n3wFrYBUTq4NMVzXbv2cqo/pouH8MZAmJb5LA9saBm7sW+322kPyKctWMfqQSpUwniG+
 vLWsWOuMJlqhseUVBrWHhwHxJjYZPXW4pBL/A0zNStnk6yH8fvRttjTI5lTDX1wYE9Q4
 2xovyGPaRPSElFRluArbZsHfahoHq8Jhk/B88d0gGIDXlzvYHaS1qXx6uigGlqvbxcff
 3OFNAwzEfsVyNsA5CkLqGzsd+C3rqhVt437y7W9SPViG30Bl6kxReA+r8IlMM5rCC5hg
 bR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706054015; x=1706658815;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YR/6IZdoMpApMNPayM6rp9uVnlkzmT9gg8m8LRchJVY=;
 b=t7UUlLd3jCAb+m1uFv1Nz+WvCiRbB0yzelRXUmLGNNchCX3W+yicYuB2ExddeJyt+v
 vFyIFMtdhatgEM/yE68ne7t28miEov9SoJmGfksHZxUM7ry+2Hcp76lodzeLuOTCHw9M
 rG09RclL9/pRbgYHOWujfuzC2t0bpfgAwk8kYQi6FbG4wGBCDDu5TrWHedXVf/LBLRSz
 XI0RnIbUyMAisApJmASLRsEL/KlqQobLX6rEcOCpqZXOxcjtErMtoCaZCfqYoXeVg+CW
 KD2h0eSERffAqnrYsXry5L7LkPxvMyrYRxwmRUZGhovZ4iu+5fNCdEmGoVfb040mHhA1
 tUYA==
X-Gm-Message-State: AOJu0YzBEw4NpzdTasmqdxQxtVvPuflQuH5KkaxIusF4TiEG5YCkMzgv
 Yg9W42UJEbZqE1n9kH55ls16rEmmf8h5e6dJfZVNTeWdoyrgeWTn3dD7Hswxg/A=
X-Google-Smtp-Source: AGHT+IHc4H7C6gXiKnKo8vgrBjFpYOxCbUzL8yHKzBHlalDCp86T2B6Yv+yf3lL/NQVz9rUwxiq/Aw==
X-Received: by 2002:a05:6a21:1a9:b0:19a:fbfa:b16a with SMTP id
 le41-20020a056a2101a900b0019afbfab16amr528211pzb.30.1706054015652; 
 Tue, 23 Jan 2024 15:53:35 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:dd1:291f:3c3c:2485?
 (2001-44b8-2176-c800-0dd1-291f-3c3c-2485.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:dd1:291f:3c3c:2485])
 by smtp.gmail.com with ESMTPSA id
 r13-20020aa7844d000000b006dbd18ad865sm6441913pfn.55.2024.01.23.15.53.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 15:53:35 -0800 (PST)
Message-ID: <973bcce0-8f68-4181-aa76-48a48be7f99e@linaro.org>
Date: Wed, 24 Jan 2024 09:53:29 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 13/34] target: Uninline cpu_get_tb_cpu_state()
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-14-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-14-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 1/20/24 00:40, Anton Johansson wrote:
> Required to compile accel/tcg/translate-all.c once for softmmu targets.
> The function gets quite big for some targets so uninlining makes sense.
> 
> Signed-off-by: Anton Johansson<anjo@rev.ng>
> ---
>   include/exec/cpu-common.h |  4 +++
>   target/alpha/cpu.h        | 11 -------
>   target/arm/cpu.h          |  3 --
>   target/avr/cpu.h          | 18 -----------
>   target/cris/cpu.h         | 10 ------
>   target/hexagon/cpu.h      | 12 -------
>   target/hppa/cpu.h         | 43 -------------------------
>   target/i386/cpu.h         |  9 ------
>   target/loongarch/cpu.h    | 11 -------
>   target/m68k/cpu.h         | 16 ---------
>   target/microblaze/cpu.h   |  8 -----
>   target/mips/cpu.h         |  9 ------
>   target/nios2/cpu.h        | 12 -------
>   target/openrisc/cpu.h     | 10 ------
>   target/ppc/cpu.h          | 13 --------
>   target/riscv/cpu.h        |  3 --
>   target/rx/cpu.h           |  9 ------
>   target/s390x/cpu.h        | 22 -------------
>   target/sh4/cpu.h          | 15 ---------
>   target/sparc/cpu.h        | 35 --------------------
>   target/tricore/cpu.h      | 12 -------
>   target/xtensa/cpu.h       | 68 ---------------------------------------
>   target/alpha/cpu.c        | 11 +++++++
>   target/avr/cpu.c          | 18 +++++++++++
>   target/cris/cpu.c         | 10 ++++++
>   target/hexagon/cpu.c      | 12 +++++++
>   target/hppa/cpu.c         | 47 +++++++++++++++++++++++++++
>   target/i386/cpu.c         |  9 ++++++
>   target/loongarch/cpu.c    | 11 +++++++
>   target/m68k/cpu.c         | 16 +++++++++
>   target/microblaze/cpu.c   |  7 ++++
>   target/mips/cpu.c         |  9 ++++++
>   target/nios2/cpu.c        | 12 +++++++
>   target/openrisc/cpu.c     | 10 ++++++
>   target/ppc/cpu.c          | 11 +++++++
>   target/rx/cpu.c           |  9 ++++++
>   target/s390x/cpu.c        | 24 ++++++++++++++
>   target/sh4/cpu.c          | 15 +++++++++
>   target/sparc/cpu.c        | 35 ++++++++++++++++++++
>   target/tricore/cpu.c      | 12 +++++++
>   target/xtensa/cpu.c       | 68 +++++++++++++++++++++++++++++++++++++++
>   41 files changed, 350 insertions(+), 349 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

