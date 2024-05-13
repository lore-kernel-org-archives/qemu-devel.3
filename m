Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98BBC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 13:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6W3M-0004FD-7d; Mon, 13 May 2024 09:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6W3J-0004Dl-UM
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:49:18 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6W3E-0001hD-T3
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:49:17 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2e538a264e0so43759901fa.1
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 06:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715608150; x=1716212950; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nFAGnqDaia0/temmN9otflOacY7lZcxjTP2qFEpdqTw=;
 b=AaMO6palV/P12Iu6qPRqiDAaPo2x8ZEJ78cpM7lMbCG/x67HZfOj6WN9XSD8QDZOf9
 kJ86/Ewlg7BmeGeYVs4T/W8/mifCEND8wd7o1sulnyjLSotnUa3mho71pvxLAYr5Q4X0
 sbOmuIns71P4oYH91HNCces/8ksDFAJVt5e1HbxJYnI+DYhI+4kO/Z0PYgJm8Gy7kOeR
 qkUr84MV5tcA9ZcjpGu/HiWxwzuuQYTKM63gVPjH+nPGVdox8vhggVvv6eo7vR9KbNG9
 MdY3RXtnnh9KOTjMClriGS8O8v/oEAMBHe7TLKddFv5w1ow34tY+kvW7b3mUD8KFJZap
 Qm4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715608150; x=1716212950;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nFAGnqDaia0/temmN9otflOacY7lZcxjTP2qFEpdqTw=;
 b=e/IXX5/HS0Y//BkN0ZTXnwckr0k9ceuATyCWeGIeZlEO+nMIvCPOHpRigMfZ1l4WIs
 8FjkVgZmivm6oWWKr8IMjji8PxmHbvWgKDq3RZhIzEP4SWjpHlHC2zJgq7tinSIIsf9d
 nva7Atr9fjjPeNtONa1Cb8DLe+JEBQsG/oxqBwsP3Np9XHnYw6IsNq51RdMrnT4+BBSO
 d3cu1ChJno19HdEgfUs6AN2HUXzutdb5nmehk71DhQ0/BVoRSqcnZuoV/MXC9lRDQIwW
 /NFa51+dSGChuUhH6f8CpbcyvRIuXbsILAdKUHdagSCEClnaYVGaMl7yf0HuO3ZZCYK1
 hOUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFEomLEDjdy6hx4vaoBne/Nrc2nYqtvUoVRNtpgZ6PNrnfqdQ9PBB8z+I7ATP9tfd/YYhfOg4LQm2sJjWvof3JV45FrpQ=
X-Gm-Message-State: AOJu0YzthDJ6WhJd7pVDyUH+/GM63jVhGDIOxhnZPjfa2MLOgKDDCuCx
 s7ARjOmZ2c/XQYsJOdnBqDBcY4mUpZsF4TxTwdaWhrzHIgpHW2Q2YfHneQ/KHZQ=
X-Google-Smtp-Source: AGHT+IF5qn//Oio64Iho6wgD1NxPShbHFr0glnIcXvm3cf/ISFt5LMON0bec4pXTlQUOJeowlzwtiQ==
X-Received: by 2002:a2e:a54c:0:b0:2e2:9416:a63f with SMTP id
 38308e7fff4ca-2e5205ec6bamr100545951fa.53.1715608149591; 
 Mon, 13 May 2024 06:49:09 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5733bed000esm6284585a12.54.2024.05.13.06.49.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 06:49:09 -0700 (PDT)
Message-ID: <e308ecc4-8e52-4ae2-8f69-8504d2200cd1@linaro.org>
Date: Mon, 13 May 2024 15:49:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/nvram: Add BCM2835 OTP device
To: Rayhan Faizel <rayhan.faizel@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
References: <20240510141010.656561-1-rayhan.faizel@gmail.com>
 <20240510141010.656561-2-rayhan.faizel@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240510141010.656561-2-rayhan.faizel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/5/24 16:10, Rayhan Faizel wrote:
> The OTP device registers are currently stubbed. For now, the device
> houses the OTP rows which will be accessed directly by other peripherals.
> 
> Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
> ---
>   hw/nvram/bcm2835_otp.c         | 187 +++++++++++++++++++++++++++++++++
>   hw/nvram/meson.build           |   1 +
>   include/hw/nvram/bcm2835_otp.h |  43 ++++++++
>   3 files changed, 231 insertions(+)
>   create mode 100644 hw/nvram/bcm2835_otp.c
>   create mode 100644 include/hw/nvram/bcm2835_otp.h


> +/* OTP rows are 1-indexed */
> +uint32_t bcm2835_otp_read_row(BCM2835OTPState *s, unsigned int row)
> +{
> +    assert(row <= 66 && row >= 1);
> +
> +    return s->otp_rows[row - 1];
> +}
> +
> +void bcm2835_otp_write_row(BCM2835OTPState *s, unsigned int row,
> +                           uint32_t value)
> +{
> +    assert(row <= 66 && row >= 1);
> +
> +    /* Real OTP rows work as e-fuses */
> +    s->otp_rows[row - 1] |= value;

Maybe name get/set instead of read/write?

> +}


