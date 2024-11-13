Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED32ED637A4
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 18:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBHzR-0004u8-LL; Wed, 13 Nov 2024 13:21:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBHzQ-0004tz-EX
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:21:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBHzO-0002Py-Fw
 for qemu-devel@nongnu.org; Wed, 13 Nov 2024 13:21:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731522073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=B163VpaRJXxp3b2iqYNrwHU/NDgSITNT/KiNnMB0IkU=;
 b=LsPDXANoDp57/h0+djePtmo1fJy0hMYacowUdmE4iwsX+ph1iqkwfHsjwG9uo10wg3z5Pt
 aNMIpGV0CqQ05F5ufFg+YVKDPvITYT6N9GFGsn4Fwo5CLofVido5Ol8sQKJ1NtD0rspocY
 Gfh033rDx9RK7fwPkBd9rfHuk+i1dsA=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-sy1bvkv7PH2e9Yr3Eh1NSQ-1; Wed, 13 Nov 2024 13:21:10 -0500
X-MC-Unique: sy1bvkv7PH2e9Yr3Eh1NSQ-1
X-Mimecast-MFC-AGG-ID: sy1bvkv7PH2e9Yr3Eh1NSQ
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-53da4315990so260428e87.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2024 10:21:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731522068; x=1732126868;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B163VpaRJXxp3b2iqYNrwHU/NDgSITNT/KiNnMB0IkU=;
 b=Ll9rF0680Zn71/RaU+Rt4he+XK9bTCSyC7T3UZg9FYXMLLMzuzVnoSEGeZFSOH47jJ
 ofWmrGxtvgG0GT1A1Gs7BFCw2n2oXdHxT5KUqDleLt/MdESnrgle+ksb497OtDZmZEL2
 8IFfAJGMsdefo8kwew4Ft5IBwxV5gjbc2P9squcJ0xwY21Zs4wC1VdXAJLnmqQPg0RDr
 nmNreo9AhJDY6Ly8Is6/81Ie0o9UjpJh8FcJ4vl8ZMrudu85M5pnRlI1GmOAYYgPRo67
 cgVDYLk7Z/4Jeseil8C+Cyfij0QNNqjUJHkfBsrpMj330dCE5OmMDNbQM2fM2Nctg9+O
 vo6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJqRivnDLs1ClMK1IkjaVKzKCwo83t+VRQFI4wrkYS/Tvt8ufV0PpnRT9VesfiAixQ9EDlDobW2NyA@nongnu.org
X-Gm-Message-State: AOJu0YyIZnvqPjf6seMZS+TLQgby2HYxqy7WSBwDoz7dXReXszCiil9V
 /vky6u/6K4J8nEp31AxCblvItoXqVP3iThTVxDjYURVcaOO+Ox3YEMq8n2RT3Z8SiYgHatt+pQw
 31tcVUYc5TV1g7nmBBpfWBxt7B+Zf27SRWpz1S+FhDh8WtvmoMVyG
X-Received: by 2002:a05:6512:3a88:b0:536:a6c6:33f with SMTP id
 2adb3069b0e04-53d862bb481mr10575544e87.13.1731522068306; 
 Wed, 13 Nov 2024 10:21:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGU6RcZJh/stvdvJj7BnrRRLy7n9hpCucCMPjhpTqNOETEY4/ZTyAjheZR6bbneoxly6hcFwA==
X-Received: by 2002:a05:6512:3a88:b0:536:a6c6:33f with SMTP id
 2adb3069b0e04-53d862bb481mr10575516e87.13.1731522067790; 
 Wed, 13 Nov 2024 10:21:07 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-432d54f75f9sm32575485e9.17.2024.11.13.10.21.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Nov 2024 10:21:07 -0800 (PST)
Message-ID: <5a3d70f5-e135-4450-aed4-eac03abc58c0@redhat.com>
Date: Wed, 13 Nov 2024 19:21:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/20] hw/net/xilinx_ethlite: Map the RAM buffer as RAM
 memory region
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Gustavo Romero <gustavo.romero@linaro.org>
References: <20241112181044.92193-1-philmd@linaro.org>
 <20241112181044.92193-20-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241112181044.92193-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.738,
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

