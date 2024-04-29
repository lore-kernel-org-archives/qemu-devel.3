Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2E3C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 11:12:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Ovm-0000d4-HP; Mon, 29 Apr 2024 07:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Ovf-0000ci-20
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 07:12:15 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1Ovc-0001bZ-E0
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 07:12:14 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-34b66f0500aso3547287f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Apr 2024 04:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714389130; x=1714993930; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HWtE2C2YAC+hry9cA1iqS/HWtTJGXmcEI8/9znojBPs=;
 b=f/hNfApr/nodmWxjonI5me0jToYay3wa6Z1vU/Ji+f37DGByONoLEq//Cs4oab15lv
 TGd+W8RJnA4SRyZ5ryGq6cWt//nSJFz4eOR5jl5PFdDVr3SZHkSorzyOQxIrU9q2k7Bl
 UCiXelu3YOcERIo6yiL26/fpnrf24aI667OH8XOxamY8rmmnA7R5m4fxNapYwEmHhf5s
 Hd9FeQEE+xtZ1JAzfhe8i1yfLXFRekzW1U7vk4MGzhttNozeRPtZ4XzNhaJjEFbcI6pk
 Z64MiMtilmuQnUG/YiKMbPPAJtPjBTxkZzu+jlht0KT7qR+pxmWRsecO97eHkOcjW0a5
 zxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714389130; x=1714993930;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HWtE2C2YAC+hry9cA1iqS/HWtTJGXmcEI8/9znojBPs=;
 b=f6sz9IiZ7M1Uk+E1ft1SXo+jKX4VffVdY7czg8LXARJVM89cNNkLUZPVYbzhImuLx/
 8gOjcoIY+zbm3HdFb5h9+80BkcnV9RcIhVSTT6Ds3TdlexNMQAHW4FCJvG9sqSZJf7zB
 g80AVbfXkzr8lhqJ12ydqcErMrUJ+/VkSzufNcu8PB2cVeggLYenPanoG3YuAvPf+53C
 s4GNUILXuE1RhXDVGKPdcyqEVe7SDfyneJPnPwU77vxWfQi90ThjKPoKSLF3TIMNqbj3
 CVtr/HBupSUTG3Mrm+lg7wCg7RLrIEiZqSo5hUWDk1ftUM9c94Cbhes8kT5KZufBSo2H
 UHSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcuQGN50Z+9IWo4V/jHoMqOKxhU0NzcIcOiD/CLWFiCtcKSaYSpY45tGovrcfeQ0Z+oZSkr4x53n/FlKvx/MsLrpLumRc=
X-Gm-Message-State: AOJu0YwDgPyG60/JDT34/Xh6L7LLvR/aDBW+tMxfrUSWvzra6f82rgH5
 Zht+IneokkMDV/jcBNXwWoNn0CbEKQYAe4WJ0s1wILFbvqn3e0iKAsiNAmd+lIuQnuxQQMALD+w
 lGy8=
X-Google-Smtp-Source: AGHT+IEC2++R/EoUUGtTdw+lf5wR1cUbNQ+wIzi3Z/0B/3XoIH/AhHkkItbU89MjIEP+4bP2vIf59Q==
X-Received: by 2002:adf:f591:0:b0:34c:f526:6d17 with SMTP id
 f17-20020adff591000000b0034cf5266d17mr2968076wro.30.1714389130573; 
 Mon, 29 Apr 2024 04:12:10 -0700 (PDT)
Received: from [10.79.37.248] ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 b10-20020a5d4d8a000000b0034cf989dbf5sm3057281wru.44.2024.04.29.04.12.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Apr 2024 04:12:10 -0700 (PDT)
Message-ID: <25d4596a-1184-4e6d-a435-25aa3ede05fa@linaro.org>
Date: Mon, 29 Apr 2024 13:12:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/10] tests/bench: Add bufferiszero-bench
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424225705.929812-1-richard.henderson@linaro.org>
 <20240424225705.929812-11-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424225705.929812-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 25/4/24 00:57, Richard Henderson wrote:
> Benchmark each acceleration function vs an aligned buffer of zeros.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tests/bench/bufferiszero-bench.c | 47 ++++++++++++++++++++++++++++++++
>   tests/bench/meson.build          |  1 +
>   2 files changed, 48 insertions(+)
>   create mode 100644 tests/bench/bufferiszero-bench.c


> +static void test(const void *opaque)
> +{
> +    size_t max = 64 * KiB;
> +    void *buf = g_malloc0(max);
> +    int accel_index = 0;

Nitpicking, accel_index could be unsigned like in util/bufferiszero.c.

> +
> +    do {
> +        if (accel_index != 0) {
> +            g_test_message("%s", "");  /* gnu_printf Werror for simple "" */
> +        }
> +        for (size_t len = 1 * KiB; len <= max; len *= 4) {
> +            double total = 0.0;
> +
> +            g_test_timer_start();
> +            do {
> +                buffer_is_zero_ge256(buf, len);
> +                total += len;
> +            } while (g_test_timer_elapsed() < 0.5);
> +
> +            total /= MiB;
> +            g_test_message("buffer_is_zero #%d: %2zuKB %8.0f MB/sec",
> +                           accel_index, len / (size_t)KiB,

Thus "buffer_is_zero #%u:..."

Regardless,
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +                           total / g_test_timer_last());
> +        }
> +        accel_index++;
> +    } while (test_buffer_is_zero_next_accel());
> +
> +    g_free(buf);
> +}


