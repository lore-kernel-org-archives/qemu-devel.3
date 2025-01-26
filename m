Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96033C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 13:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc2KD-0006zy-Vb; Sun, 26 Jan 2025 08:05:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2KC-0006zc-Gl
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:05:16 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2KB-0001LT-1c
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:05:16 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2166f1e589cso91980555ad.3
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 05:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737896713; x=1738501513; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GEzAKJnSwxLEnHwA976tePhqpI1zY6Ehv2/i07bpO6Y=;
 b=hqwhCoD0PGxHg1+IplgbvXmUi9Q02hEw0y0s7IVP2UntvXqyTfShtil8gJ2tKWk2xq
 GPAOUnXGLfRG0uLmh1eidaqaL+Et6uQeG4xhomWPpmeKAc/yFk55mIBInvUggU0UizD4
 /BkY+xyFC027Xc/theNRuO4stdXdvt3Hrxhtan//b2r/Ao9/r5o0zSH+Y8Yb7S46g7X3
 fm4wpR0A07sNWiJoyA88maf0TfdAwc+LD7I9AcHXiUdweiRSg3HgO1jybGcA1nSGOAJv
 fwEyxN8Fjl0rRofbxOnmHL1CVNGfN/SNibZoVVQtdAaR/jNJdNi2IP9Nwcnp16f5Xb2G
 wzyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737896713; x=1738501513;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GEzAKJnSwxLEnHwA976tePhqpI1zY6Ehv2/i07bpO6Y=;
 b=DJyzA033qBtNP6aml7VAu4AyUAiDnDFvWR3hvbbKX7/tcGsqbnnAkDcmE3lsWyJKxo
 hFWge70ac9Wfns+4iNY8XnnnYsJ9+9PYd4+dG5EEsk6AlL2GClQHA/iu2HqKMiZ57fAO
 lqHpwGGeHsQujrX5yhfOQp5bJi1ZmqgJ8x/NPoh6+UMhmd/zGxNOyRp16C0rJ3DbgLDY
 FkfnXOHt3kMEU05raLCVxJPh/6XcJHzgUrxmWr23B1r/RiDfl7JOpxuBzIbU3yVgLFM/
 mnaZGD7hMvz7qhukPaU21UBPrgP649oJ9iqSbqjJs8VR0/19xcpuCe95SXUPGr4AFrf0
 CiLw==
X-Gm-Message-State: AOJu0Yzm9EypLYz+HP1kcHUk4WLnu5+NpGBF+NgJ6xZvquxMRDgVXqBI
 yNCWwl5P6slROfmPqU4mZMPnjz9KEFfzuMDA/g1SeIWmNbGm6OP9V7AZcVIdwD+rrnBslMCwQSI
 F
X-Gm-Gg: ASbGncvWB4WlcmNZsuUQAYH5fAqaqvjA3leQG7MAv8jH50brdA6Us/irV73Pvkn3LLT
 prcwlZbA3rAWtALPybRMNnZJ51aoGBf3vIG2difbOMK4c7AWDlufi46cPxlhl6F/YfPuVTgrD6T
 Nxf+I9YDPOcs3Zqg68MayVO/0taFxRCyzx1ZdAi7X0wgxB6Xc2HVjRg7tok5RBqM1w3uzHoYdbH
 FUcbTynXHkuiBWtUXDzPakSnnM6AEQwnjquYSPt+gZP/I8AX7zmrAdjbdrnlLvnPTDS+CNB29+f
 It+5ZD4Eyr7kLQbZIRXw5x8=
X-Google-Smtp-Source: AGHT+IHEdnmUgRC8Pf+72Idw8k8k7947I7z/CKMIQ5mtbJsds0T1zX6jUgdcD8sJT/ZGC8FhMlONkA==
X-Received: by 2002:a05:6a20:a11d:b0:1e0:cc4a:caab with SMTP id
 adf61e73a8af0-1eb214de542mr54692971637.19.1737896712976; 
 Sun, 26 Jan 2025 05:05:12 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ac495d5665csm4590522a12.57.2025.01.26.05.05.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 05:05:12 -0800 (PST)
Message-ID: <2a00f895-226a-429a-9d85-6b66829a8fb8@linaro.org>
Date: Sun, 26 Jan 2025 05:05:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 55/76] target/arm: Handle FPCR.AH in SVE FNEG
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-56-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-56-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 1/24/25 08:28, Peter Maydell wrote:
> Make SVE FNEG honour the FPCR.AH "don't negate the sign of a NaN" semantics.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/helper-sve.h    | 4 ++++
>   target/arm/tcg/sve_helper.c    | 8 ++++++++
>   target/arm/tcg/translate-sve.c | 7 ++++++-
>   3 files changed, 18 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

