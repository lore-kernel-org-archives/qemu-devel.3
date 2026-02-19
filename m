Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F821C531D2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:38:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBgl-0007ju-J9; Thu, 19 Feb 2026 16:35:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBgN-00071Q-AJ
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:35:35 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBgF-0002cx-L3
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:35:35 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-82318702afbso1226668b3a.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 13:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771536926; x=1772141726; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wUkFswav51O16XAxkGt2jyXLI65fEb9VToaAnt33X6k=;
 b=ua6YcbaG7RtW5WsRHQknyQxDJBnziE10Kz8gEJD8efiTPgHU8735vlWd+iq2+GZsij
 RCrnLFxu+Km+efBRwwm94a9wmRnyNb+GkI89sYrlORPsqkD7p+0WPLgs2NYGELfNVIo2
 h595KXb3fnjUUENn7Zj0LFnKiOTtH6X4I8zrSR19nlF8tGeFok1CWQCOWw4bzDpfIWJG
 G/mMjd8v6pyfBNgm7uywNXU2wpLRHNtarDVqYTD1M0jrfByA2u9s/d7q4tSwmMFZfTJ7
 f2dP7ovYI6Q+OWgjsOnbwPm5H1N6bFXimm7G9sdjjsrLNd+o2VsfTLkCzIS6to4j/TXx
 cZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771536926; x=1772141726;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wUkFswav51O16XAxkGt2jyXLI65fEb9VToaAnt33X6k=;
 b=F0vAqSU1nWG4HWWyw/YFQGw8OMChtVjmDyV6ob3FH/NFKy9FSvqatWrDzC3kGN2HCC
 nxjOXYglj5wlOnn7DaTtHB0p5aXfAivOpSxahjbU6AWs04499uwB5/XgzPJOfoOVJcQ0
 AUNPeKOVbwie3XMFx2OwXs7xCcy+NJp2nm7zCNuMjuThvS119QERGxhrVL9XYoEIBYGi
 fWQOVugPlIs+wCN3JR1ALyFwFfWrgiKVr1ekdRmneW1BAuR3nkU/L17DZQ1Z4IRdySDk
 1fq+rkSIcqFP05rZUuuvHtbaa8wXx65spBr2yg3Tknx+Sfx1A5vpt5DggSxGYVjQ+wgA
 6bvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5t/Mamfnpja7+e8wMKsLhxyDJyYmkG9F9L8qe7mMxeuiFV03QjzZbgJoJWc7p/uFM8l1h6YAHrx+4@nongnu.org
X-Gm-Message-State: AOJu0YwC0Qf3jFlbErd7R/EUeoSMte7OHu3accHHyTZt5ZfkrnhYIzPy
 UfyLyIN5kZZjzcZcJXYqvZodQ/Fv2qKyv++IsMjmCvoLXSEhhPjRQQRBL4xrfrrz7Vo=
X-Gm-Gg: AZuq6aJeQL5/Hc1uTunAe1u6mLgmZTTykarovRtcH3rU9cBy/RtZnUyupP+yNxGVbUY
 zjTmH4oLx7UVlV/RA0DHlbU5Bnxwffu8PtFdnCuTNOlqIHX0cEjPqEufpx6jWQzRWTjb3E4l6os
 o1jTseO1ncZhdJZcrOBJbIGYUmW8v0olnNEMkcBSzHQP98zAPu8bYUw+wV4mKMAe/Q/LSEaADp3
 3aepUclPcRskCzY/NZ7GhYX9BUCreRftMdZiEPElrK/kSYQ01NHBnanqfA4QIeEI3SaTI8mRpGG
 bolMefawndY5Q/IzAbYc84KfdI8QcP48ka0QuWWn49M7xPWooepqRgodSon/nbjpfPb+JT4lYV2
 1pMTPQpRMtr+lVCtrE9tvz7Z37efQ0/GEhH6LKhnCfTMC99Ys0U1ZOTDv6uY2buW/gbRYkDJpVU
 NHvk4GUaxitX1Pt1VT/13UjWGnhXgZ6yQnjkp0z56M3FUBxDvq1SxBoYUmOke6tHB83XVM
X-Received: by 2002:a05:6300:800a:b0:394:f4fd:b746 with SMTP id
 adf61e73a8af0-394f4fdbcccmr5376413637.65.1771536926035; 
 Thu, 19 Feb 2026 13:35:26 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e52fcff01sm16619125a12.2.2026.02.19.13.35.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 13:35:25 -0800 (PST)
Message-ID: <e6f86df6-e8c7-4241-9714-3841ffebcfa0@linaro.org>
Date: Thu, 19 Feb 2026 13:34:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 47/50] target/rx: Build 'gdbstub.c' once for system
 single binary
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 Yoshinori Sato <yoshinori.sato@nifty.com>
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-48-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219191955.83815-48-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> There is a single qemu-system-rx binary, but by moving
> 'gdbstub.c' in the target_common_system_arch[] source set
> the resulting object can be linked into a single qemu-sytem
> binary.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/rx/meson.build | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

