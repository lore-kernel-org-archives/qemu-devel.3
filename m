Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EE5C531CB
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 21:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtBBZ-0003ol-OT; Thu, 19 Feb 2026 16:03:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBBY-0003n9-JP
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:03:44 -0500
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vtBBV-0002cJ-Q0
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 16:03:44 -0500
Received: by mail-pj1-x1042.google.com with SMTP id
 98e67ed59e1d1-3562212b427so533435a91.1
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 13:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771535020; x=1772139820; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xPiistLA6v1uPrsfXr0FuYDuWp3vPMvkA+I8hbj1+kk=;
 b=TNYgfXVnii5tCsAWdEKKCONAuCljlmleUFdgTWidJfqLbNcwe7B6jf5wuV1Jg1w3pj
 2yi+z81Z2UoKy1TB/uXnb38sNDn3ghw/FEjVYFixVL8/tLXfFupS6hBVxzHhsA6l4Y0E
 oti6hITpmj7ESGJhyNWGr5buK3htaTJYYId+CCBPFyF6FyE1SFMjQf8urMDEfYT91pBP
 T3lIIps+njtubFV4dGao0mDl4MD9iTCzCeGnt17da78Dydcik0dz5Xfz98RUQwOP53FH
 wipvHxpW68fNAPLuO7J6h9ewPEoZuXjFDENSpVTe23LMwAwhUoEfDuCSYPs6iM0Hn+bI
 RxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771535020; x=1772139820;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xPiistLA6v1uPrsfXr0FuYDuWp3vPMvkA+I8hbj1+kk=;
 b=sJjih17R7U88jVgMA+Y086nScM/lA7Vnh9IWR8rfnG79NrZruuz66JV+JHZlNH66nJ
 mMfMHXKPovFGsfZeOabPetGdBFJY+3lLVO+h7pj4Ikd+tY0//I0YFEG71hWlxP7stiKI
 c05ULfF4AMiSiUkB2iSOGWS8/eCDsKn0Tp4W+lUB3BZ6KdhJWKDm8zzSH4bCdGO43IoZ
 Wt3yt7LWq4jZu48dT1P59KT9tpcEDoziaReFfJeYtiq1QagqF4Lrg0gCxexYs0opL+P2
 leNdir1jvyAxe84SqA/PURatg64A8WpjbtkL17fgDSbBNgtNknzyR8z9kolPl9kqdz4X
 4UYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdW13LAXW1GK3OOxDyyvrHv7yARvrmBev2sFXMtnf1xN+kywwN6RsY/omvnsHbZzHeatlIttRl8OZm@nongnu.org
X-Gm-Message-State: AOJu0YzadwrIMYn3aJ++0ddI5wuszCAu5L6kt9Paukbv2e6q3Qh7zaEx
 zbQZl2FENw+egoYGfrvRReU04GI/Ed7otjHEOw+Mt5VNP4ZKo6SWWEQlOhOYZXJ6BbCMvmiuijB
 Cn1KnruM=
X-Gm-Gg: AZuq6aIj+9rP0nDZPnFSpdgHSrFj1UjgItP942trGYHc8EoifbsYpFNxwOdIRWOe7UM
 QaGQAHI/oTomPpmXGvuakJPAAiUEhQZlYk/Yb43FOq6tjZM9EGB6JVp56SxcEDjSK27ftbkud7b
 6Qb25wP1uQZYPa9fgcAfmA6dy8+RejGEBPVDBHospJxF8Z6UfyPdewnM208VtEYCHq6eTwZ8QFS
 4Vvb1re0IxJ8vbidLF/+G1y33xcGSLQhZB460ZT3hykizky/a2FlGKQIP4yZZYdMQzZelAcDRbz
 U3DStBXk855sEBpUVsoxZCVe2bQVKtM4kM3YVd2Blaj6H3450LwPFdXanO5qIKMnzO3gq7cgF15
 mTF19zX8KuJJIpHT3ToMcJzjKaKwKaLEwNPgRi7/xLeIMtA0KM7J+Ml+t9icDFcLjNNW6xnWuAZ
 xkB0MooFu7pBG9Uczpo/xX58Yj+buuR2Gol/PdqqVLjHe19Y7jr1Z4bnX2H1La73cDdt+e
X-Received: by 2002:a17:90b:3c0a:b0:356:2fc5:30e4 with SMTP id
 98e67ed59e1d1-358890a167cmr5038858a91.2.1771535020282; 
 Thu, 19 Feb 2026 13:03:40 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c6e5333d2b4sm17555396a12.33.2026.02.19.13.03.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Feb 2026 13:03:39 -0800 (PST)
Message-ID: <264b620c-7012-4144-9cd0-5c7c20d1a8a3@linaro.org>
Date: Thu, 19 Feb 2026 13:03:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/50] target/alpha: Document gdbstub register indexes
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org
References: <20260219191955.83815-1-philmd@linaro.org>
 <20260219191955.83815-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260219191955.83815-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1042.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/19/26 11:19 AM, Philippe Mathieu-Daudé wrote:
> Follow GDB XML comments. Re-order switch cases for clarity.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/alpha/gdbstub.c | 25 ++++++++++++-------------
>   1 file changed, 12 insertions(+), 13 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

