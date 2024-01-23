Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC69C47258
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jan 2024 23:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSPxl-00005X-Li; Tue, 23 Jan 2024 18:13:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSPxk-00005P-6H
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 18:13:48 -0500
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSPxh-0008Tr-2Y
 for qemu-devel@nongnu.org; Tue, 23 Jan 2024 18:13:47 -0500
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5999ec531dcso777181eaf.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jan 2024 15:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706051623; x=1706656423; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sdCdF02lzGx9cWCw+4GiCPcD/WjXXpN+gm8h/tirqvU=;
 b=YpvihMjmiLFoNOY8etGP9M5coekOsp7Ok0Fl2m+gszdT88NvdAG4mQRcJfhzM/+w0u
 sdad2GhAvB2DEoaYPSNqTkT3QVxLTKga0Yvly2HmOC8mDJz3SBe9Lyej9kq5cLCq1Ozs
 AJxt0xkonIit9tknTrRlNiU9IZusJrPmia5h0g+ZCGAJwWpzihfLht8KUCs70NANW/e9
 XAud93GVH0N/svnVcr5/kN2Qjah6O4dXjfPPEF7PwNO5ze3mrKJ8JLAypIhmLuM0+dO0
 kcseUV9ztRa21K45gnb1ISEVB0dNcygXxTZWkyl1ViM4VzhHyvxNHg52+z53EBe0qwKx
 1yOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706051623; x=1706656423;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sdCdF02lzGx9cWCw+4GiCPcD/WjXXpN+gm8h/tirqvU=;
 b=SONJY6F33oobqquqaWmMUlSAPLsUt+XusIo2UsQBkcdtTzg4Hxizf9gzwlTjPXxX/x
 nsGZB/EZI11AEmoBb3b+dYfhQDBxsNIwuamqqbfSslyddQU29A6YgVeUWviGDAnH8bNC
 wyN1HrQ3eYd6/AzlhgNOg+Ge/IC358fCQnOAufSGNtSWu2UAw5hC6P4G6hAywUDWDy4z
 pS8LfdZXKha2FKGte4irSbtbstsJFe/+nItka0u9ANaIF2Es5UUx516egXJrwiSTLI5l
 559AEQxjiXxzmhKq6dtsT0rqQbe7NL54uyElN0FRPjuHHLYL9RUpNwKBhQrCmdxeTAb0
 iEEA==
X-Gm-Message-State: AOJu0YyVE5EMQZG6cVnI47Y5AJkpQ6mjGY7KnfhmNQBFyAX+TPowV8HH
 j+3mXUUDzeCXzF/lbU70Cz/jtl4hRxTu9NTw+5/qSjby76Nlw+dIQDzX3GjxoTk=
X-Google-Smtp-Source: AGHT+IH1L0jw9h48cxXvEdFe2UPs930rOHE6Tt2T7z9EVoTQ+73aKGbzjRvRRWYELuew4ZmgIJ3K2A==
X-Received: by 2002:a05:6358:9999:b0:176:470f:92c5 with SMTP id
 j25-20020a056358999900b00176470f92c5mr4581114rwb.47.1706051623368; 
 Tue, 23 Jan 2024 15:13:43 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:dd1:291f:3c3c:2485?
 (2001-44b8-2176-c800-0dd1-291f-3c3c-2485.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:dd1:291f:3c3c:2485])
 by smtp.gmail.com with ESMTPSA id
 c10-20020aa781ca000000b006db11bab9d9sm12183306pfn.202.2024.01.23.15.13.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jan 2024 15:13:42 -0800 (PST)
Message-ID: <ae70faa8-1f4f-4b45-b6ec-61fc1726c03d@linaro.org>
Date: Wed, 24 Jan 2024 09:13:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/34] target: [VADDR] Use vaddr in
 gen_intermediate_code
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: ale@rev.ng, philmd@linaro.org
References: <20240119144024.14289-1-anjo@rev.ng>
 <20240119144024.14289-9-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240119144024.14289-9-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc32.google.com
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

On 1/20/24 00:39, Anton Johansson wrote:
> Makes gen_intermediate_code() signature target agnostic so the function
> can be called from accel/tcg/translate-all.c without target specifics.
> 
> Signed-off-by: Anton Johansson<anjo@rev.ng>
> ---
>   include/exec/translator.h     | 2 +-
>   target/alpha/translate.c      | 2 +-
>   target/arm/tcg/translate.c    | 2 +-
>   target/avr/translate.c        | 2 +-
>   target/cris/translate.c       | 2 +-
>   target/hexagon/translate.c    | 2 +-
>   target/hppa/translate.c       | 2 +-
>   target/i386/tcg/translate.c   | 2 +-
>   target/loongarch/translate.c  | 2 +-
>   target/m68k/translate.c       | 2 +-
>   target/microblaze/translate.c | 2 +-
>   target/mips/tcg/translate.c   | 2 +-
>   target/nios2/translate.c      | 2 +-
>   target/openrisc/translate.c   | 2 +-
>   target/ppc/translate.c        | 2 +-
>   target/riscv/translate.c      | 2 +-
>   target/rx/translate.c         | 2 +-
>   target/s390x/tcg/translate.c  | 2 +-
>   target/sh4/translate.c        | 2 +-
>   target/sparc/translate.c      | 2 +-
>   target/tricore/translate.c    | 2 +-
>   target/xtensa/translate.c     | 2 +-
>   22 files changed, 22 insertions(+), 22 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

