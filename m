Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4BF9C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 08:28:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ti85j-0000V0-VP; Wed, 12 Feb 2025 03:27:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ti85i-0000Ua-1z
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 03:27:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ti85f-0002tu-A0
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 03:27:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739348844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=KzUm2JcebvBEriyU/58FuXfzUnj3eWxFzJZA+8Eeklo=;
 b=JaHtM84UAc+DBo9Rx7hWN28wQd40WJsihyS5w2gPKVRNt/oqHsLvTJvG0Ays1q+OBOQIce
 fXjUCXmL7KcrA6bWhoxzn3ZXVTGLAHYjbprfyPPQpGPPLwSJJxln9GtuGEAbrAH8cH89J1
 uhlL1RwTldNez32DU0xFTdusmzVMWBo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-LmdGHCRgNz-8SpNqVBA7CQ-1; Wed, 12 Feb 2025 03:27:22 -0500
X-MC-Unique: LmdGHCRgNz-8SpNqVBA7CQ-1
X-Mimecast-MFC-AGG-ID: LmdGHCRgNz-8SpNqVBA7CQ
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38de0201961so1966616f8f.2
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 00:27:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739348841; x=1739953641;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KzUm2JcebvBEriyU/58FuXfzUnj3eWxFzJZA+8Eeklo=;
 b=mzR0TYGR86aoE48tv3TQ79ffU4sdlnDsbFX8q1+Hzr1R7Xsa6FSySLAiK8akSk7lEv
 GsCMZbdWfbygdeuY9NXkFPUQ1Jsa02Gjb5CLmDuwm5LlT6gHoKxsKXYlgydA4vb5alqy
 cos+ipsJC+UATsuhk4RH3UoFcAXuqXaksmePADTZm2FZpGXtWHTpNa491eIBn1330arI
 BVaKsLVWiIN9khAE/wefk1iJFstNSkPvhP2MUvT48W8kBBwGNSRdT8tggsmuCjV2WQuA
 PfVgCxMTQdTepxb1I1KJ0+5SgQFz4TR23YT77xTHpaDj1OnXIgkaQxm2jhoaa29nQ0v1
 018A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2yF87whqPpBf0Uk3uECliKqgLIHmeS+R89HtBf2tQT5U7Lghq1FWDNp/TK98ZAa0qHDYd+Gb12JWa@nongnu.org
X-Gm-Message-State: AOJu0Yx3ouk8iZ/g5U+rS1gNDPE3zcPvN4nQOMyAsZ+qRRkGFiW0ge1F
 dZh4yaa7Javt3kS3llPjpWItCIVk9syRw8MolyWL3aOo9NtDrE69mvNRMyRPElmDEBnuit8cubX
 xnDcMvFVIDwpJ8/NpEoG/YzPSs0Z17S3jkwRQTLK0Bh650HXKOTWY
X-Gm-Gg: ASbGncvQVk9TYiL+KArtmOLCYJeo8f4GWPpJAcnRhzCBGzbO1FwfmWVvc9Ai0xiURsN
 zPjXj5MaDn7//+0G3wzrFAbOXXJnvoQBPU5nPR+4L7wLmR5OgHwJGxkNSL6r1trv5IJCxlHzpBQ
 PtM0rfb7K29vYp+R4zVQX/DNAGI9OQ7W/UEtH25/Dx1nU9+bKdQtN5oORw6SIEkiFoB/ei9QNlN
 RKLTTjNnahD2C1cAablvoVZySER8XVfcyZvIfwoyIwsJCGSBpzfVxpD3CN5f4qbC/XrUxoX8kVf
 Gdr2MxqXbRd52XGFZnUprACEbXz1Slu4Rw==
X-Received: by 2002:a5d:48c9:0:b0:386:2d40:a192 with SMTP id
 ffacd0b85a97d-38dea2d3487mr1182295f8f.34.1739348840816; 
 Wed, 12 Feb 2025 00:27:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEHqycS6MJEtTs/Rk46/uFlF5S4uAczKpvlHelTA40oAgJeWrRZgUvweon4bl0bx6Rzsxq9TQ==
X-Received: by 2002:a5d:48c9:0:b0:386:2d40:a192 with SMTP id
 ffacd0b85a97d-38dea2d3487mr1182282f8f.34.1739348840438; 
 Wed, 12 Feb 2025 00:27:20 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-37.web.vodafone.de. [109.42.48.37])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1aa6f7sm12241285e9.32.2025.02.12.00.27.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2025 00:27:20 -0800 (PST)
Message-ID: <678561c5-4d06-494a-b12c-6013b07f3b05@redhat.com>
Date: Wed, 12 Feb 2025 09:27:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 04/32] hw/timer/xilinx_timer: Make device endianness
 configurable
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20250210204204.54407-1-philmd@linaro.org>
 <20250210204204.54407-5-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250210204204.54407-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/02/2025 21.41, Philippe Mathieu-Daudé wrote:
> Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair
> of DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
> Add the "little-endian" property to select the device
> endianness, defaulting to little endian.
> Set the proper endianness for each machine using the device.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Message-Id: <20250206131052.30207-5-philmd@linaro.org>
> ---
>   hw/microblaze/petalogix_ml605_mmu.c      |  1 +
>   hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
>   hw/ppc/virtex_ml507.c                    |  1 +
>   hw/timer/xilinx_timer.c                  | 35 +++++++++++++++---------
>   4 files changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/microblaze/petalogix_ml605_mmu.c b/hw/microblaze/petalogix_ml605_mmu.c
> index cf3b9574db3..bbda70aa93b 100644
> --- a/hw/microblaze/petalogix_ml605_mmu.c
> +++ b/hw/microblaze/petalogix_ml605_mmu.c
> @@ -127,6 +127,7 @@ petalogix_ml605_init(MachineState *machine)
>   
>       /* 2 timers at irq 2 @ 100 Mhz.  */
>       dev = qdev_new("xlnx.xps-timer");
> +    qdev_prop_set_bit(dev, "little-endian", true);
>       qdev_prop_set_uint32(dev, "one-timer-only", 0);
>       qdev_prop_set_uint32(dev, "clock-frequency", 100 * 1000000);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> index fbf52ba8f2f..9d4316b4036 100644
> --- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
> +++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> @@ -114,6 +114,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
>   
>       /* 2 timers at irq 2 @ 62 Mhz.  */
>       dev = qdev_new("xlnx.xps-timer");
> +    qdev_prop_set_bit(dev, "little-endian", !TARGET_BIG_ENDIAN);
>       qdev_prop_set_uint32(dev, "one-timer-only", 0);
>       qdev_prop_set_uint32(dev, "clock-frequency", 62 * 1000000);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index 23238119273..f87c221d076 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -230,6 +230,7 @@ static void virtex_init(MachineState *machine)
>   
>       /* 2 timers at irq 2 @ 62 Mhz.  */
>       dev = qdev_new("xlnx.xps-timer");
> +    qdev_prop_set_bit(dev, "little-endian", false);
>       qdev_prop_set_uint32(dev, "one-timer-only", 0);
>       qdev_prop_set_uint32(dev, "clock-frequency", 62 * 1000000);
>       sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);

  Hi,

with this patch applied, the ppc_virtex_ml507 functional test is now failing 
for me ... could you please double-check whether "make check-functional-ppc" 
still works for you?

  Thanks,
   Thomas


