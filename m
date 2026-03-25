Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4A41093168
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:40:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Vxc-00026s-3F; Wed, 25 Mar 2026 17:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5VxQ-0001vE-SX
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:40:09 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5VxP-00010H-9W
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:40:08 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2aaed195901so1309945ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 14:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774474806; x=1775079606; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lWXxLGhATpKlrf1x9K0p9Ij/kwFdcv4UIx1YjsEaQYg=;
 b=JwjtutWsFVlIo4+9X/FMvmf+BsoKgRgLQq9nQZWPfh7cZSOuONfWitdASoeFYYOszY
 fJSqPjx7gTaa2UvZuCBlMeY8tTL0r4EAYyyluE+DSKADji2z4BPmARvH8q0MvL7bdTcc
 y92srww2GtGtX0NJ5wmFiaoSveYfD/i8P66HZOIpNToasPosc6DUNuX42yNSlKxy7d0d
 GhGtPgnKxBbv4NwgXcbFh+Ldggpqo7Pb5mK3tMNtJemFkge4A51UnFRqQKLa5YrAmxrM
 /M+v5vR6jtMR7y0yeBolYVHTQ5mqDWzE/qwGY8qsvsSyk1JsGt+K2g2qjL/XLL1uU5sX
 sIpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774474806; x=1775079606;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lWXxLGhATpKlrf1x9K0p9Ij/kwFdcv4UIx1YjsEaQYg=;
 b=OqSqkVWJGch2FXge4MiM/3P37ee+yyu/YC72AKEqAyHWJmz5aYFkRBN6UEcXhOewCQ
 igt0Eszd8KQlkFhTB9a9242XnoVlaTwurShSxuOX/65e0v3gdAnmdDIl0rdJsQ8WDEbS
 FDJ0zaClfQy8p3AKIC7DVbZOoGpjrGZ+R9jh0J+O6XPHzk6XMhTYeM2r/Exha0CLiPz8
 zg6hNZ5D+7MGHiTL7SAgfRxgKkOHmT/9jU2CpaMsZ/7nYlslJ1NvwsxzwINvH7E/K+eb
 ZHfiEjE3NY/9ffTThbZW4oyR4e0RHXtvA8dDZ/Jg5JQEUryauZsunc9ZbqThTIH+74PR
 jKMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSTRJaZydkB+QbR0MIbttYaEw9AY6q3Urzq+mnwqiJCDYYbhwdNyDR62v1vJuj1G3x5hOE+kcZm0dH@nongnu.org
X-Gm-Message-State: AOJu0YwJIhNtAftAqW2Mtxz/js5SrXDEAj4hrRGNWbhx8Y8seymtooW4
 MhJNzOaNTE/q9StsM2hHb45wz/PwWq9/6Om3ilk6k+2aSHg8h9AYB8n+EESmY/onJjD9nM4jJzO
 gKfBvzPs=
X-Gm-Gg: ATEYQzyLYN8rhzeWUSmKQoipAazA9MqgolFkZ3J1UFGzmCdu2idsT9XNUtlh++3v23U
 d00mdjbe0tjsiVwemisRKU3O+tA8rr5MMBt+LrUxkpCor0W4ESTpFc3Kb23Ibc3xz1merQOg9qx
 2fWb2LHpfTtfHm8IVKM2r1q5td4pW0r12ZjW9CzJoi2j5zU2YVldBr6gT13u96tWv7AMproEZ4G
 NFh8HNxiGjZRXhlnhpAVpWmuATI0Q1R9alj6mwdlsFn/ihSYu7kqT3u2h5J0T5VvrN0nZPZmcVd
 EASeNQNMzSjn2Kcg7j8Vkwslycx0WtIJqQB/P9gXW+nIN+7kWiFFLtJnRzdTZW5SivkLC2I1Rco
 YxbAiFbJQRuOJUa5hPUWitf2e/l71B12xoGtHSye4yn+MuiBcgikZh4rfgb3t7tLtbgN9p4nD+6
 6z9/nkI5qWgGjIZuCsArc8Ei1YfsrPsrM+fdk9fJlNhHrO0jOCkrCdgCxpk1sd32kFB/nz
X-Received: by 2002:a17:903:1b0e:b0:2ae:6092:8d93 with SMTP id
 d9443c01a7336-2b0b0af58afmr59813495ad.28.1774474805702; 
 Wed, 25 Mar 2026 14:40:05 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc795f08sm10210795ad.21.2026.03.25.14.40.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 14:40:05 -0700 (PDT)
Message-ID: <59a072c5-a18e-4a72-9554-aef5769bb317@linaro.org>
Date: Wed, 25 Mar 2026 14:40:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 04/10] migration: Remove unused target-specific
 macros
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Alistair Francis
 <alistair.francis@wdc.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Anton Johansson <anjo@rev.ng>, Peter Xu <peterx@redhat.com>
References: <20260325211728.89204-1-philmd@linaro.org>
 <20260325211728.89204-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260325211728.89204-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 3/25/26 2:17 PM, Philippe Mathieu-Daudé wrote:
> Last use of VMSTATE_UINTTL_TEST() was removed in commit 445d3facffe
> ("ppc/spapr: remove deprecated machine pseries-2.7").
> 
> The following definitions were added in commit b6c4f71f508 ("Resurrect
> the safe part of r5274") but never used:
> 
>   - qemu_put_sbetl qemu_put_sbe64
>   - qemu_get_sbetl qemu_get_sbe64
>   - qemu_put_sbetls qemu_put_sbe64s
>   - qemu_get_sbetls qemu_get_sbe64s
> 
> Remove all as unused.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/migration/cpu.h | 13 -------------
>   1 file changed, 13 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

