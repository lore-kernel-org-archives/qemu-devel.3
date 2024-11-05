Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14047D40CE0
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 23:17:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SmT-00038n-8w; Tue, 05 Nov 2024 18:16:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1t8SmQ-000376-8O; Tue, 05 Nov 2024 18:16:10 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1t8SmM-0002E4-Iq; Tue, 05 Nov 2024 18:16:09 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4315eac969aso1595095e9.1; 
 Tue, 05 Nov 2024 15:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730848564; x=1731453364; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zscit44dK30D2dB26XkJD5zmW7H58nCSFWwIyxhXmtE=;
 b=VCVXiF5EfQ3apY1NqRU3BdQdcvc0/6jivOfu4Gb0EWaC5Bh1rijXB37nJWT2n3FnZC
 HEBHkpNCP7Sg7l14G+vcTm0f5BuBtCPJihWL8DhP4e12pHQhF4med7w+fIr5zKdxlqEA
 N6D5oEzEkcgVF7+9sExrZnI8zPGAG8aXRHsY5uOp35ACnnI5iB2nf1zgHiYnfQe76drS
 v+nb9PSTLTc0Hh2a6ywOET1DTonK/wJqhrNKHJoISbX0xtBI7OeaoTYEHy91RYHFrjAf
 iy0vdVR1eZxAv9QJQwIzIcb0eygGFAuT5G50TRs/lWlAQX9iC9ARbb34YvSRpe6b2KZc
 HF6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730848564; x=1731453364;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zscit44dK30D2dB26XkJD5zmW7H58nCSFWwIyxhXmtE=;
 b=bcUUv4KtVPn10X03Udjoxyas8jD0i7cOuudMruzsmhQENyISjENpCkhK7vHUt4pc6F
 h0bHhnhhuqsDreseVgRwz7pxkP3BMc5JS7jVyGSZi9dESs1pYethM5u+3bQLZfGl5+8k
 R2YRtT7fbu+6P4r4pxFEInPMOfZr29mC5E4B33WZO9azv9W4eTrqj91FxRQCmVWmVp2a
 37rCUqk569/Zbecg+SaT+WutA7Yv0fEv1kxuZNgZXlWTBUp715zyMSjLtilxEPyzF+/2
 GnTp676nHH3JlO7rzHapL+18XsdZPEcVbEF7fXNLtn06UtE4XZNRZploxyAuCvT/s3oI
 1r9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUi3NF448a4DcVY4H4Gfzo/En+oirtmMSZRIh4/UMYsposjdDW5KpN+YsiaarhYA3V/2eNr0dV5LQ==@nongnu.org
X-Gm-Message-State: AOJu0YxfxUSw7NKkW7C8GY2z/YkgLf/J3wrY6CLWK+Do2YbrSNQi2cU1
 kKnndtDkoJucEmiY2c+6TERdmsABaTRuQpYK+ImDXsFo6V/HAoGPO6wo3JmMI24=
X-Google-Smtp-Source: AGHT+IEbFrjRSeNoTGgU63B+I1IZ0nAb7wmmDDBRGAttVwAnw9snz+KJZHDfOLPWvohHAGymJIesqA==
X-Received: by 2002:a05:600c:3c82:b0:42c:b826:a26c with SMTP id
 5b1f17b1804b1-432a9a9b03amr3406365e9.8.1730848563594; 
 Tue, 05 Nov 2024 15:16:03 -0800 (PST)
