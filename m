Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A660EE7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 15:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMqq4-0003hm-Ow; Sun, 15 Dec 2024 10:47:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMqq3-0003he-Jg
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 10:47:23 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMqq2-0001Q1-2M
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 10:47:23 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3ebb4aae80dso662473b6e.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 07:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734277640; x=1734882440; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BmNYLUaH6mEVud5jmQnGRTZebamaWroljQ+ErzG0bT0=;
 b=m9sIC2fi5QTuj2VQAjPFw+d0i+c9g4nTC1Nf2UWCkPu16FD6ANiKyriaueKjiFZ6eD
 kMzp7ul0Ll2lOsgesKFt/wuA4BhdO9xXOl/dmT8O73An09J3F0FgKgwANeidgqGwrT4D
 RhceZr/8w7immvM30eoESsBupzBBoDmCI00OvTGFjXiSSkn04/nehru+76Gg89bIDR2K
 zYYvAmcNSqG9ke3GdDw/ROXGBmscPXem1EKbzgY30BOByUc0pU+Qpmu5Bj4l+4MBRnUg
 Du8YiQQNlR5/UDYwipp8MClyYx+f5sbCkP2Dt8fpe4wZZdth5BwQqNMSTvWNORiUirAD
 xL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734277640; x=1734882440;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BmNYLUaH6mEVud5jmQnGRTZebamaWroljQ+ErzG0bT0=;
 b=cocZCczeb0lLrM0mtdTjbVITssI7BulGOJbXLONyTcaKM/b6e6QucUD6jdwc7spTvt
 HeSMRgsVk6m/D94wy9elvUoZ4dvsCgJ+sZiujxL64DX4fQ92F1BRJGvysE57orPXJ6HQ
 ON2q7E2z4SDjvAWZNiWS8RHEtZQOyQHaxLCfGI+jNCY3AIQZTtK3LbdmRpXhUXVoSTU9
 SpOOngekno99LOTaLhRjcRBRJ++mT8nWrzvpxq77ryd69Q19m2skO6bICiD8PsS90weH
 9fM07LaRS28irjXA+3R+AP8MjZ5MUd5YgtGN8mOEODcTTowr1088Rj7HOtHfw4wxuVcd
 bO4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX+YNb4Bp/f/MMYK7rUp3+ooB3vqrmz1FjxXCmDK8eb9Mwe/Ch/wmDXCB+Ac+tgWN2lYOEVC1WkkU5@nongnu.org
X-Gm-Message-State: AOJu0YwgRrbTeq4AF6dBljYW8DbEn5VJ11/1X6Iq+m+cJdNu1BrClS/l
 jYGWy7dQ3zMJDNRNOO2wRE8SQRy6Eg0XVA2gK4Ch7q5+CIsiLnrRKzeTdE4IXL8=
X-Gm-Gg: ASbGncsSuW7H4n83wDRp10RGTd9Qy8Ahk8z5BpA2PV/rHL+rbOSrPusoK3f+0JyTPoq
 44PkJzQOIV+li91nOdrb+YjwSoVGC48IwssHn8O9B+x3Br7bVUZ0BsXV/VF0TINGtNtM+RJOR9p
 8jUgEkafE8KklIe8P9k33LncQXPnN9kWbJOLrd7LzdUwD7lgDkI2GOCt+ttR1FESJvXmvBV4Qh0
 bdPVwcO65IqL8wPrmFBrJMxtKeuXJsJ46IX50GFeFTPRo3GyHsbgXVDhfPC2at6OYOWbMBLES1e
 9Vy+BRfJwwxRTn8GSsXdC+eOG+pp+eEsixw=
X-Google-Smtp-Source: AGHT+IGdVQFUx9svHJ3Wpijw92hujIuUcNHP0/cyylMGFO3mqwjEifJrbSUaOyW8sQU2lJkg3LFd/Q==
X-Received: by 2002:a05:6870:6c14:b0:29f:de75:d178 with SMTP id
 586e51a60fabf-2a3ac6b912dmr5161971fac.19.1734277637797; 
 Sun, 15 Dec 2024 07:47:17 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d269e0fdsm1241591fac.29.2024.12.15.07.47.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Dec 2024 07:47:17 -0800 (PST)
Message-ID: <7239a31b-cc5a-4510-bb66-d13759bf5d10@linaro.org>
Date: Sun, 15 Dec 2024 09:47:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] target/i386: avoid using s->tmp0 for add to
 implicit registers
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20241215090613.89588-1-pbonzini@redhat.com>
 <20241215090613.89588-14-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241215090613.89588-14-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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

On 12/15/24 03:06, Paolo Bonzini wrote:
> For updates to implicit registers (RCX in LOOP instructions, RSI or RDI
> in string instructions, or the stack pointer) do the add directly using
> the registers (with no temporary) if 32-bit or 64-bit, or use a temporary
> created for the occasion if 16-bit.  This is more efficient and removes
> move instructions for the MO_TL case.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 23 +++++++++++++++--------
>   1 file changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index 4b652cc23e1..8de506927b0 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -504,17 +504,24 @@ static inline void gen_op_jmp_v(DisasContext *s, TCGv dest)
>       s->pc_save = -1;
>   }
>   
> +static inline void gen_op_add_reg(DisasContext *s, MemOp size, int reg, TCGv val)

Drop the inline.  Otherwise, yay!

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

