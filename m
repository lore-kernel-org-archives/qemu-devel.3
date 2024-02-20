Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F18EAC48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 12:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcP8r-0003kk-A1; Tue, 20 Feb 2024 07:22:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcP8m-0003gT-En
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:22:28 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcP8k-0005Og-LJ
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:22:28 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33d2b354c72so2054080f8f.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 04:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708431744; x=1709036544; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=120Mbf918CfIjoH9RXejPvN/VltDfd8gHYe9CW7AQaw=;
 b=TVi1cNpbUK6AL16HsYuETOw/rrGMOghQPXswsqMiQ1/t7SDDgLoXUx+PPG19ic4VX9
 znlFFedw/buMxsXpgQakjLuUETeqKyTzknhtcKMnZRe4e3pAkZavaT7ozBhXteuMNU8d
 54gh5O6vCWg1z2bBk/L1fp98+tt6j+4EQV+utuudQkHzPpcvueAn24VDgO3tIegxkfuV
 rlk/8aeFyHWIdOAKFh7dBTRKf85+tgc7Y6bm3LEhIMZ/HxMClXGXNIkIbeKgxoRCI5fx
 fv2G8RY6BzRKii5O6G6FJcVLP+Qsj0tmUrAruq3cmHKcLaDRzob8cS9ZKojDOxWM/ZxA
 aLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708431744; x=1709036544;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=120Mbf918CfIjoH9RXejPvN/VltDfd8gHYe9CW7AQaw=;
 b=oMWvVCQFI38qmwRyNtsT7GiCLuaVUeEXxLF/fl23Hgjpf/QuZ6EekxwCPWvA5OR7x6
 gJCCnfDZ7kj0nTzZpnNPCccFs0WYue08WIsbGTAxePvQzSrzUIccCmnZB210Typ7oNLA
 qvBZzKZD7llomwz/GH27ItIW7Pa3DLIYlS2jD8Iovr42S6BMdslpRZb5KaSiBPJtge1S
 FEfjvpCj4Se8Boj7kqcfhknI4Bo84V39fErCXuBijxdkTrlAE/o6jlhDqqkE6F+4Bdlk
 ErjrDIqNHtbwZNPA1lRCkVziBIRjusJJX1vWqZ4xeoyhXQXfSH7VJd/k5KoJ+WzcunZX
 3i6w==
X-Gm-Message-State: AOJu0YzjftGInU/+6ATRU0zho0rkl9P8v68FwmeppyKhaDWLFfFNa3YY
 86f4z2W+tASHJJk+J3YHZztfSx7HA4BExSshzDs1sh5OxLobicjM8lHi13bOFeo=
X-Google-Smtp-Source: AGHT+IE84mlVvKFg005XOyWa7JGRGtTAi1BUGHPX+83Y8i8lOAC/FBHhhEOORuWEWlX173XeijANyw==
X-Received: by 2002:a5d:5645:0:b0:33d:3b82:ab2a with SMTP id
 j5-20020a5d5645000000b0033d3b82ab2amr5055985wrw.19.1708431744271; 
 Tue, 20 Feb 2024 04:22:24 -0800 (PST)
Received: from [192.168.69.100] (mek33-h02-176-184-23-7.dsl.sta.abo.bbox.fr.
 [176.184.23.7]) by smtp.gmail.com with ESMTPSA id
 a7-20020adfeec7000000b0033b483d1abcsm13193952wrp.53.2024.02.20.04.22.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 04:22:23 -0800 (PST)
Message-ID: <9383e2a1-f956-4207-8c8e-27b8818444d7@linaro.org>
Date: Tue, 20 Feb 2024 13:22:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 21/21] target/sparc: correct typos
Content-Language: en-US
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <cover.1708419115.git.manos.pitsidianakis@linaro.org>
 <deda57f7d7dde2b88e2975ed6dee6cd85fb0ff96.1708419115.git.manos.pitsidianakis@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <deda57f7d7dde2b88e2975ed6dee6cd85fb0ff96.1708419115.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 20/2/24 09:52, Manos Pitsidianakis wrote:
> Correct typos automatically found with the `typos` tool
> <https://crates.io/crates/typos>
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   target/sparc/asi.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


