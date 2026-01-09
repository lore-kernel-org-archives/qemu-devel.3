Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169BCD232EB
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 08:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve7Qz-0003Jg-LW; Fri, 09 Jan 2026 03:01:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve7Qh-00036l-8h
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:01:11 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve7Qd-0005ie-1m
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:01:06 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4775e891b5eso18723165e9.2
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 00:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767945660; x=1768550460; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pg0Ky50f/M8gc0EUh9jbNZK6fIQCnS6kA3vIrS/ZvIc=;
 b=I2iIeN0ZVdfnsUK1jT540fsmJjackCL3CcxV6CvmUW1AiSvmr3tATPpfo79XIWESxF
 hY1Ty4BnCiNJnxc7ELz71s8ftyX8ZvnlWBSTJshr8zf3cVprHOf9SgbClKhrsCmSHvVf
 EkZ0KoGpya9cVwnM2Dw5osCxwFOM3w69VCp6y9iis7d5R9zjjkAJBWMhDleADBfv9Lmz
 R7+tWCdeVO02uLoVWr+/hPGA81VI8/Zm5hem8cjDAiYG8DBuTOPPk5MC8RVAOujn5nCo
 +BVrodZo3msZRvkNRqZ223WIa5Sfiu8RuuCV6x3RHEvh50iGvjEz6WSzPfC2XNWWBsPU
 Q5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767945660; x=1768550460;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pg0Ky50f/M8gc0EUh9jbNZK6fIQCnS6kA3vIrS/ZvIc=;
 b=eaVbtnKlBWOYB4+enEToSDinw2ia4Ue5j+oKFQl5Z0JGzOEdQ5h/aaETmF8S2eleuF
 8kyZPdzUwut59bNfb/A1m/tVAgFZDsq6dq63qMZjI8XZ5UpulXR/sWLyNROIBXbxSYBu
 YZihiiQyaOFGy5onWs580jVLWGg/8vFWFd1LnKSZl+5ng4KgX7myxNP1RX1I+EK+Z1Ag
 cHCxZ781uS00oQ4WAZRk6EpFvFC07jbH1YtGJnLRbRPNCJvOe8s8Jb2m0DWcRE3AOlMc
 Tsb4p2NY6lAOWbrhi+mS0URmPwtwxbHn12X7pS6VBqmfchzlCvTf7UgOwd4Cj+VN45rD
 JONQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjI2WjfUDZcnz9xJd7GEYdSFklm2o5yapMHFTmiL+0d1lvi0EE08uMWUm0Rkp4m9g7FGxbWzhgYbvZ@nongnu.org
X-Gm-Message-State: AOJu0YwDJHYDNcvYgVwgGqMlK85cQz0l0KZ6zhIIlIkSitI1ZSgWLIe1
 yxZQqz5qj3gP6fRdqiDm1H6uGIT1q7v/ZYjuZznVsNh1pSzohBErequvwEm2+896lsQvCqfJN0V
 dbEKvehE=
X-Gm-Gg: AY/fxX4yjKhlwfM+2If/QVwdaOzUPDbJhoZihbD4EF+ahcK+KcoO1h+K07ShuARLXRp
 z4MbfD8NxQAQDMNJbNdfcW+bjAepCTts3a217HHLUtlXtNquBFkh553NdeOcPN3C9WlBtxxXD4Q
 9UCi/6knThw7RTnRU04JVRzIS/Ynnii4tGWTOa6SgIvW9vfz/Rds5cEAhy2/CQ7+u9eML7c1MD8
 zZxd+KsPSNKVQMq7anPDjUS2jY5+H1WAv3YQpgnYyHjG0b//joAl4BYHREVIr+ScoI3jGTqtYc4
 fb33Me+tqqgGnUeJa67txz7qQHDOMlPXq+lF8psk6FTAuBGJFjohWiClp2XFOWJtKESnpFxirnb
 V6+73qH6MtuvPirnzkSnNKOxQb11/Vj0T680letgJtCSJbVVQdQNKarkBCGyuhOFhCe6EjZTTWB
 vclRw88tt/PWMYdcfA/cV9jQfSQkr2LoiVVfBEaLAe3Ub9sft4jmywrg==
