Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BABC606A320
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kaod.org header.i=@kaod.org header.a=rsa-sha256 header.s=ovhmo393970-selector1 header.b=mjL4sIY7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTfBI-0001YS-GV; Wed, 18 Nov 2026 07:54:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xTfBG-0001Y9-MG
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:54:30 -0500
Received: from smtpout2.mo540.mail-out.ovh.net ([51.210.91.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1xTfBD-0003fr-7H
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:54:30 -0500
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net [79.137.60.36])
 by mo540.mail-out.ovh.net (Postfix) with ESMTPS id 4jV1l31rmTz46dJ;
 Wed, 18 Nov 2026 12:54:23 +0000 (UTC)
Received: from director2.derp.mail-out.ovh.net
 (director2.derp.mail-out.ovh.net. [127.0.0.1])
 by director2.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <jamin_lin@aspeedtech.com>; Wed, 18 Nov 2026 12:54:23 +0000 (UTC)
Received: from mta3.priv.ovhmail-u2.ea.mail.ovh.net (unknown [10.109.231.92])
 by director2.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4jV1l31Cmxz20Nw; Wed, 18 Nov 2026 12:54:23 +0000 (UTC)
Received: from kaod.org (unknown [10.1.6.3])
 (Authenticated sender: clg@kaod.org)
 by mta3.priv.ovhmail-u2.ea.mail.ovh.net (Postfix) with ESMTPSA id 2FADD12E435C;
 Wed, 18 Nov 2026 12:54:21 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-110S0040832b8eb-1d9d-4a14-a2df-6c6d37b53f7c,
 240B2D80E6D5B5AB1626C6D871A46C45E5CC6673) smtp.auth=clg@kaod.org
X-OVh-ClientIp: 82.64.250.170
Message-ID: <c81acaea-2c43-4151-aee5-cd9f165d8235@kaod.org>
Date: Wed, 18 Nov 2026 13:54:20 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/11] Add SSP/TSP power control and DRAM remap support
 for AST2700
To: Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20260723022300.4174471-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Language: en-US, fr
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <20260723022300.4174471-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
x-ovh-tracer-id: 11528933572218104947
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTFbi2z0xkPrrBV649DJhwHt0RuwPxPH3eG4hAoWtqeRQYsodMmNFsYgGmwflYVNlfscUx4KdHSgwKm26zF5P2dly9bxNhZPw2C3xzIOgsgKXvf43eeXk0QRMHx7FeB+yJBb7ZcWQ6U0DQ8U7ikML4yJEeIGt5uY+LHiLXQ9vU2md+ibz9vB0DBJanzfCyKrsn03FF0KLKHUaBBAbw4mn0KFwKRLotAneGT7ZeBeYbzleIQGp3iE5SD6O0cgyBOKWtQrYnuTPQ0IaWCPrDmZjbD4CNAY7l+a9SqImypoRrtCFRvoummLyaUf8OYf+vYklXjlGUljEnAzG8MvCeinMUdKQlLOPqfkKhSHV1AQiamElL9IKo6fSdmhv7QpyPKln/EICXqi3bfGoMktF7IT9kTLvXYxTeXaJXVPsTQvDvvoFLnp88Z31bTStqT8oVdzWlexyHrtsvCGKK43Q3MEOflASmNrN5M1aBszqCF38qQRb16MYd/rpvxooNshaUWUZBYn7T9um1xKVccTkYH+zp2ffanbUWq8o9p4M2DywHru3hkflV0+bccOzJg8mz9dHrKWSdmEV+earYIvYs0fjl49zdwEVp/1bPqUWhFijOdgs4dnsLhQ0HKcJDEcdwec49hiWqnEqsiy1xuo4cGNYuAsBkYLbkxO0KwxsTTQ40fYVQ
DKIM-Signature: a=rsa-sha256; bh=Qv89hpfLxmtZjk+C1qnmFuz8v0CRsMtdLRak0Qenf/4=; 
 c=relaxed/relaxed; d=kaod.org; h=From; s=ovhmo393970-selector1;
 t=1795006463; v=1;
 b=mjL4sIY7IAbdnsif4uCUcV8QcdOFwOjMjYTrnAI3Q4f1JkEgYADGWANfeeeL2l/E8oikzlV6
 7WvN0CfnSSPI/fRanb/DOeNs/oUuENiy3EvXiakcIDmlGiEsBNIfbUQhUr5g01Buee+3R9HQN9h
 2lGtxhfxF850+NAailyb4sZ+O4JbH0GmCUKEyzSEzOk0Ck6xFk6A1GzTyQQnEsyt9MkNXHX6hiF
 BP35GLODTl1kv4luJ02qf0UkADjhLxK/5hTZMiBxDAJmJwzA/5sWjZGro/H+P+w4y4aXLE3/A/z
 UJfW1F3jDxlpkDzpr1LlQu0a2ABMr33EjC8qUIhZyGUMg==
