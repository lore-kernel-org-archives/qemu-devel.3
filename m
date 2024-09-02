Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F87C54FC6
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 22:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slFGS-0000lD-7s; Mon, 02 Sep 2024 18:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slFGR-0000iF-61
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 18:11:11 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slFGO-0002zF-NP
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 18:11:10 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-374b686d62dso1664293f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Sep 2024 15:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725315067; x=1725919867; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JskBgnUrR0VM/2FuE+LPG6LX2p1Q6bCk3Pxxj8l6LeU=;
 b=EDBJEbCFL0qJlBYMx8LgESSiDGAkN6CAqVlMO/J2GU5aUySJbT9KvTYDF0w2O9pen5
 clYJjWfB1fIQQIRadDrIlx+TiitGnh7kN/v6qm7VJ6+lCGVhmZ8+I83CQMdVPbk1GC4R
 Gf15zl6d9Ji3Vm8q5ovRY+KA75RqL6k61IpKsRnlnswlfxghk5gYzshJn795hhQZYXtM
 lDgzMED1VLuSiAZJ9ShbEMWJSBeYpL0X6hyB2UPIQHr1MYSe5fh3814cvONmVjLwHZ2y
 P3ZM8wthDn9omARB3VAxJ80L2GSgROdCmK+PfLQeCQbC3yZ3m8hMEX6uHqp56+kbOUKl
 P3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725315067; x=1725919867;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JskBgnUrR0VM/2FuE+LPG6LX2p1Q6bCk3Pxxj8l6LeU=;
 b=OEuDQauBI4qmoRpszYkpty4TSomPaoeFvC5D/P1XzI3Kf1sGxpaxw2+YXicHYgRsSD
 2jCBHG2Fn3QyF8yT1UmNVwnVR4bSRc/hkaZX7y1ri5ccZ/3rkTQ6Jyn91TJDTSPhgX7x
 Y2OyGyO51bHw241Udu2BMDKwktVd2Z9SfMp7+GANht6ErpfuEaoLTyU41TpIkihERXWj
 O5sgDYG4xCDFSyy63ae+EMM8IUuz2g+Xk0uB8QjsfDtQojUxZ4HWwalwiQm33IMl76ze
 nlxcZo0SY3ijrFSH/ZGjrDjlxxnPlH87CQ2E31a9HlRwQ82wfk/XUIV2EjST8tUu2UBw
 LeIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUd7JwTjfA6zvk8Z5lNHxYsfQ8Jnqw6yoOJvtzmEqb1U3hTfA+061B8lQsmmQ9a9Jx2OYUePeuUFXzb@nongnu.org
X-Gm-Message-State: AOJu0YzioAJM5xO5SiM9HZ9/7V2eFtPjAuGwbFgvC08QRDYBP3mx9eW0
 QEKqYz/0s/rvQQff/TSP8l96XOLfViaT8y/pyHr0go+hXTEvyFhv6pVpgWnIAfs=
X-Google-Smtp-Source: AGHT+IF9sZoxNMZkOxT+oweOAiua6Eq1hljv3YCwFUBJFfg12ei9d+cTNnqgiHLf/HyoI8veUcnKFA==
X-Received: by 2002:a5d:6b91:0:b0:367:991d:8b76 with SMTP id
 ffacd0b85a97d-374bf04f7b7mr4674524f8f.15.1725315066499; 
 Mon, 02 Sep 2024 15:11:06 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df0f41sm149588255e9.19.2024.09.02.15.11.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Sep 2024 15:11:05 -0700 (PDT)
Message-ID: <f4cd3718-5775-4d88-92f4-48427895d4f2@linaro.org>
Date: Tue, 3 Sep 2024 00:11:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/arm/tcg: refine cache descriptions with a
 wrapper
To: Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: linuxarm@huawei.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, shameerali.kolothum.thodi@huawei.com,
 Jonathan.Cameron@Huawei.com, alex.bennee@linaro.org, jiangkunkun@huawei.com
References: <20240902203211.270-1-alireza.sanaee@huawei.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240902203211.270-1-alireza.sanaee@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 2/9/24 22:32, Alireza Sanaee wrote:
> This patch allows for easier manipulation of the cache description
> register, CCSIDR. Which is helpful for testing as well. Currently,
> numbers get hard-coded and might be prone to errors.
> 
> Therefore, this patch adds a wrapper for different types of CPUs
> available in tcg to decribe caches. One function `make_ccsidr` supports
> two cases by carrying a parameter as FORMAT that can be LEGACY and
> CCIDX which determines the specification of the register.
> 
> For CCSIDR register, 32 bit version follows specification [1].
> Conversely, 64 bit version follows specification [2].

