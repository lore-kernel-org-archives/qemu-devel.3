Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC50C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2024 01:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxzQ3-0005Rw-UB; Fri, 19 Apr 2024 21:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxzQ2-0005Qm-54
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 21:21:30 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxzQ0-0006at-Cr
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 21:21:29 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1e4bf0b3e06so25254655ad.1
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 18:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713576086; x=1714180886; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ktaCVqSjMW4ppIuapMWDatztRfZY0vrB52vRBjIg96Y=;
 b=WAjyd7PY1nCr7RF9oNGOV8PA/x5GO2125gtMTOgljuoO2zLj4wchLFXjHKoMVvC0Wq
 bvXbDMSgib8OKmyFJYv7BgvTCHBinSAZ/b4OLHfKd8UA3jBVrW3qxDJb324e2eBN0vO9
 rCpX4vs4cGK2ZpYe4tQ0zyiPLJx7lBQBF31vb2HjezrHcFCjiET408LwVM7m9ukGXoCK
 59ClUR+EZSswobIQ0f7yuwH1Uhpga0QmJDZ5jqxjPmG5Y6sGlOCzTsUjr3J9qD4L6E58
 62pqXCdvmDnOEZFVYytzxdpWDJMDZKrTIcQs6daIl07mfOTOY6TXrPIeU1x2fWvhE70y
 TBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713576086; x=1714180886;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ktaCVqSjMW4ppIuapMWDatztRfZY0vrB52vRBjIg96Y=;
 b=RRLi/oVJCRNM+II5dHOVp+cErYHSKp0Jcv6wQ4dR228dol/ST3gXZ2FKVHbnvHW07E
 tygWzOm0sZUsyYioMmATOV30kzC6NiJKZo0om3lmkicAYoNXXKsOkfV/vwlEUw1MbssY
 FzxS7TYKu4BD2GRkQXFQxXDpFuYuV7TbYZl9VjAlTZR/eRX9hCAsyzlLXTB9rBR548Z3
 bZoYewP23k6aJlFbU2HuWvBjuDHb2+fbzwNzHuIA25qKQtJwv9+ph196fKFvDGSsmgDa
 XR6zu2TKSuID1VGEdMY6bkjyP5B+qFyqzM5wMvLer0AupMHJLReOPv95WeCXtEX2F9L/
 PDEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWal1SASv7sCq1fpLkbv59CNVm4bfEazHRS40ObkOQcnZVmWGgSzp1I3wATIlMfHZRFIezVJFVCvN44uD5nGeNZadwIrW8=
X-Gm-Message-State: AOJu0YxAP+mpqLnomO8d0lBeBaIS8cnsCXpauMbTJW09Z4+sSSeqYipy
 lyH1XV/UvUIDMn+e7w/P3Gzuv7nHyxUE7TfGUjCIfDbZcMx0VEkIQyz9IiPYKhs=
X-Google-Smtp-Source: AGHT+IGlrwS+Av1uXA3++tvQ2oKswfRMord1NCtWbQP3kjCwMEvNLSoo7RofS/EPfbv+lqqrDNXpEA==
X-Received: by 2002:a17:903:22ca:b0:1e4:55d8:e753 with SMTP id
 y10-20020a17090322ca00b001e455d8e753mr4604332plg.10.1713576086029; 
 Fri, 19 Apr 2024 18:21:26 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 kv13-20020a17090328cd00b001e0a28f61d0sm3993044plb.70.2024.04.19.18.21.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Apr 2024 18:21:25 -0700 (PDT)
Message-ID: <fefb7b6b-29fc-42ee-b62e-059512e881e4@linaro.org>
Date: Fri, 19 Apr 2024 18:21:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/translate.c: always write 32-bits for SGDT
 and SIDT
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, pbonzini@redhat.com,
 eduardo@habkost.net, qemu-devel@nongnu.org
References: <20240419195147.434894-1-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240419195147.434894-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 4/19/24 12:51, Mark Cave-Ayland wrote:
> The various Intel CPU manuals claim that SGDT and SIDT can write either 24-bits
> or 32-bits depending upon the operand size, but this is incorrect. Not only do
> the Intel CPU manuals give contradictory information between processor
> revisions, but this information doesn't even match real-life behaviour.
> 
> In fact, tests on real hardware show that the CPU always writes 32-bits for SGDT
> and SIDT, and this behaviour is required for at least OS/2 Warp and WFW 3.11 with
> Win32s to function correctly. Remove the masking applied due to the operand size
> for SGDT and SIDT so that the TCG behaviour matches the behaviour on real
> hardware.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2198
> 
> --
> MCA: Whilst I don't have a copy of OS/2 Warp handy, I've confirmed that this
> patch fixes the issue in WFW 3.11 with Win32s. For more technical information I
> highly recommend the excellent write-up at
> https://www.os2museum.com/wp/sgdtsidt-fiction-and-reality/.
> ---
>   target/i386/tcg/translate.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
> index 76a42c679c..3026eb6774 100644
> --- a/target/i386/tcg/translate.c
> +++ b/target/i386/tcg/translate.c
> @@ -5846,9 +5846,10 @@ static bool disas_insn(DisasContext *s, CPUState *cpu)
>               gen_op_st_v(s, MO_16, s->T0, s->A0);
>               gen_add_A0_im(s, 2);
>               tcg_gen_ld_tl(s->T0, tcg_env, offsetof(CPUX86State, gdt.base));
> -            if (dflag == MO_16) {
> -                tcg_gen_andi_tl(s->T0, s->T0, 0xffffff);
> -            }
> +            /*
> +             * NB: Despite claims to the contrary in Intel CPU documentation,
> +             *     all 32-bits are written regardless of operand size.
> +             */

Current documentation agrees that all 32 bits are written, so I don't think you need this 
comment:

   IF OperandSize =16 or OperandSize = 32 (* Legacy or Compatibility Mode *)
     THEN
       DEST[0:15] := GDTR(Limit);
       DEST[16:47] := GDTR(Base); (* Full 32-bit base address stored *)
   FI;


Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

