Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C75FD45F8
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 22:13:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvN8E-00055X-PM; Wed, 25 Feb 2026 17:13:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvN8B-00054q-D2
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 17:13:20 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vvN89-0001bQ-Qp
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 17:13:19 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2adc1d9ec56so944945ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 14:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772057596; x=1772662396; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fG3ZMck3tutu8gzYB6jA5+sgxse1QWQnySAlejIbIh4=;
 b=vB+1b8dzpWkweLLD96tbhGqLZ7JOqiVokdZxiAfX5OOeVDbXaAF0NbSMiRAHOjb6fO
 Q01/8Ok9dqwoUHuU6LAVPH2WD9SvmsN2hrNPx7Nl8ErDJKhcPTDKVpq2oT/IRXZeJg6h
 /d/Y57lhe5kKq1qp83z9U7qqZIy00Mzt+doJyvBDAR1pGD3xHXmfh5Jgxy2hbBNnDEro
 Q5G2LiMcBrfU77zJPq9HKm2momEpQKXaVFtVnaKFG/ZgX4kHGSV5qcf/FyvyxGzP8R00
 ErHacSEgpqb5dF1Tja1chlLnD0qUoI0tnDMpz2pi0avgF7HnFX835P/sfNMUTR7fikII
 fmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772057596; x=1772662396;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fG3ZMck3tutu8gzYB6jA5+sgxse1QWQnySAlejIbIh4=;
 b=pQyBFZqm4Z1SdiAz3u9GQnlC63h51z86AU71l1hpaNV4/v2pCOCgQergdkcFfEygwj
 s/BxCJCQk+f44+x5HpEkTj9YeJeJCrD0EmfsA9VsirXSkKJ+jK4Fx0qHCwuGzowu/NxU
 ujfDKRT9YS3bS175MpmpPdHnmzI+DYXx8lRf2ZaHWj6jfP70kHJbI/9BXBgRihX9VM8X
 mSoujPzOtlfeQ6pfVJY7UU2hauNmo4TRdbXiQN9PxEcVT58heunyBAtKyaUakdydIcNb
 8tjflAycPXrfGVmkxNMdIFYkYtTlNOm/KUlrSN3dD3cWF+xmFraD2FvvVVp7T+Po+n0c
 04Bg==
X-Gm-Message-State: AOJu0Ywl1Y23A8gJaBq8lKIHMmd5H9rWbgcUFq1rE0iCEzhniLxWQjGn
 wR6mQiPq3n5WNqzZj7cwtCPckGwNsXI/oa9k78IFA82iwNXn/OgRqhKwKf8B0bGS4L4=
X-Gm-Gg: ATEYQzyEJi7WTeVBWz/T5fmSM9TZnqaeUaf5owiaVdprwtlMkK6Njdk4BlqlVO/VwkY
 CzHnT9c05Lv4xRVsnpXOCl2wPpLwpdVQSPp+wl1NzYz7DoIM1Tz5Cpyt8FMeuLfOcomdvZxBOEA
 Os0Q+vRd8lRApDjw3gi3JCavniYzR0PgB/DcGSmmyrZeL/EYTNGVPV9LWD7mB7c4OpZP50DqELG
 tBji4i8X4hPM5/Np40CjQE1y/qwPQDbkpkM0Qe6pBIrsEzZboSUsdFHWwmDnH/GEuKawcUQcFWW
 L5G3bNBza1Q8Gsw018C2fn/Lf72mrFRATmepjtdjRS+D2/vqbS0hkTyEFZnCaNZ0GCoSEP9Alqy
 g8lY8HrIY8uLgjW2+dU7gTPvFQ1ZaXuHR5b5YC9K4u7x3EdccmS8k3ldXvA++unik5Mg6FP9U+C
 WrBWbTh+0MZ8wapPZaajL2mfOB1AyGKdl5EhwKfliDVPWkmzI9+VKWFapimAOB2cp5MXhp
X-Received: by 2002:a17:902:ce84:b0:2ad:ba04:40d2 with SMTP id
 d9443c01a7336-2adba0442b6mr53343615ad.25.1772057596324; 
 Wed, 25 Feb 2026 14:13:16 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2adfb5b22d4sm2489765ad.14.2026.02.25.14.13.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 14:13:15 -0800 (PST)
Message-ID: <9c0d7a06-dce3-4b79-8ab9-4c255f60f4b7@linaro.org>
Date: Wed, 25 Feb 2026 14:13:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 29/31] hw/arm/smmuv3: Initialize the secure register bank
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
 <20260221101918.2997679-1-tangtao1634@phytium.com.cn>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260221101918.2997679-1-tangtao1634@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 2/21/26 2:19 AM, Tao Tang wrote:
> Initialize the secure register bank (SMMU_SEC_SID_S) with sane default
> values during the SMMU's reset sequence.
> 
> This change ensures that key fields, such as the secure ID registers,
> GBPA reset value, and queue entry sizes, are set to a known-good state.
> The SECURE_IMPL attribute of the S_IDR1 register will be introduced
> later via device properties.
> 
> This is a necessary step to prevent undefined behavior when secure SMMU
> features are subsequently enabled and used by software.
> 
> Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>   hw/arm/smmuv3.c | 27 ++++++++++++++++++++++++++-
>   1 file changed, 26 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

