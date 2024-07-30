Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C40C3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 17:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYqhs-0004mx-O3; Tue, 30 Jul 2024 13:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=7GHu=O6=kaod.org=clg@ozlabs.org>)
 id 1sYqho-0004Zm-M4; Tue, 30 Jul 2024 13:32:12 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=7GHu=O6=kaod.org=clg@ozlabs.org>)
 id 1sYqhl-00082U-W3; Tue, 30 Jul 2024 13:32:12 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WYMjb5L0Gz4xTw;
 Wed, 31 Jul 2024 03:32:03 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WYMjX3FW2z4xKS;
 Wed, 31 Jul 2024 03:32:00 +1000 (AEST)
Message-ID: <a5d408eb-0a79-49da-902f-a5f79a74d733@kaod.org>
Date: Tue, 30 Jul 2024 19:31:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/6] hw/ppc: SPI model
To: Chalapathi V <chalapathi.v@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 calebs@linux.ibm.com, chalapathi.v@ibm.com, saif.abrar@linux.ibm.com,
 dantan@us.ibm.com, milesg@linux.ibm.com
References: <20240730172343.5818-1-chalapathi.v@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240730172343.5818-1-chalapathi.v@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=7GHu=O6=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

Hello Chalapathi

On 7/30/24 19:23, Chalapathi V wrote:
> Hello,
> 
> In patch v6 below issues detected during Coverity Scan were fixed.
> - CID 1558831:  Resource leaks  (RESOURCE_LEAK)
>    Variable "rsp_payload" going out of scope leaks the storage it points to.
> - CID 1558827:    (OVERRUN)
>    Overrunning array "s->seq_op" of 8 bytes at byte offset 16 using index
>    "get_seq_index(s) + 1" (which evaluates to 16).

You don't need to resend a v6 because the PowerNV SPI model is already
merged upstream :

  https://gitlab.com/qemu-project/qemu/-/commit/29318db133d0b2523bda771f76aa50c08842527f

What we would need now is a series of two patches on top of upstream
fixing the issues reported by coverity. Each patch should contain
a "Fixes: Coverity CID XYZxyz" tag.

Thanks,

C.




> The qom-tree looks like below.
> (qemu) info qom-tree
> /machine (powernv10-machine)
>    /chip[0] (power10_v2.0-pnv-chip)
>      /pib_spic[0] (pnv-spi)
>        /pnv-spi-bus.0 (SSI)
>        /xscom-spi[0] (memory-region)
>      /pib_spic[1] (pnv-spi)
>        /pnv-spi-bus.1 (SSI)
>        /xscom-spi[0] (memory-region)
>      /pib_spic[2] (pnv-spi)
>        /pnv-spi-bus.2 (SSI)
>        /xscom-spi[0] (memory-region)
>      /pib_spic[3] (pnv-spi)
>        /pnv-spi-bus.3 (SSI)
>        /xscom-spi[0] (memory-region)
>      /pib_spic[4] (pnv-spi)
>        /pnv-spi-bus.4 (SSI)
>        /xscom-spi[0] (memory-region)
>      /pib_spic[5] (pnv-spi)
>        /pnv-spi-bus.5 (SSI)
>        /xscom-spi[0] (memory-region)
> 
> (qemu) info qom-tree
> /machine (powernv10-machine)
>    /peripheral-anon (container)
>      /device[0] (25csm04)
>        /WP#[0] (irq)
>        /ssi-gpio-cs[0] (irq)
> 
> Patches overview in v6.
> PATCH1: Remove ppc target dependency from include/hw/ppc/pnv_xscom.h so
>          that pnv_xscom.h can be included in hw/ssi/pnv_spi.c in PATCH2.
> PATCH2: Create a PNV SPI model and implement configuration unit
>          to model SCOM registers.
> PATCH3: Extend PNV SPI model: implement sequencer FSM and shift engine.
> PATCH4: Add Microchip's SEEPROM 25csm04 model on top of m25p80.
> PATCH5: Connect SPI controllers to p10 chip and connect cs lines.
> PATCH6: Write a qtest pnv-spi-seeprom-test to check the SPI transactions
>          between spi controller and seeprom device.
> 
> Test covered:
> make check
> make check-avocado
> 
> Thank You,
> Chalapathi
> 
> Chalapathi V (6):
>    ppc/pnv: Remove ppc target dependency from pnv_xscom.h
>    hw/ssi: Add SPI model
>    hw/ssi: Extend SPI model
>    hw/block: Add Microchip's 25CSM04 to m25p80
>    hw/ppc: SPI controller wiring to P10 chip
>    tests/qtest: Add pnv-spi-seeprom qtest
> 
>   include/hw/ppc/pnv_chip.h          |    3 +
>   include/hw/ppc/pnv_xscom.h         |    5 +-
>   include/hw/ssi/pnv_spi.h           |   67 ++
>   include/hw/ssi/pnv_spi_regs.h      |  133 +++
>   hw/block/m25p80.c                  |    3 +
>   hw/ppc/pnv.c                       |   21 +-
>   hw/ssi/pnv_spi.c                   | 1269 ++++++++++++++++++++++++++++
>   tests/qtest/pnv-spi-seeprom-test.c |  110 +++
>   hw/ppc/Kconfig                     |    3 +
>   hw/ssi/Kconfig                     |    4 +
>   hw/ssi/meson.build                 |    1 +
>   hw/ssi/trace-events                |   21 +
>   tests/qtest/meson.build            |    1 +
>   13 files changed, 1639 insertions(+), 2 deletions(-)
>   create mode 100644 include/hw/ssi/pnv_spi.h
>   create mode 100644 include/hw/ssi/pnv_spi_regs.h
>   create mode 100644 hw/ssi/pnv_spi.c
>   create mode 100644 tests/qtest/pnv-spi-seeprom-test.c
> 


