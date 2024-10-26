Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800A9D10BE9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2024 04:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4YXJ-0005F7-Bl; Sat, 26 Oct 2024 00:36:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4YX1-0005Cl-KU
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 00:36:08 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4YWz-0000RO-0P
 for qemu-devel@nongnu.org; Sat, 26 Oct 2024 00:36:07 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-2e2e87153a3so1928498a91.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 21:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729917363; x=1730522163; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/gIbe1d55J0i7G5iCOOM1ljApzrAFEyO6xE7+q4tuJA=;
 b=kI20Er5gE0NPTCtSCooB54bTUdStR5FaDOXpxY8MHNqHPkvt02HhiHY6KUciKZYppf
 3JHxjz24n+EO1nDHQnYuDBJgge3N82XoNKk7untI4zABIPKLpjNlXvMs5WJXT6ixJ/IA
 +KAeHO1dUnUniHKP3vNX2E2eRaGSR1Nj4MOobodYCRfhKM7POv1Wjqzz1hgA/7D0QohH
 nyqLEvBOF9A1bjy5a+vpiWyzIfuRl0KPVNo9X5PGs0PhEKU85z1haKH4aXNcleRyUBwm
 CHww0uBWflHmQ4CJFaIGYCuGgfE2lwBd7qNy/cXo6uFcPNQCgH3rh2ReeAOPqoGkyVmi
 aG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729917363; x=1730522163;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/gIbe1d55J0i7G5iCOOM1ljApzrAFEyO6xE7+q4tuJA=;
 b=IJT0Yyqzg5cxihYbRAKi/t6ZENJxjG0zlqsQJopnrhkNTVzX6SGp9CQV2kwOkSl5mO
 SKREJAFjxe5fvzlF4Svv1NG7LJOq0mQvwbXI2jhIVpRHN2DxDt5nNCZoeh3d4EQFvBbV
 RlIMCKlJ+kBecZQCmPF6SlxVSnF69YdgpoIA1AdrDU/WcXgOtl7nuDwVKxll2nLsZdXE
 jH9C8YNdTvmU1mtldg0gvPx6WqE89LS9O8o3vdDSkQ/RrwLk5aYXhd8pihrgweq0bS6u
 Ladx3SD5UUiWAoPR1x0mXilPgBgpq6KjSYVu2oSfPHieTSXZy2PyxOxPcUQOlPeHgXfZ
 IvPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVru63cZe62xiUBrZ6jBXGTTxsvmWISQekCPoVTxFh+RkFAbCsvxWKIcVO7vgqAIniN5eQRA0tAxKPF@nongnu.org
X-Gm-Message-State: AOJu0YxHZfcZ1wMN1ESzvzbaubpX06BjRRhUPfR8Y1esjYgxN5Kprmdb
 KKlfBl0RZ3NQkSf5zyE1EVz6aeNYB4yJ0Gweyg69mk32GUwyfzf6rIxcA0X4Qa8=
X-Google-Smtp-Source: AGHT+IGReU4ICQ3M2VC36Ip/tTtyo22+H2HnmGfFtSFZ+yskBIh5Dcb1rq0I/LLPKx/DtGbBjo8Ylw==
X-Received: by 2002:a17:90b:5201:b0:2e7:6e84:a854 with SMTP id
 98e67ed59e1d1-2e8f0f53e17mr2311975a91.1.1729917362924; 
 Fri, 25 Oct 2024 21:36:02 -0700 (PDT)
Received: from [192.168.120.226] ([45.176.88.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e8e37490cesm2435135a91.37.2024.10.25.21.35.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 21:36:02 -0700 (PDT)
Message-ID: <a6a832c5-9429-40b8-ae3f-1c90c5301f73@linaro.org>
Date: Sat, 26 Oct 2024 01:35:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/21] target/m68k: Initialize float_status fields in gdb
 set/get functions
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
 <20241025141254.2141506-11-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241025141254.2141506-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x1030.google.com
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

On 25/10/24 11:12, Peter Maydell wrote:
> In cf_fpu_gdb_get_reg() and cf_fpu_gdb_set_reg() we use a temporary
> float_status variable to pass to floatx80_to_float64() and
> float64_to_floatx80(), but we don't initialize it, meaning that those
> functions could access uninitialized data.  Zero-init the structs.
> 
> (We don't need to set a NaN-propagation rule here because we
> don't use these with a 2-argument fpu operation.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Spotted by code-inspection while I was doing the 2-NaN propagation
> patches.
> ---
>   target/m68k/helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/m68k/helper.c b/target/m68k/helper.c
> index 9d3db8419de..9bfc6ae97c0 100644
> --- a/target/m68k/helper.c
> +++ b/target/m68k/helper.c
> @@ -36,7 +36,7 @@ static int cf_fpu_gdb_get_reg(CPUState *cs, GByteArray *mem_buf, int n)
>       CPUM68KState *env = &cpu->env;
>   
>       if (n < 8) {
> -        float_status s;
> +        float_status s = {};
>           return gdb_get_reg64(mem_buf, floatx80_to_float64(env->fregs[n].d, &s));

While here, could be renamed as 'discard' like SPARC. Regardless:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       }
>       switch (n) {
> @@ -56,7 +56,7 @@ static int cf_fpu_gdb_set_reg(CPUState *cs, uint8_t *mem_buf, int n)
>       CPUM68KState *env = &cpu->env;
>   
>       if (n < 8) {
> -        float_status s;
> +        float_status s = {};
>           env->fregs[n].d = float64_to_floatx80(ldq_be_p(mem_buf), &s);
>           return 8;
>       }


