Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A7FC25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 08:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGwhD-0002tJ-0i; Tue, 11 Jun 2024 04:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGwhB-0002si-Bx
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:17:33 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGwh9-0001zI-Ib
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 04:17:33 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57a677d3d79so11423971a12.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 01:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718093849; x=1718698649; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7kJSHp+3vZEw0JRPuHjECcenM6gafNdXSMSt50lci5o=;
 b=jNx0mcb6LkaWs+UElUCyZgo9aq/Ptgq5cmjXQ1RKeLeT5J0topdhxeNtVdv9tkWFPd
 puLTSMViYkbqBn+Kv8cc+GWf1RtaB3DaggwGhtu0zx3ULBrPOgmu1pF71cgqphaoDFJt
 fBQILKaA5mITSUhBcP8nbGXDQC9aEb0Ac7hUz5uJvJisUCTiDf3A5LSnWU6F93+ziJXZ
 Xflzik/3SF8pBmP2pmHu9XDRnTNytIpvqiDjo30pNBhJ0PIUxS+2GUzhuWTqDvg4t28J
 6BlBWIvffwvTHGSVylF1L+P1Hse6Y9RXoAjaZE9W46AQ3TQz9OwWSS1orllQlY6Y/16o
 5G4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718093849; x=1718698649;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7kJSHp+3vZEw0JRPuHjECcenM6gafNdXSMSt50lci5o=;
 b=Uqocb5o8AXLSe/Au/w5tMrs4NiyZDcpM0942NHBcBamTWYTj1yOFiSdxkj0UJqy0gJ
 P87Nq3/xTTOX/lAoduPeo0pN7xLiUgTnwKXCPh6HizsEKlMMjQUJMwPxdYaM1UPgJ4Kd
 FmpB4cQiwqENGLhSbJSrIGcUZZlOAuNubGs6rgc68oKQd7ZhGu1Fe+OVdjju3kBddrhE
 zEeyEnzy36TFHDjzAWG8wEdMjw1J96NTl4zF8PedCguLEu5ZSVa5ge0x6nQuI1g2sabd
 MTc3smKTCO9bhM6O64eWVtez8pZ7qq3d/kjqUCiI7CxlFAvuHLTKZBUwvuBVUYccYMNs
 RoXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXK0mkItDMYRYwCUglKzm5TQuCmfIxJepHiFHnWQRiaDncdWuuwzAahXoLWhYFVtMUbSmvf7n6wV4tx4M/ZezLJUIUDG3Y=
X-Gm-Message-State: AOJu0YwHxVu3sFoJciw3tNfJIXNjcAA++P/j+Zl2HJ4Q0Qyub3H7WGk7
 N2pRhx8FLFHRQJ0gZjGic2lP7h3jnFQJFNgKbPgCu61iVg6z5IOqrtPxnNvT7uU=
X-Google-Smtp-Source: AGHT+IGL8/4/uCmKoz6Uatz05yNsZaAvmDE3BaCN5oVmZ4Re6/TZxYS2FXNYLLMlhC57pQE5lDRlSA==
X-Received: by 2002:aa7:c2d4:0:b0:57c:9655:9943 with SMTP id
 4fb4d7f45d1cf-57c9655b257mr526919a12.2.1718093849490; 
 Tue, 11 Jun 2024 01:17:29 -0700 (PDT)
Received: from [192.168.69.100] (rsa59-h02-176-184-32-6.dsl.sta.abo.bbox.fr.
 [176.184.32.6]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae0ffbf8sm8980194a12.39.2024.06.11.01.17.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jun 2024 01:17:28 -0700 (PDT)
Message-ID: <9a45b5fb-09ba-4bb4-a91e-85dfb9b3031c@linaro.org>
Date: Tue, 11 Jun 2024 10:17:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target: Set TCGCPUOps::cpu_exec_halt to target's
 has_work implementation
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20240603160933.1141717-1-peter.maydell@linaro.org>
 <20240603160933.1141717-3-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240603160933.1141717-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x535.google.com
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

On 3/6/24 18:09, Peter Maydell wrote:
> Currently the TCGCPUOps::cpu_exec_halt method is optional, and if it
> is not set then the default is to call the CPUClass::has_work
> method (which has an identical function signature).
> 
> We would like to make the cpu_exec_halt method mandatory so we can
> remove the runtime check and fallback handling.  In preparation for
> that, make all the targets which don't need special handling in their
> cpu_exec_halt set it to their cpu_has_work implementation instead of
> leaving it unset.  (This is every target except for arm and i386.)
> 
> In the riscv case this requires us to make the function not
> be local to the source file it's defined in.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/riscv/internals.h   | 3 +++
>   target/alpha/cpu.c         | 1 +
>   target/avr/cpu.c           | 1 +
>   target/cris/cpu.c          | 2 ++
>   target/hppa/cpu.c          | 1 +
>   target/loongarch/cpu.c     | 1 +
>   target/m68k/cpu.c          | 1 +
>   target/microblaze/cpu.c    | 1 +
>   target/mips/cpu.c          | 1 +
>   target/openrisc/cpu.c      | 1 +
>   target/ppc/cpu_init.c      | 2 ++
>   target/riscv/cpu.c         | 2 +-
>   target/riscv/tcg/tcg-cpu.c | 2 ++
>   target/rx/cpu.c            | 1 +
>   target/s390x/cpu.c         | 1 +
>   target/sh4/cpu.c           | 1 +
>   target/sparc/cpu.c         | 1 +
>   target/xtensa/cpu.c        | 1 +
>   18 files changed, 23 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


