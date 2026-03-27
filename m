Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B9810F284F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6APP-0006tH-Gb; Fri, 27 Mar 2026 12:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6API-0006md-Uo
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:51:37 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6APE-0005Nb-TQ
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 12:51:35 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-827270d50d4so2126796b3a.3
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 09:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774630291; x=1775235091; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/irkLxv5bCWp/tk2sTXleFBhzpOxO+kpxVoSiEnq6LY=;
 b=XubzX/qB/F8WUY5e99kaPwZ/ba9kKK80vnCBlsH+U/Bjo03raXsBWxhrRT6ThWhd3V
 8ATqtEN7zJqwd5sCZ/jpnZ+TP8gYMEreiGaUwIQd8mZAkzWchk3LtVE2IvGwlrh3tGXI
 yCEWHpOv4h2lEzXUb7GJUzENRuNaCaHD1rW3nF3qGHXVMGrwyXB2ZiB7ngzowDAEcw5C
 cIe3YF2zu6yNJSsCIiAtTynrR1p/UmhDUtUr3XcX+QPBpsb2BuiG5uVZWeSeTyrUV0HE
 WF2U6fvVBwRWkUaXxPDIkVM2lP3O1dr3Y0g4eO/R3/RdfzJdty85hnKcUjpsqSt+Z3j5
 hg/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774630291; x=1775235091;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/irkLxv5bCWp/tk2sTXleFBhzpOxO+kpxVoSiEnq6LY=;
 b=nxapsr0+sVB1t//IrAxm5yvHgl2AeHZ1VVzVM4b4E9tUKsGUgNFVtI1wNbqayxSF8W
 Os/lauK92ygvLlUnVZU83YrECweNYteKpNq4ViTP0U7ZQ2HzpJ+neKYNhHwU4NcUzyjp
 1hAIdP3HMNsKXBY3YCGMCUVs7r3VgKJikvY1epLkP6Y/V62Rtm51VnaZEJOgXI5ftRIW
 BJuz4ASUAiKC+T7CkzdjHIzK/7TiAGWAcFXJAoFMTCbnLXFMnKY+bToS5AFUNrVUQDoV
 iXKedmDaQgU89PUW8EevqSRBxpxGH02Ovb9fZMqyEX70+oXT9Lhjqj1ZNwesBx6ehl3h
 BBDQ==
X-Gm-Message-State: AOJu0YwV1DJzN2y5ZopIO3FJ+H56hNAfMuXn/g29j+OcixRl6KTBltMn
 JtoPtsnLhy5zQiKWrYm3Rp2mYv8IlqPDOxayPl8oqxrxNBBLBwiCPgzcN5NLZWNJKAQZsfSIuny
 vOSg2XRc=
X-Gm-Gg: ATEYQzzvVIVoBGFRorK2FOUkYmjm2i0IOBXQr/SBOv8sCTkU6g10cUAUoIpsdrYhz2L
 HYy/L186grEqEsB2hj6hfKfmwAxcu8eBO+F9XCLyoJYKh9D8L4PmrWKJjCIrimcdMZeNL7/EVVE
 6+KWQifVujfhUvzq9TmBPS23WxqMamNy65twEEBh5n12E22ufRQzz+7CVtO7I6sm4lJW5dqkNrs
 0XdtfH4sGv6Zl+10SflgopdqW29pCsHFjyhxas8At3SQv3Nm+0gAh0LAEYxA7lxIpLsth2k4diR
 xoBLcz8xhmW8+B6mJY/or2yuA8t9xAhrKsLgyX0dXh8FXLQRZe47+xX6CPV08/HpLR40hYFPZMb
 OQjhMSIH2Tzc7it2eF6T3Cr3SIMSM9ZmrNbj1/FyxHZTPyvJdRPnDanZ+ZB+Q2MO6dCE3EOBuoV
 qalShMfJguzU6Tfv/vQEzAfinXUAA37xszSUeza37uSjG4tmU3uswwgeFZWvcmG6Syu4NfEepYs
 /2FGpk=
