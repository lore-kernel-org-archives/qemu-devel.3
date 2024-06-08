Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCDCEC25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 19:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG1sO-0008K6-Pj; Sat, 08 Jun 2024 15:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG1sN-0008Je-Dh
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 15:37:19 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG1sM-0007UF-0I
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 15:37:19 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-6c53a315c6eso2453033a12.3
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 12:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717875436; x=1718480236; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rUWvhkjtYZ0idT6G0lMCje5Gf669PZbYtux4uZ6aaLw=;
 b=l/lpJB3TIHjDvhDX3T3m4PCsQdk4HHPSONxZBMCGqVizC3p9s9HjH5ofdxF04USoZx
 oQVDBq0MypdH+NEKyv/URGg9Ib9u5p6X0mKDkVYlP4g8D/mW283wHnliZ8U9zw+lryV2
 wTr/DiorYzuzUugsZQZaDMElDoIO199ek4mkfeWW2sIBu8DM7EXmZvGjBTZya6T1+5Rt
 tLIzHfUfs7Qi1dDQwQsiPcLeD1+0CwYD7OydB5qz65omK8zFMzo7YDOd7sldc2MhES+o
 jhm+OHCrnQOjk3BGg48TEnztoPIarjp3ekx31+P/j1agQEtpEekbF7Y9SVOrqAUBpRY5
 HO5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717875436; x=1718480236;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rUWvhkjtYZ0idT6G0lMCje5Gf669PZbYtux4uZ6aaLw=;
 b=kWP6o0AgW+AonaxMVGtJs/sZA66sTVdVu67gy7JczoXR6r4A8MXYRyNmQpRT4M1U6H
 mXhxXo5aoa1X9MfKxo3MR5zt3ffmuCiz9wx5b28x8A0BY5Sl42ES8frXx8nK9cLsrcch
 QD3O+yN1U/F+z25SphBNBT8ZhvtE3bXh6AT45xg8beUKv3EBwKNe9DjjnlOI3oyO5PCs
 UcGDiiwJ3BYrEp2zBzk6FYRbsjG+QCPXz8rkdgnIOeXDr3qFffHzEDV8i2i60pM2KJuJ
 NBxvtG1Tc8m2gxamLpWNOu4fdI+Ayp3hdljFzXEIcjsv7LwRi+kX1lmNoI8DQE5n0be6
 QuvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUKVGbKSVEHLeMSCpNFMHQfz6YYo6DNiexVARdwY5LR1vniGculMbvnv5OHRZZE4Ro4+ToOSe159osXyuBvKHZ3eDHUkEk=
X-Gm-Message-State: AOJu0YzBv0UqXjj64WKvwe4Nok6OTWQkZ1fa6Km6vtfRuTe/Ylz+nl+U
 tLC6P7ctgLgjEJNUEbK9OpeIZIDd3CXylfcnv16usz8rcx4qs7fWVNRUhIV62Q9esa6mnU9LxnR
 3
X-Google-Smtp-Source: AGHT+IGqmR3PIJqqKY5qRX3SOG6UEotXNSCXeJ7YDxNd+rZk7W8AnKtdSDEihFl9kgV9W7xE+UL5rQ==
X-Received: by 2002:a17:90a:8c0b:b0:2c2:fadf:26d6 with SMTP id
 98e67ed59e1d1-2c2fadf2b72mr81133a91.15.1717875436149; 
 Sat, 08 Jun 2024 12:37:16 -0700 (PDT)
Received: from [192.168.64.11] ([50.78.183.178])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c2f6e74a0dsm189314a91.2.2024.06.08.12.37.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jun 2024 12:37:15 -0700 (PDT)
Message-ID: <ac196cf1-bfc6-4cf8-8087-f03f052326d8@linaro.org>
Date: Sat, 8 Jun 2024 12:37:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/25] target/i386: convert bit test instructions to new
 decoder
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-15-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240608084113.2770363-15-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

On 6/8/24 01:41, Paolo Bonzini wrote:
> -        if (mod != 3) {
> -            AddressParts a = gen_lea_modrm_0(env, s, modrm);
> -            /* specific case: we need to add a displacement */
> -            gen_exts(ot, s->T1);
> -            tcg_gen_sari_tl(s->tmp0, s->T1, 3 + ot);
> -            tcg_gen_shli_tl(s->tmp0, s->tmp0, ot);
> -            tcg_gen_add_tl(s->A0, gen_lea_modrm_1(s, a, false), s->tmp0);

This is not the same as

> +    if (decode->e.special == X86_SPECIAL_BitTest) {
> +        int oplen = 3 + decode->op[0].ot;
> +        int poslen = 8 << decode->op[2].ot;
> +        TCGv ofs = tcg_temp_new();
> +
> +        /* Extract memory displacement from T1.  */
> +        assert (decode->op[2].unit == X86_OP_INT);
> +        tcg_gen_sextract_tl(ofs, s->T1, oplen, poslen - oplen);
> +
> +        tcg_gen_add_tl(s->A0, ea, ofs);

... this.

Combining the exts + sari into an sextract is fine, but this has lost the shli.


r~

