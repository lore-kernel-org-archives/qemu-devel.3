Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64652C3DA41
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 09:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR7Xi-0000Nu-I4; Tue, 09 Jul 2024 05:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=H1KF=OJ=kaod.org=clg@ozlabs.org>)
 id 1sR7XT-0000GO-Br; Tue, 09 Jul 2024 05:53:40 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=H1KF=OJ=kaod.org=clg@ozlabs.org>)
 id 1sR7XF-0007ic-CF; Tue, 09 Jul 2024 05:53:34 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WJGWm0t4Gz4xPg;
 Tue,  9 Jul 2024 19:53:08 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WJGWc5b23z4w2K;
 Tue,  9 Jul 2024 19:53:00 +1000 (AEST)
Message-ID: <528e5ee9-c49b-425c-a779-dc5dcb57da93@kaod.org>
Date: Tue, 9 Jul 2024 11:52:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] support AST2700 network
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
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240704082922.1464317-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=H1KF=OJ=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, SPF_HELO_PASS=-0.001,
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

On 7/4/24 10:29 AM, Jamin Lin wrote:
> change from v1:
> - ftgmac100
>   - fix coding style
>   - support 64 bits dma dram address for AST2700
> 
> change from v2:
> - ftgmac100: update memory region size to 0x200.
> - ftgmac100: introduce a new class(ftgmac100_high),
>      class attribute and memop handlers, for FTGMAC100_*_HIGH regs read/write.
> - aspeed_ast27x0: update network model to ftgmac100_high to support
>    64 bits dram address DMA.
> - m25p80: support quad mode for w25q01jvq
> 
> change from v3:
> - ftgmac100: update memory region size to 64KB.
> - ftgmac100: using a property to activate the region for new registers,
>    instead of a class
> - ftgmac100: introduce TX and RX ring base address high registers
> - ftgmac100: split standalone patch for easy review
> - ftgmac100: update TX and RX packet buffers address to 64 bits
> - aspeed_ast27x0: set dma64 property for AST2700 ftgmac100
> - machine_aspeed.py: update to test sdk v09.02 and network for AST2700
> 
> Jamin Lin (8):
>    hw/net:ftgmac100: update memory region size to 64KB
>    hw/net:ftgmac100: update ring base address to 64 bits
>    hw/net:ftgmac100: introduce TX and RX ring base address high registers
>      to support 64 bits
>    hw/net:ftgmac100: update TX and RX packet buffers address to 64 bits
>    aspeed/soc: set dma64 property for AST2700 ftgmac100
>    hw/block: m25p80: support quad mode for w25q01jvq
>    machine_aspeed.py: update to test ASPEED OpenBMC SDK v09.02 for
>      AST2700
>    machine_aspeed.py: update to test network for AST2700
> 
>   hw/arm/aspeed_ast27x0.c         |   3 +
>   hw/block/m25p80.c               |  16 ++++
>   hw/net/ftgmac100.c              | 147 +++++++++++++++++++++++++++-----
>   include/hw/net/ftgmac100.h      |  17 ++--
>   tests/avocado/machine_aspeed.py |  12 +--
>   5 files changed, 162 insertions(+), 33 deletions(-)
> 


Applied to aspeed-next.

Thanks,

C.



