Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C6F4FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 12:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJsQS-0000Fm-IT; Mon, 04 May 2026 08:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wJsQO-0000FA-In
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:29:24 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wJsQM-0005mW-LA
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:29:24 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so20106535e9.1
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 05:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777897761; x=1778502561; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CAQlwwkT5l57geKAW4ArK3ulPzBSNSJwLsR8rysX02A=;
 b=H+AL1ko7BSt33WMZkcxgf/lVy7jllM/uXWyKpbXE+mgxGcDABSi123QgBcubzg6j5s
 GjCTbhMdYSiveuS95Wj/Md+1PF5mlTrrOPOdcU43wJ7/QQzIAepJVrJV6Ht+RbmfAHKW
 /a4majNQiHLha11we9VD0BLK594FsQcMYk0oS1FW9yL9Q1YXAQG1Pj3i0QIAzN0OroO1
 9HXoYVE1VztcRNcFMT3mieEWAFCIJrqoEwVoi5IvAVHPOzFRmY18VoanlQcm94A7IN9Y
 KmOqizF66u0Q5aJyGZFO9E92v458IcTSwVPF2daT7YAMHmCl0RQUO70Bk7MBeKjzPb6e
 MObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777897761; x=1778502561;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CAQlwwkT5l57geKAW4ArK3ulPzBSNSJwLsR8rysX02A=;
 b=Hio14s+aXsdKqnTnOifSjCc2PdRVS8T5Z9NJOwGK6xXAF427aZMcmDBeLGcWQnyl2J
 ch6vxFvj2JND0fmwXUebLDcSvmslu3gCw8BIaJ/rjuvZIr8/TtCITR3SHbIy5fet5lUG
 flVnt8jvAv2Y96gWMKq4lMfX4o/lhuf9Wv6wpVSTVnNoonWEp4zWGpw2AMZ7aoBKJnzi
 P4j2Z5O0pZzV5M8/5uQC7xGRAjHOXu8QVJQq1iaKNPG5T9ivURW8HTGsDTQKjM3/GGXl
 Ju18cWhtJi0Fvdm35wOR84adGNzfdB5onES1Iy72uypkOXvvmRsQBMDgmX1wnoYickST
 7+UQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ93OTkbwd/yJ9VQHU+jnL2/b96Pm7zosMQ4mweVJ6rqjjUmxT+6/wV13tw9bs/wPDO6oKEwjbAZPKAf@nongnu.org
X-Gm-Message-State: AOJu0YzZ7qLEDtCZfRKKoVgkqDrTdb3Ibz6FVZl8/ufVk6zFoBi3bDDp
 GUrF5jKJF9BpXUsKR2mjsiSULGEiVrsaTJIwZzJ9dXdPqsLP01ddfnJ7cbwtbIz2f4M=
X-Gm-Gg: AeBDievar/cbe7o/xdLB5+djiDPYQbXBrje02lrQC9fsX6FXAJz190dTAbt/HRhCrk2
 qdsmBF/Qoi3i1adSATh2zN5j3hzE9PnQTUhhaMAv45xAld3TslmOIj7+vraHyMfIpdTzjUv6Ds6
 ZPZIu0U8GCou7tU8nXqUSX54aWO0qy1h6zkOqjRGIDBvujoKJYnQobIp68VRwybPJP2lG2r5Md/
 MwmXyMEPH/u8wZ+zUS5zG8N9c5l/MEf2at3j8MSEafMP9Gq2bcuy9iBTXYuuAPst6tQn0kiyfvN
 lIofS+oXUyCCwM8SM1K7PqOBsrNRGzPyCjKc2DlHH/tJS8bkKArbEyDf51ajdmUVUN8j9xCMVWt
 OIeIbXom8eqZUUZWxsqkypIZHS+g/dm4LojChqOhMwcT6OdOlRCwWCCXVv9Pk85heav5pRk1kZd
 5QJMQXSLuD/1IQMmfgh9N9mKIjo618qgGwVlpmmp+FjCnMfTgyjDOblaZln5OmGEEHnSsFKVuAn
 D50
X-Received: by 2002:a05:600c:859a:b0:48a:7f90:2231 with SMTP id
 5b1f17b1804b1-48a9865f859mr109667675e9.19.1777897760775; 
 Mon, 04 May 2026 05:29:20 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a82308d77sm378279775e9.14.2026.05.04.05.29.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2026 05:29:20 -0700 (PDT)
Message-ID: <dac8ddbe-37c6-42b0-a6b7-8f42d96d24e6@linaro.org>
Date: Mon, 4 May 2026 14:29:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/bcm2835_rng: Specify valid memory access sizes
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20260501162700.4092512-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260501162700.4092512-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Hi Peter,

On 1/5/26 18:27, Peter Maydell wrote:
> The BCM2835 RNG has 32-bit registers only; specify this in
> the MemoryRegionOps so wrong-sized accesses are rejected rather
> than getting to the assertions in the read and write functions.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3394
> Fixes: 54a5ba13a9f ("target-arm: Implement BCM2835 hardware RNG")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/misc/bcm2835_rng.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/misc/bcm2835_rng.c b/hw/misc/bcm2835_rng.c
> index e4d2c224c8..bd4acade5b 100644
> --- a/hw/misc/bcm2835_rng.c
> +++ b/hw/misc/bcm2835_rng.c
> @@ -93,6 +93,8 @@ static const MemoryRegionOps bcm2835_rng_ops = {
>       .read = bcm2835_rng_read,
>       .write = bcm2835_rng_write,
>       .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid.min_access_size = 4,
> +    .valid.max_access_size = 4,

.impl is clearly 4 (why not set it? I tend to think the default
values -- where unset -- come from adapting pre-MemoryRegionOps models,
and today better be explicit and avoid implicit defaults here).

What is the rationale for max_access_size=4, that the ARM core is
a 32-bit CPU? I guess remember these peripherals are on an AXI bus
accessible by the videocore as 64-bit accesses. But QEMU doesn't
model that, and other peripherals are also limited to 32-bit max.
So good enough for now I suppose.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   };
>   
>   static const VMStateDescription vmstate_bcm2835_rng = {


