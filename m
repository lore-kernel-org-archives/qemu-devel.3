Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C316A109C05D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 21:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Vy6-0003Ey-TA; Wed, 25 Mar 2026 17:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5Vy5-00037w-2M
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:40:49 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5Vy3-00014P-Ga
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 17:40:48 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2aae146b604so1653755ad.3
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 14:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774474846; x=1775079646; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h2MO5/bOv/ymGQ8FaVk5LZANxrQFUbU1U+6LtEuHW3c=;
 b=tO60feY5GY1W4uSBY6SvfN7nOMLwLM96N9h7UWeH6HCIDthlacsvJV9QMmfgaKa9OW
 vwkjqF1EbEyv5aJvTWFVtu+L2dRsPdujULpILvQKHobGveo37iFdRNjh1DkRlmSdF8M9
 //YcGYxzUxVr0XxuIx7ZoN8BPrRnokudWJwxaT9p9QfaD1lEM8xF7s2dScY3wlrgTitL
 qxoUg2jJT5o1vghZyic0JdXoer8ZPg4pRXnAJHZONMAWjFMC2DRmiRx32PMoXUhvdolS
 0doRogR2q7A/0uXChQFe/H0sP5sRO+TC0nvLs193C1Z0AXap248jfEvsI85f3R5KWZRZ
 RV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774474846; x=1775079646;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=h2MO5/bOv/ymGQ8FaVk5LZANxrQFUbU1U+6LtEuHW3c=;
 b=ayjUzNagurHlLEdvZL/QW++Pnnx8ZFY0bUgcecWkDS9ELeWasnaTMRZ3Ka5x28WAiO
 5ElGBEPGzAdQ/rSJplXPJ5ZJX3eZSDdDl7dAJsUm3Kp1tGaSEjn8kuX2nQGZazO60FZa
 501rplywgRJiREhigg32R9bh+LdioIf0y2NjlkSD4pE4V+E4VJE0u6f/UURwRZDMzITZ
 ZoMUOnt9Z/gxSzJ887cI3WEJ7BYTp1P6t+/Cn2XPvkbFzTtvOsfa1eMiz3Dl4CUwsM2d
 0wHznDTaFE1iLP4zYz+s1QdCTSZMZOolUrzdFkhBhofMxOTeSWWYuWDbM46eet53cvOn
 FVVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDyRxBYUJJLIhloFMDQsDukSYX8l/sOKydPQZpBgJ3SBP9ESwiL4+w4B4mtts7aEhRa7Wb1HJlERUt@nongnu.org
X-Gm-Message-State: AOJu0YxPJ0dK55JRK/7dyWAvCZIqJEj/KARlJegmlZ+FTfJWPtapDEjX
 JKHh11HYGX0/7/HEmJ+3OAhxt1XHBs27L6JPMXCPZFIAMnjzfwnud8axLFRGx0oMJ2s=
X-Gm-Gg: ATEYQzznZbOqt3DvdGDClvE8XiIR3NMatbqAGvr5+4iNxFH/K30pglr34kqzIb+N/Cu
 leHMR9ZZBbm8Ef0QH4fy2G/UmhxAnTRadRrI0tmnsBG9xnl2lR1Z2sboq4TNOCI3Z+kiSA4b2e/
 829Y5uBkiTwXzqbXmp+cTlLhqABbYJJFBfBW0pXie5q+SfF3RIOmDzQYf0QRICL0KQV6muFLgFw
 dLwBsj+njLxVeaXkHr0z1amSs1acvGYtsm0DzKyyOIicC8prJOkC1d53KYk1dsKrsqF9+oTNqvk
 6L2tFNf71xM94xpFi7ykUH2wXhlup2eU6T2XYKFv1hGBEV7433V8YF/uNnOI5805ZUIXx/MKtbI
 vyrYkmP1VJT4QvQ3s+Ai+dzbsj+RjOofyAgN0LY/5SPzsS+aefFW7ru88UZyrWqcXvSDsXagl0Z
 uPqRehWyTrdzJwl5zXcAmgP4pgiwdd5xIMtIKM8p0bmblHim8SKMvR/9v27FX0LxOLOlMO
X-Received: by 2002:a17:903:3807:b0:2ae:7fbd:3dcd with SMTP id
 d9443c01a7336-2b0b0b5c279mr55017025ad.52.1774474841127; 
 Wed, 25 Mar 2026 14:40:41 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc7b233fsm8103565ad.32.2026.03.25.14.40.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 14:40:40 -0700 (PDT)
Message-ID: <9416f6db-3fcb-4696-8fda-db05b2e7973b@linaro.org>
Date: Wed, 25 Mar 2026 14:40:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 06/10] target/mips: Inline qemu_get/put_betls()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Alistair Francis
 <alistair.francis@wdc.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Anton Johansson <anjo@rev.ng>, Peter Xu <peterx@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>
References: <20260325211728.89204-1-philmd@linaro.org>
 <20260325211728.89204-7-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260325211728.89204-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 3/25/26 2:17 PM, Philippe Mathieu-Daudé wrote:
> Use TargetInfo target_long_bits() helper at runtime to migrate
> the VPN register as 32 or 64-bits.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/migration/cpu.h      |  6 ------
>   target/mips/system/machine.c | 14 ++++++++++++--
>   2 files changed, 12 insertions(+), 8 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

