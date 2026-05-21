Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D759CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 06:43:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPx7H-0000xW-RL; Thu, 21 May 2026 02:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wPx7F-0000wx-Kr
 for qemu-devel@nongnu.org; Thu, 21 May 2026 02:42:46 -0400
Received: from smtpout3.mo534.mail-out.ovh.net ([51.210.94.142])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1wPx7B-0005j6-NW
 for qemu-devel@nongnu.org; Thu, 21 May 2026 02:42:44 -0400
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [51.255.22.22])
 by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4gLf3f0c6Cz6Bhp;
 Thu, 21 May 2026 06:42:37 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alistair@alistair23.me>; Thu, 21 May 2026 06:42:37 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.110.0.37])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4gLf3d5RLNz7v45;
 Thu, 21 May 2026 06:42:37 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.5])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id EBDA512E3B5C;
 Thu, 21 May 2026 06:42:35 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R00669f1d9c7-6747-4a80-b2ac-11749460c161,
 155D954443A34AB19E7EFB78D45315E373F1C727) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <2277d954-478f-472e-934c-01a837b0a392@kaod.org>
Date: Thu, 21 May 2026 08:42:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/21] Add SSP/TSP power control and DRAM remap support
 for AST2700
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:Block layer core" <qemu-block@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260417032837.2664122-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 12203910566556576907
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGEqvG6whyW34rtYD38NEfb1xK8NCnRWH+PUNwI5YtTKUaE47+/NquCRx0Vvqo6Rij4AxhTuCElbxazPYZSiW2GbZiaVwq51rUuuqhkCp9wPUQAwg44wgfkhHRdpOKU9wUupBHE8WkmVEtWnliJV+qcHcsgmIxv11iRhMjq0uwm5+QA1z0mRUSAO5AeBgjwVfD8Nv55IJsehpOasQPyHTE7PIAFeAB8s0nTdi9KnNDfTx3sEWnyD//lSdeag6mUTK0rAcXPkuvkQxj/BNUAzvk1yhH4MsqJRKyaz9aHx8r9gkq88CBjss1fW8CZHiSFD4mfDvV3EBIOnPWEf+1L+iuDagpQypNh61sTxrNyNAI+I/5thYosMGlCsxfr6ABA7/FdhsurT25gvYa651YXEfFkNLz1o6NVhdtWPbsAFNDzycSxZceBNmhOj5RbRon3g6HqLvQ/4XU4R/NBdx9ziKSpj22H/clGbCclyWLKMvhcM5iZZOMASH8c+R30fN3VS2vAg3pYBt/xUgApUEQ/NPLsA9qitUde2KP3Pth2thr+wqwQUUaRZM2iKYxYsYPenUmiJ5aJiVsjYtGuJHklNzdZO3l/zUlWIFi19GZTfBr4MT09bCSgXkpCJJFGGt5PYncN7ECkjr+ZX9F/GTPEMP12Q0c33xdbawP9zC/Tz7J+EQ
DKIM-Signature: a=rsa-sha256; bh=p0r5hRfEiwcGovXylKFjhXS0PZ9HPu0jRHMJCF9RJH4=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1779345758; v=1;
 b=P7EarxQapuArOf7bEX+7Yv9c4zDp1lN1Oamrq9PYkrKg6vLTmdIMaU9oEiotbfnjnI9veWxF
 kJfpKSWIJFhjRi6vBgX08bhRvZt2urlxri9FqCt3A8MeXPUAMinZmZFx5+MXIf2LucphlvJaCbf
 BuGEJsqWhgfHNx9gcLlBTi+9ROHfiX8tQdfIO3AvrXbYa9hezhsDW6dKUSC7+uw6/s5xQ/ak3xs
 +u6p3y5o2m1RAZwk3vsD11LGBSEhTWuWDGUyysu9/ucpKpbGtManvMyCNpLAYlfvLSrlTpVRcp7
 hIWHuHJo+VR+TRqdnYbI3TbFvbE/YnThKjix28myBLx/w==
Received-SPF: pass client-ip=51.210.94.142; envelope-from=clg@kaod.org;
 helo=smtpout3.mo534.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Jamin,

