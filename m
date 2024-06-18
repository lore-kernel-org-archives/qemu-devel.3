Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2837EC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 11:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJXHr-00052g-2n; Tue, 18 Jun 2024 07:46:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJXHp-00052K-3A
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:46:05 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJXHn-0002zG-3j
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 07:46:04 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4230366ad7bso48598175e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 04:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718711161; x=1719315961; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EWFbYBDX/cRz5BrB/RlV4gYGYZOc+zNEQW8QwEvBsmI=;
 b=IQpZw0/M9fDBzOzAbUmCy+RtvbmYCf6VbfNGvN+NuZ2i3g9TvZaatewOvaBB+/Knby
 oLZ3cJJ1cymWp8LtbQZhmD8P4cVDXKAavJweCIYUhLOlqCPgsNXdf/43NxDEQr272Brv
 u1XmM3pWZVFK68JxTaybtBw3ZlZHimzUd83ECYn51ZaD6bbgAYDfFEjRG/gLpZneCrRL
 F9pE/HgHN3dW0yoBTZM5YUutOSPAPkSmK6xr8mJZMDx+S7YWxkM4+BVmcashjGfX/QeV
 ozrvmR4IpvdJcNVGYrvyEi0SZJZM232YKc9jS3Eds476wWwenNv8jUjk+l4ARpoto+iE
 ygOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718711161; x=1719315961;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EWFbYBDX/cRz5BrB/RlV4gYGYZOc+zNEQW8QwEvBsmI=;
 b=dK5SEvJRcqWUE68PyYzPIWzQwE40tHaV8CuDoQQgE+My/xJiDyxNO27kidPC0N396o
 Y21d4IoDkf74GvW6TuMzykxT7QiKovn3z+sd1D8tICfJOIFwGD7HV3bD03h3WdH+pMZ7
 YvHjf/RVkDv01/Uc9mVrKb6r1jzaXAl4ZSh/EVj4Z4k4Yvp6cuNstGW9hWEkLcuw96tF
 jgK8EQcTFUndtG+ivKVhDXi9ZJFGGlnsVGOHDlzkG5HiRId26jcX0wySiUE9I9/jEgS3
 uboik7YRsNUMkTidFN0CVcNpINKMrn6flZVai+yE8GhFbg70f7IYhsCnNq0SHj1oH0Hz
 NbFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCViqkSu1ghtokKOmCmkzFGLinmXZt5J8IMXWNzuYY7GxATJ04fr4/D4aozf5mvVVnHivlQPquMtZsGE5p2Gx4heK+Zp/zQ=
X-Gm-Message-State: AOJu0YyBR99niYCQpvtOkwwS/r4qwUGOTMk15oEaotoYnVqZRcFJZnnn
 MWwwFc5ypz+k5xkaz2LY6Fr4BUWxN+5sgOiDIH3e29OGJOCwvgDxC2MnIwtK/m3tpeN0LzqdW87
 8t5o=
X-Google-Smtp-Source: AGHT+IHSPlrJ9Fl8GLrfkj+4cqPobLvhX7fyfswCUAMr/dEQ5b95IQGcDo/GlnRghM3ghuvnrivGeA==
X-Received: by 2002:a05:600c:4c23:b0:421:756f:b2e8 with SMTP id
 5b1f17b1804b1-42304820d66mr123433515e9.11.1718711161137; 
 Tue, 18 Jun 2024 04:46:01 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f6320bfdsm186427295e9.37.2024.06.18.04.45.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 04:46:00 -0700 (PDT)
Message-ID: <b78d2329-5f31-4dc8-90af-3f3e2c7840b0@linaro.org>
Date: Tue, 18 Jun 2024 13:45:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] hw/m68k/virt: Add some devices
To: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <20240527-m68k-bios-v1-0-6de26552fa77@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240527-m68k-bios-v1-0-6de26552fa77@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 27/5/24 19:15, Jiaxun Yang wrote:
> Hi all,
> 
> This series added some devices that I found lacking when
> I was trying to port U-Boot to m68k virt machine.

Cc'ing Mark, but both he and Laurent are busy :/

> Please review.
> Thanks
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> Jiaxun Yang (4):
>        hw/m68k/virt: Add a XHCI controller
>        hw/m68k/virt: Add fw_cfg controller
>        hw/m68k/virt: Add a pflash controller for BIOS firmware
>        hw/m68k/virt: Supply bootinfo for BIOS
> 
>   hw/m68k/Kconfig                                   |   3 +
>   hw/m68k/virt.c                                    | 231 ++++++++++++++++------
>   include/standard-headers/asm-m68k/bootinfo-virt.h |   4 +
>   3 files changed, 176 insertions(+), 62 deletions(-)
> ---
> base-commit: 60b54b67c63d8f076152e0f7dccf39854dfc6a77
> change-id: 20240527-m68k-bios-a0a2370181f5
> 
> Best regards,


