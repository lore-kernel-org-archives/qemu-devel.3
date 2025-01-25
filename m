Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B811C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:44:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbkCV-0003WI-9B; Sat, 25 Jan 2025 12:44:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbkCT-0003Vu-Kq
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:44:05 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbkCR-0007sx-Re
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:44:05 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2162c0f6a39so77317235ad.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737827042; x=1738431842; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZAfUXZCiJd7yuFJ9So3OantVjpHp0CefiqB11qaiCeE=;
 b=qaz2YIIa1RLTgfmJKHFWQGTRbClhHDHudMXPoMuBmccB4PSQPbZM+b8O0fa7B7M7i6
 HGjeK1VfopQNwco/zXageLY4pHiAOLt9bd/yWZe8xPu1fYM/bGV8AGGUYPav0T/KS3HZ
 slx0qZY5oxatGPuX115RNGhlKokZu17QuvFV47/Pcv0yVb/IuPv/sAQvNn0Z3ZVamgO6
 2CCk4RGUmGm285tXbANfeZdmqo+chou6/8hCL0ZG9NQ1sLR47BvzjbBdQmXlpApsstF8
 IoVoI3uZ+sBv0lgNfTNuYNSudzC+c0iMNOWKeyka1wwBDbC/ZfrcHsWbDON3J+cqd05i
 QwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737827042; x=1738431842;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZAfUXZCiJd7yuFJ9So3OantVjpHp0CefiqB11qaiCeE=;
 b=UPyhvPUPpkZphGwgyBnTxqwomKbSdM0+5tsQnX7jYnBTR9yZYS9Ncl4x5XmD6XaaY1
 K1S9EkNQvEyFpcBjkTKYhGwET9vnt0KyFAmlwehiu+Zf7i2zKMMO8/9VJn4lniWEX6Yz
 Riv1Dpwm1a97PpBPljbxOkqPtQJMSwdBpxp0brszOPtLAp+mKYB9nzCLrmAOVAtHaZ1W
 QiOCv6IYE+i9gAtMLNzSOSCdluLxe1m7IiDtBEpijQD8snnkiEI+IIEnUk7knCGi9h5h
 xPU+gufZ6jljzkcU0x5wtcPnChKplveQwM/gmRLo13OrSE8xBYqD7hOJqrA2CR10CEnh
 OUHA==
X-Gm-Message-State: AOJu0YyLi95SSvVB1VYle/2sQyCvJjZtjarBZAdPqgbxIfwQZyPLaDVk
 wo6ZaJJRg08mSmUMvzAF6KJUAqsVxf1UIunRe0daf0lPU2mpq5FieSpqrTB6ayqFqqIvcubsUWP
 Q
X-Gm-Gg: ASbGncsG0q3MrcbEN2ddF4j/MxSrkkkEDC08Xdqt/OSLvjW1xxieps9OxhYXCiipC60
 vhgVm+/L7+w/aUdECXnc0o/6l6HswHewcbrGnBCU9gV1Ooza/ng+BLoL+bBt7d2d4vpwuNMdcJm
 oUHKb6XmEM0zBzLxnVj66CFvWTbVjmvorisxO9y2/0/cf6oltaAqn/JGcjgFZjo3ejgHb2912RE
 d93Yp+XUU976ttdAwt+1hCx/EUQzUL6iNucEn8lfULDqetMvTXcU6Z5dV9rE91+7XsXPAfxfylJ
 ImJLbMKuf+7jRQ4bcef4Yg==
X-Google-Smtp-Source: AGHT+IFJxxZ6pq794wIXPLtZnOhKWS/bz7DgrpsN8cKW5Ys0O5JKYeBE4/gxyGE50A8zizajEVDvJg==
X-Received: by 2002:a05:6a20:c88b:b0:1e1:a48f:1212 with SMTP id
 adf61e73a8af0-1eb6968a5d8mr20693415637.4.1737827042381; 
 Sat, 25 Jan 2025 09:44:02 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a761134sm3909537b3a.115.2025.01.25.09.44.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 09:44:02 -0800 (PST)
Message-ID: <e48badef-da2e-4146-a543-3e3e106496b5@linaro.org>
Date: Sat, 25 Jan 2025 09:44:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 35/76] target/arm: Use FPST_FPCR_AH for BFMLAL*, BFMLSL*
 insns
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-36-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-36-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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
> When FPCR.AH is 1, use FPST_FPCR_AH for:
>   * AdvSIMD BFMLALB, BFMLALT
>   * SVE BFMLALB, BFMLALT, BFMLSLB, BFMLSLT
> 
> so that they get the required behaviour changes.
> 
> We do this by making gen_gvec_op4_fpst() take an ARMFPStatusFlavour
> rather than a bool is_fp16; existing callsites now select
> FPST_FPCR_F16_A64 vs FPST_FPCR_A64 themselves rather than passing in
> the boolean.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 20 +++++++++++++-------
>   target/arm/tcg/translate-sve.c |  6 ++++--
>   2 files changed, 17 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

