Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 284E0CD13CF
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 10:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl3yH-00040j-NZ; Mon, 02 Sep 2024 06:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sl3y1-0003z5-L2
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 06:07:28 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sl3xx-000577-L7
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 06:07:25 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42bbe809b06so22100795e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 03:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725271635; x=1725876435; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/TC5i/JKT5tPIvEogbVzGPSG+Fta5PWN2nnd56Hg3YU=;
 b=jAnfV6u759sFAPthYB51JO8r4omJWeSlmdeJ/TCcz2WvqI/5buMvKd+8SQGYiXxz9b
 zj/EokQYoNk1Y9vkygLZaw7QIC+01bogCnoh+N0ZEpXB4tMQpQ0lWjVNzZi29B/AX0F3
 Vx+yymN1RPhbnIWEDDoixEh0okQf6dI8C7PJXaISL++ffAX/65JKM35cfFpLOKe5Fybk
 8b+WxhjpXqI7+u81mRCYnQfqxhU0DQhiE57gtFdMFDvybY9WpVkFmHfjQ+2js24Rputd
 tbWMkZxgH+rpaN+mRXibKm3KJNPufOHms+fYAac01NxNwlfHkv5um2n2iA210UCZqTbx
 0pdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725271635; x=1725876435;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/TC5i/JKT5tPIvEogbVzGPSG+Fta5PWN2nnd56Hg3YU=;
 b=vQwd6qj1Nwb6xQ0k7ssQxNwvC0zBm4uQvVImVq684gL7T1wrKqFPysuLVIO4XDAesI
 3FNeyTMixgD06mqIcOvXaVbyuPN3wbAkzeLKOf8THb6kPcLsrtV6LN0wy8+1BMzsD/Wa
 awfu1LZFoO8I5vdo0R72qXEkATm34Duubb1tDKoxCVGh+xCPC8RsLnU+VyXkWF7b29tZ
 RygyURV0RO/w9HlduaMHAK81VPwmqy31CjMVdvpkNhqFcCOsw4qtXNBnnzKiEBG7wzkH
 zNma36+SNrsW7kTss7xZk3P+1/Y1n1pmbStgUkAo/zH3z9G6tj+6CF2lWKGCjrzBLEEB
 F9wg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+hLUJC0oOtwutAmOkv30TN1qMLO77qQaG+KkYBm/zo8DRnB1DemfsNCkBw3sVNG7L/UeE1SeGHPhp@nongnu.org
X-Gm-Message-State: AOJu0YxPQYShMH/JrgheTA4dGkzWCmA5w/Binb2CqCpHqTO63Wtb0gkV
 T3CcMFd+4DNK6XfzYUHJmecJXuILyy9v5O9rK1L4J76jSRg9z6QPYp9jRNDA9ko=
X-Google-Smtp-Source: AGHT+IEkA3s/b7brSSJLT6VnAMqKX+/POPZFxTHmOcDS18vZ37pZLr54l4R1GhniF2Dq3B1aYFp+dg==
X-Received: by 2002:a5d:4ec3:0:b0:374:c581:9f4f with SMTP id
 ffacd0b85a97d-374c581a03amr2388325f8f.55.1725271635310; 
 Mon, 02 Sep 2024 03:07:15 -0700 (PDT)
