Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D2B5C2A062
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 00:57:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcYuL-0005Yo-4a; Sun, 04 Jan 2026 19:57:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYuI-0005Y4-5q
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:57:14 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYuG-0002ds-PL
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:57:13 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a2ea96930cso153603095ad.2
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 16:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767574631; x=1768179431; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lF0mgrzRlqe7PxcOzjeNifU5xFw2bd/v1Cqa7JjAWhY=;
 b=OoaFENOtlXk90Ka1ttQQD+EcGEBQFW0nzyyaoTs6YCKN7xSWHfwf5EdYd5UyJ5EKiz
 2SlxwVGAzUt+hv9n0/ckrI6vbcZCutiTyCtVjjka8N137w/PBbdHfgMpouzlTSBU17dX
 V6duKyhsoSDQpqnZ4Xz0qa1szjx0o8oCRE2oQq1c6eFFIRp63NdZq8nEmj0P3pR/QdgC
 Mjg87suIQzawYZmnJmIozuxNVf8aTbKQ/q/BMgJ4ytlpS4Ag/5+JxyF1eUYS7RaVlSSC
 ovKWeNzzvmCCulgsT4tW5/fWNh6c2zdk6yWcts7J+Yv4IMLVDz1tIib10SH98zeQTUmW
 eCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767574631; x=1768179431;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lF0mgrzRlqe7PxcOzjeNifU5xFw2bd/v1Cqa7JjAWhY=;
 b=YhmES4SK6lHE7wGnh2Rcbg2pk+0ONAOKSppQkg1leWR4pEP9iY88o8V+fLQ2UV7erC
 PnTAj3yR1cXEKUCdqj9ge13TZ4IuTUOacMeUGgaSqLjtmYSxmSa9zEBsnR8uEuRvDFXh
 CFVH+KGUFL5qvLhZSUt7bqEW+ttOjzC3aWBu4zIIRmA49kgqW5IFPjN05m+owlI2cX3+
 kkRd0M5qIW0S3ZbY2y6OPCm+R3/8xyRyH9GCWaskNCO3BuwK43WN2pKwzw+SLFDBuiIW
 cOYgeqyttvSr+YSYzn6Itvy5iFwnW2QvaiZzJE7aQx6Bf0hQ3811tzYF7DvIa0TH3myi
 sbXQ==
X-Gm-Message-State: AOJu0YzYOCkG+Ys3UUTcz1QjoUXsiknpQXUIJdDeoFCVSuJABMTaQbIB
 1ilbH8dTNKgwFU7VNASdy2TiCf+YG1PXP24w6UEnMuyotYM9UV0EyHmWRBVKNxiEX8pWs/abCA1
 2NAeofkU=
X-Gm-Gg: AY/fxX7IxNQ0OV2dbSnymW6KMpTvEKN5HeLm7Y5TIfkUGrEKfrxj3oKZJdpY5Oove7O
 hBvoanGXJAC7C7xHEaS5lb1MOc5X4Q4vwZ3gDT2ZWmhmHT6Bln7iiECuplYlgli3D7J7XDf03Px
 NHVw9ViJ3rZR77YtsfUIOngFKxgJ7XJyxymP0A6YmBcH1DM5q0W9Ygz9441vKmDx+AJIz7wtJya
 JQMk0dqGNBibTnQr+IL5kcdwVntaUXf2vuJZ8cXvxqXo05xKSOeIsZ8GfWuTaSkMOG1DM2+cFGe
 dOE9rP97tIbpEX4yRmsq/ekja6uQxIW2VqRmaV2bxss44TY5JDK8MyFcBhygv5a1nICJ8LN0g3S
 LMWblrqliCcOKlVOYuUUWRUWXuht0OD936zRWl1tdP4FViCBcVRfWkUaOk1pG4VZP3JmcP+bMxM
 yAtTooZBvVqMyAxabzUSYs/ByuLtkmXw==
X-Google-Smtp-Source: AGHT+IEGxTHOFlr2k5dHWGij4abtkciWMKlh35igP63RqA6ea2TwlDbBayJEcUwtpfyGr+1OhPpj/w==
X-Received: by 2002:a17:902:cece:b0:2a0:8df5:2f6f with SMTP id
 d9443c01a7336-2a2f222359cmr441335375ad.15.1767574631265; 
 Sun, 04 Jan 2026 16:57:11 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c82bbesm439653755ad.35.2026.01.04.16.57.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 16:57:10 -0800 (PST)
Message-ID: <a9408884-d4bc-4dbd-8fb0-7a1d665fe228@linaro.org>
Date: Mon, 5 Jan 2026 11:57:07 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] target/rx: Inline translator_lduw() and
 translator_ldl()
To: qemu-devel@nongnu.org
References: <20251224163304.91384-1-philmd@linaro.org>
 <20251224163304.91384-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224163304.91384-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 12/25/25 03:33, Philippe Mathieu-Daudé wrote:
> translator_lduw() and translator_ldl() are defined in
> "exec/translator.h" as:
> 
>    192 static inline uint16_t
>    193 translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
>    194 {
>    195     return translator_lduw_end(env, db, pc, MO_TE);
>    196 }
> 
>    198 static inline uint32_t
>    199 translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
>    200 {
>    201     return translator_ldl_end(env, db, pc, MO_TE);
>    202 }
> 
> Directly use the inlined form, expanding MO_TE -> MO_LE
> since we only build the Renesas RX target as little-endian.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/rx/translate.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Using mo_endian(),

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

