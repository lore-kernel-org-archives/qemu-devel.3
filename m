Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA91C87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:55:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhbFc-0004vC-JQ; Thu, 31 Jul 2025 17:55:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhaxZ-0005k9-8c
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:37:09 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhaxX-0000g7-KH
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:37:08 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-24031a3e05cso11568075ad.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753997826; x=1754602626; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4lyau6g7ZS2X5dhFoC647e0I5kJk8G+2Y7odzEKMVBY=;
 b=iNAX1zi20Ih8nux4NqW4ZEHY/Ykn+yHXC94MGpilZmQDdyjFmDB0TVjuLVt+FSlaFT
 DyfAWVaXW9jRezyqNyX+Fu+PGVTHdJ2D8KPaEX9tyWoPWxvzqDuxz9Cw+Tw77nRguL+i
 jKrmMEuEAYTqzaJStTpjSQYOa569gC8z5989FQobSugihAd/ogqxSSwWvXi/qqDGbHIx
 xPy0VxA7sFFaN+gJdQFimB9653Ihq9noyW35o7chlB6ejsuVMiZPsCUNVapgW1v/5ysk
 5yyh+MMoLcNCPtEHBfuq2Okox9eoqg++LrUeQ/LsBdSADYw+sMj6IDl4RfieCq8qGJ1o
 ZGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753997826; x=1754602626;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4lyau6g7ZS2X5dhFoC647e0I5kJk8G+2Y7odzEKMVBY=;
 b=a3FNPdN1U6hMLsy7J+a/47bnLSzl7p2i/10Tmi+5YvpMNYN3T6DbwbHeIAFT/oKkBK
 A7/ecKlc4m2AXSui1lAWxv7eTtRhQD6AZ2gjRVidWEz7kMPMfCaVlPsqsGPi1pPnF25y
 iu1TnVAJPaahq5z/wJKbyTVDr5EqqqGQbf5rQMkiCJuIh03VDym6nn1/pH7MOaI2KoNH
 HXjZ1p1DALIPMVnoGGwTphvkjp+p/+EwZpbNzDGE0anAbNR9d7bP5RiuZvyjOxw9gN6V
 5gi/lzRj7fS2mh/Ghef/ZAgimwUta/WLJwIMDMpXz2IT+xO1VpDu/rrTspArNJ8L7M3c
 cXww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRTB+wGW+hZFqu6ao9o8mWh9rL5bGEdWPqa2djQTomRMzk9kJqNid+Sit6gDoKW5PQKsEHf04m/TMm@nongnu.org
X-Gm-Message-State: AOJu0YzB6WHsksHNHoLRYndwIWtzcSGHG2pbqsMNh8ko6zOLHiCQ6ddz
 iQ3YZPcPAm3twKSnGOg4plMwXCi7KO+2RzP2WaBLxhKlFrVscBCnjpwKphASexgo3kM=
X-Gm-Gg: ASbGncsIJFFLgg+zo659e30Hi5VIxnOfas9d8Dyo+c7XZCSlsP9QHITMMwpqYwt276+
 ippt/6jrjSTULbDt3FaL5IuMdALMad9HDYvsgv+FuS2sQgzC5oiz0kGdr/4X1j02/tqwO3/mPkp
 VQoJVNHyd7j8UsuuZOtBH77fb9KiSFVutPOOm68O6jX2yM6joTVUIzvGz0aZxR4KDxJ/hy/a4D3
 /J1NqS0FZnxAepJfhi5BwE767dCzNVnFUlWgJprDZWVT+8jrFdHM+urE/SZZDb5ZFQI1L2MIGiE
 wTM946sgAsJ/ww0ohwHw3oHYwZaFzCBjMMBODxQugDAJ1s4ogfaBbnd1XHPAnBaitbcWfiy+9ob
 rjnKHjaYpYJG4NDcjfF8qQLhdMSAy3nI404xVNT67xtlW1w==
X-Google-Smtp-Source: AGHT+IGuOKDF7frtcqHVLz9Q7TXc7FtHCMDBdUjiwRNjOXduin/2qLPwGEsSfeZA2ROEP4gc2IjmHA==
X-Received: by 2002:a17:903:2345:b0:240:3f43:260 with SMTP id
 d9443c01a7336-24200d2c79cmr51136015ad.17.1753997826190; 
 Thu, 31 Jul 2025 14:37:06 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d21dsm26003825ad.139.2025.07.31.14.37.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:37:05 -0700 (PDT)
Message-ID: <509aa5b1-d2bf-4e07-b3f7-97366f4abcfc@linaro.org>
Date: Thu, 31 Jul 2025 14:37:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 59/82] target/arm: Implement GCSPOPX
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-60-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-60-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpregs.h            |  1 +
>   target/arm/cpregs-gcs.c        |  3 +++
>   target/arm/tcg/translate-a64.c | 37 ++++++++++++++++++++++++++++++++++
>   3 files changed, 41 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


