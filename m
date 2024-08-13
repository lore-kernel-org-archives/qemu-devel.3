Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6292C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 11:05:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdpKb-0000bB-K6; Tue, 13 Aug 2024 07:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdpKa-0000Wm-Fb
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 07:04:48 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdpKV-0005H8-Rx
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 07:04:47 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-3db145c8010so3587387b6e.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 04:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723547082; x=1724151882; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sZxl9SFeOTV033dHu4UjIahbcujxFKpYB0Z9Nej2UhQ=;
 b=gB8CHaQ6uu4gJ4NsTDPx/C8XyXUc0Wnosfi8fK/kfLC/IK09SzjR3HORDrXMdfTq8Z
 +7m1QjcNe+Jubv6c7oVptDYpSl4bEJXsUpS1n5hI7rgy0iGIvqP760cE0DCQXINLEnH7
 PwLiJhuFPytdjI5ZE/hR4XkJi7ykO41iYsPisxYoDbBCSCjV+S5VRHZW7Vj65ZQMTBAm
 kj3R2aXbxKxZTzszIEURxg1sVTEaAGWY1113xXri9wlMi2puZ7/2TRCxgRj8uQDupKxx
 NsDYyYQSlt+6deADoqc5+ATjRyjzk5C17YyvZ5gdEouzml/zdOTBvcPNaj+CaJTLg8PW
 1XSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723547082; x=1724151882;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sZxl9SFeOTV033dHu4UjIahbcujxFKpYB0Z9Nej2UhQ=;
 b=DFAVsaZF6Xb0DT0EJoiUF/PSEiiN73rIcoLLLiK9baMo+cg6TpEeqgv40jnpiRxJKD
 4cT16Dj4EikWJ2Ao3eRoMf2gO6XIqoHI0VTZj7zH7snxvQ5AV4pHHOQNjg+NIR4DqcRj
 2B++X1XqT4CjQtlm8rhlkPiEiWrpsRfhf35DyIVoeik2WDtgTzVBWtJ2cS0YpRB5+VfH
 SLsPMNgsmGtvfHKMBFImxaPzoSpBbPRy6+HMJG1LWFv3/uUQ5cbgD2ZKG7nasV+/8ZIZ
 +H1HohETUyFtggWMg+XOi0kCDohAkFKi3LWd4S0mkpParHsC53vtXrxSE9WKk8E027IT
 n+yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ+e2V72C7MQbWl+yqu+6LZSeULZA+1FlNT9QS+/Wpe+euUhC7Cu4TR7GUa3itu7JgGNXSUEVL5OEZc8daurh3HQg0ufg=
X-Gm-Message-State: AOJu0Yyb4ZB2UJtiIjFUCus/AqPWhTXf40PhH/QcY0HOUnoJZiT5k2NJ
 jaO3QnK8FZuby6GO6yWbb/xdg/iCX9TibppadPc6YUXcmFWKP2OequxPJOI9Scc=
X-Google-Smtp-Source: AGHT+IGuDosxhMnPpBdsokWxigVXy7KJJGmAL8nhg3+1w/Vb/NWvZhNMcqUXIf82gRr8wVloJJN6nw==
X-Received: by 2002:a05:6808:16ac:b0:3db:15ed:2a21 with SMTP id
 5614622812f47-3dd1ee075c7mr3665902b6e.16.1723547081593; 
 Tue, 13 Aug 2024 04:04:41 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7c6979d3d58sm1205062a12.18.2024.08.13.04.04.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Aug 2024 04:04:41 -0700 (PDT)
Message-ID: <046bd8dd-5385-4f34-a6b5-e98941431a33@linaro.org>
Date: Tue, 13 Aug 2024 21:04:33 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 2/2] target/mips: Use correct MMU index in
 get_pte()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Waldemar Brodkorb <wbx@uclibc-ng.org>
References: <20240813101856.49469-1-philmd@linaro.org>
 <20240813101856.49469-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813101856.49469-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

On 8/13/24 20:18, Philippe Mathieu-Daudé wrote:
> When refactoring page_table_walk_refill() in commit 4e999bf419
> we missed the indirect call to cpu_mmu_index() in get_pte():
> 
>    page_table_walk_refill()
>    -> get_pte()
>       -> cpu_ld[lq]_code()
>          -> cpu_mmu_index()
> 
> Since we don't mask anymore the modes in hflags, cpu_mmu_index()
> can return UM or SM, while we only expect KM or ERL.
> 
> Fix by propagating ptw_mmu_idx to get_pte(), and use the
> cpu_ld/st_code_mmu() API with the correct MemOpIdx.
> 
> Reported-by: Thomas Petazzoni<thomas.petazzoni@bootlin.com>
> Reported-by: Waldemar Brodkorb<wbx@uclibc-ng.org>
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/2470
> Fixes: 4e999bf419 ("target/mips: Pass ptw_mmu_idx down from mips_cpu_tlb_fill")
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/mips/tcg/sysemu/tlb_helper.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

