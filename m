Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB678C46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 23:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSmV4-00022L-Et; Wed, 24 Jan 2024 18:17:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmV1-00021l-M8
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:17:39 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rSmUz-0005UY-Pw
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 18:17:39 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-6ddc2a78829so568318b3a.3
 for <qemu-devel@nongnu.org>; Wed, 24 Jan 2024 15:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706138256; x=1706743056; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ar8qTwZwDiCd6oqwxtRWwP5S2G1AsLdhKA+gGlZlmdA=;
 b=cZTGgw+l+qo1JmgnxpElGtJ0s1mJwVqxfyORH7//nio2Mpd2pRWKl3bPzXFgdGmT/5
 v2NHk7W0ru+bVnW2TwpI8rGjfs/aQ0eo9tUuBSfD/ZMAiGlN1ntrlowZ19ZMGZPew4GN
 GSPdOIUgPUsZc3DAI+3B2QS4Cj88P607VZ6hSP6fiVUCPyDw6VEYV4GDXFuTpHMXWpHt
 2ouiUxCo+I1O/FLP1iULE4izSPHriUOGZm8g56nl93orkP/77wkj9roUR/I/aN9/MADE
 M3S57vhnapEGizh1RLVN2No0DY87MhXp3mst/qjNbWqTERlAlmhI1m1Kgc3EMbi0A2C+
 wTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706138256; x=1706743056;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ar8qTwZwDiCd6oqwxtRWwP5S2G1AsLdhKA+gGlZlmdA=;
 b=OpJC8SXd3cwmXMMlABHyaNhU15/6IuA/o+es2SQIKSWC3bJ0z5jTqi8PBegQ+4HnSs
 AY4i7XrAjFQdYCWyVGdqT+PYdZXx5LhzyjzylFo8Llq+XBw5JVl6R25fMhcC9LYhy0ZW
 kBLMd8GrZ6f252j/7RK5mLO17n4aDe2rGBZMuCdhq/eq9PaSopeCy1PPoFRwy2OSQKuC
 1t8o/nLSHTMmvENRG6Ylvx+i3+lQsMb6zGgtzYZlsNE6fIX7ygFfOo0SYqB6O9Dq+0N/
 OQBnL/t+fK7qWJLXYbNCEbOmWsjpghyrIZkquzLELInSUreN0s3WLVyoMH59a4wsqRuK
 L1Mw==
X-Gm-Message-State: AOJu0YyjsJMcFl+4opYmfGHWC1Tqvx4z6P/3N23a4FbUfreJ1CjouAlc
 qEQ+Spq+4SlLxdImDYM60c0GIdcCGVQQb1CSqz/81QA1Icf4eeihRa+6/S3Z7Mdvor+3f7ENwt1
 d
X-Google-Smtp-Source: AGHT+IEBoYbHGNdOIsdi+dWFga9rN2fW+CovYelG+DTP/N6JtbKRwtEcEQJWKTd9wgSC4+MJ2ymonw==
X-Received: by 2002:a05:6a00:2d1c:b0:6d9:af69:b704 with SMTP id
 fa28-20020a056a002d1c00b006d9af69b704mr321198pfb.13.1706138256382; 
 Wed, 24 Jan 2024 15:17:36 -0800 (PST)
Received: from ?IPV6:2001:44b8:2176:c800:5fcf:9e3:2e58:9c7?
 (2001-44b8-2176-c800-5fcf-09e3-2e58-09c7.static.ipv6.internode.on.net.
 [2001:44b8:2176:c800:5fcf:9e3:2e58:9c7])
 by smtp.gmail.com with ESMTPSA id
 ks11-20020a056a004b8b00b006d6b91c6eb6sm14657150pfb.13.2024.01.24.15.17.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jan 2024 15:17:36 -0800 (PST)
Message-ID: <6c17d610-e029-4614-9275-f5420d0b05df@linaro.org>
Date: Thu, 25 Jan 2024 09:17:30 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] hw/arm/aspeed: Introduce aspeed_soc_cpu_type()
 helper
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
References: <20240123224842.18485-1-philmd@linaro.org>
 <20240123224842.18485-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240123224842.18485-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

On 1/24/24 08:48, Philippe Mathieu-Daudé wrote:
> In order to alter AspeedSoCClass::cpu_type in the next
> commit, introduce the aspeed_soc_cpu_type() helper to
> retrieve the per-SoC CPU type from AspeedSoCClass.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/hw/arm/aspeed_soc.h | 1 +
>   hw/arm/aspeed_ast10x0.c     | 2 +-
>   hw/arm/aspeed_ast2400.c     | 3 ++-
>   hw/arm/aspeed_ast2600.c     | 3 ++-
>   hw/arm/aspeed_soc_common.c  | 5 +++++
>   5 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/inclu

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

