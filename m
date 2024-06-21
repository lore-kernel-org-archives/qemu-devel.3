Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4219C2BB85
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 16:17:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKgwP-0004zY-DQ; Fri, 21 Jun 2024 12:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9ak7=NX=kaod.org=clg@ozlabs.org>)
 id 1sKgwN-0004z7-K2; Fri, 21 Jun 2024 12:16:43 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=9ak7=NX=kaod.org=clg@ozlabs.org>)
 id 1sKgwL-0002mw-SD; Fri, 21 Jun 2024 12:16:43 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W5Mtb0MSmz4wcq;
 Sat, 22 Jun 2024 02:16:39 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W5MtX5Bglz4wc5;
 Sat, 22 Jun 2024 02:16:36 +1000 (AEST)
Message-ID: <f158198d-f4c4-4d2c-9871-d580d38e69e8@kaod.org>
Date: Fri, 21 Jun 2024 18:16:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/23] hw/sd/sdcard: Fix typo in SEND_OP_COND command name
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
References: <20240621080554.18986-1-philmd@linaro.org>
 <20240621080554.18986-4-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240621080554.18986-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=9ak7=NX=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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

On 6/21/24 10:05 AM, Philippe Mathieu-Daudé wrote:
> There is no SEND_OP_CMD but SEND_OP_COND.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c             | 6 +++---
>   hw/sd/sdmmc-internal.c | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index addeb1940f..331cef5779 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1035,7 +1035,7 @@ static sd_rsp_type_t sd_cmd_GO_IDLE_STATE(SDState *sd, SDRequest req)
>       return sd_is_spi(sd) ? sd_r1 : sd_r0;
>   }
>   
> -static sd_rsp_type_t sd_cmd_SEND_OP_CMD(SDState *sd, SDRequest req)
> +static sd_rsp_type_t spi_cmd_SEND_OP_COND(SDState *sd, SDRequest req)
>   {
>       sd->state = sd_transfer_state;
>   
> @@ -2149,7 +2149,7 @@ static const SDProto sd_proto_spi = {
>       .name = "SPI",
>       .cmd = {
>           [0]         = sd_cmd_GO_IDLE_STATE,
> -        [1]         = sd_cmd_SEND_OP_CMD,
> +        [1]         = spi_cmd_SEND_OP_COND,
>           [2 ... 4]   = sd_cmd_illegal,
>           [5]         = sd_cmd_illegal,
>           [7]         = sd_cmd_illegal,
> @@ -2159,7 +2159,7 @@ static const SDProto sd_proto_spi = {
>       },
>       .acmd = {
>           [6]         = sd_cmd_unimplemented,
> -        [41]        = sd_cmd_SEND_OP_CMD,
> +        [41]        = spi_cmd_SEND_OP_COND,
>       },
>   };
>   
> diff --git a/hw/sd/sdmmc-internal.c b/hw/sd/sdmmc-internal.c
> index 8648a7808d..c1d5508ae6 100644
> --- a/hw/sd/sdmmc-internal.c
> +++ b/hw/sd/sdmmc-internal.c
> @@ -14,7 +14,7 @@
>   const char *sd_cmd_name(uint8_t cmd)
>   {
>       static const char *cmd_abbrev[SDMMC_CMD_MAX] = {
> -         [0]    = "GO_IDLE_STATE",           [1]    = "SEND_OP_CMD",
> +         [0]    = "GO_IDLE_STATE",           [1]    = "SEND_OP_COND",
>            [2]    = "ALL_SEND_CID",            [3]    = "SEND_RELATIVE_ADDR",
>            [4]    = "SET_DSR",                 [5]    = "IO_SEND_OP_COND",
>            [6]    = "SWITCH_FUNC",             [7]    = "SELECT/DESELECT_CARD",


