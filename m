Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7F5EDEC01
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 02:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxc7R-0005Ha-BS; Tue, 03 Mar 2026 21:37:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vxc7P-0005Gz-Pg
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 21:37:47 -0500
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vxc7O-0001qm-Az
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 21:37:47 -0500
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-56739adfa1aso5090482e0c.0
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 18:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772591865; x=1773196665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=29D8BMZi3QBfTzcSh/I9XiMhkXjKjJSVN5akKxcnK2M=;
 b=huIeVh6QdqbZmFlx+lkHhklDcdKjIDdvBRxaIleFibz5QkxVIU75FOW6ytIxPfc7wy
 bdlR704o96Xz59RmgK3/AJ0sObdyDVYt1LDKUdsOoURRX2n5y9Tdu+u5HDm26tr8aa3o
 yQCfI498bt4ZzeDDr7v3adSshh8biW6F1UxEupa+9J7jFzmGXzDhBtjKziBQxyMI1gcH
 N7FvhMs+5vN1B/UbhFHy0pE9KCwMHXqK32THipGJePS6wm2AY6ZqN0l6J9barc7C2KJ5
 Pk2d9CnjMmeXzNfz2Y0XZ/92w8BFO+62tOoqvgJ3IE7mGOL6XyBCdS42BJDSdfS1P0g7
 aXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772591865; x=1773196665;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=29D8BMZi3QBfTzcSh/I9XiMhkXjKjJSVN5akKxcnK2M=;
 b=ASO+SrPwM+eCsGivvZZpz5zt4O2dQEbAK2tLMLAy4Nt6F2uy4h5ovUm5Q6TaGf/89x
 Lq4hbnwnn5Ty5cbTOdqYzXBHhcSLbxqtr1fcpyi7T7D4VGM48TLCV0N9PDWjPU9o6Ijw
 YxzuzdM1nubYZwkRv4DLitgh3WT3GeaW9v2dFf0rUZucSVAYJKKclw85UCdFJMHWM4DN
 lXAb4XJTn5H133WbsqRHtLnoIIPyGcmTzxZFvAweDfB/lwYb6uul52FSrd0+Xno6fEVo
 CSvozCy2lHQt0r9/Yuoqwpq+pC350OaFmpL2U0y6E/9gTDLBCvf8enNbQjrzUhVWUboW
 rO+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb91hheyyWDyjhaR1RlDWcPyNrflSTjh2/rH6PSKLfwoEUfUWPqyjMU4zE1ZH5Dzd1AmhGhwcuDKN/@nongnu.org
X-Gm-Message-State: AOJu0YyaVCzuZ6THfCaCafQ5avLpO8MuJZ2fmNJve03UTbo+AI9YncJ2
 NhRXILYfbgUjVBcuThb3uqwNovWiKmEEQVy0gowngKVZ+lh4KL4MbekdXEMWMZ3HkS4=
X-Gm-Gg: ATEYQzxIUUxND9iG/IM0pwkoEIe1TV978Dn4on9n6F/OYf9Js/yfax4UWFeiyKQ6XgP
 QRVjU+mPWUJc3USYIJ+7DifGZWp6ab2qeMUhiZ2HIjQw8D6oQqShcUAi42zmS4EUECJrxgAj9uA
 MO0S3nTFxP43/S1Bwl9bNGHOSQj5a8X0UmczgtyrMT45iHfC3rADmnJEO8E5zsXjY26rSHp69sa
 XSZMGO7Ksd14Bfo3UPsdF9uKsWaCuX6ccEN/i5zHS56uS9hrAuleAdA3S4DYwrG6b7JAEG/Xrme
 S+BJSi0NBxCuLd5Z4Ey27EZUJKxyLit5xZg1kgVCjohYcPyGcgI3C3TqrQQxYz0SU6xYA7PfzQQ
 5mokqklerUJpLaWywVxXScJVMz+Jg/Vf/1dI/Y7Uv/0JcnV8wvLmx93l6skdMODHpA72Ditbzuk
 BOwUsW4RbkkBF5ZJ46TZqm+Lby4wRyvjfs
X-Received: by 2002:a05:6102:160c:b0:5fd:fff8:5c36 with SMTP id
 ada2fe7eead31-5ffab23e51dmr272647137.39.1772591864920; 
 Tue, 03 Mar 2026 18:37:44 -0800 (PST)
Received: from [192.168.0.103] ([191.8.216.93])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-5ff1e7aeb8dsm19002412137.2.2026.03.03.18.37.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Mar 2026 18:37:44 -0800 (PST)
Message-ID: <e68f1a6b-1f20-4040-a1fe-2631c57b5334@linaro.org>
Date: Tue, 3 Mar 2026 23:37:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 1/8] target/arm/tcg: increase cache level for cpu=max
To: Alireza Sanaee <alireza.sanaee@huawei.com>, mst@redhat.com,
 qemu-devel@nongnu.org
Cc: anisinha@redhat.com, armbru@redhat.com, berrange@redhat.com,
 dapeng1.mi@linux.intel.com, eric.auger@redhat.com, farman@linux.ibm.com,
 imammedo@redhat.com, jiangkunkun@huawei.com, jonathan.cameron@huawei.com,
 linuxarm@huawei.com, maobibo@loongson.cn, mtosatti@redhat.com,
 peter.maydell@linaro.org, philmd@linaro.org, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, shannon.zhaosl@gmail.com, zhao1.liu@intel.com
References: <20260220141128.789-1-alireza.sanaee@huawei.com>
 <20260220141128.789-2-alireza.sanaee@huawei.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20260220141128.789-2-alireza.sanaee@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vk1-xa30.google.com
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

Hi,

On 2/20/26 11:11, Alireza Sanaee wrote:
> This patch addresses cache description in the `aarch64_max_tcg_initfn`
> function for cpu=max. It introduces three levels of caches and modifies
> the cache description registers accordingly.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>   target/arm/tcg/cpu64.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index fa80e48d2b..6a79ca9d43 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -1167,6 +1167,16 @@ void aarch64_max_tcg_initfn(Object *obj)
>       uint64_t t;
>       uint32_t u;
>   
> +    SET_IDREG(isar, CLIDR, 0x8200123);
> +    /* 64KB L1 dcache */
> +    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7);
> +    /* 64KB L1 icache */
> +    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2);
> +    /* 1MB L2 unified cache */
> +    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 1 * MiB, 7);
> +    /* 2MB L3 unified cache */
> +    cpu->ccsidr[4] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 2 * MiB, 7);
> +
>       /*
>        * Unset ARM_FEATURE_BACKCOMPAT_CNTFRQ, which we would otherwise default
>        * to because we started with aarch64_a57_initfn(). A 'max' CPU might

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

