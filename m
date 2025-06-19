Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E69AC7115D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 21:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSMei-0004Ri-2M; Thu, 19 Jun 2025 17:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSMea-0004PH-Eg
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 17:18:36 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSMeY-000150-QH
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 17:18:36 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a589d99963so1213422f8f.1
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 14:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750367912; x=1750972712; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xJApBPtmtRS7y1RSET1/MQvgQfsp6CfckDvWTToLESk=;
 b=MroB5QJHyZf1SjP1PieDSbCnCQOh8+sJGCcEkZ5U2fxdeNHOKfd4I/Yfxj2dtOziI/
 u89UDYCuTGdLQLPr8Dh3lvtHKW3CoZ/3vaqU56a0Kt1vxlwQnWnw+FEDjU0PNlJPsVVH
 VufwtM1kiAKIO3wVODG1/10Ym4dmuGr9DujxQhYlpc33H2rKyF3Nv6x8qX1GnQEAjJ9w
 TRXVPVR1h/oMpbC+/c2HUzXj1Jznag6alovZf948M/wBjFwx8QisKi4lPQCuZweTGE1F
 RjqLjNyYOByBKEdIxxY9VOV5j1QhXcLAGpxPc7CV7650NtHSlIW17d8p0d2MJiJKudiJ
 HhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750367912; x=1750972712;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xJApBPtmtRS7y1RSET1/MQvgQfsp6CfckDvWTToLESk=;
 b=OYICjHpo1hK9YHBegl0VutulqJ+TYt+wBPKWeZBvDATFR8AqTWWuLAS0cvP7CJDOpz
 LavdbdY/XGJg+foMSzawftUAkPBRKaqtyNuPlZvqMRCZmQ/EySWqr4ZLEhe1zLOuwM6c
 q6/8H0ufllHCcytmIEhHVUaPYWpM2TX645m/vbHus6LjJvyn6Crb+I23xNaZVwi/hRXK
 JHqE/u8zC488LbeZ4vsSVKthQnpT7nSQ/XFm+ZAYWidcT9L5rRydVgHUB/s8t/KyG0av
 BVrdgz5Gp6XXuKZFmZ0Z4UB+WUOx42eVR+bEnLpWaZ+Yfewzi74/izBOAPcFsM6ZECfl
 owvA==
X-Gm-Message-State: AOJu0YxpCsMX2PtddXfseOsZgIxIA5z4CH6G4D+904Kgl8dzcjLcCtm/
 TcjWLXEEkTLXfYuhUIZ2NRtFtOELrYyg2CKnojZrBCZst7KAlhucIUjrFGNI8/0Csim3tDv/veU
 /njGAJk0=
X-Gm-Gg: ASbGncvH1Naw8yHo/UBm+AimgnGVFT6eD6q1Jmml3Qngws314d8vCY4yX4my1Eu8zfg
 4E/IsBsXiAFRWbrl/AFk7nfQMfFf5mEmIxVJRsaqTC0vur8AIOHhwT4Vdpk6uiLDwuP0KYuWhwL
 Kp64zc6KYLAsXvVfZGxU4kJAZKqrbW6DRCAnsfIB8huLL69GVoZdXCNqoDXqAhKD2DIqylUnAmI
 raO6n2Qwdh0euaCbvXsA3A2kZdgK9KpeDxs/5jG1PqmDe/nzIrMsJad/GdAi7N+6Mzbp4O8NDlU
 9fDkjMTMMfFSKUGIC7/KfrbAhP/HB4KRcBvC8a70PzJyOo+Vvlvxf3akaJCRE6jtpcDL1Kt6aOg
 ioJtVL7s3wZjG+EsTTKRYtHTfQVy3rQ==
X-Google-Smtp-Source: AGHT+IHgjW754Ix3/O/6V9bL66G7hqdE8u5RD4c3rIRemB3+kpmqlA3k9iNLm107VjOdv1rcvj3n7A==
X-Received: by 2002:a05:6000:4a01:b0:3a5:2599:4183 with SMTP id
 ffacd0b85a97d-3a6d12b0e97mr365219f8f.25.1750367912501; 
 Thu, 19 Jun 2025 14:18:32 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535969dc4bsm30313095e9.0.2025.06.19.14.18.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Jun 2025 14:18:31 -0700 (PDT)
Message-ID: <a1bf2f2d-f7c7-4922-971f-c4e7b1f5cf84@linaro.org>
Date: Thu, 19 Jun 2025 23:18:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/20] target/arm: Restrict system register properties to
 system binary
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Julian Armistead <julian.armistead@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>
References: <20250619131319.47301-1-philmd@linaro.org>
 <20250619131319.47301-11-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250619131319.47301-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 19/6/25 15:13, Philippe Mathieu-Daudé wrote:
> Do not expose system-specific properties on user-mode binaries.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/cpu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index eb0639de719..c99981d88f8 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1500,6 +1500,7 @@ static void arm_cpu_initfn(Object *obj)
>    * 0 means "unset, use the default value". That default might vary depending
>    * on the CPU type, and is set in the realize fn.
>    */
> +#ifndef CONFIG_USER_ONLY
>   static const Property arm_cpu_gt_cntfrq_property =
>               DEFINE_PROP_UINT64("cntfrq", ARMCPU, gt_cntfrq_hz, 0);
>   
> @@ -1509,7 +1510,6 @@ static const Property arm_cpu_reset_cbar_property =
>   static const Property arm_cpu_reset_hivecs_property =
>               DEFINE_PROP_BOOL("reset-hivecs", ARMCPU, reset_hivecs, false);
>   
> -#ifndef CONFIG_USER_ONLY
>   static const Property arm_cpu_has_el2_property =
>               DEFINE_PROP_BOOL("has_el2", ARMCPU, has_el2, true);
>   
> @@ -1532,6 +1532,7 @@ static const Property arm_cpu_has_neon_property =
>   static const Property arm_cpu_has_dsp_property =
>               DEFINE_PROP_BOOL("dsp", ARMCPU, has_dsp, true);
>   
> +#ifndef CONFIG_USER_ONLY
>   static const Property arm_cpu_has_mpu_property =
>               DEFINE_PROP_BOOL("has-mpu", ARMCPU, has_mpu, true);
>   
> @@ -1544,6 +1545,7 @@ static const Property arm_cpu_pmsav7_dregion_property =
>               DEFINE_PROP_UNSIGNED_NODEFAULT("pmsav7-dregion", ARMCPU,
>                                              pmsav7_dregion,
>                                              qdev_prop_uint32, uint32_t);
> +#endif

Sorry, this patch is incomplete...


