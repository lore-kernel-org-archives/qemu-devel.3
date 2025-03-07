Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85157C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 08:10:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqSln-0001ge-5w; Fri, 07 Mar 2025 03:09:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3Khh=V2=kaod.org=clg@ozlabs.org>)
 id 1tqSld-0001eu-DM; Fri, 07 Mar 2025 03:09:14 -0500
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3Khh=V2=kaod.org=clg@ozlabs.org>)
 id 1tqSlX-0002gF-DI; Fri, 07 Mar 2025 03:09:10 -0500
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Z8JpQ3TzFz4x7D;
 Fri,  7 Mar 2025 19:09:02 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Z8JpM0Kyhz4wy9;
 Fri,  7 Mar 2025 19:08:57 +1100 (AEDT)
Message-ID: <deb95684-4cf9-4370-bed1-55327eee400a@kaod.org>
Date: Fri, 7 Mar 2025 09:08:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/29] Support AST2700 A1
To: Steven Lee <steven_lee@aspeedtech.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>
References: <20250307035945.3698802-1-jamin_lin@aspeedtech.com>
 <3485cd84-2aab-45e7-a72c-ca1d85e007ec@kaod.org>
 <SI2PR06MB5041DD86414B93AB1C77C759FCD52@SI2PR06MB5041.apcprd06.prod.outlook.com>
 <09cb40d5-dcba-40f5-916e-f303eba911cb@kaod.org>
 <SI2PR06MB41873452B148F9CC13B149B985D52@SI2PR06MB4187.apcprd06.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Autocrypt: addr=clg@kaod.org; keydata=
 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
