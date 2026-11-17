Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7631F606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 20:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Sg1lXcs2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTPzu-0001J1-3k; Tue, 17 Nov 2026 15:41:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTPzr-0001If-PS
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 15:41:44 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xTPzq-0000sF-1P
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 15:41:43 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cdb1199bfd8so154616a12.1
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 12:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794948100; x=1795552900; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TG62xZzcK2oXEJyuImzJbCMiSea+R2vCi04AJXCocZ0=;
 b=Sg1lXcs2CrjBec+dehg4yyiJ7Ymp8g9508Za46H4Y4+uIHm6ak1ySDT2HbfT7+Mimm
 kiS9IwYBFlEJ6X3yysVHtuzVqvnmi3Tvkkx+Kxtu6F5y3yGYNl2FNnZNJ1HECfLmAEVT
 3Q2e2R7EQjOnHOXJHNuKC1hh0jQE2L9mWzsygdhIrrFjTlZGXtzd/8HXKw0a3HjipXos
 p73cGmzBcOMirDzsF2EuuHIBRgXpeQMTQ7JAbXMRpk3bQ9M8zeo3xYMTeq8xrMUsmyro
 tJxjuRl6davO9FK5kqQV4uuESOg1sCu60fXcA9z+JgQj/LBAWQWYdn2dzNpxE/HD3vXH
 S0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794948100; x=1795552900;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TG62xZzcK2oXEJyuImzJbCMiSea+R2vCi04AJXCocZ0=;
 b=Bn0n+BU0sRXmd73rs2ZYf6PBA7k/zmzKNSzRtkgM+5A2pUhmalHTMTJjkeSe2DJFWI
 8I7LCBJyuRkKci/onUlH9g6LFKShJmzUGDLa+cKFyFbm/Z9sFAvEnAhYjd45ioXiMVq7
 vss1pocReJxy7QYQooJ0NWm5+yv9RfSgBA/AoAAJmP5qKKiZF2a7RS8TtZx93EdOjs+m
 2y64MIEf7f4PO32bmiNHmg9yHYLz3jJPjo0kDXoEgaX4stTwub2lnAjYkE4rsGY5NC60
 Iq2anq/CRp0o0ww5lYMXOyYAFsUbonfP17XHAJGDJkPnq8Py+CcetrrX3+PEkQpcmhbx
 IQvw==
X-Forwarded-Encrypted: i=1;
 AL+hErFv7pd/dLq4tDY1tbWDOFN+9ItW9ElvG3sDrLLuBzNmwqbD7hO8+aiQltzsFELU9j1nLnoZwfGc2Z3T@nongnu.org
X-Gm-Message-State: APuU4Z+vHZviaAayeS5gTYIwM/EkQgW2e77CmZfRYVQJB5YZxPlVMK3A
 J6Xwn2Pz8krjV5K0rWQLYCX+KFmzvc0od9qEWVtS+IoKNocvHNzh65doxpuG1AG4EjI=
X-Gm-Gg: AZFdTZdHNS1bdMEpH+qIAVcPOkeLHVspBjh02NPvEVyUfbpjE94pV24Njd2gX/PmVL1
 gLJVEbF0M0n8zK+GeTY+WVWsIdmypSMXQirEkKTEAAYy0dyDKw7sYDCw3oiSmYQQe0wH8hhmCl+
 ccY9XC0hhYrKKlH5EMq39I2SOFdJI9/toPgbGSZvGZM74x+HqnRC/n8pAl/XQOFDE2Ghx5mhJa8
 u7pTcw7ZwGSVRShAAOWLqoN5AbaAdeZZk94GyU/U0Vwp6lDJVki5VD68NT1HqwZ/i1/IyKjS/ER
 WM7ZYjFR1ZTnUIOP0ph0mIskUP7St2WdwSpq70DqqYWHhaHN1DAwETUawj+IaSdarzyFc5kYowz
 RqKN/a15CzqoCNZhudaslmOvvo10IZprbmy0J43a0cFHNDsKY2hSuNtfVq4xdaKN9C0g52y6rsN
 pFdfnxzioqJCaU/qPu0/ZrPaV2HOKq581kPOXOcrB4WcO4GdZvYa3pSGp5CYj+qlZqEohLbHenW
 43gsGMGxsRhE1LeYzmcYXQsCbvcsWnEo3ObhqRcTRb7JDgogGnVUMHO76e4mwDDXryYYJiLT0V2
 DEbcuoU0HOOflIbe8W+Fo9M1W+Y3ldPleHubgJGZQuqQUE1+B/MDz8BEyvyWMJvu3cIxHi4=
X-Received: by 2002:a17:90a:d444:b0:3aa:fc22:8aad with SMTP id
 98e67ed59e1d1-3b3d07c23bfmr537233a91.54.1794948100027; 
 Tue, 17 Nov 2026 12:41:40 -0800 (PST)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eff62e324dsm2281135ad.74.2026.11.17.12.41.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Nov 2026 12:41:39 -0800 (PST)
Message-ID: <27efc4a7-f4f5-4dae-acb7-189a9ed0a08a@linaro.org>
Date: Tue, 17 Nov 2026 12:41:37 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/m68k: Fix TB_FLAGS_TRACE* definitions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <th.huth+qemu@posteo.eu>, Laurent Vivier <laurent@vivier.eu>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20261117080747.8035-1-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261117080747.8035-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

On 11/17/26 00:07, Philippe Mathieu-Daudé wrote:
> TB_FLAGS_TRACE and TB_FLAGS_TRACE_BIT are swapped.
> Fix to avoid m68k_get_tb_cpu_state() set an invalid bit.
> 
> Fixes: 5e50c6c72bf8 ("target/m68k: implement m68k trace mode")
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   target/m68k/cpu.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
> index 781c98f78400..5adca8ed49f7 100644
> --- a/target/m68k/cpu.h
> +++ b/target/m68k/cpu.h
> @@ -606,8 +606,8 @@ void m68k_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr,
>   #define TB_FLAGS_SFC_S          (1 << TB_FLAGS_SFC_S_BIT)
>   #define TB_FLAGS_DFC_S_BIT      15
>   #define TB_FLAGS_DFC_S          (1 << TB_FLAGS_DFC_S_BIT)
> -#define TB_FLAGS_TRACE          16
> -#define TB_FLAGS_TRACE_BIT      (1 << TB_FLAGS_TRACE)
> +#define TB_FLAGS_TRACE_BIT      16
> +#define TB_FLAGS_TRACE          (1 << TB_FLAGS_TRACE_BIT)
>   
>   void dump_mmu(CPUM68KState *env);
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