Received: from [192.168.89.175] (255.red-88-29-191.dynamicip.rima-tde.net.
 [88.29.191.255]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749ee4ddc8sm10960264f8f.21.2024.09.02.03.07.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Sep 2024 03:07:14 -0700 (PDT)
Message-ID: <6bed13cc-fe6e-40ec-93af-1723bf46a6c3@linaro.org>
Date: Mon, 2 Sep 2024 12:06:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/arm/tcg: refine cache descriptions with a
 wrapper
To: Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: linuxarm@huawei.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, shameerali.kolothum.thodi@huawei.com,
 Jonathan.Cameron@Huawei.com, jiangkunkun@huawei.com
References: <20240830184713.224-1-alireza.sanaee@huawei.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240830184713.224-1-alireza.sanaee@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Hi Alireza,

On 30/8/24 20:47, Alireza Sanaee via wrote:
> This patch allows for easier manipulation of the cache description
> register, CCSIDR. Which is helpful for testing as well. Currently
> numbers get hard-coded and might be prone to errors.
> 
> Therefore, this patch adds wrappers for different types of CPUs
> available in tcg to decribe caches. Two functions `make_ccsidr32` and
> `make_ccsidr64` describing descriptions. The 32 bit version receives
> extra parameters that became unknown later in 64 bit.
> 
> For CCSIDR register, 32 bit version follows specification [1].
> Conversely, 64 bit version follows specification [2].
> 
> [1] B4.1.19, ARM Architecture Reference Manual ARMv7-A and ARMv7-R
> edition, https://developer.arm.com/documentation/ddi0406
> [2] D23.2.29, ARM Architecture Reference Manual for A-profile Architecture,
> https://developer.arm.com/documentation/ddi0487/latest/
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>   target/arm/cpu-features.h | 53 ++++++++++++++++++++++++
>   target/arm/cpu64.c        | 19 ++++++---
>   target/arm/tcg/cpu64.c    | 86 ++++++++++++++++++---------------------
>   3 files changed, 105 insertions(+), 53 deletions(-)
> 
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index c59ca104fe..00a0f0d963 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -1022,6 +1022,59 @@ static inline bool isar_feature_any_evt(const ARMISARegisters *id)
>       return isar_feature_aa64_evt(id) || isar_feature_aa32_evt(id);
>   }
>   
> +static inline uint64_t make_ccsidr32(unsigned assoc, unsigned linesize,
> +                                     unsigned cachesize, uint8_t flags)
> +{
> +    unsigned lg_linesize = ctz32(linesize);
> +    unsigned sets;
> +
> +    /*
> +     * The 32-bit CCSIDR_EL1 format is:
> +     *   [27:13] number of sets - 1
> +     *   [12:3]  associativity - 1
> +     *   [2:0]   log2(linesize) - 4
> +     *           so 0 == 16 bytes, 1 == 32 bytes, 2 == 64 bytes, etc
> +     */
> +    assert(assoc != 0);
> +    assert(is_power_of_2(linesize));
> +    assert(lg_linesize >= 4 && lg_linesize <= 7 + 4);
> +
> +    /* sets * associativity * linesize == cachesize. */
> +    sets = cachesize / (assoc * linesize);
> +    assert(cachesize % (assoc * linesize) == 0);
> +
> +    return ((uint64_t)(flags) << 28)
> +        | ((sets - 1) << 13)
> +        | ((assoc - 1) << 3)
> +        | (lg_linesize - 4);
> +}
> +
> +static inline uint64_t make_ccsidr64(unsigned assoc, unsigned linesize,
> +                              unsigned cachesize)
> +{
> +    unsigned lg_linesize = ctz32(linesize);
> +    unsigned sets;
> +
> +    /*
> +     * The 64-bit CCSIDR_EL1 format is:
> +     *   [55:32] number of sets - 1
> +     *   [23:3]  associativity - 1
> +     *   [2:0]   log2(linesize) - 4
> +     *           so 0 == 16 bytes, 1 == 32 bytes, 2 == 64 bytes, etc
> +     */
> +    assert(assoc != 0);
> +    assert(is_power_of_2(linesize));
> +    assert(lg_linesize >= 4 && lg_linesize <= 7 + 4);
> +
> +    /* sets * associativity * linesize == cachesize. */
> +    sets = cachesize / (assoc * linesize);
> +    assert(cachesize % (assoc * linesize) == 0);
> +
> +    return ((uint64_t)(sets - 1) << 32)
> +         | ((assoc - 1) << 3)
> +         | (lg_linesize - 4);
> +}
> +
>   /*
>    * Forward to the above feature tests given an ARMCPU pointer.
>    */
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 262a1d6c0b..57ebc1b979 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -23,6 +23,7 @@
>   #include "cpu.h"
>   #include "cpregs.h"
>   #include "qemu/module.h"
> +#include "qemu/units.h"
>   #include "sysemu/kvm.h"
>   #include "sysemu/hvf.h"
>   #include "sysemu/qtest.h"
> @@ -642,9 +643,12 @@ static void aarch64_a57_initfn(Object *obj)
>       cpu->isar.dbgdevid1 = 0x2;
>       cpu->isar.reset_pmcr_el0 = 0x41013000;
>       cpu->clidr = 0x0a200023;
> -    cpu->ccsidr[0] = 0x701fe00a; /* 32KB L1 dcache */
> -    cpu->ccsidr[1] = 0x201fe012; /* 48KB L1 icache */
> -    cpu->ccsidr[2] = 0x70ffe07a; /* 2048KB L2 cache */
> +    /* 32KB L1 dcache */
> +    cpu->ccsidr[0] = make_ccsidr32(4, 64, 32 * KiB, 7);
> +    /* 48KB L1 icache */
> +    cpu->ccsidr[1] = make_ccsidr32(3, 64, 48 * KiB, 2);
> +    /* 2048KB L2 cache */
> +    cpu->ccsidr[2] = make_ccsidr32(16, 64, 2 * MiB, 7);

I like the uses of make_ccsidrXX() instead of the magic values.

I don't like much the code duplication between make_ccsidrXX()
definitions, I'd prefer both call a common (static?) one.

I'm not keen on adding inlined functions in target/arm/cpu-features.h.
Just expose the prototype declarations, and keep the definition in .c
files. That way we don't need to include "qemu/host-utils.h" to get
is_power_of_2() declaration.

Regards,

Phil.

