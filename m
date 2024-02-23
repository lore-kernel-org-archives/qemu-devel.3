Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD28C54E41
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 06:16:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdOqv-0006tv-D9; Fri, 23 Feb 2024 01:16:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdOqs-0006qF-GU
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 01:16:07 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdOqo-0007aT-VE
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 01:16:04 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-564d9b0e96dso445902a12.2
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 22:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708668960; x=1709273760; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xgPnK6wuQ8wyeaGEL9HRKxnZqmUBYQ7V/HzwctHbui0=;
 b=XMHPVia5fIrhuDuXiAwe7WM1qKRQeqzhPWx6LJd1vtlPn05XocHchyQwXW2CcTMb4h
 lGqznrcAh9K+OBIwAEkFQblAEFP5/hxSTJh3h7yKRf/45Pdwz8CdeMtcRl/YY6AoCzkH
 DlBOX6Aa7WBIw3VNpE9AtPS9mcQxYxu8+W4qrH1EtiUsZCUaazGAIyZdMGifZKbsAUNQ
 8sOoLkhWYMvpQbZIv7MsBWW45EMWggJi/gl4EJYJ98iX9pbe1i0ubWFWNO53Jek2zKOZ
 SMIqeeKFdfz8FQ8eIi1OSTtqfkowLVS3rdTEH00G52fUkY1Pp0yYnDGk8XI+eP7RLu1R
 jwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708668960; x=1709273760;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xgPnK6wuQ8wyeaGEL9HRKxnZqmUBYQ7V/HzwctHbui0=;
 b=LIcN9GKluVCpMS/D0L3kuPLTv6kmFNXo9dab6Xu9fSA2Vu0UsNnEJnurtPSq8GluZx
 JvK2FzSB+Eo8dczTGjRK0kMEvGAYn8HWSJH8Oxn8kYdYw/Ju6R9XwCO3sYpgRuW6x4KV
 SQaGleWUP71xwN4xsFrpVhN2vatnuBB+BgjMLT0Z7N5I3GF0E+1vLda1gesCAbMsU023
 DqCGxEt/TaqkfiVdLeEiAr3kh4YSOO/6L5vbHMopyLY9VAN4OFaVWbSuvnRRY7Md7zoB
 K3WSd2b580q4tqVBUCvL//bOVQG1yWCL4gUUacoWphTfcG4zpZec/6Y4qe2vf050WfDF
 Zuug==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYrOnwPif9FurC+RT8Hz9Tk5yq1Uc5SBJD7wTZRlHwks8nI2xb7bAWYxHO9Cx0F/X1sBoFX45lKtR/udBYkGecjemomyo=
X-Gm-Message-State: AOJu0YzuwoUao/egnp7Y8q/dBRTD9ASd8yx3FEhmeADMiRSGURvhqCk/
 /h+uWZhHoWKDe76HuzrjG2WvSrBYgw3ANNDsulLxdcx839TNxroI60BV4RM/Cyc=
X-Google-Smtp-Source: AGHT+IHv9lmf3alSMYZ3OUFU+9tsPzHaWmGI4AxLB/EXUDJS6tJfhVp3y9tpExFRcoo34X0hpbSQRg==
X-Received: by 2002:aa7:c544:0:b0:564:4504:cc2 with SMTP id
 s4-20020aa7c544000000b0056445040cc2mr539248edr.16.1708668960364; 
 Thu, 22 Feb 2024 22:16:00 -0800 (PST)
Received: from [192.168.69.100] (sto95-h01-176-184-18-96.dsl.sta.abo.bbox.fr.
 [176.184.18.96]) by smtp.gmail.com with ESMTPSA id
 k20-20020aa7c054000000b005657eefa8e9sm10309edo.4.2024.02.22.22.15.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Feb 2024 22:15:59 -0800 (PST)
Message-ID: <6f947660-b116-4ba3-806d-6fd4a12836f5@linaro.org>
Date: Fri, 23 Feb 2024 07:15:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] hw/i2c: Implement Broadcom Serial Controller (BSC)
Content-Language: en-US
To: Rayhan Faizel <rayhan.faizel@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, qemu-arm@nongnu.org
References: <20240220134120.2961059-1-rayhan.faizel@gmail.com>
 <20240220134120.2961059-2-rayhan.faizel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240220134120.2961059-2-rayhan.faizel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
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

On 20/2/24 14:41, Rayhan Faizel wrote:
> A few deficiencies in the current device model need to be noted.
> 
> 1. FIFOs are not used. All sends and receives are done directly.
> 2. Repeated starts are not emulated. Repeated starts can be triggered in real
> hardware by sending a new read transfer request in the window time between
> transfer active set of write transfer request and done bit set of the same.
> 
> Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
> ---
>   docs/system/arm/raspi.rst    |   1 +
>   hw/i2c/Kconfig               |   4 +
>   hw/i2c/bcm2835_i2c.c         | 278 +++++++++++++++++++++++++++++++++++
>   hw/i2c/meson.build           |   1 +
>   include/hw/i2c/bcm2835_i2c.h |  80 ++++++++++
>   5 files changed, 364 insertions(+)
>   create mode 100644 hw/i2c/bcm2835_i2c.c
>   create mode 100644 include/hw/i2c/bcm2835_i2c.h


> +static const MemoryRegionOps bcm2835_i2c_ops = {
> +    .read = bcm2835_i2c_read,
> +    .write = bcm2835_i2c_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,

Watch out, your implementation is 32-bit, so this misses:

       .impl = {
           .min_access_size = 4,
           .max_access_size = 4,
       },

> +};


> diff --git a/include/hw/i2c/bcm2835_i2c.h b/include/hw/i2c/bcm2835_i2c.h
> new file mode 100644
> index 0000000000..0a56df4720
> --- /dev/null
> +++ b/include/hw/i2c/bcm2835_i2c.h


> +#define BCM2835_I2C_C       0x0                   /* Control */
> +#define BCM2835_I2C_S       0x4                   /* Status */
> +#define BCM2835_I2C_DLEN    0x8                   /* Data Length */
> +#define BCM2835_I2C_A       0xc                   /* Slave Address */
> +#define BCM2835_I2C_FIFO    0x10                  /* FIFO */
> +#define BCM2835_I2C_DIV     0x14                  /* Clock Divider */
> +#define BCM2835_I2C_DEL     0x18                  /* Data Delay */
> +#define BCM2835_I2C_CLKT    0x20                  /* Clock Stretch Timeout */

