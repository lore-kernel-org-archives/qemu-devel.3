Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0766C0218B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 23:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taNMK-0004rT-Tu; Tue, 21 Jan 2025 18:08:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taNMJ-0004nc-Fb
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 18:08:35 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1taNMH-0004Os-TO
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 18:08:35 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso110162915ad.3
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 15:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737500912; x=1738105712; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L5OOHYGGp5XiNtqXQV2PwCcR9AHYs6lySWJ+dAjlIHU=;
 b=XK8G0cza8FESbEVcwofIAh1V4mg8CScB5NaDNy9fi3xdBGlVsciWNxaouhltFpai/i
 7hHuPb8L/jZGVzLCqgLa69hz1nH+3X1WnY8bqudmuucA6Z5laF2T3one3a6He8Y+ianO
 taByQWjYpBd9qxBa4aKgVdOsvifdeDUcOnAnkgwhQJGnTIFkbQne3lHSVzfFl7/FhLpT
 3/QpeVtbidQl+GcI+YL+bh+zG+s4rcDqOhNKCPoP4mZbvTCTE49KnWbPkixz+Sga/hua
 Ohg9iMiUG3FtNpimaqc0IAATqe55be2uzeNgq8x7EAoVI+Bh+LmTgwQ+9W0eOostCmgG
 FwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737500912; x=1738105712;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L5OOHYGGp5XiNtqXQV2PwCcR9AHYs6lySWJ+dAjlIHU=;
 b=X6CpfwPae2zUFIwfqmQpKHGzV8n83M4vxrqdrdW6+NQ9LzooCLizYCwr+aVQXbkPnx
 CLmxg3NkKVwyWYQwSCetLlAKmNR3T4ijTLReUvlXbym/0qUB1UaGxbxEm5Wpks8s3Kat
 UZ2tYUR8BvdPYGd1qmJOBkv9RViBOgj3Na5aglELkfth5+Ljsrx6eCuDPLtrzuJAebrQ
 faA4mf64Kxis8T4i+7WqL74xmLKlzCPH/lZG1CY08MwuCXKMilSK9jmXrpRbWOc4dVDp
 fvHMAW9VHC4ZvFJnwExCvUtIq459BQf6esUKGnp0Pd6q4vH2Ah1kgmJKTlNjlaaIA3dd
 ZCOA==
X-Gm-Message-State: AOJu0YwPUWPpC0xYfSQ1V80xVW2HSGzWRIAcaNcBzjPuZ2YUVOjGrqhE
 Z2WyyDffnzBrdUlklOkRB8mt7TJ0RY/1O+Xji8QJe5RJBDzKjSI7Jyz+SRO63pJci0nD8E/mh3e
 q
X-Gm-Gg: ASbGncudKK1yxQk/Nqa6xlTTdPBZ1H2Jf21Ync8UAB+ODvaXxpxp+6nuLGw2f3id0U5
 tgrWRJiwYVMVaWMGUfRgvXFFqFCg3FNt61Inq4BXnGFy7JcDePTCLaDP+qQTZPxuRg3Drd/HFRx
 9XujE7AnJOJ2gvSM4+rba/Tzav26j7O3Ovm9fBoHk+v0m6jaP737wCrEj30AvGrvzwRT8V453Nw
 NANbbt2+wg/lfbxMDo2IR82nZtnw6tNnxkZSpf5hDKvGpC0yCVOnLXTHvZOzIi+BEbUVxMPnHhA
 pYId2GRrOYy1QH1Kma1npaxf5EgtYs54br4c
X-Google-Smtp-Source: AGHT+IHhUw8017UiY4puIxiTIadYru2bJgYxBxxWbS52R9B9Mg811IZ3SMVTYMnDfX9gVDEpzP5EkQ==
X-Received: by 2002:a17:903:2d2:b0:216:2804:a241 with SMTP id
 d9443c01a7336-21c355bc154mr287639725ad.37.1737500911738; 
 Tue, 21 Jan 2025 15:08:31 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d4042desm83561635ad.242.2025.01.21.15.08.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 15:08:31 -0800 (PST)
Message-ID: <929261c2-1a08-4608-8f75-e9760606dc56@linaro.org>
Date: Tue, 21 Jan 2025 15:08:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] target/mips: Move CPU timer from hw/mips/ to
 target/mips/system/
To: qemu-devel@nongnu.org
References: <20250121161817.33654-1-philmd@linaro.org>
 <20250121161817.33654-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250121161817.33654-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 1/21/25 08:18, Philippe Mathieu-Daudé wrote:
> MIPS CPU timer is tied to the CPU, no point of modelling it as
> a general timer device. Move mips_int.c to target/mips/system/.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/mips/mips_int.c => target/mips/system/interrupts.c | 0
>   hw/mips/meson.build                                   | 2 +-
>   target/mips/system/meson.build                        | 1 +
>   3 files changed, 2 insertions(+), 1 deletion(-)
>   rename hw/mips/mips_int.c => target/mips/system/interrupts.c (100%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/hw/mips/mips_int.c b/target/mips/system/interrupts.c
> similarity index 100%
> rename from hw/mips/mips_int.c
> rename to target/mips/system/interrupts.c
> diff --git a/hw/mips/meson.build b/hw/mips/meson.build
> index fcbee53bb32..6dd97331ca7 100644
> --- a/hw/mips/meson.build
> +++ b/hw/mips/meson.build
> @@ -1,5 +1,5 @@
>   mips_ss = ss.source_set()
> -mips_ss.add(files('bootloader.c', 'mips_int.c'))
> +mips_ss.add(files('bootloader.c'))
>   common_ss.add(when: 'CONFIG_FW_CFG_MIPS', if_true: files('fw_cfg.c'))
>   mips_ss.add(when: 'CONFIG_LOONGSON3V', if_true: files('loongson3_bootp.c', 'loongson3_virt.c'))
>   mips_ss.add(when: 'CONFIG_MALTA', if_true: files('malta.c'))
> diff --git a/target/mips/system/meson.build b/target/mips/system/meson.build
> index 498cf289d6f..cf232c9edad 100644
> --- a/target/mips/system/meson.build
> +++ b/target/mips/system/meson.build
> @@ -2,6 +2,7 @@ mips_system_ss.add(files(
>     'addr.c',
>     'cp0.c',
>     'cp0_timer.c',
> +  'interrupts.c',
>     'machine.c',
>     'mips-qmp-cmds.c',
>     'physaddr.c',


