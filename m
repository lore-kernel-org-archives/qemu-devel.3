Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B763C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 15:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOfcm-0004pa-Gu; Tue, 02 Jul 2024 11:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOfci-0004oL-FV
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:40:53 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOfcf-0001Px-Gg
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 11:40:52 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2ec50d4e47bso42177971fa.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 08:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719934847; x=1720539647; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=stF7WuGpcrsQaV3ZUFr5l5WCk/9RTmiuVw2jUbyk6xk=;
 b=Qei5Sh4lqNuvjWCj8vTmP2yRlZ2GxHJ6Jv7pavzbUj1onSSg+18cEQU9uOY/lZGa95
 IcVYYlHcsAT470VkPf8FEY44g9fOw1BROkY+LqnZemakc1kKPewSBa5ubtKTydMELXTr
 yN4S75dykFnp8HcpjnBULlu2M4aMfBWzynZV497GPOXQ3QaORIWxYAy+pAq3D/OmiQar
 /w+KBA3kdRZQTE3Os97f24+5KU+mqlBUqSHwswP/wg0/Awv1Xqm1JazB8IMrjlfC8L7U
 M4y7q2VHc4+rljinoq+wPSBa7NVqhGIeHenk7XpiUZjycwbLVPdaF6KI0cAh4P9xkGCE
 rlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719934847; x=1720539647;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=stF7WuGpcrsQaV3ZUFr5l5WCk/9RTmiuVw2jUbyk6xk=;
 b=kpQlJiMle02Oq2qvvGnAk8VS14aNZtyFSC48hl1y3gmV7NliUcY1CrYrzVa0C3Faq/
 T+De4ewSIqIYzbhPKk7+5LecX8oahsaTN683r1l4rghzgwuUsf8Wn2g4/L93KnzxibLT
 nw2FWd+89KQbrvKbkK94QtZQkdAcYeKK0aPpIu5TH+wEB6MJ/XHfwL2WjZVjAO57oDfI
 IuGIFJ05aRqi7jswr7t0fEGPnKv2HKFZ/LGcrMwKAIaDQocppvdYH7ALQI/s/rOoGETU
 3M2W7P6sKMUzwe1/cgrg8/BRx3bQ5oxb12TnqGXzttQdy+MZaD1G/C2bmf+PLGvCKqEl
 mXYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfFzfTx1ySdjrXxFUj0FgrYpvJ94FWIcewH6XThhdxpO56US4qcp3PFD6um0A70vcOzqmXcT00tod8kmVXVrNutRAFdSk=
X-Gm-Message-State: AOJu0Yzood26PTkWHO8oSr4sMN9xSWNzHVHf3UwlJb+o/STQGQPk114u
 tVyAjZ0OWSc2ILWcJ8yhZJXrMr3mBrFqnKX7vpEQTZVuH4HRZ87nxXf95v07NdRh0diNI21g1bi
 6
X-Google-Smtp-Source: AGHT+IEuNf1jMCVzFwnSd5LWtj/oPDsf16fL9kkdV77XvNfIkJ0JarULKNWHBMBoqVpm1A3i/wbT7A==
X-Received: by 2002:a2e:a912:0:b0:2ee:4e67:85ec with SMTP id
 38308e7fff4ca-2ee5e337908mr81930911fa.5.1719934847322; 
 Tue, 02 Jul 2024 08:40:47 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af5b61bsm204781685e9.17.2024.07.02.08.40.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 08:40:46 -0700 (PDT)
Message-ID: <b72e40c9-c2de-487c-a9ad-a52c1f286d77@linaro.org>
Date: Tue, 2 Jul 2024 17:40:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/char/pl011: Avoid division-by-zero in
 pl011_get_baudrate()
To: Zheyu Ma <zheyuma97@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20240702152750.3017426-1-zheyuma97@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240702152750.3017426-1-zheyuma97@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

Hi Zheyu,

On 2/7/24 17:27, Zheyu Ma wrote:
> In pl011_get_baudrate(), when we calculate the baudrate we can
> accidentally divide by zero. This happens because although (as the
> specification requires) we treat UARTIBRD = 0 as invalid, we aren't
> correctly limiting UARTIBRD and UARTFBRD values to the 16-bit and 6-bit
> ranges the hardware allows, and so some non-zero values of UARTIBRD can
> result in a zero divisor.
> 
> Enforce the correct register field widths on guest writes and on inbound
> migration to avoid the division by zero.
> 
> ASAN log:
> ==2973125==ERROR: AddressSanitizer: FPE on unknown address 0x55f72629b348
> (pc 0x55f72629b348 bp 0x7fffa24d0e00 sp 0x7fffa24d0d60 T0)
>      #0 0x55f72629b348 in pl011_get_baudrate hw/char/pl011.c:255:17
>      #1 0x55f726298d94 in pl011_trace_baudrate_change hw/char/pl011.c:260:33
>      #2 0x55f726296fc8 in pl011_write hw/char/pl011.c:378:9
> 
> Reproducer:
> cat << EOF | qemu-system-aarch64 -display \
> none -machine accel=qtest, -m 512M -machine realview-pb-a8 -qtest stdio
> writeq 0x1000b024 0xf8000000
> EOF
> 
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
> Changes in v2:
> - Enforce the correct register field widths on writes to both UARTIBRD
>    and UARTFBRD registers.
> - Mask UARTIBRD to 16 bits and UARTFBRD to 6 bits in the pl011_post_load
>    function to prevent division by zero during inbound migration.
> ---
>   hw/char/pl011.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/char/pl011.c b/hw/char/pl011.c
> index 8753b84a84..ba5f7cfbda 100644
> --- a/hw/char/pl011.c
> +++ b/hw/char/pl011.c
> @@ -374,11 +374,11 @@ static void pl011_write(void *opaque, hwaddr offset,
>           s->ilpr = value;
>           break;
>       case 9: /* UARTIBRD */
> -        s->ibrd = value;
> +        s->ibrd = value & 0xffff;

LGTM but could you add a definition instead of these magic values?

Similarly to the ones in the top if this file:

   /* Flag Register, UARTFR */
   #define PL011_FLAG_RI   0x100
   #define PL011_FLAG_TXFE 0x80
   ...

   /* Integer Baud Rate Divider, UARTIBRD */
   #define IBRD_MASK 0x3f

   /* Fractional Baud Rate Divider, UARTFBRD */
   #define FBRD_MASK 0xffff

Then use these definitions :)

Regards,

Phil.

>           pl011_trace_baudrate_change(s);
>           break;
>       case 10: /* UARTFBRD */
> -        s->fbrd = value;
> +        s->fbrd = value & 0x3f;
>           pl011_trace_baudrate_change(s);
>           break;
>       case 11: /* UARTLCR_H */
> @@ -531,6 +531,9 @@ static int pl011_post_load(void *opaque, int version_id)
>           s->read_pos = 0;
>       }
>   
> +    s->ibrd &= 0xffff;
> +    s->fbrd &= 0x3f;
> +
>       return 0;
>   }
>   


