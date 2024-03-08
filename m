Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74CCC54E4A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 17:58:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rieTp-0004DB-GV; Fri, 08 Mar 2024 12:58:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rieTm-0004CI-Vb
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 12:57:58 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rieTl-0003Lh-Cg
 for qemu-devel@nongnu.org; Fri, 08 Mar 2024 12:57:58 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1dd5df90170so14243175ad.0
 for <qemu-devel@nongnu.org>; Fri, 08 Mar 2024 09:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709920675; x=1710525475; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MGIj4sa/0a6oJihBsfbSxlcUOeJaz+aH5AZRyH68X5c=;
 b=p2KpLNiaNKJRmIGnHvJtUxkzSZ527wXx5yuf/6SlIkLIenV5a4rXzPUyDBwt8piY8s
 8fXnkQgEsF0cReGl6K589CFZNHqTdQCInCkwAmD1arx0K+8Gy6fz36rkPbF7JbnZHLeF
 GB/n+oj5+0m3aLR0b/HQkgx7gPGNR4J8tnTYn35RqGkY001+IHX7le/HRJEugJFhzWuB
 98fOh2uCZtxy6B0yKggV4Kqd98EH8vbltnX1B5FVk/ZkRVFjtLmuSDcNpsCDGETnlkq6
 4FEzzKRn4j2vB0k/DaaMDpRoMk49MmAC2tzJ5Wr2rLAA43ie5gC9L4gHeVghKBnzN7vC
 1Qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709920675; x=1710525475;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MGIj4sa/0a6oJihBsfbSxlcUOeJaz+aH5AZRyH68X5c=;
 b=gPEUORMyY2kmuxw40NR60HH3hNdoaQR/TCKcsFyiaA0gF8ConY/UMLjBM2uh2D0UI0
 xg3/vWC+4Tv3k8u3AGDsPxQWbgn5cBgLgDfnLMSvsdYTriby1PDazaqYXkcnQmlhYka6
 CRBc7j67vFyngzhRRHsDVzncLfMBLiAKA0csDiaBBCqRNid0opOsrbnS0QYQ8bjrB0zD
 1dKUm8usJ+oqmYiMLgE4bajUACTe6a69F9zZ5xtXFxrHWBsvjEwIfLE0eLC+2ZVVQYyD
 wOFqhMq0veLA/OkguAerzIn8gX/oiEFNXf4g7iBByrh/h1ExtUjrJ/xl9VU1RKwjS/H4
 yh3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuipEpCBTvH1fFuP0G/CbcePG4T1F0GZMtbsXnKDfbe5Zp0LJlvm1gD4DcNP4ZXTngYlc7ZrP4VyYEatmX6mv0TRthPU8=
X-Gm-Message-State: AOJu0YxyfNkDpCyadz+4IjKD2oZXQz94YpmBLhuPGoSSwMkYB6E/VQ6k
 JRNtKFCEr7RAfJtblHhNTMHulwG2cJLymgb4G+hGdSF+fhMunT6EC81VJiHlOOE=
X-Google-Smtp-Source: AGHT+IGOZEJqU1IVW0sjNgVq5cSGpoSUZCPebuwTKOGBR0nusR4ooJfi1Rg3e7x8bYU+/r86wl9lFg==
X-Received: by 2002:a17:902:bf46:b0:1dc:7976:b52b with SMTP id
 u6-20020a170902bf4600b001dc7976b52bmr1273743pls.10.1709920675105; 
 Fri, 08 Mar 2024 09:57:55 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 o8-20020a170902d4c800b001da1fae8a73sm16560715plg.12.2024.03.08.09.57.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Mar 2024 09:57:54 -0800 (PST)
Message-ID: <467b4fbd-ef2b-449e-82cb-a4d939aa7669@linaro.org>
Date: Fri, 8 Mar 2024 07:57:50 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm: Deprecate various old Arm machine types
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
References: <20240308171621.3749894-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240308171621.3749894-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 3/8/24 07:16, Peter Maydell wrote:
> Mark all these machine types as depprecated.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   docs/about/deprecated.rst | 15 +++++++++++++++
>   hw/arm/gumstix.c          |  2 ++
>   hw/arm/mainstone.c        |  1 +
>   hw/arm/nseries.c          |  2 ++
>   hw/arm/palm.c             |  1 +
>   hw/arm/spitz.c            |  1 +
>   hw/arm/tosa.c             |  1 +
>   hw/arm/z2.c               |  1 +
>   8 files changed, 24 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

