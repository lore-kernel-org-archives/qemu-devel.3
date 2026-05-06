Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D51CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 14:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcvo-00044s-C7; Wed, 06 May 2026 10:08:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wKcvb-0003vV-8q
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:08:48 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wKcvY-00029S-TA
 for qemu-devel@nongnu.org; Wed, 06 May 2026 10:08:42 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-479dd56d016so4642166b6e.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 07:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778076518; x=1778681318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yRgtv1ao5cKP94/VthOTktRWZuiIyTfATTBKeWUnkE0=;
 b=tD5lBB/aCtq5Ie9BKwlfNw6dkVu4a1Oimwg07HxIcVgrN6npCv1d+1Bu4te9fdhQA1
 D7qnM9pDCdj7vIk9+I8dQPF2QUBtrCr7pzM1VNd21gJChcy/7fgh9ju4bOCibckqhGnP
 ODlVkiT2lXkkXw0nXf5GdaquEC/HcafpT2ff9bbyxBnRO6vsjrh3sH43GwUOxMaqvvJH
 CFoNdcy3/YCA9wGW2vgg5JeqPOX2XxEM6IHrcM3S9HmzmdE/aA6RB3JHLAhCTcGLELct
 QpfsOyG5GVQZ/lT+Vy6mnbkhAnsC9B/GBaSPy6MAlV2y/Ppt1rAzQBjYAcFGyRi2DcC/
 mA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778076518; x=1778681318;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yRgtv1ao5cKP94/VthOTktRWZuiIyTfATTBKeWUnkE0=;
 b=PR9BFc61Zuxqi1cgNbXS+8727eWV9xGGV6IceZMmByp2ztaiqr0/lJdiMrHT4MTGAe
 Z/+8k/lkpLamTnO23lQ1TQp1RkGxDcEtOUzKaGmOchL48ipPOmAjOjNF/a4UXp/u7MlF
 rccFwovUtJHwkPhFpWMS/8OJtFq5yaCSKVDP5XZRuLxXjy+b6ozbQ5dS9rJcLGDcLiDI
 SckEF4zNc8b8l/aA+pBDSvky2ZkSrsGFCLimdX58giFv29LWlRfhQKGLqncGPOt4MEwN
 9VB2Dti1E4kzbbvE7PScpl37AjowN/u3MaMW/Kztvc8sB+50x1PEZddaB5FsC8MdAThu
 nJxw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9F0gjfTQZuSxiOpiYnKwYqA2gTikMlyg0s235HTGr5CIkX7Qb5gP5cjk2V7FMtseEZLCCWH4VLg0i0@nongnu.org
X-Gm-Message-State: AOJu0YzrcI5W05soKh4J36eDzRkFmzkQ8yYPcBc8+o5/FnMCcWdyxxmo
 6qXnwoMwPGP3QNGqeRY1u5givEHCIClMW3knZnaXHvwGvwun6xsfRPranfKZIjUR0Yw=
X-Gm-Gg: AeBDieu/oF2ptpG9s6cW6Vx0sABYYHIqeSgFED2mErpSY+4rnadN9izOrVjIWlLI0pR
 A125z90mlUw5996JumXMGgmxOSwOphh0845zPuVKbSKsF6jAcGY7rdJsHHjZsIltG0KD6AoSWjA
 9Nrt7HLO/FwFD9gdkhcU4jCut6Y8wF4gq18AdXTxCxBkxzJLgksZ0oFRNJ5aAXBBeC6siFjFUA9
 k/imu0Qicsf0ioJa8PgGJs0xByu+oZB+qScmufSggUwEaH/iYaO5mAKTTJ1PkThYgzG06uZ5EHg
 OtFzdwp4LQDDqqZXd/4sr8A9QE/029zbljzu66KjgcY/uU/Aw0orNxF8IuJZGJsR7eonmbgTIzY
 4pi9F2iCnuarwpL/hJGRkRDhI6aKPG55bt665Y0WjRU4N7bA9cO5EsRyyIjzB9S6yGOOEWHfWv5
 e6gI2ATKY1BVTml8cBHli/PdNKF24IPq8c8PWkysVluWOvDARYqYuAeAEzLecRaEz5b/NBA1fQB
 aTxvooxcJZ2m0w2QEh+j+Wcdscwp98=
X-Received: by 2002:a05:6808:2507:b0:467:2a6e:ada8 with SMTP id
 5614622812f47-4804230908emr1740843b6e.25.1778076518095; 
 Wed, 06 May 2026 07:08:38 -0700 (PDT)
Received: from ?IPV6:2600:381:c938:6375:5307:cd92:1ec8:e891?
 ([2600:381:c938:6375:5307:cd92:1ec8:e891])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c76986f9dsm10735693b6e.16.2026.05.06.07.08.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 07:08:37 -0700 (PDT)
Message-ID: <5357761f-be70-4543-99d5-9fda2303811f@linaro.org>
Date: Wed, 6 May 2026 09:08:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/15] target/arm: fault on tag store to canonical tag
To: Gabriel Brookman <brookmangabriel@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260504-feat-mte4-v5-0-232a648e63c6@gmail.com>
 <20260504-feat-mte4-v5-10-232a648e63c6@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260504-feat-mte4-v5-10-232a648e63c6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

On 5/4/26 10:50, Gabriel Brookman wrote:
> +static void canonical_tag_write_fail(CPUARMState *env,
> +                                     uint64_t dirty_ptr, uintptr_t ra)
> +{
> +    uint64_t syn;
> +
> +    env->exception.vaddress = dirty_ptr;
> +
> +    syn = syn_data_abort_no_iss(arm_current_el(env) != 0, 0, 0, 0, 0, 1, 0);
> +    syn |= BIT_ULL(42); /* TnD is bit 42 */
> +
> +    raise_exception_ra(env, EXCP_DATA_ABORT, syn, exception_target_el(env), ra);
> +    g_assert_not_reached();
> +}
> +

Could be marked G_NORETURN for documentation, though I'd expect the compiler to notice and 
generate the same code either way.  No need for the assert, because raise_exception_ra is 
already marked NORETURN.


> @@ -433,18 +454,23 @@ static inline void do_st2g(CPUARMState *env, uint64_t ptr, uint64_t xt,
>           if (mem1) {
>               tag |= tag << 4;
>               qatomic_set(mem1, tag);
> +        } else if (mtx) {
> +            /* Writing tags to canonically tagged memory region: faults */
> +            canonical_tag_write_fail(env, ptr, ra);
> +            return;
>           }

No need for return after noreturn function, and you're likely to get a static code 
analysis warning for unreachable code.

With that,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

