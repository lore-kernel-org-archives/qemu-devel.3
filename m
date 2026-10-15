Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288FACC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 06:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHEpi-0002fc-DY; Thu, 15 Oct 2026 02:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xHEpf-0002el-M3
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:20:52 -0400
Received: from smtpout6.mo537.mail-out.ovh.net ([51.210.91.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xHEpd-0005HX-Ct
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 02:20:51 -0400
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net [79.137.60.225])
 by mo537.mail-out.ovh.net (Postfix) with ESMTPS id 4j4ycX1RQ9z43WS;
 Thu, 15 Oct 2026 06:20:44 +0000 (UTC)
Received: from director5.derp.mail-out.ovh.net
 (director5.derp.mail-out.ovh.net. [127.0.0.1])
 by director5.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Thu, 15 Oct 2026 06:20:44 +0000 (UTC)
Received: from mta6.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.96.193])
 by director5.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4j4ycX0Mknz5vLZ; Thu, 15 Oct 2026 06:20:44 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.4])
 (Authenticated sender: clg@kaod.org)
 by mta6.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 098A71B42CB8;
 Thu, 15 Oct 2026 06:20:41 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R005d1f06cb3-f418-4883-a7e5-6746d6db4819,
 39EAFCA45846CB7F25CFDE7C5DD07A896C21AD00) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <ede46cde-e280-440b-a527-05dad685ef58@kaod.org>
Date: Thu, 15 Oct 2026 08:20:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/14] hw/arm/aspeed: Add AST1040 FMC/SPI controllers
 and unimplemented devices
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20261015055642.106204-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 8123367830765939757
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEwgDTtQp1PCuwSJLIHmh8lkvy8lwsipne3MMMqqwlo/HUoT6Z16mSOc5XeBMCQfzZiarB4R8/Zk/NZ/9161XiVOfm5I7g+GARGZC8mMKbEVpPZutiUlo/bRE7clmALsI0KWTgxfHgFdItMwWtIGHZ9uUlKAJUKY0PZrAJ+HVPBqazPN5ZSw4KmZ70onsZOFLQIMiX4OQ2QKmc18mIM/pLgJToib9ifQwdzHwegmtKyDSNa+IBmlj469piZKhf94Lqah4Yp0hL0DtCVW8bFxdIYFob9WCn1e7NvMIqjfYV4gKd9hdqdeETAezKSZvw65cMqLRdJY6eXp9hcahO0jmgHSwOaK6IfziSryCAnFwD+bl13ctKF1rRgisX0AFp/tRnfNf4LX1sbtgX/BVK9qhH2/lcFb7YmaaPBzcnJTYS54k7GQF/1vztx/6wgX0cuVqFiL7rtE7Zw1DNslD5mA/ztOMJ+jm3z7zK/BA1BHBvEeafNSjNDtJW7aN5OnKtCEq/3dN3WwIqCkaj/9qZR2DZTH5YzeqNn+LkHItvpslxDl6P3RpAQ3ca66B7W7BcpkvwjYkqD0Cmho5oiFP1bGuy6jR7KTkSlog1rLMH4nlyc1Ar7+vc52RiRD2EubHgi6mkZSGZFczSnVGUfm3dNb7Jl9niQCjnukhenLBhq8V1HIg
DKIM-Signature: a=rsa-sha256; bh=AVlsGYd4rTnV03++VXbQpDVqFYx5zAvUXGpLY5TWx8I=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1792045245; v=1;
 b=gwHoUFuuqAD9gZidvIA6rHckp9spIonH/LqUC7Wuzfuj9NyxKrL686LPlN+9mL3YcA6v4i4+
 fmv4KiD45WamrNXvaMst7+S5jk4ebt3i2sRVLqxWT8gKgmAgaPAKe6C18ImTXXU0gYORRnMABxh
 V1Zb6XcQbwSYUuz2waNxjC1XyqNTlcigALEt1yjQeRx2dFLr9rKeFVjhwVntxV57L9w4Srz4fF4
 WRvtTnnUoQOcyRwGkWXAN9sIshMIV/KRWBBkepAmZl3b2wsrENbsqlsP9/LlUraM5dmF9ImKVdH
 5SAKeBuIKMyuf/kVvaDFXIFScAE6gRYdBu04PyHoSjEgA==
Received-SPF: pass client-ip=51.210.91.25; envelope-from=clg@kaod.org;
 helo=smtpout6.mo537.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hello Jamin,

On 10/15/26 07:56, Jamin Lin wrote:
> Dependency:
> 
> This series is based on the aspeed-next branch:
> https://github.com/legoater/qemu/commits/aspeed-next

I appreciate all these new additions, but there are also pending proposals
that require some feedback too ...

Thanks,

C.


> 
> v1:
>   1. Fix AST2700 segment end address decoding
>   2. Fix AST2700 DMA flash address mask
>   3. Rename w25q32dw to w25q33pw and add the SFDP table for the W25Q33PW,
>   4. Correct the AST1040 A0 silicon revision ID
>   5. Add FMC and SPI controllers
>   6. Add the FMC/SPI filters, OTP, ATC, I3C and Caliptra register
>      regions as unimplemented device
>   7. Update the AST1040 functional test to use the official pre-built
>      image from aspeed-mcu-fw-hub v01.00.
> 
> Jamin Lin (14):
>    hw/ssi/aspeed_smc: Fix AST2700 segment end address decoding
>    hw/ssi/aspeed_smc: Fix AST2700 DMA flash address mask
>    hw/block/m25p80: Rename w25q32dw to w25q33pw
>    hw/block/m25p80: Add SFDP table for Winbond W25Q33PW flash
>    hw/misc/aspeed_scu: Correct AST1040 A0 revision ID
>    hw/ssi/aspeed_smc: Add AST1040 FMC and SPI controllers
>    hw/arm/aspeed_ast1040: Add FMC and SPI controllers
>    hw/arm/aspeed_ast1040: Add FMC and SPI filters as unimplemented
>      devices
>    hw/arm/aspeed_ast1040: Add OTP as an unimplemented device
>    hw/arm/aspeed_ast1040: Add Anti-Tamper Controller (ATC) as an
>      unimplemented device
>    hw/arm/aspeed_ast1040: Add I3C as an unimplemented device
>    hw/arm/aspeed_ast1040: Add Caliptra as an unimplemented device
>    tests/qtest/aspeed_smc: Add AST1040 SMC tests
>    tests/functional/arm/test_aspeed_ast1040: Update AST1040 image to
>      aspeed-mcu-fw-hub v01.00
> 
>   hw/block/m25p80_sfdp.h                      |   1 +
>   include/hw/misc/aspeed_scu.h                |   2 +-
>   hw/arm/aspeed_ast1040.c                     |  45 ++++++++
>   hw/block/m25p80.c                           |   3 +-
>   hw/block/m25p80_sfdp.c                      |  36 ++++++
>   hw/ssi/aspeed_smc.c                         | 121 +++++++++++++++++++-
>   tests/qtest/aspeed_smc-test.c               |  61 ++++++++++
>   tests/functional/arm/test_aspeed_ast1040.py |  12 +-
>   8 files changed, 268 insertions(+), 13 deletions(-)
> 


