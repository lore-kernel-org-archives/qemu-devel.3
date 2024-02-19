Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F17C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 18:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc8R2-0001TV-Qj; Mon, 19 Feb 2024 13:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rc8QY-0001Qu-Lg
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 13:31:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rc8QW-0007jT-Fn
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 13:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708367499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OmYNLXvlJZLGYBsovU0ECk13vmiXlXjwGym23H7acCY=;
 b=Cs5pE9lBt4OgtGgm0mixo9Sn2TP0g2GHcY53wfhsdE1vsoEVYrfS4snmxzSFJHrfQX3tVj
 ExR8CSd9RXMTgoe7jSMwHFic5EmKnXm8SK8m+3OV0Gd+jc+GFj9wRpFc11x7Yru/BGxsfy
 7tABbuvvAHVEL+/V97kKJ6Si84JypNE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-juzKmwofPTCrVLNuLVNXhg-1; Mon, 19 Feb 2024 13:31:37 -0500
X-MC-Unique: juzKmwofPTCrVLNuLVNXhg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-68f74a0a3c7so13859656d6.2
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 10:31:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708367496; x=1708972296;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OmYNLXvlJZLGYBsovU0ECk13vmiXlXjwGym23H7acCY=;
 b=YJU+bw3AoTKFfk3gykq3Dw5J76cNlaXnOt1NZXbbLS9/tXSTeMpLeodX3XdkEawf67
 u0QKlaEd59Ty0Wi5LRxpeyYtbCgcXa4RvjFqvSW1exDc+7m7ETxCiOMOEA6/l52GQl+N
 bq5rqsTeZSrfWUyJ5kmobrz91jH5ZRH6fDoJJCkPJWvrsPpdj6dBxNOIxWVVAtf9wybI
 DHQZ4ebQOhPW9WHDsOU9DYO7f4se2V+nUstsWcmbkhUhMgqfTTRps+uhbLfquKIBeQvV
 59Z3JL3XGXdw4aHWDHzZl0ceifuIQSIIgID1k6GnG3WYCracMaEaBsMmBDSe4+7Ad7am
 pnOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSNGkgFTpnvkbcZqUjYneiDZ+2jhTOr6d8vszAFgp2O92ZsQ66IA9ivWjFPz815lRytldQqMvxE/gbhFYgisBfqvJCX6U=
X-Gm-Message-State: AOJu0YzxtBhSrbcJtO2rOQgl0+9uXAXHYzL88aY/dUmSZJ/n3QWgGT9i
 dZvjLFjOqYrdf+o+bCaf/sfjzT94DAwJ9zEn7uyG1WbUzmkZNdgkx09Vcy6UullfAwgwT/xBEWc
 Vf7X4EYhO86MAXY3EVpKudYl/DS5NbuI4NPKUkpPmoLVGih7Z2uBf
X-Received: by 2002:a0c:f3d0:0:b0:68f:325f:d88c with SMTP id
 f16-20020a0cf3d0000000b0068f325fd88cmr10896303qvm.1.1708367496357; 
 Mon, 19 Feb 2024 10:31:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0SYovQT4yF32KUOEzoi3m9WNfgTumGIkxE/FrFL+eUXSNfePLZc9yyhrKH/3JzGiIlRGITw==
X-Received: by 2002:a0c:f3d0:0:b0:68f:325f:d88c with SMTP id
 f16-20020a0cf3d0000000b0068f325fd88cmr10896294qvm.1.1708367496062; 
 Mon, 19 Feb 2024 10:31:36 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-177-48.web.vodafone.de.
 [109.43.177.48]) by smtp.gmail.com with ESMTPSA id
 ob7-20020a0562142f8700b0068f3443910bsm3472684qvb.113.2024.02.19.10.31.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Feb 2024 10:31:35 -0800 (PST)
Message-ID: <7a3b6943-84dd-4007-94a1-cc959a359b7e@redhat.com>
Date: Mon, 19 Feb 2024 19:31:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] hw/ide: Split qdev.c into ide-bus.c and ide-dev.c
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org
References: <20240219104912.378211-1-thuth@redhat.com>
 <20240219104912.378211-3-thuth@redhat.com>
 <d2bbe138-72d8-dd66-255b-d3288157dd2d@eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <d2bbe138-72d8-dd66-255b-d3288157dd2d@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 19/02/2024 12.45, BALATON Zoltan wrote:
> On Mon, 19 Feb 2024, Thomas Huth wrote:
>> qdev.c is a mixture between IDE bus specific functions and IDE device
>> functions. Let's split it up to make it more obvious which part is
>> related to bus handling and which part is related to device handling.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> hw/ide/ide-bus.c             | 111 +++++++++++++++++++++++++++++++++++
>> hw/ide/{qdev.c => ide-dev.c} |  87 +--------------------------
>> hw/arm/Kconfig               |   2 +
>> hw/ide/Kconfig               |  30 ++++++----
>> hw/ide/meson.build           |   3 +-
>> 5 files changed, 134 insertions(+), 99 deletions(-)
>> create mode 100644 hw/ide/ide-bus.c
>> rename hw/ide/{qdev.c => ide-dev.c} (78%)
> [...]
>> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
>> index 29abe1da29..b372b819a4 100644
>> --- a/hw/arm/Kconfig
>> +++ b/hw/arm/Kconfig
>> @@ -275,6 +275,8 @@ config SBSA_REF
>>     select USB_XHCI_SYSBUS
>>     select WDT_SBSA
>>     select BOCHS_DISPLAY
>> +    select IDE_BUS
>> +    select IDE_DEV
>>
>> config SABRELITE
>>     bool
>> diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
>> index b93d6743d5..6dfc5a2129 100644
>> --- a/hw/ide/Kconfig
>> +++ b/hw/ide/Kconfig
>> @@ -1,51 +1,58 @@
>> config IDE_CORE
>>     bool
>>
>> -config IDE_QDEV
>> +config IDE_BUS
>>     bool
>>     select IDE_CORE
> 
> Maybe we can assume if something has an IDE bus it also wants to connect IDE 
> devices to it so just select IDE_DEV here and not at every place IDE_BUS is 
> selected? Or is there a place that only wants IDE_BUS?

Currently not, but I think it's conceptually much cleaner if we are explicit 
here.

  Thomas


