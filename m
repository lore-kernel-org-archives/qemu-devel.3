Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10DB5CD5BCF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 04:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRjs3-00057z-1C; Tue, 26 May 2026 00:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wRjs1-00057n-NX; Tue, 26 May 2026 00:58:25 -0400
Received: from smtpout1.mo528.mail-out.ovh.net ([46.105.34.251])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>)
 id 1wRjry-0003oC-DY; Tue, 26 May 2026 00:58:25 -0400
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net [152.228.215.222])
 by mo528.mail-out.ovh.net (Postfix) with ESMTPS id 4gPgVm73mQz6KYf;
 Tue, 26 May 2026 04:58:08 +0000 (UTC)
Received: from director3.derp.mail-out.ovh.net
 (director3.derp.mail-out.ovh.net. [127.0.0.1])
 by director3.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Tue, 26 May 2026 04:58:08 +0000 (UTC)
Received: from mta10.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.178.179])
 by director3.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4gPgVm24V8z5vfw;
 Tue, 26 May 2026 04:58:08 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.0])
 (Authenticated sender: clg@kaod.org)
 by mta10.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id
 462BE1923B66; Tue, 26 May 2026 04:58:06 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-109S003456d7b70-830f-4b80-91d5-ea97919d5be2,
 F49BC9865E6D06A1207BBF08B4ECD36E7EFD173C) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <2c3e1577-abe8-49b5-acc8-0321dc3c8327@kaod.org>
Date: Tue, 26 May 2026 06:58:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] hw/arm/aspeed: Introduce initial AST1040 support
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260525053036.3305181-1-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260525053036.3305181-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 2909325360855297139
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEWpvJPjkkXJQdh36+On+JpBs6mt0c9Y+hpSuJmYfkHv+XU8j/iP0+l04M2jU/i9oJ+HFk9N4oKzfRI9AKzutmeVBOrPyxsJ0dBWxp+Wbv444iEE8/jaRf7Wwj2MDNGyQJ/nFQFnX3yJ7Mx3LkZtXimuPrQmkuXXW3a0baFO8gg6PBYANC0XYdoxwZ2Hmf79KyyCI9kCgInsMTmYqvNplWfJvd0r6XVTMJuFBmWVK9BLO4HA0NN3MWYIIZ0z91chQe4OnoxnE6BO86p5yaugICGt7BAFQcjiizqmFYHYj5WhwVugKKs7ksg64mEVZu8DgLWaQgLUVJHhDEHzDqbYKE6oxDrxG8uHcn7giYTqVv0mvUS5JSnZaY8akemdpCJNMuYhUCvxdW9DPH1uI03g0lNlANbNmoItG+mpApPQU9Xaz113Xmco1NOF3EW1Q91+U6kodFevjY4hTJ6InSm45eHRa1LyDJeiZUA6/MLRJPTNG/yZIgr1XFovjI9NaFOVH54/Ycn4FEepTDcLwENhN64ah38/hiruYYzxVzb0UQ9FU5o+KbdBhky37bPH9gIF24WWJuxLChJFjSU9cvx1PC3TJOARPKP1h0o9Y0s0b9v+svCthGGkQhRJFsLa1DdGLx4q/ztc8Qc55do+SqgRgrk2JrEEtrNl0ILSFMC7huMbg
DKIM-Signature: a=rsa-sha256; bh=5PJEF0nEBrpqFkXQvli2CRht++wUq+P27DnXdV8UsT8=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1779771490; v=1;
 b=ItKPI0U/lATr2SCa5i/jUQ+6CnVDqASp9HwG45OMifF6QKvAAS1FHQ68lPtVcsoZPxyCkop3
 nQL9PDHoEHbrbUD27F4xacfpPl9JTYkgWCltgupaxxiTSgxQBXTPD/L7UZ3NX3+07IC5Nswblm5
 xWFgeS55flBm7ofOyM6/anhqOVImIyrgYUcn2MpapVVkZ4bLDGsbFqQw8h4Px6JoeMxdGTUzjiN
 5IQQ8c3bVvobPWD16WHi+UgTbwoA++gHfrTb/BRyQrMA4B4yUs4TggeLyd53P72NNuf2QLnpj7G
 qpAOgdBrWAkJeFt3goh+0T1gmjkzSjgqO/pvE9WLSWm7w==
