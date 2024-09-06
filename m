Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BDACE7AB8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 07:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smTix-0000o6-Dj; Fri, 06 Sep 2024 03:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ncBN=QE=kaod.org=clg@ozlabs.org>)
 id 1smTiv-0000fG-AS; Fri, 06 Sep 2024 03:49:41 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=ncBN=QE=kaod.org=clg@ozlabs.org>)
 id 1smTit-0001io-6Q; Fri, 06 Sep 2024 03:49:41 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4X0Szv1bsWz4x8c;
 Fri,  6 Sep 2024 17:49:31 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4X0Szk4TzQz4x7F;
 Fri,  6 Sep 2024 17:49:22 +1000 (AEST)
Message-ID: <73b7ffba-f2ae-415e-9aa6-793480c08f67@kaod.org>
Date: Fri, 6 Sep 2024 09:49:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [SPAM] [PATCH v3 00/11] support I2C for AST2700
To: Troy Lee <leetroy@gmail.com>
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, Troy Lee <troy_lee@aspeedtech.com>,
 Yunlin Tang <yunlin.tang@aspeedtech.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20240903083528.2182190-1-jamin_lin@aspeedtech.com>
 <00aac81e-ff43-4526-960c-782e27ae043f@kaod.org>
 <SI2PR06MB50418DD956AC152E4E0911CDFC9C2@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <c418168b-eb5c-459c-85b1-c7766102e558@kaod.org>
 <CAN9Jwz0cRRb308_ZOuwOsJsPLiKp3sugGJ-YzhvALv3-f+yaCQ@mail.gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CAN9Jwz0cRRb308_ZOuwOsJsPLiKp3sugGJ-YzhvALv3-f+yaCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=ncBN=QE=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hello,


On 9/4/24 11:01, Troy Lee wrote:
> Hi Cédric,
> 
> On Wed, Sep 4, 2024 at 3:29 PM Cédric Le Goater <clg@kaod.org> wrote:
>>
>> Hello Jamin,
>>
>>> Just want you to know that I and Troy are working on the following tasks for AST2700.
>>> 1. Support boot from bootmcu(riscv32) instead of u-boot(Cortex-A35)
>>
>> Oh nice. This is a good topic for heterogeneous machines !
> 
> The basic model for bootmcu(risc-v) is working now, 

May be send that first.

> but we're looking for a way
> to integrate sram/mmio/dram together.  
Unfortunately, QEMU is not yet ready for heterogeneous architectures.

> The ivshmem requires PCI, it might be
> too complicate for our use case.  There is an ivshmem-flat probably more
> sutiable for us.
> 
> [PATCH 0/4] Add ivshmem-flat device - Gustavo Romero (kernel.org)
> https://lore.kernel.org/qemu-devel/20231127052024.435743-1-gustavo.romero@linaro.org/

I lack expertise in that area. Adding Gustavo.

Thanks,

C.