Received: from gmail.com ([89.101.60.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6b62b4sm1619845e9.17.2024.11.05.15.16.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 15:16:03 -0800 (PST)
Date: Wed, 6 Nov 2024 00:16:02 +0100
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
Subject: Re: [PATCH 12/19] hw/net/xilinx_ethlite: Only expect big-endian
 accesses
Message-ID: <ZyqnMsZxpdn4EgTY@zapote>
References: <20241105130431.22564-1-philmd@linaro.org>
 <20241105130431.22564-13-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241105130431.22564-13-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-wm1-x32e.google.com
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

On Tue, Nov 05, 2024 at 02:04:24PM +0100, Philippe Mathieu-Daudé wrote:
> The Xilinx 'ethlite' device was added in commit b43848a100
> ("xilinx: Add ethlite emulation"), being only built back
> then for a big-endian MicroBlaze target (see commit 72b675caac
> "microblaze: Hook into the build-system").
> 
> I/O endianness access was then clarified in commit d48751ed4f
> ("xilinx-ethlite: Simplify byteswapping to/from brams"). Here
> the 'fix' was to use tswap32(). Since the machine was built as
> big-endian target, tswap32() use means the fix was for a little
> endian host. While the datasheet (reference added in file header)
> is not precise about it, we interpret such change as the device
> expects accesses in big-endian order. Besides, this is what other
> Xilinx/MicroBlaze devices use (see the 3 previous commits).
> 
> Correct the MemoryRegionOps endianness. Add a 'access-little-endian'
> property, so if the bus access expect little-endian order we swap
> the values. Replace the tswap32() calls accordingly.
> 
> Set the property on the single machine using this device.


I think you're partially correct but not fully. This buffer area is
really a RAM and has no endianess. Problem is back then I don't think
I was a ware of a way to map RAM memory sub regions so we hacked in
byteswaps to swap from host (which usually was little endian) to
big endian. This is because register accesses from CPU to device model
are kept in host endianess. I think the right way to solve this issue
is to map a RAM memory region to represent the BRAM.

Cheers,
Edgar


> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/microblaze/petalogix_s3adsp1800_mmu.c |  1 +
>  hw/net/xilinx_ethlite.c                  | 20 ++++++++++++++++----
>  2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> index 8110be83715..8407dbee12a 100644
> --- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
> +++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> @@ -123,6 +123,7 @@ petalogix_s3adsp1800_init(MachineState *machine)
>      qemu_configure_nic_device(dev, true, NULL);
>      qdev_prop_set_uint32(dev, "tx-ping-pong", 0);
>      qdev_prop_set_uint32(dev, "rx-ping-pong", 0);
> +    qdev_prop_set_bit(dev, "access-little-endian", !TARGET_BIG_ENDIAN);
>      sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ETHLITE_BASEADDR);
>      sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[ETHLITE_IRQ]);
> diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
> index ede7c172748..44ef11ebf89 100644
> --- a/hw/net/xilinx_ethlite.c
> +++ b/hw/net/xilinx_ethlite.c
> @@ -3,6 +3,9 @@
>   *
>   * Copyright (c) 2009 Edgar E. Iglesias.
>   *
> + * DS580: https://docs.amd.com/v/u/en-US/xps_ethernetlite
> + * LogiCORE IP XPS Ethernet Lite Media Access Controller
> + *
>   * Permission is hereby granted, free of charge, to any person obtaining a copy
>   * of this software and associated documentation files (the "Software"), to deal
>   * in the Software without restriction, including without limitation the rights
> @@ -25,7 +28,6 @@
>  #include "qemu/osdep.h"
>  #include "qemu/module.h"
>  #include "qom/object.h"
> -#include "exec/tswap.h"
>  #include "hw/sysbus.h"
>  #include "hw/irq.h"
>  #include "hw/qdev-properties.h"
> @@ -65,6 +67,7 @@ struct xlx_ethlite
>      NICState *nic;
>      NICConf conf;
>  
> +    bool access_little_endian;
>      uint32_t c_tx_pingpong;
>      uint32_t c_rx_pingpong;
>      unsigned int txbuf;
> @@ -103,9 +106,12 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
>              break;
>  
>          default:
> -            r = tswap32(s->regs[addr]);
> +            r = s->regs[addr];
>              break;
>      }
> +    if (s->access_little_endian) {
> +        bswap32s(&r);
> +    }
>      return r;
>  }
>  
> @@ -117,6 +123,10 @@ eth_write(void *opaque, hwaddr addr,
>      unsigned int base = 0;
>      uint32_t value = val64;
>  
> +    if (s->access_little_endian) {
> +        bswap32s(&value);
> +    }
> +
>      addr >>= 2;
>      switch (addr) 
>      {
> @@ -161,7 +171,7 @@ eth_write(void *opaque, hwaddr addr,
>              break;
>  
>          default:
> -            s->regs[addr] = tswap32(value);
> +            s->regs[addr] = value;
>              break;
>      }
>  }
> @@ -169,7 +179,7 @@ eth_write(void *opaque, hwaddr addr,
>  static const MemoryRegionOps eth_ops = {
>      .read = eth_read,
>      .write = eth_write,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .endianness = DEVICE_BIG_ENDIAN,
>      .impl = {
>          .min_access_size = 4,
>          .max_access_size = 4,
> @@ -256,6 +266,8 @@ static void xilinx_ethlite_init(Object *obj)
>  }
>  
>  static Property xilinx_ethlite_properties[] = {
> +    DEFINE_PROP_BOOL("access-little-endian", struct xlx_ethlite,
> +                     access_little_endian, false),
>      DEFINE_PROP_UINT32("tx-ping-pong", struct xlx_ethlite, c_tx_pingpong, 1),
>      DEFINE_PROP_UINT32("rx-ping-pong", struct xlx_ethlite, c_rx_pingpong, 1),
>      DEFINE_NIC_PROPERTIES(struct xlx_ethlite, conf),
> -- 
> 2.45.2
> 

