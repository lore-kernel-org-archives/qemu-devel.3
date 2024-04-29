Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A3AC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 21:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1YDu-0008D5-GL; Mon, 29 Apr 2024 17:07:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1YDt-0008Cp-7r
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:07:41 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1YDr-0007nt-Su
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 17:07:41 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6ece8991654so4645401b3a.3
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 14:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714424858; x=1715029658; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/MUYQvKVGq3TiHbJXL/NJASQeqP98txuJS8qw0laL6A=;
 b=yeF19G1x9iyFw4jk0RbKtQEstmvPcKHMQP7kOMbZuJ66/Tyb6sI3piWmPh9XMEQdZt
 r1V2O7+hbe7G6LHoUjpzdyWDdNQRIo8zvyou310ep5Mf00eKlJLs2wJzyrglSq6i2D0k
 aQH6tE6Otix6S5GXmwSfxx95Q20VF2ZOJkkdnBoQhraXw/C6sU5rJl2Obng2kyfwwkw2
 Gy9HIkpH+UreCWisp6inylWONF3VeYrv9lZlFZHLspNMvg35gpuoP1z9jk5zMm28OEsf
 zx+cVFOq5TZIs1L5NQsu91Y3ZIrvvcjgQkl8Eaj4QDbMADZBQ3r2xOCQzjnBDPuQsejX
 AYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714424858; x=1715029658;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/MUYQvKVGq3TiHbJXL/NJASQeqP98txuJS8qw0laL6A=;
 b=uqEAQnih/LjxWgcBEA81iabykWzFlXuFwflx0vMBFUKX/z3wfr5xYMO3p6FcgvM/NY
 rSHVZdB3m/LiqRjjslr+IyKH/fOfQlrcqizmYCXzMXxdN8IcPegvau8Kzrywssz1yhcv
 lr8wanUgFOWxlwRf1zqKnCX8TOWyuu5oRTUO8B8kjmgKN+Ub5b2JItTdp6nlxTaRISkp
 wiCNF4ELuP4tEUn0v3FSq9/Z+vLaQpLrxV9MkxFVJyHJJmGacfV81Nrvg4//NbWbZiwo
 xWh7KW2VOhX0BUdBlos3KKKIWEPhSGMgJfpn08PNVTEaF4I5qkWapfGWGgLuAYe7RsJg
 aVqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5E5RbljBVlB8kH/2UdFrr+kcDHTFu1USvqBeOt7yE8Rhw0r7xLFTDAbbgHFAhBEFFCD8eDusYmDEUREUuliS/2hxkKkE=
X-Gm-Message-State: AOJu0Yx2f4IvyPcMFlO2nyORsvCPCho87TvcKOEdpCBkueW7GGPAVkFr
 45t9cDvLh5zJd7EKQ6N6Omw3KQ6IXV5j01IUkY8aM4VD0H78hmXNpUZ7Hno2Lr4dZs22OAjXZKU
 s
X-Google-Smtp-Source: AGHT+IEHwWvjajOPFra3k8FIVKVviQypZqIHR866mPGfE4DbY6im6ax0dyZnLVe3INCEH9VKrNa7mQ==
X-Received: by 2002:a05:6a20:c887:b0:1af:50f3:75dd with SMTP id
 hb7-20020a056a20c88700b001af50f375ddmr4047365pzb.19.1714424858442; 
 Mon, 29 Apr 2024 14:07:38 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 gq41-20020a056a003be900b006f0da46c019sm17523543pfb.219.2024.04.29.14.07.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 14:07:38 -0700 (PDT)
Message-ID: <62dde7f6-df8a-440a-a1f4-0063d18af6f6@linaro.org>
Date: Mon, 29 Apr 2024 14:07:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/24] accel/tcg: Restrict icount to system emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>
References: <20240428221450.26460-1-philmd@linaro.org>
 <20240428221450.26460-24-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240428221450.26460-24-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 4/28/24 15:14, Philippe Mathieu-Daudé wrote:
> So far we don't support icount on user emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/cpu-exec.c | 6 ++++++
>   1 file changed, 6 insertions(+)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