On 4/17/26 05:28, Jamin Lin wrote:
> This series improves AST2700 platform support by aligning SSP/TSP
> power and reset behavior with hardware, and enabling DRAM remapping
> required for proper firmware boot flow.
> 
> v1:
>    1. The changes move DRAM/SDMC initialization earlier to support memory
> aliasing, add DRAM aliases for SSP/TSP SDRAM remap, and implement
> SSP/TSP reset, power-on, and remap controls via SCU registers.
>    2. With these updates, SSP and TSP can be booted via PSP and load their
> binaries from DRAM. Functional tests and documentation are updated
> accordingly.
> 
> v2:
>    Fix "make check" failure caused by both AST2700 and AST1700 realizing the same
>    TYPE_AST2700_SCU model.
>    
> v3:
>   1. Drop "Move DRAM and SDMC initialization earlier to support memory aliasing"
>   2. Support SPI/FMC FIFO Mode
>   3. Add unimplemented devices
> 
> v4:
>   1. Introduce Aspeed2700SCU subclass and separate from generic SCU.
>   2. Add separate reset handler for AST2700 SCUIO
>   3. Add AST2700 SCUIO RNG control and data registers
>   4. Share single SCUIO instance across PSP, SSP, and TSP
>   5. Fix AST2700 FC hardware strap settings


Just a quick note to tell you that I didn't forget this series.
This is on my TODO list for QEMU 11.1. It's spring time and
changes are blooming all around.

Thanks,

C.


> Jamin Lin (21):
>    hw/misc/aspeed_scu: Introduce Aspeed2700SCU subclass and separate from
>      generic SCU
>    hw/misc/aspeed_scu: Add separate reset handler for AST2700 SCUIO
>    hw/arm/ast27x0: Start SSP in powered-off state to match hardware
>      behavior
>    hw/arm/ast27x0: Start TSP in powered-off state to match hardware
>      behavior
>    hw/arm/ast27x0: Add DRAM alias for SSP SDRAM remap
>    hw/arm/ast27x0: Add DRAM alias for TSP SDRAM remap
>    hw/misc/aspeed_scu: Implement SSP reset and power-on control via SCU
>      registers
>    hw/misc/aspeed_scu: Implement TSP reset and power-on control via SCU
>      registers
>    hw/misc/aspeed_scu: Add SCU support for SSP SDRAM remap
>    hw/misc/aspeed_scu: Add SCU support for TSP SDRAM remap
>    hw/arm/ast27x0: Share FMC controller with SSP and TSP
>    hw/arm/aspeed_ast27x0: Add unimplemented Privilege Controller MMIO
>      regions for SSP/TSP
>    hw/arm/aspeed_ast27x0: Add unimplemented OTP controller MMIO regions
>      for SSP/TSP
>    hw/block/m25p80: Implement volatile status register write enable for
>      Winbond
>    hw/ssi/aspeed_smc: Add Data FIFO-based flash access support for
>      AST2700
>    hw/misc/aspeed_scu: Drop noisy unhandled read logs for AST2700
>      SCU/SCUIO
>    hw/misc/aspeed_scu: Add AST2700 SCUIO RNG control and data registers
>    hw/arm/ast27x0: Share single SCUIO instance across PSP, SSP, and TSP
>    hw/arm/aspeed_ast27x0-fc: Fix hardware strap settings
>    tests/functional/aarch64/test_aspeed_ast2700fc: Boot SSP/TSP via PSP
>      and load binaries from DRAM
>    docs: Add support vbootrom and update Manual boot for ast2700fc
> 
>   docs/system/arm/aspeed.rst                    |  42 ++-
>   include/hw/arm/aspeed_ast1700.h               |   2 +-
>   include/hw/arm/aspeed_coprocessor.h           |  13 +-
>   include/hw/arm/aspeed_soc.h                   |   4 +
>   include/hw/misc/aspeed_scu.h                  |  10 +
>   include/hw/ssi/aspeed_smc.h                   |   3 +-
>   hw/arm/aspeed_ast27x0-fc.c                    |  22 +-
>   hw/arm/aspeed_ast27x0-ssp.c                   |  67 +++-
>   hw/arm/aspeed_ast27x0-tsp.c                   |  64 +++-
>   hw/arm/aspeed_ast27x0.c                       |  22 +-
>   hw/arm/aspeed_coprocessor_common.c            |   2 -
>   hw/block/m25p80.c                             |  36 +-
>   hw/misc/aspeed_scu.c                          | 324 +++++++++++++++++-
>   hw/ssi/aspeed_smc.c                           | 113 +++++-
>   .../aarch64/test_aspeed_ast2700fc.py          |  29 +-
>   15 files changed, 672 insertions(+), 81 deletions(-)
> 


