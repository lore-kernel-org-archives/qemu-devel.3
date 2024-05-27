Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11029C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 09:29:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBWf3-0004zj-HO; Mon, 27 May 2024 05:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBWep-0004tT-FV
 for qemu-devel@nongnu.org; Mon, 27 May 2024 05:28:43 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sBWen-0003hk-RY
 for qemu-devel@nongnu.org; Mon, 27 May 2024 05:28:43 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-421124a0b37so5758845e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 02:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716802119; x=1717406919; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bjmSA0ceZNruDSICAo9LXegyqfWu5ZH4aKcdf8Bdaqg=;
 b=nFRG0HHoadmi26PBQUavVvdwURx+JdAPE9BXnTbwMN6OLGt08Ydpp/9yL84rfpugGu
 lI1PLaH/4F5zJ9xqse6jXRa2Z4mW5+/E7rLgJFkgzEztw6rKTAC3Rg8L6dg+coLZRC5s
 Dj4j4vKh7C1wvPSLQy/PDRJ2tID7QtiOQT+dUEFQX6Y6EJq9DvRNgAFZb7VsosQOezqA
 XjyHPAwaHd+my+Dbjn2lYFa8aC/imCGs4qp4xS96ySTH52sYdr6orgRq70RW9m6ZmWuK
 0yZ/MkkwV+zwAmvoDfjDR8BExFJtP46nRPs0PS18daGeBZEv6pcFVzeAlBxrEVjSv1L3
 zbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716802119; x=1717406919;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bjmSA0ceZNruDSICAo9LXegyqfWu5ZH4aKcdf8Bdaqg=;
 b=LvejYrKNI/BcqIt8w3dhGBHtEjZnyEAXZNRkc/PJTdTHB181Gzy24sUp07lwFgJZ0X
 aY2MGaZq8xnWoV5YqzF6OYSvD0WhEiZswjZSbiCKJWGyHoRJY/PDowhHsgwvI7LJKPyy
 GQepXaeoGBl8ziS52Aa75gB8jHbdCQ8AFbXOk4AEnQIetNU+DDa2DFvtJn8amZkbjHh8
 4KugXcAuVZynpIrkGj8BHyh/gHUZy8e9KAFDwZypGaJ6yYTbr1wHDwpNOYwv3Zb4/OUc
 5R6kZmMQemgMi08EBrFA0/gFLiDiRhTGTbGwiqproDvkd7RjJfV7bc9DSqOTir7GQ/Ml
 cJog==
X-Forwarded-Encrypted: i=1;
 AJvYcCXd45HLU+C+B4z0vxEeX7Hq8C3R73/BCFVHfVhAD3QeFiKBEIaGp/xJjND63TBU8UxGUWGZXIMdZREsE7r7ngKPdYBt64k=
X-Gm-Message-State: AOJu0YxEBvTpFvsC+Lxl8UpDCsb+WmU4ZA9TDK9mdSxiOnlmeSmxtbVF
 a9p+HOzgKVGBsPJ+yXOr0TCY2g7vgmfL9jSdcBssQZuTAoZGKCHiI3aZTizZu+sdUIoBfxefwZM
 erkc=
X-Google-Smtp-Source: AGHT+IFBH+bimk6cXemainUXidLSwGdGFBUnxTYprRfu8CCV7idfdkJpPbmtiug5/zCJbZs/lpaNWg==
X-Received: by 2002:a7b:c44a:0:b0:41a:8055:8b89 with SMTP id
 5b1f17b1804b1-421089d50a0mr103087655e9.6.1716802118996; 
 Mon, 27 May 2024 02:28:38 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.152.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4210897bbd2sm104205175e9.21.2024.05.27.02.28.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 May 2024 02:28:38 -0700 (PDT)
Message-ID: <4a6f1923-b1f5-4e5e-898f-73f4222c2c78@linaro.org>
Date: Mon, 27 May 2024 11:28:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/system/target-arm: Re-alphabetize board list
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240520141421.1895138-1-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240520141421.1895138-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 20/5/24 16:14, Peter Maydell wrote:
> The board list in target-arm.rst is supposed to be in alphabetical
> order by the title text of each file (which is not the same as
> alphabetical order by filename).  A few items had got out of order;
> correct them.
> 
> The entry for
> "Facebook Yosemite v3.5 Platform and CraterLake Server (fby35)"
> remains out-of-order, because this is not its own file
> but is currently part of the aspeed.rst file.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   docs/system/target-arm.rst | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


