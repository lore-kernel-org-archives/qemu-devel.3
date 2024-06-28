Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED38DC3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 08:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6a7-0006Jb-VZ; Fri, 28 Jun 2024 04:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6a6-0006Iv-Tz
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:03:42 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6a5-0005u4-1i
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:03:42 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9ScW0Tbkz4w2Q;
 Fri, 28 Jun 2024 18:03:39 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9ScV0X8Xz4wb7;
 Fri, 28 Jun 2024 18:03:37 +1000 (AEST)
Message-ID: <b1ab3349-efdb-41fd-aff5-441675987d0e@kaod.org>
Date: Fri, 28 Jun 2024 10:03:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 71/98] hw/sd/sdcard: Add
 sd_acmd_SET_WR_BLK_ERASE_COUNT handler (ACMD23)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-72-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-72-philmd@linaro.org>
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
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 9d66c3715a..cd207a3090 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -263,7 +263,6 @@ static const char *sd_acmd_name(SDState *sd, uint8_t cmd)
>           [14] = "DPS_spec",                  [15] = "DPS_spec",
>           [16] = "DPS_spec",
>           [18] = "SECU_spec",
> -                                            [23] = "SET_WR_BLK_ERASE_COUNT",
>           [42] = "SET_CLR_CARD_DETECT",
>           [51] = "SEND_SCR",
>           [52] = "SECU_spec",                 [53] = "SECU_spec",
> @@ -1696,6 +1695,15 @@ static sd_rsp_type_t sd_acmd_SEND_NUM_WR_BLOCKS(SDState *sd, SDRequest req)
>                                    &sd->blk_written, sizeof(sd->blk_written));
>   }
>   
> +/* ACMD23 */
> +static sd_rsp_type_t sd_acmd_SET_WR_BLK_ERASE_COUNT(SDState *sd, SDRequest req)
> +{
> +    if (sd->state != sd_transfer_state) {
> +        return sd_invalid_state_for_cmd(sd, req);
> +    }
> +    return sd_r1;
> +}
> +
>   static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>   {
>       uint64_t addr;
> @@ -1804,16 +1812,6 @@ static sd_rsp_type_t sd_app_command(SDState *sd,
>       }
>   
>       switch (req.cmd) {
> -    case 23:  /* ACMD23: SET_WR_BLK_ERASE_COUNT */
> -        switch (sd->state) {
> -        case sd_transfer_state:
> -            return sd_r1;
> -
> -        default:
> -            break;
> -        }
> -        break;
> -
>       case 41:  /* ACMD41: SD_APP_OP_COND */
>           if (sd->state != sd_idle_state) {
>               break;
> @@ -2320,6 +2318,7 @@ static const SDProto sd_proto_spi = {
>       .acmd = {
>           [13] = {8,  sd_spi, "SD_STATUS", sd_acmd_SD_STATUS},
>           [22] = {8,  sd_spi, "SEND_NUM_WR_BLOCKS", sd_acmd_SEND_NUM_WR_BLOCKS},
> +        [23] = {8,  sd_spi, "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
>           [41] = {8,  sd_spi, "SEND_OP_COND", spi_cmd_SEND_OP_COND},
>       },
>   };
> @@ -2379,6 +2378,7 @@ static const SDProto sd_proto_sd = {
>           [6]  = {8,  sd_ac,   "SET_BUS_WIDTH", sd_acmd_SET_BUS_WIDTH},
>           [13] = {8,  sd_adtc, "SD_STATUS", sd_acmd_SD_STATUS},
>           [22] = {8,  sd_adtc, "SEND_NUM_WR_BLOCKS", sd_acmd_SEND_NUM_WR_BLOCKS},
> +        [23] = {8,  sd_ac,   "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
>       },
>   };
>   


