Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E689CC4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 19:13:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXnLV-0001YY-F3; Wed, 07 Feb 2024 14:12:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXnLS-0001Y9-IK
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 14:12:30 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXnLP-0001Ek-LZ
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 14:12:30 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a34c5ca2537so137863366b.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 11:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707333145; x=1707937945; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fg3aQvMLQImHatVBk6pgafeUA/BBuVfBJRwx3UwdUGU=;
 b=BqBVbkjvsrVols+kdZ4s4202MrJ/hmNzw+8dM1Nl3le7qfAlDOYTlTF8JpbSI0fuhU
 kf8iPmNrMJG+S0rQuhYeNDpMt/kCStRUdubu3xzkwEToKbDUmBTkZ/6EsidlUaLkIvF8
 KtQphoCDVmlL2MEGmXooOkjfcDchIhwDY0+EtaawVRWOPAxAtonkW6gN1+vQM8C1MC0a
 mHBr3E+QjxaGG/S+2KNasy6WmuxTB9CB4QOPbs5/2v1abip4eC0SxbRfp75jGALcmVlm
 Vq862o9WpnJVEQG+eB3kM4eTpWRtUjOJU9/u+sSWhueq37Z9U9JThx6P2uma1k9pJfuW
 XWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707333145; x=1707937945;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fg3aQvMLQImHatVBk6pgafeUA/BBuVfBJRwx3UwdUGU=;
 b=Bb35P6NXgTiXIf/pNUlA+THMgxKyUVlMJMEF9j6QEudCxv58AwnuyOF39fEBG0vXUG
 Je/MItkkBCE0emaqGsgv8Fd3p0zV4LK9hL/lhxrc/oIX/81rwdyopAfUijm2++m3c4Xg
 kJwbgNP7jv9fEo4uTrzReKefbvYgG6LeeJRkbT5Y4yJtEVK81b1y+CUjcEDUW8b4y/K0
 gCzXxcbhnWM40NKKKv/7Vm3LeCTdouMSTpWFx86ey1TOYuv71MYx3TgCEvIP1WJEiwwS
 ann+G6BnzLsZiRqOGbD0VRwUj4WPd1EWRUsMD1INZl02sc81g9ZXIithAozo5QoQZCk4
 mKvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpzTuzoLrT6eDM0EUauIErJY+aJOn84Xy+oM+CCJbX83i+8Ig1M1pp8UJiVxlYYVWh+zo1rWcA8cgo5isKewxagTv8dGY=
X-Gm-Message-State: AOJu0YwzWMbfM5mR+bT297HGovJ9FV4ijQgB4VPYezImcjNlNNDwD3n0
 VwaSFYwSJ8kFy2w4Y+tkkRSFRZioDppt0r6QdMGItN2lu6vXw5xLZLodtG1+JQ25bXGqPLloxnW
 n
X-Google-Smtp-Source: AGHT+IFtmj4uZQcQxVp06oBTyb8sIqmP/5unJ1034aQ8IU7rpCGtJeIGMd895+NexRBNJIsSW4+z0g==
X-Received: by 2002:a17:907:77d7:b0:a38:2ca6:5b5d with SMTP id
 kz23-20020a17090777d700b00a382ca65b5dmr3775396ejc.16.1707333143665; 
 Wed, 07 Feb 2024 11:12:23 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXo+KcFKbKISxzoPvTLUqyE2jX6r54CXQLhLn7mibp1lS5pUS4cA9EvTeUneobnmaAYRgXyEOoid6eqRtPHn9cegg2k2jg=
Received: from [192.168.69.100] ([176.187.214.82])
 by smtp.gmail.com with ESMTPSA id
 rn3-20020a170906d92300b00a3829e6015fsm1055838ejb.55.2024.02.07.11.12.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Feb 2024 11:12:23 -0800 (PST)
Message-ID: <81d117a3-ed1d-4023-a9ce-128729ec2e73@linaro.org>
Date: Wed, 7 Feb 2024 20:12:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] mips: allow compiling out CONFIG_MIPS_ITU
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: shentey@gmail.com
References: <20240207111411.115040-1-pbonzini@redhat.com>
 <20240207111411.115040-8-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240207111411.115040-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Paolo,

On 7/2/24 12:14, Paolo Bonzini wrote:
> itc_reconfigure() is referenced from TCG, provide a stub if needed.
> This makes it possible to build a QEMU binary that only includes
> boards without a CPS device (only Malta and Boston create one).
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/mips/mips_itu-stub.c | 26 ++++++++++++++++++++++++++
>   hw/mips/meson.build     |  1 +
>   2 files changed, 27 insertions(+)
>   create mode 100644 hw/mips/mips_itu-stub.c
> 
> diff --git a/hw/mips/mips_itu-stub.c b/hw/mips/mips_itu-stub.c
> new file mode 100644
> index 00000000000..4cc82b8461f
> --- /dev/null
> +++ b/hw/mips/mips_itu-stub.c
> @@ -0,0 +1,26 @@
> +/*
> + * Inter-Thread Communication Unit emulation.
> + *
> + * Copyright (c) 2016 Imagination Technologies
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License as published by the Free Software Foundation; either
> + * version 2.1 of the License, or (at your option) any later version.
> + *
> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>.

This is your code addition, so "Inter-Thread Communication Unit stubs" /
RH / SPDX GPLv2-or-later.

> + */
> +
> +#include "qemu/osdep.h"
> +#include "hw/misc/mips_itu.h"
> +
> +void itc_reconfigure(MIPSITUState *tag)
> +{
> +    abort();

As Zoltan suggested, g_assert_not_reached(). Indeed this path
can't be reached without ITU, TCG won't emit anything and will
call instead:

     qemu_log_mask(LOG_UNIMP, "mthc0 %s (reg %d sel %d)\n",
                   register_name, reg, sel);

I'm reluctant to add stubs, but since it helps you (hoping we
can figure a clean way to split architectural access to hw/ from
tcg/ one day):

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Regards,

Phil.

