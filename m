Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9633ED2FEC2
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 17:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkmcz-00078u-Av; Tue, 27 Jan 2026 12:13:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vkmcq-00074j-GU
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 12:13:14 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vkmcp-0005Hh-0a
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 12:13:12 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-82361bcbd8fso870511b3a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 09:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769533989; x=1770138789; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JlsyXi17RSlo5cYovrH1MAYo3MzJfBQoDqER7aF5foo=;
 b=FLFgTCuCCEGWICueJJTZoQtf8Oab0i+DqzVZ/pOzNWyT3mdZfnCPlEqg0XlGlpYzXY
 r5JVI3cozqQNbaozV4SgqOIdWT3SvP4zjp5QmVr1nAkcDKWUDbD52PFHc94kdETYUjHx
 TzaMEezb0/EHryFjWNUqKTH9Pov+HQgcwwRrAOKLhN0Ofx8oo+9dInUlFGLw8/hFGHH3
 blllxgcRB0yZ8JCvJx2EWnk0mD+rXGGe/yqI5L2g/ekwqG9fyLZPWNvwtx5rLkZMNMOm
 kjZ5sjrljW9vs0GP0n3g+fIzJ6HFNjg4rynPINgPctiKrsnXbdzoVp3kk0VFTxICtOF7
 wvxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769533989; x=1770138789;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JlsyXi17RSlo5cYovrH1MAYo3MzJfBQoDqER7aF5foo=;
 b=Y/4kKhjaxXzSFryKP5K3YOTPtsqGxs00swXnTVE/s09WggFTRc9zZ41qRfZnO3dvii
 ir+ih3x5YWoVYkrmT/H50CXXDrYWnkE73MOu/jQmiTnAtaZTIatkXdGRpmMCZlfJt/lb
 0FPz5WIG73jyHr8TPUeLuBRUzErOU3+iQov2o5OfuvLVh7t/GKaWLk3hKTIT6hmUfA81
 vEndMXpuPmzV9msmukBc/8ZF9Lg4CLZU6sRMXHt7L3d3qrn6gq7hfXa3P3vLAJOhEP3f
 IDYAdxfD/6l+GMhBkVnKyCMEFwm638XIXUPJbC6ehBg/7MqTVgzotJZODL3o6tVZ5aEn
 fCfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPWR8XKQAIwq89/PI7jEvVf+GwpOU0H7kLBZY2Z0/PirZaqjLBS/JnQEcmNo4DJ/l7RZJO1unC/Xm/@nongnu.org
X-Gm-Message-State: AOJu0YyNWg2KyZqvaZxQ8pJMhAXLwkeof59fRzYFS4aJ72KrGj/dTipl
 3M2yXl5TrSsb7oDmgs4Wvkua4Jx9CM8X82LbOr26FoHwYzZ5Hv9/56nSkhEkD0eA4fx94rt4yx6
 nU0P8
X-Gm-Gg: AZuq6aJiFBGAM9d10hRBWybf6TepzRTwHZWtsYDjFTsYOvyVoiIKBa/9z5Q4XSTFBA6
 YOPqP0zL4LcVtcXuYvdMwZOcar5wj1umSA8+lxNcVCVdlMuKQo9em6YWRPeRI4I7bzF5KLEDsJZ
 hDL4M75PxaBFyavoujQPVhGPf4fy+U2TXUvoK+J8HCcVg9ZyUiT/9ExOJxu2p2x79kkDf0QjLyD
 oYvfU4pRUlUO2xHhfuuhyLa+D3rToXGCYKQpMWOEQJInLwYJuKmFlt4KWo1AR48pgHShPpjYlke
 PQAHF576kn5pInhIDPSvlliLqpyrdwH5qx7aDTHcTZ4RPPK9cx28gMySNKqQgxMmSo8MFuMYtdA
 9EZieWYUxb2jxdpQJvoadfHcIlZ1md8c1KfxbtxjdY+Nzxo48VqYm7H12Uw/iw4kF8kpDEfrVxT
 84+kgPZZ6QKKMxNCf0PZ3L0CE/3PgUzxmjU035+V1R//Q6cg8mkcMcIqX9
X-Received: by 2002:a05:6a00:1388:b0:823:efc:21b0 with SMTP id
 d2e1a72fcca58-82368f9b772mr2320668b3a.0.1769533989278; 
 Tue, 27 Jan 2026 09:13:09 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b1ee43sm121306b3a.4.2026.01.27.09.13.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jan 2026 09:13:08 -0800 (PST)
Message-ID: <4aac3da7-f556-40a5-9881-c3c08fdf7c61@linaro.org>
Date: Tue, 27 Jan 2026 09:13:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] docs/system: update FEAT_BBML[12] references
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20260127145555.3070590-1-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260127145555.3070590-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 1/27/26 6:55 AM, Alex Bennée wrote:
> It looks like the features were renamed to include the levels at some
> point. To make it easier to match features up to the Arm ARM update to
> use the full name.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>    - move level 1/2 into the () section
> ---
>   docs/system/arm/emulation.rst | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
> index 3f30ea5a30e..e0d5f9886e1 100644
> --- a/docs/system/arm/emulation.rst
> +++ b/docs/system/arm/emulation.rst
> @@ -26,7 +26,8 @@ the following architecture extensions:
>   - FEAT_ASID16 (16 bit ASID)
>   - FEAT_ASID2 (Concurrent use of two ASIDs)
>   - FEAT_ATS1A (Address Translation operations that ignore stage 1 permissions)
> -- FEAT_BBM at level 2 (Translation table break-before-make levels)
> +- FEAT_BBML1 (Translation table break-before-make level 1)
> +- FEAT_BBML2 (Translation table break-before-make level 2)
>   - FEAT_BF16 (AArch64 BFloat16 instructions)
>   - FEAT_BTI (Branch Target Identification)
>   - FEAT_CCIDX (Extended cache index)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org

