Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32309C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:50:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJhC-0005Yu-RZ; Wed, 29 May 2024 09:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCJh9-0005Ob-Sx
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:50:24 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sCJh5-0002vx-DD
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:50:23 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-35508106cc2so1952036f8f.2
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 06:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716990617; x=1717595417; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LuuXb/nW10D+yJAng2WKg8K/Ofyv1dKNEmCpb+80bN4=;
 b=jQsaC7eG2tEa0PFkUiDUAd/33/UW7ElzFq1vJKTNMJG2ugvtpTWkGmUhspywu6Kon2
 s/UoHOxXTwxZ2mbBx2ElJQHaA3AocXTi/7eb3j5Fn0Uur593Z8xtE7qZFrOsYvEA4Y3e
 gGgRdbqnMHLMgd0Lu/iMbqs35wrfONpwUXg/PQMuR+d4Ek6reTSkX3JJQlwTW6T0abIg
 5OXcB+hf3fDuUW5DcBwB8yFXJh/V9e2x4n8MlFFQrbBm96+chCkogTw37yR91qPonZo3
 yomLBjnClWJ/S/bxCMHHLkGdhGnj4fJOritJARlalrXFozu6fC0Y0+p7a3lm3kaK+hJN
 rxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716990617; x=1717595417;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LuuXb/nW10D+yJAng2WKg8K/Ofyv1dKNEmCpb+80bN4=;
 b=CcWIlS1BNVHIMYA2HYpGD3dLIg55rBkbis5BhhgRECTSZHfpfO8XrIEZZK8hIX//gh
 xXK1IqhylsOKV9rHuQad6DJsnLRL4RMwi2CiPIMF6BhLQFzzruWREGHpVu8SzOFkt5Bt
 G/gHIPSRWRVEqXhdWIIXm1TIoVuvsYEooKUuXZFrTY3pwAS2SI7xn6SYo9LxWIxPoLsH
 DRvP8W5qnUM8EzEocmu8Bun1ucxNbDWPzsbfRpHnfw2BWqV9374HAKOarbmJ3tYgeMmt
 i+3Xzpc9BMMlrrc8eCeoLyX0SAXsfZeFRrnQL/C90cUKCgNmK5AkHtSjiwZjJKr0GUFV
 UboQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZeQj0VNJdfteXZpXT0sGXtfiaT+fKvZD7GXJWmJx+YVfMUlw/swfaN1TgNE4o+H0UV4mP3abRC/3Fy8i9c4M/znJl5Jg=
X-Gm-Message-State: AOJu0Yx+cpI8r62nYQBjo4S3ZDT+EA/LAc3Jwvx6YCftcv3fOd7ZLzPM
 dNctJLJbFQ1a+if96ch7HRyWrIQz0WVlWrDa474VIOZGfTk5Uu5AqRWKpMcdkII=
X-Google-Smtp-Source: AGHT+IHiG796RuAuh2raoGoW+YpK3xXA/3l8Af9q3vBfDbi1Jrg4yDBpjf0fQPaE15Ss3RgyLcHUgg==
X-Received: by 2002:adf:a34d:0:b0:354:dfd4:4f4d with SMTP id
 ffacd0b85a97d-35526c2b6bcmr9739685f8f.16.1716990616916; 
 Wed, 29 May 2024 06:50:16 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.204.141])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557dcf0871sm15228057f8f.110.2024.05.29.06.50.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 06:50:16 -0700 (PDT)
Message-ID: <fc0338d2-9a4d-4770-8a9c-c9e077415b29@linaro.org>
Date: Wed, 29 May 2024 15:50:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pci-bridge/xio3130_downstream: fix invalid link speed and
 link width
To: Nam Cao <namcao@linutronix.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
References: <20240529132125.106790-1-namcao@linutronix.de>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240529132125.106790-1-namcao@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Hi Nam,

On 29/5/24 15:21, Nam Cao wrote:
> Set link width to x1 and link speed to 2.5 Gb/s as specified by the
> datasheet. Without this, these fields in the link status register read
> zero, which is incorrect.
> 
> This problem appeared since 3d67447fe7c2 ("pcie: Fill PCIESlot link fields
> to support higher speeds and widths"), which allows PCIe slot to set link
> width and link speed. However, if PCIe slot does not explicitly set these
> properties, they will be zero. Before this commit, the width and speed
> default to x1 and 2.5 Gb/s.
> 
> Fixes: 3d67447fe7c2 ("pcie: Fill PCIESlot link fields to support higher speeds and widths")
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
>   hw/pci-bridge/xio3130_downstream.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
> index 38a2361fa2..d949431191 100644
> --- a/hw/pci-bridge/xio3130_downstream.c
> +++ b/hw/pci-bridge/xio3130_downstream.c
> @@ -172,10 +172,18 @@ static void xio3130_downstream_class_init(ObjectClass *klass, void *data)
>       device_class_set_props(dc, xio3130_downstream_props);
>   }
>   
> +static void xio3130_downstream_instance_post_init(Object *obj)
> +{
> +    PCIESlot *s = PCIE_SLOT(obj);
> +    s->speed = QEMU_PCI_EXP_LNK_2_5GT;
> +    s->width = QEMU_PCI_EXP_LNK_X1;

- You ignore previous value and overwrite
- You don't warn the user about missing config value

Is post_init() the correct way to deal with that? Usually
this is done in realize(), where you can set *errp to
notify the user of invalid values.

> +}
> +
>   static const TypeInfo xio3130_downstream_info = {
>       .name          = TYPE_XIO3130_DOWNSTREAM,
>       .parent        = TYPE_PCIE_SLOT,
>       .class_init    = xio3130_downstream_class_init,
> +    .instance_post_init = xio3130_downstream_instance_post_init,
>       .interfaces = (InterfaceInfo[]) {
>           { INTERFACE_PCIE_DEVICE },
>           { }


