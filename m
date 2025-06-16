Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65154C71136
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 05:15:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR2Ay-00023p-3F; Mon, 16 Jun 2025 01:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uR2AR-00020u-F2
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 01:14:00 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uR2AP-0003zS-Ra
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 01:13:59 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-442e9c00bf4so33400595e9.3
 for <qemu-devel@nongnu.org>; Sun, 15 Jun 2025 22:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750050834; x=1750655634; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fgAGEeBMrVeI7DLnCGaqows5HAGT1+vGAZ0R9Yy6NA4=;
 b=ANt1ZWhnmNLVgKAuskAwAQk5YJ3rV0KJ+IsswxusODVJ+pKkwho4PylXQf6XWnK3ij
 ihXKU/AN5haveL/tlwJ4rYLV95XUpcCbuzRzgWTBmJ2mT1VdjO+4rwgG0sg3Kahnf9Q5
 jVD6r+laS7wBBHh1X4gxYqTTligkA7zunAeT5bvfFrPDR+IDcvHdmjF9W1XMl3Dscxw4
 Z7wh+M+IhUGodc45LJ1Cpuac1dfvXQVv9HIUJY0VtFuG/+CkvK4Pa7v/wj/eotIe1szC
 HMqXryM5GcRyyjWOcMcm9c2w/sUN/RNW1GZgNOBAolUESIvjNRoCDFYgAeuSa7pc9Odt
 2LOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750050834; x=1750655634;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fgAGEeBMrVeI7DLnCGaqows5HAGT1+vGAZ0R9Yy6NA4=;
 b=RQ9rMjy9OUDxLUw8A8sK2z2LjJrYgwQkxGcULPTeVMtBPqyRGOd3FDXa2iXXmgXrq+
 PSokoeiDsE9KGBv82iSSF2p2wusG13wLvxqi7PD1fj0vs7CFsYky7yEV4QWUsja0G4v+
 6dvPygu4Up2JsWsl4XfmDC0Df2wT1/LoPWq/q7EX9vmRBc4fjTbeeJMnKgxlhlTt84wH
 OfyvhgErOamex0WH8ClRGw6Ks9aSnU6CIhWPbU18ZUfNhXTe1WqVAXv8nv09ZWRwjgBG
 o3+frxrnesluE1S/nGqtsJBB4s96L7hETA6cbO1hv8KMM3GD+uNoTu5YnSngj00aZOZp
 yk+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuZPDDYZIJ57KhQK8AGycZpB6hJT0AlG020woZU7/JbOKLrfxln26Ukbx2QHYUVj7NtryyrdzINSK6@nongnu.org
X-Gm-Message-State: AOJu0YxKl8d09xVcj1pfIk76U85b8ZZkVuxmSbTt2Q2s/jfmncuFUWOP
 BMpdZYunRe+wFIL920HgAZI4IOz2lXz5GoDovsNgA7+wVdTHIasOzIFuAgxikC56HFk=
X-Gm-Gg: ASbGncv83mIeuFuRfldpIoo7E8BCuUdeQfVdFu92z5dfvjky/Ydss66tHCXOPeBQ+9N
 jgkzZ7aXBF0gRK/kBh1OCMwzEK8q/W5CNTY7Ys406yC5RVp8BqIF50lsJxlKz2WkoQy/gncZ4lq
 aPCNTq45WqE3o8H/pGUfOqxnkXriBL//szepRa/bazb37evJxgBtKahLYLwVdKiNTrrfn3h4e/u
 LUfX334J1gGbF479X+7Puw9EFK957sgF8zQNuTQZvlx9cjINi39aww0rdxvHnIf0W0Jg6UGlD2p
 bXwlzsPIC4L9QT7NwLFTQzTnVlcXiubyvTxbF0LUXgcFP9WylCnEulpzwo97K+PfK8UtQgsRzby
 UU88rS1FzMrHrQBTHnx3A2O9/R+SWaA==
X-Google-Smtp-Source: AGHT+IFOKzv8Z35ANQvN0FXPBDOvcMstw7Fn5PUmfu1p/ViAaGF4n+/yhmpFWoUVZetynlcbpO3/AA==
X-Received: by 2002:a05:600c:4fc3:b0:441:b3f0:e5f6 with SMTP id
 5b1f17b1804b1-4533caecda9mr63529565e9.25.1750050834640; 
 Sun, 15 Jun 2025 22:13:54 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e13d009sm133491865e9.20.2025.06.15.22.13.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Jun 2025 22:13:54 -0700 (PDT)
Message-ID: <ae86b2f5-289a-4767-9704-41f019187ec1@linaro.org>
Date: Mon, 16 Jun 2025 07:13:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] MAX78000 GCR implementation
To: jcksn@duck.com, qemu-devel@nongnu.org
Cc: alistair@alistair.me
References: <20250510042043.2056265-1-jcksn@duck.com>
 <ACFFEE84-30F3-4A74-93C0-5E18B0412D25.1@smtp-inbound1.duck.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ACFFEE84-30F3-4A74-93C0-5E18B0412D25.1@smtp-inbound1.duck.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Hi,

On 10/5/25 06:20, jcksn@duck.com wrote:
> This patch implements the Global Control Register for the MAX78000 SOC
> 
> Signed-off-by: Jackson Donaldson <jcksn@duck.com>
> ---
>   hw/arm/Kconfig                 |   1 +
>   hw/arm/max78000_soc.c          |   9 +-
>   hw/misc/Kconfig                |   3 +
>   hw/misc/max78000_gcr.c         | 285 +++++++++++++++++++++++++++++++++
>   hw/misc/meson.build            |   1 +
>   include/hw/arm/max78000_soc.h  |   2 +
>   include/hw/misc/max78000_gcr.h | 122 ++++++++++++++
>   7 files changed, 422 insertions(+), 1 deletion(-)
>   create mode 100644 hw/misc/max78000_gcr.c
>   create mode 100644 include/hw/misc/max78000_gcr.h


> diff --git a/hw/arm/max78000_soc.c b/hw/arm/max78000_soc.c
> index 6334d8b49b..7a012c6ef7 100644
> --- a/hw/arm/max78000_soc.c
> +++ b/hw/arm/max78000_soc.c
> @@ -29,6 +29,8 @@ static void max78000_soc_initfn(Object *obj)
>   
>       object_initialize_child(obj, "armv7m", &s->armv7m, TYPE_ARMV7M);
>   
> +    object_initialize_child(obj, "gcr", &s->gcr, TYPE_MAX78000_GCR);
> +
>       for (i = 0; i < MAX78000_NUM_ICC; i++) {
>           object_initialize_child(obj, "icc[*]", &s->icc[i], TYPE_MAX78000_ICC);
>       }
> @@ -104,6 +106,10 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
>           return;
>       }
>   
> +    dev = DEVICE(&s->gcr);
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp);
> +    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0x40000000);
> +
>       for (i = 0; i < MAX78000_NUM_ICC; i++) {
>           dev = DEVICE(&(s->icc[i]));
>           sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), errp);
> @@ -116,6 +122,8 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)
>           if (!sysbus_realize(SYS_BUS_DEVICE(&s->uart[i]), errp)) {
>               return;
>           }
> +        dev->id = g_strdup_printf("uart%d", i);

This line belongs to the previous patch (UART implementation).

>           busdev = SYS_BUS_DEVICE(dev);
>           sysbus_mmio_map(busdev, 0, max78000_uart_addr[i]);
>           sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m,
> @@ -123,7 +131,6 @@ static void max78000_soc_realize(DeviceState *dev_soc, Error **errp)


