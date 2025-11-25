Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5501D0E6C5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 11:06:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNqs0-0002yv-4F; Tue, 25 Nov 2025 06:06:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqrt-0002tb-An
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 06:05:58 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNqrl-0002we-NB
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 06:05:54 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso52307185e9.0
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 03:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764068724; x=1764673524; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UgY++uly/bN0M4cyXaOljm64OjzaEubh9yqkMc+mvvw=;
 b=f7legtUhLagefAnUYEJHSwDS98Boja4+0UjsUlj6JdHqxLT4Hw2NL+A/aEYiXtDw/3
 anYEx68NL64hJeXOXk+ADmJVYaJpgwvevrFyphVgsIk2rKJJtpkffhnrSLIiqRl6ClKP
 I2VnSJfBSeYqMKfisdrITMJusLfyWy4BbQ621exR8u2nKzFPtqCosNSCQfKN4+QeM40r
 SgYo3dZKpawmW4qUYPLdzdvAbW5xMMin6o60/4Vebhyv6W/fnx+Krv2t8juQwo42jkCH
 RhFzfjdB5bM5pN/zPrCxbGySU9eca0e2IDFVYRdsK8y4sLb3/TCs4QxeqhHXIcASL02t
 7NDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764068724; x=1764673524;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UgY++uly/bN0M4cyXaOljm64OjzaEubh9yqkMc+mvvw=;
 b=nwxKI7mcFotNje1bahQ/SUyE1rwq5B8L6UWziFKtqF2HNjH77dlF+4I2Aok6ZKLd2l
 Ec65iCQjAHMs3coNC8XV0zKI7GUzHry7xQwuV1tHouiVYghUhF4Q2pdZpqs8z9OgcDyq
 7xUDD4qz4w8Tz0KvP8w3PEcDXCgIu2ZZcCFYNF1G0i6CBa4JhxHJG/OxXHFhIJSBjR5J
 mNNclRfVuU9Hwrf18YOkukEPyYttXkzeTRXqfT/Eg56EBhfINpQckAmvBU6PSrzUcsdU
 KNCwCqVV/4kCFwJhlCj3KAG4wu5CEW+eFYhRMwd+MYgOTQC3gHxZesUWmyCN9+QexMOo
 TVkA==
X-Gm-Message-State: AOJu0YxiRmPt2v3GJ2OARELkAIky5Ikyq7yKPO4lVkpFweLH4QFZZ8Nw
 PwpVrUg7aOI4MFM2i00jIfCVhHIkw4AzlWyN0hs9PJ2bTyxWiOnXMTG+yGWbUhoj/nk6rNqrOLA
 uRLG9OEdbmw==
X-Gm-Gg: ASbGncu4u+KWIZ3DRiSOdeHh3EthuKgMqiTUaUBTZmxYBLMoxLTrNh5Ji0YmVKFn2Ce
 WSWicSEkkO+6/NOXT/W1wpPaDesd/ExFk2T+BxwVVXXWe6U8NWbuaR3Ic1yxQNihnmqAr1pcBpH
 uh2UFce3rw7s98bauRE2mS3fYUGkIDFf52kUdIy/HY9qNQk2C3YeYRCaHnGY7PEMJQp8Nj3EzfP
 kmq4ufshu9UrVwMwyhtMGTWG1jfuvl6vmkqA5+cwJ9486vroXleaHvGgTFtT72i+VDqk+UHdi7S
 lSfc8WTxQa4WBrumXt65F3bKr00oiUpbszaFvjRzANL4D+Y727HNf9KSyhQIR3RvhNOK0jh4ht4
 HFcf9pcw79DJxbvSnLXRKE9FKOlmuq2AwuSUSunf4SXHlginNWEjnZqAah8E68PI+rRjpvxuXPB
 Ls3LWZrLnaQkVfbm1raOrYvNzSfwVN54luvguNmNeFH2JDgsZkfV2huw==
X-Google-Smtp-Source: AGHT+IEcZP/BerIFuxFIImchNu5kCriDjHmsWm+p5Lp5A/sv02Oy2v/vygNs75uHHPBKDSgGhS4ONA==
X-Received: by 2002:a05:600c:1c82:b0:477:73cc:82c3 with SMTP id
 5b1f17b1804b1-477c01ee405mr148333775e9.26.1764068724163; 
 Tue, 25 Nov 2025 03:05:24 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf1df392sm248138045e9.1.2025.11.25.03.05.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Nov 2025 03:05:23 -0800 (PST)
Message-ID: <09ba6882-37ac-425d-ab30-3c351b1fe864@linaro.org>
Date: Tue, 25 Nov 2025 12:05:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.0 06/12] target/sparc: Use little-endian variant of
 cpu_ld/st_data*()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <20251125105434.92355-1-philmd@linaro.org>
 <20251125105434.92355-7-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251125105434.92355-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 25/11/25 11:54, Philippe Mathieu-Daudé wrote:
> We only build the SPARC targets using little endianness order,
> therefore the cpu_ld/st_data*() definitions expand to the little
> endian declarations. Use the explicit little-endian variants.

Wrong endianness in patch description, code change correct.

> Mechanical change running:
> 
>    $ tgt=sparc; \
>      end=be; \
>      for op in data mmuidx_ra; do \
>        for ac in uw sw l q; do \
>          sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
>                    $(git grep -l cpu_ target/${tgt}/); \
>        done;
>        for ac in w l q; do \
>          sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
>                    $(git grep -l cpu_ target/${tgt}/); \
>        done;
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/sparc/ldst_helper.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
> index 2c63eb9e036..bd0257d313a 100644
> --- a/target/sparc/ldst_helper.c
> +++ b/target/sparc/ldst_helper.c
> @@ -1228,13 +1228,13 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
>               ret = cpu_ldub_data(env, addr);
>               break;
>           case 2:
> -            ret = cpu_lduw_data(env, addr);
> +            ret = cpu_lduw_be_data(env, addr);
>               break;
>           case 4:
> -            ret = cpu_ldl_data(env, addr);
> +            ret = cpu_ldl_be_data(env, addr);
>               break;
>           case 8:
> -            ret = cpu_ldq_data(env, addr);
> +            ret = cpu_ldq_be_data(env, addr);
>               break;
>           default:
>               g_assert_not_reached();


