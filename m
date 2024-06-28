Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A456FC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:52:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6PE-0002By-9f; Fri, 28 Jun 2024 03:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6PB-0002AY-83
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:52:26 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6P8-0007NO-P0
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:52:24 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SMS4ydKz4w2K;
 Fri, 28 Jun 2024 17:52:20 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SMR50FBz4wcS;
 Fri, 28 Jun 2024 17:52:19 +1000 (AEST)
Message-ID: <2f0f6d7d-9ca1-4aa5-b06d-65a820b4d67d@kaod.org>
Date: Fri, 28 Jun 2024 09:52:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 36/98] hw/sd/sdcard: Move sd_[a]cmd_name() methods to
 sd.c
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-37-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-37-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
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

On 6/28/24 9:01 AM, Philippe Mathieu-Daudé wrote:
> Merge sdmmc-internal.c into sd.c by moving
> sd_cmd_name() and sd_acmd_name() and updating
> meson.build.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sdmmc-internal.h | 26 ---------------
>   hw/sd/sd.c             | 62 ++++++++++++++++++++++++++++++++++++
>   hw/sd/sdmmc-internal.c | 72 ------------------------------------------
>   hw/sd/meson.build      |  2 +-
>   4 files changed, 63 insertions(+), 99 deletions(-)
>   delete mode 100644 hw/sd/sdmmc-internal.c
> 
> diff --git a/hw/sd/sdmmc-internal.h b/hw/sd/sdmmc-internal.h
> index 306ffa7f53..20d85aea6d 100644
> --- a/hw/sd/sdmmc-internal.h
> +++ b/hw/sd/sdmmc-internal.h
> @@ -108,30 +108,4 @@
>   #define EXT_CSD_PART_CONFIG_EN_BOOT0    (0x1 << 3)
>   #define EXT_CSD_PART_CONFIG_EN_USER     (0x7 << 3)
>   
> -#define SDMMC_CMD_MAX 64
> -
> -/**
> - * sd_cmd_name:
> - * @cmd: A SD "normal" command, up to SDMMC_CMD_MAX.
> - *
> - * Returns a human-readable name describing the command.
> - * The return value is always a static string which does not need
> - * to be freed after use.
> - *
> - * Returns: The command name of @cmd or "UNKNOWN_CMD".
> - */
> -const char *sd_cmd_name(uint8_t cmd);
> -
> -/**
> - * sd_acmd_name:
> - * @cmd: A SD "Application-Specific" command, up to SDMMC_CMD_MAX.
> - *
> - * Returns a human-readable name describing the application command.
> - * The return value is always a static string which does not need
> - * to be freed after use.
> - *
> - * Returns: The application command name of @cmd or "UNKNOWN_ACMD".
> - */
> -const char *sd_acmd_name(uint8_t cmd);
> -
>   #endif
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index f9708064d0..93a4a4e1b4 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -88,6 +88,8 @@ enum SDCardStates {
>       sd_disconnect_state     = 8,
>   };
>   
> +#define SDMMC_CMD_MAX 64
> +
>   typedef sd_rsp_type_t (*sd_cmd_handler)(SDState *sd, SDRequest req);
>   
>   typedef struct SDProto {
> @@ -231,6 +233,66 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
>       return response_name[rsp];
>   }
>   
> +static const char *sd_cmd_name(uint8_t cmd)
> +{
> +    static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
> +         [0]    = "GO_IDLE_STATE",           [1]    = "SEND_OP_COND",
> +         [2]    = "ALL_SEND_CID",            [3]    = "SEND_RELATIVE_ADDR",
> +         [4]    = "SET_DSR",                 [5]    = "IO_SEND_OP_COND",
> +         [6]    = "SWITCH_FUNC",             [7]    = "SELECT/DESELECT_CARD",
> +         [8]    = "SEND_IF_COND",            [9]    = "SEND_CSD",
> +        [10]    = "SEND_CID",               [11]    = "VOLTAGE_SWITCH",
> +        [12]    = "STOP_TRANSMISSION",      [13]    = "SEND_STATUS",
> +                                            [15]    = "GO_INACTIVE_STATE",
> +        [16]    = "SET_BLOCKLEN",           [17]    = "READ_SINGLE_BLOCK",
> +        [18]    = "READ_MULTIPLE_BLOCK",    [19]    = "SEND_TUNING_BLOCK",
> +        [20]    = "SPEED_CLASS_CONTROL",    [21]    = "DPS_spec",
> +                                            [23]    = "SET_BLOCK_COUNT",
> +        [24]    = "WRITE_BLOCK",            [25]    = "WRITE_MULTIPLE_BLOCK",
> +        [26]    = "MANUF_RSVD",             [27]    = "PROGRAM_CSD",
> +        [28]    = "SET_WRITE_PROT",         [29]    = "CLR_WRITE_PROT",
> +        [30]    = "SEND_WRITE_PROT",
> +        [32]    = "ERASE_WR_BLK_START",     [33]    = "ERASE_WR_BLK_END",
> +        [34]    = "SW_FUNC_RSVD",           [35]    = "SW_FUNC_RSVD",
> +        [36]    = "SW_FUNC_RSVD",           [37]    = "SW_FUNC_RSVD",
> +        [38]    = "ERASE",
> +        [40]    = "DPS_spec",
> +        [42]    = "LOCK_UNLOCK",            [43]    = "Q_MANAGEMENT",
> +        [44]    = "Q_TASK_INFO_A",          [45]    = "Q_TASK_INFO_B",
> +        [46]    = "Q_RD_TASK",              [47]    = "Q_WR_TASK",
> +        [48]    = "READ_EXTR_SINGLE",       [49]    = "WRITE_EXTR_SINGLE",
> +        [50]    = "SW_FUNC_RSVD",
> +        [52]    = "IO_RW_DIRECT",           [53]    = "IO_RW_EXTENDED",
> +        [54]    = "SDIO_RSVD",              [55]    = "APP_CMD",
> +        [56]    = "GEN_CMD",                [57]    = "SW_FUNC_RSVD",
> +        [58]    = "READ_EXTR_MULTI",        [59]    = "WRITE_EXTR_MULTI",
> +        [60]    = "MANUF_RSVD",             [61]    = "MANUF_RSVD",
> +        [62]    = "MANUF_RSVD",             [63]    = "MANUF_RSVD",
> +    };
> +    return cmd_abbrev[cmd] ? cmd_abbrev[cmd] : "UNKNOWN_CMD";
> +}
> +
> +static const char *sd_acmd_name(uint8_t cmd)
> +{
> +    static const char *acmd_abbrev[SDMMC_CMD_MAX] = {
> +         [6] = "SET_BUS_WIDTH",
> +        [13] = "SD_STATUS",
> +        [14] = "DPS_spec",                  [15] = "DPS_spec",
> +        [16] = "DPS_spec",
> +        [18] = "SECU_spec",
> +        [22] = "SEND_NUM_WR_BLOCKS",        [23] = "SET_WR_BLK_ERASE_COUNT",
> +        [41] = "SD_SEND_OP_COND",
> +        [42] = "SET_CLR_CARD_DETECT",
> +        [51] = "SEND_SCR",
> +        [52] = "SECU_spec",                 [53] = "SECU_spec",
> +        [54] = "SECU_spec",
> +        [56] = "SECU_spec",                 [57] = "SECU_spec",
> +        [58] = "SECU_spec",                 [59] = "SECU_spec",
> +    };
> +
> +    return acmd_abbrev[cmd] ? acmd_abbrev[cmd] : "UNKNOWN_ACMD";
> +}
> +
>   static uint8_t sd_get_dat_lines(SDState *sd)
>   {
>       return sd->enable ? sd->dat_lines : 0;
> diff --git a/hw/sd/sdmmc-internal.c b/hw/sd/sdmmc-internal.c
> deleted file mode 100644
> index c1d5508ae6..0000000000
> --- a/hw/sd/sdmmc-internal.c
> +++ /dev/null
> @@ -1,72 +0,0 @@
> -/*
> - * SD/MMC cards common helpers
> - *
> - * Copyright (c) 2018  Philippe Mathieu-Daudé <f4bug@amsat.org>
> - *
> - * This work is licensed under the terms of the GNU GPL, version 2 or later.
> - * See the COPYING file in the top-level directory.
> - * SPDX-License-Identifier: GPL-2.0-or-later
> - */
> -
> -#include "qemu/osdep.h"
> -#include "sdmmc-internal.h"
> -
> -const char *sd_cmd_name(uint8_t cmd)
> -{
> -    static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
> -         [0]    = "GO_IDLE_STATE",           [1]    = "SEND_OP_COND",
> -         [2]    = "ALL_SEND_CID",            [3]    = "SEND_RELATIVE_ADDR",
> -         [4]    = "SET_DSR",                 [5]    = "IO_SEND_OP_COND",
> -         [6]    = "SWITCH_FUNC",             [7]    = "SELECT/DESELECT_CARD",
> -         [8]    = "SEND_IF_COND",            [9]    = "SEND_CSD",
> -        [10]    = "SEND_CID",               [11]    = "VOLTAGE_SWITCH",
> -        [12]    = "STOP_TRANSMISSION",      [13]    = "SEND_STATUS",
> -                                            [15]    = "GO_INACTIVE_STATE",
> -        [16]    = "SET_BLOCKLEN",           [17]    = "READ_SINGLE_BLOCK",
> -        [18]    = "READ_MULTIPLE_BLOCK",    [19]    = "SEND_TUNING_BLOCK",
> -        [20]    = "SPEED_CLASS_CONTROL",    [21]    = "DPS_spec",
> -                                            [23]    = "SET_BLOCK_COUNT",
> -        [24]    = "WRITE_BLOCK",            [25]    = "WRITE_MULTIPLE_BLOCK",
> -        [26]    = "MANUF_RSVD",             [27]    = "PROGRAM_CSD",
> -        [28]    = "SET_WRITE_PROT",         [29]    = "CLR_WRITE_PROT",
> -        [30]    = "SEND_WRITE_PROT",
> -        [32]    = "ERASE_WR_BLK_START",     [33]    = "ERASE_WR_BLK_END",
> -        [34]    = "SW_FUNC_RSVD",           [35]    = "SW_FUNC_RSVD",
> -        [36]    = "SW_FUNC_RSVD",           [37]    = "SW_FUNC_RSVD",
> -        [38]    = "ERASE",
> -        [40]    = "DPS_spec",
> -        [42]    = "LOCK_UNLOCK",            [43]    = "Q_MANAGEMENT",
> -        [44]    = "Q_TASK_INFO_A",          [45]    = "Q_TASK_INFO_B",
> -        [46]    = "Q_RD_TASK",              [47]    = "Q_WR_TASK",
> -        [48]    = "READ_EXTR_SINGLE",       [49]    = "WRITE_EXTR_SINGLE",
> -        [50]    = "SW_FUNC_RSVD",
> -        [52]    = "IO_RW_DIRECT",           [53]    = "IO_RW_EXTENDED",
> -        [54]    = "SDIO_RSVD",              [55]    = "APP_CMD",
> -        [56]    = "GEN_CMD",                [57]    = "SW_FUNC_RSVD",
> -        [58]    = "READ_EXTR_MULTI",        [59]    = "WRITE_EXTR_MULTI",
> -        [60]    = "MANUF_RSVD",             [61]    = "MANUF_RSVD",
> -        [62]    = "MANUF_RSVD",             [63]    = "MANUF_RSVD",
> -    };
> -    return cmd_abbrev[cmd] ? cmd_abbrev[cmd] : "UNKNOWN_CMD";
> -}
> -
> -const char *sd_acmd_name(uint8_t cmd)
> -{
> -    static const char *acmd_abbrev[SDMMC_CMD_MAX] = {
> -         [6] = "SET_BUS_WIDTH",
> -        [13] = "SD_STATUS",
> -        [14] = "DPS_spec",                  [15] = "DPS_spec",
> -        [16] = "DPS_spec",
> -        [18] = "SECU_spec",
> -        [22] = "SEND_NUM_WR_BLOCKS",        [23] = "SET_WR_BLK_ERASE_COUNT",
> -        [41] = "SD_SEND_OP_COND",
> -        [42] = "SET_CLR_CARD_DETECT",
> -        [51] = "SEND_SCR",
> -        [52] = "SECU_spec",                 [53] = "SECU_spec",
> -        [54] = "SECU_spec",
> -        [56] = "SECU_spec",                 [57] = "SECU_spec",
> -        [58] = "SECU_spec",                 [59] = "SECU_spec",
> -    };
> -
> -    return acmd_abbrev[cmd] ? acmd_abbrev[cmd] : "UNKNOWN_ACMD";
> -}
> diff --git a/hw/sd/meson.build b/hw/sd/meson.build
> index abfac9e461..bbb75af0c9 100644
> --- a/hw/sd/meson.build
> +++ b/hw/sd/meson.build
> @@ -1,5 +1,5 @@
>   system_ss.add(when: 'CONFIG_PL181', if_true: files('pl181.c'))
> -system_ss.add(when: 'CONFIG_SD', if_true: files('sd.c', 'core.c', 'sdmmc-internal.c'))
> +system_ss.add(when: 'CONFIG_SD', if_true: files('sd.c', 'core.c'))
>   system_ss.add(when: 'CONFIG_SDHCI', if_true: files('sdhci.c'))
>   system_ss.add(when: 'CONFIG_SDHCI_PCI', if_true: files('sdhci-pci.c'))
>   system_ss.add(when: 'CONFIG_SSI_SD', if_true: files('ssi-sd.c'))


