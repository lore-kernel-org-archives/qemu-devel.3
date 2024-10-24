Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EBBD0BB4F
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 02:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3nps-0003fo-0n; Wed, 23 Oct 2024 22:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t3npp-0003fe-NV
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 22:44:25 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t3npo-0003d2-6n
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 22:44:25 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7ed9f1bcb6bso248838a12.1
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 19:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729737862; x=1730342662; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PirV9v6Fz+mCnD4l9A9nsE/XjCHG65CKZNn5SdD3JUk=;
 b=eP28v4Dg6uyylA1PghbUaKEvCOK4s3vns/znOsVk57wvYc+GNlJEG88BYPMBKHvyrF
 f2D46VHFx1Kt7wZ5ht+tLAQsBDORxE4niNcLzwV/8h/A9Eu29cGPLsZWcJ6KEmBgJedr
 gVShrEQBitYs9H5nS5UpgwLRKPysgO1Ndw0kilzL6BEbe2tvkdwEWk/fpjLpaZxWOUg4
 vjjopkbz2lfK55o0jdxM0g/UNDbx7s4O1GA7BaOl6X7IKtWcTtRQBXtlwWyzslHVvMIr
 89WkKH4pbXYoXXeXravrJzNI70LPZ3NLK0UiqbscsA9XAwAZ5m4oDRTYZ6Oc9W4PzpXw
 TTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729737862; x=1730342662;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PirV9v6Fz+mCnD4l9A9nsE/XjCHG65CKZNn5SdD3JUk=;
 b=ZjtSNdOTgIp3jFgPctmWM8UviYC3vsD2imuNg+wDhR+gik38zgL++jFbv8Dkn/F218
 +Hhv8nSzlnaccYbkvVl/brgNzOEKGoV/U2HGLrO+mWiAboPBmSGuosQJLVk0I3EODPC2
 RYjcLv2m74HyiiCmlyf0v5b9KpVIgGl5PnScR6HWUTyEUs6jZq3fJsodRQ6AOnEYWGPN
 lu6xTqarjJ4EO9qSjQfXF8sSVFXqsdERlp2q4rX2nuuT4LbkMgplk+vB9VcofKnDNea4
 55JGmjCt5B4w594Dj8c1PEzqSbXjOZ+v9l2ZmdK7m8KFJcqJf3c/qqKtPB60OdNwN6sZ
 Cbyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqVeGqKufvF2KKSBDEpQycCcriHFQ/x5r4l4It01fKwJn2IBef4kCQX9C4i+4sjGgZXypFcxJx3aZ4@nongnu.org
X-Gm-Message-State: AOJu0YxBYSKbLmzE2K2NBJTUDZMpLIndvpP9qmOw4kDjixzdcAfdLIBN
 uUCNvgXI3OHDalHcySamiMGlq1XpIjlx8vEvqoJ8JSG00LcxM2oxj+HsqrKJD80=
X-Google-Smtp-Source: AGHT+IE2M4uaO4J3hvr6m4p+t0FbzsSWmHJbtIPnP7rYVLkT6sBW4Sq4PwiMq6NKTaDiTzx0f6X4cg==
X-Received: by 2002:a05:6a21:390:b0:1cf:476f:2d10 with SMTP id
 adf61e73a8af0-1d989d0414emr472585637.49.1729737862387; 
 Wed, 23 Oct 2024 19:44:22 -0700 (PDT)
Received: from [192.168.100.49] ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0bd2d9sm63794855ad.142.2024.10.23.19.44.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 19:44:22 -0700 (PDT)
Message-ID: <ff126981-ddd6-41a7-bcd4-f27083a0445a@linaro.org>
Date: Wed, 23 Oct 2024 23:44:19 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/36] next-cube: QOMify NeXTRTC
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, huth@tuxfamily.org,
 qemu-devel@nongnu.org
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
 <20241023085852.1061031-28-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241023085852.1061031-28-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Mark,

On 23/10/24 05:58, Mark Cave-Ayland wrote:
> This is to allow the RTC functionality to be maintained within its own separate
> device.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>   hw/m68k/next-cube.c | 66 ++++++++++++++++++++++++++++++++-------------
>   1 file changed, 48 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
> index e4d0083eb0..6b574d39cf 100644
> --- a/hw/m68k/next-cube.c
> +++ b/hw/m68k/next-cube.c
> @@ -42,7 +42,13 @@
>   #define RAM_SIZE    0x4000000
>   #define ROM_FILE    "Rev_2.5_v66.bin"
>   
> -typedef struct NeXTRTC {
> +
> +#define TYPE_NEXT_RTC "next-rtc"
> +OBJECT_DECLARE_SIMPLE_TYPE(NeXTRTC, NEXT_RTC)
> +
> +struct NeXTRTC {
> +    SysBusDevice parent_obj;

Since it was not explicitly reset, maybe QDev parent is enough?

>       int8_t phase;
>       uint8_t ram[32];
>       uint8_t command;
> @@ -50,7 +56,7 @@ typedef struct NeXTRTC {
>       uint8_t status;
>       uint8_t control;
>       uint8_t retval;
> -} NeXTRTC;
> +};


