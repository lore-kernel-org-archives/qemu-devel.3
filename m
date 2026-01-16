Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0766DC982F1
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 18:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgoW1-00034j-Si; Fri, 16 Jan 2026 13:25:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgoVx-00031h-Sn
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 13:25:42 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vgoVt-0003Vi-IR
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 13:25:39 -0500
Received: by mail-oi1-x244.google.com with SMTP id
 5614622812f47-45c9c505fe8so511836b6e.0
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 10:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768587933; x=1769192733; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JptwofF7oBpFgcmE3kuUuDUG2/pClJlDBY4U8YW3c+E=;
 b=wc9YAkKI458HaU/lkFiSY016iphlOzw9hP1ouF0F6W2edSX/55o572JtwfZffduqxE
 pxrDEClDq4QWWt4k0+20oaqaRU5siItH3fMeqEXALuo7EypBtnfdmxAcKEQWPhhddH4r
 gzNhnflYS+iZvHYW+WkpwJhcF+h3B0vOMt+Z0gi+Bg7AIT5ga5cqBQjM9DEIHNGsQsGv
 sO+uKzW5HL0DtHnoOzA07QuDo3UlD52pp3UTfwODGI1t0MLdTuyELWke/jIsR8DY5S6z
 /RaVBIaWtWXkWtO9ZxIirs9WwbHfekVzT7SZygs0Nz1psWQwZvBPIMd5BujCHYbvsVwe
 bhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768587933; x=1769192733;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JptwofF7oBpFgcmE3kuUuDUG2/pClJlDBY4U8YW3c+E=;
 b=Bc/rnEW4L+JJmLVPgux9SsUEtwZ7uyoFO2htzxM9ZKm6LH/KlgJG2kHDtM+J+g53xO
 FM2DdTdn7bYbFSpHZ2AetS3eXv8q3WCSdW8zUXWCUHJiHw7AKU4Z3W47SuAL83LMMRtt
 34vUlEwUIuUpNBNlm5gVSeeIKMpSItUV4fHGSvnfntPdUFCZ7aXq2AtCwIX6ao7njWwB
 LJAm3gEhyYS1/GvN2k4ADBrTWFyA4MFFowekTFFPpiGe/dplVRT0E58e7OB52A80XPXv
 JUJqffVVkMf9hyoyib2ihUSBC38/25KpWG55fXs8s6HtrwWMt5OFJfKHyhL5oF5Zz/mo
 1bHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7jUmSa75pElFlEGlaqesfwKHgmgD5U9bvS2GedlwFWWPCj0v6ZwSQl53tKesANF/DlriKbDyQtMHH@nongnu.org
X-Gm-Message-State: AOJu0YxERQt/HWgcz/ITcNflNjmD7JtHPR8RpwgV9W8mkCZUAkRb8qTp
 e6smIJ7v2l/V6n2ljRWEZtNqltQycAjITdHGhB3Fb73IzaoFIzES99Yv3Q23FApolK8=
X-Gm-Gg: AY/fxX72U9K31Lve7zhXSlTTPiP1PlGp7EMQwS5hC+eLncOyRr7QVK6dXBXf3a9fcoo
 1SXvBZSyVCuy1l/lsXb0npZYLNS6YjqJXi/2E6oVPWd0k9DFkOwsuLy5RqXGi9FzZKDAkzj+B/B
 7n/foBBUAypYAT2D8wjzUX/kHZCNFVlCErNNcvrgIN4KbupeXmlVC0QzmwdtwLk/j70xagGNXWs
 ld8D+YGR8mXFHeyHsiIz/L4S5rUsScr3gQwWmR9VwvanhdJ+gdpFCCkjhX9TwUVtth7+08dcBvY
 hCkPyymCUCYyEM5mDhNc1Fx22gJQqoSfRZHOUMviooI44uwkaBQeOEYW/EhEtzqr/zUXvwCrihd
 CTBq9e935HmwZwYnOUrjfg58ZNSMg+lfatUj03/IjitTbT1iiogmwG3U5HsL3JJSWdD1vK59N/o
 103sRGRnQtedoiWvcTKk7DicqRAJ73HrEyZNGpzbN2GRriX3LyvcdouRPU
X-Received: by 2002:a05:6808:318f:b0:45a:6d59:44f5 with SMTP id
 5614622812f47-45c9d77f4b8mr1338179b6e.30.1768587932745; 
 Fri, 16 Jan 2026 10:25:32 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-45c9e03e82esm1660746b6e.15.2026.01.16.10.25.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Jan 2026 10:25:32 -0800 (PST)
Message-ID: <8fb45c60-3975-47e0-8513-d76f9e2bfdbb@linaro.org>
Date: Fri, 16 Jan 2026 10:25:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: Do not try to build module for empty per-target
 hw/ directory
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Frederic Bezies <fredbezies@gmail.com>
References: <20260116131817.38009-1-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260116131817.38009-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-oi1-x244.google.com
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

On 1/16/26 5:18 AM, Philippe Mathieu-Daudé wrote:
> In commit 83d5db95d38 ("meson: Allow system binaries to not
> have target-specific units") we allowed targets with empty
> target_system_arch[] source set, but missed hw_arch[] could
> also be empty when building modules.
> 
> Skip such case, otherwise due to commit a1ced487549
> ("hw/microblaze: Build files once"), building with
> --enable-modules triggers:
> 
>    ../meson.build:4034:14: ERROR: Key microblaze is not in the dictionary.
> 
> Fixes: a1ced487549 ("hw/microblaze: Build files once")
> Reported-by: Frederic Bezies <fredbezies@gmail.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3272
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   meson.build | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

