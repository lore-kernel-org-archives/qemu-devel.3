Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE40C531D2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBg9-0006gJ-RZ; Thu, 19 Feb 2026 16:35:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBg7-0006Xl-63
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:35:19 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBg2-0002Os-2w
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:35:18 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2ad22a5e245so10255535ad.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 13:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771536912; x=1772141712; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BaLSPP89/32S397zyo29jCcviyVPjCNdknb/dD02mvw=;
 b=uEuGS5AY5AjbzS2t2hgTVqjNU+nUkmvz9PXFO3674tb5frrSGahAtgkLgGcsd7MX/h
 QsibYKTutm2uJGWVrLs9/1GV3xLL04ZGRvaRiKm38m3y2fD4+mJFs+yD8ofs7R8U9uLH
 Oc3s9AaD5YJRYomDgUSJ2C21+76M2jk1gMqzA5fQo9EPOnmaQlYn8OXFahoqK5sW1oYC
 lLM9VDLoU1H39ZM1CCkY4Q0MM5wk2bJ6+dshOwdhBk7BCstDclQ+sIBAh8rk7JoLp++/
 O8R7L7P9Y4L3s3hzRFofLz0rACFchURD9mFCFebTfiN0gDDHyPMH6qDMSoaXrlF/KdZs
 nuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771536912; x=1772141712;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BaLSPP89/32S397zyo29jCcviyVPjCNdknb/dD02mvw=;
 b=jgTf0HAORIQy9gVO1iUF1EculO+XwxH58NaJKusiFKToPO+4kDHeB+6MQAxNrRI/gc
 ZWYFSPe4oRj197ICyMYi6VYPY8eqHWt8ZZh89Ao5e9Jwh8pzpnaqPY+71HeB72caf5dI
 lyKajdi0bu62iptFf4ZDkdoeWZsyNpmu5PONS8qhERkMeSCOFkAx0zpYOFxQ2c2Udf/s
 YvrS+0SXWigwy1RirxBISQenYMd+lBEonv7/QX1seYMsjBM8FtGrsnlt3UZPOIGKMwen
 2d++gbUR0k37kRLCjZLamBerk7oW8NKV9R+qkxpfRLCVZtYWAC8dUBQI3C2jHZxpR+bI
 4heg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXu+NZi+3+TjTj91NW3Ek+1ViR5AHDzu6sxwNJrtc0icf4hky6WuHY2awtw67NxhbKvI2IfZB3IgFYp@nongnu.org
X-Gm-Message-State: AOJu0Yye+tNypQx8/cAVmwdlIGy17vv4K2oDqRL68XNQ1RuJT/NzH9Ih
 C0tGvA+QoyNuyhEbBASZJRi5F/8E3OW79zVJ9i+nvAsLXeEdEx8ntce8tn/5cpMWou0=
X-Gm-Gg: AZuq6aIY93dfA4wm74mabtjw32qZaR0yJn9DL5WnYpIH0tVBeyfb3Ic7gqlKZGbYu1r
 7P+sPFPFR4+Ru+6GuKNFiNxd0pDCjDFfPcIeLOoOUFagXGIPsd/jMDYWnUU46fMIbC2dLzjzElM
 DNv7f6f7K0w4X5fkha96Z16ZpfSRyDzUunO/gcrXHnVc9btxbD7bfJGdXjA9+KOW3yRT909xiXO
 Cn6FAx5mDlE/2ldblciJcPF4WIVENpgrse5/a2x7OzYoPBh3BEOZe5LEfr3dG/ZBMRf8G8GRChl
 JJWNddLL/wY5iHYjuIcKx9yXTfSutBz7cH374KW9pO7IBw2cCSlgzGpDW2GtvUBWQycFqeEmJOZ
 0Bnb4t1HSFegegX32IQI57ng31M/WCZ+CC9wAM8YA4QRmBKnHT/j5kasgZVlJkIW3EcNorStwXs
 MJF5P1nIv7gXAK6QHPSeIaFCKM6Vfa5WzhaZonNjcISkx1WtEJ4ia07K1phDohtrGnaiN4
X-Received: by 2002:a17:903:32c5:b0:2aa:d201:25f6 with SMTP id
 d9443c01a7336-2ad50f9bcb4mr65701565ad.45.1771536912528; 
 Thu, 19 Feb 2026 13:35:12 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad1a9d58e7sm182774265ad.45.2026.02.19.13.35.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 13:35:12 -0800 (PST)
Message-ID: <2d79ec4e-f6d3-47c1-99c8-cc5d351e1394@linaro.org>
Date: Thu, 19 Feb 2026 13:31:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 31/50] gdbstub: Remove ldtul*() macros
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-32-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219191955.83815-32-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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
> These macros aren't used anymore, remove them to avoid
> further uses creeping back in.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/gdbstub/helpers.h | 6 ------
>   1 file changed, 6 deletions(-)
> 

😌
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

