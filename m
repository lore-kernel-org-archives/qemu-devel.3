Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E82FF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHSm2-0001yB-5T; Mon, 27 Apr 2026 16:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHSlq-0001rt-8X
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:41:39 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHSlm-0004oa-Cf
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 16:41:33 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-483487335c2so105016435e9.2
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 13:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777322488; x=1777927288; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o7ZyTBqVXGKPXMZpE7Qzs6I7dl1gZeQBBGt+h4y9LoY=;
 b=PS1IdJe/mL1sfjNXVPv8im3NtDo2nPwWeioGYzvXOta4JuGovSW4QsNMC3vCF2Nq6g
 a0pc5etwk+BeuEJX0lBhGAMyZqub1akO9oJOEY1L/jgZ6HgNgS7uEmjxJSluCOMz/Jev
 2YpOwQQfYBEx0Eo0P+vpMN61w7WlWXDKQWT7MYN43zvgjh8bbYN1ZVt/0VHB+if/nQwv
 UqqYxCXGS12R6P9rVtf/T5aqfWbYeEt63PMOkZ/TF8wI8daXQbZ87Z+1GdOasimzW2/w
 /86frL2N2Blto1HdR6YjX6MDOzFhrg3AwBhtXuzxn4g61pq4/J6Oz1V/DZ6IR3bc7Ckk
 l+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777322488; x=1777927288;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o7ZyTBqVXGKPXMZpE7Qzs6I7dl1gZeQBBGt+h4y9LoY=;
 b=DL9Jqn53ybVB+9M5d4A4pfCg69HqLsefQ5l7bp8II1NwFY2P2LholZCbbJttdHefvV
 6NQPF415tCLBQB0H+hR4VIOCmfUdBH4VEKqvlU1Q8Vr3Ik3A7t4fd5NEwL3q4aYzJmhR
 0KqOij8+KoMiSTjBwaAJ8c9JUGRYMoQaVj82rS1e0zUHO30OeYidtYzGNNsMy8YKgKMW
 vLWsaTO08v6V5PSwbtNAWGpSj3niQtpFrauXlpIUvoKpRmYtivFC5mQdKBPIR+dQZ0me
 k0auyLQW20G0y+BMrlX2wdRISQpHyXJwYdruZg30Ym4y76eXu13AaGO5FL4wY0yTOjIo
 HQHA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+3H4G2Bst1HJfLP50GNdK7A1PF8Fsh+k+CZN6h+hOrmJPGQm3BK0TxOQX42h6Unh+rBNwhiwS0nbXC@nongnu.org
X-Gm-Message-State: AOJu0YwcG4F4iIOhjpu0XPNcJs2Mvb6fiiHfITKTSH8eAxZaLURhPUM8
 8kOQpvi3jpA6tnIJugAsG6JHnaVR4vIJpJ+hRSpfVrZJHbGJHOF+OVkDnODTiGQkXN434/LOuem
 jSCc3XeM=
X-Gm-Gg: AeBDievW4jQt3Fb9R5R490vLwfHLUABMxofSth+3AFRAxFZwmzlkfTnEIYmMQRxT2U5
 x+6cv/eoSULOtYf4IQK2TiN5h56JJCp15eBEaTQbpux9JCTg1nCBr44K3STow7kLq0GNSgoY7yG
 ilzy7wK65LMHndpoWNbIk2k6tY/Fi4RyF+w/f4H1fGkHaY1/4FS+5oebKbRiNMdNALn1HNQcf8m
 gbv6TwX5+lXZ+tWUsGkBZO5uuCF55HsNzhe9oPu9ueWvsFCOThlfAZBoqxW6UCEfhdXhR2Lft4q
 PCpH+DhGlXeXuZMcNlH0uorc1yv2FesNFqUAoTUPx7QbYj1gGyJRggU+SrjRul9dwAzXYisD+Ro
 xx3z06J4h+vfXELjNmcGwOqj5zaihAtVyv3HWIo5Vn2048m/zQ71bG2gfb6rneFn150UWbVY3hp
 cGFXgbjKayaW90rvTHzo2hoaA8IOAXpsvcs2u93toP1mjrvgU9BY0dK2ZB74B2YyqNhlpN0A8zx
 MxU
X-Received: by 2002:a05:600c:6304:b0:483:8062:b2f with SMTP id
 5b1f17b1804b1-48a77ae04aamr3814155e9.6.1777322488290; 
 Mon, 27 Apr 2026 13:41:28 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a77b29487sm3919015e9.13.2026.04.27.13.41.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 13:41:27 -0700 (PDT)
Message-ID: <31169a57-30c8-4fbd-b9a3-44f0cff2d622@linaro.org>
Date: Mon, 27 Apr 2026 22:41:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 28/84] fpu: Drop parts_float_to_float
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-29-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260426134002.865628-29-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 26/4/26 15:39, Richard Henderson wrote:
> Use parts{64,128}_float_to_float at each call site.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c | 37 +++++++++++++++++--------------------
>   1 file changed, 17 insertions(+), 20 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

