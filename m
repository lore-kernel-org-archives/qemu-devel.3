Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777BFC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 17:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcqXY-0005TN-C7; Wed, 21 Feb 2024 12:37:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcqXS-0005SU-Bt
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:37:47 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcqXQ-00032E-F0
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 12:37:45 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-33d509c5706so2217690f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 09:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708537060; x=1709141860; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l48eRUfXjKDzXhAMlr3Ke0C/zNt7CtxuBSFFxpDPl3g=;
 b=HoPx7VVrxzvzy6dse9EPimrY5IiNCdEhIBhM9CUJxSqORiGY7f2iPMXVvGsY90ls+A
 zlqETjLZn/xgtFFTdkOrI2lySFMOmF1F+9uVH/afgGq3h9cFrtP8WF2yZbWF6wGNsdJe
 5ddiVgaVfHSAtZskJHnMhBWD+Vv19DwTD6IKQA8mWQz+05nFeLEQfT/lLD1542gSoHnk
 Gvog8wl+F98pPxkdeML/H9Y3gh24F8dC6tiRI1Q7pDt4P53TDkL35qbWApOJQb4RNtuh
 mrRvYQUIZso5OS1eCE94K4fQ2ezVwfgNQ5fIjIqgkeKUpKEPAFFdqh/0eoDhHLhVvooo
 JvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708537060; x=1709141860;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l48eRUfXjKDzXhAMlr3Ke0C/zNt7CtxuBSFFxpDPl3g=;
 b=iYoWkCKopYFmZndUQcWr+69NHLDB78md7ROGCejLboUVAW8hPemOg6WIzz47Jk5js7
 eJrMGRfXa/ul5wFcX+9lmHEZpd8qvFTFeUVrcYbXcMEMTqnblDIR8EDazJZJwXmFYjEY
 v9LkMKffMCjIDYz23b9lJ2C/QBqf6b3UIymWcMOGnl4yHnmTVgVxldAfSPSdwrcDx2tO
 PZ8lDrTjx4QOMabFKW2nu/tit6jRmUzxlf0Yn5LoRdsXTXppvpqXvCceIpRo102WEcWQ
 MXTfvuPVaVd2legohYMid5pH+cMu0ZV9nKOh2tC7W+aLvsDNQ0aUCblfaMlHoxJjHmqT
 jWpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrhpheR7oL2aevGuVOE25ecmloPpMTKXk0lrXaxO4sBXzwK5lJBYxqyqx5Q+l56kIaoR7kIDJG6fuJXBsNFQWL3+ycPUs=
X-Gm-Message-State: AOJu0YyeIzfVt8ddLQsW85oAYLctdHidnuUAG8pSwjsRzVYH1d01sPkT
 tT+hPx7xrGf6+N0sQBEnx6XYYLYIK8TcOxfqaiHyaZZARr+S6VA58VlRPiOnIk0=
X-Google-Smtp-Source: AGHT+IEq1k6+sth6krJGIPmfCvhApo/Y1KOjCet3kinWywFYD3DKFbRx7+f9AuxIHIHfyrni6Fa2GQ==
X-Received: by 2002:adf:ef8f:0:b0:33d:277b:1ef3 with SMTP id
 d15-20020adfef8f000000b0033d277b1ef3mr7887953wro.38.1708537060594; 
 Wed, 21 Feb 2024 09:37:40 -0800 (PST)
Received: from [192.168.69.100] ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 e6-20020adfa446000000b0033d76a5bec1sm3378760wra.15.2024.02.21.09.37.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 09:37:39 -0800 (PST)
Message-ID: <dd01fc4b-e522-44d0-9082-766866f42196@linaro.org>
Date: Wed, 21 Feb 2024 18:37:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hw/i386/pc: Inline i8042_setup_a20_line() and remove
 it
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost
 <eduardo@habkost.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>
References: <20240218131701.91132-1-shentey@gmail.com>
 <20240218131701.91132-5-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240218131701.91132-5-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 18/2/24 14:17, Bernhard Beschow wrote:
> This function is used once in the pc machines. Remove it since it contains one
> line only.

Now reminds me of 
https://lore.kernel.org/qemu-devel/20211218130437.1516929-6-f4bug@amsat.org/

> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/input/i8042.h | 1 -
>   hw/i386/pc.c             | 2 +-
>   hw/input/pckbd.c         | 5 -----
>   3 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/include/hw/input/i8042.h b/include/hw/input/i8042.h
> index 9fb3f8d787..e90f008b66 100644
> --- a/include/hw/input/i8042.h
> +++ b/include/hw/input/i8042.h
> @@ -89,7 +89,6 @@ struct MMIOKBDState {
>   
>   
>   void i8042_isa_mouse_fake_event(ISAKBDState *isa);
> -void i8042_setup_a20_line(ISADevice *dev, qemu_irq a20_out);
>   
>   static inline bool i8042_present(void)
>   {
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 8b601ea6cf..1b2077dc32 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1195,7 +1195,7 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl,
>       }
>   
>       a20_line = qemu_allocate_irqs(handle_a20_line_change, first_cpu, 1);
> -    i8042_setup_a20_line(i8042, a20_line[0]);
> +    qdev_connect_gpio_out_named(DEVICE(i8042), I8042_A20_LINE, 0, a20_line[0]);
>       g_free(a20_line);
>   }
>   
> diff --git a/hw/input/pckbd.c b/hw/input/pckbd.c
> index 90a4d9eb40..74f10b640f 100644
> --- a/hw/input/pckbd.c
> +++ b/hw/input/pckbd.c
> @@ -777,11 +777,6 @@ void i8042_isa_mouse_fake_event(ISAKBDState *isa)
>       ps2_mouse_fake_event(&s->ps2mouse);
>   }
>   
> -void i8042_setup_a20_line(ISADevice *dev, qemu_irq a20_out)
> -{
> -    qdev_connect_gpio_out_named(DEVICE(dev), I8042_A20_LINE, 0, a20_out);
> -}
> -
>   static const VMStateDescription vmstate_kbd_isa = {
>       .name = "pckbd",
>       .version_id = 3,