Received-SPF: pass client-ip=51.210.91.51; envelope-from=clg@kaod.org;
 helo=smtpout2.mo540.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Jamin,

On 7/23/26 04:23, Jamin Lin wrote:
> This series improves AST2700 platform support by aligning SSP/TSP
> power and reset behavior with hardware, and enabling DRAM remapping
> required for proper firmware boot flow.
> 
> This series depends on:
> [v4,0/9] Refactor AST2700 SCU preparation for coprocessors
> https://patchwork.kernel.org/project/qemu-devel/cover/20260717084559.3477061-1-jamin_lin@aspeedtech.com/
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
> 
> v5:
>   1. To speed up the review process, move the following patches into a separate
>      patch series, as they are not directly related to the main topic of this series:
>   
>      [v4,01/21] hw/misc/aspeed_scu: Introduce Aspeed2700SCU subclass and separate from generic SCU
>      [v4,02/21] hw/misc/aspeed_scu: Add separate reset handler for AST2700 SCUIO
>      [v4,11/21] hw/arm/ast27x0: Share FMC controller with SSP and TSP
>      [v4,12/21] hw/arm/aspeed_ast27x0: Add unimplemented Privilege Controller MMIO regions for SSP/TSP (Merged)
>      [v4,13/21] hw/arm/aspeed_ast27x0: Add unimplemented OTP controller MMIO regions for SSP/TSP (Merged)
>      [v4,14/21] hw/block/m25p80: Implement volatile status register write enable for Winbond
>      [v4,15/21] hw/ssi/aspeed_smc: Add Data FIFO-based flash access support for AST2700
>      [v4,16/21] hw/misc/aspeed_scu: Drop noisy unhandled read logs for AST2700 SCU/SCUIO (Merged)
>      [v4,17/21] hw/misc/aspeed_scu: Add AST2700 SCUIO RNG control and data registers (Merged)
>      [v4,18/21] hw/arm/ast27x0: Share single SCUIO instance across PSP, SSP, and TSP
>      [v4,19/21] hw/arm/aspeed_ast27x0-fc: Fix hardware strap settings (Merged)
>      
>    2. Add memory_region_transaction_begin() and memory_region_transaction_commit()
>       to protect the transaction.
> 
> v6:
>    1. Move the DRAM remap MemoryRegions from the SCU to the SSP/TSP
>       coprocessor state itself.
>    2. Set ssp_cpuid/tsp_cpuid directly once the SSP/TSP's armv7m core is
>       realized, instead of pre-guessing them from board code via a QOM
>       property.
>    3. Correct AST2700 SCU to SCUIO to AST1700
> 
> Jamin Lin (11):
>    hw/arm/aspeed_ast1700: Correct AST2700 SCU to SCUIO
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
>    tests/functional/aarch64/test_aspeed_ast2700fc: Boot SSP/TSP via PSP
>      and load binaries from DRAM
>    docs: Add support vbootrom and update Manual boot for ast2700fc
> 
>   docs/system/arm/aspeed.rst                    |  42 ++-
>   include/hw/arm/aspeed_ast1700.h               |   2 +-
>   include/hw/arm/aspeed_coprocessor.h           |   2 +
>   include/hw/misc/aspeed_scu.h                  |   5 +
>   hw/arm/aspeed_ast1700.c                       |  22 +-
>   hw/arm/aspeed_ast27x0-fc.c                    |   4 +
>   hw/arm/aspeed_ast27x0-ssp.c                   |  45 ++++
>   hw/arm/aspeed_ast27x0-tsp.c                   |  37 +++
>   hw/misc/aspeed_scu.c                          | 240 ++++++++++++++++++
>   .../aarch64/test_aspeed_ast2700fc.py          |  29 ++-
>   10 files changed, 396 insertions(+), 32 deletions(-)
> 

The test passes. v7 should be fine for merge with the changes I proposed.

Thanks,

C.

