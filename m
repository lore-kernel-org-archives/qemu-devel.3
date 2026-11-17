Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4867E606A32C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 19:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=orY+NpL7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTOTW-00067n-L5; Tue, 17 Nov 2026 14:04:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOTV-00067O-Gx
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:04:13 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTOTU-0007Nq-0S
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 14:04:13 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3b0d0b80fb9so37005a91.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 11:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794942250; x=1795547050; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aQVnNtPEIak6W6/t0keyTqnV9Q3211h1DEQEY1BKXak=;
 b=orY+NpL7n4QfqfR8FD+BNM3squjb9uu6lNCkpihHIHDLqjMPMLgj6Aeqyo2+GC1v/t
 r7EGZYdSs0BKmky1zcrIFW/h/kzR4Y8fsm1EuXeSCqIXW0x4AVoYhTP7D2Ui0Yx18pb1
 0BaW2C7FPnE4T3EPDG9z+XOuaVccamDeYoW4UZzzxBQ3JlLbaaZEhUVVqMsB5dFd6w3h
 TlKGvZJN9twV1gcQ8y1XEhaCjpn/FFCVWpbYe41tYL518wxT0CynqZmT/IQPGsJet8xA
 hiwBOM5x0gZqGH+hSm9+EUXPKhKLESjqHwyHh/xnzQIDe1IAyoQa/yTMNrQtvsZt0ld4
 QGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794942250; x=1795547050;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aQVnNtPEIak6W6/t0keyTqnV9Q3211h1DEQEY1BKXak=;
 b=lq/rlVSOO/+Kk6irT4Ii6rx3FlqeiFuQ6mhgjmLHC0N8FpSyBdqYXmWQwxRf6P9UAj
 NJabgyqkQ38Rlz7miMnlrlrSFwLbs0g8MpOl7/5WRpONPn1jbY2Bzt2u2QG6JT6iUW3N
 9oFqX6COD3jdZogDaARiS0vjWUBctZ6iT87i8P1QuagYJFv0WbGQUjfeAt6U901SJucJ
 z70cyYeDNYTOW0n2zMKC6Jk9NiAlAFz0/l6x7HHg5pe33iSjYRXJ1oQKQ6uLiJANHRGn
 BdRh2kZniUrGiWke/63AHkcIvpEWvQ5EhcLq2IAg7zLgM1P67vwsXzBUPD4YNC90+Jei
 jhXg==
X-Forwarded-Encrypted: i=1;
 AL+hErEsTWbYC52BDNFmMGcpg8LSsyQlFY/kRSwKTWh6Lps4sevCJxomp/GqRmsuemV/45Ex/SilcO+4ko+G@nongnu.org
X-Gm-Message-State: APuU4Z96cfY2CuJtk9HW0IyXvdagjXxey8NvUrYDv3LsuDbuhvK/IrDF
 2aKWPV8mwIGqpmeJBZEBoLzqbvNowaTaCs7+ug5KezJk2SkcnXz0V6jiaCcriHTKUm4=
X-Gm-Gg: AZFdTZeDMxWbVN9Bg6diYqmIUSNVU4Rs6DtiEajemYf7IEMcOaFTiNJgKyyY61CRJd+
 j2jhx/hAkqKxSHPwwO7hpnihSjipwiaQK6oI48UubO5CUEQ0yTPdqlrwRfz+UHIGGJjZ6uTQVUQ
 s/QI/1T3RITJavEA6etqU+u8wANy0cMqcZmWM5glXv+EVSQAfw/0JmfQrK0fCELA3br1oUAwNJN
 rokhut7zr5biQ7TouGyW8737bWXTW2fGgicyq80tf0l4CMJsfryk2/ilMX3YLG6JF2tuHtdAuAM
 e/xIYodw7S1psTci7LiXivV2LCmlPJ0KgZCNDSbzZ+pb6zTswUUDfDkes/hg0RYr44/iSLvfosp
 5bKMQA3wNYGl/KJUJmjIw5FSjAlh2m+NKLVHdmQLZnxpQAjueWtecCegvck+hdnT7WB7bnY4A03
 pSBw3Q4ZtmNOuHstjcpDtqe0gRlkaAVjvQW09QFxVUa2kEXHqRIz7W2X0pNMc3GAl8xq50/eQ9v
 vzGlAx73SXmYUP4wvOulSBV2g3BoVBTV8hvH6n8pYJU6YQj5+lgqr9TQUfQvY8ZMwKVSLX3OaWA
 p5LrByXx+gNIJGQdFPU6U0Y5cwYlSu6jFLr2dCC/U+tP4WKkvTOp4JnNT1pTBI6gpGhg8ic=
X-Received: by 2002:a17:90b:2783:b0:3a0:e1f7:9b04 with SMTP id
 98e67ed59e1d1-3b3d079ffa7mr300602a91.12.1794942250038; 
 Tue, 17 Nov 2026 11:04:10 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cde3af26c35sm3314a12.2.2026.11.17.11.04.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 11:04:09 -0800 (PST)
Message-ID: <f26c896d-9da0-4ffa-85e0-4d62b2a2070e@linaro.org>
Date: Tue, 17 Nov 2026 11:04:08 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/19] target/mips: Reject the PMON encoding on Release 6
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
 <20261113161158.25811-5-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261113161158.25811-5-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 08:11, Philippe Mathieu-Daudé wrote:
> On R6, SPECIAL funct 0x05 is LSA, which decodetree matches only
> when bits 10:8 are zero. Other encodings fell through to the
> non-standard PMON hook instead of raising Reserved Instruction.
> 
> Fixes: 0e9524af2dd5 ("target/mips: Remove unreachable [D]LSA code")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   target/mips/tcg/translate.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
> index c434da714b0c..d1be32bfd9f5 100644
> --- a/target/mips/tcg/translate.c
> +++ b/target/mips/tcg/translate.c
> @@ -13301,6 +13301,10 @@ static void decode_opc_special(CPUMIPSState *env, DisasContext *ctx)
>           MIPS_INVAL("PMON / selsl");
>           gen_reserved_instruction(ctx);
>   #else
> +        if (ctx->insn_flags & ISA_MIPS_R6) {
> +            gen_reserved_instruction(ctx);
> +            break;
> +        }
>           gen_helper_pmon(tcg_env, tcg_constant_i32(sa));
>   #endif
>           break;

Depending on how long this lives, perhaps better as a REMOVED line in 
rel6.decode to catch this instead?

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

