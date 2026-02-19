Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C060EC531D3
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:35:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBg0-0006Qk-HV; Thu, 19 Feb 2026 16:35:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBfz-0006QG-2Q
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:35:11 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBfx-0002MH-91
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:35:10 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a929245b6aso13540075ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 13:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771536908; x=1772141708; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V7R3e/e4LS2ryFQoDPSWr49ncIDOfVevFBz0q6M0arQ=;
 b=FrS3wgOAErPeGNkSRPTJt0GpKo5Vw2jy3XtYwPEY/wim5zDZOnadeGapTwRoCxNCtW
 OJqlT7gdOZXn/FdzPebej4p/3Xft2E1CWF7fAw5HvWn7hwWPwb2g444Ys4lYNz8Tjh/8
 zuRAKfBB+PO+5UyCbYvk2e7RjjUoT+r9tsihpIysmUQXldaids1V6WwDDEE9OfOBkkfz
 zgW0THn588TnBxbI2CFugmAVjIsAz7fgeAao4sgvn7wxGfu/KSFeeJ69rVG6F3m9+JTP
 u2Wd8e7mZ9Y9PAR0n/FVxjoEWtan20lahjtaOlz374NlD4gG9bRQNuC9oL5hunYiFV1m
 fBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771536908; x=1772141708;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V7R3e/e4LS2ryFQoDPSWr49ncIDOfVevFBz0q6M0arQ=;
 b=CaZOb6CUzxGP71+R1BhtKef8aX99yc9He0rSUN6VQd4+hdwj9USCTq9ok2ZG3PqRqW
 wvBLkhxbkmkhAh9rkDA8t8ubgJzDcQVtlAXTPjN4LU4WXOiu9YRQeV5p28Id7DIzwDbY
 QQnQEdH8J6Ml6L1RpKAwft+U/pNe2tjA6+Ojmk9T7jLChPnMF/TH9gLwZR0E+xPmPK5r
 6hObUNxMu8gx4NUROZzSfGDJ+0PixBiVDfGvlwd70kv2VbU73x7xb4tCREiZ5DyLsF9f
 Dx395J4IeeYwLwJHNBtFGX4g5O7mod+6lwbMdbqh0MzeF9IoM+MiX4D4y3xIJHMWxxEp
 lg9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeMNoUzSfd9KB/agS8mMzJJ/R7ZILSvu7zQcobrhjQdWazLEb0P/c0psYgtw6UjZiIRsRCBznitMYT@nongnu.org
X-Gm-Message-State: AOJu0YyepwMYjsZSW0eyDufwmtvE1Zm13owzkpHFvNQqO2rphSyiQxW2
 llevfj5bHBrU+IL6MPTBhfaVPLuWfitFuo5/niFnSAtB3DZtbaZAhqIBM3kBhfSD97w=
X-Gm-Gg: AZuq6aKM1RGcRJ/Zx2askISPLqkJwjqDMS3iNb/Q6IEiBEZj3WKZdkqaJhPo6pX0FEQ
 Odi9XAkWEqyBZqGgtxDeJjWfLNGuDROQs7fDaELNXxykGpq58Z3W3ucnNRbWgq+I5GMwvN6xpQP
 tLtVrQ+1vDNyxkqY5WkJYUjNX56v2ccB57nJiaBdTDJHESDP+HPNg9e3tYr01EyuEdpWVYmPkww
 sIQeHSelFiXB+BUPnfQwiQ9vgfQrC1uzjUVOt52nkUgp0dR+Ph1XP946r7/AGxdvteb02aDHhFz
 K82LxEITyw8fxBtXGqZlPHLdzMgjQx+ZdCBNpWVyF84qrLhnEvPB84tdgSIn+Akmdf6v35wblCJ
 NJD1XpF9t7hEKbk7Rtyy0cVg0MWOcdUy+qa9nv5J9W8EsoJbSrDSiYAmVYwJIJoO1kt3lZXxZDk
 CUGRC1QBM9XNKk5adffs/6FFjpvNFoVWMOtZUDzs4lMbwofHcaeJUQ4GqvA6MtEU4ZV/lobTKNn
 gx0cFY=
X-Received: by 2002:a17:902:eccf:b0:295:62d:5004 with SMTP id
 d9443c01a7336-2ad174a34f3mr213061375ad.26.1771536907699; 
 Thu, 19 Feb 2026 13:35:07 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a9d58e7sm182774265ad.45.2026.02.19.13.35.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 13:35:07 -0800 (PST)
Message-ID: <0602beb0-c975-45fb-bed4-e0fb6c0fe033@linaro.org>
Date: Thu, 19 Feb 2026 13:29:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 25/50] target/ppc: Replace ldtul_p() -> ldn_p()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-26-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219191955.83815-26-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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

On 2/19/26 11:19 AM, Philippe Mathieu-Daudé wrote:
> Prefer ldn_p(target_long_bits/8) over target-specific ldtul_p().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/ppc/gdbstub.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

