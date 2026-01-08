Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE227D1D48A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdwGU-00085m-Rm; Thu, 08 Jan 2026 15:05:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwGT-000850-28
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:05:49 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwGR-0007o4-IR
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:05:48 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a2ea96930cso26746675ad.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 12:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767902746; x=1768507546; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Eca1/bTgJm0CzM7sCdiqvzs9RLCU4xA44/QNJhBl5Gk=;
 b=EOAJfMLXiaQLc7Df2GJndCAqGen1khmdP/nCSVanpQis0xOz/2ouE7UGMj81wZPpJq
 TA6fwWo9VdwAYo8GCHOK4bk5pGqfSz9STcebkPYSTP72GFS3tWBYnKFt9Z86C8boJqpR
 ofWW/Img6uXpajhg1/XkZ8Wivio5hsnF5roZ63d6FMhp01FWKZKPXlUFP0h12tk8cOw9
 dpRb20ByZeU+E0+Oe9UWqmKB4f37n5La+ORXMk/nEWPy9A346lagclJiTh1qGEnBLkI5
 XssCk7rMOS8f7JiWW8rHTizriLf8n6w+tsFNcOVvykM0nSmPTHnln/IeKWn6HcUzIezT
 F1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767902746; x=1768507546;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Eca1/bTgJm0CzM7sCdiqvzs9RLCU4xA44/QNJhBl5Gk=;
 b=a8WKka7wMqYDEzWQUmysAlJZL8t2jlljNK9nMcKD7YNbnlACPbB3U8w3LSDIf3d8zs
 rgFX5XfmJWNxniYMU420msTHFewqHy9Nej54mgmBd5wFnNBRbpI4jwsBo14r8+qDnb1q
 NERjZLABui1TH8J45qOizYhh8FA6sG1Azd4JRZXVWQ7S73QbnIS3VjS88qY0ixxOg/xO
 tKOX/x6oKfuP4P4VtblxUbiXmYnILgmL3v+cu3xsho+P8XCZI+H7pYiJB4e0mDUUbnqx
 iuBY0SFLHx80UdBf37q8DrNGHFj91wHR/owk9lUUin6TdX7mk/Hy5zuuX9en3kAUVmTJ
 t/cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUqCroo1j5HFpQ2tA9kE5wFyrF2pdqMqnWCZUK7ni3CtqMn/pTlksgsRBi1b7gOfs4X3wvrirtAAjoO@nongnu.org
X-Gm-Message-State: AOJu0Ywy5W4+HSo/wV7uuUplja3kbS+T9JpWG7eNpMF1gfSca0oMiHEN
 Z05gL5n2Tg56WaGW4uqg2ad+E5wXMlpKu/+7coefXxt1zp29AJR/GsstzFV1dNT33s8=
X-Gm-Gg: AY/fxX7nrU2uddbBkea5g1vrBcPJUR4s8W5TCGiG5u3O4LETk9Tx3OKLVWNxnbKVYiq
 secdB1MSwNSULSo/p5hLMz1BGXP8aMu4lW86zJQgavkW6z4pccmR4DzJFzUsn+C9MYsWI8skLuS
 WCQBpz5fbCqYyzm5FV0oU4F/vaFqYBe/3udEEJbfyXNDsrgQuO8g/Fnr7uUtDXx/+SpwV2DDZVb
 +ruXijMi7MJXrG7JKKIrMdFN8qrJmWp7RyhB/bv/y1cQ6lFN9LatPNKMGbOBAI88jatDgvZDma6
 wPU3HJAbepA+OjUuzh/o/Qk6ShjB5yFlAcllJ7vbRe4Uam2yXTM0SijiKHKX19kZKAdGKFBW7OI
 g3dHdB+vU+rU5CnvGo1FNxjk0WfwoboWaQKAJ+O+odQTr/0ibQIUOGnmYUsidQWGJGi0es38i2t
 XQaZWr9KoBWaXQcXSWylj0Ge8yD4NYSpNrsZA5zvq/bpegdodK/3+rMWYL
X-Google-Smtp-Source: AGHT+IF7gC9/C/38ySSpllApSZgmo7/5TVFAbBhdcMaNMKTRsIPZOrhUTx4serN5fUQWyKICU+y7Zw==
X-Received: by 2002:a17:902:f54b:b0:2a0:a9f8:48f7 with SMTP id
 d9443c01a7336-2a3ee513ce6mr64555425ad.55.1767902745968; 
 Thu, 08 Jan 2026 12:05:45 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c4796asm87072055ad.34.2026.01.08.12.05.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:05:45 -0800 (PST)
Message-ID: <9408ea62-ae35-4d49-ad79-739c1f3952dd@linaro.org>
Date: Thu, 8 Jan 2026 12:05:45 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/50] *: Remove __i386__ tests
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-6-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 1/7/26 9:29 PM, Richard Henderson wrote:
> Remove instances of __i386__, except from tests and imported headers.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/atomic.h     |  4 ++--
>   include/qemu/cacheflush.h |  2 +-
>   include/qemu/osdep.h      |  4 +---
>   include/qemu/processor.h  |  2 +-
>   include/qemu/timer.h      |  9 ---------
>   tcg/tci/tcg-target-mo.h   |  2 +-
>   accel/kvm/kvm-all.c       |  2 +-
>   disas/disas-host.c        |  6 ------
>   hw/display/xenfb.c        | 10 +---------
>   linux-user/syscall.c      |  9 ---------
>   target/i386/cpu.c         | 10 ----------
>   util/cacheflush.c         |  2 +-
>   configure                 |  2 --
>   13 files changed, 9 insertions(+), 55 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

