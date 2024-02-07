Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62C92C4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 08:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXdjB-0001Xg-3I; Wed, 07 Feb 2024 03:56:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXdjA-0001XK-56
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 03:56:20 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXdj8-0004iL-Gx
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 03:56:19 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40fdd65a9bdso2876845e9.2
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 00:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707296177; x=1707900977; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fyhEqDbns1miPBAfn+h3ZKIxGo/tiCvBbdNxTjmFELw=;
 b=sfWq4D16QKVoz4HWk+bUSx/c5EWzZidxfdC/VV59ifV2cuLCKACvDIiBslvIDk/nbc
 8Ai4VYR9t31Cqv2Z5DABTQ+I8RaW8FrBQy7wIJ8niNfwC35psLwxjV8uMTGyk5k9yh86
 M5SygEa2fWaAVvLnzQG+jJwcXxU1L0g8LqgqVoo4pmM62tVlzB2c8MzJMu+YuD4ljCQV
 V0XByjfROHJHdBA7tPopymvBrS8cgXXf8HinEWq5KIYC3d/xJh+14nGNcqAkC5nip6ET
 deGL33SD+LgIvrDxLwidxjMIOAXrEboSYWg0YKCnUxlKlRmsB2z8gv+AeTM2VFe0xSg7
 SxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707296177; x=1707900977;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fyhEqDbns1miPBAfn+h3ZKIxGo/tiCvBbdNxTjmFELw=;
 b=TqaFgpArbSnVGw8NvUkuENlx68Up7CE4Om1AyRuxKwYS77Cq2fV7OhXTrsvp2HqARD
 PUB1zhAwuoATO9iXkrhDKKo1WvGUCX7MTAxdgFlirvdMHp6oaJpkfNM5aGyCw0BIlLLa
 VX9tWp+xrPbY2RTliqeoHkHJgHtvM1X1dv5JdS4JbHkPCa8CLw+c1XzFhenomvv2vOZP
 d+of9bsAMS5l/QXcx8sPmU+UPBcT0IcnTQZHu7fW/WzebRrHIswQnB1mrBa7DrpiZ7bi
 rjKCoXgf4yiS3gtufZqtqLquTnOxkqYOt/U7D3/lPih42q/LrrWydSw5pqfhL614P7R6
 m7pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1SBb1ZUxzY9+u4t/nhtNjDPT7Pg1FpDw9zBG8qSpcctCE9VtJLGju0zS3pFcvMDQBmBKGTdxh53oMdlmSjfpDDUSl2lc=
X-Gm-Message-State: AOJu0YxYWKqG49W95FECyeJWmWImXdgfEwG3NhbENX8x1FL2WAmujiuC
 4cQmzMEcNDOttuWXdPDCeI5+Irw0ol0+4OA7A/P+d1l2ioKSQustZeu8zmm0q1I=
X-Google-Smtp-Source: AGHT+IG7ZjqDsdmQUvxUMvonwVD2+U2Z6e/D53jVdVWkekSDsyeZzFYUJwOWtDAZMa5ZHs6d4lKDRg==
X-Received: by 2002:a05:600c:3b16:b0:40f:b732:1ed7 with SMTP id
 m22-20020a05600c3b1600b0040fb7321ed7mr3969583wms.34.1707296176762; 
 Wed, 07 Feb 2024 00:56:16 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVkz9759xdPzUURy1GfubVYvivzocqNfyrKqpvRnVX8Gq80a0MjR7wsSPf0uBCaNRTpZrJyoNWymCB/q6BGmCB5bbEamEJqtJqSwfky/sNi5QuTK0707u7iLpw=
Received: from [192.168.69.100] ([176.176.170.22])
 by smtp.gmail.com with ESMTPSA id
 u14-20020a05600c19ce00b0040fdf2832desm1338202wmq.12.2024.02.07.00.56.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Feb 2024 00:56:16 -0800 (PST)
Message-ID: <4a99697d-99fb-4df5-a6d2-4ea4e4214437@linaro.org>
Date: Wed, 7 Feb 2024 09:56:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] hw/misc/mps2-scc: Make changes needed for AN536
 FPGA image
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240206132931.38376-1-peter.maydell@linaro.org>
 <20240206132931.38376-8-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240206132931.38376-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/2/24 14:29, Peter Maydell wrote:
> The MPS2 SCC device is broadly the same for all FPGA images, but has
> minor differences in the behaviour of the CFG registers depending on
> the image. In many cases we don't really care about the functionality
> controlled by these registers and a reads-as-written or similar
> behaviour is sufficient for the moment.
> 
> For the AN536 the required behaviour is:
> 
>   * A_CFG0 has CPU reset and halt bits
>      - implement as reads-as-written for the moment
>   * A_CFG1 has flash or ATCM address 0 remap handling
>      - QEMU doesn't model this; implement as reads-as-written
>   * A_CFG2 has QSPI select (like AN524)
>      - implemented (no behaviour, as with AN524)
>   * A_CFG3 is MCC_MSB_ADDR "additional MCC addressing bits"
>      - QEMU doesn't care about these, so use the existing
>        RAZ behaviour for convenience
>   * A_CFG4 is board rev (like all other images)
>      - no change needed
>   * A_CFG5 is ACLK frq in hz (like AN524)
>      - implemented as reads-as-written, as for other boards
>   * A_CFG6 is core 0 vector table base address
>      - implemented as reads-as-written for the moment
>   * A_CFG7 is core 1 vector table base address
>      - implemented as reads-as-written for the moment
> 
> Make the changes necessary for this; leave TODO comments where
> appropriate to indicate where we might want to come back and
> implement things like CPU reset.
> 
> The other aspects of the device specific to this FPGA image (like the
> values of the board ID and similar registers) will be set via the
> device's qdev properties.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/misc/mps2-scc.h |   1 +
>   hw/misc/mps2-scc.c         | 101 +++++++++++++++++++++++++++++++++----
>   2 files changed, 92 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


