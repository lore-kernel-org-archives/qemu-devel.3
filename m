Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00A00D26D9D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 21:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veKAY-00050N-9x; Fri, 09 Jan 2026 16:37:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veKAW-0004zk-J7
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:37:16 -0500
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veKAV-00041C-5K
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:37:16 -0500
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-c075ec1a58aso1935847a12.0
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 13:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767994634; x=1768599434; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GEal6o9Eodg8ZprnYmchEyjjBp89I5H/qXWGu5c9e08=;
 b=igOim2LC8Tq1YdehqwI6MefaVmUOIJ/I+ZZjOJ5IFt738Y+/tO6su4+4cUg6VeNpQY
 jIndnTzix+2lwLW+p7a4SP3CyG34cHQAtDQ7wFfdo3wnPQb/MFxtZC01uBfJmiuBgbYk
 gy2xdmsm9FJrAVL0iBw7e29X/1is1EvhaoOzO6LKLNU2qbQma+mSUrqESLBsWtuFXamU
 YtB0AOnKiccklMWkf2zS4izcUCgqnAd7ZKkZ5XFowzs/xw7RsoeBNnMMXkKUrCCzrruS
 zNjFOOGh0DRhHNVdtVFkdfYQci6Byux5iM6BtnMxjf6TShcLvmnu2x9aVezoOpaofEm2
 hDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767994634; x=1768599434;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GEal6o9Eodg8ZprnYmchEyjjBp89I5H/qXWGu5c9e08=;
 b=BU0/W2dRa4uWK/98QBZibN6Zh6tyw1LqbNxa7GIAL1xAKAnb8Ulhn+bVZAPl7F9xWH
 ufM82ItPf11nTElo4BTuVHJKkGpTkMNwYfgTSZ7KF9zE1D564GVqOgFtfBosq7ODMPHq
 wvQZW2ifZOR0t1JqEHDvABQ6beZqEr+wIx86CAA0q42IRGJc3oUvJE7eQH73GQNtZZiW
 WW1cq2jkH2t1fm7a/0kts1FfMJLPkMqQKKK4WIf9HDNXCzs3ZpgmETlkkVE0ND1+izgf
 fkcPize32OmPUq6BfEemSwbzYzYKusPCnyGFwglFJwX9GPaLfi1g8m3WHKU14kuAbj/J
 XeZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh2N3lW2jN/KmkBwTMGS90tcE7EjID0tsQ8glOIQIoHwORInL084CPVYFXuPWTv6BqLDQV/GQypnzQ@nongnu.org
X-Gm-Message-State: AOJu0Yxk4sa3d23qNfIaPbzPFOkQoP9FeJDt60xaNzGpPpB5R9hX8Nh8
 mzpR/gQayRVNZB1VGMqWhNC6Vj91Z35/x0Wnzcwooar5VO1ADXe7pSz81Rsh5ins6qI=
X-Gm-Gg: AY/fxX4vPVU5e1jiZOY6LmPPhJZ/Kmco99+/jb9WBkhmN2xvSxmyRT7VQBvKSOSvbcl
 QToIV+kpxyTczHWMzMQdtGz3XpGRn6ml5AcE+X0J0buleSBeaXZ18xCV5IxEsp5P3qImziR32LQ
 9JPwh/kq+c0B0kVB1mLVC+uBONNZpubjFUyaesqnurFoQW4or0z2yFoGitGKRbwhYUqlfNk+Lxv
 5VK+HrKY36zuZjuv5b3RoxE9GccTLbGTSkjAqLaZJp/1N5bCbNuOkBRBrALIOQMX7rex7NA5OQL
 uqexgveZ6gGQk8taATh46+fLCu1zRMmu3mio73mGdR8kRan03q3CMXwbkDyd1VWk5CQCkra5JiI
 ZWniR8++hJv1uLo56yXdf7LuNvUckVt6NSgM8P3fMiMeYGtZLZahawRrjAOSOPhtbCxdgxhEpvq
 4x/L9mx7N2hoc1QwSge3jJcelm71b+Giy5Iixc
X-Google-Smtp-Source: AGHT+IHmkRpA181RtBF2ddXsrGxlD8ykaBtm/MWCFl9KTe6u8MQKcKI9QffXGwqOYwQb+Biqdb69dw==
X-Received: by 2002:a17:90b:3c09:b0:34c:9cec:dd83 with SMTP id
 98e67ed59e1d1-34f68c27d40mr9983351a91.27.1767994633383; 
 Fri, 09 Jan 2026 13:37:13 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34f6af53004sm3911614a91.1.2026.01.09.13.37.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 13:37:12 -0800 (PST)
Message-ID: <1972efec-12d0-4bed-9812-c9eff1277c74@linaro.org>
Date: Sat, 10 Jan 2026 08:37:05 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/29] target/arm/tcg/psci.c: make compilation unit common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-8-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109053158.2800705-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

On 1/9/26 16:31, Pierrick Bouvier wrote:
> Now that helper.h does not contain TARGET_AARCH64 identifier, we can
> move forward with this file.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/psci.c      | 2 +-
>   target/arm/tcg/meson.build | 5 +----
>   2 files changed, 2 insertions(+), 5 deletions(-)

Since this is just concerns helper_wfi, it might be more appropriate to split out an 
arm_wfi() function rather than involving tcg.


r~

