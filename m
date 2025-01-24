Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79963C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 18:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbO64-0000ob-Tl; Fri, 24 Jan 2025 13:08:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbO63-0000oE-3Q
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 13:07:59 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbO61-0006gN-CN
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 13:07:58 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-38633b5dbcfso2760693f8f.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 10:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737742074; x=1738346874; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WNERd4jKTwPNcA84P3Bwla00gQ/OilA9Jp70Zf8lLsY=;
 b=ggTZdJ/oYsLW4rzC0fujn8KuegnSfV6FXfLik3nsXF7FivxszQDqTnh4VbE9bnAe87
 EB98X6PqND0C79AXT64bP6fLF2pLCkgg3TsiWJr1rFdrDVR0jmlyTjkauXWKC3pBPLrk
 j2p6R6DCEUM7jmCSyiukngkXampLZfTv61PJsxTzK5kD++H0ih/p8ItKYWZk9in+NrMO
 G883fk4fJr16OJBaZ8glsJzI/2mrcfUvzPn4caJY1nPc4+UfUfA1Js2nu7XNa/FA3pqy
 xHvx57yhJG+ddECzasApspB5y70B54eQEVsKQZKTH5j+VBj5C6FCYYHRo4Ms44GGv9B/
 TW/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737742074; x=1738346874;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WNERd4jKTwPNcA84P3Bwla00gQ/OilA9Jp70Zf8lLsY=;
 b=SJsntEEOoAglQoLiMsFWY76NIgcIBknwlo/NTlR9/7CdXSAtr5RJVBdNNjabDVbsaF
 fSm7lLwXNOhbr15Z6A60CKWupJKvG9Q0EUYTaQjPs5E891Lnj+5Ww1ABj2VTZM/K2VDr
 Zp26l/2VYfntMmUvl1E34PVtgna99Qz/RbvcPtfWlfpxY1DVToal4iPzedrQIAIvmUpq
 oxBPzCTBDS590Z3DxUw/iRV1PsCzSOduwAy1Gu7899GdKOEsIICnK182rV5JEhmMGWlY
 h+miFElikwDYPP/nMLdebiTd4NtQ69xhjzJjrSFZ0ZCwoKskHRbMcemXmTx7uULGziSY
 QLYg==
X-Gm-Message-State: AOJu0YzFzKtW3DpA3RunFUgh6tWB3z9WgiW+L15rKG//9kOHuEUNZWJK
 xeicPgQDreRAlWvaACUTAE0A7K9FRvNsfgm365StrmvrxC4wHZSiabiN3aCi6Mgw7SLwat1hsxG
 Y4Zc=
X-Gm-Gg: ASbGnctVHw35rsbgCV35gMGz31mXMKA8ylMsCj1BO+y32lN3HeLQOPd0YZvPf4tnQyZ
 7qdZ3naZ95x2zr9ggT/Ma79X8MLrmThxcpy+N19u556EwOiKU/QsLuPpxw5n3Gpc4WCYWshowjt
 lWtNVG+Gslhh0S5eeX6qh+35IyqlezYz2VKACYU0poZs9EX5YVcjBOUK2LZ8vMv3A3fTRgYpWZ9
 AzNv4k/jswYbX8VurnIVuw4a85b1SkjyVoakRnmB+4Vua5ghMJer4L695JjRkoJnRlAjHM2kO2y
 IXU4L4SygjjWfM9T9rhjZbQxyejJul2wB7ylz1YLB3/uHivx
X-Google-Smtp-Source: AGHT+IHDteRmkvPbJoQ8jiCugxCjDDZ+q5YSr2filV7UJJNXbgcKWM0E7ZsTlaq5r3QVBsJ0b4yhIA==
X-Received: by 2002:a5d:59a3:0:b0:382:4b9a:f51f with SMTP id
 ffacd0b85a97d-38bf57bd650mr31133158f8f.47.1737742074226; 
 Fri, 24 Jan 2025 10:07:54 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a17650esm3402763f8f.12.2025.01.24.10.07.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Jan 2025 10:07:53 -0800 (PST)
Message-ID: <3f15447a-4dec-4855-8bbb-3beb14e4c97f@linaro.org>
Date: Fri, 24 Jan 2025 19:07:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/char/sh_serial: Convert to TypeInfo
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20250124175053.74461-1-philmd@linaro.org>
 <20250124175053.74461-3-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250124175053.74461-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 24/1/25 18:50, Philippe Mathieu-Daudé wrote:
> QOM types are now registered using as TypeInfo via DEFINE_TYPES()
> or type_init(). Update TYPE_SH_SERIAL, removing the empty QOM
> instance_init/finalize handlers.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/char/sh_serial.c | 23 +++++++++++------------
>   1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/char/sh_serial.c b/hw/char/sh_serial.c
> index 29ac9f9e5e7..b1db91656fe 100644
> --- a/hw/char/sh_serial.c
> +++ b/hw/char/sh_serial.c
> @@ -78,10 +78,6 @@ struct SHSerialState {
>       qemu_irq bri;
>   };
>   
> -typedef struct {} SHSerialStateClass;

Note this structure was buggy, as it should have embedded its parent...

   struct SHSerialStateClass {
     SysBusDeviceClass parent_class;
     ...
   };

> -
> -OBJECT_DEFINE_TYPE(SHSerialState, sh_serial, SH_SERIAL, SYS_BUS_DEVICE)
> -
>   static void sh_serial_clear_fifo(SHSerialState *s)
>   {
>       memset(s->rx_fifo, 0, SH_RX_FIFO_LENGTH);
> @@ -443,14 +439,6 @@ static void sh_serial_unrealize(DeviceState *dev)
>       timer_del(&s->fifo_timeout_timer);
>   }
>   
> -static void sh_serial_init(Object *obj)
> -{
> -}
> -
> -static void sh_serial_finalize(Object *obj)
> -{
> -}
> -
>   static const Property sh_serial_properties[] = {
>       DEFINE_PROP_CHR("chardev", SHSerialState, chr),
>       DEFINE_PROP_UINT8("features", SHSerialState, feat, 0),
> @@ -467,3 +455,14 @@ static void sh_serial_class_init(ObjectClass *oc, void *data)
>       /* Reason: part of SuperH CPU/SoC, needs to be wired up */
>       dc->user_creatable = false;
>   }
> +
> +static const TypeInfo sh_serial_types[] = {
> +    {
> +        .name           = TYPE_SH_SERIAL,
> +        .parent         = TYPE_SYS_BUS_DEVICE,
> +        .instance_size  = sizeof(SHSerialState),
> +        .class_init     = sh_serial_class_init,
> +    },
> +};
> +
> +DEFINE_TYPES(sh_serial_types)


