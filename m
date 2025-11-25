Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E3ED10366
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 21:51:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO0wf-0008Tr-Mu; Tue, 25 Nov 2025 16:51:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0wZ-0008Gx-F8
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:51:28 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vO0wX-0005jF-Bq
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 16:51:27 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4775e891b5eso25966405e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 13:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764107482; x=1764712282; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=359VWssTtPkKZrWVQZsMcI00cQKKrR1WCVnUNHwP6Oo=;
 b=D10gA+Rr14vf4lVs7fn/QEtZnfZD/9DxZvqssda8byfTgGrHZlf6z84ClgUT6CR47j
 uEVAsN5fUDKpl5K/R+82aVBzQh2rZLcTzZtQUuYhUcphKwd4SFjzTEOG2K29lZ43y5b7
 R04UI8rv9eKjluDspwjxq0xuXfNMjJExFu8A7XOS5Nq8hWPZSPyNjyq1orGbHzVZy0hz
 ug6G12EPnFnq5zZ9pR0KOOXfS0GMN7Rb4yioa2q255njn0NWbGNAFrQyHt7qhmWqmuSj
 6QX5LNxVI7lbbVUWm1AXJml1TrR4LVSajbvhvRouI0yZOw9X64QD0n0aXYn66IDzpJjH
 uG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764107482; x=1764712282;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=359VWssTtPkKZrWVQZsMcI00cQKKrR1WCVnUNHwP6Oo=;
 b=BrZbOVrFn5ffvVRYIzu/qrT3KJDPmsLB35r4SGKcTsgqm/2ZczBxrh1WE9k1rt1Ox5
 s4BrW/ewLIoOb3+61xqlBFsLsPUjHDJN7+hd52XwjaE1HU3XZMlSLv4nIgCahHhfiq0a
 XP3cKcKt/k+hkmww0wiCoPV7xTAjBrFW9tNqWVB969B7g/0LwU+ihijWkazyHBWim2h0
 OsaTYv25ukVyPeHAc5X1fQnNXHXtNkfbfilh4HPrp7cNk0seuHUEf2mP6iJjXSjN83LX
 a9np3vkFNAS3iMUgR8mvFK03DAssOsUJQynFJL0wPFZJ9IFZUSjn7Qwmw0SHEtUzAoXy
 0/lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2Tmn6DtTB7XFpiR0kf2DeqXqv3lDuoNg3yOENEeVTeIJ3VpSLJq5ZU23Xnw5vVzrGCBQJPtrdI2/m@nongnu.org
X-Gm-Message-State: AOJu0Yzo2fDRiwh7vvHgl1RFYpSUkIeaMJr4NAZFJVVrCnjnDmnTDuGF
 gSMg4WvpEr9LnZZHfYoyPAvnD0/3Xb5cGoQu+bnColuGmU+Bi9qJe5WKZ7YAVqct7HU=
X-Gm-Gg: ASbGnctnFUqCsPZS93G4uYMtsmris5zUAHdO0QjBwTNmfptdoWoklRAxaywfHopMyfs
 mXO8X16zk8UbkEt/PU6g3UgdJvh1tXkIfBBjtwFKN0lVQrTKpXw6sYk+51aU0tk9ZfCzHqRSJzZ
 ANtOVe799kF9xqKpz+5/kmCOoamolUDdUJDSaW13ca62bhKdkMesKXccObzJBV1R49W2PJG6UxD
 WARHC2H0vtfBSoXMmS5eSPg4CzFoI/7X2uHKU6kLONGso600U0vGyL/ZR8buK5dQ+WJrC4XKePH
 NZdWHHl5tzmWa6gq3hhXFTM2Q2N5zCix00xf+QMqSMHpE/WtY9aBdkWpFwWpBcujADMZw7q8Dn+
 RJWVGKfdpqnN/80F/3YAa6qoHBHEVggC3wl0T4RJogVaAES7rU07PgdzqVIjTPbn7qmDeoEs3sG
 UkRXAlJF6vlAIx7HFe+OLR1CrHWtkOUG5iqy1T6ITVZqOfBVubP4erNiipTVajLTDc
X-Google-Smtp-Source: AGHT+IG+s262t7Og6oVvN8z/f1H93+1L0is99i0l++oGM9QBmcJMu3G8wAksI7L14ySHmr5jIiH/QA==
X-Received: by 2002:a05:600c:3541:b0:477:9650:3184 with SMTP id
 5b1f17b1804b1-477c0165bc3mr165313745e9.2.1764107482498; 
 Tue, 25 Nov 2025 13:51:22 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e5a3sm36456455f8f.6.2025.11.25.13.51.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 13:51:21 -0800 (PST)
Message-ID: <96494f37-cd76-430b-9f1c-2a730346ae6e@linaro.org>
Date: Tue, 25 Nov 2025 22:51:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aspeed/{xdma,rtc,sdhci}: Fix endianness to
 DEVICE_LITTLE_ENDIAN
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
References: <20251125142631.676689-1-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251125142631.676689-1-clg@redhat.com>
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

On 25/11/25 15:26, Cédric Le Goater wrote:
> When the XDMA, RTC and SDHCI device models of the Aspeed SoCs were
> first introduced, their MMIO regions inherited of a DEVICE_NATIVE_ENDIAN
> endianness. It should be DEVICE_LITTLE_ENDIAN. Fix that.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/misc/aspeed_xdma.c | 2 +-
>   hw/rtc/aspeed_rtc.c   | 2 +-
>   hw/sd/aspeed_sdhci.c  | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)

Queued, thanks.

