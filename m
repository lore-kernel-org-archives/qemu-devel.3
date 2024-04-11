Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D968DC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 14:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruvql-00017r-40; Thu, 11 Apr 2024 10:56:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruvqi-00017b-QT
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 10:56:25 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruvqf-0006IR-MS
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 10:56:24 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-343cfe8cae1so4978596f8f.3
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 07:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712847380; x=1713452180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JLhzofJJmUcfk3U5SxiHtfwYLmME0/8dxqXUqvpisNw=;
 b=CPpKbjE6MLgzsB3T1YNeQqAZx7ywTk7DJRB56QFNpQWphpQAnhZQvrYH0i66MVxBCU
 YqgiJEtcn/OLdJFoPvExXmCk7FA1NGJf0vYeIcfLQ1HjRpucawY0t4ll1DyCA+cR/tE+
 qWTUbY4a93xvAHrqQyEnjF1QLsDImaFyIrOUZMnjObiXIqszd5+cMH3kT8R5DNt5QAF2
 +j1eutnX9+vsH3ltVSG+bCU8itpyfp1anZrSJk5jrO7qrnW+DVOeO65mYbdHr13z350T
 euGpLXogZzZHNHpEUKmw2XrNjlcp1mna6n7wOf9oyBivenYi8seP63gtrqqq6Kh4mIvr
 HBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712847380; x=1713452180;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JLhzofJJmUcfk3U5SxiHtfwYLmME0/8dxqXUqvpisNw=;
 b=MCbeLPQ227tsyDYHJjbE/JbyZak7WnfARIINGAM7oHZcsT4DKovRIeDWJYW3LioQvQ
 zemCpKfqzkyK60oLMbOuw+SD66vFNPwLQuyHIz7T0dfzEQM01TGyemxiXnE+17Q908/7
 5wbkiB2XkPrGDW283rciIuzGpvqIZpERu47md+rTT305IOjp1/WDQaAJvhNj6WlJKUnO
 twk1EloLxJf4zOu+TMqz32Vd9Ag/DNX0KjtrebouAnMrz5cFuZ9B+wP2v2SQ5Wd2m5qJ
 fTO0LJNdIJngoaiB5LNsJ4818QUUz6XVgNoBtkJ0PpFJD14X7FhAgOTHd/nS3x4Q7goB
 hkIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe4vkPXzv544mshTblrpW08+bty1jE5NL0VltZXjnO0QRVeMCOhO6U7qIlLoPJVIYq3aRjNOgOgx0AiU7MIoQ8jzZ7xvQ=
X-Gm-Message-State: AOJu0YzBmNZqlUFXU8lbB9B1TqhOZnU1J3x0XDMJNJ5D3C062OqC4C5M
 mvxFNs8XyMMOkdb4P9xhsaO2WzzSzAM1aPClkJMfApAt9LzCWrsUTCus4IjJafE=
X-Google-Smtp-Source: AGHT+IFz1Uvm14fPMKBS5p5SBHKIH4JCWtSeG2AebLupfjf7ndS0HdwT3DRA53CNRvfaW70+itx43A==
X-Received: by 2002:a05:6000:104d:b0:33e:6d6c:8503 with SMTP id
 c13-20020a056000104d00b0033e6d6c8503mr3734889wrx.16.1712847379577; 
 Thu, 11 Apr 2024 07:56:19 -0700 (PDT)
Received: from [192.168.120.175] ([92.88.171.159])
 by smtp.gmail.com with ESMTPSA id
 b4-20020a5d4b84000000b0033e786abf84sm1946490wrt.54.2024.04.11.07.56.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 07:56:18 -0700 (PDT)
Message-ID: <6a848564-c40c-4ad0-83c4-a380af354fa2@linaro.org>
Date: Thu, 11 Apr 2024 16:56:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.0] meson.build: Disable -fzero-call-used-regs on
 OpenBSD
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Brad Smith <brad@comstyle.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240411120819.56417-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240411120819.56417-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 11/4/24 14:08, Thomas Huth wrote:
> QEMU currently does not work on OpenBSD since the -fzero-call-used-regs
> option that we added to meson.build recently does not work with the
> "retguard" extension from OpenBSD's Clang. Thus let's disable the
> -fzero-call-used-regs here until there's a better solution available.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2278
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   Note: Given that we're close to the release, I think the host_os check
>   is the best we can do ... the problem does not seem to trigger in all
>   functions, only if certain registers are used by the compiler, so a
>   more sophisticated check here seems to be too fragile to me right now.
> 
>   meson.build | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/meson.build b/meson.build
> index c9c3217ba4..91a0aa64c6 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -562,7 +562,11 @@ hardening_flags = [
>   #
>   # NB: Clang 17 is broken and SEGVs
>   # https://github.com/llvm/llvm-project/issues/75168
> -if cc.compiles('extern struct { void (*cb)(void); } s; void f(void) { s.cb(); }',
> +#
> +# NB2: This clashes with the "retguard" extension of OpenBSD's Clang
> +# https://gitlab.com/qemu-project/qemu/-/issues/2278
> +if host_os != 'openbsd' and \
> +   cc.compiles('extern struct { void (*cb)(void); } s; void f(void) { s.cb(); }',
>                  name: '-fzero-call-used-regs=used-gpr',
>                  args: ['-O2', '-fzero-call-used-regs=used-gpr'])
>       hardening_flags += '-fzero-call-used-regs=used-gpr'

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


