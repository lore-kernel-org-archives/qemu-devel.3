Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A82A7C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN61F-0003Qi-0Z; Fri, 28 Jun 2024 03:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN61C-0003Ph-SP
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:27:39 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN61A-0006oK-AK
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:27:38 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9Rpq1vHTz4w2N;
 Fri, 28 Jun 2024 17:27:31 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9Rpn3qTMz4w2K;
 Fri, 28 Jun 2024 17:27:29 +1000 (AEST)
Message-ID: <35ffa9c7-a553-41b9-acbd-e4c833b6b2dd@kaod.org>
Date: Fri, 28 Jun 2024 09:27:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 00/98] hw/sd/sdcard: Add eMMC support
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Jamin Lin <jamin_lin@aspeedtech.com>,
 Troy Lee <troy_lee@aspeedtech.com>
References: <20240628070216.92609-1-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=GU6n=N6=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
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

On 6/28/24 9:00 AM, Philippe Mathieu-Daudé wrote:
> Cédric asked for one big series to review instead of
> various tiny ones...

Thanks for all this work !

> I plan to send a pull request before v9.1 soft freeze
> with at least patches 1-81 (prerequisistes before the
> "Basis for eMMC support" patch) except qtest patch #15.

I will scheme through the series for obvious flaws.

Unfortunately, I can not review for 82-98 adding the eMMC part, we will
need someone else for that. Adding Aspeed engineers.

Anyhow,

   Tested-by: Cédric Le Goater <clg@redhat.com>

> Also available as:
> https://gitlab.com/philmd/qemu/-/commits/emmc-testing/
Thanks,

C.

