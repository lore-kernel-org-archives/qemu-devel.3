Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66210C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 21:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgA10-0006mR-0H; Fri, 01 Mar 2024 16:01:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgA0o-0006l9-Pk
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 16:01:47 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rgA0n-00032d-6E
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 16:01:46 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1d93edfa76dso24067055ad.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 13:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709326903; x=1709931703; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RU9YZj8AagaoCGRFPs6L7I/TWTREjW4XzxioQtL0dMU=;
 b=ZYNegoMBEESxaeJ7j69RIyJoywrKnym+iv9yN/KygchO/QSbu2oziaOqz5imo+YJtK
 teZmJO8rcTf/D/NnaqMVWB/hCLVfrzXB+MdMnDjP6lNtiQya4ew6tP+V8K0h6sW4C/fM
 Pi32a++Sz5hj1sJBbRrkmUcDuB4Ef5aCjj9uZk4cxoh5nYR9bbzQchv0PJpflXHLy6lH
 ih0ZLZTQTHCzguvdFiEUUz4hZC6Q2RyDjB5ddwKgaN0LjLL/NZCUD4hgKI87QNd3lr7h
 BaFHjqYSJadG+XUga4cK27d5Pki/jslaxpC7IreWiGdXlG3+CSXLxRU+mbEuGIkW38IP
 1YhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709326903; x=1709931703;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RU9YZj8AagaoCGRFPs6L7I/TWTREjW4XzxioQtL0dMU=;
 b=hT4iGT6jpm+PPuKaRKgEVSWioqOjMbSEhCck9vOXXOS9KywNcoLoKxOjkl0hYlxJMs
 rKghAeLKYGJMv3DcQKgo3RyjnuXRdTvavjNDc5D1yv87gm+gpnnL+RPFFFx+6nEMf7uD
 gHJHvd3/47EWdZ7kShoevT2altxu24ZyxYVI1ZVUsUei4rrBTJCcmxqhJN6NQkgeVtou
 EgCkC10Nc3q4tLG8x466Hm0yi8rdcprQP/EzGantLGVU5vzCl8YoqzXqdCci5cUJfpsc
 g5DJl2eTObbk3i1vK9JckOE1SVegngwKkil77afXxCUdjTRqJY2/QWNnVNu4UygobRxq
 p8ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeySJ5J5nb3SCBjP0W+PMjqXXVLNT0Xd1KWTqUQ/R/uqMqrPzKEvur8gTe0FBuPq7a1zgnIjBjYcweNSIlRU4aiRzQsUU=
X-Gm-Message-State: AOJu0YyNjL0kll2skcBsjVhmeMzX+tH/tX5PO2uxH9qcWoy9RUupPSvj
 j8950oTqrTY5UMSzCW1N30t/tspzk5xd07N7/ZSiloJ+qGwJSThs3NRMAJsvmjnD8DctGR3LYdA
 Y
X-Google-Smtp-Source: AGHT+IG7gs9HJqJG/ebg6DWVzjVEPvW2UlkVVj9nt/TQnLav2AHRcEBQlcgkuetWAbiimVlSE9qmsg==
X-Received: by 2002:a17:903:984:b0:1dc:8b82:7f56 with SMTP id
 mb4-20020a170903098400b001dc8b827f56mr3315619plb.20.1709326903319; 
 Fri, 01 Mar 2024 13:01:43 -0800 (PST)
Received: from [192.168.6.128] (098-147-055-211.res.spectrum.com.
 [98.147.55.211]) by smtp.gmail.com with ESMTPSA id
 w7-20020a170902e88700b001dba739d15bsm3908461plg.76.2024.03.01.13.01.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 13:01:42 -0800 (PST)
Message-ID: <c48b6ae6-87ae-4033-8a64-0ce756115922@linaro.org>
Date: Fri, 1 Mar 2024 11:01:39 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] target/arm: Move some register related defines to
 internals.h
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20240301183219.2424889-1-peter.maydell@linaro.org>
 <20240301183219.2424889-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240301183219.2424889-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 3/1/24 08:32, Peter Maydell wrote:
> cpu.h has a lot of #defines relating to CPU register fields.
> Most of these aren't actually used outside target/arm code,
> so there's no point in cluttering up the cpu.h file with them.
> Move some easy ones to internals.h.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> I want to add some more CNTHCTL_* values, and don't really
> want to put more into cpu.h. There's obviously more that could
> be moved here, but I don't want to get into doing too much
> all at once. I pondered having a different file for these,
> but probably we'd end up pulling it in everywhere we do
> internals.h.
> ---
>   target/arm/cpu.h       | 128 -----------------------------------------
>   target/arm/internals.h | 128 +++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 128 insertions(+), 128 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

