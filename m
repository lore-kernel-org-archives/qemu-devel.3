Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234E0C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIAJ-00089w-9F; Wed, 28 Feb 2024 06:31:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rfIAH-00089P-VD
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:31:58 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rfI9u-0001v1-8o
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:31:55 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5131a9b3d5bso700160e87.0
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 03:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709119885; x=1709724685; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nwrrCNP7m7XWANN8T5JR4dCc1oxKkbG1oGFrIaZYcco=;
 b=AL9cWXPvrbe9UPOYLLXFudUvo5Le7jDkEzGLfY6ZQDv32i8hW0+JG15XQOLzQXkv94
 J/umduB/DCZ7X8gG6+w4zfx1QpcBTZqoTCm7cOTq9psD4fdAMZzQNveuD0MGOyZcIJRt
 b1YiaC2qLYSuPuqkYaoJJ6KjZ4925PMoBnXukLW7DRBg8k7PJhuDWvGjwm2vGtiWdtXO
 xx0jmoVQsGeJLcU4sBaQjtekWV+egvhdNry/sNBTxVGLQlWkCgFdGIXdZDGVYn0F8GdC
 rMBy/DJ2jb8R1og8vXPsjIcRLEnGIAdIjCIL32O/Nkvcdi5GnfcqtOHtRgcfmUoRSdGa
 2bFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709119885; x=1709724685;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nwrrCNP7m7XWANN8T5JR4dCc1oxKkbG1oGFrIaZYcco=;
 b=bHeMvaR1WHHSVlri3A0dbDWC6RlKTsMuxvLEgFAcvbWKmv5lbrsoUFPVgFyYlQvpLM
 oLfebCtcT1MuIoPIWBQbTGBQDR/HQxIuEwVWw/hEyLWgkiZx80bfBzrvFuPKOzZsE2mg
 H+tTcxcMbhg0DD6rY1qKvmeAKdpAA04dt/6zs8MrCEu/GJySssjyA4El3QmQTlRpPPHH
 CHS/PmfoLL0FHWZ4hBt3AJQUbw8V4nNvsXhngZXKFGXYWmUqD9bWEZn6U5I6veHpxLc0
 /BYw7+Ucz8S1ERKvm7HpAuofQlgNBPjyM/oVhpdDY+pXMwTxJeRwsLcnLhkz6EuzLgQK
 h01w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiWG5IQ8bqSuFRva3pY/9kiIhXIwGjBteXyv6GZbSOQFpmtbgwsBDHFvWpCZPuNQaWttw2R8lsFF4hMae/FsV5X3umbJ0=
X-Gm-Message-State: AOJu0YxUacXG4MOiIpEqc6bEtNtu62FnZjHWe6bEmvCyOHMKCI2RfFsM
 5K4l1vVWwgjWgaPEv7p43ylYauMFVX2M3XCsTFYezYlmIvaDt2MoITKrylOtzyo=
X-Google-Smtp-Source: AGHT+IE2wbIs5c5LK5eB315tlCGdqProPWYhyhhw2RwOsfb5DdInipwnqTX0oEP9hHhHs4oo9NdZ4A==
X-Received: by 2002:a05:6512:1589:b0:512:e061:e35d with SMTP id
 bp9-20020a056512158900b00512e061e35dmr10231876lfb.53.1709119885289; 
 Wed, 28 Feb 2024 03:31:25 -0800 (PST)
Received: from [192.168.169.175] ([92.88.171.236])
 by smtp.gmail.com with ESMTPSA id
 ck19-20020a5d5e93000000b0033db9383e70sm14477490wrb.81.2024.02.28.03.31.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 03:31:24 -0800 (PST)
Message-ID: <ef28a548-6aa6-4948-8f14-f1adc451653a@linaro.org>
Date: Wed, 28 Feb 2024 12:31:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] tests/vm: update openbsd image to 7.4
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Brad Smith <brad@comstyle.com>
References: <20240226224843.487256-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240226224843.487256-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 26/2/24 23:48, Alex Bennée wrote:
> The old links are dead so even if we have the ISO cached we can't
> finish the install. Update to the current stable and tweak the install
> strings.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2192
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/vm/openbsd | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


