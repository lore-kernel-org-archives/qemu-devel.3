Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF75C25B76
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 15:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE9fk-0005WS-H6; Mon, 03 Jun 2024 11:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE9ff-0005Vo-GS
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:32:30 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sE9fd-0000PX-J4
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 11:32:27 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-421392b8156so13412915e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 08:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717428744; x=1718033544; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kttWk285TmQlKiM54Fl/VNgnRVpdriyOBrecjCQJlxY=;
 b=paDn2Eblos8RiiXhsxe3WF72/UsfXmnNc5bX0sL14Bj53NMawT30R7QA+Jldm0Nf9N
 BGaCKM8o5DdZQl51ORYo/8gIr4lNlv/uMYnRtS3nGUQTNZscQ86c9qaBuuaFxG2sLZXZ
 b0t0tEb81DP/9W1W7rOLzAH9biW3nO52dUDokN98u5WS9B/KSNSDfJaCz42Iv1pXHT4L
 P52EZanwKXHe477UeP42uTVSuBPgSWu8b70PATinP6BApRx2ZHNgq0T/mjy0INDLzFam
 UywOX6PuJCg0riuvg7fnhdzZk8TKqJThnKJ+ASf/bpGMYff2vQKRQ82iHkAKM2zoKR+a
 G3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717428744; x=1718033544;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kttWk285TmQlKiM54Fl/VNgnRVpdriyOBrecjCQJlxY=;
 b=Gxnhnd5Om9Qudnxd1ScvQK/oSIfqC4ZJTnNhIcTVCVNEFVh2nuZCMlXQkwGoiHPhsD
 ixJeWQuZLhCKWRiR39ZyIcDi/OTUOpRKPFTM6QX6c1rnpVk+7VCz5P/NyTQpCHlSayqi
 vCEzNM7ziVh5ZUTO7GrXnq2FkDf+cBd2r9zHRwEUGEup746IlHkR6bSTe3TnaE53waiK
 bMqqAdMIzYWsi/KudiG+tIv1dm7mplQUxkOdMm2P65VRcFPvYGjJfZAI7XeDMwLV2YpP
 GnOMXWrOTWhuIlItX1+3HJi6X+oyZQWVXH699SnedSOnlBMzClEPEO3z2bRbhyXjCvHW
 5c/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh2xbtepYmzFsKQLD+oeKMgsruVVSZM5V7jGNYHFOXqdx7DWZLE+N9sWpsEr+kwy3bGPz5hj6cv3wWvgDHKbFZa1JwLz4=
X-Gm-Message-State: AOJu0YzOakrpboxnoB1n9FyWGbYycILIi5/KV0fKkXn58JCHPlziPbQc
 FkP2AeZWgIv5xzsx072uaIdHU95bf2zYRBb1PXzRcFPpJvwdhobVfigwW50odMo=
X-Google-Smtp-Source: AGHT+IH6om7N+0vFQd82bSP5LWS2wIE47XJ8T38nfsW+/Lg7jPuuZOuDWbKu7N3P5Zl0k1aTNofNOQ==
X-Received: by 2002:a05:600c:1d25:b0:421:2a54:2f1d with SMTP id
 5b1f17b1804b1-4212e061399mr85571975e9.17.1717428743516; 
 Mon, 03 Jun 2024 08:32:23 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b84de44sm120383785e9.11.2024.06.03.08.32.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jun 2024 08:32:22 -0700 (PDT)
Message-ID: <6c1de896-c2fb-4772-b3f9-bd2b6175090e@linaro.org>
Date: Mon, 3 Jun 2024 17:32:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/mips/loongson3_virt: Implement node counter timer
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>
References: <20240512-loongson3_hpt-v1-1-5cb9cbae649b@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240512-loongson3_hpt-v1-1-5cb9cbae649b@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Hi Jiaxun,

On 12/5/24 14:20, Jiaxun Yang wrote:
> Node counter is a timer presents on Loongson-3 chips, which runs
> as fast as CPU clock. It's being mapped into a MMIO location.
> 
> Emulate this for loongson3_virt machine, in hope that kernel can
> use it as a better clock source.
> 
> Hardware's behavior on 32-bit read/write is also emulated in case
> legacy kernel is trying to use it with hi/lo splitted read.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   hw/mips/loongson3_bootp.h |  1 +
>   hw/mips/loongson3_virt.c  | 38 ++++++++++++++++++++++++++++++++++----
>   2 files changed, 35 insertions(+), 4 deletions(-)


> +static uint64_t loongson3_nodecnt_read(void *opaque,
> +                                        hwaddr addr, unsigned size)
> +{
> +    LoongsonMachineState *s = opaque;
> +    int64_t now_ns = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    uint64_t ticks = clock_ns_to_ticks(s->cpuclk, now_ns);
> +
> +    if (addr == 0x4) {
> +        return ticks >> 32;

Does that imply .endianness = DEVICE_BIG_ENDIAN?

It could be simpler to let the core MMIO code do the hi/lo
bits management using ".impl.min_access_size = 8".

> +    }
> +
> +    return ticks;
> +}
> +
> +static const MemoryRegionOps loongson3_nodecnt_ops = {
> +    .read  = loongson3_nodecnt_read,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 8,
> +    .impl.min_access_size = 4,
> +    .impl.max_access_size = 8,
> +};