X-Google-Smtp-Source: AGHT+IFuKP+ZmrDW2AMLilX3tCinWMge5aqiICdIqrHG5pDKS5TafSWiKUu5atXxZi8FdNWOo/GkvQ==
X-Received: by 2002:a05:600c:37c8:b0:475:de12:d3b5 with SMTP id
 5b1f17b1804b1-47d84b40816mr80004545e9.34.1767945660140; 
 Fri, 09 Jan 2026 00:01:00 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f653c78sm205527975e9.11.2026.01.09.00.00.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 00:00:59 -0800 (PST)
Message-ID: <06933b3a-dc90-4332-ba26-66faf2831229@linaro.org>
Date: Fri, 9 Jan 2026 09:00:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/29] include/tcg/tcg-op.h: eradicate
 TARGET_INSN_START_EXTRA_WORDS
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jim MacArthur <jim.macarthur@linaro.org>,
 anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-14-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260109053158.2800705-14-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 9/1/26 06:31, Pierrick Bouvier wrote:
> We simply define the 3 variants and call the correct one per arch.
> Since all arch have a single call site (in translate.c), this is as
> good documentation as having a single define.

Just wondering, if we define a per-target @inst_start_words
constant in TCGCPUOps instead of the INSN_START_WORDS definition,
could we 1/ ensure we call the correct tcg_gen_insn_start()
in cpu_restore_state_from_tb() and 2/ "optimize" the loop in
cpu_unwind_data_from_tb()? Surely not worth it =)

> The notable exception is target/arm, which has two different translate
> files for 32/64 bits. Since it's the only one, we accept to have two
> call sites for this.
> 
> This is much simpler and safer than trying to define a common functions
> with variadic or unused parameters. The only risk is calling two
> different variants for a single arch, but as mentioned in first
> paragraph, there is no real reason for this to happen.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/tcg/tcg-op.h             | 16 ++++++----------
>   target/alpha/cpu-param.h         |  2 --
>   target/arm/cpu-param.h           |  7 -------
>   target/avr/cpu-param.h           |  2 --
>   target/hexagon/cpu-param.h       |  2 --
>   target/hppa/cpu-param.h          |  2 --
>   target/i386/cpu-param.h          |  2 --
>   target/loongarch/cpu-param.h     |  2 --
>   target/m68k/cpu-param.h          |  2 --
>   target/microblaze/cpu-param.h    |  2 --
>   target/mips/cpu-param.h          |  2 --
>   target/openrisc/cpu-param.h      |  2 --
>   target/ppc/cpu-param.h           |  2 --
>   target/riscv/cpu-param.h         |  7 -------
>   target/rx/cpu-param.h            |  2 --
>   target/s390x/cpu-param.h         |  2 --
>   target/sh4/cpu-param.h           |  2 --
>   target/sparc/cpu-param.h         |  2 --
>   target/tricore/cpu-param.h       |  2 --
>   target/xtensa/cpu-param.h        |  2 --
>   target/alpha/translate.c         |  4 ++--
>   target/arm/tcg/translate-a64.c   |  2 +-
>   target/arm/tcg/translate.c       |  2 +-
>   target/avr/translate.c           |  2 +-
>   target/hexagon/translate.c       |  2 +-
>   target/hppa/translate.c          |  2 +-
>   target/i386/tcg/translate.c      |  2 +-
>   target/loongarch/tcg/translate.c |  2 +-
>   target/m68k/translate.c          |  2 +-
>   target/microblaze/translate.c    |  2 +-
>   target/mips/tcg/translate.c      |  4 ++--
>   target/openrisc/translate.c      |  4 ++--
>   target/ppc/translate.c           |  2 +-
>   target/riscv/translate.c         |  2 +-
>   target/rx/translate.c            |  2 +-
>   target/s390x/tcg/translate.c     |  2 +-
>   target/sh4/translate.c           |  4 ++--
>   target/sparc/translate.c         |  2 +-
>   target/tricore/translate.c       |  2 +-
>   target/xtensa/translate.c        |  2 +-
>   40 files changed, 30 insertions(+), 82 deletions(-)


