Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47484CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNc5-0000zs-By; Mon, 11 May 2026 06:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMNbd-0000mW-R9
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:11:24 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMNbc-0002fB-7d
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:11:21 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-459bf19e87bso293563f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 03:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778494278; x=1779099078; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=n1tCYwCA6vMalyhyBe3A80+FO3JNz0MZ1bTEpKLIZIc=;
 b=H9maiQDODjEcc8BeFYeuDkCyi2z2HE2QoFZNvG/aOMBXSOfoLYrqiyf+3jM0Bl+wMy
 w1lHYdeQU73UrceKq5ZcXj2GlscK/znTepn6m6lr4vbY2r793Sjr2ZQrREV5jwN52vWe
 haR4ci7rasHqs1q4XO5U2Dh9OuZjaWEPZvNkr282JcCqHDDFugIxPoH5CLuPnspiuJRy
 XKKlimB35wCpAUUqkQb5ZW+VQoj9OYX3R/Z0IWGka1YZVE/7tOwZF/0vFy2f0NtYJN4N
 MEIJmXqWXUueNjwU8KpQNtOeRBr1OOsMMsCuXIbxZAzENpSNyC1Tk5H+rGg4hN1m4EjB
 WeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778494278; x=1779099078;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n1tCYwCA6vMalyhyBe3A80+FO3JNz0MZ1bTEpKLIZIc=;
 b=AdL6w6QRwav5msNoV7R0P+Vac9lt8pxuU66tuMdcWv05OYDQ9plIhCm1WuzKtIkM4F
 rmw4zDY/tZMSJGNpzKXq1cZaT6NTn4Ksh1QP0x0mH2TDHY+KNDDRmUowZkR8rxMIjGjX
 xUgxIo55sZ5JsMhLJdBdrq4gN1TdNCtAvO89CkA4POvEwh/CyAydV5VlMBQkTNE6wC6d
 cf8AZs0beEryrQIwg/ODy8V5XIPV2gJh3RyFep4aU7rMjhkoVtqOt0usePfPTYOCnb/M
 Rwi537kWi/MEwYWft0PMGPN3F4pul965ut/zQXk5YO7Cez6P2l/nvLUqKvYYYN5g9aO8
 4qhg==
X-Forwarded-Encrypted: i=1;
 AFNElJ87iuGXjdfU9sGUlXcqYbeKuQconfyra9WJ36T5EMoJ5UpTxgLpaFK9E8d9h0+cKlwZaudoSNgjNjVj@nongnu.org
X-Gm-Message-State: AOJu0Yxxp5Ci4bgBJsJZ9v9/SHvEy8ZWR4Opexj4Ho7nuZo/sDdVyC4S
 HCpre6DpAoWGtARxeCPL8dlGkkAl6aPhSzNPJL8EVYJF5fgnrHIK/0V1fTodwcmqdZ8=
X-Gm-Gg: Acq92OH5bPUGiQeNPwyKj49wr8FgaaNuZZQWiok01fqXm55eXcv2KjyrApYYh3N+LJ6
 h6hqlJS4iGV4WG8oVpAOzQLVGk1uUW/uqnsz+7NJ3S9pj6Q9NckEN3vG/i1/w72mRWkZF1T4ITr
 tqNX9sKSL5rhvBT5n72a/2Zlq8ipD69nveR1VgfqY6IqTQD0hRUwIRKE7VZpjgkkz9g8HpBNPlc
 xjwmACrOZ/8Mubk2aae+L5+YnNSxH517XdnmowedG0yzBennv/9aleHS9rGWYQTvupcLfI40wAA
 5ApwJg36oP+EYyukD4RjHBgM+RcnX7bntVoakjMS7iZvgo+YyfpQCbjKTliPX7CaevaVT3VTWD3
 xN7lADboN3J476QPzv4lP7S/N7CBCz8uRxR0L40FUjfKRlEfLcq3cvE22PKW1vzFLDEimp2bPWU
 gBJnK971iHANut0AeU2WbnMJR+E2UUZQp0GpzLrZfIX+h6aGYhaPsBmbaF/+dZtDmATA==
X-Received: by 2002:a05:6000:420c:b0:43b:4136:1e6f with SMTP id
 ffacd0b85a97d-454637c817fmr19373674f8f.38.1778494278025; 
 Mon, 11 May 2026 03:11:18 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491cab9c2sm25789464f8f.31.2026.05.11.03.11.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 03:11:17 -0700 (PDT)
Message-ID: <5178c9a1-50b0-4864-a48e-d316b602abd9@linaro.org>
Date: Mon, 11 May 2026 12:11:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/arm: Remove qcom-dc-scm-v1-bmc and
 qcom-firework-bmc machines
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, pierrick.bouvier@oss.qualcomm.com
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, kane_chen@aspeedtech.com,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
References: <20260510165704.2935316-1-clg@redhat.com>
 <20260510165704.2935316-3-clg@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260510165704.2935316-3-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 10/5/26 18:57, Cédric Le Goater wrote:
> The qcom-dc-scm-v1-bmc and qcom-firework-bmc machines were deprecated
> in QEMU 10.2 and are now removed in QEMU 11.1.
> 
> These Qualcomm lab servers never entered production and do not rely on
> specific device models. They can be replaced by the ast2600-evb
> machine with appropriate fmc-model and I2C device configuration via
> command line.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   docs/about/deprecated.rst              | 10 ---
>   docs/about/removed-features.rst        | 10 +++
>   docs/system/arm/aspeed.rst             |  6 +-
>   hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c | 55 ----------------
>   hw/arm/aspeed_ast2600_qcom-firework.c  | 91 --------------------------
>   hw/arm/meson.build                     |  2 -
>   6 files changed, 12 insertions(+), 162 deletions(-)
>   delete mode 100644 hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c
>   delete mode 100644 hw/arm/aspeed_ast2600_qcom-firework.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

