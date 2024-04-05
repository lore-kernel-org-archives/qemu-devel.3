Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87E6C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 12:35:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsimx-0002hq-GB; Fri, 05 Apr 2024 08:35:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsimt-0002fF-M5
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:35:21 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsimn-0000nu-Ue
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:35:17 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a51ad517450so28384066b.2
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 05:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712320512; x=1712925312; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0w1e6iMMumvTWTtuSY6ScFH54x7HoEmxSYLLOaLx+yQ=;
 b=h+qKbpmV4J+6q9t51QvtoY4fbD3pOt4PJgGqJPTrqCwsqMk+t+c2yitaKjZaP+vqZ4
 tQZGscZA7BAlOBILen8+3ICExBi0BGL3JHEYxF0vLI5QkHK3h7c0hnQ2UlWvgGp032qf
 79h5tnrpyefnK0LBaqguAdvm2anBxxf7pGhfmp+B6GnjASTJu5zJ5rTLzfxNT1lFhE3B
 +trwvLF1zwc530zD3h6fo/gyy9KZJhku4LHYtb+McAB8RhIjTUhsdJ43/FtutsTKA0tX
 bdUeIXGuPvKidw3CXjBdFsmKZBf/oz4aKP4ir1DIyzn/5rTG7Zja/rMZVT05RBtaR2FM
 qY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712320512; x=1712925312;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0w1e6iMMumvTWTtuSY6ScFH54x7HoEmxSYLLOaLx+yQ=;
 b=ofMfBpnEr3nNtavPZvD7SD3MYKsrQ0Qsaxp6Riv29AoK3pH7csSjjcrjaFc1bL/SGU
 6pjtmFmUzezCgn4o9Je43arO0CIFmUZ3ysRN+AlyfxZAbM0Z8TqztRfjEizGF0R8gg8B
 3UIIBChcFiUvcjC88UK2v48cjOaqD06Lxe3hefaLh87C/dP094nLvOwTTVWEtVKZ4zAK
 4CDo13QMz+Xf6EGjiHj2HvxLLu3NJJs3QE1aZEtHh8uxwlZWSAu1yZEIYC1GMFmkKud8
 M+I4coVBgVUPqe6aFMkABAp/ESBbeV83LyxTz3KVNXLHCs/9a3C8ihmjfIfFalVAaJUA
 bMcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrb0U+S6kPW1XzM/t0YshqGomjnbrA1vl5F+ZijrJbQBAc/y5hRI5enug9BkUqrD0upSj1yvxrDammBieR05EwgSMzguU=
X-Gm-Message-State: AOJu0YwPPEDtd9rdbVUZKlkmzcPwiibMBu9866FX0Y0lhmoOFy3g6b9e
 nX5EkfD9jimF9yGNASPm6tX7FgCZswUAU/iF8N5zwRijbdARzXU5f/QtBP0I+KMassU7wUVoYfi
 v
X-Google-Smtp-Source: AGHT+IGJZ+B+xVvOqkrTcjl7zndSP2isYNGDlpe2xQ562LajVZyBbyb75s8ntdfH42EYyCOv7ZwXFw==
X-Received: by 2002:a17:907:971d:b0:a4e:5bb4:48ba with SMTP id
 jg29-20020a170907971d00b00a4e5bb448bamr1216828ejc.60.1712320512441; 
 Fri, 05 Apr 2024 05:35:12 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.34])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a170906708600b00a519d2ac2f4sm793059ejk.63.2024.04.05.05.35.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 05:35:12 -0700 (PDT)
Message-ID: <c36ca2af-95be-4bfc-9461-fe15c999a796@linaro.org>
Date: Fri, 5 Apr 2024 14:35:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/32] accel/tcg: Hide in_same_page outside of a
 target-specific context
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240405102459.462551-1-richard.henderson@linaro.org>
 <20240405102459.462551-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240405102459.462551-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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

On 5/4/24 12:24, Richard Henderson wrote:
> While there are other methods that could be used to replace
> TARGET_PAGE_MASK, the function is not really required outside
> the context of target-specific translation.
> 
> This makes the header usable by target independent code.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/translator.h | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


