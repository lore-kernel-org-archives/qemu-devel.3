Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2D5C30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 09:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOw3C-0001fY-6I; Wed, 03 Jul 2024 05:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=dfZQ=OD=kaod.org=clg@ozlabs.org>)
 id 1sOw3A-0001eQ-5U; Wed, 03 Jul 2024 05:13:16 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=dfZQ=OD=kaod.org=clg@ozlabs.org>)
 id 1sOw37-0005dv-St; Wed, 03 Jul 2024 05:13:15 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WDYwL6DTgz4wxx;
 Wed,  3 Jul 2024 19:13:06 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WDYwD0f4kz4whq;
 Wed,  3 Jul 2024 19:12:59 +1000 (AEST)
Message-ID: <c3ee29b3-4587-4056-a5f8-338c253cdb45@kaod.org>
Date: Wed, 3 Jul 2024 11:12:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] hw/net:ftgmac100: update memory region size to
 0x200
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
References: <20240703081623.2740862-1-jamin_lin@aspeedtech.com>
 <20240703081623.2740862-2-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240703081623.2740862-2-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=dfZQ=OD=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 7/3/24 10:16 AM, Jamin Lin wrote:
> According to the datasheet of ASPEED SOCs,
> one MAC controller owns 128KB of register space for AST2500.
> 
> However, one MAC controller only owns 64KB of register space for AST2600
> and AST2700.
> 
> It set the memory region size 128KB and it occupied another
> controllers Address Spaces.
> 
> Currently, the ftgmac100 model use 0x100 register space.
> To support DMA 64 bits dram address and new future mode(ftgmac100_high) which
> have "Normal Priority Transmit Ring Base Address Register High(0x17C)",
> "High Priority Transmit Ring Base Address Register High(0x184)" and
> "Receive Ring Base Address Register High(0x18C)" to save the high part physical
> address of descriptor manager.
> 
> Update memory region size to 0x200.
> 
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   hw/net/ftgmac100.c         | 2 +-
>   include/hw/net/ftgmac100.h | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> index 25e4c0cd5b..4e88430b2f 100644
> --- a/hw/net/ftgmac100.c
> +++ b/hw/net/ftgmac100.c
> @@ -1108,7 +1108,7 @@ static void ftgmac100_realize(DeviceState *dev, Error **errp)
>       }
>   
>       memory_region_init_io(&s->iomem, OBJECT(dev), &ftgmac100_ops, s,
> -                          TYPE_FTGMAC100, 0x2000);
> +                          TYPE_FTGMAC100, FTGMAC100_NR_REGS);
>       sysbus_init_mmio(sbd, &s->iomem);
>       sysbus_init_irq(sbd, &s->irq);
>       qemu_macaddr_default_if_unset(&s->conf.macaddr);
> diff --git a/include/hw/net/ftgmac100.h b/include/hw/net/ftgmac100.h
> index 765d1538a4..5a970676da 100644
> --- a/include/hw/net/ftgmac100.h
> +++ b/include/hw/net/ftgmac100.h
> @@ -14,6 +14,8 @@
>   #define TYPE_FTGMAC100 "ftgmac100"
>   OBJECT_DECLARE_SIMPLE_TYPE(FTGMAC100State, FTGMAC100)
>   
> +#define FTGMAC100_NR_REGS   0x200

Since this value will size a memory region, I think the define name should
be changed to FTGMAC100_{MEM,REGION,MMIO}_SIZE. What ever you prefer.


Thanks,

C.


  
> +
>   #include "hw/sysbus.h"
>   #include "net/net.h"
>   


