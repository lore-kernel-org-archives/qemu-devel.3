Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2454CC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 21:59:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgAuJ-0008WA-Uc; Fri, 01 Mar 2024 16:59:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgAuD-0008VI-Kj
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 16:59:01 -0500
Received: from mail-pg1-x52b.google.com ([2607:f8b0:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgAu9-00021s-7d
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 16:59:00 -0500
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-5d8b276979aso1969209a12.2
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 13:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709330335; x=1709935135; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5jT0CxuJEnE5tUgTaHMHdXhkiNyo/OhNsWLxNmpXTVo=;
 b=SJNenJokP5VJ1+HiV//uj7+cYa7nc7QKD2XQQCTRLw6/Wy6XfouaM8TNIbsFrK4IAz
 GNSw49ItQDJnIfp9tN3aGcZBZ6igmhTjqhi+oRY2mnKfmLiuk8JOvSu0SvK4OxqC9hic
 y6wjh1OOIM1jylEzX3zqABNE6KtGdX8loSUbB2v8grBcu8YuD3aChjDNLXhWaXpF+xfZ
 OHuZJ5tsZyFoxICyc1nKCfETbBSvbhDgH+YV4fWtBM+2WsTkzuP3qvSiOiG5WlGGzhnV
 fttc4FJjgvQG3yGEw0L77v//mn+rX7vsqMGjqB4yvkbP1GDGuPnA+MhyQivzolIo9/aw
 vriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709330335; x=1709935135;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5jT0CxuJEnE5tUgTaHMHdXhkiNyo/OhNsWLxNmpXTVo=;
 b=bqCJdotFtq1v2Js/Xn/0InJ+aIl43zqfPKkn+KhtJ/XaX1F+4mIuQ3CyyePY0gBmhT
 4i6UvsOWweTCGdcz7iAOmFBP4fpn6T7x9Up3UynKYzkwYu6RlBNQH9g1IYJWDjnnYxAR
 Z4FhGSYsx6wDdZZ3pXD+o6Fy9KCe/dQGqy0K6sHzNr/+NpAjQWm+yHctJ7kqqnZViboW
 Ao4s2cNlamcwq1DbrvJE/8P3ZnklCrNR1cn+VMRHJKHfY1lKnYy5LQ59U57zZ3xv7cC6
 GrNt07f7DC2HjJypK3QKIel6/u1EYbne6t5ktDT39vbMnp+HicTbxDTVlYmSAKDvKE9l
 MXcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWygGGrRsWBXKU22nWUh/voLCsaqXRfwiANOHcnfP5ukUOHfHt1504sqaI7lUWZqbdUFf7oNwnhB7Lvz0fL67boh9QCjzs=
X-Gm-Message-State: AOJu0Yy1kQ1mbYoW9lshhsypTnKuLxTE9vZZ1GezttdXTneDz4TzetPw
 RsZ+VuY0jhjewnj8rQqb7ia1Df6fgQFNkYN/UvTBeZtXdOxe7Nj238Kj0fW0XwvB6QxtowBYbvi
 A
X-Google-Smtp-Source: AGHT+IFopOMWgMG0xxw8L/9vu23FKmKgk+CxfPARCxFHqJO4TU1eaE5r8XqDKiHmGjg9P8I2KR8z+A==
X-Received: by 2002:a17:90a:b881:b0:29a:8c78:9a7 with SMTP id
 o1-20020a17090ab88100b0029a8c7809a7mr2709892pjr.40.1709330334887; 
 Fri, 01 Mar 2024 13:58:54 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 db12-20020a17090ad64c00b00298ca3a93f1sm6006165pjb.4.2024.03.01.13.58.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 13:58:54 -0800 (PST)
Message-ID: <81774643-dee7-4279-b622-f9435373401c@linaro.org>
Date: Fri, 1 Mar 2024 11:58:50 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] target/arm: Enable FEAT_ECV for 'max' CPU
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20240301183219.2424889-1-peter.maydell@linaro.org>
 <20240301183219.2424889-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240301183219.2424889-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 3/1/24 08:32, Peter Maydell wrote:
> Enable all FEAT_ECV features on the 'max' CPU.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   docs/system/arm/emulation.rst | 1 +
>   target/arm/tcg/cpu64.c        | 1 +
>   2 files changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

