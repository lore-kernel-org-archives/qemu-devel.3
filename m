Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A745AD462BF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2024 15:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBFJf-0001pO-G5; Wed, 13 Nov 2024 10:29:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBFJc-0001oT-Tj; Wed, 13 Nov 2024 10:29:56 -0500
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1tBFJb-0007kE-B8; Wed, 13 Nov 2024 10:29:56 -0500
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2fb3debdc09so55709981fa.3; 
 Wed, 13 Nov 2024 07:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731511793; x=1732116593; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Xk6iQY5Tzos1w+3jRuPSKFWckteHK/rsp3asRy597ug=;
 b=C2IDnKghpruKmLBH6dpqSFSzegy71eZzo7HoGARixnCC4RdomYUSPuD8ThepnJ/XvF
 kSLdNBWA0bqqHx+c+6GOkMV1fIv5lKuhBCgT7pyAcmhn3GrD9NphfBGRuLD0I4jYhW8e
 M6DqZ4H5YzXNJcr35SFF22eco+T2SlMw+7y9AFDczMHDCzp9bJjDZUW2OImUEyHcdT+5
 1ihyP7cq++6w/Pfmrd0o0n/HHAWwTBqbQb8OBYY0Y1i7t17TrltMCz+7HpFTjSfVw94s
 Wi8IcMt9/taWdj/AwpDnAIFQWSFS+0oH83Mqe3e8EBxuMsJifCnYQXtjQHZZ+rU3SlI6
 bTog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731511793; x=1732116593;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xk6iQY5Tzos1w+3jRuPSKFWckteHK/rsp3asRy597ug=;
 b=dROHsxfiFJNK0+vk3kpfM4tIOOXZAnJTe0Ub41rFirvS+r6TDJLpdV8F5cuBBVhJ8S
 jJ+KIwsEGseMONSjUtpX7fFNctXzFKB6U1zCYdeww1/kXJkiLqbsu9wsl8z/C7au8kMJ
 07EsMcU23QvsSWyduYdoLWDxEA+ttEz5YBuRjrhedXJZxtiHC0gS4EUqhOIL8wBHOwJR
 8FcRKDSWw8qO5UbmVN7bY5XnjwYWTcNblLLv4v5PyTNH/zpsZLXGKCCTOym0NIc4ok7i
 W8udUw7tWEs3n/mgW33yVbdUnNuMp1bBwURiJVSB+8SzBsCtMQ2MWubXsUK5eMOrLRpT
 P4tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2E6Bam8mD8MR/wc/nww9jrvB6DVMxMti65wU8ui3OnlabSm3RHJVlBjbkekgBzd83Rv7ZaizWFA==@nongnu.org
X-Gm-Message-State: AOJu0Yx8Wg056DIQ1fwhHjZI6EJsFZ6+ZHpPYYJHOrSK6OCTgSkg68PT
 2zhAXqfCo2QHn4pyDbumbBRZTuxfslNeCBx2Vkz5ps/kCAeP1yHh
X-Google-Smtp-Source: AGHT+IHzf1M6dXguj1S7SwnrA/V8LIe5uHY4VnCtlHbCBB6MxvunbWymgV+NWC7NysonlovLaSJc2A==
X-Received: by 2002:a2e:a883:0:b0:2fb:8de8:7f9e with SMTP id
 38308e7fff4ca-2ff4c5977b2mr18174461fa.1.1731511792969; 
 Wed, 13 Nov 2024 07:29:52 -0800 (PST)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2ff178e03f6sm23372421fa.12.2024.11.13.07.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 07:29:52 -0800 (PST)
Date: Wed, 13 Nov 2024 16:29:51 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Jason Wang <jasowang@redhat.com>,
 qemu-arm@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [PATCH 15/20] hw/net/xilinx_ethlite: Map RX_CTRL as MMIO
Message-ID: <ZzTF78kR4jA69J5W@zapote>
References: <20241112181044.92193-1-philmd@linaro.org>
 <20241112181044.92193-16-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112181044.92193-16-philmd@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x235.google.com
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

On Tue, Nov 12, 2024 at 07:10:39PM +0100, Philippe Mathieu-Daudé wrote:
> Declare RX registers as MMIO region, split it out
> of the current mixed RAM/MMIO region.
> The memory flat view becomes:
> 
>   FlatView #0
>    Root memory region: system
>     0000000081000000-00000000810007e3 (prio 0, i/o): xlnx.xps-ethernetlite
>     00000000810007e4-00000000810007f3 (prio 0, i/o): ethlite.mdio
>     00000000810007f4-00000000810017fb (prio 0, i/o): xlnx.xps-ethernetlite @00000000000007f4
>     00000000810017fc-00000000810017ff (prio 0, i/o): ethlite.rx[0]io
>     0000000081001800-0000000081001ffb (prio 0, i/o): xlnx.xps-ethernetlite @0000000000001800
>     0000000081001ffc-0000000081001fff (prio 0, i/o): ethlite.rx[1]io
>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>


> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/net/xilinx_ethlite.c | 79 +++++++++++++++++++++++++++++++++--------
>  1 file changed, 65 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/net/xilinx_ethlite.c b/hw/net/xilinx_ethlite.c
> index 4d86851f38..161fd97f06 100644
> --- a/hw/net/xilinx_ethlite.c
> +++ b/hw/net/xilinx_ethlite.c
> @@ -46,13 +46,18 @@
>  #define R_TX_CTRL1    (0x0ffc / 4)
>  
>  #define R_RX_BUF0     (0x1000 / 4)
> -#define R_RX_CTRL0    (0x17fc / 4)
> +#define A_RX_BASE0    0x17fc
>  #define R_RX_BUF1     (0x1800 / 4)
> -#define R_RX_CTRL1    (0x1ffc / 4)
> +#define A_RX_BASE1    0x1ffc
>  #define R_MAX         (0x2000 / 4)
>  
>  #define RX_BUFSZ_MAX  0x07e0
>  
> +enum {
> +    RX_CTRL = 0,
> +    RX_MAX
> +};
> +
>  #define GIE_GIE    0x80000000
>  
>  #define CTRL_I     0x8
> @@ -61,6 +66,8 @@
>  
>  typedef struct XlnxXpsEthLitePort
>  {
> +    MemoryRegion rxio;
> +
>      struct {
>          uint32_t tx_len;
>          uint32_t tx_gie;
> @@ -118,6 +125,53 @@ static void *rxbuf_ptr(XlnxXpsEthLite *s, unsigned port_index)
>      return &s->regs[rxbase + R_RX_BUF0];
>  }
>  
> +static uint64_t port_rx_read(void *opaque, hwaddr addr, unsigned int size)
> +{
> +    XlnxXpsEthLite *s = opaque;
> +    unsigned port_index = addr_to_port_index(addr);
> +    uint32_t r = 0;
> +
> +    switch (addr >> 2) {
> +        case RX_CTRL:
> +            r = s->port[port_index].reg.rx_ctrl;
> +            break;
> +        default:
> +            g_assert_not_reached();
> +    }
> +
> +    return r;
> +}
> +
> +static void port_rx_write(void *opaque, hwaddr addr, uint64_t value,
> +                          unsigned int size)
> +{
> +    XlnxXpsEthLite *s = opaque;
> +
> +    switch (addr >> 2) {
> +        case RX_CTRL:
> +            if (!(value & CTRL_S)) {
> +                qemu_flush_queued_packets(qemu_get_queue(s->nic));
> +            }
> +            break;
> +        default:
> +            g_assert_not_reached();
> +    }
> +}
> +
> +static const MemoryRegionOps eth_portrx_ops = {
> +        .read = port_rx_read,
> +        .write = port_rx_write,
> +        .endianness = DEVICE_NATIVE_ENDIAN,
> +        .impl = {
> +            .min_access_size = 4,
> +            .max_access_size = 4,
> +        },
> +        .valid = {
> +            .min_access_size = 4,
> +            .max_access_size = 4,
> +        },
> +};
> +
>  static uint64_t
>  eth_read(void *opaque, hwaddr addr, unsigned int size)
>  {
> @@ -143,10 +197,6 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
>              r = s->port[port_index].reg.tx_ctrl;
>              break;
>  
> -        case R_RX_CTRL1:
> -        case R_RX_CTRL0:
> -            r = s->port[port_index].reg.rx_ctrl;
> -
>          default:
>              r = tswap32(s->regs[addr]);
>              break;
> @@ -187,14 +237,6 @@ eth_write(void *opaque, hwaddr addr,
>              break;
>  
>          /* Keep these native.  */
> -        case R_RX_CTRL0:
> -        case R_RX_CTRL1:
> -            if (!(value & CTRL_S)) {
> -                qemu_flush_queued_packets(qemu_get_queue(s->nic));
> -            }
> -            s->port[port_index].reg.rx_ctrl = value;
> -            break;
> -
>          case R_TX_LEN0:
>          case R_TX_LEN1:
>              s->port[port_index].reg.tx_len = value;
> @@ -287,6 +329,15 @@ static void xilinx_ethlite_realize(DeviceState *dev, Error **errp)
>      memory_region_add_subregion(&s->mmio, A_MDIO_BASE,
>                              sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->mdio), 0));
>  
> +    for (unsigned i = 0; i < 2; i++) {
> +        memory_region_init_io(&s->port[i].rxio, OBJECT(dev),
> +                              &eth_portrx_ops, s,
> +                              i ? "ethlite.rx[1]io" : "ethlite.rx[0]io",
> +                              4 * RX_MAX);
> +        memory_region_add_subregion(&s->mmio, i ? A_RX_BASE1 : A_RX_BASE0,
> +                                    &s->port[i].rxio);
> +    }
> +
>      qemu_macaddr_default_if_unset(&s->conf.macaddr);
>      s->nic = qemu_new_nic(&net_xilinx_ethlite_info, &s->conf,
>                            object_get_typename(OBJECT(dev)), dev->id,
> -- 
> 2.45.2
> 