---

[cut]

> Changes from v2 [3] -> v3:
> 
> 1) add only one function instead of ccsidr32 and ccsidr64
> 2) use deposit32 and deposit64 in ccsidr function
> 
---

> [1] B4.1.19, ARM Architecture Reference Manual ARMv7-A and ARMv7-R
> edition, https://developer.arm.com/documentation/ddi0406
> [2] D23.2.29, ARM Architecture Reference Manual for A-profile Architecture,
> https://developer.arm.com/documentation/ddi0487/latest/

---

[cut]

> [3] https://lore.kernel.org/qemu-devel/20240830184713.224-1-alireza.sanaee@huawei.com/
> 

---

> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>   target/arm/cpu-features.h |  50 ++++++++++++++++++
>   target/arm/cpu64.c        |  19 ++++---
>   target/arm/tcg/cpu64.c    | 108 +++++++++++++++++++-------------------
>   3 files changed, 117 insertions(+), 60 deletions(-)
> 
> diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
> index c59ca104fe..ef40b0dfdc 100644
> --- a/target/arm/cpu-features.h
> +++ b/target/arm/cpu-features.h
> @@ -1022,6 +1022,56 @@ static inline bool isar_feature_any_evt(const ARMISARegisters *id)
>       return isar_feature_aa64_evt(id) || isar_feature_aa32_evt(id);
>   }
>   
> +typedef enum {
> +    CCSIDR_FORMAT_LEGACY,
> +    CCSIDR_FORMAT_CCIDX,
> +} CCSIDRFormat;
> +
> +static inline uint64_t make_ccsidr(CCSIDRFormat format, unsigned assoc,
> +                                   unsigned linesize, unsigned cachesize,
> +                                   uint8_t flags)
> +{
> +    unsigned lg_linesize = ctz32(linesize);
> +    unsigned sets;
> +    uint32_t ccsidr32 = 0;
> +    uint64_t ccsidr64 = 0;

deposit32() works with unsigned so you can use 'uint64_t ccsidr' for
both cases and return once.

> +
> +    assert(assoc != 0);
> +    assert(is_power_of_2(linesize));

As mentioned in v2, if you insist in using an inlined method, you have
to include "qemu/host-utils.h" to get is_power_of_2() declaration.

If the inlining is proven problematic later we can still un-inline
it, so as this is an useful cleanup (preferably with one 'ccsidr'
variable and the include):

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> +    assert(lg_linesize >= 4 && lg_linesize <= 7 + 4);
> +
> +    /* sets * associativity * linesize == cachesize. */
> +    sets = cachesize / (assoc * linesize);
> +    assert(cachesize % (assoc * linesize) == 0);
> +
> +    if (format == CCSIDR_FORMAT_LEGACY) {
> +        /*
> +         * The 32-bit CCSIDR format is:
> +         *   [27:13] number of sets - 1
> +         *   [12:3]  associativity - 1
> +         *   [2:0]   log2(linesize) - 4
> +         *           so 0 == 16 bytes, 1 == 32 bytes, 2 == 64 bytes, etc
> +         */
> +        ccsidr32 = deposit32(ccsidr32, 28,  4, flags);
> +        ccsidr32 = deposit32(ccsidr32, 13, 15, sets - 1);
> +        ccsidr32 = deposit32(ccsidr32,  3, 10, assoc - 1);
> +        ccsidr32 = deposit32(ccsidr32,  0,  3, lg_linesize - 4);
> +        return (uint64_t)ccsidr32;
> +    } else {
> +        /*
> +         * The 64-bit CCSIDR_EL1 format is:
> +         *   [55:32] number of sets - 1
> +         *   [23:3]  associativity - 1
> +         *   [2:0]   log2(linesize) - 4
> +         *           so 0 == 16 bytes, 1 == 32 bytes, 2 == 64 bytes, etc
> +         */
> +        ccsidr64 = deposit64(ccsidr64, 32, 24, sets - 1);
> +        ccsidr64 = deposit64(ccsidr64,  3, 21, assoc - 1);
> +        ccsidr64 = deposit64(ccsidr64,  0,  3, lg_linesize - 4);
> +        return ccsidr64;
> +    }
> +}


