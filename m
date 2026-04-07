Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 464E7FF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABsE-0006Ax-32; Tue, 07 Apr 2026 15:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wABrv-0005xi-P3
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:13:47 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wABru-00039P-0Y
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 15:13:47 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488a4bc360bso18499525e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 12:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775589224; x=1776194024; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qYd9y7jsUtq/jXOrtKexQFCwV5hEMo9e0sWL6zQmD98=;
 b=eUUK2drQkYousa3OXv2byp3Z/R5iHpyuLmpYTRuGHizlHSW9b9bubWVOiHR0BC+F8Y
 9Hm/e8VrQATt4/p1L9kDlR1hMqAqw4O+uGmzYSxbEpcdE+f60x3MLhC9bz+WO5iZCiQ6
 WDAomcyfxVmAgO13onsdWgNfpBy4to04ZesOT5ws25cfiVDq5n/nAwSFp5mAEgHLc+To
 0YPScYdy/Xj5lrw6kw/7+e2OKmJp9zKJCxsRRWNn2Ew1LLGJwMuDsY3H1aagZYAtYALS
 kXaMeRoeSabrQaUtQRkaJkCttPyPO1j2TQx70MELWP5P8rpo+sml8nWBCS7QF1ywPHJZ
 EbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775589224; x=1776194024;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qYd9y7jsUtq/jXOrtKexQFCwV5hEMo9e0sWL6zQmD98=;
 b=SjB2zSFJD/jUWaKidNvjsEfT18ukr6U/sZPpsiX4ieRukt9pRzrh/weuWujErSVvVl
 4geRdtGyDFtCmHdbxn7J66A7GCixJMBtUVu1lu3XLEewnkFU4pk7DpzDeIpLmY8nwg8z
 3D6zqtZrwme5VH5zD9/RYA1eFpHWFkLews9v2cGOweXglfd4NX1rlXSG8VYsS5XpxBDb
 kqbACGnIyI7J5aYX0zMtyjPiTfktbKxvQZgyW2Xb5ujy8HokYKZc6JVnrURdvdG45e3R
 8epYmR1PQpCarnAOOfwODys5B8NjeDvIcIlu2sBEDqS3t9Ep2R7ZrbX/MwNs3yzSI69T
 Irrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQQcQsp04IkiyrfPhlZPnXtsuroh+SrV8UDCyU9MzVuWIRu2IGiq0oROTj8ICX+pJmaPuWubCJoL/x@nongnu.org
X-Gm-Message-State: AOJu0YwSwncuVKoVvQcUoea6v95/RXKgWJznepQxWJhgbCSK+JNrGl8O
 OywD3LHGNLNQqJFxJ5elugdVUHVZFjeLocU7R0Kb1O+dhpTvGTKQtpEjZuEPDOWZvr4=
X-Gm-Gg: AeBDieuPk+outLmXU3+6RCrt7tRaxugcqD8Lgt1Ox8yjk20mJZ4tAE4g0XwFEwoz8SD
 MfpgNIQtDjfMhnQtDP/Mbik9NyffcdQNP92jO8IwbW4oJzIO9PE8/AoDh08BUc3JaW9frbddCDo
 vDvV2dNnkTdkxo7Zk/iio1KOdrs+ukfLey1KrLIW8FETVZPdlmULjvj3XXpVEff9KB2mD6okzYI
 YiroIqDAy5PNYU8Dtp9Jza9doenTUDGsPokEkVdjTw7mAzod7rCixuOjWQM1AnWWfclDnRo7Vk3
 O/b5HtZ11Z3AIv5/8EeoId6yTyLvuJEfgp7+q5D5K5qFkHTemUYRLXEro9eS14kSrNNm/mgr62U
 kedHFFIYtztSlCpAZnhnopL6ljZ7gi8aR57OtPSLZbkE/Tz5h4yYm3uw+jxJmcD1bsZq3uOPFWs
 4Brmz0ltdjdXHrl5wDjaZLR1BmLhVnMV76WhxNa0yYzVa6qsVuGVHPPMSnv8wRzBR58A==
X-Received: by 2002:a05:600c:3546:b0:485:2f4a:6ae6 with SMTP id
 5b1f17b1804b1-488996da165mr259316815e9.6.1775589224181; 
 Tue, 07 Apr 2026 12:13:44 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4d289asm51269290f8f.19.2026.04.07.12.13.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 12:13:43 -0700 (PDT)
Message-ID: <974cdf32-cd30-4267-b785-bad9abae088d@linaro.org>
Date: Tue, 7 Apr 2026 21:13:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 16/20] target/arm/tcg/translate-a64.c: use
 translator_ldl_end instead of arm_ldl_code
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org
References: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
 <20260407022748.57629-17-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260407022748.57629-17-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 7/4/26 04:27, Pierrick Bouvier wrote:
> Allows to reduce scope of target/arm/tcg/arm_ldst.h to aarch32 only.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)


> @@ -10812,7 +10811,7 @@ static void aarch64_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
>       }
>   
>       s->pc_curr = pc;
> -    insn = arm_ldl_code(env, &s->base, pc, s->sctlr_b);
> +    insn = translator_ldl_end(env, &s->base, pc, MO_LE);

Maybe worth a comment /* Code is always little-endian on Aarch64 */?

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       s->insn = insn;
>       s->base.pc_next = pc + 4;
>   


