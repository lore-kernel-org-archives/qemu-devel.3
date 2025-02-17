Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EDFC021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 08:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjwGI-0008Su-FL; Mon, 17 Feb 2025 03:13:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjwGG-0008Sa-7X
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:13:52 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjwGE-0000Yr-IT
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 03:13:51 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43964e79314so35764565e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 00:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739780028; x=1740384828; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mGxjYeUB3zJuHIvZRpYnR0gj179NV2V6NA3rRIJMaCg=;
 b=Zr6NmkuO+HIaqIZfgDA3PvPt1dDcTdUx1Ml82zlsfCJj7cnM4sOyNwHFWdPbQ8BwE8
 Ge6oSCX3gOZj3yZE5y7i2WNOicnezSOBhznXAxKaRuEjc4l/L4v/f0xoqaWF1kA4IKjL
 aUrxSmGMU2iTB4fxR6A1DQ/Yl9VpRE5oEUqu6tBwq8g0s+p43P0BiN7v3KLYwVXKuzcm
 RZ7EXOYQMujBJchxwqa3b1Wirr7q8Q5OCy5lrz3TJtSU9WSt0/+VpiuTdiL2q6rfOfx5
 nED6Uvnn8xgYrLJu0Uml4PgUpQJr2eMQIZJUZaaKAavemHU7owJaBfixdUxspb5VvLCk
 dENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739780028; x=1740384828;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mGxjYeUB3zJuHIvZRpYnR0gj179NV2V6NA3rRIJMaCg=;
 b=UleW/v1MO03JiMu2PniPp74dBiVhZMCnbPy/P25ZYQryzDrASHYVka9zfsyX10p0Fe
 pwgJIOtJ64bF2PpW8hLRy2ZPVmsHfRt4TdsHuQR9zXnevlZyHSTRsPivnlVO+rYjDXOR
 gE27uFTgBK5y1xCqPvAyvmJXbhBk3xJ0xg0rBsX2zWCxM+kjKtoKeVW/oJFhHvocbzIF
 H+Mp3XRIZ6a+wW8utYV0BVwaixZMEvbbkc4EQCa7xJstVKBpRdu5At4uBsE5YV48IaDr
 G6emInkl9Tp6vPU7L8Im9fCqEbbL8cIz+juB/kxsKdGCY/X9qanSz3soysiRstplzF6Z
 qGHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWN1/uXp7/xJvDpg88fD55BWaGWPEy5B73cOt8KfFSLxNIG9BGqFxo5dOWyWkxigarbhGURmeHPZCVZ@nongnu.org
X-Gm-Message-State: AOJu0YxcQnW419tpTH5jhR1BqScIJ90arJ1RcB1W8ky6FVt82mBBBeLM
 tfztBOY4bCHZcSGUS2X4S1fiy9RAsqexLHo8HRCIeYggoDLqbzug9lIAHJNkvR6Vr3l4BahGSwH
 e
X-Gm-Gg: ASbGncstSW+h6yJJc+rxRC8tbdhca23pTgjQiXcEQ9e7gbZRvpc2dqGq/8glpKFWNOx
 IphWzeI6GUrX+sbkSpXPJcgWOjSofn+qAdipSRvRTxiWCbbq9ExZj/lcojEssHyC7ruZvE/7Ocd
 yWhU9tpvSWFYBTVMc+IFZtpFJ0QBAf++UgtqcSlu82p9U+QZO4WJsl1rB8Fe+cW2xPJnXF0mt2Z
 vhg4EZO+7tvQnxM7n+CwfKTLJ82w8qFgJ/FkxueYx+CSoUSkjECkJD5VDcjY2awIrDLuH2SVjM+
 GujLwM6OGJzZ3tYMuz5oIJW2FKLoOQ==
X-Google-Smtp-Source: AGHT+IE8acnnGBwfJiNn9glBCc9pnqxBJfEJQyxKy3GfZEw4M141PJe+mFTjcNh1SXlEVdNfJW36zA==
X-Received: by 2002:a05:600c:3546:b0:439:419d:ae01 with SMTP id
 5b1f17b1804b1-4396e6eda19mr81513535e9.10.1739780028597; 
 Mon, 17 Feb 2025 00:13:48 -0800 (PST)
Received: from [192.168.1.121] ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4396180f199sm113252485e9.15.2025.02.17.00.13.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 00:13:48 -0800 (PST)
Message-ID: <063865ea-d3bd-4265-93f5-7b47687b1fd2@linaro.org>
Date: Mon, 17 Feb 2025 09:13:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 095/162] tcg: Merge INDEX_op_sextract_{i32,i64}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
 <20250216231012.2808572-96-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250216231012.2808572-96-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 17/2/25 00:09, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |  3 +--
>   tcg/optimize.c           | 22 +++-------------------
>   tcg/tcg-op.c             | 12 ++++++------
>   tcg/tcg.c                |  9 +++------
>   tcg/tci.c                | 12 ++++--------
>   docs/devel/tcg-ops.rst   |  2 +-
>   tcg/tci/tcg-target.c.inc |  5 +----
>   7 files changed, 19 insertions(+), 46 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


