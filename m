Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C7D4CA5FB5
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 17:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viF5Q-0000oz-9O; Tue, 20 Jan 2026 12:00:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viF5E-0000ex-BQ
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 12:00:00 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viF5C-000787-JT
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 11:59:59 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47ee937ecf2so275665e9.0
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 08:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768928397; x=1769533197; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LmCUs282K4/tylcg9QZD7xuR1Rh/5OFRlrbEouPAO4w=;
 b=qU1ZXc3De0YYhLmx3UNEl3UpQAK3R93Y3Zt7sQETkluD+dMm3fqMkOrizos8ocTjqT
 fYbvrxIrMdZBOhN//lyCud+8KauFVIfrUD1Ak2Sk7m9SmSbMX7a4tJWloqWNT331RchF
 bry1sWRLhEGaBi2QUi3qOj4Ga3NA5YS2/Rjh9fx6dSgzsFan0DGkhYcBrX2Ks9uU2guM
 KBWnQ/ahsmQsxYQiUWJcb5iSWyKgqAQmeu0qkx4Ii0qiltDw9ov4Ed3nnB3h09dmy47W
 zOD3x6xTz/Voy2aG2eVHPCRwxqWdhPCLt7zSvSzDdEdo0sLCtwgM+mEDpx0HxBUgM7J5
 F/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768928397; x=1769533197;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LmCUs282K4/tylcg9QZD7xuR1Rh/5OFRlrbEouPAO4w=;
 b=qc/A8vtm1zYd9vYdzh8MbY2aeYF4xUUdGwXO1z+FqLyccxiaspG+g1PlUYE7tip9xK
 dTf/RcHsh++Wjlt0hJB5cX38fNR2nhsTdbo27toEOJltmllPt7hS2AgaAjoFNA1gwgwa
 6ZFNrFS0F9J5MM0cDdggWxnM+vXfJa+6SAq2ebnwSng110lSv0CKVyu423E5DCVAu0DI
 K3TlcsKlV03OVWMZ5GSExug5WWNYYNFu/OFx2tQ+vf9qkd3CrYhJ9z/Y6FWvmMbPlD1t
 8dMoUjMACrKMHyxzaOSIHCFPrVtvd2D5BHVenrfjfCW++uYVz+wUEQvOOTRNnyhfasfu
 ydgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkT8gEOa7A/HQgpYextyZyzLMlVlCZDHQox41F6rP3+33cJ1yGsSogwwafqVECziXfnkZR6sBxvCyX@nongnu.org
X-Gm-Message-State: AOJu0YyDhs9pOWrHILgklDFHltzJS+RXTkWqqVG1Q5rSVTUYgr0MwtDf
 svrsXT+HufZU+3P8U6EP0q46gLaR4UqMXMsLWB6sv7Np8ODKhA+n6Cf7MaEksRsCueQ=
X-Gm-Gg: AY/fxX7w/YlX7xAJCcSHvlQ3n6hd/FLiaeHP9zjpRTFNmPD1UHcDv52irei72tMAUyG
 P/OyZPixJhZ3swZTasQh230OkKRXvDbsMYiXTiY0RONmg7IInXNZAT0BrO6sPzo7vc5pB6gtRDp
 W1QwbWHxB9HpLjiWjRZXhV6dOrpZwBWXlh+ULp52oO9SeEcTnvaslSsxG8HvUrICPaNIHJrZ+XK
 lqIO6UmNP5+AVX0IZRMjrZm8Up/+2TOIDT52/jpv6/Rl3rvgg5xzIIq/s0qiX7kyRT+woNJzvlw
 l6jx/jpEOIeVagnWRut+8WfEKz9Paib1jfUMSIsmTH906AC+c+egnz9QqVRLMxwNXGOmU2kvc/V
 Sv3yYcX1qIuuIj1J6pNgEd+brZgWMDpgVCU9jBhyleRYwPJotWiZO8RWGY2nMR169Co+b8TM1fQ
 ryMMPJZeW3tL71NYrDGBCBXNXOrGGdNec52QlHmTO4wfkqKVTPbNghrA==
X-Received: by 2002:a05:600c:8208:b0:47e:e981:78b4 with SMTP id
 5b1f17b1804b1-4801e67b738mr194331985e9.12.1768928396810; 
 Tue, 20 Jan 2026 08:59:56 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e86c00esm252289045e9.2.2026.01.20.08.59.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 08:59:56 -0800 (PST)
Message-ID: <ae4c2553-c82e-4ba5-a79d-535e02b39e44@linaro.org>
Date: Tue, 20 Jan 2026 17:59:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] Freescale SDHCI Fixes
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>, Bin Meng <bmeng.cn@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org
References: <20260112145418.220506-1-shentey@gmail.com>
 <4add79fa-6cee-4795-96e9-033ae98c472e@linaro.org>
 <3F4EA15D-0769-4FF6-BC25-B1052EA69032@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <3F4EA15D-0769-4FF6-BC25-B1052EA69032@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 18/1/26 23:56, Bernhard Beschow wrote:
> 
> 
> Am 18. Januar 2026 18:23:11 UTC schrieb "Philippe Mathieu-Daudé" <philmd@linaro.org>:
>>> Bernhard Beschow (14):
>>>     hw/sd/sdhci: Fix TYPE_IMX_USDHC to implement sd-spec-version 3 by
>>>       default
>>>     hw/arm/fsl-imx6: Remove now redundant setting of "sd-spec-version"
>>>       property
>>>     hw/arm/fsl-imx6: Fix naming of SDHCI related constants and attributes
>>>     hw/arm/fsl-imx25: Apply missing reset quirk
>>>     Revert "hw/sd/sdhci: Rename ESDHC_* defines to USDHC_*"
>>>     hw/sd/sdhci: Consolidate eSDHC constants
>>>     hw/sd/sdhci: Rename usdhc_ functions
>>>     hw/sd/sdhci: Add TYPE_FSL_ESDHC_BE
>>>     hw/ppc/e500: Use TYPE_FSL_ESDHC_BE
>>>     hw/arm/fsl-imx25: Extract TYPE_FSL_ESDHC_LE
>>>     hw/sd/sdhci: Remove endianness property
>>>     hw/sd/sdhci: Add uSDHC-specific quirk
>>>     hw/sd/sdhci: Remove vendor property
>>>     hw/sd/trace-events: Remove redundant "SWITCH " command name
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> and queued, thanks!
> 
> Thanks, Phil!
> 
> Could you do me a favor and drop patch "hw/sd/sdhci: Add uSDHC-specific quirk" for now? Although the patch does solve a boot problem I think it needs some more thought. Thanks!

Done.