> 
> Cédric Le Goater (5):
>    hw/sd/sdcard: Introduce definitions for EXT_CSD register
>    hw/sd/sdcard: Add emmc_cmd_SET_RELATIVE_ADDR() handler
>    hw/sd/sdcard: Fix SET_BLOCK_COUNT command argument on eMMC (CMD23)
>    hw/sd/sdcard: Adapt sd_cmd_ALL_SEND_CID handler for eMMC (CMD2)
>    hw/sd/sdcard: Adapt sd_cmd_APP_CMD handler for eMMC (CMD55)
> 
> Joel Stanley (3):
>    hw/sd/sdcard: Support boot area in emmc image
>    hw/sd/sdcard: Subtract bootarea size from blk
>    hw/sd/sdcard: Add boot config support
> 
> Luc Michel (1):
>    hw/sd/sdcard: Implement eMMC sleep state (CMD5)
> 
> Philippe Mathieu-Daudé (85):
>    hw/sd/sdcard: Deprecate support for spec v1.10
>    hw/sd/sdcard: Use spec v3.01 by default
>    hw/sd/sdcard: Track last command used to help logging
>    hw/sd/sdcard: Trace block offset in READ/WRITE data accesses
>    hw/sd/sdcard: Trace requested address computed by sd_req_get_address()
>    hw/sd/sdcard: Do not store vendor data on block drive (CMD56)
>    hw/sd/sdcard: Send WRITE_PROT bits MSB first (CMD30)
>    hw/sd/sdcard: Send NUM_WR_BLOCKS bits MSB first (ACMD22)
>    hw/sd/sdcard: Use READY_FOR_DATA definition instead of magic value
>    hw/sd/sdcard: Assign SDCardStates enum values
>    hw/sd/sdcard: Simplify sd_inactive_state handling
>    hw/sd/sdcard: Restrict SWITCH_FUNCTION to sd_transfer_state (CMD6)
>    hw/sd/sdcard: Add direct reference to SDProto in SDState
>    hw/sd/sdcard: Extract sd_blk_len() helper
>    tests/qtest: Disable npcm7xx_sdhci tests using hardcoded RCA
>    hw/sd/sdcard: Generate random RCA value
>    hw/sd/sdcard: Introduce sd_cmd_to_sendingdata and sd_generic_read_byte
>    hw/sd/sdcard: Convert SWITCH_FUNCTION to generic_read_byte (CMD6)
>    hw/sd/sdcard: Convert SEND_CSD/SEND_CID to generic_read_byte (CMD9 &
>      10)
>    hw/sd/sdcard: Duplicate READ_SINGLE_BLOCK / READ_MULTIPLE_BLOCK cases
>    hw/sd/sdcard: Convert READ_SINGLE_BLOCK to generic_read_byte (CMD17)
>    hw/sd/sdcard: Convert SEND_TUNING_BLOCK to generic_read_byte (CMD19)
>    hw/sd/sdcard: Convert SEND_WRITE_PROT to generic_read_byte (CMD30)
>    hw/sd/sdcard: Convert GEN_CMD to generic_read_byte (CMD56)
>    hw/sd/sdcard: Convert SD_STATUS to generic_read_byte (ACMD13)
>    hw/sd/sdcard: Convert SEND_NUM_WR_BLOCKS to generic_read_byte (ACMD22)
>    hw/sd/sdcard: Convert SEND_SCR to generic_read_byte (ACMD51)
>    hw/sd/sdcard: Introduce sd_cmd_to_receivingdata /
>      sd_generic_write_byte
>    hw/sd/sdcard: Duplicate WRITE_SINGLE_BLOCK / WRITE_MULTIPLE_BLOCK
>      cases
>    hw/sd/sdcard: Convert WRITE_SINGLE_BLOCK to generic_write_byte (CMD24)
>    hw/sd/sdcard: Convert PROGRAM_CID to generic_write_byte (CMD26)
>    hw/sd/sdcard: Convert PROGRAM_CSD to generic_write_byte (CMD27)
>    hw/sd/sdcard: Convert LOCK_UNLOCK to generic_write_byte (CMD42)
>    hw/sd/sdcard: Convert GEN_CMD to generic_write_byte (CMD56)
>    hw/sd/sdcard: Move sd_[a]cmd_name() methods to sd.c
>    hw/sd/sdcard: Pass SDState as argument to sd_[a]cmd_name()
>    hw/sd/sdcard: Prepare SDProto to contain more fields
>    hw/sd/sdcard: Store command name in SDProto
>    hw/sd/sdcard: Store command type in SDProto
>    hw/sd/sdcard: Store command class in SDProto
>    hw/sd/sdcard: Remove SEND_DSR dead case (CMD4)
>    hw/sd/sdcard: Register generic optional handlers (CMD11 and CMD20)
>    hw/sd/sdcard: Register optional handlers from spec v6.00
>    hw/sd/sdcard: Register SDIO optional handlers
>    hw/sd/sdcard: Register Security Extension optional handlers
>    hw/sd/sdcard: Add sd_cmd_SWITCH_FUNCTION handler (CMD6)
>    hw/sd/sdcard: Add sd_cmd_DE/SELECT_CARD handler (CMD7)
>    hw/sd/sdcard: Add sd_cmd_SEND_IF_COND handler (CMD8)
>    hw/sd/sdcard: Add sd_cmd_SEND_CSD/CID handlers (CMD9 & CMD10)
>    hw/sd/sdcard: Add spi_cmd_SEND_CSD/CID handlers (CMD9 & CMD10)
>    hw/sd/sdcard: Add sd_cmd_STOP_TRANSMISSION handler (CMD12)
>    hw/sd/sdcard: Add sd_cmd_SEND_STATUS handler (CMD13)
>    hw/sd/sdcard: Add sd_cmd_GO_INACTIVE_STATE handler (CMD15)
>    hw/sd/sdcard: Add sd_cmd_SET_BLOCKLEN handler (CMD16)
>    hw/sd/sdcard: Add sd_cmd_READ_SINGLE_BLOCK handler (CMD17)
>    hw/sd/sdcard: Add sd_cmd_WRITE_SINGLE_BLOCK handler (CMD24)
>    hw/sd/sdcard: Add sd_cmd_PROGRAM_CSD handler (CMD27)
>    hw/sd/sdcard: Add sd_cmd_SET/CLR_WRITE_PROT handler (CMD28 & CMD29)
>    hw/sd/sdcard: Add sd_cmd_SEND_WRITE_PROT handler (CMD30)
>    hw/sd/sdcard: Add sd_cmd_ERASE_WR_BLK_START/END handlers (CMD32 &
>      CMD33)
>    hw/sd/sdcard: Add sd_cmd_ERASE handler (CMD38)
>    hw/sd/sdcard: Add sd_cmd_LOCK_UNLOCK handler (CMD42)
>    hw/sd/sdcard: Add sd_cmd_APP_CMD handler (CMD55)
>    hw/sd/sdcard: Add sd_cmd_GEN_CMD handler (CMD56)
>    hw/sd/sdcard: Add spi_cmd_READ_OCR handler (CMD58)
>    hw/sd/sdcard: Add spi_cmd_CRC_ON_OFF handler (CMD59)
>    hw/sd/sdcard: Add sd_acmd_SET_BUS_WIDTH handler (ACMD6)
>    hw/sd/sdcard: Add sd_acmd_SD_STATUS handler (ACMD13)
>    hw/sd/sdcard: Add sd_acmd_SEND_NUM_WR_BLOCKS handler (ACMD22)
>    hw/sd/sdcard: Add sd_acmd_SET_WR_BLK_ERASE_COUNT handler (ACMD23)
>    hw/sd/sdcard: Add sd_acmd_SD_APP_OP_COND handler (ACMD41)
>    hw/sd/sdcard: Add sd_acmd_SET_CLR_CARD_DETECT handler (ACMD42)
>    hw/sd/sdcard: Add sd_acmd_SEND_SCR handler (ACMD51)
>    hw/sd/sdcard: Remove sd_none enum from sd_cmd_type_t
>    hw/sd/sdcard: Remove noise from sd_acmd_name()
>    hw/sd/sdcard: Remove noise from sd_cmd_name()
>    hw/sd/sdcard: Remove default case in read/write on DAT lines
>    hw/sd/sdcard: Trace length of data read on DAT lines
>    hw/sd/sdcard: Introduce set_csd/set_cid handlers
>    hw/sd/sdcard: Cover more SDCardStates
>    hw/sd/sdcard: Basis for eMMC support
>    hw/sd/sdcard: Register generic command handlers
>    hw/sd/sdcard: Register unimplemented command handlers
>    hw/sd/sdcard: Add mmc_cmd_PROGRAM_CID handler (CMD26)
>    hw/sd/sdcard: Add experimental 'x-aspeed-emmc-kludge' property
> 
> Sai Pavan Boddu (3):
>    hw/sd/sdcard: Add emmc_cmd_SEND_OP_COND handler (CMD1)
>    hw/sd/sdcard: add emmc_cmd_SEND_TUNING_BLOCK handler (CMD21)
>    hw/sd/sdcard: Add mmc SWITCH function support (CMD6)
> 
> Vincent Palatin (1):
>    hw/sd/sdcard: Add emmc_cmd_SEND_EXT_CSD handler (CMD8)
> 
>   docs/about/deprecated.rst        |    6 +
>   hw/sd/sdmmc-internal.h           |  118 +-
>   include/hw/sd/sd.h               |   10 +-
>   hw/sd/sd.c                       | 1917 +++++++++++++++++++-----------
>   hw/sd/sdmmc-internal.c           |   72 --
>   tests/qtest/npcm7xx_sdhci-test.c |    7 +
>   hw/sd/meson.build                |    2 +-
>   hw/sd/trace-events               |    6 +-
>   8 files changed, 1362 insertions(+), 776 deletions(-)
>   delete mode 100644 hw/sd/sdmmc-internal.c
> 


