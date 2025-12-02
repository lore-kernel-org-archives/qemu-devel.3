Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5788CFD2F6
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Dec 2025 14:29:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQRNd-0000vy-0p; Tue, 02 Dec 2025 09:29:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vQRNb-0000vl-TJ
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 09:29:23 -0500
Received: from mail-vs1-xe2b.google.com ([2607:f8b0:4864:20::e2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1vQRNa-0006Yk-Fd
 for qemu-devel@nongnu.org; Tue, 02 Dec 2025 09:29:23 -0500
Received: by mail-vs1-xe2b.google.com with SMTP id
 ada2fe7eead31-5dfaceec8deso3730910137.0
 for <qemu-devel@nongnu.org>; Tue, 02 Dec 2025 06:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764685761; x=1765290561; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MjuiNFOaYH0A7R4M6QDCL0duwveLtiW1HhVPqyv8veQ=;
 b=fQt6hw/f8gJ9+oIvqgh8FFk6zqJqgF4AVprOQPjUrEpplHbwiU5p3t+OZ8QMLc5UrA
 NAsMhTrLScx9cRbVOQPmZKwFotClaBTIBP1RuYrtfqZoYtOdxOy13a7DFuu+1NAxsS9L
 zB53tmdNcTziDood4IB5X1n5YGe+tlgyGYtnrXyA3LGnjZ8TPQ3czLhsrC9LpZ4q6N4z
 zxYjerYnyRzcwAvNP/6gFY9ruYI7W2VqhzUr4fQ8R1dGRS2lqVVFH8WJrwWR1vE52GCx
 BLnLqjYJGzthRe1I17zqMQme+RqWwILLsZtQxLR0oXSyX+2BFHNqebzQZnO24M/UEBEX
 Ry3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764685761; x=1765290561;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MjuiNFOaYH0A7R4M6QDCL0duwveLtiW1HhVPqyv8veQ=;
 b=Ln+T6MPsvmSp7eVlIRmaGvSWfFUVnVLj1Sv/Vktzo+iP1KpheBOu8LKFgSWnpq9d3q
 QlqZP0IbIxVM+atPG9wLZiDCZgWPXq1O1cYbKe3xt1RHN/sc41TD8gLft1P7wOlaPmc9
 eRZ0D+yr5HRRUVuHzAhzHwCBzcFQL1VtJhrntbseJmVWZpFXtRdceK1jM6sehnX1XAvw
 +nVSYg+urz0sqclJR0qiRoVo6qzILeqI9vaJj/LteZ7chK6iPhB2z28aLWn8KdSYdam0
 hiQsfJDTYKK9RjXKxRSs6Y7nKqDxP3/HK+bvvx7hnPRrZf86pPRtxffvxuxbSJTrrseL
 MUvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkuBr4bV99bsAtOG/fCn/1m86onOZE0hXTohp6tqt58tDZJQLtTU3rxusXSYpHRJyjTQI7cALV+GaW@nongnu.org
X-Gm-Message-State: AOJu0Ywf87gh5BF0v2lU+lF7smrcQm0Y1RwHEpPTrZJ/6gOpSiGsPtnm
 VJBS1RZlqvpkLpLFD8USm8ZUmNwh8wmZrhmiV8PgdjIlmEpAuSkLgEgu+g6m0D14/kE=
X-Gm-Gg: ASbGnct+Su3YW2cAp7AIv8wwVnw39M7VqXOGr+QyjLG1rFoRhPOfxxM+KuQmloNaTYl
 PNlpz15FX9d/7o1gxMV/B4pwB9FKecydIJJqU5j9+dseWtFUa9egiNnfQpEQ6OZBX31Mxi8K4Vu
 Dj5WIg/phrXFKttjVNgZQYd4ncW3ANShyX/MuaofexzJFIEG928He5fOPtFkDrEeLInWIOev8eh
 8sxelQu19He+909yC8UEBhobCLYGGNs0vCsTQwv0xWj0Jj4wZli4F6pjbkbCZgL0RQX3739g40v
 DHP1TnYCQR83e9Zhl5xsACs+9kzZqkpIryig0kH3vf7j4qgtRPrie08HVm7SoeO4jkO2hzjGGcO
 dW2pJuXPTBlP/oMEzHKN+udG8erm14t1wmmYmiO8G7djPj5j4wEvo+uCtxSwzh2Zwe3Z1WbqEfI
 bNsdCkrN6wldlasgxSiHL54Q==
X-Google-Smtp-Source: AGHT+IH2CXcYYdWv8A7rXi22r5c31S8f/IjNC4zFUoafzD9U6SdfylsATUyUayMIr1EJpI5LoGhCWQ==
X-Received: by 2002:a05:6102:370b:b0:5dd:b240:ca8 with SMTP id
 ada2fe7eead31-5e40c750f22mr1233092137.1.1764685761320; 
 Tue, 02 Dec 2025 06:29:21 -0800 (PST)
Received: from [192.168.0.102] ([177.139.2.175])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-5e24d9391f8sm6508592137.5.2025.12.02.06.29.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Dec 2025 06:29:20 -0800 (PST)
Message-ID: <622f85a3-c671-4a83-bf1b-83127a2fb282@linaro.org>
Date: Tue, 2 Dec 2025 11:29:18 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 3/4] target/arm/tcg/cpu64.c: Enable ASID2 for cpu_max
To: Jim MacArthur <jim.macarthur@linaro.org>, qemu-devel@nongnu.org
References: <20251202120250.763150-1-jim.macarthur@linaro.org>
 <20251202120250.763150-4-jim.macarthur@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20251202120250.763150-4-jim.macarthur@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vs1-xe2b.google.com
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

Hi Jim,

On 12/2/25 09:00, Jim MacArthur wrote:
> docs/system/arm/emulation.rst: Add ASID2
> 
> Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
> ---
>   docs/system/arm/emulation.rst | 1 +
>   target/arm/tcg/cpu64.c        | 4 ++++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
> index 31a5878a8f..3f30ea5a30 100644
> --- a/docs/system/arm/emulation.rst
> +++ b/docs/system/arm/emulation.rst
> @@ -24,6 +24,7 @@ the following architecture extensions:
>   - FEAT_AIE (Memory Attribute Index Enhancement)
>   - FEAT_Armv9_Crypto (Armv9 Cryptographic Extension)
>   - FEAT_ASID16 (16 bit ASID)
> +- FEAT_ASID2 (Concurrent use of two ASIDs)
>   - FEAT_ATS1A (Address Translation operations that ignore stage 1 permissions)
>   - FEAT_BBM at level 2 (Translation table break-before-make levels)
>   - FEAT_BF16 (AArch64 BFloat16 instructions)
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index 6871956382..ef4c0c8d73 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -1334,6 +1334,10 @@ void aarch64_max_tcg_initfn(Object *obj)
>       t = FIELD_DP64(t, ID_AA64MMFR3, AIE, 1);      /* FEAT_AIE */
>       SET_IDREG(isar, ID_AA64MMFR3, t);
>   
> +    t = GET_IDREG(isar, ID_AA64MMFR4);
> +    t = FIELD_DP64(t, ID_AA64MMFR4, ASID2, 1);    /* FEAT_ASID2 */
> +    SET_IDREG(isar, ID_AA64MMFR4, t);
> +
>       t = GET_IDREG(isar, ID_AA64ZFR0);
>       t = FIELD_DP64(t, ID_AA64ZFR0, SVEVER, 2);    /* FEAT_SVE2p1 */
>       t = FIELD_DP64(t, ID_AA64ZFR0, AES, 2);       /* FEAT_SVE_PMULL128 */

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>

