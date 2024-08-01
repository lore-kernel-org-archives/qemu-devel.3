Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E35C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 14:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZXH3-0006LH-DU; Thu, 01 Aug 2024 10:59:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZXH1-0006Cz-6t
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:59:23 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZXGz-0004g2-LI
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:59:22 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-428085a3ad1so47501625e9.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 07:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722524359; x=1723129159; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WwpOBcDdrYa8LGdl6Bz1wmYNkQXUSM+M4H7Y98mwJPg=;
 b=tswsyma4qgLIvRwFJKe2m/zzUXfPfJeXI4Mvy4r2DOYmV+aD8JA0ewwqVTMZhHyC36
 +Px/voeyMsH2fy7yWg06xXM9r6gGb7I+2rywLeo2AdpSwJ8+JOqfXgjak5MRjaP9gIQx
 zKGRrm3JmNxxRKtgGDwEmTqDu5h3oeUdzlK1H9aA3V82WesY0ewWyeV/5UYWmgk8MfOp
 YVcS1HlgH/4C2FG5xTB9n7TyqFL7wx5k4/YP/JquH+9CefE+Cda4qWCqDn43djyCmDNR
 h2PTovb0AcEyNJlsSXJA8HQr2wqHUjXLraN0cfWvaqHESICwjoEwY2ejq8/94YjvcnbQ
 jb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722524359; x=1723129159;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WwpOBcDdrYa8LGdl6Bz1wmYNkQXUSM+M4H7Y98mwJPg=;
 b=Km6TYmUqvFeMJbHaNS+zLHYvS4HKolfkjNRXnA7InVJhRjyaZTwHL6Y3HeUkI/SJMp
 LPne3TFcPL0YR2IV/d7QsRM/FLzQFj73STpsQBZuPZJDRzm5udUI+fQp3RqCynfRfL2N
 JDCoE5PUHjQhOH2bizn5KzlLd1tuC1boLEpnP7vQNii+2UtMOZfE9FVEogwoquK+F9n5
 R0BI/dvATDi/yoE4Li3JTmd0RoA//6ke+D8iPjJA0QQ5sQ5XM0oauIsuJoPyb2BXptZ7
 CJKVzbIeYWXmxNmQD8U5a0ajog884ZQD/nftib4bMQuvO9cYftJULeaudN+aCoS7/DVn
 dNiA==
X-Gm-Message-State: AOJu0YzR/pcXbFiDYwezDT4KqeUCqykOwTxKI5JJx58/ZV/wEr6DDdNt
 sq9vd17/uT1yvv6EWhGIgk7OhdHlE5fWDVCDfXv06HEhkaY0HbHyaEx70CU2BngH7kW6aovTd+b
 Z/cs=
X-Google-Smtp-Source: AGHT+IE/wQ2YINLTrlnfr7bJ9yDLubjBopIKgGDhDCpr/xYxJREyh13O0OHlaVRvxwD/xivGrH7s+w==
X-Received: by 2002:a05:600c:4ece:b0:426:5ee5:3130 with SMTP id
 5b1f17b1804b1-428e6ae2802mr1397965e9.3.1722524359306; 
 Thu, 01 Aug 2024 07:59:19 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282baa9071sm61186985e9.13.2024.08.01.07.59.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Aug 2024 07:59:18 -0700 (PDT)
Message-ID: <2638c0b9-659e-42fb-9830-b913e4e4354a@linaro.org>
Date: Thu, 1 Aug 2024 16:59:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 2/2] hw/pci-host/gt64120: Set PCI base address
 register write mask
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20240801145630.52680-1-philmd@linaro.org>
 <20240801145630.52680-3-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240801145630.52680-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 1/8/24 16:56, Philippe Mathieu-Daudé wrote:
> When booting Linux we see:
> 
>    PCI host bridge to bus 0000:00
>    pci_bus 0000:00: root bus resource [mem 0x10000000-0x17ffffff]
>    pci_bus 0000:00: root bus resource [io  0x1000-0x1fffff]
>    pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
>    pci 0000:00:00.0: [11ab:4620] type 00 class 0x060000
>    pci 0000:00:00.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
>    pci 0000:00:00.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
>    pci 0000:00:00.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
>    pci 0000:00:00.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
>    pci 0000:00:00.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)
> 
> This is due to missing base address register write mask.
> Add it to get:
> 
>    PCI host bridge to bus 0000:00
>    pci_bus 0000:00: root bus resource [mem 0x10000000-0x17ffffff]
>    pci_bus 0000:00: root bus resource [io  0x1000-0x1fffff]
>    pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
>    pci 0000:00:00.0: [11ab:4620] type 00 class 0x060000
>    pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00000fff pref]
>    pci 0000:00:00.0: reg 0x14: [mem 0x01000000-0x01000fff pref]
>    pci 0000:00:00.0: reg 0x18: [mem 0x1c000000-0x1c000fff]
>    pci 0000:00:00.0: reg 0x1c: [mem 0x1f000000-0x1f000fff]
>    pci 0000:00:00.0: reg 0x20: [mem 0x1be00000-0x1be00fff]
>    pci 0000:00:00.0: reg 0x24: [io  0x14000000-0x14000007]
> 
> Mention the datasheet referenced. Remove the "Malta assumptions ahead"
> comment since the reset values from the datasheet are used.

Argh this comment belongs to the previous patch :/

> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/pci-host/gt64120.c | 7 +++++++
>   1 file changed, 7 insertions(+)


