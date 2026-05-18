Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376F0CD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 20:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP4MW-00056x-0O; Mon, 18 May 2026 16:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wP4MQ-00056d-J4
 for qemu-devel@nongnu.org; Mon, 18 May 2026 16:14:46 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wP4MO-00081c-Te
 for qemu-devel@nongnu.org; Mon, 18 May 2026 16:14:46 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso29106035e9.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 13:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779135283; x=1779740083; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oIyOi59fozT/sXvVqbp5nOsCdrHNsDDqiw3JDTptoBc=;
 b=yXwPn4Mpue+hM5G9ZzeBscNbf1BATiHD4UkIGCNRgy6Q58okO2FFvl2eVvpNbOfFDd
 xFEgg0Q7/op9NAlye35RnEDJMP7jBDjGYkPQafYlvFe4pXRFou0bnnVGNzW4Ij+s5SKi
 32KOOGMTlK/n7XVsf6tTJqRO51zxnVQOnvxSZtZ7Ob8FYhbbPEIrRhgyqLmjKGvON+gg
 S2KB69f7L/sWv1Z8ooTtZW7rikrHcHL4Dbl4UbEXBZUtubpK2tC9y08GFeWEr2nnUh9N
 OU8S9OyV0thiHg9wCy1G90N8Xk4iioNp6zBszksqZSwjIqwcfBrvrV5BqS1gJwqnwweC
 u4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779135283; x=1779740083;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oIyOi59fozT/sXvVqbp5nOsCdrHNsDDqiw3JDTptoBc=;
 b=HXm72d+SFv4vxNEUEGV7r/CPfXICsim8pYDWkK/T98NODrAUYIPi0ZqfUhyyREpeCT
 fOB0Sx1uWFde9U5WR5r/5jDuyNB9xWKMXGnyeO+NOnZrDfz19l/2wDyNB3Lk503Ib3JJ
 nMz/zZnu0c0BUNzXp6os9Lb+oWoF/YJF5gFL7aiviZGJuzuOz0GKn5XIgitT951IyJUk
 RO9EX4D+N1ZSvzuLBxoja3VyRztRDXbKReaU82GAK0BbiLS797ooJ1YEDs+LHThI2Y2/
 DIjaV8oCQvn4P9qw0LYnX12k4YtzfhdlP2xx0z3TRKVG1yTlAAt6h7jTlmbKvMLX+0cM
 m/vg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Ga3fGFFhMa3gb9f5mfQbKyXLZmLNrNAbC9kMUKmI57IVjmHe4WbErDhr6sxK2Zk/na8zOXbdiTD+l@nongnu.org
X-Gm-Message-State: AOJu0YzVdZL7QX+1R/0Yia8h6VnA67WHii0xHm2g/8xfTR9CBvrB36jm
 tWvjZPl8qBhvHhY/wiMPT0yVpD0/jPd1e0Q+Zwa+nCW92iWg7ojlC4oNdHKFJQYPBmk=
X-Gm-Gg: Acq92OGP3cQbMWMzVSpOFO67nBU8JzRleSe1eq18IWxwf35BYhWLeUHXvE0k7arDGYP
 xQQVrCiINSkkCDMoGNx9gp+U3TMNCZae2ME7aWDo07CojDX6ejaeJg2S2exHi4PaW6lQF1dUmtk
 WU/S9wnfI81KEcj8d0x6J4xn/7Qt+s2km8fdOkQesdWsCAa/PBCITe+wmhXOVYZHr8y90zp2Y5S
 7hnZfx6UcnVM1HN/OHTiAKg7/h9P4dkYbBL/NbetyeWDen5Mucgp3fztNxR0ZuXlOjgpr4EO7PG
 TNzAuF6NUmFZnIMentH91eWxmWytIUI7aaHBkH51aDwH+3kkvxeScVpPkp/SQgnohl32VKwQQ+U
 zRd3a+puH1Oh1Mx96Dx6xWrqW6hdzsIDcsu20IylPYzZQfjtwew4MbxLBCopfBFtH3DVRw1DeQ8
 YmFwqaFndIIpKEVtiiCSHHDg6+p2mIcJywSU0pVaNpN9s4fxbLxBZvWhWfcHGCo0amUQ==
X-Received: by 2002:a05:600c:4fc9:b0:489:1c1f:35df with SMTP id
 5b1f17b1804b1-48fe60e58ecmr237615085e9.10.1779135283111; 
 Mon, 18 May 2026 13:14:43 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ec39ff1sm42392695f8f.10.2026.05.18.13.14.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 13:14:42 -0700 (PDT)
Message-ID: <6170dc99-98c0-4d06-9517-d6b147779503@linaro.org>
Date: Mon, 18 May 2026 22:14:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/12] target/arm: Use FloatParts64 in bfdotadd_ebf
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260517002550.321291-1-richard.henderson@linaro.org>
 <20260517002550.321291-9-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260517002550.321291-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 17/5/26 02:25, Richard Henderson wrote:
> Use softfloat-parts.h so that we can more naturally
> perform the required operations witha single rounding step.
> This happens to also simplify the NaN detection step.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/vec_helper.c | 77 +++++++++++++++++++------------------
>   1 file changed, 40 insertions(+), 37 deletions(-)

To the best of my softfloat understanding:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


