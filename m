Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1564C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 13:30:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Vl2-00061r-7i; Mon, 13 May 2024 09:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6Vky-0005zc-Ms
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:30:20 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6Vkw-00068S-L5
 for qemu-devel@nongnu.org; Mon, 13 May 2024 09:30:20 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-34da4d6f543so3197548f8f.3
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 06:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715607016; x=1716211816; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JIXZ57XSBqv04yqVQhcI1lAtcTMOxTYPB/N8kZSEFag=;
 b=WaULQTZm+XUzvK6+j8JdBhNlPPrSBKtl9IkV5Bj8tsgFcr7bJdOrwr/ToN7BH2wTLR
 56U4ZIPD/G3VqRhll82ImUdRuX6R4C7a7Ws3ObZZ5x31vhRsQY1Nhh6Ar178OimbEDiF
 jTpnKYIpB3qCX2aXNqVcGc+utKflViw9Z55S61FOJcw/95dR7DfHM0vLH8bowWkYWrQb
 xwByqsU+t3D6lOBv0KiQfC/uB/0Dkxj09Z5uVSCrDjijaekJNkKfvX/PwLi9j4KHxC+5
 TDRlpw2ZPgeKjWjYih1P3k+hFV9uQj68YtHt5TGecua78CNwHGajmWKMXBb2DaAG8yeK
 tNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715607016; x=1716211816;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JIXZ57XSBqv04yqVQhcI1lAtcTMOxTYPB/N8kZSEFag=;
 b=Ex4Rb8akRFiuDhUhMH48oT1hT+q11+Bgl7kCNxe0wUDNDkqpo/YzI5b6Pyf3jUDgHS
 2IaK2VI2YE1NR9gIEuMhnpyxrdhVOZHdTWUbCOeSWUKOy1ZhLsQSuepIcocCuvI0vutS
 5yjPVZKUzi7k6oxUNk137cxXVIF0Dh4jC3HrMIIg8sMYYKC7114Qy65LMF00p5+zmGVG
 3OM03cCxsWAIS0pV0U+IQ1I8A1KByc3SG2QFc6qEGcLAXlgRj6wHwmZdcN+GZ02WDUgB
 Q4+9Stzgdpurs2MSKOt9VhN/eddMPhUdI5/1pBI9J5G4Lqjr1WFloyjg0ZlMDb0XnOkp
 a3iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPJ90Qs5QVMYmGSPVeKVUCgvEdbLjgMeAnjUYiayFKZ5P6dhJ44ghnRT+mk4TvTVEbMQV/2CThY2SjdkJtDbfHntACJmY=
X-Gm-Message-State: AOJu0YzmnH+sIRNScvujOJsZnGixLOuQXymlgkI1ZMidzW6UWzY757PX
 BFi5KPTcGWUKP9I44D+nuHIsgTIOVAlm0Pw49v90jeoRWlEMZk/ne0NMSlbOC5I=
X-Google-Smtp-Source: AGHT+IHlJ2gVQ0ioPrg2T3gTSEUvFclY8yKwWQq0uImfc3+XceI7q3magXVqW4iiY7QS0VB+ju6X4Q==
X-Received: by 2002:adf:fa4d:0:b0:34f:fd71:9af with SMTP id
 ffacd0b85a97d-3504a73edbfmr7026811f8f.39.1715607015860; 
 Mon, 13 May 2024 06:30:15 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b896a89sm10992838f8f.31.2024.05.13.06.30.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 06:30:15 -0700 (PDT)
Message-ID: <6bb04e15-5bfd-4ac6-98a1-33c65a6f1663@linaro.org>
Date: Mon, 13 May 2024 15:30:14 +0200
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
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Hi Rayhan,

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


> +static void bcm2835_otp_write(void *opaque, hwaddr addr,
> +                              uint64_t value, unsigned int size)
> +{
> +    switch (addr) {
> +    case BCM2835_OTP_BOOTMODE_REG:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "bcm2835_otp: BCM2835_OTP_BOOTMODE_REG\n");
> +        break;
> +    case BCM2835_OTP_CONFIG_REG:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "bcm2835_otp: BCM2835_OTP_CONFIG_REG\n");
> +        break;
> +    case BCM2835_OTP_CTRL_LO_REG:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "bcm2835_otp: BCM2835_OTP_CTRL_LO_REG\n");
> +        break;
> +    case BCM2835_OTP_CTRL_HI_REG:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "bcm2835_otp: BCM2835_OTP_CTRL_HI_REG\n");
> +        break;
> +    case BCM2835_OTP_STATUS_REG:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "bcm2835_otp: BCM2835_OTP_STATUS_REG\n");
> +        break;
> +    case BCM2835_OTP_BITSEL_REG:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "bcm2835_otp: BCM2835_OTP_BITSEL_REG\n");
> +        break;
> +    case BCM2835_OTP_DATA_REG:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "bcm2835_otp: BCM2835_OTP_DATA_REG\n");
> +        break;
> +    case BCM2835_OTP_ADDR_REG:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "bcm2835_otp: BCM2835_OTP_ADDR_REG\n");
> +        break;
> +    case BCM2835_OTP_WRITE_DATA_READ_REG:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "bcm2835_otp: BCM2835_OTP_WRITE_DATA_READ_REG\n");
> +        break;
> +    case BCM2835_OTP_INIT_STATUS_REG:
> +        qemu_log_mask(LOG_UNIMP,
> +                      "bcm2835_otp: BCM2835_OTP_INIT_STATUS_REG\n");
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "%s: Bad offset 0x%" HWADDR_PRIx "\n", __func__, addr);
> +    }
> +}
> +
> +static const MemoryRegionOps bcm2835_otp_ops = {
> +    .read = bcm2835_otp_read,
> +    .write = bcm2835_otp_write,
> +    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .valid = {

s/valid/impl/ here, this is your implementation. It isn't illegal to
access these registers with a non 32-bit size.

> +        .min_access_size = 4,
> +        .max_access_size = 4,
> +    },
> +};


> +/* https://elinux.org/BCM2835_registers#OTP */
> +#define BCM2835_OTP_BOOTMODE_REG            0x00
> +#define BCM2835_OTP_CONFIG_REG              0x04
> +#define BCM2835_OTP_CTRL_LO_REG             0x08
> +#define BCM2835_OTP_CTRL_HI_REG             0x0c
> +#define BCM2835_OTP_STATUS_REG              0x10
> +#define BCM2835_OTP_BITSEL_REG              0x14
> +#define BCM2835_OTP_DATA_REG                0x18
> +#define BCM2835_OTP_ADDR_REG                0x1c
> +#define BCM2835_OTP_WRITE_DATA_READ_REG     0x20
> +#define BCM2835_OTP_INIT_STATUS_REG         0x24

