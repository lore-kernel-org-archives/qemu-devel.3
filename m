Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD922C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 11:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUPE3-0001MB-Vo; Thu, 18 Jul 2024 07:23:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUPE1-0001KU-60
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 07:23:06 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUPDy-0002jG-Am
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 07:23:04 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-70b0bc1ef81so465042b3a.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 04:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721301779; x=1721906579; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0Q7UeEV4A9p8C4pcuCowp2XB9ebCU4ZNoKKU0owdUVg=;
 b=IgTpCvbiotS4p8p0Npf2GlChARYtm8wdq0Sr2kUQLhkAVgL52rzQdEQGEFaxYqNj6N
 RYJ/mQK7J2XBbec+pe6kPf0iPPGxMQ+oLzOFAWXyn2Deou5VKTjOsAM7qN4H9CRH8ZrF
 qx+nIjoIBOQMpWJiF4zN2qv6IU6K4dugVJOPumpJj1LK11sv7aSo+YdvgG39mhv4/+hN
 c5jFj/DQ+ahZu7yTH1wz/Yb6quXd5yVuDbVTBxK1xwiHYXlvR++8+UnI9aiJuNgxWncy
 R04ADjqoaMKiKmCtIk7yJypTYRRCZbKTXDRpWc2u41m3F45r6I13PyzLyIaQTcW4UfJP
 SivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721301779; x=1721906579;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0Q7UeEV4A9p8C4pcuCowp2XB9ebCU4ZNoKKU0owdUVg=;
 b=h0K/PfhvBUyappHlVkqkXrcDaQoYAsixixmp7Nabo3VbQ9163XLLLom7JIiMoMm3So
 W6S1pc95OQdJZTYfwtgsd18sf8KOSFTLQCbMYcV5K6LsFwRXXx5Hp62J/e7yZ2aiDRjw
 rF1HEd7acIGJXIml71Wtkg0MfpcRHtIkdL8RjVD9VOvSSoOxbr+i7SBQ7I3z/vhXOK6o
 LjR1UIpSkftvxmNJ9DSVzvwwNit3bfe7w3zMU/iboe0GGy46yhzQBZcoq4rQ1lMnm1W7
 Hkcba3M6qvVsXspM1euONRjYxLyVP6XAszsgZZeBsqQ4BYySkV5D1mGm2XDZjZ9mdN97
 kyrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6nRdT9voh6/4ytzKb7IjB/EFoORoG0cwGFaLmwRBTvoahvE0H+ZLndaHYGljmLFopecoH8s8nEfBUTHv+yH8CaTxAdYY=
X-Gm-Message-State: AOJu0YxVvqhr2iOL4qGeHFuqAy+cu6db6vQ/FmXJvyCzArTIrGIWPE6j
 gz6ZbQSi0fkeWX2ywBfYCG0sVCGIw//O+7MA0S5f9yZwEYtMLURtrHFEagTRmgc=
X-Google-Smtp-Source: AGHT+IE8bwxjQOopbawcVBbhZYxo6wVOkCx7KackGpDlaf0Dw+nm5YrEobLrM/NkgHP8BZw+t45NAg==
X-Received: by 2002:a05:6a21:4d8a:b0:1c3:cfc2:2b1f with SMTP id
 adf61e73a8af0-1c3fdd4d424mr4537265637.37.1721301778964; 
 Thu, 18 Jul 2024 04:22:58 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cb77345e2dsm438023a91.27.2024.07.18.04.22.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 04:22:58 -0700 (PDT)
Message-ID: <80c3e53a-6b75-4976-bad3-4a681f6cdb9b@linaro.org>
Date: Thu, 18 Jul 2024 21:22:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/16] Trivial patches for 2024-07-17
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20240717110640.844335-1-mjt@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240717110640.844335-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 7/17/24 21:06, Michael Tokarev wrote:
> The following changes since commit e2f346aa98646e84eabe0256f89d08e89b1837cf:
> 
>    Merge tag 'sdmmc-20240716' ofhttps://github.com/philmd/qemu into staging (2024-07-17 07:59:31 +1000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/mjt0k/qemu.git tags/pull-trivial-patches
> 
> for you to fetch changes up to 66a8de9889ceb929e2abe7fb0e424f45210d9dda:
> 
>    meson: Update meson-buildoptions.sh (2024-07-17 14:04:15 +0300)
> 
> ----------------------------------------------------------------
> trivial patches for 2024-07-17

Applied, thanks.

r~