On 11/12/24 19:10, Philippe Mathieu-Daudé wrote:
> Rather than using I/O registers for RAM buffer, having to
> swap endianness back and forth (because the core memory layer
> automatically swaps endiannes for us), declare the buffers
> as RAM regions. Remove the now unused s->regs[] array.
> 
> The memory flat view becomes:
> 
>    FlatView #0
>     Root memory region: system
>      0000000081000000-00000000810007f3 (prio 0, ram): ethlite.tx[0]buf
>      00000000810007f4-00000000810007ff (prio 0, i/o): ethlite.tx[0]io
>      0000000081000800-0000000081000ff3 (prio 0, ram): ethlite.tx[1]buf
>      0000000081000ff4-0000000081000fff (prio 0, i/o): ethlite.tx[1]io
>      0000000081001000-00000000810017f3 (prio 0, ram): ethlite.rx[0]buf
>      00000000810017fc-00000000810017ff (prio 0, i/o): ethlite.rx[0]io
>      0000000081001800-0000000081001ff3 (prio 0, ram): ethlite.rx[1]buf
>      0000000081001ffc-0000000081001fff (prio 0, i/o): ethlite.rx[1]io

The receive buffers should end at 7fb and ffb; no need to repost of course.

Paolo

> 
> Mention the device datasheet in the file header.
> 
> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/net/xilinx_ethlite.c | 79 +++++++++++------------------------------
>   1 file changed, 20 insertions(+), 59 deletions(-)
> 
> diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
> index f681b91769..da453465ca 100644
> --- a/hw/net/xilinx_ethlite.c
> +++ b/hw/net/xilinx_ethlite.c
> @@ -2,6 +2,10 @@
>    * QEMU model of the Xilinx Ethernet Lite MAC.
>    *
>    * Copyright (c) 2009 Edgar E. Iglesias.
> + * Copyright (c) 2024 Linaro, Ltd
> + *
> + * DS580: https://docs.amd.com/v/u/en-US/xps_ethernetlite
> + * LogiCORE IP XPS Ethernet Lite Media Access Controller
>    *
>    * Permission is hereby granted, free of charge, to any person obtaining a copy
>    * of this software and associated documentation files (the "Software"), to deal
> @@ -27,7 +31,6 @@
>   #include "qemu/bitops.h"
>   #include "qom/object.h"
>   #include "qapi/error.h"
> -#include "exec/tswap.h"
>   #include "hw/sysbus.h"
>   #include "hw/irq.h"
>   #include "hw/qdev-properties.h"
> @@ -46,7 +49,6 @@
>   #define A_RX_BASE0    0x17fc
>   #define R_RX_BUF1     (0x1800 / 4)
>   #define A_RX_BASE1    0x1ffc
> -#define R_MAX         (0x2000 / 4)
>   
>   #define RX_BUFSZ_MAX  0x07e0
>   
> @@ -72,6 +74,8 @@ typedef struct XlnxXpsEthLitePort
>   {
>       MemoryRegion txio;
>       MemoryRegion rxio;
> +    MemoryRegion txbuf;
> +    MemoryRegion rxbuf;
>   
>       struct {
>           uint32_t tx_len;
> @@ -100,7 +104,6 @@ struct XlnxXpsEthLite
>   
>       UnimplementedDeviceState mdio;
>       XlnxXpsEthLitePort port[2];
> -    uint32_t regs[R_MAX];
>   };
>   
>   static inline void eth_pulse_irq(XlnxXpsEthLite *s)
> @@ -118,16 +121,12 @@ static unsigned addr_to_port_index(hwaddr addr)
>   
>   static void *txbuf_ptr(XlnxXpsEthLite *s, unsigned port_index)
>   {
> -    unsigned int rxbase = port_index * (0x800 / 4);
> -
> -    return &s->regs[rxbase + R_TX_BUF0];
> +    return memory_region_get_ram_ptr(&s->port[port_index].txbuf);
>   }
>   
>   static void *rxbuf_ptr(XlnxXpsEthLite *s, unsigned port_index)
>   {
> -    unsigned int rxbase = port_index * (0x800 / 4);
> -
> -    return &s->regs[rxbase + R_RX_BUF0];
> +    return memory_region_get_ram_ptr(&s->port[port_index].rxbuf);
>   }
>   
>   static uint64_t port_tx_read(void *opaque, hwaddr addr, unsigned int size)
> @@ -252,53 +251,6 @@ static const MemoryRegionOps eth_portrx_ops = {
>           },
>   };
>   
> -static uint64_t
> -eth_read(void *opaque, hwaddr addr, unsigned int size)
> -{
> -    XlnxXpsEthLite *s = opaque;
> -    uint32_t r = 0;
> -
> -    addr >>= 2;
> -
> -    switch (addr)
> -    {
> -        default:
> -            r = tswap32(s->regs[addr]);
> -            break;
> -    }
> -    return r;
> -}
> -
> -static void
> -eth_write(void *opaque, hwaddr addr,
> -          uint64_t val64, unsigned int size)
> -{
> -    XlnxXpsEthLite *s = opaque;
> -    uint32_t value = val64;
> -
> -    addr >>= 2;
> -    switch (addr)
> -    {
> -        default:
> -            s->regs[addr] = tswap32(value);
> -            break;
> -    }
> -}
> -
> -static const MemoryRegionOps eth_ops = {
> -    .read = eth_read,
> -    .write = eth_write,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> -    .impl = {
> -        .min_access_size = 4,
> -        .max_access_size = 4,
> -    },
> -    .valid = {
> -        .min_access_size = 4,
> -        .max_access_size = 4
> -    }
> -};
> -
>   static bool eth_can_rx(NetClientState *nc)
>   {
>       XlnxXpsEthLite *s = qemu_get_nic_opaque(nc);
> @@ -354,6 +306,9 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
>   {
>       XlnxXpsEthLite *s = XILINX_ETHLITE(dev);
>   
> +    memory_region_init(&s->mmio, OBJECT(dev),
> +                       "xlnx.xps-ethernetlite", 0x2000);
> +
>       object_initialize_child(OBJECT(dev), "ethlite.mdio", &s->mdio,
>                              TYPE_UNIMPLEMENTED_DEVICE);
>       qdev_prop_set_string(DEVICE(&s->mdio), "name", "ethlite.mdio");
> @@ -363,6 +318,10 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
>                               sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mdio), 0));
>   
>       for (unsigned i = 0; i < 2; i++) {
> +        memory_region_init_ram(&s->port[i].txbuf, OBJECT(dev),
> +                               i ? "ethlite.tx[1]buf" : "ethlite.tx[0]buf",
> +                               0x07f4, &error_abort);
> +        memory_region_add_subregion(&s->mmio, 0x0800 * i, &s->port[i].txbuf);
>           memory_region_init_io(&s->port[i].txio, OBJECT(dev),
>                                 &eth_porttx_ops, s,
>                                 i ? "ethlite.tx[1]io" : "ethlite.tx[0]io",
> @@ -370,6 +329,11 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
>           memory_region_add_subregion(&s->mmio, i ? A_TX_BASE1 : A_TX_BASE0,
>                                       &s->port[i].txio);
>   
> +        memory_region_init_ram(&s->port[i].rxbuf, OBJECT(dev),
> +                               i ? "ethlite.rx[1]buf" : "ethlite.rx[0]buf",
> +                               0x07f4, &error_abort);
> +        memory_region_add_subregion(&s->mmio, 0x1000 + 0x0800 * i,
> +                                    &s->port[i].rxbuf);
>           memory_region_init_io(&s->port[i].rxio, OBJECT(dev),
>                                 &eth_portrx_ops, s,
>                                 i ? "ethlite.rx[1]io" : "ethlite.rx[0]io",
> @@ -390,9 +354,6 @@ static void xilinx_ethlite_init(Object *obj)
>       XlnxXpsEthLite *s = XILINX_ETHLITE(obj);
>   
>       sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
> -
> -    memory_region_init_io(&s->mmio, obj, &eth_ops, s,
> -                          "xlnx.xps-ethernetlite", R_MAX * 4);
>       sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
>   }
>   


