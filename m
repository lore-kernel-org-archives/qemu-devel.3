Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB60D0D16D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 20:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdZqa-0004Se-UZ; Wed, 07 Jan 2026 15:09:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdZqU-00049Z-K2
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:09:32 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdZqS-0002LZ-5M
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 15:09:30 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47a8195e515so17908815e9.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 12:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767816566; x=1768421366; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JZ7L3Pf178vwFuizAo3o2FgCHyg5vMUBww1QiJ0Hq3c=;
 b=H9KzQcsS14V1j/RI7zRfta70hnVxl4Y96bjXXL6WNwc7rM0tr0EKVC2sG4jtKfQtum
 vAGX3pBYS02KGYceMLwDpD8H6QSUR3dHsEo4P1nK4lPCOjrP8ib/eJei5CQSLAJlKs0c
 EROrKBt8ppUbdm7dTcEH5TouN36LEsF9C34RfCKGXFN22cbnlqMWdjH621yZ9HIiwT4U
 p5ZfoBIZf4oZh+Z/jUhVc4SFrjaVEgCOv5idUDH1IONEwqhi/FC/1vzenhxnELL2e8lM
 7ZQ0win6Xl+8/gdLlsdp/e4vlZliHihyJ1TFzubBbigYXPuNyuF9BnMTUdU9gAhA9njY
 TDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767816566; x=1768421366;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JZ7L3Pf178vwFuizAo3o2FgCHyg5vMUBww1QiJ0Hq3c=;
 b=gNAjL9JWsYGIttepZxgUEU+cCr2ZC6pyz1yaeQiMGohyey8VmPHDI0lh/zXFlUAlWL
 M6ikLAUU4yJZkvk+q73c9YIS+MkTRFvzn/v9ixjCTPpNfaCBarr8Qwkdc5Qv71IVBYB2
 EHZ6q+vc5Qh7bHh4ZrCfJzh4wNtcyW6t5vxitsVeQxa3IZyLO/xUQR/2UXjYsVbrRC0h
 L60tGhJtZiDDvIdVDk9aNWHgWr94j+VJTFalC1Er3lV1gdWIc13R+SBeOeM5Vy1IZ+WA
 qJS+dyvJOlRFV72SFi/ZNQYl2dUR3GOmCS24eeICQL+S0BuWCsYYCX9oS8gKbtsvqsXu
 vssA==
X-Gm-Message-State: AOJu0Yx2UIxFsQxazqRPzJfII6thADrrX1cN+QZdT5fXHjK3ZER4OUfD
 yO5KuQc/++B/Q6Sh9+4im9Oj2Og6AcWQq1BI4uWwkEUqg/pW/IcglFZnnQGnl4QTEIdyqRdAGs/
 72e0Bk6k=
X-Gm-Gg: AY/fxX4t7LnI21NI2lkBsMkZGMH6WFIpCaS1JRwHGwB4URFN881uZ6gRlvvEwTXc7vj
 Ex4N4QwS1w3GIkz1lE1SMYWeF/dmwb4d2tXVytEyBmi0SncO7sDKmVPsn81UaxK8mmwSWd5HwkK
 Ij8MWK2bNvf3BPXL3TbbW0gn341oPlMIMETBDtXJN0OxaWumSRUbqbfK/AEI+u1xRlsyuf++Q0d
 O+Gk2cHptqYcv/7ija/YW96tFH1I0X/En7NqV6qOaMdMGAN0rr/lkVFfjk6WHe11LG8kKgtZZ1g
 m7kutzBcB6Yc2o7gkw52iBAwBTPKdwmT5zBP1MEJhPhAv93YE7POcX/ydGMt9rHKhoL9DXkSqVB
 nyTUewroQdBEFl9qeyTIA6HbJjZ6PXn5v7uNoWK26pAnjHo0J+97OxptXfHk7JyaY2sqQsnious
 cLyqFrGjZs/u/8AAbQL4qj7wWZ+QRCpn4zJcbAvY5mhATVYHsgn9gX2w==
X-Google-Smtp-Source: AGHT+IHDU+TAjiZjunK5ROmrOlO650ARChGdt5hWHVa0PjK1J7vDPI6PuMKd4+Oz6nNX3nysNiEzYQ==
X-Received: by 2002:a05:600c:1e1c:b0:477:561f:6fc8 with SMTP id
 5b1f17b1804b1-47d84b0a211mr39126245e9.5.1767816565867; 
 Wed, 07 Jan 2026 12:09:25 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f41f5e0sm112120065e9.8.2026.01.07.12.09.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Jan 2026 12:09:25 -0800 (PST)
Message-ID: <9eec8c4a-c6fb-4c47-8701-1afec420f5b7@linaro.org>
Date: Wed, 7 Jan 2026 21:09:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/18] target/s390x: Remove unused 'gdbstub/helpers.h'
 header in helper.c
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Thomas Huth <thuth@redhat.com>
References: <20260107130807.69870-1-philmd@linaro.org>
 <20260107130807.69870-6-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260107130807.69870-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 7/1/26 14:07, Philippe Mathieu-Daudé wrote:

Updated description:

     "gdbstub/helpers.h" uses target-specific symbols, but we don't
     need it, so remove it.

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/s390x/helper.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/target/s390x/helper.c b/target/s390x/helper.c
> index 8d1e03f6768..a6c89ed0af3 100644
> --- a/target/s390x/helper.c
> +++ b/target/s390x/helper.c
> @@ -21,7 +21,6 @@
>   #include "qemu/osdep.h"
>   #include "cpu.h"
>   #include "s390x-internal.h"
> -#include "gdbstub/helpers.h"
>   #include "qemu/timer.h"
>   #include "hw/s390x/ioinst.h"
>   #include "system/hw_accel.h"


