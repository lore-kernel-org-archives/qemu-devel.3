Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF686C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 06:06:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdOB2-0000dP-BJ; Mon, 12 Aug 2024 02:05:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdOB0-0000Wx-By
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 02:05:06 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sdOAx-00024N-Pa
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 02:05:06 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3684407b2deso2165755f8f.1
 for <qemu-devel@nongnu.org>; Sun, 11 Aug 2024 23:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723442702; x=1724047502; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V17n5Ba27HN4fKAYkqrdnkJFfcKF/xGx8w4F5mRAxqo=;
 b=rDDk0h9zCTmKRjTHWVrudPiTi4YxcCzPpWyKlMbC+FqNwbvnl4dwf2JWyhYbRl0BoZ
 fSpoeEtdUyTFk9edc5hKQQRb6Ag+7zOMkCxpMgUy2F3scve0GOu9U1w5mjDV8X7+d5GY
 KH7oDEMA7xHFGElNZea8U/WIfNGeLwViJvsPYwtGOA+Kth+uAa1bKd02fYm0ApSKEX4l
 8fZxkl6t+0ZCDZ5Tb6wqEHaXozJRZn7nq1yxZs0scOGxGe90VWsBhGSy8BgxFmGTfdwE
 OQh5HMJIMVVvX9A2EAWckReM8WlkrizbSxMYlRpF7OU0oE/mDfPg+w05IUvtbI2aJBJ8
 wZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723442702; x=1724047502;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V17n5Ba27HN4fKAYkqrdnkJFfcKF/xGx8w4F5mRAxqo=;
 b=L2zBTnZv7w2iT2tfCTgbIyWRmwoibTR2H2DYSpqdlSf5hxRQRiwhgds6/JjYdOPla9
 lEQ4/ut0Nii6SZpRrq9QotXwl7g3AuN4rlrmFRqY36STB8bXv0gF4TDgagX8oks7IlYc
 PAS6mrIgC0hqvpy7t0sd4Vm/tOkzBqUm3P71ybNjgfZL6eeBlKmRNAGBgcSfzRWTbpAe
 udvAJa0I61x4H4z2DvBHWu7r0z345SVG6WMHyPFwYqv5MDE2g6vfqly2o4ye2ym4ZIzP
 TBSIxguY5uV8SvhMWVVGiuXYrCulYKoDh7UQNqHXSkcP4zGlQHj/PYKLKs9x3EcAFOv1
 C4Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3bmeW3WyT73dlep83nAysbOnoITQ3OOg8Cp6JLgXMWRJupxr44zsYaBP/s4DmrT1u/klHFL/VdbJsPuN1XzwYMJunxUc=
X-Gm-Message-State: AOJu0YwIGJv3ZCKNCF+OUyBuW8zvS52tS7GJpNMYJtPxooy0gLA5YhTZ
 qGgKuX1RKzp+FkZkHyh9ZVaWG0Pf13wmrU0Q0PQwXNzzNUp+ynjmLdhDl1IJvtM=
X-Google-Smtp-Source: AGHT+IHRzqDb+uo4r/Ja5QsLUleWtFATWMRWLoEv0uBD/pMI/OwaWS1BPbvqyckE5Ph6z2ObZXqfAQ==
X-Received: by 2002:a5d:456e:0:b0:367:9522:5e70 with SMTP id
 ffacd0b85a97d-36d60352db5mr5265261f8f.52.1723442702224; 
 Sun, 11 Aug 2024 23:05:02 -0700 (PDT)
Received: from [192.168.71.175] (133.170.88.92.rev.sfr.net. [92.88.170.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36e4f0a6d76sm6484940f8f.115.2024.08.11.23.05.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Aug 2024 23:05:01 -0700 (PDT)
Message-ID: <5285096a-d9ee-47ca-9e93-aee43b2afb98@linaro.org>
Date: Mon, 12 Aug 2024 08:01:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] tests/tcg/m68k: Add packed decimal tests
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20240812004451.13711-1-richard.henderson@linaro.org>
 <20240812004451.13711-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240812004451.13711-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 12/8/24 02:44, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tests/tcg/m68k/packeddecimal-1.c | 41 +++++++++++++++++++++++++++++++
>   tests/tcg/m68k/packeddecimal-2.c | 42 ++++++++++++++++++++++++++++++++
>   tests/tcg/m68k/Makefile.target   |  4 ++-
>   3 files changed, 86 insertions(+), 1 deletion(-)
>   create mode 100644 tests/tcg/m68k/packeddecimal-1.c
>   create mode 100644 tests/tcg/m68k/packeddecimal-2.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


