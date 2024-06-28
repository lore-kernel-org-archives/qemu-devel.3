Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BADEC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 07:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6TO-0000a0-26; Fri, 28 Jun 2024 03:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6TL-0000WO-Ty
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:56:43 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6TJ-0002Ys-Sa
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:56:43 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SSR3TCgz4wb7;
 Fri, 28 Jun 2024 17:56:39 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SSQ2X2cz4w2K;
 Fri, 28 Jun 2024 17:56:38 +1000 (AEST)
Message-ID: <b002d2f4-5b69-4dfc-8168-03a89f03d39c@kaod.org>
Date: Fri, 28 Jun 2024 09:56:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 45/98] hw/sd/sdcard: Register SDIO optional handlers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-46-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-46-philmd@linaro.org>
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

On 6/28/24 9:01 AM, Philippe Mathieu-Daudé wrote:
> See "SD Input/Output Card Specification" v1.00.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 406fadb3b4..87bfd0fd56 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -240,7 +240,6 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
>   static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
>   {
>       static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
> -                                             [5]    = "IO_SEND_OP_COND",
>            [6]    = "SWITCH_FUNC",             [7]    = "SELECT/DESELECT_CARD",
>            [8]    = "SEND_IF_COND",            [9]    = "SEND_CSD",
>           [10]    = "SEND_CID",
> @@ -260,7 +259,6 @@ static const char *sd_cmd_name(SDState *sd, uint8_t cmd)
>           [40]    = "DPS_spec",
>           [42]    = "LOCK_UNLOCK",
>           [50]    = "SW_FUNC_RSVD",
> -        [52]    = "IO_RW_DIRECT",           [53]    = "IO_RW_EXTENDED",
>           [54]    = "SDIO_RSVD",              [55]    = "APP_CMD",
>           [56]    = "GEN_CMD",                [57]    = "SW_FUNC_RSVD",
>           [60]    = "MANUF_RSVD",             [61]    = "MANUF_RSVD",
> @@ -2270,6 +2268,9 @@ static const SDProto sd_proto_spi = {
>       .cmd = {
>           [0]  = {0,  sd_spi, "GO_IDLE_STATE", sd_cmd_GO_IDLE_STATE},
>           [1]  = {0,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
> +        [5]  = {9,  sd_spi, "IO_SEND_OP_COND", sd_cmd_optional},
> +        [52] = {9,  sd_spi, "IO_RW_DIRECT", sd_cmd_optional},
> +        [53] = {9,  sd_spi, "IO_RW_EXTENDED", sd_cmd_optional},
>       },
>       .acmd = {
>           [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
> @@ -2283,6 +2284,7 @@ static const SDProto sd_proto_sd = {
>           [2]  = {0,  sd_bcr,  "ALL_SEND_CID", sd_cmd_ALL_SEND_CID},
>           [3]  = {0,  sd_bcr,  "SEND_RELATIVE_ADDR", sd_cmd_SEND_RELATIVE_ADDR},
>           [4]  = {0,  sd_bc,   "SEND_DSR", sd_cmd_unimplemented},
> +        [5]  = {9,  sd_bc,   "IO_SEND_OP_COND", sd_cmd_optional},
>           [11] = {0,  sd_ac,   "VOLTAGE_SWITCH", sd_cmd_optional},
>           [19] = {2,  sd_adtc, "SEND_TUNING_BLOCK", sd_cmd_SEND_TUNING_BLOCK},
>           [20] = {2,  sd_ac,   "SPEED_CLASS_CONTROL", sd_cmd_optional},
> @@ -2294,6 +2296,8 @@ static const SDProto sd_proto_sd = {
>           [47] = {1,  sd_adtc, "Q_WR_TASK", sd_cmd_optional},
>           [48] = {1,  sd_adtc, "READ_EXTR_SINGLE", sd_cmd_optional},
>           [49] = {1,  sd_adtc, "WRITE_EXTR_SINGLE", sd_cmd_optional},
> +        [52] = {9,  sd_bc,   "IO_RW_DIRECT", sd_cmd_optional},
> +        [53] = {9,  sd_bc,   "IO_RW_EXTENDED", sd_cmd_optional},
>           [58] = {11, sd_adtc, "READ_EXTR_MULTI", sd_cmd_optional},
>           [59] = {11, sd_adtc, "WRITE_EXTR_MULTI", sd_cmd_optional},
>       },


