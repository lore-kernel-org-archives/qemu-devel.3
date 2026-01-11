Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5945DD2502F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Jan 2026 07:40:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veq3I-0006de-0k; Sun, 11 Jan 2026 02:39:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veq2k-0006UF-0s
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 02:39:22 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veq2i-0007yY-FD
 for qemu-devel@nongnu.org; Sun, 11 Jan 2026 02:39:21 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-81df6a302b1so1908824b3a.2
 for <qemu-devel@nongnu.org>; Sat, 10 Jan 2026 23:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768117159; x=1768721959; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=QIy9B8YCiM+vNW/Lwl/JBdngfDJvJlvS/FkxS0xJ5MA=;
 b=WVcoT+vAhpq+PcVC5twuTuzJLUCoE8FOaNV4GqM4rx6SXhsEmb9DfEH5qGuF+ZnDFC
 8OAfSolXy2WXXWnvHD5y6ifhUMsne4G4LJZNJLVZijSVnRbtIExbJcx1NG1GXLU15xTD
 Sn+dTo4sVIIirsf0AnfStN98w7JMLXkkyl4/gm3bzncV2m2/XKi9kLMZMTnjNl/7GGg1
 zbmVRqo8DhFSrKqxZCn63gXwPl8pAoN/GjZjqI+rmRV2+S3QM5qmTwNbUh6NWC9JXZwg
 wGCS6G1bI6xufeGItta+ufwZErj6tcsIze0bZX1w1ZX/cFrcbokoloUCUcMH1WiCQWPT
 ruiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768117159; x=1768721959;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QIy9B8YCiM+vNW/Lwl/JBdngfDJvJlvS/FkxS0xJ5MA=;
 b=vuQ3kSBFW+UxMlO/bbq1HWZtmfW8L395Qu2tMExKFgVe9HCLMDktszoJ1JjsNr1OSO
 J0EOyLlTZpidwQLrHje97zxAVpfKnfIvoedEQVhlKCw/rA71Cc4Wr6QCr+8+j6YtPKPZ
 KNF+CJw0E6xa61Gg3yi/X2fISSr7RYxMKA9xCLr/+8rbhh3YaY/2Sc0hhsNnyU0pqYgR
 Xpr+WNGerDZUGkbF4rOtLI5ZZZR2WOgUwITmZW5rf1VD45HTO2adLHxx09Ogl3UhzaPp
 Gx4f4MPM/4rpBJzkY6XCER01SGovftN7OYw4Q8g+Lx2AyQra3v8LiGxpgW3t3m0H6Ofw
 0L5Q==
X-Gm-Message-State: AOJu0YxcrqbbgugpD+gLkP/5RVNzXZEUo49LOoTsIOTcX1lTDx1dBFc6
 0X6KemGn1mOFX8EHQhy6ZHKsMQvaTd2ZbtxqK8ZZSvHxtBVvFrPSReLX9Vz3ZbNLJ8qCBK7+Lm4
 H7i1xVLA=
X-Gm-Gg: AY/fxX6fI5h8PNBHfpWDcF1WYLX1xb2CCE+JXgpE7z62cUIdpolSmQu5GUznO68j4sZ
 ZNibBdImRK1kj0CJwrUpfJZ8e885eV2tFJS3fibYRkO3vKzoOyl8hv9mTFhsk22FS8+bLr/iXCy
 N/SxQr01SrsC2JU1fvHasmTXipARhVaqwZwVP74+47sKtsOiJPQooXmgvY4sM6Y1Vwt+gDrm9Xp
 hym+oAGmVeB2RmTXM6wwB8/1AOrUWwtJGSqgCuY1ZzP/wwxDyoLSF1b9dOjmDVhkYNaMRnOIpgQ
 HdIasjrT2qgEMAzmW9Es9qRXf6xdRv0yeOcN6or/wOkofgiWz0qT1I6ASQHyzwHzgrrgSOWnlEK
 okxj07G2nDXDj0riB49S9jj8Es+XNP8XQsG531IVCWKZIJAdYztJ1g6p5XB6RS+kOZyxqCjQVB5
 O0Yc3cTYR8bt/L/hyw8PMGpQVnjQ==
X-Google-Smtp-Source: AGHT+IFfKqNbpuuG8ZIIUTOsjr3xfvNK7hfx7xoLwWoqfPC6JdqcnYn3KLm4aFobte4Lps+44XbdQQ==
X-Received: by 2002:a05:6a00:1d2a:b0:81f:4063:f1e4 with SMTP id
 d2e1a72fcca58-81f4063f409mr2814210b3a.56.1768117158691; 
 Sat, 10 Jan 2026 23:39:18 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81e4633957asm1360746b3a.18.2026.01.10.23.39.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Jan 2026 23:39:17 -0800 (PST)
Message-ID: <de77d952-af2e-4100-9b07-6f75c2cd3e0f@linaro.org>
Date: Sun, 11 Jan 2026 18:39:12 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg/optimize: Fix a_mask computation for orc
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, qemu-stable@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260111071137.433005-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260111071137.433005-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 1/11/26 18:11, Richard Henderson wrote:
> In computing a_mask, for or, we remove the bits from t1->o_mask
> which are known to be zero.  For orc, the bits known to be zero
> are the inverse of those known to be one.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: cc4033ee47c ("tcg/optimize: Build and use zero, one and affected bits in fold_orc")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index 23278799af..5ae26e4a10 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -2360,7 +2360,7 @@ static bool fold_orc(OptContext *ctx, TCGOp *op)
>       s_mask = t1->s_mask & t2->s_mask;
>   
>       /* Affected bits are those not known one, masked by those known one. */
> -    a_mask = ~t1->o_mask & t2->o_mask;
> +    a_mask = ~t1->o_mask & ~t2->o_mask;
>   
>       return fold_masks_zosa(ctx, op, z_mask, o_mask, s_mask, a_mask);
>   }

I meant to mention, that this bug is exposed by Paolo's fix to actually make use of 
a_mask: tests/tcg/hexagon/hvx_misc fails.


r~

