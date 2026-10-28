Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D78606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 16:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=Uew2ccJn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM68y-0008WG-SC; Wed, 28 Oct 2026 12:04:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM68x-0008V7-E1
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:04:51 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xM68v-0004bt-W6
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 12:04:51 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-845f3fa7f38so531150a34.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 09:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793203488; x=1793808288; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BATZNDQYJoLrMC1fMQI8aRV1vjz5BNw4x6hWVLbWsCU=;
 b=Uew2ccJnKwXSOhQXxVwxWMinXspvldflBGwjWmNjCJzzD9sh8GPF/EwfB55QG11xO0
 DbdSH0NGTkKgq6OqiKYijBSM5yKec5EYUVtcjeim3jCubx450H+I4PfqwFNeVB8mXZwG
 eag0sNdjnqmCoMstZkv6ICyIPmPscUAQ0UvNuBDz2cLlS48vBFI3xTCOFmb7NaTZ4ee+
 mXctNbGleD2NX9/ZVTFiqebeWmjBkm2zZHIeDQtKgD174b+xfSB+fywJqoQrfk8ygyjc
 xPZpjCFptIONzywXApdE4jmWij7lwo3KMCA+zU9y+484MsjJP/OfH5OrRZqZAbj0z/dj
 O6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793203488; x=1793808288;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BATZNDQYJoLrMC1fMQI8aRV1vjz5BNw4x6hWVLbWsCU=;
 b=ydtd1yaScNt/XGV6luawgDgw2mMq3PQ+xj+nsPHwyiXcF/G1x0l0LZrqlAtyHW9lx+
 sTCSkS7u7EIiGp/j+Y8/dOIIaK8NUFOBnaTH3JrapQBzbrIJYZqHPH2+AJy4LD1TJ9G4
 kgmX9zAngbykJz+i5zEges2JNPHRYYdkq82ScVhft7ab7EGHfxJlE76Ji6e6j56KRIUV
 ytb2JuFP9rtNI/A17kjJVZNqLjsnE1zUnXhn1t0dRTm3vCtauMC1/Se2NfX4DdOd7+Tb
 Oi1J/sVI7tV3VtRyWWiQQYDedaApCohb1ex+lfxZJ3TV70IshCZcx0jOewZqkbISgXmI
 Hh9g==
X-Forwarded-Encrypted: i=1;
 AKwUvByaZ+yiVJiRuThZFo3kohUXz+VkDwqdsA8YB2P9fEENJ9AbmuPoKLEZVHxu6vcplxlfRoAhbvQAmheD@nongnu.org
X-Gm-Message-State: AFq9FYIB0vo2Z8WQtjMhcYx7emo739CAYj9e+RCCCyfQNY8skIjpCk4F
 SXaJHcY+BbBjypRO+e2eTHNq2OCybCoIBqa8MX+FtwM4BSwztEvINUd0/vR5lQufy68=
X-Gm-Gg: AYBFou1aJQ/oEn2/C4UFZ/PU7ucexzgMRXENdhjsm49axWUcT73eGHnsIlAWJsH0ajf
 BKajaoWoerSVjaCymqU1NxtzxbY6BO7Cfz4r66lclQUyRo1v6oiLpmv4IJ4VKPgwxLEDA1BxTOg
 TVdJO2V3HC/nQkg0i63N4yPhq/s//ieyFaq7nPbmBOH8YiwfNd2unHm096uzUQPfAZYlFe5jRQ7
 v0X7S6z4YBv6JD3QQncbPsPA67kLqv70ynDR6lF0jorcTFZlY9sv3IjXMtDpYjZzcEatm+VPRNo
 9nRw9iUivzBf64wwTN23+7vNhYuCkkReY/nWkqGaymmLuvnuiI46/uYRtCdrl7EGQiejPVIRBgn
 i/D4zSEwjEFb91H8tz0q3rP1kC7ZEkj0eprTJRXlqDnTlmg6tDVLKSTEPu7kXyRTJlUmZhHYYju
 Gs/9FEFwj6LMR3gH+35gyd7XBhIg8JLBVjOufX7OH1owwVKl8lCQcj7i7NQKfqTelAGtIPwC/36
 SDnbtS0lqUO9vUnjeJ6AiqJ3WI6BUcVp/vU1etyAbj2FfFFHeDej/jKnrx04YRWBaffp73dGgoP
 RPE6d8ySPqCGMCVTWUSavXdelPbAvwcVy9N+R2+YDLYMXocYHfrjqpGpqGtZomLvjdc1C0uOrB0
 G+PVEFxiZThDOyeEuSwFcKS116s3w+KXU
X-Received: by 2002:a05:6830:4393:b0:7fa:5c68:d04d with SMTP id
 46e09a7af769-85ac0ce9632mr2337208a34.23.1793203488372; 
 Wed, 28 Oct 2026 09:04:48 -0700 (PDT)
Received: from ?IPV6:2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6?
 ([2607:fb91:2c2e:8a8c:60fa:827:925e:3bb6])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-85b1fd3170dsm2076793a34.16.2026.10.28.09.04.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2026 09:04:48 -0700 (PDT)
Message-ID: <1a80111a-431c-4ff6-a3ee-74d91065f7b9@linaro.org>
Date: Wed, 28 Oct 2026 11:04:45 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/14] target/mips: Introduce decode tree bindings for
 MIPS16e ASE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20261026162034.32711-1-philmd@oss.qualcomm.com>
 <20261026162034.32711-4-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261026162034.32711-4-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 11:20, Philippe Mathieu-Daudé wrote:
> From: Philippe Mathieu-Daudé<philmd@linaro.org>
> 
> Introduce the MIPS16e decodetree configs for the 16-bit
> and 32-bit instructions.
> 
> EXTEND-prefixed and JAL/JALX instructions are 32-bit, all
> others are 16-bit. Call the matching decoder, loading the
> second halfword only for 32-bit instructions. Unmatched
> opcodes fall back to the legacy decoder.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
> Since v3:
> - Only call the 32-bit decoder for EXTEND-prefixed opcodes,
>    loading the second halfword only then (rth)
> - Treat JAL/JALX as 32-bit instructions
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