X-Received: by 2002:a05:6a00:f93:b0:82a:6967:a06d with SMTP id
 d2e1a72fcca58-82c9602b9c9mr3084001b3a.57.1774630291414; 
 Fri, 27 Mar 2026 09:51:31 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c7d388f92sm7537880b3a.38.2026.03.27.09.51.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2026 09:51:30 -0700 (PDT)
Message-ID: <15c1c031-3a15-4b37-bf44-0a654d58797d@linaro.org>
Date: Fri, 27 Mar 2026 09:51:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] This series tackles (most of) the rest of
 target/arm, especially tcg folder.
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org, philmd@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260327164449.596767-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260327164449.596767-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 3/27/26 9:44 AM, Pierrick Bouvier wrote:
> We extract tcg memory operation in a new header, with a new type representing
> virtual addresses.
> 
> Initially, I went down the way to have a dynamic definition of TCGv, which
> required much more boilerplate and runtime checks. After discussing with
> Richard, I realized it was not needed, and that could simply split 32 and 64 bit
> properly in different files instead. This approach will not work with other
> architectures, requiring something else, but it's enough for target/arm.
> 
> Files left are:
> - target/arm/tcg/mve_helper.c
> - target/arm/tcg/m_helper.c
> - target/arm/tcg/cpu32.c
> 
> v5
> --
> 
> - reimplemented what v0 did with new approach defining new tcg-op-mem header
> - reapply all straightforward patches from v0
> - only translate.c is left, but first want to validate that changes here are ok
>    for maintainers before doing more.
> 
> v0
> --
> 
> See original thread:
> https://lore.kernel.org/qemu-devel/20260109053158.2800705-1-pierrick.bouvier@linaro.org/#t
> 
> Note about v1 -> v4
> -------------------
> 
> - After v0 which was trying to do too many changes, v1 to v4 focused on smaller
>    things, and all patches have been merged already.
>    https://patchew.org/QEMU/20260219040150.2098396-1-pierrick.bouvier@linaro.org/
> 
> Pierrick Bouvier (12):
>    include/tcg/tcg-op: extract memory operations to tcg-op-mem.h
>    target/arm/translate.h: remove tcg-op.h include
>    target/arm/tcg/translate.h: remove tcg-op-gvec.h include
>    target/arm/tcg/translate.h: remove TARGET_AARCH64
>    target/arm/tcg/translate-vfp.c: make compilation unit common
>    target/arm/tcg/translate-neon.c: make compilation unit common
>    target/arm/tcg/translate-mve.c: make compilation unit common
>    target/arm/tcg/translate-m-nocp.c: make compilation unit common
>    target/arm/tcg/op_helper.c: make compilation unit common
>    target/arm/tcg/gengvec.c: make compilation unit common
>    target/arm/tcg/translate.c: remove MO_TE usage
>    target/arm/tcg/translate.c: replace target_ulong with uint32_t
> 
>   include/tcg/tcg-op-mem.h       | 126 +++++++++++++++++++++++++++++++++
>   include/tcg/tcg-op.h           | 100 +-------------------------
>   target/arm/tcg/translate.h     |  14 +---
>   target/arm/tcg/op_helper.c     |   1 -
>   target/arm/tcg/stubs32.c       |  17 +++++
>   target/arm/tcg/translate-a64.c |   1 +
>   target/arm/tcg/translate-sme.c |   1 +
>   target/arm/tcg/translate-sve.c |   1 +
>   target/arm/tcg/translate.c     |   6 +-
>   target/arm/tcg/meson.build     |  29 ++++++--
>   10 files changed, 176 insertions(+), 120 deletions(-)
>   create mode 100644 include/tcg/tcg-op-mem.h
>   create mode 100644 target/arm/tcg/stubs32.c
> 

Please ignore this series, the cover letter was incomplete and the 
version number was reset for some reason.

Regards,
Pierrick

