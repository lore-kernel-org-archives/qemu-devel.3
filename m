Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDB0ECD9B1
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 22:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo7r0-0003YO-PL; Thu, 05 Feb 2026 17:29:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vo7qz-0003YA-4t
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 17:29:37 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vo7qx-0004MU-K2
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 17:29:36 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-81ecbdfdcebso75910b3a.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 14:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770330573; x=1770935373; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=09jWMdr15BvFAbuq7rsBoKCGwxMj0jZwNnFD5Bsj3zw=;
 b=HVjuV1UBg+C03BPSgxYmYricHFOigNkOENb/ndh90LtPDypQyDAsH9nXeOm+UqcAdI
 Vs7GKlC87rdZifunMhqTtyNH5JYmnPb2IHIUYR9te8WtaVQH0jnAJIzYLofY3ax6Nvco
 oU8frUtTrg8Jq1JUA1hVCWuTKweGDu3/eHgxDt6yPcku2dgjEYqG2sG+0AqJTldCCdvD
 1gB8XQ0Ae+NyCM4pn9tL74n8+xRHSC1C40gynt1d/6N2y/f2pcpmXH05I3CHCjoHKyt/
 kHVknmyPNFStRSdTF/daA8ATFY36YQCg8qFKmV3Wj2p12Xij5i+D4CKPVHG3P/RVQp8a
 BdrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770330573; x=1770935373;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=09jWMdr15BvFAbuq7rsBoKCGwxMj0jZwNnFD5Bsj3zw=;
 b=bWKMDACaJpLbLjzC8DUhrfZQFBTCN+cXtI2I6UEf6UFu3FvQLmzSgeygkz3vmv1psS
 BGrleoHb0GsFfibK3ksfpHVqqPqkTr9oJq/k3DWqVGZn2kw5C1kizTShQG/zHKJ0e2rL
 68DnJ3hVZCypT58Xip/tVA7G3Pj3Nrh2Nv660e7N6ny8jARDJLzK63NTsZEw5Qc9zh++
 PAp73z33uLVsImQUR/JIAR5E+BNvkkG0GxoawUArqMZMR2+FVzMGgdWzFoZe8jyZnbtR
 a3VTucUn+e8f324uvCKrRcjUt8BoM5zXVpirEh9/GKsEZXvoDRO9YlAT7f1azw3gVvsx
 QTYA==
X-Gm-Message-State: AOJu0Yz8WpuJQmJCTWbcFd0xc39JeGkWk69wMC7saN9E2q3AzFKQWa64
 HnarAWf/sfkqk6ElenEMjrHy3pt+HDTwM9uOKSubVPsdje8YAVkELcEImwEGGz4YXv4=
X-Gm-Gg: AZuq6aINUXupDFSuIFwx7BRQDoGxZG4qTUSqRxDbWwdXJm5f6+Gdxs7W6CpYv/Bqrup
 X1EdUt7o3A1ol+xDhULxsW+TBWHd0C6iDLWsKJfYv/zPb0PbGGYEx2Tc+/9OgjWvjaHto57QXQw
 bIGT3DWZ/FRmd6ZYCj9PjBqMweN1fbxm6owp937DcAqPwc8boFE48YK/bPyiuS4Nz+RxTaCaUbS
 ULZlIIBxLp7Bt6K/kcgvXtlF4RSb/VHvZbj5oIOwBRzRD6/3YFIsI9NzKBeNhEeEldWbXH3a6fg
 x7gTPy/ByIM956Qgba4t2py3ECYTbDsJdfxMp354f85WTpMLpWi64OwKFGLqpBosGmpERjV1unF
 qwo2QoBXDD19INBrPA5RLc5X570AQ8pNrYV5NSmxH1fq/zojy8Z+BUf1I/ieo9J5ImRob/Ty8Yz
 pW7GTock7djEOu5lMiULVj0J8ETP6Pnvh46pnaqj5T3yl9IOQuoEHXA7qpSn8/KAmHkSqMTIKj
X-Received: by 2002:a05:6a20:3d85:b0:366:14b0:4b04 with SMTP id
 adf61e73a8af0-393ad39fbc7mr779165637.64.1770330573354; 
 Thu, 05 Feb 2026 14:29:33 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:3c5e:852f:abc3:6539?
 ([2401:d002:dc0f:2100:3c5e:852f:abc3:6539])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6dcb658243sm409489a12.34.2026.02.05.14.29.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Feb 2026 14:29:32 -0800 (PST)
Message-ID: <c2cb0273-de90-439b-9058-c4b57df86fce@linaro.org>
Date: Fri, 6 Feb 2026 08:29:26 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] tcg/optimize: possibly expand deposit into zero
 with shifts
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <20260204052456.970605-1-richard.henderson@linaro.org>
 <20260204052456.970605-7-richard.henderson@linaro.org>
 <4bfd463a-f7ba-4bea-9fd5-27c1a05045f4@redhat.com>
 <4f299aca-b1f5-473e-9cd8-dc1fe997d19d@linaro.org>
 <CABgObfb3zP3TYCz04Rmg+2HZbXZjKFvuACqznJm56ET9NhBhzw@mail.gmail.com>
 <5c46d3a3-e046-46a1-ac5c-5588a2179441@linaro.org>
 <CABgObfZArFHKHjwbWBmWP09OegtfiCpAQuQLtSrWax0tzc_hSA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CABgObfZArFHKHjwbWBmWP09OegtfiCpAQuQLtSrWax0tzc_hSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 2/5/26 18:22, Paolo Bonzini wrote:
> 
> 
> Il mer 4 feb 2026, 21:46 Richard Henderson <richard.henderson@linaro.org 
> <mailto:richard.henderson@linaro.org>> ha scritto:
> 
>     On 2/4/26 20:41, Paolo Bonzini wrote:
>      >     This is primarily for x86.
>      >
>      >     (1) movz is 2 operand, so that may avoid clobbering an input,
>      >     (2) movz is 3-4 byte whereas and r/i32 is 6-7 byte.
>      >
>      >     Because of these, there's a comment somewhere that says we'll prefer extract
>     over and
>      >     (perhaps in tcg_gen_andi_* or fold_and).  IIRC this also happens to simplify
>     ppc and
>      >     s390x
>      >     insn selection (and vs rotate and mask).  AFAIK, no other hosts are penalized.
>      >
>      >
>      > I think it would be better to pick a canonical form for AND with 2^n-1 and handle
>      > conversion to extract (like PPC rotates or movz) in the backend.
>      >
>      > Picking AND as the canonical form also avoids makes the macros for extract validity
>      > simpler too; adding an extra constraint for immediate 2^n-1 is easier and it
>     generalizes
>      > to other PPC rotate and mask cases.
> 
>     Picking AND means we have to use "r,0,ri" for x86, losing register allocation flexibility.
> 
> 
> Then could you wrap the target specific extract_valid with one that allows ofs == 0 if AND 
> allows the immediate 2^len-1? That would also simplify this series.

I don't understand your suggestion here.


r~