Received-SPF: pass client-ip=46.105.34.251; envelope-from=clg@kaod.org;
 helo=smtpout1.mo528.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 5/25/26 07:30, Jamin Lin wrote:
> This series introduces the initial ASPEED AST1040 support for QEMU.
> 
> AST1040 is the next-generation bridge/BIC controller platform
> following AST1030 and is based on an ARM Cortex-M4F CPU core.
> Since QEMU currently does not provide Cortex-M4F support, the
> existing Cortex-M4 CPU model is used temporarily.
> 
> The current implementation provides enough functionality to boot
> basic firmware environments with UART console support, HyperRAM/SRAM
> mapping, and NVIC interrupt handling.
> 
> Currently this series is able to boot Zephyr successfully to the
> shell prompt:
> 
>    uart:~$
> 
> Example command line:
> 
>    ./build/qemu-system-arm \
>        -machine ast1040-evb \
>        -kernel <zephyr.elf> \
>        -serial mon:stdio \
>        -snapshot \
>        -nographic
> 
> There are many different types of RAM, including DRAM, SRAM, SDRAM, PSRAM,
> SECSRAM, and HyperRAM. To support these memory types, we need to introduce
> distinct variable names for their memory regions and memory sizes.
> 
> In addition, the SoC contains multiple SRAM instances. To make the code more
> flexible and maintainable, I am considering changing the array structure to
> support internal memory types such as SRAM, SDRAM, PSRAM, HyperRAM, and SECSRAM.
> 
> For example:
> 
> sram[NUM]
> sram_size[NUM]
> ASPEED_DEV_SRAMX
> 
> v1:
>    - AST1040 silicon revision ID
>    - SDRAM support in the Aspeed SoC framework
>    - Initial AST1040 SoC model
>    - AST1040 EVB machine model
> 
> v2:
>    - Add AST1040 functional test
>    - Add AST1040 documentation
>    - Convert SRAM MemoryRegion to array type
>    - Convert SRAM size definition to array type
>    
> Jamin Lin (9):
>    hw/arm/aspeed: Convert SRAM MemoryRegion to array type
>    hw/arm/aspeed: Convert SRAM size definition to array type
>    hw/arm/aspeed: Rename SRAM memmap entry for multi-SRAM support
>    hw/arm/aspeed: Consolidate secure SRAM into SRAM array
>    hw/misc/aspeed_scu: Add AST1040 A0 silicon revision ID
>    hw/arm/aspeed: Introduce AST1040 A0 SoC model
>    hw/arm/aspeed: Add AST1040 EVB machine model
>    tests/function/aspeed: Add AST1040 functional test
>    docs/system/arm/aspeed: Add AST1040 Bridge IC evaluation board
> 
>   docs/system/arm/aspeed.rst                  |  18 +-
>   include/hw/arm/aspeed_soc.h                 |  11 +-
>   include/hw/misc/aspeed_scu.h                |   1 +
>   hw/arm/aspeed_ast1040.c                     | 254 ++++++++++++++++++++
>   hw/arm/aspeed_ast1040_evb.c                 |  73 ++++++
>   hw/arm/aspeed_ast10x0.c                     |  29 ++-
>   hw/arm/aspeed_ast2400.c                     |  14 +-
>   hw/arm/aspeed_ast2600.c                     |  10 +-
>   hw/arm/aspeed_ast27x0-ssp.c                 |   4 +-
>   hw/arm/aspeed_ast27x0-tsp.c                 |   4 +-
>   hw/arm/aspeed_ast27x0.c                     |  12 +-
>   hw/misc/aspeed_scu.c                        |   1 +
>   hw/arm/meson.build                          |   4 +-
>   tests/functional/arm/meson.build            |   1 +
>   tests/functional/arm/test_aspeed_ast1040.py |  35 +++
>   15 files changed, 424 insertions(+), 47 deletions(-)
>   create mode 100644 hw/arm/aspeed_ast1040.c
>   create mode 100644 hw/arm/aspeed_ast1040_evb.c
>   create mode 100644 tests/functional/arm/test_aspeed_ast1040.py
> 

For the series,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


