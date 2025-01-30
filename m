Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC88C02193
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 22:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdcgj-0007nU-Pq; Thu, 30 Jan 2025 17:07:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdcgg-0007mu-2O
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 17:07:02 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdcgd-0006Ed-FT
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 17:07:01 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385de9f789cso1087006f8f.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 14:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738274818; x=1738879618; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3DhTxPruFzLIvBQIEPufbWnYLODqX5Zqz9c9MMMl/ug=;
 b=mXCGPYAl3jmkt72tNxKOczItQzCnWyFB87FS8JuXTF/Kj8Zv+EOxRXA1i7ny2Phb6l
 xCUbDXLJ3tNhvG/fdmo81C/4sw7WeWCmhd7GAR4VE4P0xPhZRXA5jLgoAx80C5J3u9Yu
 DdI6BATXn4Z8NSq26WqbpahFm0sG7PSPRkJp4Hl/qE/OK/48dIsGH4ELeH9p+9hbQGhm
 1ClMzHzvi+KDDQUb/fQFGWi6ZCr/DskGxwC4yLKpyABnamahDMCqOqmWmgx5Agafcyxh
 DH/s/Nzi0zmjzbeDn5jDr2L4KPimZ7l8sK/7sN+qDs26ICewWHhT31bf09ga+eqKevTr
 JJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738274818; x=1738879618;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3DhTxPruFzLIvBQIEPufbWnYLODqX5Zqz9c9MMMl/ug=;
 b=wy1KBGzSaEjttI32QPPrlnSA0tOMk9h75aGYQMEoJ7Vi3sm2QGeSzBP0F+bQtA4oxl
 qv5sNDizIK1mn5foGbN+MYWWBiK66Q+GxvR1gEiS2xiI8bGyPWXw2M98FbbBORxYnypo
 ltKFLszruvBKmzej1J62QjAWmm/Bv/f8uo9aTTk8pCp10s3qoTtUN6iwbgbUEolvJs51
 Q6Lsur4vt7Rj+chbGKGCP/RgiXmlGryzkf5kRENHAJmLnE2vwEcENmAqvBLzGy8ALrTk
 syHc0i0cXoNE+/uz5D0NJkDCwgL18/2n63sykSSk1puMT0iwzbJrQTDY2po9nLhT3Jqn
 ZHlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2kNff9YmWn98SE9RHgECTBP4AS6hmgWNj5RZEUjywqEfz3V9X3NxroZVEvb347p0EVL2GbhzTvE5w@nongnu.org
X-Gm-Message-State: AOJu0YyONH8tWTjJcE/YOcsAA+qusd4X35upgCY/cWOcd2ty+V3AJPnh
 8+aGMQvvneaPMwUipwNfbPDVdB3U0t/Un4wjmT9AX4R+KSPpLjmKAOFzCTQncSU=
X-Gm-Gg: ASbGnct/1v5smUvTW/OqU4aMiopPWs4TDZPb7aZjBV81MmXZ3KNvc2fo7dGYlM2ZdOV
 yWq9XBqXG4TeOlChadeqFZcduGebJP/iXiquW03EeyNob5u5g0i5UNaqrRYRCFxausjRm58ln/D
 V1D9iEFCaAEVFLAxXRp/S1eWnq/cnKz20EpCuLsyxF81yOmyMWEI2GWNbDVYgveJHQTDj1imht2
 mBczwvcSRfIZ8T3Kl18FzsDdy0RbL/fJGk39E8ufr37R+dgabPl0Q70K80RyzszkZ4a1K5BWA5j
 bROMgN4T1c4+QBGyWZJHe2T9WpuFV12bt9/lWtY4EIarJ5nMcEvkT7ufgxs=
X-Google-Smtp-Source: AGHT+IHC1spnaVHFcY8pZcaV5jMCsoX/AG5PZCfJf2w2cxck+sEXotUnG0/QtWQYDuatn7TnaVEeCA==
X-Received: by 2002:a5d:584e:0:b0:38a:8b00:6908 with SMTP id
 ffacd0b85a97d-38c520b0b23mr8475392f8f.54.1738274817737; 
 Thu, 30 Jan 2025 14:06:57 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23d48b3sm37515985e9.5.2025.01.30.14.06.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 14:06:57 -0800 (PST)
Message-ID: <ad6875fe-5ea7-43fd-90f1-d8667273f7b2@linaro.org>
Date: Thu, 30 Jan 2025 23:06:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] hw/sd/omap_mmc: Convert output qemu_irqs to gpio
 and sysbus IRQ APIs
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
References: <20250128104519.3981448-1-peter.maydell@linaro.org>
 <20250128104519.3981448-4-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250128104519.3981448-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 28/1/25 11:45, Peter Maydell wrote:
> The omap_mmc device has three outbound qemu_irq lines:
>   * one actual interrupt line
>   * two which connect to the DMA controller and are signalled for
>     TX and RX DMA
> 
> Convert these to a sysbus IRQ and two named GPIO outputs.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/sd/omap_mmc.c | 20 +++++++++++++-------
>   1 file changed, 13 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


