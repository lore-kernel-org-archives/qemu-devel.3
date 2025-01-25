Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D57C0218D
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 16:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbjVQ-00042Q-Hx; Sat, 25 Jan 2025 11:59:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbjVM-00041s-6I
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:59:32 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbjVK-0008RV-Nw
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 11:59:31 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ef6c56032eso4224409a91.2
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 08:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737824368; x=1738429168; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IJt+Ix/xlxl3gMVBEvF2fZ2IPm5nbtgWC1gpwRCvIwM=;
 b=P294oYf4MqXExGghiHTSeHc45uuzWgZWWvLqJt7VwcXrV7W9htLhIv2CYwtxkCfsjz
 qCxtunGm0BvX2koK97tHHUfmI4sZ9gJPVpvZdlG31G3xABat0WI22hqLjZ//SaqNyXsg
 KPI95H0Afx64oKbK1dkQpZR7Dxv1xFukvHKmJ3Q0LRmG8gTDA5A7ZHSYMR06zaO/SKnz
 ydY6BOtgVk6sSGj2Y8VzIkjFvbnV1ginyH7BCZBC0qSgF2uo76WX0UzCJXklDQ7Ced0r
 HSA/fWSyI3D2bhh6A3yI3tCXWnwcvJsJg16lf4zRwk3p4fcVd0eljF8/XYmGfL1623Ki
 GEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737824368; x=1738429168;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IJt+Ix/xlxl3gMVBEvF2fZ2IPm5nbtgWC1gpwRCvIwM=;
 b=j5+iDFgMB3a0Tx6oFHfdhDnytgoMGcqopQQLRDbug+jiAySmaizuTuRPvk9yMx8Bf0
 qPiPbwrexLztffARJKwi6lRLbCaLv1INbvEJF9Qv3BbkNKN0jC6TYL3gWBHLLxjEkGBK
 pmOYWuRTwV5tibZR9/o8E2hLxZ3Nl0kxK4vT0HKwYD6lUycSFv0hFb1NghTxj/fmfezb
 IhE28EsRh1WnfMxYHVtUDd+VMEw0lhYGz0HyxeGUUd7SOFReMF1NEmJO5bjpDKVFMSt4
 FmDL7i37C/kGXTcHnNsMajCvh7Ngg4fxaucz9wvwXwwfOjcJSIKBDMRPbcc0QfUlMERG
 qNeg==
X-Gm-Message-State: AOJu0Yx7C603BpjsrxKEw6U1X5Q/zMUUPky8juj0XCj79xLqPMbuCLJ8
 Rk9JGXZE+fmmlxQFmBkQkObtfvKe/vwVLNZp/RhAFXuqNBAHJaD4kt3UbOjcnjX4FJgucLatzcT
 g
X-Gm-Gg: ASbGncu9VPqx22y79mM8V7qIT4J6IqrB2iVMpCOEmKdLviDC8/0jyQM/0lGFn/HO62T
 xWkkpisC2vP7ae2/U+h9wU8MK9xGdgKQqyiO5UqPSSPAnIPFAGtJcwth+GuKxtvFi4vCltsiNC5
 DRMdJjh8b38pfwvd2s6pLdW7/lBG0Zv29TNL4NRbKcU/+H46D0E8ToR/b5txi5XlMhQT2gHsOgh
 XsdI1rAfdj2TvXZdULpcTU/JvdXP3LYQRbn5xXkZAlQ1fFvhyC7tAOI1J2WaHJuro1fvWsApIaU
 AkQfSe2BtwMcfmX5wue7YA==
X-Google-Smtp-Source: AGHT+IFxciqihGdi40UnPdblKzE6CCp+mkXRBwmlfF7z/admFHVjevPAnIVCWeX0kRMQUmp/zNFUOQ==
X-Received: by 2002:a17:90b:51c6:b0:2ee:fdf3:38dd with SMTP id
 98e67ed59e1d1-2f782d38454mr42708053a91.23.1737824367937; 
 Sat, 25 Jan 2025 08:59:27 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7ffaf80dfsm3793929a91.33.2025.01.25.08.59.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 08:59:27 -0800 (PST)
Message-ID: <bcdc54c9-2842-4974-891f-1f2fe69081f5@linaro.org>
Date: Sat, 25 Jan 2025 08:59:25 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/76] target/arm: Remove redundant advsimd float16 helpers
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-26-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-26-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 1/24/25 08:27, Peter Maydell wrote:
> The advsimd_addh etc helpers defined in helper-a64.c are identical to
> the vfp_addh etc helpers defined in helper-vfp.c: both take two
> float16 inputs (in a uint32_t type) plus a float_status* and are
> simple wrappers around the softfloat float16_* functions.
> 
> (The duplication seems to be a historical accident: we added the
> advsimd helpers in 2018 as part of the A64 implementation, and at
> that time there was no f16 emulation in A32.  Then later we added the
> A32 f16 handling by extending the existing VFP helper macros to
> generate f16 versions as well as f32 and f64, and didn't realise we
> could clean things up.)
> 
> Remove the now-unnecessary advsimd helpers and make the places that
> generated calls to them use the vfp helpers instead. Many of the
> helper functions were already unused.
> 
> (The remaining advsimd_ helpers are those which don't have vfp
> versions.)
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/helper-a64.h    |  8 --------
>   target/arm/tcg/helper-a64.c    |  9 ---------
>   target/arm/tcg/translate-a64.c | 16 ++++++++--------
>   3 files changed, 8 insertions(+), 25 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

