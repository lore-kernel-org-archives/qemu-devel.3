Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843B8C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 08:09:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVo6U-0008OM-Ed; Mon, 22 Jul 2024 04:09:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVo6Q-0008MR-Mz
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 04:09:02 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sVo6O-0002B6-4g
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 04:09:01 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-427b9dcbb09so29702015e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 01:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721635738; x=1722240538; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GuhGhQfW+nG+132ytSxy9RpTW+oDEVjviPWjVECwFhM=;
 b=Z91Wx9YOkS0cg1rWYDyPACw95r+1yYlZkCWKlr5lmK2/hC5jlaDGqe6DZKKXrDw39E
 5SMxagdtHth5T9oB11s0ntzpDi9D9C7xqFDhfvjVdZdYH3OQE/auvRkQquYu2Eq0c7YI
 uc/rkmXZ5GGL34SKOE38dsxa5VrV2bBMbvf1HqstghWdF1R+5VYvcyYTAGy37ijKBLfB
 VRc50gGmNYUs/0XoKO2xVc4dkCCIelaZJ7RLJr++GyUkXoCOxLjjEsJDhtjeCo8dTFLJ
 TbULNPQP9BRUD5ch4wnc6nU4N06B3u0n8rxirjmxJjqnpXhbmnzKJnykiOqJtqut95Px
 +VRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721635738; x=1722240538;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GuhGhQfW+nG+132ytSxy9RpTW+oDEVjviPWjVECwFhM=;
 b=nFK5AI5X9rZp9Dxvpb94CLEuVBnBALagxda1S9rPEzbNdvN4qrs9/kqhaZ19k2z2re
 VTSEcNvHjnQDv/CuOw5BbjV6mIHcwSFKGZBqf4/6bbHZZ0sJiPwv8720ygaRfKY9Kbg1
 phJWqreR3D9qFh2hkOCcfz6j6d+BGZ8VTqkC1wdXVB5wf/SzcSaUEm+hPXUv1d/ZhXx8
 F/iT8S3TvwU4iqAHAqSL9pK8Y0CJNi3sVtWDTerixqaTO2GKYVf/FfV7sGMkY0v6KwKm
 Dhbgir5pfI2kAAP7Wh9dFiaFSHByn4V4yhCEXfA4N08oZjc3sgTAL2N/R6DYEKrtSa1Q
 Qbgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBcAvX25CmCeehJJQ3RA27kvfL0/f77kYpy+eVUTLClXPMeymkfbnHbX6mKpxkcEQqCQrR5VoSqriepGJwpGKoceXlw4M=
X-Gm-Message-State: AOJu0Yzv2lC+1yK8AVNeMV7Ygt7jh16Spia0UxUffEYLWl8LKYAKCDNa
 xKxMoUDLG73IScBG03e8K3c9b3ilMNinZbqcQwP5umk4g43SZFUA2WdnM/ppb1g=
X-Google-Smtp-Source: AGHT+IFISfe7Glmxr7X5ayHDuHzcYnKBZCYOjH/6XVdDUkj2wovbUHVeWIkoddXiTHyXbY7zPENxhw==
X-Received: by 2002:a5d:5352:0:b0:368:71bc:2b0c with SMTP id
 ffacd0b85a97d-369bae02398mr3704156f8f.10.1721635738020; 
 Mon, 22 Jul 2024 01:08:58 -0700 (PDT)
Received: from [192.168.69.100] (gen92-h02-176-184-20-254.dsl.sta.abo.bbox.fr.
 [176.184.20.254]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-368787ecf92sm7759570f8f.101.2024.07.22.01.08.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Jul 2024 01:08:57 -0700 (PDT)
Message-ID: <8ab5cfc4-3360-4b2e-9679-8566aea9b890@linaro.org>
Date: Mon, 22 Jul 2024 10:08:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i2c/mpc_i2c.c: Fix mmio region size
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org
References: <20240721225506.B32704E6039@zero.eik.bme.hu>
Content-Language: en-US
Cc: Andrew Randrianasulu <randrianasulu@gmail.com>,
 Amit Singh Tomar <amit.tomar@freescale.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240721225506.B32704E6039@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

+Amit & Andrew

On 22/7/24 00:55, BALATON Zoltan wrote:
> The last register of this device is at offset 0x14 occupying 8 bits so
> to cover it the mmio region needs to be 0x15 bytes long. Also correct
> the name of the field storing this register value to match the
> register name.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/i2c/mpc_i2c.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)


> @@ -329,7 +329,7 @@ static void mpc_i2c_realize(DeviceState *dev, Error **errp)
>       MPCI2CState  *i2c = MPC_I2C(dev);
>       sysbus_init_irq(SYS_BUS_DEVICE(dev), &i2c->irq);
>       memory_region_init_io(&i2c->iomem, OBJECT(i2c), &i2c_ops, i2c,
> -                          "mpc-i2c", 0x14);
> +                          "mpc-i2c", 0x15);

Personally I'm not a big fan of non-pow2 regions, so I'd have picked
0x20 or 0x100 where the 2nd i2c controller starts. Amit, what do you
think?

Anyhow,

Fixes: 7abb479c7a ("PPC: E500: Add FSL I2C controller")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       sysbus_init_mmio(SYS_BUS_DEVICE(dev), &i2c->iomem);
>       i2c->bus = i2c_init_bus(dev, "i2c");
>   }


