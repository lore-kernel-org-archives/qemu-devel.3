Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1BA1CD3427
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 16:10:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM6jb-0004Tg-OY; Sun, 10 May 2026 12:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wM6jT-0004TD-PZ
 for qemu-devel@nongnu.org; Sun, 10 May 2026 12:10:20 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wM6jR-00020t-J7
 for qemu-devel@nongnu.org; Sun, 10 May 2026 12:10:19 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7dca4debedaso3635890a34.2
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 09:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778429415; x=1779034215; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C94n/xBXen0FCntVga0CiQStBSxLrimtHQYl3bifRu8=;
 b=dbLSxlbb08wNejiLLVU11rWeq1Mu+LgFKjCwEGCvW4Ug6xl/dn8NOcgTaPNnal5Imc
 Z+mQVy3poIKnGsa4OmFoMoqV7iveBiq93WLHg6O/nrBjoAomOQmI5kSdqk52o15ZhzSz
 5/4U/3g2toS7Ie3P0wkRL0MlKJCvgtlQgd/srDe4ec29mu+73Nd51IrM9BvUDmT70S0k
 9ayD8J4AX9+yJe856DJ2soiLKJD6ZgNMoSlgaUwgzaPSRRtX5WF6Rz792JJdY1JqLB1i
 AjfZKy50qqiwetbzhnst/juHXyHjJLPcrVqlW4pdEZ/NSOAx6hGTrJYVBcWdVqRehmmt
 zyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778429415; x=1779034215;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C94n/xBXen0FCntVga0CiQStBSxLrimtHQYl3bifRu8=;
 b=WXvk0mC2/7S7ko0jJvrMhpkJQHw38atGHNRuF9+y0x9kniKJj+guSRJVX+NEBc0WKu
 O16bUQGxJWeLcpFMZe/SIlYmaaSTJtjtlrSl3jJpZYNrvyA3FyJX7Agu6E8SvQ+mAWbk
 VX4kagqZdSgTalQ5AExPKI0CFXHt1IFc+wtPIw6l3qp+lw1JHGj8JHkWEjC5vN+qJ22h
 OyChFYV+u6ZTLt/3OmofwypOANJCAOLgM8Ssk7f2uNnY+QGTTmf+WRc6hKq9dFUc4xdN
 jhx98559UPirmP6uGTkqn7J3VJxLGwZCowqK4SNnp+NS7OJiZLs3KyNRlsSjbif1+2TJ
 DCtA==
X-Gm-Message-State: AOJu0Yw7YYP6ynusu/02F0bVz/jffBP5IJepnSgl6Y41iVMeXalxaR3x
 jI7gWFxxrQtA0btqvV5PuCv3hyIC4TCr4SLS+sv9AKS0aeF8DX171FlAgit0f7ZYzrXXHafQHIr
 TFQ6b
X-Gm-Gg: Acq92OFCE3bYTuFo4Bo2aZBXjeKVB3jYXnNMeYRLf4ZaaFyO2+jLmQfm09UnRg6Rgub
 XPl3vExt9BrPdGNHF66Uofe7ILAEz/lzIXx99TOGWHu1N0C0eJtA0hswXV4mXF/0+d+qbH14yZQ
 zvgBcQUKK81GQAIlBBbYb9h6t7KJplNgytnYd7w7U+4qqw+K3iBrwV3mDP3UHrhJBsaIm++O0YM
 0UepR4SKlZBWVkulkEcPL8/hnCCVNKZ7kQI0/tVUFNrsUFl04aZRZF1O5uEQL8Xpm1Q/YsUIpxJ
 hPL6SCLwm2Ob9tn8zBcDQthy90Nei8DHJ1JrsofaF6sMSMSjVWS+CtOK7HzNYOWshzx7naVvmvc
 oDMB9IAuZysl6MndwXc9ho1X1sBS0iu4xNAYoHewLTWd/E9siszkNBYP/rCx+1vD4UrpIdXrUn/
 zOwnzEzEBhE3OKJz9nnVCF1/vnxnBumy3FIaICIAqH6tsU8GQ3d1hSBblKAmbSsV1zYLK/Wew7A
 D5W9pgYoA==
X-Received: by 2002:a05:6830:3691:b0:7db:f6a1:3742 with SMTP id
 46e09a7af769-7e3821e4c3cmr3880933a34.28.1778429414668; 
 Sun, 10 May 2026 09:10:14 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:32c5:6ccf:a676:6508?
 ([2600:381:c938:6375:32c5:6ccf:a676:6508])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367c04e66sm5192468a34.8.2026.05.10.09.10.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 May 2026 09:10:14 -0700 (PDT)
Message-ID: <6c9f5061-14bc-47ef-a8d4-63ffefb47449@linaro.org>
Date: Sun, 10 May 2026 11:10:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/32] target/mips: add Octeon LBX instruction
To: qemu-devel@nongnu.org
References: <20260509-mips-octeon-missing-insns-v2-v4-0-d669dcd05c2f@gmail.com>
 <20260509-mips-octeon-missing-insns-v2-v4-8-d669dcd05c2f@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260509-mips-octeon-missing-insns-v2-v4-8-d669dcd05c2f@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

On 5/9/26 21:13, James Hilliard wrote:
> LBX performs an indexed signed byte load from base + index and writes the
> sign-extended result to rd.
> 
> Wire the existing indexed-load helper to MO_SB so Octeon user-mode
> binaries can use the signed byte variant alongside the existing LBUX
> path.
> 
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes v2 -> v3:
>    - Split LBX out of the combined Octeon arithmetic and memory
>      instruction patch.  (requested by Richard Henderson)
> ---
>   target/mips/tcg/octeon.decode      | 1 +
>   target/mips/tcg/octeon_translate.c | 1 +
>   2 files changed, 2 insertions(+)
> 
> diff --git a/target/mips/tcg/octeon.decode b/target/mips/tcg/octeon.decode
> index a2bfd0751d..efb1a48b38 100644
> --- a/target/mips/tcg/octeon.decode
> +++ b/target/mips/tcg/octeon.decode
> @@ -49,4 +49,5 @@ SNEI         011100 rs:5 rt:5 imm:s10 101111 &cmpi
>   LWX          011111 ..... ..... ..... 00000 001010 @lx
>   LHX          011111 ..... ..... ..... 00100 001010 @lx
>   LBUX         011111 ..... ..... ..... 00110 001010 @lx
> +LBX          011111 ..... ..... ..... 10110 001010 @lx
>   LDX          011111 ..... ..... ..... 01000 001010 @lx
> diff --git a/target/mips/tcg/octeon_translate.c b/target/mips/tcg/octeon_translate.c
> index 1893bf359f..ecdce6ab9b 100644
> --- a/target/mips/tcg/octeon_translate.c
> +++ b/target/mips/tcg/octeon_translate.c
> @@ -161,6 +161,7 @@ static bool trans_lx(DisasContext *ctx, arg_lx *a, MemOp mop)
>       return true;
>   }
>   
> +TRANS(LBX,  trans_lx, MO_SB);
>   TRANS(LBUX, trans_lx, MO_UB);
>   TRANS(LHX,  trans_lx, MO_SW);
>   TRANS(LWX,  trans_lx, MO_SL);
> 

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

