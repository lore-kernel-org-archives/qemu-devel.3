Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69538C3065C
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 08:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPIDs-00013y-37; Thu, 04 Jul 2024 04:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mgHy=OE=kaod.org=clg@ozlabs.org>)
 id 1sPIDp-000132-Qx; Thu, 04 Jul 2024 04:53:45 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=mgHy=OE=kaod.org=clg@ozlabs.org>)
 id 1sPIDj-0003Sk-4r; Thu, 04 Jul 2024 04:53:45 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WF9RJ6QvNz4x1V;
 Thu,  4 Jul 2024 18:53:32 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WF9R96mxQz4wx6;
 Thu,  4 Jul 2024 18:53:25 +1000 (AEST)
Message-ID: <7c2a40f4-8ab2-4e44-a7f5-2f445e9b6d77@kaod.org>
Date: Thu, 4 Jul 2024 10:53:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] hw/net:ftgmac100: update memory region size to 64KB
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
Cc: troy_lee@aspeedtech.com, yunlin.tang@aspeedtech.com
References: <20240704082922.1464317-1-jamin_lin@aspeedtech.com>
 <20240704082922.1464317-2-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240704082922.1464317-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=mgHy=OE=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/4/24 10:29 AM, Jamin Lin wrote:
> According to the datasheet of ASPEED SOCs,
> one MAC controller owns 128KB of register space for AST2500.
> However, one MAC controller only owns 64KB of register space for AST2600
> and AST2700. It set the memory region size 128KB and it occupied another
> controllers Address Spaces.
> 
> Update one MAC controller memory region size to 0x1000
> because AST2500 did not use register spaces over than 64KB.
> 
> Introduce a new container region size to 0x1000 and its range
> is from 0 to 0xfff. This container is mapped a sub region
> for the current set of register.
> This sub region range is from 0 to 0xff.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/net/ftgmac100.c         | 11 ++++++++---
>   include/hw/net/ftgmac100.h |  4 ++++
>   2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> index 25e4c0cd5b..9e1f12cd33 100644
> --- a/hw/net/ftgmac100.c
> +++ b/hw/net/ftgmac100.c
> @@ -1107,9 +1107,14 @@ static void ftgmac100_realize(DeviceState *dev, Error **errp)
>           s->rxdes0_edorr = FTGMAC100_RXDES0_EDORR;
>       }
>   
> -    memory_region_init_io(&s->iomem, OBJECT(dev), &ftgmac100_ops, s,
> -                          TYPE_FTGMAC100, 0x2000);
> -    sysbus_init_mmio(sbd, &s->iomem);
> +    memory_region_init(&s->iomem_container, OBJECT(s),
> +                       TYPE_FTGMAC100 ".container", FTGMAC100_MEM_SIZE);
> +    sysbus_init_mmio(sbd, &s->iomem_container);
> +
> +    memory_region_init_io(&s->iomem, OBJECT(s), &ftgmac100_ops, s,
> +                          TYPE_FTGMAC100 ".regs", FTGMAC100_REG_MEM_SIZE);
> +    memory_region_add_subregion(&s->iomem_container, 0x0, &s->iomem);
> +
>       sysbus_init_irq(sbd, &s->irq);
>       qemu_macaddr_default_if_unset(&s->conf.macaddr);
>   
> diff --git a/include/hw/net/ftgmac100.h b/include/hw/net/ftgmac100.h
> index 765d1538a4..269446e858 100644
> --- a/include/hw/net/ftgmac100.h
> +++ b/include/hw/net/ftgmac100.h
> @@ -14,6 +14,9 @@
>   #define TYPE_FTGMAC100 "ftgmac100"
>   OBJECT_DECLARE_SIMPLE_TYPE(FTGMAC100State, FTGMAC100)
>   
> +#define FTGMAC100_MEM_SIZE 0x1000
> +#define FTGMAC100_REG_MEM_SIZE 0x100
> +
>   #include "hw/sysbus.h"
>   #include "net/net.h"
>   
> @@ -30,6 +33,7 @@ struct FTGMAC100State {
>       NICState *nic;
>       NICConf conf;
>       qemu_irq irq;
> +    MemoryRegion iomem_container;
>       MemoryRegion iomem;
>   
>       uint8_t frame[FTGMAC100_MAX_FRAME_SIZE];


