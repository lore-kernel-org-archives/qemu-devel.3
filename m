Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0B3CD37AC
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 17:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLP1j-0001cr-EX; Fri, 08 May 2026 13:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLP1g-0001cH-Gb
 for qemu-devel@nongnu.org; Fri, 08 May 2026 13:30:12 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wLP1d-0005sE-I7
 for qemu-devel@nongnu.org; Fri, 08 May 2026 13:30:12 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6948fb494a0so1233270eaf.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 10:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778261407; x=1778866207; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Hb1EH9Xrzx9rxL5gZMbpieqiGBVfWSH4VhI5pKGThkU=;
 b=sHC/EUC0LmToCPcNJopXi6P6PFP/Ut00423EelARjF9nZS8zcNs4znN81JUzShZMxL
 0ItqLDWHK1y+piA5kz6WNBYAq9OE6O5KiMdwtlG4LfNC51c07FN5lzolCnSVCuFArfxJ
 mJFPOzNVa26IwQ0xUrZxfFyHOyyEK/AZRxhkAqVG+yiVQMRT+lWB43JzEs+whicbygwl
 ouvG6ln0YkYKFGManL//nP4c0UAxB6WdqPd5+WOi7mVm4kMaSov9UNFLVNtBG+oRmkHb
 2gCTVWACGAXGxoJLsZg7Q0+BNQ2F/YCj/awgyJ6rHfd12F6bB7Dp08G2oFH9NZdHHMCD
 L2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778261407; x=1778866207;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Hb1EH9Xrzx9rxL5gZMbpieqiGBVfWSH4VhI5pKGThkU=;
 b=Hs42Ot14qPy0RqtOrWsJ3AMBPxHISu3Mr37G48JOI1DNXh1VuCbjSV0rn++VLJz7/3
 xtBcYjDRNCmMEsla8Os1xQtdKfRqU9Qpi7IDGaLo972kdUc87pKb4tEIbt+LP7zqx7VT
 rUNplvHEvna7/bP4uAeVftNHg/FixKc31U7k8rNVAuvQgmYlB1c4ZKDvVIIpsSR2MYxZ
 qp50mQFzr9ZwkqRYkfM/WLFvNj9lY1tZGjn4FwWx54YgFrBMoAulHTqHXnJkv+IBrUgB
 +HAnQUXx+AahSwXiBlHwo4D2Pa0df2XDkwfHuAX5cUCZ/uT37QiaXQ8mmJyC+lXUkfmy
 cblw==
X-Gm-Message-State: AOJu0Yxfp9/DqufFc3cZ2z+l97YA6bZdR1rUxrX379x36tqMnZIXzutz
 LwXEuiXkMyA4L5efWzgiCIQkNYcEzryz2a1xq3KeqdebZzziUlznoU++dv97LG7bqS4GwU83kUw
 5JMSx
X-Gm-Gg: AeBDievzS+akhd0uc82dRQlV88D9M3XBg4VAn9hJa0yEpNRwzoTzQY/RQNmBar31AqU
 mpU9UgmezPIaWY/lXWAF8GJny51xdWPzzWBdpoanVix5jWb5Qj6TbHNeQIGiLaJyNPzixtJuQI1
 zRuUMVT46mXLj4dASL/5OMals5ZTaGQ4go9mBQKvxF8EUHNXQovsVoJNgi/p49Z7gl3rfPHlWXv
 lu7brY1kt0cUVE9i44QxfqaO8ZATqCWd+4GIa6WRCXtW2/Pmn0OkJLtZ6rgkcphSp7jpC9cXiDz
 5tKF4mEWcK9BkrpUmrsLxkXHKhBz5LEBZOrUoBaxZCoo23eGTJdeMdFEmLYzlWO6VEYNPxvcfIx
 KQue4p5z8r4At5wnIx5sJ+tSiRAl/bWYmzpgzVimUxZ2X/mRBCoA7uJfffUnZJz6/6KprO5kCYR
 IG98kfllMbzEKcPrFeW5HMdwJuOTzqZYKkOLyPvQC87ut5bAB4v64bfzxL3tPERZymseWQcAGkd
 0z1FfPGzQ==
X-Received: by 2002:a05:6820:1621:b0:696:1a25:fddc with SMTP id
 006d021491bc7-69998cdf2a7mr7023102eaf.23.1778261407427; 
 Fri, 08 May 2026 10:30:07 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:4b0a:aabe:cbe1:bd0c?
 ([2600:381:c938:6375:4b0a:aabe:cbe1:bd0c])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69b25dbffdbsm1412511eaf.9.2026.05.08.10.30.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 10:30:07 -0700 (PDT)
Message-ID: <810e5b86-4885-49ba-960d-f4841214727c@linaro.org>
Date: Fri, 8 May 2026 12:30:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/32] target/mips: split Octeon SEQ/SNE decode
To: qemu-devel@nongnu.org
References: <20260508-mips-octeon-missing-insns-v2-v3-0-bcbec96357d9@gmail.com>
 <20260508-mips-octeon-missing-insns-v2-v3-5-bcbec96357d9@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260508-mips-octeon-missing-insns-v2-v3-5-bcbec96357d9@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/8/26 10:12, James Hilliard wrote:
> Decode the equality and inequality forms as explicit SEQ/SNE and
> SEQI/SNEI instructions rather than using shared generated SEQNE/SEQNEI
> entries.
> 
> The explicit decoder names match the architectural mnemonics, which makes
> the translator entry points and trace/debug output easier to correlate
> with the instruction set.
> 
> Signed-off-by: James Hilliard<james.hilliard1@gmail.com>
> ---
> Changes v1 -> v2:
>    - Split the SEQ/SNE decode cleanup out of the Octeon arithmetic
>      instruction patch.  (suggested by Philippe Mathieu-Daudé)
> 
> Changes v2 -> v3:
>    - Remove the decoded ne field now that the instructions are split.
>    - Reuse @r3 for SEQ/SNE and pass the TCG condition into a shared
>      translator helper.  (suggested by Richard Henderson)
> ---
>   target/mips/tcg/octeon.decode      |  7 +++--
>   target/mips/tcg/octeon_translate.c | 52 ++++++++++++++++++++------------------
>   2 files changed, 32 insertions(+), 27 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

