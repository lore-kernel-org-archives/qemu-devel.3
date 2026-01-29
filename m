Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D64D61009
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 11:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlQVK-0003oc-Jj; Thu, 29 Jan 2026 06:48:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlQV9-0003lC-IP
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 06:47:57 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vlQV7-0002nR-Hz
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 06:47:55 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-48068ed1eccso8267145e9.2
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 03:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769687272; x=1770292072; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pl+i2s0HO9f0YiD7dfYp+gRanisRF1fEkPjAWJfVLbU=;
 b=pXPa5Ly+EvvFibiAbuIig9aFC0KO8GQPAId5KYUM1xt+jCtwQVDI/g5EcT7Mwq/BcM
 MkKFPEnc0LwdjcHtfxtpGz1EwWf78P29BZq3ckeGCZVWXcuA1HL2OuVOqmhx2ySK4vpI
 nHoTqwhvKUWqIHVjskmhgtxD0AC45b9WPw+Or92khNF93l3EoFkzbeljsidPePOMx1OR
 S2NJ8G4cZsR079c0hM0ESy43QlFZ4X/QagMMnXS7HRQGIygQ+9/l8WV98czry/H3JHQl
 7l/qwPvP7czl6mtDvdJGhKU57+7Qxxa28oTwNJzSfGVgYiif7e6EyZd4wQPm3mymxK4c
 ww0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769687272; x=1770292072;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pl+i2s0HO9f0YiD7dfYp+gRanisRF1fEkPjAWJfVLbU=;
 b=CT0mh+02hcNbHJOU9/m67F7q6qi13aLQ8skzyfKZwnDJglkXhPr+AUxmX0ziLGrwVL
 caKRDWKyi5LWOKtDaS6WEPViSjjn0nSBcaXI39jUcVMg3fhjxTr8ZZ8xRpeBpIjMzSeZ
 35UzbiquIZyr3NtKSut+yE4cKiStwaRQ+crJ//RPV2dEPZAIBiNmqbGtcpNIi8PNw3+3
 0bg3MBNshywvYV0L7zul1SoKjcWynB7+m8wbUYb878GRJH0tZYi6V/vNVyBmdmYLmnFw
 90UiB0qSVXZwqoGNft+mOatJmK8oQLlXpAD6afihBuF3tC1Gpkh5H2eHYpnbHelQF3Ww
 h+xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSJN2BtJt/Xb8fYF4F7Wo/2WrJ82LLKjDffYk1oM3w5rL1xLjrncFDgzr3MLASnpg4sVchljTISS/K@nongnu.org
X-Gm-Message-State: AOJu0YyL7djDUZMngrE3VCujnSTNFPDCr1zwPInol9cpk9dGGxrgRxys
 aYSxB+pq50Sq8+fjZuH4FITY3zBcwGZqTlu1Ysnbp+Q+5uxvYR9XmRZaLOjcjkLC9Gs=
X-Gm-Gg: AZuq6aIEGg9PJNeTHwAVAz+tVEVFUT18PHhqTc4TrO1enJh0kxvcb74f/JlyiJxjNng
 KbxB5dPJTC1ntd1CY0BBKm6kALvnN2TT5mVs8TKAm7Qk4bSl/MfeboqWths6HhfxXVsmPUClD0l
 mlMR5qeIzL+S3IQgL+eNtub83YA7O7c39+suuPvpFUycOyv/hIyBmdZ3AnRx6BD472LlCUhem7q
 fnh3x8xyhmwcWdnl6uO5OH6JW11bkkBJTZLwwgmAR5pA5MjX6//YDlsenBpoIaXOE3kpre7GD8O
 2v7v5OJQ2ku6eCvr4XxjdCxgzQw+7NNMKWlKr8j6zNA1AAB19TiedJzHXT1HBUQOQm9aoHwTiPP
 UjVuWGVIZDjyZ9i8dPTQNYp1d70fJn3hMuiVlETw76IWV1L+AWZwOPqpwiBE3FYbLaVqWj7+nTv
 ifW8VqU2FsBu3nNo3zVkMJztTlVqISYPW4P9K7+FUvYDqDWk1PojejhA==
X-Received: by 2002:a05:600c:3e16:b0:477:755b:5587 with SMTP id
 5b1f17b1804b1-48069c10f78mr95761315e9.8.1769687271752; 
 Thu, 29 Jan 2026 03:47:51 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-481a5d31651sm2188395e9.4.2026.01.29.03.47.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jan 2026 03:47:51 -0800 (PST)
Message-ID: <a4d3bf53-e1f9-4287-b8b1-3c84555bad83@linaro.org>
Date: Thu, 29 Jan 2026 12:47:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] target/arm: Handle SME-without-SVE on change of EL
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260129113455.1283266-1-peter.maydell@linaro.org>
 <20260129113455.1283266-5-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260129113455.1283266-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 29/1/26 12:34, Peter Maydell wrote:
> aarch64_sve_change_el() currently assumes that SME implies
> SVE, and will return without doing anything if SVE is not
> implemented, skipping a possible requirement to change
> the vector register state because the SME vector length
> has changed. Update it to handle SME also.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 732c3a9eba..655ce73ee1 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -10127,8 +10127,8 @@ void aarch64_sve_change_el(CPUARMState *env, int old_el,

Could we rename the method? Maybe aarch64_vq_change_el()?

>       int old_len, new_len;
>       bool old_a64, new_a64, sm;
>   
> -    /* Nothing to do if no SVE.  */
> -    if (!cpu_isar_feature(aa64_sve, cpu)) {
> +    /* Nothing to do if no SVE or SME.  */
> +    if (!cpu_isar_feature(aa64_sve, cpu) && !cpu_isar_feature(aa64_sme, cpu)) {
>           return;
>       }
>   


