Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FEBCC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 06:56:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZmi4-0005Qe-3J; Tue, 13 Feb 2024 01:56:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZmi1-0005QB-Db
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 01:56:01 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZmi0-0004Sh-1K
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 01:56:01 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-410c59a3e46so14036795e9.3
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 22:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707807358; x=1708412158; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w10q3LEjjDMmCluZ9uvKydR8XHU1z3VR1YfuKoqyb3A=;
 b=zLo8CKtZr1uWZJtyqjW7gYBhIUDrBh1EV0vMpwLx6P3xUEvhw9XiJqxTY0ysbYEZPG
 ssGoNb9k//pB2lt8+a5JuHl2gOItPR3NjEw6a7zc2hl1MV+V3fkRKbtRWdz5L7/62E6e
 DnRS/YJA+82wcodLUM/iMXsiFsbk0fHxOCs4vtb501834yj3kSPJI4GgwJESvt8vzIoR
 YYEJn5DUN3//hmhj6/yzd6HO6RFjB7mPBJ7BTqIKMkq2VgFF2/0BFhFGmu06Zcef2egD
 lubdi/m7M943do/PAe7/V4SW4rp0fAK94d24wwiFdu/5GBVI2k/70i2WaR2vOqtn5skR
 7JCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707807358; x=1708412158;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w10q3LEjjDMmCluZ9uvKydR8XHU1z3VR1YfuKoqyb3A=;
 b=jWGmS2lqU3Dy2wZ+t2kYr4265a/mOoPq+q++hkqlwEsdAEkZoYE8ec4oOviwWq2VHc
 xne3BkQG2zGMlMpUNrAnlEQVqper4Ikov3YJ2j4hciO64b/FULxOB1H3B1Hfp39bOt00
 lIb1YJdiW7pHBjSdGTGCfkwnSLoi31aNKu8XE4JKoXGTI7L/4iVOnSfb/Er5fvl0CBse
 Xcys/dDUDCTy1zV3/mFTe8f7wle20+bp6ouWeVS6ngdYwYADEJElMxc/zyUJGwPI7J1H
 6hudN1wnaacxu9PvWK5Zkr/W/yue+XNoJz3v3t25cyTcxnhqsFfSd1VnEcN/QvtqpkFA
 2z+g==
X-Gm-Message-State: AOJu0Yybe7XnhWfdda9/jYypeMv8CnfT+Zuv6xeSeyB63wjMQgxdDMT3
 HrY7Gw7St2TnvNDgZHTq0OLJRuxPyu90hXH1kcNyQgwwJWMRR98hiY/28CBojqU=
X-Google-Smtp-Source: AGHT+IEYpmQmmK0nT3pmQXmnH2FY7fv/FL+m2/8RZsiK+3EzB6WG9BM2WHCtorZXhBB2dcFTU+x/FA==
X-Received: by 2002:a05:600c:4f91:b0:410:eba0:6d9a with SMTP id
 n17-20020a05600c4f9100b00410eba06d9amr2716766wmq.11.1707807358637; 
 Mon, 12 Feb 2024 22:55:58 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXUxrVI+EnBUZ/dZBnl1oIl+z6ILmk3n6aoQVUR7itRqFTP0lFKxkKX8OQM7zkT48QG6kchgnE+WT/IbDThoSxhK8EOT2M=
Received: from [192.168.69.100] ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 e27-20020a5d595b000000b0033b80a0d002sm5338566wri.57.2024.02.12.22.55.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Feb 2024 22:55:58 -0800 (PST)
Message-ID: <ab447c2a-eb8e-499b-b943-4b7c5dd9412c@linaro.org>
Date: Tue, 13 Feb 2024 07:55:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/block/tc58128: Don't emit deprecation warning under
 qtest
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240206154151.155620-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240206154151.155620-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 6/2/24 16:41, Peter Maydell wrote:
> Suppress the deprecation warning when we're running under qtest,
> to avoid "make check" including warning messages in its output.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/block/tc58128.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Patched queued, thanks.



