Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32409FD45F8
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 21:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvMop-0007e9-Fd; Wed, 25 Feb 2026 16:53:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvMoj-0007VX-Hs
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 16:53:16 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvMoc-0006Cb-Bm
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 16:53:07 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2ad9f316d68so563605ad.2
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 13:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772056383; x=1772661183; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZeUXuLzaGvZfQwoS21E0YChtoJgW13dnJa2R/OKYCsE=;
 b=S1+arvm1IC6BO6h7w+j4hdZjw7DO4rkMaIUlmm+HnIiRFmhqGRSul9uNVsngzbkJT6
 Rx6JaXXoFbUwzw8lEpMQK4rWHP2vyhKvbY3Y3cYSSR6F2HtoBbfhSVJ5yWgbf9ARtfx1
 dKL6KaxlSRWvwGtXOOnPwE4kYlOXspPfond5GPtcZAe69K1dp3oyZ260tkghF/ALjLar
 D786/e96qZs0EiWgrhWEDQdRaMv9hK3YDE4NejgJeN2mUP3ATMDSsaromvGMrnaKhRJP
 eVbNOGagA2lDMTiV33CQ3g+nhku64afutU4nqWipiHDxxB4OgXnR15bcUffcx75qGskC
 DOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772056383; x=1772661183;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZeUXuLzaGvZfQwoS21E0YChtoJgW13dnJa2R/OKYCsE=;
 b=QG1AZhPMO2PCSHXgZEkkbdxHlXMGWlYVUuMzvLI2lJFlEAuZAUdXhcyn2UyizBYndx
 nKYMfFnjvMOXaKMBtSbqSTvzg0aPml5jGRv+AJj0sZJUfF103LKT4PCxDQXGLaLbMgcN
 dcn2QW2Y9Bs4CT2Kx9/dUFCxEF5lKs3b3yc+3TCkC8MSwOXxMEqjxvdhs5HP3dN7NkZu
 sCvzHOAPIugdWPI7yWjEyNBxNwQr0BbG6yHcrV3lib15DHhW2Fz8k6Wu1uReb4jDj2qo
 69a3Xn1ApcqFmjKugIzPoSIvtqALe5bmMb3H8IKEMjMmGYOcWkFXRRavZc6iG5G3GQ/T
 Aqzw==
X-Gm-Message-State: AOJu0YzytTJvJuD+qsC+GQLXqwIi/Bx71zcEPdc7biRyMmkNy+RxOJpC
 Gse18a9wUVSuMGIeaXOfbPVT2atCjiHYyhec3Ij0KGIWWhEPYQZ/P58deM9C5bKZbrA=
X-Gm-Gg: ATEYQzwEt0r96Vvp2yqPw2gQPgmkAoHNEnrz2txQLrXJVcg8nT3ng4i/6biJTDX0E6E
 Z5SXw6mcO0GPLGGm5GTroDPTg4qF/IkTd1hOowjrWdF6Y5W17CnHf9MxOs8RCyRt5FVPD+hVs3w
 lPxEJRQKCi5Y7yxsOYuqGTqvMu/mm/3ry7QH/cpdrzCV2iOdFt7OTdeAoFpTZ9Tx4lIsQpnSKHF
 htyAgXQ2Fdo0nrFYxQMAbChvIC2F6AKYGQclKlhQ7jvK1Qxmc9f+kvHOv+4/WcXNlkMdgAP2YUu
 reQVisdvV7W1i7Nek90Ri1A1rooB3/DU9f69qXIadQWhv/Z/t5SI8dXRs7UVeE4wOkuIu1DkT74
 7aHbmGGXPIzw8f8jS8DS71iBFGRPKvbOk9SgQlWd7wfRj/sQX2Koq/rZJpKwWZZX9AbRmBYKWUY
 Nb58iB/pkGc3lyoBU0r21bJWtgNNfdftOxovfmUnLEuFxyHz39O4i6m3R8f3xUECK3VBkI
X-Received: by 2002:a17:903:94e:b0:2ad:9edf:7fe9 with SMTP id
 d9443c01a7336-2ad9edf8200mr65576065ad.27.1772056383469; 
 Wed, 25 Feb 2026 13:53:03 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb6e261dsm1882215ad.83.2026.02.25.13.53.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 13:53:03 -0800 (PST)
Message-ID: <93861789-8a94-4c39-815f-ef983e769a83@linaro.org>
Date: Wed, 25 Feb 2026 13:53:02 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 22/31] hw/arm/smmuv3: Add access checks for STRTAB_BASE
 and CR2 registers
Content-Language: en-US
To: Tao Tang <tangtao1634@phytium.com.cn>, Eric Auger
 <eric.auger@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Chen Baozi <chenbaozi@phytium.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mostafa Saleh <smostafa@google.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260221100250.2976287-1-tangtao1634@phytium.com.cn>
 <20260221101816.2996053-1-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260221101816.2996053-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

On 2/21/26 2:18 AM, Tao Tang wrote:
> Add access control for SMMU_STRTAB_BASE and SMMU_CR2 registers to
> ensure they can only be modified when the SMMU is disabled.
> 
> This implements:
> - smmuv3_smmu_disabled_stable(): Check whether the SMMU is in a stable
>     disabled state (CR0.SMMUEN == 0 and CR0ACK.SMMUEN == 0);
> - smmu_strtab_base_writable(): returns true only when IDR1.TABLES_PRESET==0
>     and SMMU is completely disabled.
> 
> Additionally, mask reserved bits on writes to SMMU_STRTAB_BASE using
> SMMU_STRTAB_BASE_RESERVED.
> 
> Fixes: fae4be38b35d ("hw/arm/smmuv3: Implement MMIO write operations")
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>   hw/arm/smmuv3.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 67 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

