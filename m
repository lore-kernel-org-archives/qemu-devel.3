Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3242C0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 17:56:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbkO4-0001O7-Ed; Sat, 25 Jan 2025 12:56:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbkO1-0001Ng-OI
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:56:01 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tbkO0-0001ZD-9I
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 12:56:01 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so74675905ad.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 09:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737827758; x=1738432558; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2Wm4E91HwVfdcP5HjbFE/OCbHsqxHFYJpSIpK5ULfc4=;
 b=Giat6f598laNYx+H8mNozUlM4J1+VCep021EMVq5meGe3h3PL1484tkkG3Q+aO/z+u
 AK/B5pT2Og0dNCjcMqZEj6WzU8gCO0QLuSHzV/d+n+Kf1O+2OU4K+uCBOpshYGLPxKXY
 DF/HyyVkHh91zaZc7roIE3lC1O1wf19prMn8G52DN3zDfoD/n72jdmYENHnJS380nuDC
 UnvyINkrXAa1J5G+z+Vke2izz39a3uz0vq7p+mgJJSwsReXc/AW7fIOOXjVmO0FQ14lf
 U/LvOBvCW5ysV8mWp11RNikLpEHnTJB43U5Zwj+hRscZFcho5G+CllWmoDAJT7qVCTuv
 Ex3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737827758; x=1738432558;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2Wm4E91HwVfdcP5HjbFE/OCbHsqxHFYJpSIpK5ULfc4=;
 b=u0EAdMz3+FaJmbzOUutsTnk/HH0bFvp0NseZW3ClLk1oKC19iXKFlMLmkyVmxuZ+N6
 cyixgiFpd8rccjssD8LxrSNShSq+4RJSWHRK4vpK2z2gKQzI+5JxKC6N/Yg5lhXC2tqr
 pvgU4fzcj/KI83Fl8DkHHVJ+S6VJIgX7j+nLyrJWtvoOVh5+NG46frVR1ZFUHJcVwSEM
 1mjAAF53ITIGFTULIXvN/UWriZAl2xxW3rRAJMX6rBbNBdnQ8Hx5zISwRaPxecGcxciX
 c7+Rwamo4JZFCQvHiaXmjnvBntmnu/tJXY+PTSUrM6FLODNYSGr2SdHXGkydk1EUzAri
 fesQ==
X-Gm-Message-State: AOJu0Yx5jOL18tpsMCLlpnLUa9DRsAqJLA1yfZZho6IzubZtISsX2NRF
 dUr0z1FZs+YHBxuA7NBrVij2zZGOnhw7HF25KLy2Oiz2cy/xIwcgxfmYaYOHNd1+lwnL6qCAqey
 i
X-Gm-Gg: ASbGncuWvKOiQ1J5PPQxdMR66Zi8xZ/lHvlabU9TCohMG/2UUdOF6bbRdm79pA8Gcw2
 vIT+1CUIcnB2zuOakcccaB/eMkitLfAWU8vzZm9XbA/WZZ4wOnfWxJIeVviqKul40uK4vyMVWQG
 2bbIkrw8CJ5wXHCFtA41oi6m9GBZOZFNs4W6sci59I4JD3pthjjlVfgoZLHQGU+W7kTsmUP6RTW
 10SQKL1OP4DEItBlAfx8Os9yNJrB70UwwJcEx/74jY/0Ueo835zpwwb0AE8ku/Vta7RbjOhqTeZ
 YdwNkhYdY0V2jZo1kclojg==
X-Google-Smtp-Source: AGHT+IGJMqhsP/J4wFbfx+9Pt7HocD4CeP1zr7QH+q3wNPOkLRabx40E6dBvnm5aOWhUsujh6oWlpg==
X-Received: by 2002:a05:6a20:a105:b0:1e1:b153:4dc9 with SMTP id
 adf61e73a8af0-1eb214983b7mr52966169637.19.1737827758697; 
 Sat, 25 Jan 2025 09:55:58 -0800 (PST)
Received: from [192.168.74.94] ([50.200.230.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a6d22e4sm3986772b3a.83.2025.01.25.09.55.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 09:55:58 -0800 (PST)
Message-ID: <12b52f8b-f7a5-4bd4-b735-395a3f33b88c@linaro.org>
Date: Sat, 25 Jan 2025 09:55:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 39/76] target/arm: Handle FPCR.NEP for BFCVT scalar
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-40-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-40-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
> Currently we implement BFCVT scalar via do_fp1_scalar().  This works
> even though BFCVT is a narrowing operation from 32 to 16 bits,
> because we can use write_fp_sreg() for float16. However, FPCR.NEP
> support requires that we use write_fp_hreg_merging() for float16
> outputs, so we can't continue to borrow the non-narrowing
> do_fp1_scalar() function for this. Split out trans_BFCVT_s()
> into its own implementation that honours FPCR.NEP.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 25 +++++++++++++++++++++----
>   1 file changed, 21 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

