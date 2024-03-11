Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78D00C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 04:50:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjXb5-0000qt-Nj; Mon, 11 Mar 2024 00:49:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rjXb1-0000px-N8
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 00:49:08 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rjXaz-0008Ip-Bq
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 00:49:07 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-29bc1c64a98so1142311a91.1
 for <qemu-devel@nongnu.org>; Sun, 10 Mar 2024 21:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710132544; x=1710737344; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/e4wRTuByfzJr5hJ+kzcrOqf+rLyOL7Yw+rLf16X83U=;
 b=Zf1Ee0JwMaDc9Ip4aOl7WvQ0ZBy2Q3HTPxu3XTAwGYowegz5HdoD6QbyFbuVPZPHaW
 So1AwxURPQKOUsgcDozr2rpdWeThZ3oGEnfyevCfL/5kZFgNJCJ9b4Laxdb3MeJCZje4
 B9FN6X90ZLYuxTNLiZZyg5ZX6O6Gugi98ekjMnYBIGvPftynL5TNSESrlPh2c7AGMnnA
 YoUw3M9uvPEKEuO5CY6/TwdIFy4j5sjNPfj9ex8Zwe9PdoswxMgLTLxeP322Zok7zxe8
 e0xcEAzFmJAIgrS7d9iFv8lhALm+FM1q2CtVO+nNPoEcASfEjLNaZiZzws0s3Lx8yjVK
 OAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710132544; x=1710737344;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/e4wRTuByfzJr5hJ+kzcrOqf+rLyOL7Yw+rLf16X83U=;
 b=oCTzlmzTL3AmyRKgR/Yrn+kLLx2Ye/qA6WEg9fimyR3adxLtzlpvNgWVw21BU2Q1um
 uIZ2Wos4Gq5CExuHKQVrHaQvXHXCCe5QGNoVreMdbhTgeaL+mdEXW89lGwy4gDZjyoNJ
 TnVR6xfFscpG2v9UMSconrF2XoyNllDXnqa9zIvVKdG2A4Qhl9//Pd2KfXMToXN/oV9B
 neKkBpuWcUJIMlWnjxCS+cokDUc8ADv4taAamV/uo5Bghr4VP63T/XvasQCt9xRhYGj5
 VwP8oLyNOaSA0ZgCo6sBeAxB7+A29YmcLBnIiP0dsgac1bgIKcOfOWwpFqsjmYgfoioy
 nyVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW7rafmB2eSyzVu/WZ3Le2tXkX/Mkj7FAEkFeEk8I+f8fE6aTX6XRQjKr0GWG5+3nYiBgdqGkhjA7455CbSZTFI1PFiyI=
X-Gm-Message-State: AOJu0YxJOTephkKVqUR7Kbhkz6j5xoRqL/Y4SAzuB6Cmcn0QwScud3GF
 W7AoT++EXVN9/IFczYXwflBGhuOMeuJcrHufcrJyNZ5RpnnZ2FPwA2gze+enqI4=
X-Google-Smtp-Source: AGHT+IHi5dTtiBEUbQyd+afWu5XBC2/G3mzVlT6gQRc/iyhwfy8P6b2rBgPAiGdB0cby0wJhMBpyFg==
X-Received: by 2002:a17:90a:db8c:b0:29b:aec3:6de7 with SMTP id
 h12-20020a17090adb8c00b0029baec36de7mr3087186pjv.1.1710132543593; 
 Sun, 10 Mar 2024 21:49:03 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 i22-20020a17090a7e1600b0029be7922b32sm1861144pjl.26.2024.03.10.21.49.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Mar 2024 21:49:03 -0700 (PDT)
Message-ID: <e0954d6d-3d46-4620-875a-bdffebaf0a81@linaro.org>
Date: Sun, 10 Mar 2024 18:48:58 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: raise an exception when CSRRS/CSRRC
 writes a read-only CSR
Content-Language: en-US
To: Yu-Ming Chang <yumin686@andestech.com>, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20240311030852.53831-1-yumin686@andestech.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240311030852.53831-1-yumin686@andestech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

On 3/10/24 17:08, Yu-Ming Chang via wrote:
> Both CSRRS and CSRRC always read the addressed CSR and cause any read side
> effects regardless of rs1 and rd fields. Note that if rs1 specifies a register
> holding a zero value other than x0, the instruction will still attempt to write
> the unmodified value back to the CSR and will cause any attendant side effects.
> 
> So if CSRRS or CSRRC tries to write a read-only CSR with rs1 which specifies
> a register holding a zero value, an illegal instruction exception should be
> raised.
> 
> Signed-off-by: Yu-Ming Chang<yumin686@andestech.com>
> ---
> This incorporated the comments from Richard. Thank you.
> 
>   target/riscv/cpu.h       |  2 ++
>   target/riscv/csr.c       | 17 ++++++++++++++---
>   target/riscv/op_helper.c |  2 +-
>   3 files changed, 17 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

