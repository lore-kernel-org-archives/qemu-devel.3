Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE09C98315
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 01:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhdlz-0001WC-E0; Sun, 18 Jan 2026 20:09:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhdlr-0001S2-P5
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 20:09:32 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhdlq-0001x1-9x
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 20:09:31 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2a0d67f1877so24920365ad.2
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 17:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768784968; x=1769389768; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IY5CnqZ06otKRRaU6lsInyAGKZvinYGi4/YlAoDSRmQ=;
 b=kSdy10PHiyoe5j64l/N6Q/OZZnrBNLeE6tdcExWJl9ov3TRIO3afgsHSFJhLDDpQb7
 DpKBcJz5EYCWNaHiYcjPGT/xVS64xmyhwRhCZ/QJHueHsOrWEJ97wYQLEOBWIect9lSo
 CeuC1HYi3aZjuIOlnKIdaBe7v3KFxgDtLV1m6C8hAngeiVL9cnpcgCFih7LpujlxRXo7
 3O7KIQfVKmTdx1D95cijPFu5VR8ADtIe5yuQauaxtvYCjiRjCi87OHvrrJLbiYKwnxLa
 KXntLTRF7u0yGuZS1EeY37/ZJdp/tFi6iQ3uCJ4OLHnPsU5nfKY5jMrpaw1ih0IskuqU
 j4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768784968; x=1769389768;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IY5CnqZ06otKRRaU6lsInyAGKZvinYGi4/YlAoDSRmQ=;
 b=vuNIam0kR/2pEkFtov+cmfnoFOfDGsMipHIooV4hHpFNDSGy1cdkIvF8iok8TC+Pqo
 IAO8lthtXTfYGAYdvi+9IpQybzoT6cU2K3Q3xyXBQKysYNijI6Cr3GUzUVBJOI3XKhpl
 dyQoGFonJuq8ywexKQvebSOMoJbGfAA5AOdTmxATjYcyGQ89TyUdrc7M4GKPZ4tyZfvi
 UtsLTK9mBiyt0Sk1S2YVGXFeV9SCvHXTan5eUx39u0qVJKrXBHl3INYyugWMKJ9WTRLl
 A0kQROJWdGLYjMRyUJtMeehfMPLAk7X/35vcB5/q4ai5nkxe1D5m0cUj3EZPwniWY49K
 6D/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCLU6bsSy2irb0cx72Hmf5ofG3ybXV5KlaGZ1ziJ6zbUpFle0t4xdBFfl40kDhr4yoqd9IvMYYvBFw@nongnu.org
X-Gm-Message-State: AOJu0Ywzlpoh3u+OPuJmUSaS8rlO5CvL7XQop3G4caQPPXrZlsda79Hk
 LYIwO3DVDCwK77cAyJjXcWFPTgyjOOg/7GPkKghUuESg81wESAHitQyiSW9RIP3daF3UKZJogmt
 RjO9DljITpw==
X-Gm-Gg: AY/fxX7RZD/25FZ8V8+jHJ8lKFMxKHJTThiq8Y8cjsaGQeIq5Oyb3Az7xFFwbTm5+BT
 8Hc6fkaAjCk+m+uVRWzF/Nk213YktzsxQMU9N47HWpNo+F0eciJHrq+hREDD9N92uA2I/c6WPAr
 KeK54GNbCfETb6wLXJv9VKfOCywVXuPNa8+MCsdZ8gqN3xIDQfQ0m2Gj2JPqjQk/Qoz8fLUqL43
 WBK/lg6FHLB1RkDZEWMiLRQpYdYQP9abVtcg2RSjhUtmX0PUagwnuVvH985FV9mju8hzB75/xjS
 wRilwHdYVGfycUWicFHWwLQIOw8MrFq1FBK62NbbEiMN6l1e4Uhsy3cWPL0rDO+Bksz19EpEq3T
 x7XWlBK4VJK1ApbAzTIJ8jj60vMlfCBH+wvkGo3o6fAh2W/zaxn83+JP5TSlepp+CyF2O3Cj6S0
 OzWuBaOqXKx/6L1tLqZXI7sboutBFMBnUf7naQbtOR
X-Received: by 2002:a17:902:d490:b0:29e:9e97:ca70 with SMTP id
 d9443c01a7336-2a7188beff1mr84012255ad.25.1768784968181; 
 Sun, 18 Jan 2026 17:09:28 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c5edf32d1f1sm7278159a12.22.2026.01.18.17.09.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jan 2026 17:09:27 -0800 (PST)
Message-ID: <37159f1d-b3c2-4686-bf47-331092e3ca85@linaro.org>
Date: Mon, 19 Jan 2026 12:09:23 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] target/i386/tcg: cleanup #ifdef TARGET_X86_64
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20260115113306.126905-1-pbonzini@redhat.com>
 <20260115113306.126905-7-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260115113306.126905-7-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/15/26 22:33, Paolo Bonzini wrote:
> 32-bit TCG opcodes produced for the i386 target usually looks the same
> as 64-bit TCG opcodes produced for the x86_64.  The special one that
> needs extensions is 32-bit TCG opcodes produced for the x86_64 target.
> Make all #ifdefs look the same, like this:
> 
>      case MO_32:
>    #ifdef TARGET_X86_64
>        /* code using 32-bit opcodes */
> 
>      case MO_64:
>    #endif
>        /* code using target_long opcodes */
> 
>    default:
>      g_assert_not_reached();
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 11 ++++++-----
>   target/i386/tcg/emit.c.inc  | 18 ++++++++++++------
>   2 files changed, 18 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


>       case MO_32:
> -        /* For x86_64, this sets the higher half of register to zero.
> -           For i386, this is equivalent to a mov. */
> +#ifdef TARGET_X86_64
>           dest = dest ? dest : cpu_regs[reg];
>           tcg_gen_ext32u_tl(dest, t0);
>           break;
> -#ifdef TARGET_X86_64
>       case MO_64:
> +#endif
>           dest = dest ? dest : cpu_regs[reg];
>           tcg_gen_mov_tl(dest, t0);
>           break;
> -#endif
>       default:
>           g_assert_not_reached();
>       }

This could plausibly share the dest selection code and then use

   tcg_gen_ext_tl(dest, t0, mop).

> @@ -1236,8 +1236,8 @@ static void gen_ADCOX(DisasContext *s, X86DecodedInsn *decode, int cc_op)
...
> +    case MO_64:
>   #endif
> -    default:
>           zero = tcg_constant_tl(0);
>           tcg_gen_add2_tl(s->T0, *carry_out, s->T0, zero, carry_in, zero);
>           tcg_gen_add2_tl(s->T0, *carry_out, s->T0, *carry_out, s->T1, zero);
>           break;

A fairly new function, but this could use

   tcg_gen_addcio_tl(s->T0, *carry_out, s->T0, s->T1, carry_in);


r~

