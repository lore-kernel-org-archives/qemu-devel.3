Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53F3107BCCA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15Wj-0008BG-J1; Fri, 13 Mar 2026 12:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15Wb-0007mP-Np
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:38:11 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15WZ-0001mS-V4
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:38:09 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2ae43042ea7so29942945ad.0
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773419886; x=1774024686; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6nCzdDl2nB0jpBnhJl/hjnM99dUjhCei3ACDuNEj9Io=;
 b=qu4pPQgx4ep9SnA1OgSkDDOK4pmwO8VXSSCm0LSCdFtr4WKOdVubvyN8vizGRH2ePE
 HiJWE7YPSzr6pLSQ/k4jJtUDMoYUjqDYSemoIieiwKMFEOqreVdC16w6TKGBquT/l76C
 lpboUJ+nZArGdGMV6Eo1KeqgtOTv7gBcKBA653w+jaKpTcHuef9d6kApdDFnzAN664Ct
 PctS0sKm9hqpMrskDYh/owZt7z2OfVJeBm08ke7uJ2UD7evWVBr7ST+quF6B3fL0dcNF
 106tfxInQ7TJjvLgwKUo6Qw0+kxj4jFQkHEf+NYkSBSs4UB0/kdFvsFKrCxsksf93SbO
 kHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773419886; x=1774024686;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6nCzdDl2nB0jpBnhJl/hjnM99dUjhCei3ACDuNEj9Io=;
 b=ZvvKYqztgmaAvRbLHY7DbSTfnNy4nVkZCbSDfRfJFLgXOBJHH5pVmxHTuAQX0Gt2Vo
 C3fSFLRSvKD5R9bpnxShF686o+y9KcgC8Qlk4FMM2DY+AXPoq5c0E41QRao4mTViUoph
 V/fSnKEfjiJFhxVIcVPsg0ZaqvRmLH5r98JDO9Yk2ExH7Skrk9Qi+cJKrKn+FmtErCzd
 DsBq8o8aatnqO5rE+UXOl2eYCwSBea0hLSiSq8GomE3Ql8ifzAxmHi2Ze1s5m0qWQkIv
 GtIKFlTdQsKqT4/3TQnt70EPlXflq+yJmjybo67ectTDhkMbiK3nzQ5xnFAZo9ixinzh
 Y5rA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUS1xrg3J0ewfX8JT529jEBncq+pqBgH5Ou9c3AZgCWtVumD/1n5zVoiVFb509lwlCIZUAlozz1PMgq@nongnu.org
X-Gm-Message-State: AOJu0YzQ24tApiMI7Vml0UeTA6z+p5dCJ8uUOJoog8HU9MH5zJarFpKl
 6vux7kVMTvKNDnS7GU5Xwd3w7VOypMXezZ8PGx1Z9EGelgViG9gLSST7lQzvFR7tvKA=
X-Gm-Gg: ATEYQzzoxRKNpGr8l84MjFJN1bIgQeBZH45xqPfYaSGXI2JgzpNBN6hfn+URUTBCqwh
 O20Tke9RI+5iGJ/jOebDF5GKGtifSvZVTPewQEhCRWKgxE+cKutYSuMUc5DJF+yfieJp+L2Uq+Q
 /1QYzwZPZ/CuQHMnsQEmJ5rpdvBqSCwClS2nIEmCQ0mRMYKQumAgXuvy4M/McxS8/Dz1QWHMGxS
 2u3DfDmvtZVD7x+qtEn/pwUD1OsOgEZiby3eYT1m6LBgnZVBAv3/3D4fOZnXFBp5Et4gQgUpzeN
 5XMscKuKgrFvhfNiOWChCT58fXICO45+duySXTXyan04jIWNrFgiPc6vliXjQUb+QrXBDm0kRvE
 FllgZmE40qCu9tMGTJybJ2C+k1g8ZVSLhqM1GkTVxsdsYLtXrnmUGj+Qr/K+oFBQJy1vqMpmPVO
 AB/+BlmR+ODK9ETOGyVS89F6eRKq+R+Pv/tHPR8AhSJiwNaXcVdr2xWPYqdVLluosiKk2x
X-Received: by 2002:a17:902:d48c:b0:2b0:41f7:5243 with SMTP id
 d9443c01a7336-2b041f755f6mr76115ad.15.1773419886423; 
 Fri, 13 Mar 2026 09:38:06 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece56ca0csm28491855ad.4.2026.03.13.09.38.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:38:06 -0700 (PDT)
Message-ID: <39f03f28-759d-4862-b799-90b98f53eb63@linaro.org>
Date: Fri, 13 Mar 2026 09:38:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/38] hw/misc/cpc: Include missing 'hw/core/cpu.h'
 header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260313062055.2188-1-philmd@linaro.org>
 <20260313062055.2188-17-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260313062055.2188-17-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

On 3/12/26 11:20 PM, Philippe Mathieu-Daudé wrote:
> The "hw/core/cpu.h" header is indirectly included. Include it
> explicitly otherwise we get when refactoring unrelated headers:
> 
>    ../hw/misc/mips_cpc.c:36:53: error: unknown type name 'run_on_cpu_data'
>       36 | static void mips_cpu_reset_async_work(CPUState *cs, run_on_cpu_data data)
>          |                                                     ^
>    ../hw/misc/mips_cpc.c:40:5: error: call to undeclared function 'cpu_reset'
>         40 |     cpu_reset(cs);
>            |     ^
>    ../hw/misc/riscv_cpc.c:34:54: error: unknown type name 'run_on_cpu_data'
>       34 | static void riscv_cpu_reset_async_work(CPUState *cs, run_on_cpu_data data)
>          |                                                      ^
>    ../hw/misc/riscv_cpc.c:39:5: error: call to undeclared function 'cpu_reset'
>       39 |     cpu_reset(cs);
>          |     ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/misc/mips_cpc.c  | 1 +
>   hw/misc/riscv_cpc.c | 1 +
>   2 files changed, 2 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

