Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE12C27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 04:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK9ep-0005el-FJ; Thu, 20 Jun 2024 00:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK9eo-0005eV-Nx
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 00:44:22 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK9en-0008HK-6G
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 00:44:22 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1f44b594deeso4247405ad.2
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 21:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718858658; x=1719463458; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KZAcnkf7yF9i3TOMOotRM41aD6ReAy02AiCP96c7YeA=;
 b=hpp8SxPNJCeGksAKR2vJSesBkE9Z070LjJKROkq3ARY7b7pJpDh0oAhNTSV9UH5+d0
 7NAOm8ygwTLub4X8yysNiAZAVQeJxosF/Ckn7yv6uGNVjmYjpPlW4wxzF3y5XNJ1TI6h
 aZuJNqEeFLrqQ/bPgmFFLv67SqNti3SUn7jmZbXe8tjdg3cosK9QVvgvGVb//wkX/FPQ
 AO+CrB+sCUg/bi6ZtR5Jjah5RJTF7eKXtaTD6cy/KT+mwUKEHV/QUWYdsTEI4fVIQywV
 v+nUH5HHRkl1qhj936BGDyWFFnd7Ni2+Q8CvsxgMAsZrEOMl/5w1O8CVnkZYG+SlNKfB
 2dhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718858658; x=1719463458;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KZAcnkf7yF9i3TOMOotRM41aD6ReAy02AiCP96c7YeA=;
 b=VdhjKwnUPEd0y1HAjjFsEYpW8iX7MFYq37cSjy1UEXhaB+4QEK+G/k5cBcxmP/WPLP
 jXoRWgpV3pHiIlKYU5bHt0waPUhZQ3Hdg8EGhbUkl4RVZzRoEpObC017fF+do9ZS9ys3
 myGBKCvWoOt2bNq/vUqMF3yAdraj0LmhK4txAo6luw5+F8Sx7p/uL77AhFXAGzSM/acT
 wXk9NRNCvCa3QVdcNP+ROHOdBYbEHWtgCazEPwDVG6CQVO1G9BOg7Duw+z7ouZqEvlF4
 X8IqFI2EZxrolgOxXgq6PAYJk4skmdk/cwIfeUXCXJxT+Nxthw7HAXrX5lsLqNFPCufL
 1dlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX92jAn591aiiGeYK4a4PJyHxI87VNmwBiNP1n6aaATq4LZbUDMm9maquT9IBiN2qtq2FUDlkiSOzeSoWMJ0BIyn5o42Hg=
X-Gm-Message-State: AOJu0Yzg01TNMFbYGwjKuU+9Hed53UL6mmj3VMrwzqKOFRJsglRTXtC1
 0F1X75s4J3C390hY1DhVERJi/XNM2thwL9XGq5mR7zaByJpzoxxh1wB3vGEl3Cg=
X-Google-Smtp-Source: AGHT+IF/NgvYOeuJ8UpeAxrsAAr7M6Wn/VGZCk3IAlcC9tg4qBxhz8RHhPbxKqB1hOms3K/vcS+4Rg==
X-Received: by 2002:a17:902:ced0:b0:1f8:6cf8:232d with SMTP id
 d9443c01a7336-1f9aa3ec4e9mr46294145ad.10.1718858657818; 
 Wed, 19 Jun 2024 21:44:17 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f88fe6a1e8sm62629265ad.288.2024.06.19.21.44.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Jun 2024 21:44:17 -0700 (PDT)
Message-ID: <e60e7b66-e04d-4e55-98ad-bf89aa75c68e@linaro.org>
Date: Wed, 19 Jun 2024 21:44:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 5/5] target/riscv: Inline unit-stride ld/st and
 corresponding functions for performance
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240613175122.1299212-1-max.chou@sifive.com>
 <20240613175122.1299212-6-max.chou@sifive.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240613175122.1299212-6-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/13/24 10:51, Max Chou wrote:
> In the vector unit-stride load/store helper functions. the vext_ldst_us
> & vext_ldst_whole functions corresponding most of the execution time.
> Inline the functions can avoid the function call overhead to improve the
> helper function performance.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>   target/riscv/vector_helper.c | 64 +++++++++++++++++++-----------------
>   1 file changed, 34 insertions(+), 30 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

