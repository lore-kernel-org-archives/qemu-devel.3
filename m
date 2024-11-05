Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EC2D40CE8
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 23:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SXj-0004rm-Pr; Tue, 05 Nov 2024 18:01:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1t8SXZ-0004rG-4E; Tue, 05 Nov 2024 18:00:49 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1t8SXX-0007BF-LI; Tue, 05 Nov 2024 18:00:48 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4319399a411so51359995e9.2; 
 Tue, 05 Nov 2024 15:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730847646; x=1731452446; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3ZueUSgtUlRwc3EWENhG8LW3cQMqrZh9FH7+l6LOEHg=;
 b=gnLXkbxiRCMivHb3LhkdXrZkds8BQTct/eaB9G4D0pYeBCbRm0FTmT/lYgRc6UJkbb
 KeRjwcZA/YfDNzJ64wu62gWHO33ktYMxu/49jYSbkXeDq3MAdP3rVVrGPyT3MynKOj+t
 /FhBDhdgPIQlKhORFJtQR736C8MDfl0gZn6bNPgjVzg8Cbku6WnE1b4DyNZb1Slbj50M
 e6gGIR+cnUUe/Y+3Ki9RA8ihGd8ubt9EMAjuzq+2g8YFf16aL3hVlU79WZM325MWdczS
 nTzaio+0MOcSODNR424wGDtH64KkHvGJu6q/JDYuuIJwPf0/6iaa1S0s6VRulpEztL/q
 qqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730847646; x=1731452446;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3ZueUSgtUlRwc3EWENhG8LW3cQMqrZh9FH7+l6LOEHg=;
 b=qmlMcjw83NCcp88l2iCo6+HKDl9cUKRR+76ZAMhuiSJFY+PPrTb8tNu9pRQe134LDP
 PzoCrV01ex0yp0mkCb7vyc814Q8XHYNHDmi/SkGwcQiho8U1EKvxCtGhfkgHmVbPgH2K
 gSrJII6vMYz50Avq2IobLxq6lqT6w5oA3RdBsL4Isn9J4MKLXnyh7xsaZ9mBMvn+33BX
 bf/mlDcsm3TQYGWQslRCmctF5mqJSWF6K/xRNGH32M3NWSqinblJjfDWdpfwpA7hkCoZ
 2kiph0DF6loeG2MaM8XTpB9mFT6/hUzFpVwVbF3fxwW+K6sSuqdVkKu536uZmDL0dQuM
 VsmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMP+IUZ8kY03l7xUC1Gicgje68nCLIqW1lk/2DNor71a0fTX5P0rZVcqyVj0b1Qxlm7nLeLjF/WA==@nongnu.org
X-Gm-Message-State: AOJu0YxM3SPl/oKQfy5Rk42YtFe09Dyu7SZJ6O3XeHw15XsUKmbFiY05
 pgWoNnu2apXsUItm14lMkUFMXXyUhCbiKEFgDNbBOHbFDzzlh3aJ
X-Google-Smtp-Source: AGHT+IHCypKS/1QotNh6W/Mhv4ETXFGeBAtInM5vwVfsfsQ/MiWVDTNb1MIEtFf9wcFfmc9qDRi5BA==
X-Received: by 2002:a05:600c:5490:b0:431:1a98:cb40 with SMTP id
 5b1f17b1804b1-4319acb8d51mr318432205e9.18.1730847645530; 
 Tue, 05 Nov 2024 15:00:45 -0800 (PST)
Received: from gmail.com ([89.101.60.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa5b5b2dsm1362255e9.1.2024.11.05.15.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 15:00:45 -0800 (PST)
Date: Wed, 6 Nov 2024 00:00:44 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 06/19] hw/microblaze: Fix MemoryRegionOps coding style
Message-ID: <ZyqjnB7m7wznwA9r@zapote>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-7-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241105130431.22564-7-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Nov 05, 2024 at 02:04:18PM +0100, Philippe Mathieu-Daudé wrote:
> Fix few MemoryRegionOps style before adding new fields
> in the following commits.

Wasn't aware of this style rule :-)

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/char/xilinx_uartlite.c | 4 ++--
>  hw/intc/xilinx_intc.c     | 4 ++--
>  hw/net/xilinx_ethlite.c   | 4 ++--
>  hw/timer/xilinx_timer.c   | 4 ++--
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/char/xilinx_uartlite.c b/hw/char/xilinx_uartlite.c
> index f325084f8b9..a69ad769cc4 100644
> --- a/hw/char/xilinx_uartlite.c
> +++ b/hw/char/xilinx_uartlite.c
> @@ -172,8 +172,8 @@ static const MemoryRegionOps uart_ops = {
>      .endianness = DEVICE_NATIVE_ENDIAN,
>      .valid = {
>          .min_access_size = 1,
> -        .max_access_size = 4
> -    }
> +        .max_access_size = 4,
> +    },
>  };
>  
>  static Property xilinx_uartlite_properties[] = {
> diff --git a/hw/intc/xilinx_intc.c b/hw/intc/xilinx_intc.c
> index 6e5012e66eb..2b8246f6206 100644
> --- a/hw/intc/xilinx_intc.c
> +++ b/hw/intc/xilinx_intc.c
> @@ -146,8 +146,8 @@ static const MemoryRegionOps pic_ops = {
>      .endianness = DEVICE_NATIVE_ENDIAN,
>      .valid = {
>          .min_access_size = 4,
> -        .max_access_size = 4
> -    }
> +        .max_access_size = 4,
> +    },
>  };
>  
>  static void irq_handler(void *opaque, int irq, int level)
> diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
> index bd812908085..11eb53c4d60 100644
> --- a/hw/net/xilinx_ethlite.c
> +++ b/hw/net/xilinx_ethlite.c
> @@ -172,8 +172,8 @@ static const MemoryRegionOps eth_ops = {
>      .endianness = DEVICE_NATIVE_ENDIAN,
>      .valid = {
>          .min_access_size = 4,
> -        .max_access_size = 4
> -    }
> +        .max_access_size = 4,
> +    },
>  };
>  
>  static bool eth_can_rx(NetClientState *nc)
> diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
> index 32a9df69e0b..0822345779c 100644
> --- a/hw/timer/xilinx_timer.c
> +++ b/hw/timer/xilinx_timer.c
> @@ -195,8 +195,8 @@ static const MemoryRegionOps timer_ops = {
>      .endianness = DEVICE_NATIVE_ENDIAN,
>      .valid = {
>          .min_access_size = 4,
> -        .max_access_size = 4
> -    }
> +        .max_access_size = 4,
> +    },
>  };
>  
>  static void timer_hit(void *opaque)
> -- 
> 2.45.2
> 