In-Reply-To: <SI2PR06MB41873452B148F9CC13B149B985D52@SI2PR06MB4187.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=3Khh=V2=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 3/7/25 08:56, Steven Lee wrote:
>> -----Original Message-----
>> From: Cédric Le Goater <clg@kaod.org>
>> Sent: Friday, March 7, 2025 3:44 PM
>> To: Jamin Lin <jamin_lin@aspeedtech.com>; Peter Maydell
>> <peter.maydell@linaro.org>; Steven Lee <steven_lee@aspeedtech.com>; Troy
>> Lee <leetroy@gmail.com>; Andrew Jeffery <andrew@codeconstruct.com.au>;
>> Joel Stanley <joel@jms.id.au>; open list:All patches CC here
>> <qemu-devel@nongnu.org>; open list:ASPEED BMCs
>> <qemu-arm@nongnu.org>
>> Cc: Troy Lee <troy_lee@aspeedtech.com>
>> Subject: Re: [PATCH v6 00/29] Support AST2700 A1
>>
>> On 3/7/25 08:36, Jamin Lin wrote:
>>> Hi Cedric,
>>>
>>>> Subject: Re: [PATCH v6 00/29] Support AST2700 A1
>>>>
>>>> On 3/7/25 04:59, Jamin Lin wrote:
>>>>> v1:
>>>>>     1. Refactor INTC model to support both INTC0 and INTC1.
>>>>>     2. Support AST2700 A1.
>>>>>     3. Create ast2700a0-evb machine.
>>>>>
>>>>> v2:
>>>>>      To streamline the review process, split the following patch series into
>>>>>      three parts.
>>>>>
>>>>
>> https://patchwork.kernel.org/project/qemu-devel/cover/20250121070424.24
>> 6
>>>> 5942-1-jamin_lin@aspeedtech.com/
>>>>>      This patch series focuses on cleaning up the INTC model to
>>>>>      facilitate future support for the INTC_IO model.
>>>>>
>>>>> v3:
>>>>>     1. Update and add functional test for AST2700
>>>>>     2. Add AST2700 INTC design guidance and its block diagram.
>>>>>     3. Retaining the INTC naming and introducing a new INTCIO model to
>>>> support the AST2700 A1.
>>>>>     4. Create ast2700a1-evb machine and rename ast2700a0-evb
>> machine
>>>>>     5. Fix silicon revision issue and support AST2700 A1.
>>>>>
>>>>> v4:
>>>>>     1. rework functional test for AST2700
>>>>>     2. the initial machine "ast2700-evb" is aliased to "ast2700a0-evb.
>>>>>     3. intc: Reduce regs array size by adding a register sub-region
>>>>>     4. intc: split patch for Support setting different register sizes
>>>>>     5. update ast2700a1-evb machine parent to TYPE_ASPEED_MACHINE
>>>>>
>>>>> v5:
>>>>>     1. Rename status_addr and addr to status_reg and reg for clarity
>>>>>     2. Introduce dynamic allocation for regs array
>>>>>     3. Sort the memmap table by mapping address
>>>>>     4. ast27x0.c split patch for Support two levels of INTC controllers for
>>>> AST2700 A1
>>>>>     5. tests/functional/aspped split patch for Introduce
>> start_ast2700_test API
>>>>>     6. keep variable naming for reviewer suggestion.
>>>>>     7. Add reviewer suggestion and split patch to make more readable.
>>>>>
>>>>> v6:
>>>>>      1. rename reg_size to nr_regs
>>>>>      2. Fix clean regs size
>>>>>      3. replace g_malloc with g_new
>>>>>
>>>>> With the patch applied, QEMU now supports two machines for running
>>>> AST2700 SoCs:
>>>>> ast2700a0-evb: Designed for AST2700 A0
>>>>> ast2700a1-evb: Designed for AST2700 A1
>>>>>
>>>>> Test information
>>>>> 1. QEMU version:
>>>>
>> https://github.com/qemu/qemu/commit/50d38b8921837827ea397d4b20c8b
>> c
>>>> 5efe186e53
>>>>> 2. ASPEED SDK v09.05 pre-built image
>>>>>
>> https://github.com/AspeedTech-BMC/openbmc/releases/tag/v09.05
>>>>>       ast2700-default-obmc.tar.gz (AST2700 A1)
>>>>>
>>>>
>> https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.05/a
>> st
>>>> 2700-default-obmc.tar.gz
>>>>>       ast2700-a0-default-obmc.tar.gz (AST2700 A0)
>>>>>
>>>>
>> https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.05/a
>> st
>>>> 2700-a0-default-obmc.tar.gz
>>>>>
>>>>> This patch series depends on the following patch series:
>>>>>
>>>>
>> https://patchwork.kernel.org/project/qemu-devel/cover/20250304064710.21
>> 2
>>>> 8993-1-jamin_lin@aspeedtech.com/
>>>>>
>>>>
>> https://patchwork.kernel.org/project/qemu-devel/cover/20250225075622.30
>> 5
>>>> 515-1-jamin_lin@aspeedtech.com/
>>>>>
>>>>> Jamin Lin (29):
>>>>>      hw/intc/aspeed: Support setting different memory size
>>>>>      hw/intc/aspeed: Rename status_addr and addr to status_reg and
>> reg for
>>>>>        clarity
>>>>>      hw/intc/aspeed: Introduce dynamic allocation for regs array
>>>>>      hw/intc/aspeed: Support setting different register size
>>>>>      hw/intc/aspeed: Reduce regs array size by adding a register
>> sub-region
>>>>>      hw/intc/aspeed: Introduce helper functions for enable and status
>>>>>        registers
>>>>>      hw/intc/aspeed: Add object type name to trace events for better
>>>>>        debugging
>>>>>      hw/arm/aspeed: Rename IRQ table and machine name for AST2700
>> A0
>>>>>      hw/arm/aspeed_ast27x0: Sort the IRQ table by IRQ number
>>>>>      hw/intc/aspeed: Support different memory region ops
>>>>>      hw/intc/aspeed: Rename num_ints to num_inpins for clarity
>>>>>      hw/intc/aspeed: Add support for multiple output pins in INTC
>>>>>      hw/intc/aspeed: Refactor INTC to support separate input and output
>> pin
>>>>>        indices
>>>>>      hw/intc/aspeed: Introduce AspeedINTCIRQ structure to save the irq
>>>>>        index and register address
>>>>>      hw/intc/aspeed: Introduce IRQ handler function to reduce code
>>>>>        duplication
>>>>>      hw/intc/aspeed: Add Support for Multi-Output IRQ Handling
>>>>>      hw/intc/aspeed: Add Support for AST2700 INTCIO Controller
>>>>>      hw/misc/aspeed_scu: Add Support for AST2700/AST2750 A1 Silicon
>>>>>        Revisions
>>>>>      hw/arm/aspeed_ast27x0.c Support AST2700 A1 GIC Interrupt
>> Mapping
>>>>>      hw/arm/aspeed_ast27x0: Define an Array of AspeedINTCState with
>> Two
>>>>>        Instances
>>>>>      hw/arm/aspeed_ast27x0: Support two levels of INTC controllers for
>>>>>        AST2700 A1
>>>>>      hw/arm/aspeed_ast27x0: Add SoC Support for AST2700 A1
>>>>>      hw/arm/aspeed: Add Machine Support for AST2700 A1
>>>>>      hw/arm/aspeed_ast27x0: Sort the memmap table by mapping
>> address
>>>>>      tests/functional/aspeed: Introduce start_ast2700_test API
>>>>>      tests/functional/aspeed: Update temperature hwmon path
>>>>>      tests/functional/aspeed: Update test ASPEED SDK v09.05
>>>>>      tests/functional/aspeed: Add test case for AST2700 A1
>>>>>      docs/specs: Add aspeed-intc
>>>>>
>>>>>     docs/specs/aspeed-intc.rst              | 136 +++++
>>>>>     docs/specs/index.rst                    |   1 +
>>>>>     include/hw/arm/aspeed_soc.h             |   3 +-
>>>>>     include/hw/intc/aspeed_intc.h           |  36 +-
>>>>>     include/hw/misc/aspeed_scu.h            |   2 +
>>>>>     hw/arm/aspeed.c                         |  33 +-
>>>>>     hw/arm/aspeed_ast27x0.c                 | 329 ++++++++----
>>>>>     hw/intc/aspeed_intc.c                   | 667
>>>> ++++++++++++++++++------
>>>>>     hw/misc/aspeed_scu.c                    |   2 +
>>>>>     hw/intc/trace-events                    |  25 +-
>>>>>     tests/functional/test_aarch64_aspeed.py |  47 +-
>>>>>     11 files changed, 978 insertions(+), 303 deletions(-)
>>>>>     create mode 100644 docs/specs/aspeed-intc.rst
>>>>>
>>>>
>>>> Applied to aspeed-next.
>>>>
>>>
>>> I really appreciate your great help and support recently. Supporting
>>> AST2700 A1 is a significant milestone.
>>
>> yw.
>>
>> What about the "AST27x0 multi-SoC machine" series ?
>>
>> Thanks,
>>
>> C.
> 
> Hi Cedric,
> 
> I will submit AST27x0 multi-SoC machine v2 patch next week.
> V2 supports both A0 and A1 chips and depends on Jamin's AST2700 A1 patch.

Great ! Then, It is best that you wait for the aspeed-next branch to be
merged first. Should be next week.

Thanks,

C.


